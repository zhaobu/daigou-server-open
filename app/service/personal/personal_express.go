package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SeeExpressInfo struct {
	ExpressCount int `json:"all_count"`
	Express      []*model.SeeExpressResp
}

//查看默认快递设置
func SeeDefaultExpress(req *model.SeeDefaultExpressReq) (resp *model.SeeDefaultExpressResp, err error) {
	resp, err = model.SeeDefaultExpress(req)
	if err != nil {
		zaplog.Infof("查看默认快递设置失败:%v", err)
		return nil, err
	}

	return
}

//查看快递设置
func SeeExpress(req *model.SeeExpressReq, session *ghttp.Session) (resp *SeeExpressInfo, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	setup, err := model.SeeExpress(req, sessionman.GetUserInfo(session).ShopID)
	express := make([]*model.SeeExpressResp, 0)
	express = append(express, setup...)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("查看快递设置:%s", setup)
	resp = &SeeExpressInfo{
		ExpressCount: len(setup),
		Express:      express,
	}

	return
}

//增加快递设置
func IncreaseExpress(req *model.IncreaseExpressReq, session *ghttp.Session) (resp *model.IncreaseExpressResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.IncreaseExpress(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, err
	}
	return
}

//修改快递设置
func ModifyExpress(req *model.ModifyExpressReq, session *ghttp.Session) (resp *model.ModifyExpressResp, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.ModifyExpress(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, err
	}
	return
}

//删除快递
func DeleteExpress(req *model.DeleteExpressReq) (resp *model.DeleteExpressResp, err error) {
	resp, err = model.DeleteExpress(req)
	if err != nil {
		return nil, err
	}
	return
}

type ExpressCompany struct {
	ExpressCount   int                         `json:"all_count"`
	ExpressCompany []*model.ExpressCompanyResp `json:"express_cmpany"`
}

//快递公司
func PersonalExpressCompany(session *ghttp.Session) (resp *ExpressCompany, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	expresscompany, err := model.PersonalExpressCompany(sessionman.GetUserInfo(session).ShopID)
	express := make([]*model.ExpressCompanyResp, 0)
	express = append(express, expresscompany...)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("快递公司:%s", resp)
	resp = &ExpressCompany{
		ExpressCount:   len(expresscompany),
		ExpressCompany: express,
	}
	return
}
