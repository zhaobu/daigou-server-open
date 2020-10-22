// 登录凭证校验。通过 wx.login 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程
// url= https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/login/auth.code2Session.html
package wxapi

import (
	"daigou/library/zaplog"
	"fmt"

	"github.com/gogf/gf/net/ghttp"
	jsoniter "github.com/json-iterator/go"
)

const (
	code2SessionUrl string = "https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code"
)

//微信auth.code2Session请求结果
type Code2SessionResp struct {
	OpenId     string `json:"openid"`
	SessionKey string `json:"session_key"`
	UnionId    string `json:"unionid"`
	ErrCode    int    `json:"errcode"`
	ErrMsg     string `json:"errmsg"`
}

func Code2Session(_appid, _secret, _code string) (resp *Code2SessionResp, err error) {
	url := fmt.Sprintf(code2SessionUrl, _appid, _secret, _code)
	zaplog.Infof("code2SessionUrl=%s", url)
	wxRes, err := ghttp.Get(url)
	defer wxRes.Close()
	if err != nil {
		zaplog.Errorf("Code2Session ghttp.Get err=%s", err.Error())
		return nil, err
	}
	//解析微信接口服务返回的参数
	err = jsoniter.Unmarshal(wxRes.ReadAll(), &resp)
	if err != nil {
		zaplog.Errorf("Code2Session jsoniter.Unmarshal err=%s", err.Error())
		return nil, err
	}
	return
}
