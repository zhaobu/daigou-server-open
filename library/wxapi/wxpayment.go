// 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程
// url= https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/login/auth.code2Session.html
package wxapi

import (
	"bytes"
	"daigou/app/model"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"encoding/xml"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/guid"
	"github.com/milkbobo/gopay/client"
	"github.com/milkbobo/gopay/common"
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
	Attach           string `xml:"attach"`           //商品ID
}

// Pay 支付
func PayMent(charge *common.Charge) (resp *UnifyOrderResp, err error) {
	var bodys string = ""
	if gconv.Int(charge.Describe) == 1 || gconv.Int(charge.Describe) == 4 {
		bodys = "诚物-1个月会员"
	} else if gconv.Int(charge.Describe) == 2 {
		bodys = "诚物-3个月会员"
	} else {
		bodys = "诚物-12个月会员"
	}
	sendData := UnifyOrderReq{
		Appid:            conf.Conf.Weapp.AppID,
		Body:             client.TruncatedText(bodys, 32),
		Mch_id:           conf.Conf.Weapp.PayMent.MchID,
		Nonce_str:        guid.S(),
		Spbill_create_ip: util.LocalIP(),
		Total_fee:        client.WechatMoneyFeeToString(charge.MoneyFee),
		Out_trade_no:     charge.TradeNum,
		Notify_url:       conf.Conf.Weapp.PayMent.NotifyUrl, //"http://119.23.138.52:8199/daigou/api/v1/common/paymentCallback",
		Trade_type:       "JSAPI",
		Openid:           charge.OpenID,
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
	sign, err := client.WechatGenSign(conf.Conf.Weapp.PayMent.Key, m)
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

	clients := http.Client{}
	xmlResp, _err := clients.Do(req)
	if _err != nil {
		fmt.Println("请求微信支付统一下单接口发送错误, 原因:", _err)
		return
	}
	respBytes, err := ioutil.ReadAll(xmlResp.Body)
	if err != nil {
		fmt.Println("解析返回body错误", err)
		return
	}
	resp = &UnifyOrderResp{}
	_err = xml.Unmarshal(respBytes, &resp)
	resp.Total_fee, err = strconv.ParseFloat(sendData.Total_fee, 64)
	resp.Total_fee = resp.Total_fee / 100
	timestamp := gconv.String(time.Now().Unix())
	var k = make(map[string]string)
	k["appId"] = sendData.Appid
	k["nonceStr"] = sendData.Nonce_str
	k["package"] = "prepay_id=" + resp.Prepay_id
	k["signType"] = "MD5"
	k["timeStamp"] = timestamp
	paysign, err := client.WechatGenSign(conf.Conf.Weapp.PayMent.Key, k)
	if err != nil {
		return
	}
	resp.Nonce_str = sendData.Nonce_str
	resp.Sign = paysign
	resp.TimeStamp = timestamp
	//处理return code.
	if resp.Return_code == "FAIL" {
		fmt.Println("微信支付统一下单不成功，原因:", resp.Return_msg, " str_req-->", str_req)
		return
	} else {
		return resp, err
	}
}

// WeChatCallback 微信支付返回
func WeChatCallback(req *CallbackReq) (resp *common.WechatBaseResult, err error) {
	resp = &common.WechatBaseResult{}
	if req.ReturnCode == "FAIL" {
		res, err := GetWeixinOrderInfo(req)
		if err != nil {
			return nil, err
		}
		if res.ResultCode == "SUCCESS" {
			resp.ReturnCode = "SUCCESS"
			resp.ReturnMsg = "OK"
		} else {
			resp.ReturnCode = "FAIL"
			resp.ReturnMsg = "failed to verify sign, please retry!"
		}
		//结果返回，微信要求如果成功需要返回return_code "SUCCESS"
		bytes, _err := xml.Marshal(resp)
		strResp := strings.Replace(string(bytes), "WXPayNotifyResp", "xml", -1)
		if _err != nil {
			fmt.Println("xml编码失败，原因：", _err)
			return resp, err
		}
		zaplog.Infof("WeChatCallback success:%s", strResp)
		return resp, err
	}
	var reqMap = make(map[string]string)
	reqMap["return_code"] = req.ReturnCode
	reqMap["return_msg"] = req.ReturnMsg
	reqMap["appid"] = req.AppID
	reqMap["mch_id"] = req.MchID
	reqMap["nonce_str"] = req.NonceStr
	reqMap["result_code"] = req.ResultCode
	reqMap["openid"] = req.OpenID
	reqMap["is_subscribe"] = req.IsSubscribe
	reqMap["trade_type"] = req.TradeType
	reqMap["bank_type"] = req.BankType
	reqMap["total_fee"] = req.TotalFee
	reqMap["fee_type"] = req.FeeType
	reqMap["cash_fee"] = req.CashFee
	reqMap["cash_fee_type"] = req.CashFeeType
	reqMap["transaction_id"] = req.TransactionID
	reqMap["out_trade_no"] = req.OutTradeNO
	reqMap["attach"] = req.Attach
	reqMap["time_end"] = req.TimeEnd

	mySign, err := client.WechatGenSign(conf.Conf.Weapp.PayMent.Key, reqMap)
	if err != nil {
		return nil, err
	}

	if mySign != req.Sign {
		resp.ReturnCode = "FAIL"
		resp.ReturnMsg = "failed to verify sign, please retry!"

	} else {
		price, err := model.SeePrice(req.OutTradeNO)
		if err != nil {
			return nil, err
		}
		if price.MemberPrice*100 == gconv.Float64(req.TotalFee) {
			resp.ReturnCode = "SUCCESS"
			resp.ReturnMsg = "OK"
		} else {
			resp.ReturnCode = "FAIL"
			resp.ReturnMsg = "failed to verify sign, please retry!"
		}
	}

	//结果返回，微信要求如果成功需要返回return_code "SUCCESS"
	bytes, _err := xml.Marshal(resp)
	strResp := strings.Replace(string(bytes), "WXPayNotifyResp", "xml", -1)
	if _err != nil {
		fmt.Println("xml编码失败，原因：", _err)
		return resp, err
	}
	zaplog.Infof("WeChatCallback success:%s", strResp)
	return resp, err
}

//查询订单
func GetWeixinOrderInfo(charge *CallbackReq) (*common.WeChatPayResult, error) {
	sendData := GetOrderDetail{
		Appid:        charge.AppID,
		Mch_id:       charge.MchID,
		Out_trade_no: charge.OutTradeNO,
		Noncestr:     charge.NonceStr,
		Sign_type:    "MD5",
	}
	var m = make(map[string]string)
	m["appid"] = sendData.Appid
	m["mch_id"] = sendData.Mch_id
	m["nonce_str"] = sendData.Noncestr
	m["out_trade_no"] = sendData.Out_trade_no
	m["sign_type"] = sendData.Sign_type
	sign, err := client.WechatGenSign(conf.Conf.Weapp.PayMent.Key, m)
	if err != nil {
		return nil, err
	}
	sendData.Sign = sign
	zaplog.Infof("sign :%s", sign)
	bytes_req, err := xml.Marshal(sendData)
	str_req := strings.Replace(string(bytes_req), "UnifyOrderReq", "xml", -1)
	//fmt.Println("转换为xml--------", str_req)
	bytes_req = []byte(str_req)

	//发送unified order请求.
	req, err := http.NewRequest("POST", "https://api.mch.weixin.qq.com/pay/orderquery", bytes.NewReader(bytes_req))
	if err != nil {
		fmt.Println("New Http Request发生错误，原因:", err)
		return nil, errors.New("Http Request发生错误")

	}
	req.Header.Set("Accept", "application/xml")
	//这里的http header的设置是必须设置的.
	req.Header.Set("Content-Type", "application/xml;charset=utf-8")

	client := http.Client{}
	resp, _err := client.Do(req)
	if _err != nil {
		fmt.Println("请求微信支付统一下单接口发送错误, 原因:", _err)
		return nil, errors.New("请求微信支付统一下单接口发送错误")
	}
	respBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("解析返回body错误", err)
		return nil, errors.New("解析返回body错误")
	}
	xmlResp := common.WeChatPayResult{}
	_err = xml.Unmarshal(respBytes, &xmlResp)
	//处理return code.
	if xmlResp.ReturnCode == "FAIL" {
		fmt.Println("微信支付查询订单不成功，原因:", xmlResp.ReturnMsg, " str_req-->", str_req)
		return nil, errors.New("不成功失败原因:" + xmlResp.ReturnMsg)
	} else {
		return &xmlResp, nil
	}
}

// 微信关闭订单
func WachatCloseOrder(charge *common.Charge) (common.WeChatQueryResult, error) {
	sendData := UnifyOrderReq{
		Appid:        conf.Conf.Weapp.AppID,
		Mch_id:       conf.Conf.Weapp.PayMent.MchID,
		Nonce_str:    guid.S(),
		Out_trade_no: charge.TradeNum,
	}
	var m = make(map[string]string)
	m["appid"] = sendData.Appid
	m["mch_id"] = sendData.Mch_id
	m["nonce_str"] = sendData.Nonce_str
	m["out_trade_no"] = sendData.Out_trade_no
	m["sign_type"] = "MD5"

	sign, err := client.WechatGenSign(conf.Conf.Weapp.PayMent.Key, m)
	if err != nil {
		return common.WeChatQueryResult{}, err
	}
	m["sign"] = sign

	// 转出xml结构
	result, err := client.PostWechat("https://api.mch.weixin.qq.com/pay/closeorder", m, nil)
	if err != nil {
		return common.WeChatQueryResult{}, err
	}

	return result, err
}
