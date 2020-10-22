package test

import (
	"bytes"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
	"testing"

	"github.com/gogf/gf/util/guid"
	"github.com/milkbobo/gopay/client"
	"github.com/milkbobo/gopay/util"
)

type UnifyOrderReq struct {
	Appid            string `xml:"appid"`            //公众账号ID
	Body             string `xml:"body"`             //商品描述
	Mch_id           string `xml:"mch_id"`           //商户号
	Nonce_str        string `xml:"nonce_str"`        //随机字符串
	Notify_url       string `xml:"notify_url"`       //通知地址
	Trade_type       string `xml:"trade_type"`       //交易类型
	Spbill_create_ip string `xml:"spbill_create_ip"` //支付提交用户端ip
	Total_fee        string `xml:"total_fee"`        //总金额
	Out_trade_no     string `xml:"out_trade_no"`     //商户订单号
	Sign             string `xml:"sign"`             //签名
	Openid           string `xml:"openid"`           //购买商品的用户wxid
}

type UnifyOrderResp struct {
	Return_code string `xml:"return_code"`
	Return_msg  string `xml:"return_msg"`
	Appid       string `xml:"appid"`
	Mch_id      string `xml:"mch_id"`
	Nonce_str   string `xml:"nonce_str"`
	Sign        string `xml:"sign"`
	Result_code string `xml:"result_code"`
	Prepay_id   string `xml:"prepay_id"`
	Trade_type  string `xml:"trade_type"`
}

func Test1(t *testing.T) {
	sendData := UnifyOrderReq{
		Appid:            "wxce110d1bd97f0dda",
		Body:             client.TruncatedText("腾讯充值中心-QQ会员充值", 32),
		Mch_id:           "1600500050",
		Nonce_str:        guid.S(),
		Spbill_create_ip: util.LocalIP(),
		Total_fee:        client.WechatMoneyFeeToString(1),
		Out_trade_no:     "20150806125346",
		Notify_url:       "http://119.23.138.52:8199/daigou/api/v1/common/paymentCallback",
		Trade_type:       "JSAPI",
		Openid:           "otZjk5JMo_dL3SnOgaXOeBtUijmU",
	}
	var m = make(map[string]string)
	m["appid"] = sendData.Appid
	m["body"] = sendData.Body
	m["mch_id"] = sendData.Mch_id
	m["notify_url"] = sendData.Notify_url
	m["trade_type"] = sendData.Trade_type
	m["spbill_create_ip"] = sendData.Spbill_create_ip
	m["total_fee"] = sendData.Total_fee
	m["out_trade_no"] = sendData.Out_trade_no
	m["nonce_str"] = sendData.Nonce_str
	m["openid"] = sendData.Openid
	sign, err := client.WechatGenSign("Loverxjc587493Loverxjc587493Love", m)
	if err != nil {
		return
	}
	sendData.Sign = sign
	zaplog.Infof("sign :%s", sign)
	bytes_req, err := xml.Marshal(sendData)
	str_req := strings.Replace(string(bytes_req), "UnifyOrderReq", "xml", -1)
	//fmt.Println("转换为xml--------", str_req)
	bytes_req = []byte(str_req)

	//发送unified order请求.
	req, err := http.NewRequest("POST", "https://api.mch.weixin.qq.com/pay/unifiedorder", bytes.NewReader(bytes_req))
	if err != nil {
		fmt.Println("New Http Request发生错误，原因:", err)
		return

	}
	req.Header.Set("Accept", "application/xml")
	//这里的http header的设置是必须设置的.
	req.Header.Set("Content-Type", "application/xml;charset=utf-8")

	client := http.Client{}
	resp, _err := client.Do(req)
	if _err != nil {
		fmt.Println("请求微信支付统一下单接口发送错误, 原因:", _err)
		return
	}
	respBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("解析返回body错误", err)
		return
	}
	xmlResp := UnifyOrderResp{}
	_err = xml.Unmarshal(respBytes, &xmlResp)
	//处理return code.
	if xmlResp.Return_code == "FAIL" {
		fmt.Println("微信支付统一下单不成功，原因:", xmlResp.Return_msg, " str_req-->", str_req)
		return
	} else {
		return
	}
}
func Test2(t *testing.T) {
	req := &wxapi.WxUserReq{
		OpenID: "oGstJwDKHCMh4NcB7Rod7kHTdkGY",
	}
	resp, _ := wxapi.GetWxUserInfo(req)
	fmt.Println("unionid=", resp.UnionID)
	// wxapi.PostFormDataFile("D:/IE Downloads/qrcode_for_gh_679b8303fff9_258.jpg")
}
