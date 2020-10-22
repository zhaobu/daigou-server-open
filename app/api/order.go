//api 处理路由接口业务
package api

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/order"
	"daigou/library/kuaidi"
	"daigou/library/response"
	"daigou/library/zaplog"
	"net/url"
	"time"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/gvalid"
)

// 订单API管理对象
type OrderPageAction struct{}

// @summary 订单查看页面
// @description 展示订单列表页面。
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.CheckOrderReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.CheckOrderResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/checkOrder [GET]
func (c *OrderPageAction) CheckOrder(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.CheckOrderReq
		resp *order.CheckOrderResp
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
	resp, msg, err = order.CheckOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("CheckOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 按订单状态获取订单个数
// @description 按订单状态获取订单个数 展示订单页面所有状态订单列表的个数
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.CheckOrderCountReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=[]order.CheckOrderCountResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/checkOrderCount [POST]
func (c *OrderPageAction) CheckOrderCount(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.CheckOrderCountReq
		resp *order.CheckOrderCountResp
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
	resp, msg, err = order.CheckOrderCount(req, r.Session)
	if err != nil {
		zaplog.Infof("CheckOrderCount param:%s ,err:%v", gconv.String(req), err)
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

// @summary 订单查看详情页面
// @description 展示订单详情页面，可以编辑订单。
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.CheckOrderDetailReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.CheckOrderOneDetail{}} "执行结果"
// @router  /daigou/api/v{version}/order/checkOrderDetail [GET]
func (c *OrderPageAction) CheckOrderDetail(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.CheckOrderDetailReq
		resp *order.CheckOrderOneDetail
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
	resp, msg, err = order.CheckOrderDetail(req, r.Session)
	if err != nil {
		zaplog.Infof("CheckOrderDetail param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 取消订单
// @description 取消店主为确认的指定ID的订单,针对用户买家
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderCancelReq true "传入参数"
// @success 0 {object} response.JsonResponse{} "执行结果"
// @router  /daigou/api/v{version}/order/cancelOrder [POST]
func (c *OrderPageAction) CancelOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderCancelReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.CancelOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("ModelCancelOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 删除订单
// @description 店主删除指定ID的订单数据，卖家行为
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderDeleteReq true "传入参数"
// @success 0 {object} response.JsonResponse{} "执行结果"
// @router  /daigou/api/v{version}/order/deleteOrder [POST]
func (c *OrderPageAction) DeleteOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderDeleteReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.DeleteOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("DeleteOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 确认订单
// @description 确认订单。
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderComfirmReq true "传入参数"
// @success 0 {object} response.JsonResponse{} "执行结果"
// @router  /daigou/api/v{version}/order/comfirmOrder [POST]
func (c *OrderPageAction) ComfirmOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderComfirmReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.ComfirmOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("ComformOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 查看订单的账单流水记录
// @description 查看订单的账单流水记录（收款或退款）流水账
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderLookUpBillReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=[]model.OrderLookUpBillRes{}} "执行结果"
// @router  /daigou/api/v{version}/order/lookUpBillOrder [GET]
func (c *OrderPageAction) LookUpBillOrder(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderLookUpBillReq
		resp []*model.OrderLookUpBillRes
		msg  string
		err  error
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
	resp, msg, err = order.LookUpBillOrder(req)
	if err != nil {
		zaplog.Infof("LookUpBillOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 收款或退款编辑
// @description 收款或退款编辑，记录和展示流水账
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderCollectionOrReturnReq true "传入参数"
// @success 0 {object} response.JsonResponse "执行结果"
// @router  /daigou/api/v{version}/order/collectionOrReturnOrder [POST]
func (c *OrderPageAction) CollectionOrReturnOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderCollectionOrReturnReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.CollectionOrReturnOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("CollectionOrReturnOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 标记为未完成或完成订单
// @description 标记为未完成或完成订单
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderModifyIncompleteReq true "传入参数"
// @success 0 {object} response.JsonResponse "执行结果"
// @router  /daigou/api/v{version}/order/modifyStatusOrder [POST]
func (c *OrderPageAction) ModifyStatusOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderModifyIncompleteReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.ModifyStatusOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("modifyStatusOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 修改收货地址
// @description 修改收货地址
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderModifyAddressReq true "传入参数"
// @success 0 {object} response.JsonResponse "执行结果"
// @router  /daigou/api/v{version}/order/modifyAddressOrder [POST]
func (c *OrderPageAction) ModifyAddressOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.OrderModifyAddressReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.ModifyAddressOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("ModifyAddressOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 修改订单
// @description 修改订单
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.ModifyOrderReq true "传入参数"
// @success 0 {object} response.JsonResponse "执行结果"
// @router  /daigou/api/v{version}/order/modifyOrder [POST]
func (c *OrderPageAction) ModifyOrder(r *ghttp.Request) {
	//检查请求参数
	var req *order.ModifyOrderReq
	if err := r.Parse(&req); err != nil {
		// Validation error.
		if v, ok := err.(*gvalid.Error); ok {
			response.FailExit(r, v.FirstString())
		}
		// Other error.
		response.ErrorExit(r, err.Error())
		return
	}
	msg, err := order.ModifyOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("ModifyOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}

	if msg == "" {
		response.SuccExit(r, nil)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 搜索订单
// @description 按照买家名称或者商品名称或手机号码或订单号来搜检
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderSearchReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=[]order.OrderSearchResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/searchOrder [GET]
func (c *OrderPageAction) SearchOrder(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderSearchReq
		resp *order.OrderSearchResp
		msg  string
		err  error
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
	resp, msg, err = order.SearchOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("SearchOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 电子面单打印
// @description 电子面单打印
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderTemplatePrintf true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.EOrderPrintfResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/eOrderPrintf [POST]
func (c *OrderPageAction) EOrderPrintf(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderTemplatePrintf
		resp *order.EOrderPrintfResp
		msg  string
		err  error
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
	resp, msg, err = order.EOrderPrintf(req, r.Session)
	if err != nil {
		zaplog.Infof("EOrderPrintf param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}

// @summary 发货订单
// @description 人工或者快递公司寄货,确认发货
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderDeliverReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.OrderDeliverResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/deliverOrder [POST]
func (c *OrderPageAction) DeliverOrder(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderDeliverReq
		resp *order.OrderDeliverResp
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
	resp, msg, err := order.DeliverOrder(req, r.Session)
	if err != nil {
		zaplog.Infof("DeliverOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	zaplog.Infof("DeliverOrder成功:%s ", msg)
	return
}

// @summary 物流信息
// @description 查看订单物流消息
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderLogisticsReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.OrderLogisticsResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/lookUpLogisticsOrder [GET]
func (c *OrderPageAction) LookUpLogisticsOrder(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderLogisticsReq
		resp *order.OrderLogisticsResp
		msg  string
		err  error
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
	resp, msg, err = order.LookUpLogisticsOrder(req)
	if err != nil {
		zaplog.Infof("LookUpLogisticsOrder param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, resp)
	}
	return
}

// @summary 物流包裹列表信息 (买家查看)
// @description 查看订单物流消息
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body order.OrderLogisticsUserReq true "传入参数"
// @success 0 {object} response.JsonResponse{data=order.OrderLogisticsMultipleResp{}} "执行结果"
// @router  /daigou/api/v{version}/order/lookUpLogistics [GET]
func (c *OrderPageAction) LookUpLogistics(r *ghttp.Request) {
	//检查请求参数
	var (
		req  *order.OrderLogisticsUserReq
		resp *order.OrderLogisticsMultipleResp
		msg  string
		err  error
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
	resp, msg, err = order.LookUpLogistics(req)
	if err != nil {
		zaplog.Infof("LookUpLogistics param:%s ,err:%v", gconv.String(req), err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, resp)
	}
	return
}

// @summary 轨迹推送接口快递鸟
// @description 该接口主流快递仅支持中通快递、申通快递、圆通速递3家，如需查询所有主流快递公司,请选用在途监控服务
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body kuaidi.OrderPushQueryDataReq true "传入参数"
// @success 0 {object} kuaidi.OrderPushQueryDataResp{} "执行结果"
// @router  /daigou/api/v{version}/order/pushQueryDataKdn [POST]
func PushQueryDataKdn(r *ghttp.Request) {
	//检查请求参数
	var (
		req     *kuaidi.OrderPushQueryDataReq
		strData string
		err     error
		res     *kuaidi.OrderPushQueryDataResp
	)
	res = &kuaidi.OrderPushQueryDataResp{
		UpdateTime: entity.Time{Time: time.Now()}, // 更新时间
	}
	RequestType := gconv.String(r.GetQuery("RequestType"))
	//获取传递过来的参数推送数据
	if RequestType != "101" && RequestType != "102" {
		res.Success = false
		res.Reason = "RequestType不是101和102"
	} else if strData, err = url.QueryUnescape(gconv.String(r.GetQuery("RequestData"))); err != nil {
		res.Success = false
		res.Reason = "url解码失败"
	} else if err = gconv.Struct(gconv.Map(strData), &req); err != nil {
		res.Success = false
		res.Reason = "data解析数据失败"
	} else {
		// 接收的成功信息按运单号保存到数据库订单物流表中
		res = order.PushQueryDataKdn(req)
	}

	r.Response.WriteJsonExit(res)
	return
}

// @summary 轨迹推送接口快递100
// @description 根据您提供的订阅 回调地址将物流轨迹信息回调到您的接口，回调请求使用http的post方式，回调参数名是param，订阅方接收到回调参数后请及时响应，业务处理逻辑尽量异步处理。
// @tags    订单
// @Accept  json
// @Produce  json
// @param   data body kuaidi.OrderPushQueryDataKd100Req true "传入参数"
// @success 0 {object} kuaidi.OrderPushResp{} "执行结果"
// @router  /daigou/api/v{version}/order/pushQueryDataKd100 [POST]
func PushQueryDataKd100(r *ghttp.Request) {
	//检查请求参数
	var (
		req *kuaidi.OrderPushQueryDataKd100Req
		res *kuaidi.OrderPushResp
	)
	res = &kuaidi.OrderPushResp{}
	if err := gconv.Struct(gconv.String(r.GetQuery("param")), &req); err != nil {
		res.Result = "false"
		res.Message = "解析数据失败"
	} else {
		// 接收的成功信息按运单号保存到数据库订单物流表中
		res = order.PushQueryDataKd100(req)
	}
	r.Response.WriteJsonExit(res)
	return
}

// @summary 查询商铺电子面单模板设置界面
// @description 查询商铺电子面单模板设置界面（所属的快递公司以及模板样式选择）
// @tags    订单
// @Accept  json
// @Produce  json
// @success 0 {object} response.JsonResponse{data=[]order.LookUpEOrderSetResp{}}"执行结果"
// @router  /daigou/api/v{version}/order/lookUpEOrderTemplate [POST]
func (c *OrderPageAction) LookUpEOrderTemplate(r *ghttp.Request) {
	//检查请求参数
	var (
		resp []*order.LookUpEOrderSetResp
		msg  string
		err  error
	)
	resp, msg, err = order.LookUpEOrderTemplate()
	if err != nil {
		zaplog.Infof("LookUpEOrderTemplateSet param:%v ,err:%v", nil, err)
		response.ErrorExit(r, err.Error())
	}
	if msg == "" {
		response.SuccExit(r, resp)
	} else {
		response.FailExitData(r, msg, nil)
	}
	return
}
