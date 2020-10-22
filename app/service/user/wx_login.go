package user

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"
	"fmt"
	"strings"

	"github.com/gogf/gf/crypto/gsha1"
	"github.com/gogf/gf/net/ghttp"
	jsoniter "github.com/json-iterator/go"
)

// WxLoginRequest 微信登录request
type WxLoginReq struct {
	RawData   string `json:"rawData" v:"rawData@required#rawData不能为空"`       //rawdaa
	Signature string `json:"signature" v:"signature@required#signature不能为空"` //签名
	Type      int32  `json:"type" v:"type@required#登录类型type不能为空"`            //登录类型(1:普通登录 2:分享链接登录 3:二维码登录)
}

// WxLoginWithTokenReq 微信登录request
type WxLoginWithTokenReq struct {
	Type int32 `json:"type" v:"type@required#登录类型不能为空"` //登录类型(1:普通登录 2:分享链接登录 3:二维码登录)
}

// WxLoginResponse 微信登录response
type WxLoginResp struct {
	*model.DbWxLoginOut
	Type int32 `json:"type"`
}

//微信RawData解析结构体
type wxRawData struct {
	NickName  string `json:"nickName"`
	Gender    int32  `json:"gender"`
	Language  string `json:"language"`
	City      string `json:"city"`
	Province  string `json:"province"`
	Country   string `json:"country"`
	AvatarUrl string `json:"avatarUrl"`
}

// 带session微信登录
func WxLoginWithSession(req *WxLoginWithTokenReq, session *ghttp.Session) (resp *WxLoginResp, err error) {
	zaplog.Debugf("req=%+v", req)
	userInfo := sessionman.GetUserInfo(session)
	if userInfo == nil {
		err = fmt.Errorf("WxLoginWithSession err, token 过期")
		return
	}
	userInfo.Type = req.Type
	resp = &WxLoginResp{DbWxLoginOut: userInfo.DbWxLoginOut, Type: userInfo.Type}
	//update
	sessionman.UpdateSession(session, userInfo)
	//添加登录日志
	// model.AddLoginRecord(&entity.UserLoginRecords{UserID: userInfo.UserID, Type: req.Type})
	return
}

//code验证通过后,验证更新用户信息
func WxLogin(req *WxLoginReq, session *ghttp.Session) (resp *WxLoginResp, err error) {
	zaplog.Debugf("req=%+v", req)
	sessionInfo := sessionman.GetSessionInfo(session)

	//数据签名校验
	newSignature := genSignature(req.RawData, sessionInfo.SessionKey)
	if req.Signature != newSignature {
		zaplog.Errorf("WxLogin err, newSignature=%s,Signature=%s", newSignature, req.Signature)
		return nil, fmt.Errorf("signature check error")
	}

	var rawData *wxRawData
	err = jsoniter.Unmarshal([]byte(req.RawData), &rawData)
	if err != nil {
		zaplog.Errorf("WxLogin err=%s", err)
		return nil, err
	}

	//根据openid判断用户是否是新用户
	res1, err := model.WxLogin(&model.DbWxLoginIn{
		UnionID:   sessionInfo.UnionId,
		OpenID:    sessionInfo.OpenId,
		NickName:  rawData.NickName,
		AvatarURL: rawData.AvatarUrl,
		Gender:    rawData.Gender,
		Country:   rawData.Country,
		Province:  rawData.Province,
		City:      rawData.City,
		Language:  rawData.Language,
	})
	if err != nil {
		zaplog.Errorf("WxLogin err=%s", err)
		return nil, err
	}
	resp = &WxLoginResp{DbWxLoginOut: res1, Type: req.Type}
	//将用户信息保存到redis中
	sessionman.UpdateSession(session, &sessionman.UserInfo{DbWxLoginOut: res1, Type: req.Type})
	zaplog.Infof("wXLogin success,resp=%+v", resp)
	return
}

func genSignature(_rawData, _sessionKey string) string {
	return gsha1.Encrypt(strings.ReplaceAll(_rawData, "\\", "") + _sessionKey)
}

type TestUserLoginReq struct {
	UserType int32 `json:"user_type" v:"user_type@required-unless:user_type,1,2#用户类型不正确"` //用户类型(1:买家体验号,2:卖家体验号)
	Type     int32 `json:"type" v:"type@required#登录类型不能为空"`                               //登录类型(1:普通登录 2:分享链接登录 3:二维码登录)
}

type TestUserLoginResp struct {
	*WxLoginResp
	Token string `json:"token"`
}

func TestUserLogin(req *TestUserLoginReq, session *ghttp.Session) (resp *TestUserLoginResp, err error) {
	zaplog.Debugf("req=%+v", req)

	res1, err := model.TestUserLogin(&model.DbTestUserLoginIn{Type: req.Type, UserType: req.UserType})
	if err != nil {
		zaplog.Errorf("WxLogin err=%s", err)
		return nil, err
	}

	resp = &TestUserLoginResp{WxLoginResp: &WxLoginResp{DbWxLoginOut: &res1.DbWxLoginOut, Type: req.Type}, Token: session.Id()}
	//将用户信息保存到redis中
	sessionman.UpdateSession(session, &sessionman.SessionInfo{OpenId: res1.OpenID})
	sessionman.UpdateSession(session, &sessionman.UserInfo{DbWxLoginOut: &res1.DbWxLoginOut, Type: req.Type})
	zaplog.Infof("TestUserLogin success,resp=%+v", resp)
	return
}

// WxLoginRequest 微信登录request
type WxLoginNotSignReq struct {
	RawData string `json:"rawData" v:"rawData@required#rawData不能为空"` //rawdaa
	Type    int32  `json:"type" v:"type@required#登录类型type不能为空"`      //登录类型(1:普通登录 2:分享链接登录 3:二维码登录)
}

//不需要code验证
func WxLoginNotSign(req *WxLoginNotSignReq, session *ghttp.Session) (resp *WxLoginResp, err error) {
	zaplog.Debugf("req=%+v", req)
	sessionInfo := sessionman.GetSessionInfo(session)

	var rawData *wxRawData
	err = jsoniter.Unmarshal([]byte(req.RawData), &rawData)
	if err != nil {
		zaplog.Errorf("WxLogin err=%s", err)
		return nil, err
	}

	//根据openid判断用户是否是新用户
	res1, err := model.WxLogin(&model.DbWxLoginIn{
		UnionID:   sessionInfo.UnionId,
		OpenID:    sessionInfo.OpenId,
		NickName:  rawData.NickName,
		AvatarURL: rawData.AvatarUrl,
		Gender:    rawData.Gender,
		Country:   rawData.Country,
		Province:  rawData.Province,
		City:      rawData.City,
		Language:  rawData.Language,
	})
	if err != nil {
		zaplog.Errorf("WxLogin err=%s", err)
		return nil, err
	}
	resp = &WxLoginResp{DbWxLoginOut: res1, Type: req.Type}
	//将用户信息保存到redis中
	sessionman.UpdateSession(session, &sessionman.UserInfo{DbWxLoginOut: res1, Type: req.Type})
	zaplog.Infof("wXLogin success,resp=%+v", resp)
	return
}
