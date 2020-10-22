package personal

import (
	"bytes"
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/txcloud"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/gf/util/guid"
	"github.com/medivhzhan/weapp/v2"
)

var (
	smallProgramCodePage  = "pages/auth/index" //小程序码扫描跳转页面
	smallProgramCodeScene = "shopid=%d"
)

//个人信息
func PersonalInformation(session *ghttp.Session) (resp *model.UserInformationShopResp, err error) {
	resp, err = model.PersonalInformation(sessionman.GetUserInfo(session).UserID, sessionman.GetUserInfo(session).Role)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("个人信息:%s", resp)

	return
}

//访问量，关注，粉丝
func PersonalVisitFansShop(session *ghttp.Session) (resp *model.VisitFansShopResp, err error) {
	userInfo := sessionman.GetUserInfo(session)
	resp, err = model.PersonalVisitFansShop(userInfo.UserID, model.UserRoleType(userInfo.Role))
	if err != nil {
		return nil, err
	}
	zaplog.Infof("访问量，关注，粉丝:%s", resp)

	return
}

//今日收益，今日订单
func PersonalTodayinfo(session *ghttp.Session) (resp *model.TodayinfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	//判断userInfo
	userInfo := sessionman.GetUserInfo(session)
	resp, err = model.PersonalTodayinfo(userInfo.ShopID)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("今日收益，今日订单:%s", resp)

	return
}

// UnlimitedQRCode 小程序码参数
type SmallProgramCodeReq struct {
	weapp.UnlimitedQRCode
}

//微信服务器小程序码
type SmallProgramCodeResp struct {
	ProgramCode string `json:"program_code"` //微信服务器返回的小程序码图片链接
}

// 直接请求数据库用户小程序码数据
type DbProgramCodeResp struct {
	ProgramCodeUrl string `json:"program_code_url"` //小程序码图片云链接
}

//微信小程序码
func SmallProgramCode(req *SmallProgramCodeReq, session *gsession.Session) (resp *SmallProgramCodeResp, err error) {
	resp = &SmallProgramCodeResp{}
	req.Page = fmt.Sprintf(smallProgramCodePage)
	zaplog.Infof("微信小程序码扫描跳转 page:%s", req.Page)
	req.Scene = fmt.Sprintf(smallProgramCodeScene, sessionman.GetUserInfo(session).ShopID)
	zaplog.Infof("微信小程序码扫描跳转 scene:%s", req.Scene)
	var imgByte []byte
	imgByte, err = wxapi.GetUnlimited(&req.UnlimitedQRCode)
	if err != nil {
		return resp, err
	}
	// zaplog.Infof("微信小程序码:%s", resp.ProgramCode)
	if resp.ProgramCode, err = DrawWeChatCodeShareImg(imgByte, session); resp.ProgramCode != "" && err == nil {
		err = model.SaveUserSmallWxCode(sessionman.GetUserInfo(session).UserID, resp.ProgramCode)
	}

	return
}

//查询用户或店铺头像
func SeeHeadURL(req *model.SeeHeadURLReq) (resp *model.SeeHeadURLResp, err error) {
	resp, err = model.SeeHeadURL(req)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("查询用户或店铺头像:%s", resp)

	return
}

//数据库获取微信小程序码
func SmallProgramCodeDb(session *gsession.Session) (resp *DbProgramCodeResp, err error) {
	resp = &DbProgramCodeResp{}
	//读取用户头像昵称数据
	resp_userInfo := &model.UserInformationShopResp{}
	resp_userInfo, err = model.PersonalInformation(sessionman.GetUserInfo(session).UserID, sessionman.GetUserInfo(session).Role)
	if err != nil {
		return resp, err
	}
	resp.ProgramCodeUrl = resp_userInfo.SmallWxCode

	return
}

//合并生成微信分享图片码
func DrawWeChatCodeShareImg(ProgramCode []byte, session *gsession.Session) (imgUrl string, err error) {
	imgUrl = ""
	if ProgramCode == nil {
		return imgUrl, errors.New(("小程序码获取为空"))
	}
	//读取用户头像昵称数据
	resp_userInfo := &model.UserInformationShopResp{}
	resp_userInfo, err = model.PersonalInformation(sessionman.GetUserInfo(session).UserID, sessionman.GetUserInfo(session).Role)
	if err != nil {
		return imgUrl, err
	}
	var _avatarImgByte []byte //用户头像
	if resp_Img, err := http.Get(resp_userInfo.AvatarURL); err == nil {
		if _avatarImgByte, err = ioutil.ReadAll(resp_Img.Body); err != nil {
			return imgUrl, err
		}
	}
	//描述语
	//获取店铺名称
	_welcomeMsg := resp_userInfo.ShopName // "扫描我的代购小店，进店选购吧！"
	var _programCodeTemp []byte
	if _programCodeTemp, err = wxapi.DrawWeChatCodeShareImg(ProgramCode, _avatarImgByte, resp_userInfo.NickName, _welcomeMsg); len(_programCodeTemp) == 0 || err != nil {
		return imgUrl, err
	}
	img := bytes.NewReader(_programCodeTemp) //小程序码读对象
	var buf bytes.Buffer
	_userId := sessionman.GetUserInfo(session).UserID
	buf.WriteString(fmt.Sprintf("%d", _userId))
	buf.WriteString("/")
	buf.WriteString(time.Now().Format("20061021504"))
	buf.WriteString("/")
	_imgName := guid.S() //图片名称，随机uid
	buf.WriteString(_imgName)
	buf.WriteString(".jpg")
	_txCound_path := buf.String()

	if err = txcloud.PutObjectImg(&txcloud.PutObjectIn{
		GetCredentialIn: &txcloud.GetCredentialIn{
			Action: []string{
				"name/cos:PutObject",
			},
			Effect:   "allow",
			Resource: []string{"*"},
		},
		Name: _txCound_path,
	}, img); err == nil {
		imgUrl = _txCound_path
	}

	return
}
