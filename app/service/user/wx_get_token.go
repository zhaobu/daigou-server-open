package user

import (
	"daigou/app/service/user/sessionman"
	"daigou/library/conf"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"fmt"

	"github.com/gogf/gf/net/ghttp"
)

type WxGetTokenReq struct {
	Code string `json:"code" v:"code@required#code码不能为空"` //微信登录code码
}

type WxGetTokenResp struct {
	Token string `json:"token"`
}

// 验证code获取token
func WxGetToken(req *WxGetTokenReq, session *ghttp.Session) (resp *WxGetTokenResp, err error) {
	zaplog.Debugf("req=%+v", req)

	//请求微信登录接口服务
	wxResult, err := wxapi.Code2Session(conf.Conf.Weapp.AppID, conf.Conf.Weapp.Secret, req.Code)
	if err != nil {
		zaplog.Errorf("wxapi.Code2Session err=%s", err.Error())
		return nil, err
	}

	if wxResult.ErrCode != 0 {
		zaplog.Errorf("wxapi.Code2Session err, wxResult=%+v", wxResult)
		return nil, fmt.Errorf(wxResult.ErrMsg)
	}
	zaplog.Debugf("wxResult=%+v", wxResult)

	//将session保存到redis中
	sessionman.UpdateSession(session, &sessionman.SessionInfo{
		OpenId:     wxResult.OpenId,
		SessionKey: wxResult.SessionKey,
		UnionId:    wxResult.UnionId,
	})
	resp = &WxGetTokenResp{Token: session.Id()}
	zaplog.Infof("WxGetToken success,resp=%+v", resp)
	return
}
