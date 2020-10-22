package redis

import (
	"bytes"
	"context"
	"daigou/library/zaplog"
	"fmt"
	"io"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
	"time"

	jsoniter "github.com/json-iterator/go"
)

const (
	uploadImagePath    string = "../bin/qrcode_for_gh_679b8303fff9.jpg"                                  //上传的公众号二维码图片路径
	uploadTempMediaUrl string = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=%s&type=%s" //把媒体文件上传到微信服务器。目前仅支持图片
)

//模拟客户端POST表单功能文件上传应答消息
type UpdateFormDataFile struct {
	//{"type":"image","media_id":"4f-P3MGdJxJ7jpkdMaWoSG-YA4c3HLFcbr4IimtSfdutgXGsqB8vloSluvnyJFAo","created_at":1596595550,"item":[]}
	Type      string        `json:"type"`       //文件类型
	MediaId   string        `json:"media_id"`   //媒体文件上传后，获取标识，3天内有效。
	CreatedAt time.Duration `json:"created_at"` //	媒体文件上传时间戳
	Item      []string      `json:"item"`       //发送的图片的媒体ID，通过 新增素材接口 上传图片文件获得
}

//模拟客户端POST表单功能文件上传到微信服务器
func PostFormDataFile(filename string) (mediaId string, err error) {
	bodyBuf := &bytes.Buffer{}
	bodyWriter := multipart.NewWriter(bodyBuf)

	//关键的一步操作
	fileWriter, err := bodyWriter.CreateFormFile("uploadfile", filename)
	if err != nil {
		fmt.Println("error writing to buffer")
		return "", err
	}

	//打开文件句柄操作
	fh, err := os.Open(filename)
	if err != nil {
		fmt.Println("error opening file")
		return "", err
	}
	defer fh.Close()

	//iocopy
	_, err = io.Copy(fileWriter, fh)
	if err != nil {
		return "", err
	}

	contentType := bodyWriter.FormDataContentType()
	bodyWriter.Close()
	// //获取token
	// res_token := &weapp.TokenResponse{}
	// res_token, err = weapp.GetAccessToken("wxce110d1bd97f0dda", "4f62c52120fd73393e77cf1568040537")
	// token := res_token.AccessToken //redis.GetAccessToken()
	//获取token
	token, err := GetAccessToken()
	if err != nil {
		zaplog.Errorf("PostFormDataFile GetAccessToken err=%s", err.Error())
		return "", err
	}

	targetUrl := fmt.Sprintf(uploadTempMediaUrl, token, "image")
	resp, err := http.Post(targetUrl, contentType, bodyBuf)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	resp_body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}
	//解析微信接口服务返回的参数
	res := &UpdateFormDataFile{}
	err = jsoniter.Unmarshal(resp_body, &res)
	if err != nil {
		zaplog.Errorf("PostFormDataFile jsoniter.Unmarshal err=%s", err.Error())
		return "", err
	}
	fmt.Println(resp.Status)
	fmt.Println(string(resp_body))
	return res.MediaId, nil
}

//获取微信接口模拟客户端POST表单功能文件上传返回的mediaid等json数据
func GetMediaInfo() (mediaId string, err error) {
	//优先从redis中获取
	conn := cache.Conn(context.Background())
	defer conn.Close()
	mediaId, err = conn.Get(context.Background(), Cache_Str_WxTemp_Media).Result()
	if err == nil && mediaId != "" {
		return
	}

	mediaId, err = PostFormDataFile(uploadImagePath) //上传的公众号二维码图片路径
	if err != nil || mediaId == "" {
		// 处理一般错误信息
		zaplog.Errorf("GetMediaInfo err:%s", err)
		return
	}
	//缓存到redis中
	//过期时间 3天内
	_expiresIn := time.Duration(3*20*3600) * time.Second
	res1, err1 := conn.Set(context.Background(), Cache_Str_WxTemp_Media, mediaId, _expiresIn).Result()
	if err1 != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("GetMediaInfo res1:%+v", res1)
		return "", err1
	}
	return mediaId, nil
}
