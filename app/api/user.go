package api

import (
	"daigou/app/service/user"
	"daigou/library/response"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

// 用户API管理对象
type UserAction struct{}

// @summary 微信登录获取token
// @tags    UserAction
// @description 使用服务器调用微信的auth.code2Session接口,获取token
// @produce json
// @accept  json
// @param   data  body user.WxGetTokenReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/wxGetToken [POST]
// @success 200 {object} response.JsonResponse{data=user.WxGetTokenResp{}} "请求成功"
func WxGetToken(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.WxGetTokenReq
		resp *user.WxGetTokenResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.WxGetToken(req, r.Session)
	if err != nil {
		zaplog.Infof("user.WxGetToken err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.WxGetToken success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 游客登录
// @tags    UserAction
// @description code验证通过后,验证更新用户信息
// @produce json
// @accept  json
// @param   data  body user.TestUserLoginReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/testUserLogin [POST]
// @success 200 {object} response.JsonResponse{data=user.TestUserLoginResp{}} "请求成功"
func TestUserLogin(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.TestUserLoginReq
		resp *user.TestUserLoginResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.TestUserLogin(req, r.Session)
	if err != nil {
		zaplog.Infof("user.TestUserLogin err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.TestUserLogin success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 微信登录
// @tags    UserAction
// @description code验证通过后,验证更新用户信息
// @produce json
// @accept  json
// @param   data  body user.WxLoginReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/wxLogin [POST]
// @success 200 {object} response.JsonResponse{data=user.WxLoginResp{}} "请求成功"
func (c *UserAction) WxLogin(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.WxLoginReq
		resp *user.WxLoginResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.WxLogin(req, r.Session)
	if err != nil {
		zaplog.Infof("user.WxLogin err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.WxLogin success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 带token微信登录
// @tags    UserAction
// @description 用于小程序切换后台后,token未过期时重新登录
// @produce json
// @accept  json
// @param   data  body user.WxLoginWithTokenReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/wxLoginWithSession  [POST]
// @success 200 {object} response.JsonResponse{data=user.WxLoginResp} "请求成功"
func WxLoginWithSession(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.WxLoginWithTokenReq
		resp *user.WxLoginResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.WxLoginWithSession(req, r.Session)
	if err != nil {
		zaplog.Infof("user.WxLoginWithSession err:%s", err)
		response.ExpiredExit(r)
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.WxLoginWithSession success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 微信绑定手机号
// @tags    UserAction
// @description 微信绑定手机号
// @produce json
// @accept  json
// @param   data  body user.WxBindPhoneNumberReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/wxBindPhoneNumber  [POST]
// @success 200 {object} response.JsonResponse{data=user.WxBindPhoneNumberResp} "请求成功"
func (c *UserAction) WxBindPhoneNumber(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.WxBindPhoneNumberReq
		resp *user.WxBindPhoneNumberResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.WxBindPhoneNumber(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.WxBindPhoneNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.WxBindPhoneNumber success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 验证码绑定手机号
// @tags    UserAction
// @description 验证码绑定手机号
// @produce json
// @accept  json
// @param   data  body user.SmsBindPhoneNumberReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/smsBindPhoneNumber  [POST]
// @success 200 {object} response.JsonResponse{data=user.SmsBindPhoneNumberResp} "请求成功"
func (c *UserAction) SmsBindPhoneNumber(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.SmsBindPhoneNumberReq
		resp *user.SmsBindPhoneNumberResp
		err  error
		msg  string
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, msg, err = user.SmsBindPhoneNumber(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SmsBindPhoneNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	if resp.Code == 0 {
		zaplog.Infof("user.SmsBindPhoneNumber success. resp:%+v,msg:%s", resp, msg)
		response.SuccExitMsg(r, msg, resp)
	} else {
		zaplog.Infof("user.SmsBindPhoneNumber fail. resp:%+v,msg:%s", resp, msg)
		response.FailExitData(r, msg, resp)
	}
}

// @summary 发送验证码
// @tags    UserAction
// @description 发送验证码,用来绑定手机号
// @produce json
// @accept  json
// @param   data  body user.SendSmsCodeReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/sendSmsCode  [POST]
// @success 200 {object} response.JsonResponse{data=user.SendSmsCodeResp} "请求成功"
func (c *UserAction) SendSmsCode(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.SendSmsCodeReq
		resp *user.SendSmsCodeResp
		err  error
		msg  string
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	//判断该手机号是否已经绑定
	isbind, s, err := user.IsbindPhoneNumber(req.PhoneNumber)
	if err != nil {
		zaplog.Errorf("user.IsbindPhoneNumber err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	if isbind.IsBind == 1 {
		zaplog.Errorf("user.IsbindPhoneNumber err:%s", err)
		response.FailExit(r, s)
	}

	resp, msg, err = user.SendSmsCode(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.SendSmsCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	if resp.Code == 0 {
		zaplog.Infof("user.SendSmsCode success. resp:%+v,msg:%s", resp, msg)
		response.SuccExitMsg(r, msg, resp)
	} else {
		zaplog.Infof("user.SendSmsCode fail. resp:%+v,msg:%s", resp, msg)
		response.FailExitData(r, msg, resp)
	}
}

// @summary 获取推荐店铺
// @tags    UserAction
// @description 新用户注册后,获取推荐店铺
// @produce json
// @accept  json
// @param   data  body user.GetRecommendShopReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/getRecommendShop  [GET]
// @success 200 {object} response.JsonResponse{data=user.GetRecommendShopResp} "请求成功"
func (c *UserAction) GetRecommendShop(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.GetRecommendShopReq
		resp []*user.GetRecommendShopResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.GetRecommendShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.GetRecommendShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.GetRecommendShop success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 新用户绑定商铺
// @tags    UserAction
// @description 新用户注册后,绑定推荐的店铺
// @produce json
// @accept  json
// @param   data  body user.BindShopReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/bindShop  [POST]
// @success 200 {object} response.JsonResponse{data=user.BindShopResp} "请求成功"
func (c *UserAction) BindShop(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.BindShopReq
		resp *user.BindShopResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.BindShop(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.BindShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.BindShop success:%+v", resp)
	response.SuccExit(r, resp)
}

// @summary 使用店铺码
// @tags    UserAction
// @description 新用户注册后,使用店铺码开通自己的店铺
// @produce json
// @accept  json
// @param   data  body user.UseShopCodeReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/useShopCode  [POST]
// @success 200 {object} response.JsonResponse{data=user.UseShopCodeResp} "请求成功"
func (c *UserAction) UseShopCode(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.UseShopCodeReq
		resp *user.UseShopCodeResp
		err  error
		msg  string
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, msg, err = user.UseShopCode(req, r.Session)

	if err != nil {
		zaplog.Errorf("user.UseShopCode err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	if resp.Code == 0 {
		zaplog.Infof("user.UseShopCode success. resp:%+v,msg:%s", resp, msg)
		response.SuccExitMsg(r, msg, resp)
	} else {
		zaplog.Infof("user.UseShopCode fail. resp:%+v,msg:%s", resp, msg)
		response.FailExitData(r, msg, resp)
	}
}

// @summary 用户成为商铺客户
// @tags    UserAction
// @description 新用户注册后,成为商铺客户
// @produce json
// @accept  json
// @param   data  body user.BindCustomerReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/bindCustomer [POST]
// @success 200 {object} response.JsonResponse{data=user.BindCustomerResp} "请求成功"
func (c *UserAction) BindCustomer(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.BindCustomerReq
		resp *user.BindCustomerResp
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
	}

	resp, msg, err = user.BindCustomer(req, r.Session)
	if err != nil {
		zaplog.Errorf("user.BindShop err:%s", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.ErrorExit(r, msg)
	}
}

// @summary 微信登录（不需要验证）
// @tags    UserAction
// @description
// @produce json
// @accept  json
// @param   data  body user.WxLoginNotSignReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/user/wxLoginNotSign [POST]
// @success 200 {object} response.JsonResponse{data=user.WxLoginResp{}} "请求成功"
func (c *UserAction) WxLoginNotSign(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *user.WxLoginNotSignReq
		resp *user.WxLoginResp
		err  error
	)

	if err = r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
	}

	resp, err = user.WxLoginNotSign(req, r.Session)
	if err != nil {
		zaplog.Infof("user.WxLoginNotSign err:%s", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Infof("user.WxLoginNotSign success:%+v", resp)
	response.SuccExit(r, resp)
}
