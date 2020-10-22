package house

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"

	"github.com/gogf/gf/net/ghttp"
)

//查询搜索我的客户
func CustomerSee(req *model.CustomerSeeReq, session *ghttp.Session) (resp []*model.CustomerSeeResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.CustomerSee(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, "查询失败", nil
	}
	return
}

//查询搜索我的客户
func CustomerInfoSee(req *model.CustomerInfoSeeReq, session *ghttp.Session) (resp *model.CustomerInfoSeeResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.CustomerInfoSee(req)
	if err != nil {
		return resp, "查询失败", nil
	}
	return
}

//添加我的客户
func CustomerIncrease(req *model.CustomerIncreaseReq, session *ghttp.Session) (resp *model.CustomerIncreaseResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	if model.IsNameIncrease(req, sessionman.GetUserInfo(session).ShopID) {
		msg = "该客户名称已经添加，请勿重复添加!"
		return
	}
	resp, msg, err = model.CustomerIncrease(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, msg, nil
	}
	return
}

//修改我的客户
func CustomerUpdate(req *model.CustomerUpdateReq, session *ghttp.Session) (resp *model.CustomerUpdateResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.CustomerUpdate(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, "修改失败", nil
	}
	return
}

//删除我的客户
func CustomerDelete(req *model.CustomerDeleteReq, session *ghttp.Session) (resp *model.CustomerDeleteResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	if !model.IsCustomerOrders(req) {
		msg = "有存在订单未完成，不能删除客户"
		return
	}
	resp, err = model.CustomerDelete(req)
	if err != nil {
		return resp, "删除失败", nil
	}
	return
}

//手动绑定客户与平台用户
func CustomerBinding(req *model.CustomerBindingReq, session *ghttp.Session) (msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	if !model.IsCustomerBinding(&model.CustomerBindingReq{CustomerID: req.CustomerID}) {
		msg = "该客户已经绑定用户，不能重复绑定"
		return
	}
	if !model.IsFansBinding(req, sessionman.GetUserInfo(session).ShopID) {
		msg = "该用户不是你名下粉丝!"
		return
	}
	if model.IsUserBinding(req, sessionman.GetUserInfo(session).ShopID) {
		msg = "该用户已经绑定在您名下其他客户上，请勿重复绑定!"
		return
	}
	if req.CrUserid != uint32(sessionman.GetUserInfo(session).ShopID) {
		err = model.CustomerBinding(req, sessionman.GetUserInfo(session).ShopID, "")
		if err != nil {
			return "", nil
		}
	} else {
		msg = "您不能把自己绑定成自己的客户!"
		return
	}
	return
}

//客户统计
func CustomerStatistics(session *ghttp.Session) (resp *model.CustomerStatisticsResp, msg string, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	resp, err = model.CustomerStatistics(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, "查询失败", nil
	}
	return
}
