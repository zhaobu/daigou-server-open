// 发送订阅消息
// url= https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/subscribe-message/subscribeMessage.send.html
package wxapi

import (
	"daigou/library/redis"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/gogf/gf/net/ghttp"
	jsoniter "github.com/json-iterator/go"
	"github.com/medivhzhan/weapp/v2"
)

const (
	subscribeMessageUrl string = "https://api.weixin.qq.com/cgi-bin/message/subscribe/send?access_token=%s"
	templateMessageUrl  string = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=%s"          //公众号推送
	getWxUserInfoUrl    string = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=%s&openid=%s&lang=zh_CN" //获取微信用户基础信息
)

type SubscribeMessageReq struct {
	AccessToken      string                     `json:"access_token,omitempty"`
	ToUser           string                     `json:"touser"`
	TemplateID       string                     `json:"template_id"`
	Page             string                     `json:"page,omitempty"`
	Data             weapp.SubscribeMessageData `json:"data"`
	MiniprogramState string                     `json:"miniprogram_state,omitempty"`
	Lang             string                     `json:"lang,omitempty"`
}

//微信小程序订阅消息
func SubscribeMessage(_req *SubscribeMessageReq) (resp *CommonError, err error) {
	//获取token
	token, err := redis.GetAccessToken()
	if err != nil {
		zaplog.Errorf("SubscribeMessage GetAccessToken err=%s", err.Error())
		return nil, err
	}
	url := fmt.Sprintf(subscribeMessageUrl, token)
	zaplog.Infof("subscribeMessageUrl=%s", url)
	_req.AccessToken = token

	jsonArg, err := jsoniter.Marshal(_req)
	if err != nil {
		zaplog.Errorf("SubscribeMessage jsoniter.Marshal err=%s", err.Error())
		return nil, err
	}
	wxRes, err := ghttp.Post(url, jsonArg)
	defer wxRes.Close()
	if err != nil {
		zaplog.Errorf("SubscribeMessage ghttp.Post err=%s", err.Error())
		return nil, err
	}

	//解析微信接口服务返回的参数
	err = jsoniter.Unmarshal(wxRes.ReadAll(), &resp)
	if err != nil {
		zaplog.Errorf("SubscribeMessage jsoniter.Unmarshal err=%s", err.Error())
		return nil, err
	}
	if resp.CommonError.ErrMSG != "ok" {
		zaplog.Errorf("[error] SubscribeMessage,resp=%+v", resp)
	}
	return
}

// UniformMpTmpMsg 公众号模板消息
type UniformMpTmpMsg struct {
	ToUser      string                `json:"touser"` // 接收者openid
	TemplateID  string                `json:"template_id"`
	URL         string                `json:"url"`
	Miniprogram UniformMsgMiniprogram `json:"miniprogram"`
	Data        UniformMsgData        `json:"data"` //模板数据
}

// UniformMsgMiniprogram 跳小程序所需数据，不需跳小程序可不用传该数据
type UniformMsgMiniprogram struct {
	AppID    string `json:"appid"`
	PagePath string `json:"pagepath"`
}

// UniformMsgData 模板消息内容
type UniformMsgData map[string]UniformMsgKeyword

// UniformMsgKeyword 关键字
type UniformMsgKeyword struct {
	Value string `json:"value"`
	Color string `json:"color,omitempty"`
}

//公众号模板推送消息
func TemplateMessage(_req *UniformMpTmpMsg) (resp *CommonError, err error) {
	//获取token
	token, err := redis.GetGzhAccessToken()
	// token := "35_5zcVG0ImhxHLCdzcSkFYjCeBgB8gEAoiqH2aDKX6corWHhaq5dmcH_tdcwmraLfXNOrNprjgPpqP6qVmjwT1kz2TWYSmBASupJtGZYta05ccqOmunLf7u90-26OrTdvklsRlyvTQdO46BLigQXTfAJAJQM"
	if err != nil {
		zaplog.Errorf("TemplateMessage GetAccessToken err=%s", err.Error())
		return nil, err
	}
	url := fmt.Sprintf(templateMessageUrl, token)
	zaplog.Infof("templateMessageUrl=%s", url)

	jsonArg, err := jsoniter.Marshal(_req)
	if err != nil {
		zaplog.Errorf("TemplateMessage jsoniter.Marshal err=%s", err.Error())
		return nil, err
	}
	zaplog.Errorf("json=%s", string(jsonArg))
	wxRes, err := ghttp.Post(url, jsonArg)
	defer wxRes.Close()
	if err != nil {
		zaplog.Errorf("TemplateMessage ghttp.Post err=%s", err.Error())
		return nil, err
	}

	//解析微信接口服务返回的参数
	err = jsoniter.Unmarshal(wxRes.ReadAll(), &resp)

	if err != nil {
		zaplog.Errorf("TemplateMessage jsoniter.Unmarshal err=%s", err.Error())
		return nil, err
	}
	if resp.CommonError.ErrMSG != "ok" {
		zaplog.Errorf("[error] TemplateMessage,resp=%+v", resp)
	}
	return
}

// 获取用户基础信息
type WxUserReq struct {
	OpenID string
}

type WxUserInfoResp struct {
	Subscribe      int           `json:"subscribe"`       //用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息
	OpenID         string        `json:"openid"`          //用户的标识，对当前公众号唯一
	NickName       string        `json:"nickname"`        //用户的昵称
	Sex            int           `json:"sex"`             //用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
	Language       string        `json:"language"`        //用户所在城市
	City           string        `json:"city"`            //用户所在国家
	Province       string        `json:"province"`        //用户所在省份
	Country        string        `json:"country"`         //用户的语言，简体中文为zh_CN
	HeadImgUrl     string        `json:"headimgurl"`      //用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。
	SubscribeTime  time.Duration `json:"subscribe_time"`  //用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间
	UnionID        string        `json:"unionid"`         //只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。
	Remark         string        `json:"remark"`          //公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注
	GroupID        int           `json:"groupid"`         //用户所在的分组ID（兼容旧的用户分组接口）
	TragIdList     []int         `json:"tagid_list"`      //用户被打上的标签ID列表
	SubscribeScene string        `json:"subscribe_scene"` //返回用户关注的渠道来源，ADD_SCENE_SEARCH 公众号搜索，ADD_SCENE_ACCOUNT_MIGRATION 公众号迁移，ADD_SCENE_PROFILE_CARD 名片分享，ADD_SCENE_QR_CODE 扫描二维码，ADD_SCENE_PROFILE_LINK 图文页内名称点击，ADD_SCENE_PROFILE_ITEM 图文页右上角菜单，ADD_SCENE_PAID 支付后关注，ADD_SCENE_WECHAT_ADVERTISEMENT 微信广告，ADD_SCENE_OTHERS 其他
	QrScene        int           `json:"qr_scene"`        //二维码扫码场景（开发者自定义）
	QrSceneStr     string        `json:"qr_scene_str"`    //二维码扫码场景描述（开发者自定义）
}
type WxUserInfoErrorResp struct {
	ErrCode string `json:"errcode"` //错误码
	ErrMsg  string `json:"errmsg"`  //错误消息
}

//获取用户基础信息(UnionID)
func GetWxUserInfo(_req *WxUserReq) (resp *WxUserInfoResp, err error) {
	//获取token
	token, err := redis.GetGzhAccessToken()
	// token := "35_0XCheollSig5dnpiv0UY-eJdvT69RgERhfETll45lORF7JCcYo1nRnxxdC5NcfPgu5dg4-9XjnfBDNAdJA1U8bq363tIuebDJysHCeaO3ml78tTflhZzdzVJf2OFMc61cO5OYDaRpEsadGt-NUZfADAVCH"
	if err != nil {
		zaplog.Errorf("GetWxUserInfo GetAccessToken err=%s", err.Error())
		return nil, err
	}
	url := fmt.Sprintf(getWxUserInfoUrl, token, _req.OpenID)
	zaplog.Infof("getWxUserInfoUrl=%s", url)
	wxRes, err := ghttp.Get(url)
	defer wxRes.Close()
	if err != nil {
		zaplog.Errorf("GetWxUserInfo ghttp.Post err=%s", err.Error())
		return nil, err
	}
	resbyte := wxRes.ReadAll() //获取应答
	zaplog.Info(string(resbyte))
	resp = &WxUserInfoResp{}
	//解析微信接口服务返回的参数
	err = jsoniter.Unmarshal(resbyte, &resp)
	if err != nil {
		zaplog.Errorf("GetWxUserInfo jsoniter.Unmarshal err=%s", err.Error())
		return nil, err
	}
	return
}
