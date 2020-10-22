package customer

import (
	"daigou/library/redis"
	"daigou/library/wxapi"
)

//服务器返回微信小程序客服用户对话消息
func CustomerServiceHandle(req *wxapi.CustomerClientMessage) {
	if req.Content == "11" {
		_media_id, err := redis.GetMediaInfo()
		//解析微信接口服务返回的参数
		if err != nil || _media_id == "" {
			return
		}
		wxapi.CustomerServiceFile(&wxapi.CustomerServiceMessage{
			Touser: req.FromUserName,
			// Msgtype: "text",
			// Text: wxapi.TextInfo{
			// 	Content: "欢迎加入诚物<img src=\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/qrcode_for_gh_679b8303fff9_258.jpg\"  alt=\"欢迎加入诚物\" />",
			// 	//"欢迎加入诚物,<a href=\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/qrcode_for_gh_679b8303fff9_258.jpg\">点击获取</a>", //
			// },
			Msgtype: "image",
			Image: wxapi.ImageInfo{
				MediaId: _media_id,
			},
		})
	}
}
