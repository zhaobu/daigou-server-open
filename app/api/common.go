package api

import (
	"daigou/app/service/common"
	"daigou/app/service/user/sessionman"
	"daigou/library/alioss"
	"daigou/library/response"
	"daigou/library/txcloud"
	"daigou/library/utils"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"encoding/xml"
	"fmt"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/gvalid"
	jsoniter "github.com/json-iterator/go"
)

// 通用接口
type CommonAction struct{}

// @summary alioss获取policy
// @tags    CommonAction
// @description alioss获取policy
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/common/aliGetPolicy  [GET]
// @success 200 {object} response.JsonResponse{data=alioss.PolicyToken} "请求结果"
func (c *CommonAction) AliGetPolicy(r *ghttp.Request) {
	userInfo := sessionman.GetUserInfo(r.Session)
	zaplog.Debugf("AliGetPolicy success")
	response.SuccExit(r, alioss.GetPolicyToken(gconv.String(userInfo.UserID)))
}

// @summary 获取临时密钥
// @tags    CommonAction
// @description 微信对象存储服务获取临时密钥
// @produce json
// @accept  json
// @param   data  body  txcloud.GetCredentialIn  true "需要传入的参数"
// @router  /daigou/api/v{version}/common/txCloudGetToken  [POST]
// @success 200 {object} response.JsonResponse{data=txcloud.GetCredentialOut} "请求结果"
func (c *CommonAction) TxCloudGetToken(r *ghttp.Request) {
	var (
		req  *txcloud.GetCredentialIn
		resp *txcloud.GetCredentialOut
		err  error
	)
	//解析参数
	if err = jsoniter.Unmarshal(r.GetBody(), &req); err != nil {
		zaplog.Errorf("TxCloudGetToken err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	//验证参数
	if errStr := gvalid.CheckStruct(req, ""); errStr != nil {
		zaplog.Errorf("TxCloudGetToken err:%s", errStr.FirstString())
		response.FailExit(r, errStr.FirstString())
	}

	resp, err = txcloud.GetCredential(req)
	if err != nil {
		zaplog.Errorf("TxCloudGetToken err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	zaplog.Debugf("TxCloudGetToken success,resp=%s", utils.Dump(resp))

	response.SuccExit(r, resp)
}

// @summary 微信发送订阅消息
// @tags    CommonAction
// @description 调用subscribeMessage.send接口发送订阅消息
// @produce json
// @accept  json
// @param   data  body  wxapi.SubscribeMessageReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/common/wxSendSubscribeMsg  [POST]
// @success 200 {object} response.JsonResponse{data=wxapi.CommonError} "请求结果"
func (c *CommonAction) WxSendSubscribeMsg(r *ghttp.Request) {
	//检查请求参数
	var (
		req *wxapi.SubscribeMessageReq
		err error
	)

	//解析参数
	if err = jsoniter.Unmarshal(r.GetBody(), &req); err != nil {
		zaplog.Errorf("WxSendSubscribeMsg err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	//验证参数
	if errStr := gvalid.CheckStruct(req, ""); errStr != nil {
		zaplog.Errorf("WxSendSubscribeMsg err:%s", errStr.FirstString())
		response.FailExit(r, errStr.FirstString())
	}

	zaplog.Debugf("WxSendSubscribeMsg req=%+v", req)
	resp, err := wxapi.SubscribeMessage(req)
	if err != nil {
		zaplog.Infof("WxSendSubscribeMsg err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("WxSendSubscribeMsg success:%s", utils.Dump(resp))
	response.SuccExit(r, resp)
}

// @summary 微信支付回调
// @tags    CommonAction
// @produce json
// @accept  json
// @success 200 {object} response.JsonResponse "请求结果"
func PaymentCallback(r *ghttp.Request) {
	//检查请求参数
	var (
		req *wxapi.CallbackReq
		err error
	)

	//解析参数
	if err = xml.Unmarshal(r.GetBody(), &req); err != nil {
		zaplog.Errorf("PaymentCallback err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	zaplog.Infof("微信支付回调:%s", utils.Dump(req))

	resp, err := common.WeChatCallback(req)
	if err != nil {
		zaplog.Errorf("PaymentCallback err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
}

// @summary 测试接口
// @tags    CommonAction
// @description 测试接口
// @produce json
// @accept  json
// @param   data  body  common.TestApiReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/common/testApi  [POST]
// @success 200 {object} response.JsonResponse{data=common.TestApiResp} "请求结果"
func (c *CommonAction) TestApi(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *common.TestApiReq
		resp *common.TestApiResp
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = common.TestApi(req)
	if err != nil {
		err = fmt.Errorf("common.TestApi err:%s", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	zaplog.Debugf("common.TestApi success:%s", utils.Dump(resp))
	response.SuccExit(r, resp)
}
