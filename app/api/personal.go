package api

import (
	"daigou/app/model"
	"daigou/app/service/personal"
	"daigou/app/service/user"
	"daigou/app/service/user/sessionman"
	"daigou/library/redis"
	"daigou/library/response"
	"daigou/library/wxapi"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

// 我的API管理对象
type PersonalAction struct{}

// @summary 查看名下粉丝
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeFansReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeFans [POST]
// @success 200 {object} response.JsonResponse{data=personal.SeeFansInfo} "执行结果" "执行结果"
func (c *PersonalAction) SeeFans(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeFansReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeeFans(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeFans err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 搜索名下粉丝
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SearchFansReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/searchFans [POST]
// @success 200 {object} response.JsonResponse{data=personal.SearchFansInfo} "执行结果" "执行结果"
func (c *PersonalAction) SearchFans(r *ghttp.Request) {
	//检查请求参数
	var req *model.SearchFansReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SearchFans(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SearchFans err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看关注的店铺
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeFollowShopReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeFollowShop [POST]
// @success 200 {object} response.JsonResponse{data=personal.SeeFollowShopInfo}  "执行结果"
func (c *PersonalAction) SeeFollowShop(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeFollowShopReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	resp, err := personal.SeeFollowShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeFollowShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
	return
}

// @summary 搜索关注的店铺
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SearchFollowShopReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/searchFollowShop [POST]
// @success 200 {object} response.JsonResponse{data=personal.SearchFollowShopInfo}  "执行结果"
func (c *PersonalAction) SearchFollowShop(r *ghttp.Request) {
	//检查请求参数
	var req *model.SearchFollowShopReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	resp, err := personal.SearchFollowShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SearchFollowShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
	return
}

// @summary 增加关注的店铺
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.IncreaseFollowShopReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/increaseFollowShop [POST]
// @success 200 {object} response.JsonResponse{data=model.IncreaseFollowShopResp}  "执行结果"
func (c *PersonalAction) IncreaseFollowShop(r *ghttp.Request) {
	//检查请求参数
	var req *model.IncreaseFollowShopReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	resp, err := personal.IncreaseFollowShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.IncreaseFollowShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
	return
}

// @summary 取消关注的店铺
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.DeleteFollowShopReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/deleteFollowShop [POST]
// @success 200 {object} response.JsonResponse{data=model.DeleteFollowShopResp}  "执行结果"
func (c *PersonalAction) DeleteFollowShop(r *ghttp.Request) {
	//检查请求参数
	var req *model.DeleteFollowShopReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	resp, err := personal.DeleteFollowShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.DeleteFollowShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	response.SuccExit(r, resp)
	return
}

// @summary 查看用户默认地址设置
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/seeDefaultAddress [POST]
// @success 200 {object} response.JsonResponse{data=personal.UserDefaultAdress} "执行结果"
func (c *PersonalAction) SeeDefaultAddress(r *ghttp.Request) {

	resp, err := personal.SeeDefaultAddress(r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeDefaultAddress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看地址
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeAddressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeAddress [POST]
// @success 200 {object} response.JsonResponse{data=personal.SeeAddressInfo} "执行结果"
func (c *PersonalAction) SeeAddress(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeAddressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeeAddress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeAddress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 新增地址
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.IncreaseAddressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/increaseAddress [POST]
// @success 200 {object} response.JsonResponse{data=model.IncreaseAddressResp} "执行结果"
func (c *PersonalAction) IncreaseAddress(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.IncreaseAddressReq
		resp *model.IncreaseAddressResp
		msg  string
		err  error
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, msg, err = personal.IncreaseAddress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.IncreaseAddress err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg != "" {
		response.FailExit(r, msg)
	}
	response.SuccExit(r, resp)

	return
}

// @summary 修改地址
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyAddressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyAddress [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyAddressResp} "执行结果"
func (c *PersonalAction) ModifyAddress(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.IncreaseAddressReq
		resp *model.ModifyAddressResp
		msg  string
		err  error
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, msg, err = personal.ModifyAddress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.ModifyAddress err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg != "" {
		response.FailExit(r, msg)
	}

	response.SuccExit(r, resp)

	return
}

// @summary 删除地址
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.DeleteAddressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/deleteAddress [POST]
// @success 200 {object} response.JsonResponse{data=model.DeleteAddressResp} "执行结果"
func (c *PersonalAction) DeleteAddress(r *ghttp.Request) {
	//检查请求参数
	var req *model.DeleteAddressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.DeleteAddress(req)
	if err != nil {
		zaplog.Errorf("user.DeleteAddress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看店铺信息
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/seeShopInfo [POST]
// @success 200 {object} response.JsonResponse{data=model.SeeShopInfoResp} "执行结果"
func (c *PersonalAction) SeeShopInfo(r *ghttp.Request) {

	resp, err := personal.SeeShopInfo(r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeShopInfo err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改店铺信息
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyShopInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyShopInfo [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyShopInfoResp} "执行结果"
func (c *PersonalAction) ModifyShopInfo(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyShopInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyShopInfo(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalshopInfo err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看商铺默认快递设置
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeDefaultExpressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeDefaultExpress [POST]
// @success 200 {object} response.JsonResponse{data=model.SeeDefaultExpressResp} "执行结果"
func (c *PersonalAction) SeeDefaultExpress(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeDefaultExpressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.0
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	resp, err := personal.SeeDefaultExpress(req)
	if err != nil {
		zaplog.Errorf("SeeDefaultExpress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看快递设置
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeExpressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeExpress [POST]
// @success 200 {object} response.JsonResponse{data=personal.SeeExpressInfo} "执行结果"
func (c *PersonalAction) SeeExpress(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeExpressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeeExpress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeExpress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 增加快递设置
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.IncreaseExpressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/increaseExpress [POST]
// @success 200 {object} response.JsonResponse{data=model.IncreaseExpressResp} "执行结果"
func (c *PersonalAction) IncreaseExpress(r *ghttp.Request) {
	//检查请求参数
	var req *model.IncreaseExpressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.IncreaseExpress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.IncreaseExpress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改快递设置
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyExpressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyExpress [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyExpressResp} "执行结果"
func (c *PersonalAction) ModifyExpress(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyExpressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyExpress(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.ModifyExpress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 删除快递
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.DeleteExpressReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/deleteExpress [POST]
// @success 200 {object} response.JsonResponse{data=model.DeleteExpressResp} "执行结果"
func (c *PersonalAction) DeleteExpress(r *ghttp.Request) {
	//检查请求参数
	var req *model.DeleteExpressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.DeleteExpress(req)
	if err != nil {
		zaplog.Errorf("user.DeleteExpress err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 快递公司
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/personalExpressCompany [POST]
// @success 200 {object} response.JsonResponse{data=personal.ExpressCompany} "执行结果"
func (c *PersonalAction) PersonalExpressCompany(r *ghttp.Request) {

	resp, err := personal.PersonalExpressCompany(r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalExpressCompany err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 今日收益，今日订单
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/personalTodayinfo [POST]
// @success 200 {object} response.JsonResponse{data=model.TodayinfoResp} "执行结果"
func (c *PersonalAction) PersonalTodayinfo(r *ghttp.Request) {

	resp, err := personal.PersonalTodayinfo(r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalTodayinfo err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 我的钱包
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/personalWallet [POST]
// @success 200 {object} response.JsonResponse{data=model.ShopWalletResp} "执行结果"
func (c *PersonalAction) PersonalWallet(r *ghttp.Request) {

	resp, err := personal.PersonalWallet(r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalWallet err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 收支明细
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.OrderStreamReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/personalOrderStream [POST]
// @success 200 {object} response.JsonResponse{data=personal.OrderStream} "执行结果"
func (c *PersonalAction) PersonalOrderStream(r *ghttp.Request) {
	//检查请求参数
	var (
		req   *model.OrderStreamReq
		resp  *personal.OrderStream
		isvip uint8
		err   error
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, isvip, err = personal.PersonalOrderStream(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalOrderStream err:%s", err)
		if isvip == 1 {
			response.FailExit(r, err.Error())
		} else {
			response.ErrorExit(r, err.Error())
		}
	}

	response.SuccExit(r, resp)

	return
}

// @summary 搜索收支明细
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.OrderStreamReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/searchOrderStream [POST]
// @success 200 {object} response.JsonResponse{data=personal.OrderStream} "执行结果"
func (c *PersonalAction) SearchOrderStream(r *ghttp.Request) {
	//检查请求参数
	var req *model.OrderStreamReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, isvip, err := personal.SearchOrderStream(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SearchOrderStream err:%s", err)
		if isvip == 1 {
			response.FailExit(r, err.Error())
		} else {
			response.ErrorExit(r, err.Error())
		}
	}

	response.SuccExit(r, resp)

	return
}

// @summary 访问量，关注，粉丝
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/personalVisitFansShop [POST]
// @success 200 {object} response.JsonResponse{data=model.VisitFansShopResp} "执行结果"
func (c *PersonalAction) PersonalVisitFansShop(r *ghttp.Request) {

	resp, err := personal.PersonalVisitFansShop(r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalVisitFansShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 我的个人信息
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/personalInformation [POST]
// @success 200 {object} response.JsonResponse{data=model.UserInformationShopResp} "执行结果"
func (c *PersonalAction) PersonalInformation(r *ghttp.Request) {

	resp, err := personal.PersonalInformation(r.Session)
	if err != nil {
		zaplog.Errorf("user.PersonalInformation err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看会员界面
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/seeMember [POST]
// @success 200 {object} response.JsonResponse{data=model.SeeMemberResp} "执行结果"
func (c *PersonalAction) SeeMember(r *ghttp.Request) {

	resp, err := personal.SeeMember(r.Session)
	if err != nil {
		zaplog.Errorf("user.SeeMember err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 开通会员
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.Membership true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/openMembership [POST]
// @success 200 {object} response.JsonResponse{data=wxapi.UnifyOrderResp} "执行结果"
func (c *PersonalAction) OpenMembership(r *ghttp.Request) {
	//检查请求参数
	var (
		req   *model.Membership
		resp  *wxapi.UnifyOrderResp
		isvip uint8
		err   error
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, isvip, err = personal.OpenMembership(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.OpenMembership err:%s", err)
		if isvip == 1 {
			response.FailExit(r, err.Error())
		} else {
			response.ErrorExit(r, err.Error())
		}
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看绑定手机号
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/seePhoneNumber [POST]
// @success 200 {object} response.JsonResponse{data=model.SeePhoneNumberResp} "执行结果"
func (c *PersonalAction) SeePhoneNumber(r *ghttp.Request) {

	resp, err := personal.SeePhoneNumber(r.Session)
	if err != nil {
		zaplog.Errorf("user.SeePhoneNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改绑定手机号
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body user.SmsBindPhoneNumberReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyPhoneNumber  [POST]
// @success 200 {object} response.JsonResponse{data=user.SmsBindPhoneNumberResp} "请求成功"
func (c *PersonalAction) ModifyPhoneNumber(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.SmsBindPhoneNumberReq
		resp *user.SmsBindPhoneNumberResp
		err  error
		msg  string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, msg, err = user.SmsBindPhoneNumber(req, r.Session)
	if err != nil {
		zaplog.Errorf("ModifyPhoneNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("ModifyPhoneNumber success:%+v", resp)

	if resp.Code == 0 {
		response.SuccExitMsg(r, msg, resp)
	} else {
		response.FailExitData(r, msg, resp)
	}

	return
}

// @summary 查看隐私政策
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeePrivacyPolicyReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seePrivacyPolicy [POST]
// @success 200 {object} response.JsonResponse{data=model.SeePrivacyPolicyResp} "执行结果"
func (c *PersonalAction) SeePrivacyPolicy(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeePrivacyPolicyReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeePrivacyPolicy(req)
	if err != nil {
		zaplog.Errorf("user.SeePrivacyPolicy err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查看用户服务协议
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeServiceAgreementReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeServiceAgreement [POST]
// @success 200 {object} response.JsonResponse{data=model.SeeServiceAgreementResp} "执行结果"
func (c *PersonalAction) SeeServiceAgreement(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeServiceAgreementReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeeServiceAgreement(req)
	if err != nil {
		zaplog.Errorf("user.SeeServiceAgreement err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 微信小程序码
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   scene  formData string  true "scene"
// @param   Page  formData string  false "主页"
// @param   width formData int  false "二维码的宽度"
// @param   auto_color formData bool  false "自动配置线条颜色"
// @param   line_color formData int  false "uto_color 为 false 时生效，使用 rgb 设置颜色（line_color是结构体）"
// @param   r formData string  false "line_color的参数"
// @param   g formData string  false "line_color的参数"
// @param   b formData string  false "line_color的参数"
// @param   is_hyaline formData bool  false "是否需要透明底色"
// @router  /daigou/api/v{version}/personal/smallProgramCode [POST]
// @success 200 {object} response.JsonResponse{data=personal.SmallProgramCodeReq} "执行结果"
func (c *PersonalAction) SmallProgramCode(r *ghttp.Request) {
	//检查请求参数
	var req *personal.SmallProgramCodeReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	if sessionman.GetUserInfo(r.Session).ShopID == 0 {
		//非店主不能生成店铺小程序码
		return
	}
	resp, err := personal.SmallProgramCode(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SmallProgramCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	r.Response.Header().Set("Content-Type", "multipart/form-data")
	r.Response.WriteExit(response.JsonResponse{
		Code: response.SUCCESS,
		Msg:  "success",
		Data: resp,
	})
	return
}

// @summary 数据库获取微信小程序码
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/smallProgramCodeDb [POST]
// @success 200 {object} response.JsonResponse{data=personal.SmallProgramCodeResp} "执行结果"
func (c *PersonalAction) SmallProgramCodeDb(r *ghttp.Request) {
	resp, err := personal.SmallProgramCodeDb(r.Session)
	if err != nil {
		zaplog.Errorf("user.SmallProgramCodeDb err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	r.Response.Header().Set("Content-Type", "multipart/form-data")
	r.Response.WriteExit(response.JsonResponse{
		Code: response.SUCCESS,
		Msg:  "success",
		Data: resp,
	})
	return
}

// @summary 访问信息
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.VisitInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/visitInfo [POST]
// @success 200 {object} response.JsonResponse{data=personal.Visitinfo} "执行结果"
func (c *PersonalAction) VisitInfo(r *ghttp.Request) {
	//检查请求参数
	var req *model.VisitInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.VisitInfo(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.VisitInfo err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 访问历史（用户）
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.VisitHistoryReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/visitHistory [POST]
// @success 200 {object} response.JsonResponse{data=personal.Visithistory} "执行结果"
func (c *PersonalAction) VisitHistory(r *ghttp.Request) {
	//检查请求参数
	var req *model.VisitHistoryReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.VisitHistory(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.VisitHistory err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 货币列表
// @tags    PersonalAction
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/currencies [POST]
// @success 200 {object} response.JsonResponse{data=redis.RedisGetCurrenciesOut} "执行结果"
func (c *PersonalAction) Currencies(r *ghttp.Request) {

	resp, err := redis.GetSystemConfigValue("exchange_rate_list")
	if err != nil {
		zaplog.Errorf("user.VisitHistory err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 汇率查询换算
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body redis.GetExchangeRateIn true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/exchangeRate [POST]
// @success 200 {object} response.JsonResponse{data=redis.GetExchangeRateOut} "执行结果"
func (c *PersonalAction) ExchangeRate(r *ghttp.Request) {
	//检查请求参数
	var req *redis.GetExchangeRateIn
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := redis.GetExchangeRate(req)
	if err != nil {
		zaplog.Errorf("user.VisitHistory err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 获取推广码
// @tags    PersonalAction
// @description 新用户注册后,获取推荐店铺
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/personal/getShopCode [GET]
// @success 200 {object} response.JsonResponse{data=personal.GetShopCodeResp} "请求成功"
func (c *PersonalAction) GetShopCode(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *personal.GetShopCodeReq
		resp *personal.GetShopCodeResp
		err  error
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = personal.GetShopCode(req, r.Session)
	if err != nil {
		zaplog.Errorf("GetShopCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	zaplog.Infof("GetShopCode success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 查询用户或店铺头像
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.SeeHeadURLReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/seeHeadURL [POST]
// @success 200 {object} response.JsonResponse{data=model.SeeHeadURLResp} "执行结果"
func (c *PersonalAction) SeeHeadURL(r *ghttp.Request) {
	//检查请求参数
	var req *model.SeeHeadURLReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.SeeHeadURL(req)
	if err != nil {
		zaplog.Errorf("user.SeeHeadURL err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 查询用户VIP充值记录
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.VipRechargeRecordsReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/vipRechargeRecords [POST]
// @success 200 {object} response.JsonResponse{data=model.VipRechargeRecordsResp} "执行结果"
func (c *PersonalAction) VipRechargeRecords(r *ghttp.Request) {
	//检查请求参数
	var req *model.VipRechargeRecordsReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.VipRechargeRecords(req, r.Session)
	if err != nil {
		zaplog.Errorf("VipRechargeRecords err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改店铺名称
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyShopInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyShopInfoName [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyShopInfoResp} "执行结果"
func (c *PersonalAction) ModifyShopInfoName(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyShopInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyShopInfoName(req, r.Session)
	if err != nil {
		zaplog.Errorf("ModifyShopInfoName err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改店铺头像
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyShopInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyShopInfoUrl [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyShopInfoResp} "执行结果"
func (c *PersonalAction) ModifyShopInfoUrl(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyShopInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyShopInfoUrl(req, r.Session)
	if err != nil {
		zaplog.Errorf("ModifyShopInfoUrl err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改店铺简绍
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyShopInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyShopInfoDescription [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyShopInfoResp} "执行结果"
func (c *PersonalAction) ModifyShopInfoDescription(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyShopInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyShopInfoDescription(req, r.Session)
	if err != nil {
		zaplog.Errorf("ModifyShopInfoDescription err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 修改微信号
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ModifyShopInfoReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/modifyShopInfoWechatNumber [POST]
// @success 200 {object} response.JsonResponse{data=model.ModifyShopInfoResp} "执行结果"
func (c *PersonalAction) ModifyShopInfoWechatNumber(r *ghttp.Request) {
	//检查请求参数
	var req *model.ModifyShopInfoReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err := personal.ModifyShopInfoWechatNumber(req, r.Session)
	if err != nil {
		zaplog.Errorf("ModifyShopInfoWechatNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 编辑图片水印配置
// @tags    PersonalAction
// @produce json
// @accept  json
// @param   data  body model.ShopWatermarkReq true "需要传入的参数"
// @router  /daigou/api/v{version}/personal/shopWatermark [POST]
// @success 200 {object} response.JsonResponse{} "执行结果"
func (c *PersonalAction) ShopWatermark(r *ghttp.Request) {
	//检查请求参数
	var req *model.ShopWatermarkReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	msg, err := personal.ShopWatermark(req, r.Session)
	if err != nil {
		zaplog.Errorf("ShopWatermark err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}

	return
}
