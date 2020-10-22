package customer

import (
	"daigou/app/model"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"encoding/xml"
	"time"

	"github.com/gogf/gf/net/ghttp"
)

//校验审核设置服务器地址应答
type TokenReq struct {
	Signature string        //微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数。
	Timestamp time.Duration //时间戳
	Nonce     string        //随机数
	Echostr   string        //随机字符串
}

//公众号事件推送或者用户发送消息接收
type GzhSubscribeReq struct {
	XMLName      xml.Name      `xml:"xml"`
	ToUserName   string        //开发者微信号
	FromUserName string        //发送方帐号（一个OpenID）
	CreateTime   time.Duration //消息创建时间 （整型）
	MsgType      string        //消息类型，event
	Content      string        //用户发送信息内容
	MsgId        string        //
	Event        string        //事件类型，subscribe(订阅)、unsubscribe(取消订阅)
}

//公众号事件推送或者用户发送消息应答
type GzhSubscribeResp struct {
	XMLName      xml.Name        `xml:"xml"`
	ToUserName   string          `xml:"ToUserName"`   //开发者微信号
	FromUserName string          `xml:"FromUserName"` //发送方帐号（一个OpenID）
	CreateTime   time.Duration   `xml:"CreateTime"`   //消息创建时间 （整型）
	MsgType      string          `xml:"MsgType"`      //消息类型，event
	Content      string          `xml:"Content"`      //
	Image        GzhMsgImageResp `xml:"Image"`        //
}

type GzhMsgImageResp struct {
	MediaId string `xml:"MediaId"` //通过素材管理中的接口上传多媒体文件，得到的id。
}

//接收公众号事件推送消息
func GzhSubscribeHandle(req *GzhSubscribeReq) (err error) {
	//获取公众号用户openid,保存到用户表
	_open_id := req.FromUserName
	//获取unionid
	wx_req := &wxapi.WxUserReq{
		OpenID: _open_id, //"oGstJwADCH1mKugRbeaIYGPSWyRw",
	}
	if !model.CheckGzhOpenID(_open_id) {
		resp := &wxapi.WxUserInfoResp{}
		if resp, err = wxapi.GetWxUserInfo(wx_req); err != nil || resp.OpenID == "" {
			return
		}
		zaplog.Info(resp.UnionID)
		// 将openid和unionid保存到数据库中
		_param := &model.WxUserInfoUnionID{
			Subscribe:      resp.Subscribe,
			OpenID:         resp.OpenID,
			NickName:       resp.NickName,
			Sex:            resp.Sex,
			Language:       resp.Language,
			City:           resp.City,
			Province:       resp.Province,
			Country:        resp.Country,
			HeadImgUrl:     resp.HeadImgUrl,
			SubscribeTime:  resp.SubscribeTime,
			UnionID:        resp.UnionID,
			Remark:         resp.Remark,
			GroupID:        resp.GroupID,
			TragIdList:     resp.TragIdList,
			SubscribeScene: resp.SubscribeScene,
			QrScene:        resp.QrScene,
			QrSceneStr:     resp.QrSceneStr,
		}
		err = model.SaveGzhUserInfo(_param)
	}

	return
}

const (
	//欢迎语
	contentWecome string = "欢迎加入诚物💦\r\n\r\n 1)获取诚物小程序\r\n 2)获取客服微信号\r\n"
	//诚物小程序链接
	contentUrl    string = "<a href=\"http://www.qq.com\" data-miniprogram-appid=\"wxce110d1bd97f0dda\" data-miniprogram-path=\"pages/auth/index?page=/pages/index/index\">点击跳小程序</a>"
	contentWxCode string = "DreamAndHelp1951" //客服微信号
	contentType   string = "application/xml"
)

//被动回复公众号用户消息
func GzhMsgResponse(response *ghttp.Response, requestBody *GzhSubscribeReq) error {
	var _content string
	var _msgType string = "text"
	switch requestBody.Content {
	case "1":
		_content = contentUrl
		// _msgType = "image"
	case "2":
		_content = contentWxCode
	default:
		_content = contentWecome
	}

	bodycontent := GzhSubscribeResp{
		ToUserName:   requestBody.FromUserName,
		FromUserName: requestBody.ToUserName,
		CreateTime:   requestBody.CreateTime,
		MsgType:      _msgType,
		Content:      _content,
		Image:        GzhMsgImageResp{MediaId: _content},
	}
	response.Header().Set("Content-Type", contentType)
	if content_str, err := xml.Marshal(bodycontent); err == nil {
		response.Write(content_str)
		response.Request.Exit()
	} else {
		return err
	}
	return nil
}
