package api

import (
	"daigou/app/model"
	"daigou/app/service/house"
	"daigou/library/response"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gvalid"
)

// 仓库管理对象
type HouseAction struct{}

// @summary 商品库入库添加
// @tags    HouseAction
// @description 商家入库
// @produce json
// @accept  json
// @param   data  body house.CreateHouseReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/createHouse  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *HouseAction) CreateHouse(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.CreateHouseReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.CreateHouse(req, r.Session)
	if err != nil {
		zaplog.Infof("CreateHouse err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库编辑
// @tags    HouseAction
// @description 编辑商品库
// @produce json
// @accept  json
// @param   data  body house.EditHouseReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/editHouse  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *HouseAction) EditHouse(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.EditHouseReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.EditHouse(req, r.Session)
	if err != nil {
		zaplog.Infof("EditHouse err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库修改库存
// @tags    HouseAction
// @description 修改库存数量
// @produce json
// @accept  json
// @param   data  body house.HouseNumReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/modHouseNum  [POST]
// @success 200 {object} response.JsonResponse "请求成功"
func (c *HouseAction) ModHouseNum(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.HouseNumReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.ModHouseNum(req, r.Session)
	if err != nil {
		zaplog.Infof("ModHouseNum err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库查看库存详情
// @tags    HouseAction
// @description 查看库存详情
// @produce json
// @accept  json
// @param   data  body house.GetHouseDetailReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getHouseDetail  [POST]
// @success 0 {object} response.JsonResponse{data=house.GetHouseDetailResp{}} "执行结果"
func (c *HouseAction) GetHouseDetail(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.GetHouseDetailReq
		resp *house.GetHouseDetailResp
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
		return
	}
	resp, msg, err = house.GetHouseDetail(req, r.Session)
	if err != nil {
		zaplog.Infof("GetHouseDetail err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库查看库存简易详情
// @tags    HouseAction
// @description 查看库存简易详情
// @produce json
// @accept  json
// @param   data  body house.GetHouseEasyReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getHouseEasy  [POST]
// @success 0 {object} response.JsonResponse{data=house.GetHouseEasyResp{}} "执行结果"
func (c *HouseAction) GetHouseEasy(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.GetHouseEasyReq
		resp *house.GetHouseEasyResp
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
		return
	}
	resp, msg, err = house.GetHouseEasy(req, r.Session)
	if err != nil {
		zaplog.Infof("GetHouseEasy err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库库存记录列表详情
// @tags    HouseAction
// @description 库存记录列表详情
// @produce json
// @accept  json
// @param   data  body house.GetHouseStockRecordReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getHouseStockRecord  [POST]
// @success 0 {object} response.JsonResponse{data=house.GetHouseStockRecordResp{}} "执行结果"
func (c *HouseAction) GetHouseStockRecord(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.GetHouseStockRecordReq
		resp *house.GetHouseStockRecordResp
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
		return
	}
	resp, msg, err = house.GetHouseStockRecord(req, r.Session)
	if err != nil {
		zaplog.Infof("GetHouseStockRecord err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库查看库存商品列表（包含搜索功能）
// @tags    HouseAction
// @description 查看库存列表
// @produce json
// @accept  json
// @param   data  body house.GetHouseListReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getHouseList  [POST]
// @success 0 {object} response.JsonResponse{data=house.GetHouseListResp{}} "执行结果"
func (c *HouseAction) GetHouseList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.GetHouseListReq
		resp *house.GetHouseListResp
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
		return
	}
	resp, msg, err = house.GetHouseList(req, r.Session)
	if err != nil {
		zaplog.Infof("GetHouseList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库进货
// @tags    HouseAction
// @description 进货
// @produce json
// @accept  json
// @param   data  body house.InputHouseGoodsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/inputHouseGoods  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) InputHouseGoods(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.InputHouseGoodsReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.InputHouseGoods(req, r.Session)
	if err != nil {
		zaplog.Infof("InputHouseGoods err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库删除
// @tags    HouseAction
// @description 删除商品库
// @produce json
// @accept  json
// @param   data  body house.DelHouseReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/delHouse  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) DelHouse(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.DelHouseReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.DelHouse(req, r.Session)
	if err != nil {
		zaplog.Infof("DelHouse err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品库操作下架
// @tags    HouseAction
// @description 商品下架
// @produce json
// @accept  json
// @param   data  body house.DownGoodsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/downGoods  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) DownGoods(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.DownGoodsReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.DownGoods(req, r.Session)
	if err != nil {
		zaplog.Infof("DownGoods err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单添加
// @tags    HouseAction
// @description 添加
// @produce json
// @accept  json
// @param   data  body house.CreatePreorderReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/createPreorder  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) CreatePreorder(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.CreatePreorderReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.CreatePreorder(req, r.Session)
	if err != nil {
		zaplog.Infof("CreatePreorder err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单搜索已存在对象名称
// @tags    HouseAction
// @description 对象名称（标签名称和用户名称和商品名称）
// @produce json
// @accept  json
// @param   data  body house.SearchObjectNameReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/searchPreorderObjectName  [POST]
// @success 0 {object} response.JsonResponse{data=house.SearchObjectNameResp{}} "执行结果"
func (c *HouseAction) SearchPreorderObjectName(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.SearchObjectNameReq
		err  error
		msg  string
		resp *house.SearchObjectNameResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.SearchPreorderObjectName(req, r.Session)
	if err != nil {
		zaplog.Infof("SearchPreorderObjectName err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单派单
// @tags    HouseAction
// @description 预购商品派单
// @produce json
// @accept  json
// @param   data  body house.PreorderTaskReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/preorderTask  [POST]
// @success 0 {object} response.JsonResponse{data=house.PreorderTaskResp{}} "执行结果"
func (c *HouseAction) PreorderTask(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.PreorderTaskReq
		err  error
		msg  string
		resp *house.PreorderTaskResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.PreorderTask(req, r.Session)
	if err != nil {
		zaplog.Infof("PreorderTask err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单买到
// @tags    HouseAction
// @description 买到
// @produce json
// @accept  json
// @param   data  body house.PreorderBuyDataReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/preorderBuy  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) PreorderBuy(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.PreorderBuyDataReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.PreorderBuy(req, r.Session)
	if err != nil {
		zaplog.Infof("PreorderBuy err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单标签修改
// @tags    HouseAction
// @description 标签修改
// @produce json
// @accept  json
// @param   data  body house.ModPreorderTagReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/modPreorderTag  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) ModPreorderTag(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.ModPreorderTagReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.ModPreorderTag(req, r.Session)
	if err != nil {
		zaplog.Infof("ModPreorderTag err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单买家核单查看
// @tags    HouseAction
// @description 核单查看
// @produce json
// @accept  json
// @param   data  body house.PreorderCheckBillReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/preorderCheckBill  [POST]
// @success 0 {object} response.JsonResponse{data=house.PreorderCheckBillResp{}} "执行结果"
func (c *HouseAction) PreorderCheckBill(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.PreorderCheckBillReq
		err  error
		msg  string
		resp *house.PreorderCheckBillResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.PreorderCheckBill(req, r.Session)
	if err != nil {
		zaplog.Infof("PreorderCheckBill err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary  商家查看清单个数
// @description  商家查看清单个数 展示预购清单和付款发货界面
// @tags    HouseAction
// @Accept  json
// @Produce  json
// @success 0 {object} response.JsonResponse{data=house.CheckPreorderGoodsCountResp{}} "执行结果"
// @router  /daigou/api/v{version}/house/checkPreorderGoodsCount [POST]
func (c *HouseAction) CheckPreorderGoodsCount(r *ghttp.Request) {
	//检查请求参数
	var (
		resp *house.CheckPreorderGoodsCountResp
		msg  string
		err  error
	)

	resp, msg, err = house.CheckPreorderGoodsCount(r.Session)
	if err != nil {
		zaplog.Infof("CheckPreorderGoodsCount err:%v", err)
		response.ErrorExit(r, err.Error())
		return
	}

	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 商家查看清单列表
// @tags    HouseAction
// @description 预购清单和付款发货界面列表
// @produce json
// @accept  json
// @param   data  body house.PreorderGoodsListReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/preorderGoodsList  [POST]
// @success 0 {object} response.JsonResponse{data=house.PreorderGoodsListResp{}} "执行结果"
func (c *HouseAction) PreorderGoodsList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.PreorderGoodsListReq
		err  error
		msg  string
		resp *house.PreorderGoodsListResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.PreorderGoodsList(req, r.Session)
	if err != nil {
		zaplog.Infof("PreorderGoodsList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家搜索清单列表
// @tags    HouseAction
// @description 预购清单和付款发货界面列表
// @produce json
// @accept  json
// @param   data  body house.SearchGoodsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/searchGoodsList  [POST]
// @success 0 {object} response.JsonResponse{data=house.SearchGoodsResp{}} "执行结果"
func (c *HouseAction) SearchGoodsList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.SearchGoodsReq
		err  error
		msg  string
		resp *house.SearchGoodsResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.SearchGoodsList(req, r.Session)
	if err != nil {
		zaplog.Infof("SearchGoodsList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家查看单个商品所属买家列表
// @tags    HouseAction
// @description 单个商品
// @produce json
// @accept  json
// @param   data  body house.SingleGoodsListReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/singleGoodsList  [POST]
// @success 0 {object} response.JsonResponse{data=house.SingleGoodsListResp{}} "执行结果"
func (c *HouseAction) SingleGoodsList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.SingleGoodsListReq
		err  error
		msg  string
		resp *house.SingleGoodsListResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.SingleGoodsList(req, r.Session)
	if err != nil {
		zaplog.Infof("SingleGoodsList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家查看订单支付管理详情 （预购清单）
// @tags    HouseAction
// @description 支付管理详情
// @produce json
// @accept  json
// @param   data  body house.PreorderPayInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getPreorderPayInfo  [POST]
// @success 0 {object} response.JsonResponse{data=house.PreorderPayInfoResp{}} "执行结果"
func (c *HouseAction) GetPreorderPayInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.PreorderPayInfoReq
		err  error
		msg  string
		resp *house.PreorderPayInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.GetPreorderPayInfo(req, r.Session)
	if err != nil {
		zaplog.Infof("GetPreorderPayInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家查看订单支付管理详情
// @tags    HouseAction
// @description 支付管理详情
// @produce json
// @accept  json
// @param   data  body house.UserOrdersPayInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getUserOrdersPayInfo  [POST]
// @success 0 {object} response.JsonResponse{data=house.UserOrdersPayInfoResp{}} "执行结果"
func (c *HouseAction) GetUserOrdersPayInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.UserOrdersPayInfoReq
		err  error
		msg  string
		resp *house.UserOrdersPayInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.GetUserOrdersPayInfo(req, r.Session)
	if err != nil {
		zaplog.Infof("GetUserOrdersPayInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家查看支付管理界面物流信息
// @tags    HouseAction
// @description 物流信息
// @produce json
// @accept  json
// @param   data  body house.PayRecivceInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getPayRecivceInfo  [POST]
// @success 0 {object} response.JsonResponse{data=house.PayRecivceInfoResp{}} "执行结果"
func (c *HouseAction) GetPayRecivceInfo(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.PayRecivceInfoReq
		err  error
		msg  string
		resp *house.PayRecivceInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.GetPayRecivceInfo(req, r.Session)
	if err != nil {
		zaplog.Infof("GetPayRecivceInfo err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 单个编辑清单
// @tags    HouseAction
// @description 编辑单条商品记录
// @produce json
// @accept  json
// @param   data  body house.EditSingleOrderReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/editSingleValue  [POST]
// @success 0 {object} response.JsonResponse{data=house.EditOrderResp{}} "执行结果"
func (c *HouseAction) EditSingleValue(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.EditSingleOrderReq
		err  error
		msg  string
		resp *house.EditOrderResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.EditSingleValue(req, r.Session)
	if err != nil {
		zaplog.Infof("EditSingleValue err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 批量编辑清单
// @tags    HouseAction
// @description 批量商品记录
// @produce json
// @accept  json
// @param   data  body house.EditBatchOrderReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/editBatchValue  [POST]
// @success 0 {object} response.JsonResponse{data=house.EditOrderResp{}} "执行结果"
func (c *HouseAction) EditBatchValue(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.EditBatchOrderReq
		err  error
		msg  string
		resp *house.EditOrderResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.EditBatchValue(req, r.Session)
	if err != nil {
		zaplog.Infof("editBatchValue err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 编辑邮费属性
// @tags    HouseAction
// @description 单个属性操作
// @produce json
// @accept  json
// @param   data  body house.EditPostageReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/editPostage  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) EditPostage(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.EditPostageReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.EditPostage(req, r.Session)
	if err != nil {
		zaplog.Infof("EditPostage err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 订单数据详情查看
// @tags    HouseAction
// @description 详情查看
// @produce json
// @accept  json
// @param   data  body house.OrderRecordDetailReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/getOrderRecordDetail  [POST]
// @success 0 {object} response.JsonResponse{data=house.OrderRecordDetailResp{}} "执行结果"
func (c *HouseAction) GetOrderRecordDetail(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.OrderRecordDetailReq
		err  error
		msg  string
		resp *house.OrderRecordDetailResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.GetOrderRecordDetail(req, r.Session)
	if err != nil {
		zaplog.Infof("GetOrderRecordDetail err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家订单发货信息查看
// @tags    HouseAction
// @description 发货信息
// @produce json
// @accept  json
// @param   data  body house.DeliverInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/deliverInfoList  [POST]
// @success 0 {object} response.JsonResponse{data=house.DeliverInfoResp{}} "执行结果"
func (c *HouseAction) DeliverInfoList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.DeliverInfoReq
		err  error
		msg  string
		resp *house.DeliverInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.DeliverInfoList(req, r.Session)
	if err != nil {
		zaplog.Infof("DeliverInfoList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家订单已发货信息查看
// @tags    HouseAction
// @description 已发货信息
// @produce json
// @accept  json
// @param   data  body house.CompleteDeliverInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/completeDeliverInfoList  [POST]
// @success 0 {object} response.JsonResponse{data=house.CompleteDeliverInfoResp{}} "执行结果"
func (c *HouseAction) CompleteDeliverInfoList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.CompleteDeliverInfoReq
		err  error
		msg  string
		resp *house.CompleteDeliverInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CompleteDeliverInfoList(req, r.Session)
	if err != nil {
		zaplog.Infof("CompleteDeliverInfoList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商家指定订单商品已发货信息查看
// @tags    HouseAction
// @description 已发货信息
// @produce json
// @accept  json
// @param   data  body house.SingleCompleteDeliverInfoReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/singleCompleteDeliverInfoList  [POST]
// @success 0 {object} response.JsonResponse{data=house.SingleCompleteDeliverInfoResp{}} "执行结果"
func (c *HouseAction) SingleCompleteDeliverInfoList(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *house.SingleCompleteDeliverInfoReq
		err  error
		msg  string
		resp *house.SingleCompleteDeliverInfoResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.SingleCompleteDeliverInfoList(req, r.Session)
	if err != nil {
		zaplog.Infof("SingleCompleteDeliverInfoList err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 同步商品旧数据到商品库中
// @tags    HouseAction
// @description 详情查看
// @produce json
// @accept  json
// @router  /daigou/api/v{version}/house/synchronizationGoods  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func SynchronizationGoods(r *ghttp.Request) {
	//检查请求参数
	var (
		err error
		msg string
	)

	msg, err = house.SynchronizationGoods()
	if err != nil {
		zaplog.Infof("SynchronizationGoods err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 商品记录统计
// @tags    HouseAction
// @description 商品信息
// @produce json
// @accept  json
// @param   data  body model.CommodityRecordsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/commodityRecords  [POST]
// @success 0 {object} response.JsonResponse{data=model.CommodityRecordsResp{}} "执行结果"
func (c *HouseAction) CommodityRecords(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CommodityRecordsReq
		err  error
		msg  string
		resp *model.CommodityRecordsResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CommodityRecords(req, r.Session)
	if err != nil {
		zaplog.Infof("CommodityRecords err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 订单统计
// @tags    HouseAction
// @description 订单信息
// @produce json
// @accept  json
// @param   data  body model.OrderStatisticsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/orderStatistics  [POST]
// @success 0 {object} response.JsonResponse{data=[]model.OrderStatisticsResp{}} "执行结果"
func (c *HouseAction) OrderStatistics(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.OrderStatisticsReq
		err  error
		msg  string
		resp []*model.OrderStatisticsResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.OrderStatistics(req, r.Session)
	if err != nil {
		zaplog.Infof("OrderStatistics err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 预购清单统计
// @tags    HouseAction
// @description 订单信息
// @produce json
// @accept  json
// @param   data  body model.PreOrderListStatisticsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/preOrderListStatistics  [POST]
// @success 0 {object} response.JsonResponse{data=model.PreOrderListStatisticsResp{}} "执行结果"
func (c *HouseAction) PreOrderListStatistics(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.PreOrderListStatisticsReq
		err  error
		msg  string
		resp *model.PreOrderListStatisticsResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.PreOrderListStatistics(req, r.Session)
	if err != nil {
		zaplog.Infof("PreOrderListStatistics err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 收款发货统计
// @tags    HouseAction
// @description 订单信息
// @produce json
// @accept  json
// @param   data  body model.CollectionDeliveryStatisticsReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/collectionDeliveryStatistics  [POST]
// @success 0 {object} response.JsonResponse{data=model.CollectionDeliveryStatisticsResp{}} "执行结果"
func (c *HouseAction) CollectionDeliveryStatistics(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *model.CollectionDeliveryStatisticsReq
		err  error
		msg  string
		resp *model.CollectionDeliveryStatisticsResp
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	resp, msg, err = house.CollectionDeliveryStatistics(req, r.Session)
	if err != nil {
		zaplog.Infof("CollectionDeliveryStatistics err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 收货地址修改
// @tags    HouseAction
// @description 订单信息
// @produce json
// @accept  json
// @param   data  body house.ModReceiverAddressReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/modReceiverAddress  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) ModReceiverAddress(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.ModReceiverAddressReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.ModReceiverAddress(req, r.Session)
	if err != nil {
		zaplog.Infof("ModReceiverAddress err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}

// @summary 快递公司修改
// @tags    HouseAction
// @description 修改默认物流数据
// @produce json
// @accept  json
// @param   data  body house.ModExpressCompanyReq  true "需要传入的参数"
// @router  /daigou/api/v{version}/house/modExpressCompany  [POST]
// @success 0 {object} response.JsonResponse "执行结果"
func (c *HouseAction) ModExpressCompany(r *ghttp.Request) {
	//检查请求参数
	var (
		req *house.ModExpressCompanyReq
		err error
		msg string
	)
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err = house.ModExpressCompany(req, r.Session)
	if err != nil {
		zaplog.Infof("ModExpressCompany err:%v", err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
}
