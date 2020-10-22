package api

import (
	"daigou/app/model"
	"daigou/app/service/house"
	"daigou/library/response"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/gvalid"
)

// @summary 查询搜索我的客户
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerSeeReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=[]model.CustomerSeeResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerSee [post]
func (c *HouseAction) CustomerSee(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerSeeReq
		resp []*model.CustomerSeeResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerSee(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerSee param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查询我的客户信息
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerInfoSeeReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=model.CustomerInfoSeeResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerInfoSee [post]
func (c *HouseAction) CustomerInfoSee(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerInfoSeeReq
		resp *model.CustomerInfoSeeResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerInfoSee(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerSee param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 添加我的客户
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerIncreaseReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=model.CustomerIncreaseResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerIncrease [post]
func (c *HouseAction) CustomerIncrease(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerIncreaseReq
		resp *model.CustomerIncreaseResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerIncrease(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerIncrease param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 修改我的客户
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerUpdateReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=model.CustomerUpdateResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerUpdate [post]
func (c *HouseAction) CustomerUpdate(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerUpdateReq
		resp *model.CustomerUpdateResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerUpdate(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerUpdate param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 删除我的客户
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerDeleteReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=model.CustomerDeleteResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerDelete [post]
func (c *HouseAction) CustomerDelete(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerDeleteReq
		resp *model.CustomerDeleteResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerDelete(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerDelete param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 手动绑定客户与平台用户
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerBindingReq true "传入参数"
// @success 0 {object} response.JsonResponse{} "执行结果"
// @router  /daigou/api/v{version}/house/customerBinding [post]
func (c *HouseAction) CustomerBinding(r *ghttp.Request) {
	//检查请求参数
	var (
		req *model.CustomerBindingReq
		msg string
		err error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.CustomerBinding(req, r.Session)
	if err != nil {
		zaplog.Infof("CustomerBinding param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 客户统计
// @description HouseAction
// @tags    我的客户
// @Accept  json
// @Produce  json
// @param   data body model.CustomerStatisticsReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=model.CustomerStatisticsResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/customerStatistics [post]
func (c *HouseAction) CustomerStatistics(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CustomerStatisticsReq
		resp *model.CustomerStatisticsResp
		msg  string
		err  error
	)
	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CustomerStatistics(r.Session)
	if err != nil {
		zaplog.Infof("CustomerStatistics param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查看全部或默认地址
// @description HouseAction
// @tags    我的客户
// @produce json
// @accept  json
// @param   data  body model.AddressSeeReq true "需要传入的参数"
// @router  /daigou/api/v{version}/house/addressSee [POST]
// @success 200 {object} response.JsonResponse{data=[]model.AddressSeeResp} "执行结果"
func (c *HouseAction) AddressSee(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.AddressSeeReq
		resp []*model.AddressSeeResp
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

	resp, err = house.AddressSee(req, r.Session)
	if err != nil {
		zaplog.Errorf("AddressSee err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}

// @summary 新增地址
// @description HouseAction
// @tags    我的客户
// @produce json
// @accept  json
// @param   data  body model.AddressIncreaseReq true "需要传入的参数"
// @router  /daigou/api/v{version}/house/addressIncrease [POST]
// @success 200 {object} response.JsonResponse{data=model.AddressIncreaseResp} "执行结果"
func (c *HouseAction) AddressIncrease(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.AddressIncreaseReq
		resp *model.AddressIncreaseResp
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

	resp, msg, err = house.AddressIncrease(req, r.Session)
	if err != nil {
		zaplog.Errorf("AddressIncrease err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg != "" {
		response.FailExit(r, msg)
	}
	response.SuccExit(r, resp)

	return
}

// @summary 修改地址
// @description HouseAction
// @tags    我的客户
// @produce json
// @accept  json
// @param   data  body model.AddressUpdateReq true "需要传入的参数"
// @router  /daigou/api/v{version}/house/addressUpdate [POST]
// @success 200 {object} response.JsonResponse{data=model.AddressUpdateResp} "执行结果"
func (c *HouseAction) AddressUpdate(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.AddressIncreaseReq
		resp *model.AddressUpdateResp
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

	resp, msg, err = house.AddressUpdate(req, r.Session)
	if err != nil {
		zaplog.Errorf("AddressUpdate err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg != "" {
		response.FailExit(r, msg)
	}

	response.SuccExit(r, resp)

	return
}

// @summary 删除地址
// @description HouseAction
// @tags    我的客户
// @produce json
// @accept  json
// @param   data  body model.AddressDeleteReq true "需要传入的参数"
// @router  /daigou/api/v{version}/house/addressDelete [POST]
// @success 200 {object} response.JsonResponse{data=model.AddressDeleteResp} "执行结果"
func (c *HouseAction) AddressDelete(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.AddressDeleteReq
		resp *model.AddressDeleteResp
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

	resp, err = house.AddressDelete(req)
	if err != nil {
		zaplog.Errorf("AddressDelete err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	response.SuccExit(r, resp)

	return
}
