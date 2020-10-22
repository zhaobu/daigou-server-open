package api

import (
	"daigou/app/model"
	"daigou/app/service/mainpage"
	"daigou/library/response"
	"daigou/library/zaplog"
	"fmt"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gutil"
	"github.com/gogf/gf/util/gvalid"
	jsoniter "github.com/json-iterator/go"
)

// 首页API管理对象
type MainPageAction struct{}

// @summary 获取首页基本信息
// @tags    MainPageAction
// @description 用于登录后获取首页基本信息
// @produce json
// @accept  json
// @param   data  body mainpage.GetMainPageBaseInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/getMainPageBaseInfo [GET]
// @success 200 {object} response.JsonResponse{data=mainpage.GetMainPageBaseInfoResp{}} "请求成功"
func (c *MainPageAction) GetMainPageBaseInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetMainPageBaseInfoReq
		resp *mainpage.GetMainPageBaseInfoResp
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
		return
	}

	resp, msg, err = mainpage.GetMainPageBaseInfo(req, r.Session)
	if err != nil {
		err = fmt.Errorf("获取首页基本信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取首页基本信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}

	return
}

// @summary 获取商店信息
// @tags    MainPageAction
// @description 用于登录后获取首页基本信息
// @produce json
// @accept  json
// @param   data  body mainpage.GetMainPageShopInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/getMainPageShopInfo [GET]
// @success 200 {object} response.JsonResponse{data=model.GetMainPageBaseInfoOut1{}} "请求成功"
func (c *MainPageAction) GetMainPageShopInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetMainPageShopInfoReq
		resp *mainpage.GetMainPageShopInfoResp
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
		return
	}

	resp, msg, err = mainpage.GetMainPageShopInfo(req, r.Session)
	if err != nil {
		err = fmt.Errorf("获取首页商店信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取首页商店信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 获取首页分类信息
// @tags    MainPageAction
// @description 用于登录后获取首页基本信息
// @produce json
// @accept  json
// @param   data  body mainpage.GetMainPageBaseInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/getMainPageCategoryInfo [GET]
// @success 200 {object} response.JsonResponse{data=[]mainpage.GetMainPageBaseInfoResp1{}} "请求成功"
func (c *MainPageAction) GetMainPageCategoryInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetMainPageBaseInfoReq
		resp []*mainpage.GetMainPageBaseInfoResp1
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
		return
	}

	resp, msg, err = mainpage.GetMainPageCategoryInfo(req)
	if err != nil {
		err = fmt.Errorf("获取首页分类信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取首页分类信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 获取首页行程滚动信息
// @tags    MainPageAction
// @description 用于登录后获取首页基本信息
// @produce json
// @accept  json
// @param   data  body mainpage.GetMainPageBaseInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/getMainPageScrollInfo [GET]
// @success 200 {object} response.JsonResponse{data=mainpage.GetMainPageBaseInfoResp2{}} "请求成功"
func (c *MainPageAction) GetMainPageScrollInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetMainPageBaseInfoReq
		resp *mainpage.GetMainPageBaseInfoResp2
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
		return
	}

	resp, msg, err = mainpage.GetMainPageScrollInfo(req, r.Session)
	if err != nil {
		err = fmt.Errorf("获取首页行程滚动信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取首页行程滚动信息成功:%+v", resp)
	response.SuccExit(r, resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 获取分页
// @tags    MainPageAction
// @description 首页获取分页接口
// @produce json
// @accept  json
// @param   data  body mainpage.GetPageInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/getPageInfo [Get]
// @success 200 {object} response.JsonResponse{data=mainpage.GetPageInfoResp{}} "请求成功"
func (c *MainPageAction) GetPageInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetPageInfoReq
		resp *mainpage.GetPageInfoResp
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
		return
	}

	resp, msg, err = mainpage.GetPageInfo(req, r.Session)
	if err != nil {
		err = fmt.Errorf("获取分页信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取分页信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}

	return
}

// @summary 新增商品
// @tags    MainPageAction
// @description 首页新增商品接口
// @produce json
// @accept  json
// @param   data body mainpage.AddGoodsTypeReq true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/addGoodsType [POST]
// @success 200 {object} response.JsonResponse{data=mainpage.AddGoodsTypeResp{}} "请求成功"
func (c *MainPageAction) AddGoodsType(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.AddGoodsTypeReq
		resp *mainpage.AddGoodsTypeResp
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
		return
	}

	resp, msg, err = mainpage.AddGoodsType(req, r.Session)
	if err != nil {
		zaplog.Errorf("新增商品失败 err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("新增商品成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 编辑商品
// @tags    MainPageAction
// @description 编辑商品
// @produce json
// @accept  json
// @param   data  body mainpage.EditGoodsTypeReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/editGoods [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *MainPageAction) EditGoods(r *ghttp.Request) {
	//检查请求参数
	var (
		req *mainpage.EditGoodsTypeReq
		err error
		msg string
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

	msg, err = mainpage.EditGoods(req, r.Session)
	if err != nil {
		zaplog.Errorf("编辑商品失败 err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("编辑商品成功:%+v", nil)
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 单指令操作商品
// @tags    MainPageAction
// @description 操作商品,指令：0无指令，1上架，2下架，3删除，4置顶
// @produce json
// @accept  json
// @param   data  body mainpage.SingleCmdEditGoodsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/singleCmdEditGoods [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *MainPageAction) SingleCmdEditGoods(r *ghttp.Request) {
	//检查请求参数
	var (
		req *mainpage.SingleCmdEditGoodsReq
		err error
		msg string
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

	msg, err = mainpage.SingleCmdEditGoods(req, r.Session)
	if err != nil {
		zaplog.Errorf("单指令操作商品失败 err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("单指令操作商品成功:%+v", nil)
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查看指定商品详细信息
// @tags    MainPageAction
// @description 查看指定商品详细信息，便于买家查看或者店主编辑修改商品
// @produce json
// @accept  json
// @param   data  body mainpage.LookUpGoodsDetailReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/lookUpGoodsDetail [Get]
// @success 200 {object} response.JsonResponse{data=model.DbLookUpGoodsDetailReps{}} "请求成功"
func (c *MainPageAction) LookUpGoodsDetail(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.LookUpGoodsDetailReq
		resp *model.DbLookUpGoodsDetailReps
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
		return
	}

	resp, msg, err = mainpage.LookUpGoodsDetail(req, r.Session)
	if err != nil {
		zaplog.Errorf("查看指定商品详细信息失败 err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("查看指定商品详细信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 搜索商品
// @tags    MainPageAction
// @description 根据商品名称搜索
// @produce json
// @accept  json
// @param   data  body mainpage.SearchGoodsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/search [Get]
// @success 200 {object} response.JsonResponse{data=mainpage.SearchGoodsReps{}} "请求成功"
func (c *MainPageAction) Search(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.SearchGoodsReq
		resp *mainpage.SearchGoodsReps
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
		return
	}

	resp, msg, err = mainpage.Search(req, r.Session)
	if err != nil {
		zaplog.Errorf("搜索商品失败 err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	zaplog.Debugf("搜索商品成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查看分类配置信息
// @tags    MainPageAction
// @description 分类配置信息接口
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/mainPage/checkCfgClassify [GET]
// @success 200 {object} response.JsonResponse{data=mainpage.CheckCfgClassifyResp{}} "请求成功"
func (c *MainPageAction) CheckCfgClassify(r *ghttp.Request) {
	//检查请求参数
	var (
		resp *mainpage.CheckCfgClassifyResp
		err  error
		msg  string
	)

	resp, msg, err = mainpage.CheckCfgClassify(r.Session)
	if err != nil {
		zaplog.Errorf("查看分类配置信息失败 %v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("查看分类配置信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 编辑分类
// @tags    MainPageAction
// @description 首页编辑分类接口
// @produce json
// @accept  json
// @param   data  body mainpage.EditClassifyReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/editClassify [POST]
// @success 200 {object} response.JsonResponse{data=mainpage.EditClassifyResp{}} "请求成功"
func (c *MainPageAction) EditClassify(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.EditClassifyReq
		resp *mainpage.EditClassifyResp
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
		return
	}

	resp, msg, err = mainpage.EditClassify(req, r.Session)
	if err != nil {
		zaplog.Errorf("编辑分类失败 %v", err)
		response.ErrorExit(r, err.Error())
	}

	zaplog.Debugf("编辑分类成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 编辑滚动信息
// @tags    MainPageAction
// @description 首页编辑滚动信息
// @produce json
// @accept  json
// @param   data  body mainpage.EditScrollInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/editScrollInfo [POST]
// @success 200 {object} response.JsonResponse{data=mainpage.EditScrollInfoResp{}} "请求成功"
func (c *MainPageAction) EditScrollInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.EditScrollInfoReq
		resp *mainpage.EditScrollInfoResp
		err  error
		msg  string
	)

	//解析参数
	if err = jsoniter.Unmarshal(r.GetBody(), &req); err != nil {
		zaplog.Errorf("EditScrollInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	//验证参数
	if errStr := gvalid.CheckStruct(req, ""); errStr != nil {
		zaplog.Errorf("EditScrollInfo err:%v", errStr.FirstString())
		response.FailExit(r, errStr.FirstString())
	}

	zaplog.Debugf("EditScrollInfo req=%+v", req)
	resp, msg, err = mainpage.EditScrollInfo(req, r.Session)
	if err != nil {
		zaplog.Infof("EditScrollInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	zaplog.Debugf("EditScrollInfo success:%v", gutil.Export(resp))
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 获取首页行程滚动信息（新）
// @tags    MainPageAction
// @description 用于登录后获取首页基本信息
// @produce json
// @accept  json
// @param   data  body mainpage.GetMainPageBaseInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/newGetMainPageScrollInfo [GET]
// @success 200 {object} response.JsonResponse{data=mainpage.NewGetMainPageBaseInfoResp2{}} "请求成功"
func (c *MainPageAction) NewGetMainPageScrollInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.GetMainPageBaseInfoReq
		resp *mainpage.NewGetMainPageBaseInfoResp2
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
		return
	}
	resp, msg, err = mainpage.NewGetMainPageScrollInfo(req, r.Session)

	if err != nil {
		err = fmt.Errorf("获取首页行程滚动信息失败 err:%v", err)
		zaplog.Errorf(err.Error())
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("获取首页行程滚动信息成功:%+v", resp)
	response.SuccExit(r, resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 编辑滚动信息（新）
// @tags    MainPageAction
// @description 首页编辑滚动信息
// @produce json
// @accept  json
// @param   data  body mainpage.EditScrollInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/newEditScrollInfo [POST]
// @success 200 {object} response.JsonResponse{data=mainpage.NewEditScrollInfoResp{}} "请求成功"
func (c *MainPageAction) NewEditScrollInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *mainpage.EditScrollInfoReq
		resp *mainpage.NewEditScrollInfoResp
		err  error
		msg  string
	)

	//解析参数
	if err = jsoniter.Unmarshal(r.GetBody(), &req); err != nil {
		zaplog.Errorf("EditScrollInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	//验证参数
	if errStr := gvalid.CheckStruct(req, ""); errStr != nil {
		zaplog.Errorf("EditScrollInfo err:%v", errStr.FirstString())
		response.FailExit(r, errStr.FirstString())
	}

	zaplog.Debugf("EditScrollInfo req=%+v", req)
	resp, msg, err = mainpage.NewEditScrollInfo(req, r.Session)
	if err != nil {
		zaplog.Infof("EditScrollInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}

	zaplog.Debugf("EditScrollInfo success:%v", gutil.Export(resp))
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查看分类
// @tags    MainPageAction
// @description 分类配置信息接口
// @produce json
// @accept  json
// @param   data  body model.CategorySeeReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/categorySee [GET]
// @success 200 {object} response.JsonResponse{data=mainpage.CategoryInfoSee{}} "请求成功"
func (c *MainPageAction) CategorySee(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CategorySeeReq
		resp *mainpage.CategoryInfoSee
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
		return
	}
	resp, msg, err = mainpage.CategorySee(req, r.Session)
	if err != nil {
		zaplog.Errorf("查看分类信息失败 %v", err)
		response.ErrorExit(r, err.Error())
	}

	// r.Cookie.Remove()
	zaplog.Debugf("查看分类信息成功:%+v", resp)
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 增加分类
// @tags    MainPageAction
// @description 首页编辑分类接口
// @produce json
// @accept  json
// @param   data  body model.CategoryIncreaseReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/categoryIncrease [POST]
// @success 200 {object} response.JsonResponse{} "请求成功"
func (c *MainPageAction) CategoryIncrease(r *ghttp.Request) {
	//检查请求参数
	var (
		req *model.CategoryIncreaseReq
		err error
		msg string
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

	msg, err = mainpage.CategoryIncrease(req, r.Session)
	if err != nil {
		zaplog.Errorf("增加分类失败 %v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 编辑分类
// @tags    MainPageAction
// @description 首页编辑分类接口
// @produce json
// @accept  json
// @param   data  body model.CategoryUpdateReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/categoryUpdate [POST]
// @success 200 {object} response.JsonResponse{} "请求成功"
func (c *MainPageAction) CategoryUpdate(r *ghttp.Request) {
	//检查请求参数
	var (
		req *model.CategoryUpdateReq
		err error
		msg string
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

	msg, err = mainpage.CategoryUpdate(req, r.Session)
	if err != nil {
		zaplog.Errorf("编辑分类失败 %v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 删除分类
// @tags    MainPageAction
// @description 首页编辑分类接口
// @produce json
// @accept  json
// @param   data  body model.CategoryDeleteReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/categoryDelete [POST]
// @success 200 {object} response.JsonResponse{data=model.CategoryDeleteResp{}} "请求成功"
func (c *MainPageAction) CategoryDelete(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CategoryDeleteReq
		resp *model.CategoryDeleteResp
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
		return
	}

	resp, msg, err = mainpage.CategoryDelete(req, r.Session)
	if err != nil {
		zaplog.Errorf("删除分类失败 %v", err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 分类排序
// @tags    MainPageAction
// @description 首页编辑分类接口
// @produce json
// @accept  json
// @param   data  body model.CategoryUpdateReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/mainPage/categorySort [POST]
// @success 200 {object} response.JsonResponse{} "请求成功"
func (c *MainPageAction) CategorySort(r *ghttp.Request) {
	//检查请求参数
	var (
		req *model.CategorySortReq
		err error
		msg string
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

	msg, err = mainpage.CategorySort(req, r.Session)
	if err != nil {
		zaplog.Errorf("分类排序失败 %v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}
