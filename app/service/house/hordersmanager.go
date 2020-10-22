package house

//商品库订单管理
import (
	"daigou/app/model"
	"daigou/app/service/order"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/gf/util/gconv"
)

//创建预购清单请求
type CreatePreorderReq struct {
	*model.PreorderData
}

func CreatePreorder(req *CreatePreorderReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限增加预购清单"
		return
	}
	//判断客户id和客户昵称是否存在
	if req.GoodsName == "" {
		msg = "商品名称必填，不能为空"
		return
	}
	if req.TagName == "" {
		// msg = "标签名称必填，不能为空"
		// return
		req.TagName = "默认标签"
	}
	if req.UserName == "" {
		msg = "客户名称必填，不能为空"
		return
	}
	if req.Num < 0 {
		msg = "预购数量不能小于0"
		return
	}
	if len(req.Remark) > 100 {
		msg = "备注内容不能超过100个字"
		return
	}
	//如果不存在需要新建客户信息插入客户表中
	msg, err = model.CreatePreorder(req.PreorderData, _shopId)
	return
}

//预购清单搜索已存在对象名称请求
type SearchObjectNameReq struct {
	Kind       uint32 `json:"kind"`        // 搜索对象类型 0标签搜索 1客户搜索 2商品搜索
	SearchName string `json:"search_name"` // 搜索对象名称
}

//应答
type SearchObjectNameResp struct {
	Count    int                           `json:"count"`     // 个数
	DataList []*model.SearchNameListResult `json:"data_list"` //列表
}

func SearchPreorderObjectName(req *SearchObjectNameReq, session *gsession.Session) (res *SearchObjectNameResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限搜索"
		return
	}
	if req.SearchName == "" {
		return
	}
	if req.Kind < 0 || req.Kind > 2 {
		return
	}

	res = &SearchObjectNameResp{}
	if res.DataList, msg, err = model.SearchPreorderObjectName(req.Kind, req.SearchName, _shopId); err != nil || res.DataList == nil {
		return
	}
	res.Count = len(res.DataList)
	return
}

//预购清单派单请求
type PreorderTaskReq struct {
	TagID uint32 `json:"tag_id"` // 标签id
}

//应答
type PreorderTaskResp struct {
	TagName  string                          `json:"tag_name"`  // 标签名称
	Count    int                             `json:"count"`     // 个数
	DataList []*model.PreorderTaskListResult `json:"data_list"` //列表
}

func PreorderTask(req *PreorderTaskReq, session *gsession.Session) (res *PreorderTaskResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限搜索"
		return
	}
	if req.TagID == 0 {
		msg = "参数非法"
		return
	}

	res = &PreorderTaskResp{}
	if res.DataList, res.TagName, msg, err = model.PreorderTask(req.TagID, _shopId); err != nil || res.DataList == nil {
		return
	}
	res.Count = len(res.DataList)
	return
}

//买到预购商品请求
type PreorderBuyDataReq struct {
	*model.PreorderBuyData
}

func PreorderBuy(req *PreorderBuyDataReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限买到操作"
		return
	}
	if req.PreorderID == nil && (req.TagID == nil || req.HgsID == nil) && req.UserID == nil {
		//校验
		msg = "请求数据为空，请重新操作"
		return
	}

	err = model.PreorderBuy(req.PreorderBuyData, _shopId)
	return
}

//买到预购商品请求
type ModPreorderTagReq struct {
	*model.ModPreorderTagData
}

func ModPreorderTag(req *ModPreorderTagReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限移动操作"
		return
	}
	if req.HgsID == "" || req.TagID == 0 || req.MoveTagID == 0 {
		//校验
		msg = "请求数据为空，请重新操作"
		return
	}

	err = model.ModPreorderTag(req.ModPreorderTagData, _shopId)
	return
}

//预购清单买家核单查看请求
type PreorderCheckBillReq struct {
	*model.PreorderCheckBillParam
}

//应答
type PreorderCheckBillResp struct {
	UserID   uint32                         `json:"user_id"`   // 买家ID
	UserName string                         `json:"user_name"` //  客户名称
	Count    int                            `json:"count"`     //  列表个数
	DataList []*model.PreorderCheckBillInfo `json:"data_list"` // 数据列表
}

//预购清单买家核单查看
func PreorderCheckBill(req *PreorderCheckBillReq, session *gsession.Session) (res *PreorderCheckBillResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.UserID == 0 {
		//校验
		msg = "请求数据为空，请重新操作"
		return
	}
	res = &PreorderCheckBillResp{
		UserID: req.UserID,
	}
	res.DataList = make([]*model.PreorderCheckBillInfo, 0)
	if res.DataList, res.UserName, err = model.PreorderCheckBill(req.PreorderCheckBillParam, _shopId); err != nil || res.DataList == nil {
		return
	}
	res.Count = len(res.DataList)
	return
}

//清单列表总数应答
type CheckPreorderGoodsCountResp struct {
	PreorderCount int `json:"preorder_count"` //预购列表总数
	OrderCount    int `json:"order_count"`    //收款发货列表总数
}

func CheckPreorderGoodsCount(session *gsession.Session) (res *CheckPreorderGoodsCountResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	res = &CheckPreorderGoodsCountResp{}
	res.PreorderCount, res.OrderCount = model.CheckPreorderGoodsCount(_shopId)
	return
}

//清单列表请求
type PreorderGoodsListReq struct {
	Kind uint32 `json:"kind"` //0表示清单 1表示收款发货
	*model.PageHouseReq
}

//清单列表应答
type PreorderGoodsListResp struct {
	Kind              uint32                           `json:"kind"`                //0表示清单 1表示收款发货
	Count             int                              `json:"count"`               //列表个数
	PreorderGoodsList []*model.PreorderGoodsListResult `json:"preorder_goods_list"` //预购清单商品分类列表
	OrderOrderList    []*model.OrdersOrderListResult   `json:"order_order_list"`    //已购订单分类列表
}

func PreorderGoodsList(req *PreorderGoodsListReq, session *gsession.Session) (res *PreorderGoodsListResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000014)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Kind < 0 || req.Kind > 2 {
		msg = "查看状态类型非法"
		return
	}
	if req.Count == 0 || req.StartIndex < 0 {
		msg = "查看个数非法"
		return
	}
	res = &PreorderGoodsListResp{
		Kind: req.Kind,
	}
	if req.Kind == 0 {
		res.PreorderGoodsList, err = model.PreorderGoodsList(req.PageHouseReq, _shopId)
		res.Count = len(res.PreorderGoodsList)
	} else {
		res.OrderOrderList, err = model.OrdersGoodsList(req.PageHouseReq, _shopId)
		res.Count = len(res.OrderOrderList)
	}

	return
}

//商家搜索清单列表请求
type SearchGoodsReq struct {
	Kind       uint32 `json:"kind"`        //0表示清单 1表示收款发货
	SearchType uint32 `json:"search_type"` //搜索类型 0不选择(不应答) 1按订单状态已全付 2已全发 4未全付 8未全发 16按订单号 32按订单商品名 64按客户名
	InputTerms string `json:"input_terms"` //搜索输入词 为空表示查看全部
	*model.PageHouseReq
}

//商家搜索清单列表应答
type SearchGoodsResp struct {
	Kind              uint32                           `json:"kind"`                //0表示清单 1表示收款发货
	Count             int                              `json:"count"`               //列表个数
	PreorderGoodsList []*model.PreorderGoodsListResult `json:"preorder_goods_list"` //预购清单商品分类列表
	OrderOrderList    []*model.OrdersOrderListResult   `json:"order_order_list"`    //已购订单分类列表
}

func SearchGoodsList(req *SearchGoodsReq, session *gsession.Session) (res *SearchGoodsResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000014)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Kind < 0 || req.Kind > 2 {
		msg = "查看状态类型非法"
		return
	}
	if req.Count == 0 || req.StartIndex < 0 {
		msg = "查看个数非法"
		return
	}
	if req.SearchType == 0 {
		return
	}
	res = &SearchGoodsResp{
		Kind: req.Kind,
	}
	if req.Kind == 0 {
		res.PreorderGoodsList, err = model.PreorderGoodsListEx(req.PageHouseReq, req.SearchType, req.InputTerms, _shopId)
		res.Count = len(res.PreorderGoodsList)
	} else {
		res.OrderOrderList, err = model.OrdersGoodsListEx(req.PageHouseReq, req.SearchType, req.InputTerms, _shopId)
		res.Count = len(res.OrderOrderList)
	}

	return
}

//商家查看单个商品所属买家列表请求
type SingleGoodsListReq struct {
	*model.OSHouseReq
}

//商家查看单个商品所属买家列表应答
type SingleGoodsListResp struct {
	*model.SingleGoodsListResult
}

func SingleGoodsList(req *SingleGoodsListReq, session *gsession.Session) (res *SingleGoodsListResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	res = &SingleGoodsListResp{}
	if res.SingleGoodsListResult, err = model.SingleGoodsList(req.HgsID, _shopId); err != nil {
		return
	}
	res.Count = len(res.GoodsList)

	return
}

//商家查看订单支付管理详情(预购清单)
type PreorderPayInfoReq struct {
	UserID uint32 `json:"user_id"` //用户id
}
type PreorderPayInfoResp struct {
	UserName         string                        `json:"user_name"`          // 买家名称
	Count            int                           `json:"count"`              // 列表个数
	PreorderBillList []*model.PreorderBillListInfo `json:"Preorder_bill_list"` // 买家账单列表
}

func GetPreorderPayInfo(req *PreorderPayInfoReq, session *gsession.Session) (res *PreorderPayInfoResp, msg string, err error) {
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}

	res = &PreorderPayInfoResp{}

	res.PreorderBillList = make([]*model.PreorderBillListInfo, 0)
	res.PreorderBillList, res.UserName, err = model.UserPreorderBill(req.UserID, _shopId)
	res.Count = len(res.PreorderBillList)
	return
}

//商家查看订单支付管理详情
type UserOrdersPayInfoReq struct {
	Type    uint32 `json:"type"`     //查看类型 0订单分类 1买家分类
	UserID  uint32 `json:"user_id"`  //用户id
	OrderID string `json:"order_id"` //订单id
}
type UserOrdersPayInfoResp struct {
	Type          uint32                     `json:"type"`            // 查看类型 0订单分类 1买家分类
	UserID        uint32                     `json:"user_id"`         // 用户id
	UserName      string                     `json:"user_name"`       // 买家名称
	Count         int                        `json:"count"`           // 列表个数
	OrderBillList []*model.OrderBillListInfo `json:"order_bill_list"` // 买家账单列表
}

func GetUserOrdersPayInfo(req *UserOrdersPayInfoReq, session *gsession.Session) (res *UserOrdersPayInfoResp, msg string, err error) {
	// _shopId := uint64(1000010)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Type < 0 || req.Type > 2 {
		msg = "查看对象类型非法"
		return
	}
	res = &UserOrdersPayInfoResp{
		Type: req.Type,
	}
	res.OrderBillList = make([]*model.OrderBillListInfo, 0)
	if req.Type == 0 {
		if res.OrderBillList, res.UserName, res.UserID, err = model.UserBill(req.OrderID, _shopId); err != nil {
			return
		}
	} else {
		if res.OrderBillList, res.UserName, res.UserID, err = model.OrderBill(req.UserID, _shopId); err != nil {
			return
		}
	}
	res.Count = len(res.OrderBillList)
	return
}

//商家查看支付管理界面物流信息
type PayRecivceInfoReq struct {
	UserID uint32 `json:"user_id"` //用户id（客户id）
}
type PayRecivceInfoResp struct {
	Count      int                     `json:"count"`       // 列表个数
	PayRecivce []*model.PayRecivceInfo `json:"pay_recivce"` // 买家快递包裹列表
}

func GetPayRecivceInfo(req *PayRecivceInfoReq, session *gsession.Session) (res *PayRecivceInfoResp, msg string, err error) {
	// _shopId := uint64(1000010)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	res = &PayRecivceInfoResp{}
	res.PayRecivce = make([]*model.PayRecivceInfo, 0)
	if res.PayRecivce, err = model.GetPayRecivceInfo(req.UserID, _shopId); err != nil {
		return
	}
	res.Count = len(res.PayRecivce)
	return
}

//编辑清单请求
type EditSingleOrderReq struct {
	Kind     uint32 `json:"kind"`      //0表示清单 1表示收款发货
	SingleID uint32 `json:"single_id"` //单操作id 订单商品id
	*model.ModSValue
}

//编辑清单应答
type EditOrderResp struct {
	Kind uint32 `json:"kind"` //0表示清单 1表示收款发货
}

func EditSingleValue(req *EditSingleOrderReq, session *gsession.Session) (res *EditOrderResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000011)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Kind < 0 || req.Kind > 3 {
		msg = "查看状态类型非法"
		return
	}
	res = &EditOrderResp{
		Kind: req.Kind,
	}
	//单独处理付款特殊操作
	if req.ModSValue.ParamType == 3 && req.Kind == 1 {
		var orderInfo *model.ModelOrderResp
		orderInfo, msg, err = model.ModSinglePayOs(req.ModSValue, req.Kind, req.SingleID, _shopId)
		if (err == nil || msg == "") && orderInfo != nil && gconv.Uint32(req.Value) == 1 {
			resErr := order.CreateSubscribe(orderInfo)
			if resErr != nil {
				zaplog.Errorf("CreateSubscribe err=%s", resErr)
				return
			}
		}
		return
	}

	msg, err = model.ModSingleParam(req.ModSValue, req.Kind, req.SingleID, _shopId)
	return
}

//编辑清单请求
type EditBatchOrderReq struct {
	Kind    uint32 `json:"kind"`     //0表示清单 1表示收款发货
	Object  uint32 `json:"object"`   //对象类型 0商品分类 1买家分类 2订单分类
	BatchID string `json:"batch_id"` //批量操作id （买家id或者商品库id或者订单id）
	*model.ModSValue
}

func EditBatchValue(req *EditBatchOrderReq, session *gsession.Session) (res *EditOrderResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000011)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Kind < 0 || req.Kind > 3 {
		msg = "查看状态类型非法"
		return
	}
	if req.ParamType == 3 && req.Object == 0 {
		msg = "商品分类已付确认不能操作"
		return
	}
	res = &EditOrderResp{
		Kind: req.Kind,
	}
	if res.Kind == 1 && req.ParamType == 3 {
		//查看所有非预购清单的订单下的商品以及邮费是否都付款，如果是，那更新订单确认状态
		orderInfo := make([]*model.ModelOrderResp, 0)
		orderInfo, msg, err = model.ModBatchPayOs(req.ModSValue, req.Kind, req.BatchID, req.Object, _shopId)
		if (err == nil || msg == "") && orderInfo != nil && gconv.Uint32(req.Value) == 1 {
			for _, v_info := range orderInfo {
				if v_info == nil {
					break
				}
				resErr := order.CreateSubscribe(v_info)
				if resErr != nil {
					zaplog.Errorf("CreateSubscribe err=%s", resErr)
					return
				}
			}
		}
		return
	}
	msg, err = model.ModBatchInfo(req.ModSValue, req.Kind, req.BatchID, req.Object, _shopId)
	return
}

//编辑邮费数据
type EditPostageReq struct {
	OrderID string `json:"order_id"` // 订单编号
	model.PostageInfo
}

func EditPostage(req *EditPostageReq, session *gsession.Session) (msg string, err error) {
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.Cost == nil || req.Offer == nil || req.UfPayStatus == nil {
		msg = "修改值非法，请重新修改"
		return
	}
	orderInfo := &model.ModelOrderResp{}
	orderInfo, msg, err = model.EditPostageInfo(&req.PostageInfo, req.OrderID, _shopId)

	//如果改的时付款状态，则需要影响大订单确认状态
	if req.UfPayStatus != nil && msg == "" && err == nil && orderInfo != nil && *req.UfPayStatus == 1 {
		resErr := order.CreateSubscribe(orderInfo)
		if resErr != nil {
			zaplog.Errorf("CreateSubscribe err=%s", resErr)
			return
		}
	}
	return
}

//订单数据详情查看请求
type OrderRecordDetailReq struct {
	Kind         uint32 `json:"kind"`           //0表示清单 1表示收款发货 2订单统计
	OrderGoodsID uint32 `json:"order_goods_id"` //订单商品编号
}

//订单数据详情查看应答
type OrderRecordDetailResp struct {
	Detail *model.OrderRecordDetailInfo `json:"detail"`
}

func GetOrderRecordDetail(req *OrderRecordDetailReq, session *gsession.Session) (res *OrderRecordDetailResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000011)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}

	res = &OrderRecordDetailResp{}

	res.Detail, msg, err = model.GetOrderRecordDetail(req.OrderGoodsID, req.Kind, _shopId)
	return
}

//查看发货信息
type DeliverInfoReq struct {
	UserID  uint32 `json:"user_id"`  //用户id 为0表示不使用
	OrderID string `json:"order_id"` //订单id 为空表示不使用
}
type DeliverInfoResp struct {
	UserName    string                   `json:"user_name"`    // 买家名称
	UserID      uint32                   `json:"user_id"`      //用户id 为0表示不使用
	Count       int                      `json:"count"`        // 列表个数
	DeliverList []*model.DeliverListInfo `json:"deliver_list"` // 发货信息列表
}

func DeliverInfoList(req *DeliverInfoReq, session *gsession.Session) (res *DeliverInfoResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000010)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.UserID == 0 && req.OrderID == "" {
		msg = "数值非法"
		return
	}
	res = &DeliverInfoResp{}

	if res.DeliverList, res.UserName, res.UserID, msg, err = model.DeliverInfoUser(req.UserID, req.OrderID, _shopId); err != nil || msg != "" {
		return
	}
	res.Count = len(res.DeliverList)
	return
}

//查看已发货信息
type CompleteDeliverInfoReq struct {
	UserID  uint32 `json:"user_id"`  //用户id 为0表示不使用
	OrderID string `json:"order_id"` //订单id 为空表示不使用
}

type CompleteDeliverInfoResp struct {
	UserName    string                           `json:"user_name"`    // 买家名称
	Count       int                              `json:"count"`        // 列表个数
	DeliverList []*model.CompleteDeliverListInfo `json:"deliver_list"` // 发货信息列表
}

func CompleteDeliverInfoList(req *CompleteDeliverInfoReq, session *gsession.Session) (res *CompleteDeliverInfoResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000010)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.UserID == 0 && req.OrderID == "" {
		msg = "数值非法"
		return
	}
	res = &CompleteDeliverInfoResp{}

	if res.DeliverList, res.UserName, msg, err = model.CompleteDeliverInfoUser(req.UserID, req.OrderID, _shopId); err != nil || msg != "" {
		return
	}
	res.Count = len(res.DeliverList)
	return
}

//查看指定已发货信息
type SingleCompleteDeliverInfoReq struct {
	OrderGoodsID uint32 `json:"order_goods_id"` //订单商品id
}

type SingleCompleteDeliverInfoResp struct {
	*model.SingleCompleteDeliverListInfo // 发货信息
}

func SingleCompleteDeliverInfoList(req *SingleCompleteDeliverInfoReq, session *gsession.Session) (res *SingleCompleteDeliverInfoResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000010)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	if req.OrderGoodsID == 0 {
		msg = "数值非法"
		return
	}
	res = &SingleCompleteDeliverInfoResp{}

	if res.SingleCompleteDeliverListInfo, msg, err = model.SingleCompleteDeliverInfoUser(req.OrderGoodsID, _shopId); err != nil || msg != "" {
		return
	}
	return
}

func SynchronizationGoods() (msg string, err error) {
	msg, err = model.SynchronizationGoods()
	return
}

//商品记录统计
func CommodityRecords(req *model.CommodityRecordsReq, session *gsession.Session) (res *model.CommodityRecordsResp, msg string, err error) {
	//权限校验
	// _shopId := uint64(1000011)
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	res, err = model.CommodityRecords(req, _shopId)
	zaplog.Infof("商品记录统计:%v", res)
	return
}

//收货地址修改请求
type ModReceiverAddressReq struct {
	OrderID   string `json:"order_id"`   //订单编号
	AddressID uint32 `json:"address_id"` //收货地址ID
}

//收货地址修改
func ModReceiverAddress(req *ModReceiverAddressReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	if req.AddressID == 0 || req.OrderID == "" {
		msg = "参数非法"
		return
	}
	msg, err = model.ModReceiverAddress(req.AddressID, req.OrderID)
	return
}

//快递公司修改
type ModExpressCompanyReq struct {
	OrderID     string `json:"order_id"`     //订单编号
	Com         string `json:"com"`          //快递公司编码
	CompanyName string `json:"company_name"` //快递公司名称
}

//快递公司修改
func ModExpressCompany(req *ModExpressCompanyReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	if req.CompanyName == "" || (req.Com == "" && req.CompanyName != "自行配送") || (req.Com != "" && req.CompanyName == "自行配送") || req.OrderID == "" {
		msg = "参数非法"
		return
	}
	msg, err = model.ModExpressCompany(req.Com, req.CompanyName, req.OrderID)
	return
}
