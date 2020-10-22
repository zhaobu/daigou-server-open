package wxapi

import (
	"github.com/medivhzhan/weapp/v2"
	"github.com/milkbobo/gopay/common"
)

type CommonError struct {
	weapp.CommonError
}

// PayMentReq 微信支付参数
type PayMentReq struct {
	common.Charge
}

type UnifyOrderResp struct {
	Return_code string  `xml:"return_code"`
	Return_msg  string  `xml:"return_msg"`
	Appid       string  `xml:"appid"`
	Mch_id      string  `xml:"mch_id"`
	Nonce_str   string  `xml:"nonce_str"`
	Sign        string  `xml:"sign"`
	Result_code string  `xml:"result_code"`
	Prepay_id   string  `xml:"prepay_id"`
	Trade_type  string  `xml:"trade_type"`
	Total_fee   float64 `xml:"total_fee"` //总金额
	TimeStamp   string  `xml:"timeStamp"` //总金额
}

type CallbackReq struct {
	common.WeChatPayResult
}

type GetOrderDetail struct {
	Appid        string `xml:"appid"`
	Mch_id       string `xml:"mch_id"`
	Out_trade_no string `xml:"out_trade_no"`
	Noncestr     string `xml:"nonce_str"`
	Sign         string `xml:"sign"`
	Sign_type    string `xml:"sign_type"`
}
