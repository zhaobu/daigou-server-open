package wxapi

import (
	"daigou/library/redis"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/gogf/gf/net/ghttp"
	jsoniter "github.com/json-iterator/go"
)

const (
	customerServiceMessageUrl string = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=%s" //发送客服消息给用户
)

type CustomerServiceMessage struct {
	Touser  string    `json:"touser"`  //是	用户的 OpenID
	Msgtype string    `json:"msgtype"` //	是	消息类型text(文本消息)\	image(图片消息)\link(图文链接)\	miniprogrampage(小程序卡片)
	Text    TextInfo  `json:"text"`    //	是	文本消息，msgtype="text" 时必填
	Image   ImageInfo `json:"image"`   //	是	图片消息，msgtype="image" 时必填
	// link            Object    `json:"link"`                   //	是	图文链接，msgtype="link" 时必填
	// miniprogrampage Object    `json:"miniprogrampage"`        //	是	小程序卡片，msgtype="miniprogrampage" 时必填
}
type TextInfo struct {
	Content string `json:"content"` //文本消息内容
}

//使用本文档内的方法PostFormDataFile
type ImageInfo struct {
	MediaId string `json:"media_id"` //发送的图片的媒体ID，通过 新增素材接口 上传图片文件获得
	//已上传的图片ID{"type":"image","media_id":"4f-P3MGdJxJ7jpkdMaWoSG-YA4c3HLFcbr4IimtSfdutgXGsqB8vloSluvnyJFAo","created_at":1596595550,"item":[]}
}

//服务器回复信息到用户的小程序客服上
func CustomerServiceFile(req *CustomerServiceMessage) (err error) {
	//获取token
	token, err := redis.GetAccessToken()
	if err != nil {
		zaplog.Errorf("CustomerServiceText GetAccessToken err=%s", err.Error())
		return
	}
	url := fmt.Sprintf(customerServiceMessageUrl, token)
	zaplog.Infof("customerServiceMessageUrl=%s", url)

	jsonArg, err := jsoniter.Marshal(req)
	if err != nil {
		zaplog.Errorf("SubscribeMessage jsoniter.Marshal err=%s", err.Error())
		return err
	}
	wxRes, err := ghttp.Post(url, jsonArg)
	defer wxRes.Close()
	if err != nil {
		zaplog.Errorf("SubscribeMessage ghttp.Post err=%s", err.Error())
		return err
	}

	//解析微信接口服务返回的参数
	zaplog.Errorf("客服回复用户消息：", string(wxRes.ReadAll()))
	return

}

//用户在小程序客服发送的消息
type CustomerClientMessage struct {
	ToUserName   string        //小程序的原始ID
	FromUserName string        //发送者的openid
	CreateTime   time.Duration //消息创建时间(整型）
	MsgType      string        //text
	Content      string        //文本消息内容
	MsgId        string        //消息id，64位整型
	Encrypt      string        //加密数据
}
