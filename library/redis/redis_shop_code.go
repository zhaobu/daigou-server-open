package redis

import (
	"context"
	"crypto/rand"
	"daigou/library/public"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/go-redis/redis/v8"
	jsoniter "github.com/json-iterator/go"
)

//店铺码用于买家用来申请店铺

var (
	shopCodeValidTime int32 = 300                                            //有效期(s)
	shopCodeSize      int32 = 6                                              //位数
	strSet                  = []byte("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ") //字符集
	shopCodeSetSize   int   = 200                                            //set集合容量
)

type GenShopCodeIn struct {
	ShopID      uint64              `json:"shop_id"`       //生成该店铺码的店铺id
	GenType     public.ShopCodeType `json:"gen_type"`      //生成类型
	OldShopCode string              `json:"old_shop_code"` //之前生成的店铺码
}

type GenShopCodeOut struct {
	ShopCode  string              `json:"shop_code"`  //店铺码
	ValidTime int32               `json:"valid_time"` //剩余有效时间(单位秒)
	GenType   public.ShopCodeType `json:"gen_type"`   //生成类型
	ShopID    uint64              `json:"shop_id"`    //生成该店铺码的店铺id
}

type shopCodeInfo struct {
	ShopID  uint64              `json:"shop_id"`  //生成该店铺码的店铺id
	GenType public.ShopCodeType `json:"gen_type"` //生成类型
	GenTime time.Time           `json:"gen_time"` //生成时间
}

//生成店铺码
func GenShopCode(_args *GenShopCodeIn) (out *GenShopCodeOut, err error) {
	if _args.OldShopCode != "" {
		out1, _, _ := CheckShopCode(_args.OldShopCode, false)
		if out1 != nil && out1.Code == 0 {
			//计算剩余有效期
			validtime := shopCodeValidTime - int32(time.Now().Sub(out1.GenTime).Seconds())
			return &GenShopCodeOut{ShopCode: _args.OldShopCode, ValidTime: validtime, GenType: _args.GenType, ShopID: out1.ShopID}, nil
		}
	}
	//重新生成新的店铺码
	conn := cache.Conn(context.Background())
	defer conn.Close()

	info, err := jsoniter.Marshal(&shopCodeInfo{ShopID: _args.ShopID, GenType: _args.GenType, GenTime: time.Now()})
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return nil, err
	}
	shopCode := popShopCode(conn)

	//写入到redis
	err = conn.Set(context.Background(), fmt.Sprintf(Cache_Str_Shop_Code, shopCode), info, time.Second*time.Duration(shopCodeValidTime)).Err()
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return nil, err
	}

	zaplog.Debugf("GenShopCode success,shopcode:%s", shopCode)
	out = &GenShopCodeOut{ShopCode: shopCode, ValidTime: shopCodeValidTime, GenType: _args.GenType, ShopID: _args.ShopID}
	return
}

type GetShopCodeInfoOut struct {
	Code int32 `json:"code"` //错误码(0:获取成功 1:店铺码无效)
	*shopCodeInfo
}

//检查店铺码是否有效
func CheckShopCode(_arg string, _del bool) (out *GetShopCodeInfoOut, msg string, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	res, err := conn.Get(context.Background(), fmt.Sprintf(Cache_Str_Shop_Code, _arg)).Result()
	out = &GetShopCodeInfoOut{}
	if res == "" {
		out.Code = 1
		return out, "店铺码无效", nil
	}
	err = jsoniter.Unmarshal([]byte(res), &out.shopCodeInfo)
	if err != nil {
		zaplog.Errorf("UseShopCode err=%s", err)
		out.Code = 1
		return out, "店铺码无效", nil
	}
	if _del {
		//删除该店铺码
		_, err = conn.Del(context.Background(), fmt.Sprintf(Cache_Str_Shop_Code, _arg)).Result()
		if res != "" {
			zaplog.Errorf("UseShopCode err=%s", err)
		}
	}
	return
}

//更新set中的shopcode
func UpdateShopCode() (err error) {
	if !isEnable {
		return
	}
	conn := cache.Conn(context.Background())
	defer conn.Close()
	size, err := conn.SCard(context.Background(), Cache_Set_Shop_Code).Result()
	if err != nil {
		zaplog.Errorf("UpdateShopCode err:%s", err)
		return err
	}
	if int(size) > shopCodeSetSize/2 {
		return
	}
	//集合不足一半时就添加
	for i := 0; i < shopCodeSetSize-int(size); i++ {
		num, err1 := conn.SAdd(context.Background(), Cache_Set_Shop_Code, genShopCode(shopCodeSize)).Result()
		if err1 != nil {
			zaplog.Errorf("UpdateShopCode err:%s", err1)
			return err1
		}
		if num != 1 {
			i--
		}
	}
	return
}

func popShopCode(conn *redis.Conn) string {
	//首先判断集合有没有
	res, err := conn.SPop(context.Background(), Cache_Set_Shop_Code).Result()
	if err != nil {
		zaplog.Errorf("popShopCode err:%s", err)
	}
	if res != "" {
		return res
	}
	return genShopCode(shopCodeSize)
}

func genShopCode(size int32) string {
	data := make([]byte, size)
	out := make([]byte, size)
	buffer := len(strSet)
	n, err := rand.Read(data)
	if err != nil {
		zaplog.Errorf("genShopCode n:%d,err:%s", n, err)
	}
	for id, key := range data {
		x := byte(int(key) % buffer)
		out[id] = strSet[x]
	}
	return string(out)
}
