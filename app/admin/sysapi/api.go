package sysapi

import (
	"daigou/app/admin/sysapi/sysreq"
	"daigou/app/admin/sysapi/sysresp"
	"daigou/app/admin/sysservice"
	"daigou/library/redis"
	"daigou/library/response"
	"daigou/library/utils"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

//管理后台调用接口
type AdminAction struct{}

// @summary admin获取店铺码
// @tags    管理后台调用接口
// @description 管理后台获取店铺码
// @produce json
// @accept  json
// @param   data  body sysreq.GetShopCodeReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/admin/getShopCode  [POST]
// @success 200 {object} response.JsonResponse{data=sysresp.GetShopCodeResp} "请求成功"
func (c *AdminAction) GetShopCode(r *ghttp.Request) {
	//检查请求参数
	var (
		req  sysreq.GetShopCodeReq
		resp *sysresp.GetShopCodeResp
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
	zaplog.Debugf("GetShopCode req:%s", utils.Dump(req))

	out, err := redis.GenShopCode(req.GenShopCodeIn)
	if err != nil {
		zaplog.Errorf("GetShopCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	resp = &sysresp.GetShopCodeResp{GenShopCodeOut: out}
	zaplog.Infof("GetShopCode success:%+v", utils.Dump(resp))
	response.SuccExit(r, resp)
}

// @summary admin使用店铺码
// @tags    管理后台使用店铺码
// @description 管理后台使用店铺码
// @produce json
// @accept  json
// @param   data  body user.UseShopCodeReq true "需要传入的参数"
// @router  /daigou/api/v{version}/admin/useShopCode  [POST]
// @success 200 {object} response.JsonResponse{data=user.UseShopCodeResp} "请求成功"
func (c *AdminAction) UseShopCode(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *sysreq.UseShopCodeReq
		resp *sysresp.UseShopCodeResp
	)

	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}
	zaplog.Debugf("UseShopCode req:%s", utils.Dump(req))

	resp, err := sysservice.UseShopCode(req)

	if err != nil {
		zaplog.Errorf("UseShopCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	zaplog.Infof("UseShopCode success:%+v", utils.Dump(resp))
	response.SuccExit(r, resp)
}
