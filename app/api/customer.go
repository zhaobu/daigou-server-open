package api

import (
	"daigou/app/service/customer"
	"daigou/library/response"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"log"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

// 支付管理对象
type CustomerAction struct{}

// @summary customer购买下单商品
// @tags    CustomerAction
// @description 客户商品下单
// @produce json
// @accept  json
// @param   data  body customer.PaymentReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/customer/submitOrders  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *CustomerAction) SubmitOrders(r *ghttp.Request) {
	//检查请求参数
	var (
		req *customer.PaymentReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = customer.CustmoerOrdersGoods(req, r.Session)
	if err != nil {
		zaplog.Infof("customer.payment err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 推送系统公告
// @tags    CustomerAction
// @description 按不同版本和用户角色来推送系统公告
// @produce json
// @accept  json
// @param   data  body customer.SystemAnnReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/customer/systemAnnouncement  [POST]
// @success 200 {object} response.JsonResponse{data=customer.SystemAnnResp{}} "请求成功"
func (c *CustomerAction) SystemAnnouncement(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *customer.SystemAnnReq
		err  error
		resp *customer.SystemAnnResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, err = customer.SystemAnnHandle(req, r.Session)
	if err != nil {
		zaplog.Infof("customer.payment err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
}

// @summary 接收公众号事件推送消息
// @tags    CustomerAction
// @description 保存关注公众号用户信息,比如关注和取消关注
// @produce xml
// @accept  xml
// @param   data  body customer.PaymentReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/customer/subscribeGzh  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func SubscribeGzh(r *ghttp.Request) {
	if r.Method == "GET" {
		//以下两行是用于更换微信服务器url配置，审核回应成功
		zaplog.Info(r.FormValue("echostr"))
		r.Response.WriteXmlExit(r.FormValue("echostr"))
	}

	//检查请求参数
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		log.Fatal(err)
	} else {
		fmt.Println(string(body))
		requestBody := &customer.GzhSubscribeReq{}
		xml.Unmarshal(body, requestBody)
		customer.GzhSubscribeHandle(requestBody)
		if err = customer.GzhMsgResponse(r.Response, requestBody); err != nil {
			zaplog.Infof("SubscribeGzh->GzhMsgResponse() err:%v", err)
		}
	}

	r.Response.WriteXmlExit("")
	return
}

// @summary 接收小程序事件推送消息
// @tags    CustomerAction
// @description 接收小程序事件推送消息
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/customer/wxSmallEvent  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func WxSmallEvent(r *ghttp.Request) {
	if r.Method == "GET" {
		//以下两行是用于更换微信服务器url配置，审核回应成功
		zaplog.Info(r.FormValue("echostr"))
		r.Response.WriteXmlExit(r.FormValue("echostr"))
	}
	var (
		req *wxapi.CustomerClientMessage
	)
	//检查请求参数
	body, _ := ioutil.ReadAll(r.Body)
	zaplog.Info(string(body))
	if err := r.Parse(&req); err != nil {
		r.Response.WriteXmlExit("success")
	}

	customer.CustomerServiceHandle(req)
	r.Response.WriteXmlExit("success")
	// //"r"为*http.Request
	// r.ParseForm()

	// timestamp := strings.Join(r.Form["timestamp"], "")
	// nonce := strings.Join(r.Form["nonce"], "")
	// signature := strings.Join(r.Form["signature"], "")
	// encryptType := strings.Join(r.Form["encrypt_type"], "")
	// msgSignature := strings.Join(r.Form["msg_signature"], "")

	// if !wechat.ValidateUrl(timestamp, nonce, signature) {
	// 	wmm.log.AppendObj(nil, "Wechat Message Service: this http request is not from Wechat platform!")
	// 	return
	// }

	// //微信安全模式更改/首次添加url，需要验证，将参数原样写会即可
	// var es string
	// if e = req.ParseGet("echostr", &es); e != nil {

	// }
	// if es != "" {
	// 	//todo 将参数值es原先写回即可
	// 	return
	// }

	// if r.Method == "POST" {
	// 	if encryptType == "aes" {
	// 		encryptRequestBody := wechat.ParseEncryptRequestBody(r)
	// 		// Validate mstBody signature
	// 		if !wechat.ValidateMsg(timestamp, nonce, encryptRequestBody.Encrypt, msgSignature) {
	// 			return
	// 		}

	// 		// Decode base64
	// 		cipherData, err := base64.StdEncoding.DecodeString(encryptRequestBody.Encrypt)
	// 		if err != nil {
	// 			return
	// 		}

	// 		// AES Decrypt
	// 		plainData, err := wechat.AesDecrypt(cipherData, wechat.AesKey)
	// 		if err != nil {
	// 			return
	// 		}

	// 		//封装struct
	// 		textRequestBody, err := wechat.ParseEncryptTextRequestBody(plainData)
	// 		if err != nil {
	// 			return
	// 		}

	// 		var url string

	// 		tp := textRequestBody.MsgType
	// 		if tp == "text" && textRequestBody.Content == "【收到不支持的消息类型，暂无法显示】" {
	// 			//安全模式下向用户回复消息也需要加密
	// 			respBody, e := wechat.MakeEncryptResponseBody(textRequestBody.ToUserName, textRequestBody.FromUserName, "一些回复给用户的消息", nonce, timestamp)
	// 			if e != nil {
	// 				return e
	// 			}
	// 			//此处return NewSimpleError是一个对返回值处理的封装，返回xml格式消息，并不是返回错误
	// 			return service.NewSimpleError(service.SERVER_WRITE_XML, string(respBody))

	// 		}
	// 		if tp == "event" {
	// 			//某个类型的消息暂时后台不作处理，也需要向微信服务器做出响应
	// 			return service.NewSimpleError(service.SERVER_WRITE_TEXT, "success")
	// 		}
	// 	}
	// 	return service.NewSimpleError(service.SERVER_WRITE_TEXT, "success")
	// }
	return
}
