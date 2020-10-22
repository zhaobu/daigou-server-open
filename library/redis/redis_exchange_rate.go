package redis

import (
	"context"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"time"

	jsoniter "github.com/json-iterator/go"
)

//----------------------------------
// 汇率调用示例代码 － 聚合数据
// 在线接口文档：http://www.juhe.cn/docs/80
//----------------------------------

const (
	appkey             = "8858d42b12f2ed5370d3bb1c2cdc368f" //您申请的appkey
	exchangeRateExpire = time.Hour * 2
)

type RedisGetCurrenciesOut struct {
	Code string `json:"code"`
	Name string `json:"name"`
}

//2.货币列表
func GetCurrencies() (out []*RedisGetCurrenciesOut, err error) {
	//优先从redis中获取
	conn := cache.Conn(context.Background())
	defer conn.Close()
	res, err := conn.Get(context.Background(), Cache_Str_Get_Currencies).Result()
	if res != "" {
		err = jsoniter.Unmarshal([]byte(res), &out)
		if err != nil {
			zaplog.Errorf("GetCurrencies err=%s", err)
		}
		return out, err
	}

	//调用接口并保存到redis
	res1, err := apiGetCurrencies()
	if err != nil {
		zaplog.Errorf("GetCurrencies err=%s", err)
		return out, err
	}

	jsonStr, err := jsoniter.Marshal(res1.Result.List)
	if err != nil {
		zaplog.Errorf("GetCurrencies err=%s", err)
		return out, err
	}

	_, err = conn.Set(context.Background(), Cache_Str_Get_Currencies, jsonStr, time.Hour*24).Result()
	if err != nil {
		zaplog.Errorf("GetCurrencies err=%s", err)
		return out, err
	}
	return res1.Result.List, nil
}

type getExchangeRateRedis1 struct {
	CurrencyF     string `json:"currencyF"`      //货币代码
	CurrencyFName string `json:"currencyF_Name"` //货币名称
	CurrencyT     string `json:"currencyT"`      //货币代码
	CurrencyTName string `json:"currencyT_Name"` //货币名称
	CurrencyFD    string `json:"currencyFD"`
	Exchange      string `json:"exchange"` //当前汇率
	Result        string `json:"result"`   //当前汇率
	UpdateTime    string `json:"updateTime"`
}

type GetExchangeRateOut struct {
	CurrencyF  string `json:"currencyF"`  //持有货币
	CurrencyT  string `json:"currencyT"`  //转换货币
	Exchange   string `json:"exchange"`   //当前汇率
	UpdateTime string `json:"updateTime"` //汇率更新时间
}

type GetExchangeRateIn struct {
	From string `json:"from"` //转换汇率前的货币代码
	To   string `json:"to"`   //转换汇率成的货币代码
}

type getExchangeRateRedis struct {
	GetTime time.Time                `json:"get_time"` //获取该结果的时间
	Result  []*getExchangeRateRedis1 `json:"result"`   //汇率查询结果
}

func genField(_args *GetExchangeRateIn) string {
	if _args.From > _args.To {
		return _args.To + "_" + _args.From
	} else {
		return _args.From + "_" + _args.To
	}
}

func getExchangeRateOut(_args1 *GetExchangeRateIn, _args2 []*getExchangeRateRedis1) (out *GetExchangeRateOut) {
	for _, v := range _args2 {
		if v.CurrencyF == _args1.From && v.CurrencyT == _args1.To {
			out = &GetExchangeRateOut{
				CurrencyF:  v.CurrencyF,
				CurrencyT:  v.CurrencyT,
				Exchange:   v.Exchange,
				UpdateTime: v.UpdateTime,
			}
			break
		}
	}
	return
}

//3.汇率查询换算
func GetExchangeRate(_args *GetExchangeRateIn) (out *GetExchangeRateOut, err error) {
	//优先从redis中获取
	conn := cache.Conn(context.Background())
	defer conn.Close()
	res, err := conn.HGet(context.Background(), Cache_Hash_Get_ExchangeRate, genField(_args)).Result()
	if res != "" {
		var resRedis *getExchangeRateRedis
		err = jsoniter.Unmarshal([]byte(res), &resRedis)
		if err != nil {
			zaplog.Errorf("GetExchangeRate err=%s", err)
			return
		}
		if time.Now().Sub(resRedis.GetTime) < exchangeRateExpire { //在有效期内不用重新请求
			return getExchangeRateOut(_args, resRedis.Result), nil
		}
	}

	//调用接口并保存到redis
	res1, err := apiGetExchangeRate(_args.From, _args.To)
	if err != nil {
		zaplog.Errorf("GetExchangeRate err=%s", err)
		return out, err
	}

	jsonStr, err := jsoniter.Marshal(&getExchangeRateRedis{GetTime: time.Now(), Result: res1.Result})
	if err != nil {
		zaplog.Errorf("GetExchangeRate err=%s", err)
		return out, err
	}

	_, err = conn.HSet(context.Background(), Cache_Hash_Get_ExchangeRate, genField(_args), jsonStr).Result()
	if err != nil {
		zaplog.Errorf("GetExchangeRate err=%s", err)
		return out, err
	}

	return getExchangeRateOut(_args, res1.Result), nil
}

type apiGetCurrenciesOut1 struct {
	List []*RedisGetCurrenciesOut `json:"list"` //汇率
}

type apiGetCurrenciesOut struct {
	ErrorCode int32                `json:"error_code"`
	Reason    string               `json:"reason"`
	Result    apiGetCurrenciesOut1 `json:"result"`
}

//2.货币列表
func apiGetCurrencies() (out *apiGetCurrenciesOut, err error) {
	//请求地址
	juheURL := "http://op.juhe.cn/onebox/exchange/list"

	//初始化参数
	param := url.Values{}

	//配置请求参数,方法内部已处理urlencode问题,中文参数可以直接传参
	param.Set("key", appkey) //应用appkey(应用详细页查询)

	//发送请求
	data, err := get(juheURL, param)
	if err != nil {
		zaplog.Errorf("请求失败,错误信息:\r\n%v", err)
		return out, err
	}
	err = jsoniter.Unmarshal(data, &out)
	if err != nil {
		zaplog.Errorf("apiGetCurrencies err=%s", err)
		return out, err
	}

	if out.ErrorCode != 0 {
		err = errors.New(out.Reason)
		zaplog.Errorf("apiGetCurrencies err=%s", err)
	}
	return
}

type apiGetExchangeRateOut struct {
	ErrorCode int32                    `json:"error_code"`
	Reason    string                   `json:"reason"`
	Result    []*getExchangeRateRedis1 `json:"result"`
}

//3.实时汇率查询换算
func apiGetExchangeRate(_from, to string) (out *apiGetExchangeRateOut, err error) {
	//请求地址
	juheURL := "http://op.juhe.cn/onebox/exchange/currency"

	//初始化参数
	param := url.Values{}

	//配置请求参数,方法内部已处理urlencode问题,中文参数可以直接传参
	param.Set("from", _from) //转换汇率前的货币代码
	param.Set("to", to)      //转换汇率成的货币代码
	param.Set("key", appkey) //应用appkey(应用详细页查询)

	//发送请求
	data, err := get(juheURL, param)
	if err != nil {
		zaplog.Errorf("请求失败,错误信息:\r\n%v", err)
		return out, err
	}
	err = jsoniter.Unmarshal(data, &out)
	if err != nil {
		zaplog.Errorf("apiGetExchangeRate err=%s", err)
		return out, err
	}

	if out.ErrorCode != 0 {
		err = errors.New(out.Reason)
		zaplog.Errorf("apiGetExchangeRate err=%s", err)
	}
	return
}

// get 网络请求
func get(apiURL string, params url.Values) (rs []byte, err error) {
	var Url *url.URL
	Url, err = url.Parse(apiURL)
	if err != nil {
		zaplog.Infof("解析url错误:\r\n%v", err)
		return nil, err
	}
	//如果参数中有中文参数,这个方法会进行URLEncode
	Url.RawQuery = params.Encode()
	resp, err := http.Get(Url.String())
	if err != nil {
		fmt.Println("err:", err)
		return nil, err
	}
	defer resp.Body.Close()
	return ioutil.ReadAll(resp.Body)
}

// post 网络请求 ,params 是url.Values类型
func post(apiURL string, params url.Values) (rs []byte, err error) {
	resp, err := http.PostForm(apiURL, params)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	return ioutil.ReadAll(resp.Body)
}
