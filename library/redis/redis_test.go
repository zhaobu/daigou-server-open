package redis

import (
	"context"
	"daigou/library/conf"
	"daigou/library/public"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"fmt"
	"testing"
	"time"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/grand"
	jsoniter "github.com/json-iterator/go"
)

func init() {
	zaplog.InitLog(&zaplog.Config{
		Logdir:   "./",
		LogName:  "go_test.log",
		Loglevel: "debug",
		Debug:    true,
	})
	conf.InitConfig("../../bin/config/config1.toml")
	conf.InitConnect()
	InitRedis()
}

func Test_GetGoodsCategory(t *testing.T) {
	info, err := GetGoodsCategory()
	if err != nil {
		zaplog.Infof("err=%s", err)
		return
	}
	g.Dump(info)
}

func Test_RedisSendSmsCode(t *testing.T) {
	out, msg, err := RedisSendSmsCode(&RedisSendSmsCodeIn{PhoneNumber: "17620372006"})
	zaplog.Infof("out=%v,msg=%s,err=%s", out, msg, err)
}

func Test_AddCache_Hash_Sms_Code(t *testing.T) {
	conn := cache.Conn(context.Background())
	defer conn.Close()

	info, err := jsoniter.MarshalToString(&sendSmsCode{Code: "12345", SendTime: time.Now()})
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return
	}
	//写入到redis
	for i := 0; i < 100; i++ {
		reply, err := conn.HSet(context.Background(), string(Cache_Hash_Sms_Code), gconv.String(17620372000+i), info).Result()
		if err != nil {
			zaplog.Errorf("RedisSendSmsCode err=%s", err)
			return
		}
		zaplog.Infof("reply=%+v", reply)
	}
}

func Test_Hscan1(t *testing.T) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	//序列化
	var info string
	for i := 0; i < 100; i++ {
		time1, err := time.ParseDuration(fmt.Sprintf("-%ds", grand.Intn(60)))
		info, err = jsoniter.MarshalToString(&sendSmsCode{Code: grand.Digits(6), SendTime: time.Now().Add(time1)})
		if err != nil {
			zaplog.Errorf("err=%s", err)
			return
		}
		//写入到redis
		err = conn.HSet(context.Background(), Cache_Hash_Sms_Code, fmt.Sprintf("%d", 17620142000+i), info).Err()
		if err != nil {
			zaplog.Errorf("err=%s", err)
			return
		}
		zaplog.Infof("Cache_Hash_Sms_Code=%s", info)
	}
}

func Test_GredisHscan(t *testing.T) {
	conn := g.Redis("cache")
	defer conn.Close()

	//写入到redis
	times := 0
	cursor := 0
	count := 0

	for {
		times++
		reply, err := conn.DoVar("HSCAN", string(Cache_Hash_Sms_Code), cursor, "match", "*", "count", 3)
		if err != nil {
			zaplog.Errorf("RedisSendSmsCode err=%s", err)
			return
		}
		data := reply.Array()
		cursor = gconv.Int(gconv.String(data[0]))

		zaplog.Infof("cursor=%d,times=%d", cursor, times)

		if times == 30 {
			break
		}
		var (
			lastField string
		)

		//处理拿到的结果
		for k, v := range gconv.SliceAny(data[1]) {
			//反序列化
			if k&1 == 0 { //偶数时为filed
				lastField = gconv.String(v)
				zaplog.Debugf("filed=%s", lastField)
			} else {
				var info *sendSmsCode
				err := jsoniter.Unmarshal(gconv.Bytes(v), &info)
				if err != nil {
					zaplog.Errorf("RedisSendSmsCode err=%s", err)
					return
				}
				zaplog.Debugf("info=%v", info)
				if gconv.Int(lastField)&1 == 0 { //如果是偶数就删除
					_, err = conn.DoVar("HDEL", string(Cache_Hash_Sms_Code), lastField)
					if err != nil {
						zaplog.Errorf("RedisSendSmsCode err=%s", err)
						return
					}
					zaplog.Infof("第%d次删除了%s", count, lastField)
					count++
				}
			}
		}

		if cursor == 0 {
			zaplog.Debugf("over")
			return
		}
	}
}

func Test_ExchangeRate(t *testing.T) {
	out, err := GetCurrencies()
	zaplog.Infof("out=%s,err=%s", utils.Dump(out), err)

	out1, err1 := GetExchangeRate(&GetExchangeRateIn{From: "EUR", To: "CNY"})
	zaplog.Infof("out1=%s,err1=%s", utils.Dump(out1), err1)
}

func Test_genField(t *testing.T) {
	zaplog.Infof("res1=%s", genField(&GetExchangeRateIn{From: "hello", To: "lw"}))
	zaplog.Infof("res2=%s", genField(&GetExchangeRateIn{From: "lw", To: "hello"}))
}

func Test_GenShopCode(t *testing.T) {
	res, err := GenShopCode(&GenShopCodeIn{GenType: public.ShopCodeType_Shop, ShopID: 1000001, OldShopCode: ""})
	// res, err := GenShopCode(&GenShopCodeIn{GenType: public.ShopCodeType_System, ShopID: 0, OldShopCode: ""})
	if err != nil {
		zaplog.Errorf("Test_GenShopCode err=%s", err)
		return
	}
	zaplog.Infof("res=%s", utils.Dump(res))
}
