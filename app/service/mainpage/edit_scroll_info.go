package mainpage

import (
	"daigou/app/model"
	"daigou/app/service/personal"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type EditScrollInfoReq struct {
	*model.DbEditScrollInfoIn
}

type EditScrollInfoResp struct {
	ScrollInfo *GetMainPageBaseInfoResp2 `json:"scroll_info"` //滚动信息
}

type NewEditScrollInfoResp struct {
	ScrollInfo *NewGetMainPageBaseInfoResp2 `json:"scroll_info"` //滚动信息
}

func EditScrollInfo(req *EditScrollInfoReq, session *ghttp.Session) (resp *EditScrollInfoResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "编辑失败"
		}
	}()
	if !sessionman.IsShopOwner(session, req.ShopID) {
		return
	}

	if shopvip, err := personal.ShopVipExplain(2, session); shopvip.Explain == 0 && err == nil {
		msg = "您还不是VIP用户，无法进行此操作!"
		return nil, msg, err
	}

	res, err := model.EditScrollInfo(req.DbEditScrollInfoIn)
	if err != nil {
		zaplog.Errorf("EditScrollInfo err=%s", err)
		return
	}

	resp = &EditScrollInfoResp{}
	resp.ScrollInfo, err = getScrollInfo(res.MainpageScrollInfo, session)
	if err != nil {
		zaplog.Errorf("EditScrollInfo err=%s", err)
		return
	}
	return
}

func NewEditScrollInfo(req *EditScrollInfoReq, session *ghttp.Session) (resp *NewEditScrollInfoResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "编辑失败"
		}
	}()
	if !sessionman.IsShopOwner(session, req.ShopID) {
		return
	}

	if shopvip, err := personal.ShopVipExplain(2, session); shopvip.Explain == 0 && err == nil {
		msg = "您还不是VIP用户，无法进行此操作!"
		return nil, msg, err
	}

	res, err := model.EditScrollInfo(req.DbEditScrollInfoIn)
	if err != nil {
		zaplog.Errorf("EditScrollInfo err=%s", err)
		return
	}

	resp = &NewEditScrollInfoResp{}
	resp.ScrollInfo, err = NewgetScrollInfo(res.MainpageScrollInfo, session)
	if err != nil {
		zaplog.Errorf("EditScrollInfo err=%s", err)
		return
	}
	return
}
