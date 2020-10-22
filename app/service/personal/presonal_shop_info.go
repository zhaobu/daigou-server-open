package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

//查看店铺信息
func SeeShopInfo(session *ghttp.Session) (resp *model.SeeShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.SeeShopInfo(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看店铺信息:%s", resp)
	return
}

//修改店铺信息
func ModifyShopInfo(req *model.ModifyShopInfoReq, session *ghttp.Session) (resp *model.ModifyShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	shopinfo, err := SeeShopInfo(session)
	if err != nil {
		return nil, err
	}
	if req.ShopName == "" {
		req.ShopName = shopinfo.ShopName
	}
	resp, err = model.ModifyShopInfo(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	if req.ShopName != shopinfo.ShopName {
		programcode := &SmallProgramCodeReq{}
		programcode.Width = 400
		smallprogramcode, err := SmallProgramCode(programcode, session)
		if err != nil {
			zaplog.Infof("修改名称时修改小程序码:%v", smallprogramcode)
			return nil, err
		}
	}
	return
}

//修改店铺名称
func ModifyShopInfoName(req *model.ModifyShopInfoReq, session *ghttp.Session) (resp *model.ModifyShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	shopinfo, err := SeeShopInfo(session)
	if err != nil {
		return nil, err
	}
	if req.ShopName == "" {
		req.ShopName = shopinfo.ShopName
	}
	resp, err = model.ModifyShopInfoName(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	if req.ShopName != shopinfo.ShopName {
		programcode := &SmallProgramCodeReq{}
		programcode.Width = 400
		smallprogramcode, err := SmallProgramCode(programcode, session)
		if err != nil {
			zaplog.Infof("修改名称时修改小程序码:%v", smallprogramcode)
			return nil, err
		}
	}
	return
}

//修改店铺头像
func ModifyShopInfoUrl(req *model.ModifyShopInfoReq, session *ghttp.Session) (resp *model.ModifyShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	shopinfo, err := SeeShopInfo(session)
	if err != nil {
		return nil, err
	}
	if req.ShopUrl == "" {
		req.ShopUrl = shopinfo.ShopUrl
	}
	resp, err = model.ModifyShopInfoUrl(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	return
}

//修改店铺简绍
func ModifyShopInfoDescription(req *model.ModifyShopInfoReq, session *ghttp.Session) (resp *model.ModifyShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.ModifyShopInfoDescription(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	return
}

//修改微信号
func ModifyShopInfoWechatNumber(req *model.ModifyShopInfoReq, session *ghttp.Session) (resp *model.ModifyShopInfoResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.ModifyShopInfoWechatNumber(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	return
}

//编辑图片水印
func ShopWatermark(req *model.ShopWatermarkReq, session *ghttp.Session) (msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != 0 && sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return "无权限操作", nil
	}
	if err = model.ShopWatermarkModel(req, sessionman.GetUserInfo(session).ShopID); err != nil {
		return "", err
	}
	return
}
