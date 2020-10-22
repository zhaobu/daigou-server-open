package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

//查看绑定手机号
func SeePhoneNumber(session *ghttp.Session) (resp *model.SeePhoneNumberResp, err error) {
	resp, err = model.SeePhoneNumber(sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看绑定手机号:%s", resp)
	return
}

//查看隐私政策
func SeePrivacyPolicy(req *model.SeePrivacyPolicyReq) (resp *model.SeePrivacyPolicyResp, err error) {
	resp, err = model.SeePrivacyPolicy(req)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看隐私政策:%s", resp)
	return
}

//查看用户服务协议
func SeeServiceAgreement(req *model.SeeServiceAgreementReq) (resp *model.SeeServiceAgreementResp, err error) {
	resp, err = model.SeeServiceAgreement(req)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看用户服务协议:%s", resp)
	return
}
