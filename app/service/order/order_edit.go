package order

import (
	"bytes"
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/user/sessionman"
	"daigou/library/conf"
	"daigou/library/kuaidi"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/gf/util/gconv"
	"github.com/medivhzhan/weapp/v2"
)

//CancelOrder 取消订单
func CancelOrder(reqData *OrderCancelReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "取消订单失败"
		}
	}()
	_userId := sessionman.GetUserInfo(session).UserID
	if _userId == 0 {
		msg = "无效用户"
		return
	}
	//通过订单编号取消指定的数据,内部数据库不删除，只是修改订单状态为删除状态
	_pData := &model.OrderCancelParam{
		UserID:  _userId,
		OrderId: reqData.OrderId,
	}
	err = model.ModelCancelOrder(_pData)
	return
}

//DeleteOrder 删除订单
func DeleteOrder(reqData *OrderDeleteReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "删除订单失败"
		}
	}()
	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}
	//通过订单编号删除指定的数据,内部数据库不删除，只是修改订单状态为删除状态
	_pData := &model.OrderDeleteParam{
		ShopID:  _shopId,
		OrderId: reqData.OrderId,
	}
	err = model.ModelDeleteOrder(_pData)
	return
}

//通过订单编号确认指定订单
func ComfirmOrder(reqData *OrderComfirmReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "确认订单失败"
		}
	}()
	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}
	_pData := &model.OrderComfirmParam{
		UserID:  sessionman.GetUserInfo(session).UserID,
		ShopID:  _shopId,
		OrderId: reqData.OrderId,
	}
	var orderInfo *model.ModelOrderResp
	orderInfo, msg, err = model.ModelComfirmOrder(_pData)
	if err == nil {
		resErr := CreateSubscribe(orderInfo)
		if resErr != nil {
			zaplog.Errorf("CreateSubscribe err=%s", resErr)
			return
		}
	}
	return
}

//CreateSubscribe 发送订阅消息通知
func CreateSubscribe(pData *model.ModelOrderResp) (err error) {
	//组合商品描述
	//获取物品名称数据
	_goodsNameArr := []string{}
	if respParse, errTemp := gjson.DecodeToJson(pData.GoodsNameArr); errTemp == nil {
		_goodsNameArr = gconv.Strings(respParse.Value())
	}
	if len(_goodsNameArr) == 0 {
		err = errors.New("该订单没有商品")
		return
	}
	var _goodsDescribe bytes.Buffer
	for i, _goods := range _goodsNameArr {
		_goodsDescribe.WriteString(_goods)
		if (i + 1) < len(_goodsNameArr) {
			_goodsDescribe.WriteString("\r\n")
		}
	}
	//获取被确认的订单买家信息openid
	var _openId string
	if _openId, err = model.ModelGetOpenId(pData.OrderId); err != nil {
		return
	}
	//发送订阅消息通知
	_messageData := weapp.SubscribeMessageData{
		"number1": {
			Value: pData.OrderId, //订单编号
		},
		"thing2": {
			Value: _goodsDescribe.String(), //订单商品
		},
		"amount3": {
			Value: gconv.String(pData.Price) + "元", //订单金额
		},
		"time5": {
			Value: time.Now().Format("2006-01-02 15:04:05"), //确认时间
		},
	}
	_page_str := fmt.Sprintf("pages/auth/index?page=/pages/order/index&order_type=%d&order_id=%s", model.OSTBD, pData.OrderId)
	_, err = wxapi.SubscribeMessage(&wxapi.SubscribeMessageReq{
		ToUser:     _openId,
		TemplateID: conf.Conf.Weapp.SubscribeMessage.TemplateComfirm,
		Page:       _page_str,
		Data:       _messageData,
	})
	return
}

//收取或退款订单款项金额 目前暂时不开放
func CollectionOrReturnOrder(reqData *OrderCollectionOrReturnReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "操作订单金额失败"
		}
	}()
	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}
	_pData := &model.OrderCollectionOrReturnParam{
		ShopID:  _shopId,
		OrderId: reqData.OrderId,
		Aomoney: reqData.Aomoney,
		Remarks: reqData.Remarks,
	}
	err = model.ModelCollectionOrReturnOrder(_pData)
	return

}

//修改标记为未完成或完成订单 lyh
func ModifyStatusOrder(reqData *OrderModifyIncompleteReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "操作订单失败"
		}
	}()

	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}

	_pData := &model.OrderModifyIncompleteParam{
		OrderId:     reqData.OrderId,
		OrderStatus: reqData.OrderStatus,
	}
	err = model.ModelModifyStatusOrder(nil, _pData)
	return
}

//修改订单收货信息
func ModifyAddressOrder(reqData *OrderModifyAddressReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "修改订单收货失败"
		}
	}()

	// var _shopId uint64
	// _shopId = model.GetOrderIdToShopId(reqData.OrderId)
	// if !sessionman.IsShopOwner(session, _shopId) {
	// 	msg = "无权限发货订单"
	// 	return
	// }
	_pData := &model.OrderModifyAddressParam{
		OrderId:          reqData.OrderId,
		ReceiverName:     reqData.ReceiverName,
		ReceiverIphone:   reqData.ReceiverIphone,
		ReceiverProvince: reqData.ReceiverProvince,
		ReceiverCity:     reqData.ReceiverCity,
		ReceiverDistrict: reqData.ReceiverDistrict,
		ReceiverAddress:  reqData.ReceiverAddress,
	}
	err = model.ModelModifyAddressOrder(_pData)
	return
}

//修改订单信息
func ModifyOrder(reqData *ModifyOrderReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "修改订单失败"
		}
	}()

	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}

	//校验
	if len(reqData.OrderGoodsInfo) <= 0 {
		msg = "订单不允许空商品"
		return
	}

	//计算利润
	//利润=(商品销售价+运费报价)-（商品成本价+运费成本+优惠额度）
	//商品成本价换算成人民币=成本价数*（本币种对应人民币汇率）
	//人民币汇率要去汇率表内查询
	var profit_value float64 = 0.00
	var total_price float64 = 0.00       //总售价
	var total_input_price float64 = 0.00 //总进价
	for i, goodsInfo := range reqData.OrderGoodsInfo {
		reqData.OrderGoodsInfo[i].TotalPrice = model.MultiplyFloat64(goodsInfo.SinglePrice, gconv.Float64(goodsInfo.Quantity))
		reqData.OrderGoodsInfo[i].TotalInputPrice = model.MultiplyFloat64(goodsInfo.InputPrice, gconv.Float64(goodsInfo.Quantity))
		total_price = model.AddFloat64(total_price, reqData.OrderGoodsInfo[i].TotalPrice)
		total_input_price = model.AddFloat64(total_input_price, reqData.OrderGoodsInfo[i].TotalInputPrice)
	}
	//校验总售价数据
	if model.AddFloat64(total_price, reqData.OrdersLogistics.Offer) != reqData.Price {
		msg = "订单数据有误，具体原因请联系客服"
		return
	}
	//进价要兑换为RMB，先默认为100%
	total_input_price *= 1
	profit_value = model.SubtractFloat64(reqData.Price, model.AddFloat64(total_input_price, reqData.OrdersLogistics.Cost))
	_pData := model.ModifyOrderParam{
		OrderId:  reqData.OrderId,
		ShopID:   _shopId,
		UserID:   reqData.UserID,
		NickName: reqData.NickName,
		Price:    reqData.Price,
		PayPrice: reqData.PayPrice,
		Remark:   reqData.Remark,
		Profit:   profit_value, //利润
		OrdersLogistics: model.OrderLog{
			ReceiverAddress:  reqData.OrdersLogistics.ReceiverAddress,
			Cost:             reqData.OrdersLogistics.Cost,
			Offer:            reqData.OrdersLogistics.Offer,
			ReceiverName:     reqData.OrdersLogistics.ReceiverName,
			ReceiverProvince: reqData.OrdersLogistics.ReceiverProvince,
			ReceiverCity:     reqData.OrdersLogistics.ReceiverCity,
			ReceiverDistrict: reqData.OrdersLogistics.ReceiverDistrict,
			ReceiverIphone:   reqData.OrdersLogistics.ReceiverIphone,
			LogisticsCompany: reqData.OrdersLogistics.LogisticsCompany,
			LogisticsNumber:  reqData.OrdersLogistics.LogisticsNumber,
		},
	}
	_pData.OrderGoodsInfo = make([]model.OrderGoods, len(reqData.OrderGoodsInfo))
	for k, _goodsInfo := range reqData.OrderGoodsInfo {
		_pData.OrderGoodsInfo[k] = model.OrderGoods{
			OrderId:         _goodsInfo.OrderId,
			Quantity:        _goodsInfo.Quantity,
			InputPrice:      _goodsInfo.InputPrice,
			SinglePrice:     _goodsInfo.SinglePrice,
			GoodsName:       _goodsInfo.GoodsName,
			TotalInputPrice: _goodsInfo.TotalInputPrice,
			TotalPrice:      _goodsInfo.TotalPrice,
			Specifications:  _goodsInfo.Specifications,
			Image:           _goodsInfo.Image,
		}
	}

	err = model.ModelModifyOrder(&_pData)
	return
}

//CreateSubSend 发送订阅消息通知
//组合商品描述
func CreateSubSend(pData *model.OrderLogsInfo, session *gsession.Session) (err error) {
	//获取物品名称数据
	_goodsNameArr := []string{}
	if respParse, errTemp := gjson.DecodeToJson(pData.GoodsNameArr); errTemp == nil {
		_goodsNameArr = gconv.Strings(respParse.Value())
	}
	if len(_goodsNameArr) == 0 {
		err = errors.New("该订单没有商品")
		return
	}
	var _goodsDescribe bytes.Buffer
	for i, _goods := range _goodsNameArr {
		_goodsDescribe.WriteString(_goods)
		if (i + 1) < len(_goodsNameArr) {
			_goodsDescribe.WriteString("\r\n")
		}
	}
	//快递单号
	var _Number string = pData.LogisticsNumber
	if pData.LogisticsNumber == "无" {
		_Number = "0"
	}
	_messageData := weapp.SubscribeMessageData{
		"thing1": {
			Value: pData.LogisticsCompany, //快递公司
		},
		"thing2": {
			Value: _goodsDescribe.String(), //订单名称
		},
		"character_string3": {
			Value: pData.OrderID, //订单编号
		},
		"date4": {
			Value: pData.ShipTime.Format("2006-01-02 15:04:05"), //发货时间
		},
		"character_string5": {
			Value: _Number, //快递单号
		},
	}
	//获取被确认的订单买家信息openid
	var _openId string
	if _openId, err = model.ModelGetOpenId(pData.OrderID); err != nil {
		return
	}
	_page_str := fmt.Sprintf("pages/auth/index?page=/pages/order/index&order_type=%d&order_id=%s", model.OSD, pData.OrderID)
	_, err = wxapi.SubscribeMessage(&wxapi.SubscribeMessageReq{
		ToUser:     _openId,
		TemplateID: conf.Conf.Weapp.SubscribeMessage.TemplateDeliver,
		Page:       _page_str,
		Data:       _messageData,
	})
	return
}

//发货订单
func DeliverOrder(reqData *OrderDeliverReq, session *gsession.Session) (resp *OrderDeliverResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "发货订单失败"
		}
	}()

	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if !sessionman.IsShopOwner(session, _shopId) {
		msg = "无权限发货订单"
		return
	}

	orderInfo := &model.OrderLogsInfo{}
	resp = &OrderDeliverResp{
		ExpressNumber: reqData.ExpressNumber,
	}
	if reqData.ExpressCompanyId != 0 {
		//校验
		if (reqData.Sender != nil && reqData.Sender.JudgeLogisticsNull()) || reqData.Sender == nil {
			msg = "发货不允许寄货地址为空"
			return
		}
		if (reqData.Receiver != nil && reqData.Receiver.JudgeLogisticsNull()) || reqData.Receiver == nil {
			msg = "发货不允许收货地址为空"
			return
		}
	}

	//判断重复快递包裹发货
	if msg, err = model.JudgmentRepetitionLogis(&reqData.OrderDeliverParam, _shopId); err != nil {
		return
	} else if msg != "" {
		return nil, msg, err
	}

	if reqData.ExpressCompanyId != 0 && reqData.ExpressNumber == "" {
		//请求第三方平台获取运单号
		if reqData.OrderDeliverParam.ExpressNumber, msg, err = GetEOrderNumber(reqData, _shopId); msg == "" && err == nil && reqData.OrderDeliverParam.ExpressNumber != "" {
			resp.ExpressNumber = reqData.OrderDeliverParam.ExpressNumber
		} else {
			if msg == "" {
				msg = "自动发货失败"
			}
			return
		}
	}
	orderInfo, msg, err = model.ModelDeliverOrder(&reqData.OrderDeliverParam, _shopId)
	if err == nil && msg == "" {
		//发货成功后
		CreateSubSend(orderInfo, session)
	}

	return resp, msg, err
}

//模板参数数据
type TempleteDataParam struct {
	BackCode      string                //返回的运单号
	KuaiDiAddress string                //快递网点
	Receiver      *kuaidi.LogisticOrder // 收件人信息
	Sender        *kuaidi.LogisticOrder // 寄件人信息
	Fdate         string                //打印日期
	Ftime         string                //打印时间
	GoodsType     string                //物品类型
	Offer         string                //运费
}

//电子面单打印响应
type EOrderPrintfResp struct {
	// ThirdCode    int32  `json:"third_code"`   //第三方平台编号 1表示快递鸟 2表示快递100
	TempleteData string `json:"tmplete_data"` //模板数据
}

//调用第三方平台获取运单号
func GetEOrderNumber(reqData *OrderDeliverReq, shopId uint64) (number string, msg string, err error) {
	defer func() {
		if err != nil {
			zaplog.Infof("调用第三方平台获取运单号 失败：%v", err)
			if msg == "" {
				msg = "获取快递运单号失败"
			} else {
				err = nil
			}
		}
	}()
	//去数据库验证该订单已经发货了
	_goodsNameArr := make([]string, 0) //获取物品名称
	if len(reqData.OrderGoodsId) > 0 {
		//选中项发货
		_goodsNameArr, err = model.ModelGetSendOrderGoodsDetail(reqData.OrderId, reqData.OrderGoodsId)
		if err != nil {
			return
		}
	} else {
		//订单全部发货
		_orderInfo := &entity.Orders{}
		_orderInfo, err = model.ModelGetSendOrderDetail(reqData.OrderId, true)
		if err != nil {
			return
		}
		//获取物品名称数据
		_goodsNameArr = gconv.Strings(_orderInfo.GoodsNameArr.String)
	}
	if len(_goodsNameArr) == 0 {
		msg = "该订单没有商品"
		return
	}
	//访问数据库获得 客户号和密码或者月结账户
	res_express := &entity.ShopExpress{}
	res_express, msg, err = model.ModelCheckShopExpress(reqData.ExpressCompanyId, shopId)
	if err != nil || msg != "" {
		return
	}
	if res_express.PartnerID.String == "" || res_express.PartnerKey.String == "" {
		msg = "电子面单账号或者密码为空"
		return
	}
	//获取第三方平台物流公司配置信息
	_thirdCfg, err_third := model.ModelGetThirdPartyList()
	if err_third != nil {
		err = err_third
		return
	}

	//判断是否需要从数据库拉取数据
	if reqData.Receiver == nil {
		res_logistics := &entity.OrdersLogistics{}
		//取默认收货地址
		if res_logistics, err = model.ModelGetOrderReceiverInfo(reqData.OrderId, 0); err != nil || res_logistics == nil {
			msg = err.Error()
			return
		}
		//重新赋值
		reqData.Receiver = &kuaidi.LogisticOrder{
			Name:         res_logistics.ReceiverName,
			Mobile:       res_logistics.ReceiverIphone,
			ProvinceName: res_logistics.ReceiverProvince.String,
			CityName:     res_logistics.ReceiverCity.String,
			ExpAreaName:  res_logistics.ReceiverDistrict.String,
			Address:      res_logistics.ReceiverAddress.String,
		}
	}
	if reqData.Sender == nil {
		msg = "寄货人信息为空"
		return
	}
	//获取快递公司配置信息
	_systemExpressCompany := model.ModelIdToExpressCode(res_express.ExpressCompanyID)
	if _systemExpressCompany == nil {
		msg = "该快递公司未绑定,请选择其他"
		return
	}
	//数据库获取第三平台账号和appkey，以及对应的功能接口链接
	_ThirdPlatformInterfaceInfo := &kuaidi.KuaiDiThirdPlatformInfo{}

	var numStr, responseInfo_str string //返回结果分别表示快递单号，面单模板,第三方应答结果
	for i, _ := range _thirdCfg {
		if _ThirdPlatformInterfaceInfo, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "电子面单"); err != nil {
			return
		}
		if _ThirdPlatformInterfaceInfo.AppKey == "" || _ThirdPlatformInterfaceInfo.EBusinessID == "" || _ThirdPlatformInterfaceInfo.InterfaceUrl == "" {
			msg = "非常抱歉，该功能异常，请您联系客服。"
			return
		}
		// resp.ThirdCode = _thirdCfg[i].ID //先注释
		//请求打印电子面单接口
		switch _thirdCfg[i].ThirdCompany.String {
		case "快递鸟":
			res_express.ExpressCode = _systemExpressCompany.ExpressCode.String
		case "快递100":
			res_express.ExpressCode = _systemExpressCompany.ExoressCodeKd100.String
		}
		numStr, _, responseInfo_str, err = ParseRequstEOrder(reqData, res_express, _goodsNameArr, _thirdCfg[i].ThirdCompany.String, _ThirdPlatformInterfaceInfo)
		if err == nil && numStr != "" && responseInfo_str != "" {
			//物流订阅请求
			if _ThirdPlatformInterfaceInfo, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "轨迹订阅"); err != nil {
				return
			}
			switch _thirdCfg[i].ThirdCompany.String {
			case "快递鸟":
				DistOrderKdn(numStr, _ThirdPlatformInterfaceInfo)
			case "快递100":
				var _TPIInfoTemp *kuaidi.KuaiDiThirdPlatformInfo
				if _TPIInfoTemp, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "推送接口"); err != nil {
					//"https://cwyx.chengyouhd.com/daigou/api/v1/order/pushQueryDataKd100"
					return
				}
				DistOrderKd100(&kuaidi.ResultData{
					Com: res_express.ExpressCode,
					Nu:  numStr,
				}, _ThirdPlatformInterfaceInfo, _TPIInfoTemp.InterfaceUrl)
			}

			//打印面单已成功，直接返回结果
			break
		}
	}
	//返回成功，则保存物流单号到数据库内
	if err == nil && numStr != "" {
		// logParam := &entity.OrdersLogistics{
		// 	OrderID:          reqData.OrderId,
		// 	Cost:             null.FloatFrom(reqData.Cost),
		// 	Offer:            reqData.Offer,
		// 	ReceiverName:     reqData.Receiver.Name,
		// 	ReceiverIphone:   reqData.Receiver.Mobile,
		// 	ReceiverProvince: null.StringFrom(reqData.Receiver.ProvinceName),
		// 	ReceiverCity:     null.StringFrom(reqData.Receiver.CityName),
		// 	ReceiverDistrict: null.StringFrom(reqData.Receiver.ExpAreaName),
		// 	ReceiverAddress:  null.StringFrom(reqData.Receiver.Address),
		// 	SenderName:       null.StringFrom(reqData.Sender.Name),
		// 	SenderIphone:     null.StringFrom(reqData.Sender.Mobile),
		// 	SenderProvince:   null.StringFrom(reqData.Sender.ProvinceName),
		// 	SenderCity:       null.StringFrom(reqData.Sender.CityName),
		// 	SenderDistrict:   null.StringFrom(reqData.Sender.ExpAreaName),
		// 	SenderAddress:    null.StringFrom(reqData.Sender.Address),
		// 	LogisticsCompany: null.StringFrom(res_express.ExpressName), //reqData.ExpressName 测试阶段不保存
		// 	LogisticsCom:     null.StringFrom(res_express.ExpressCode), //reqData.ExpressCode 测试阶段不保存
		// 	LogisticsNumber:  null.StringFrom(numStr),                  //num 测试阶段不保存
		// 	IsDefault:        1,
		// }

		// //保存物流信息,更新订单状态 已发货
		// err = model.ModelSaveOrderData(logParam, model.OSD, &reqData.OrderDeliverParam, shopId)
		// if err == nil {
		// 	orderInfo = &model.OrderLogsInfo{
		// 		LogisticsCompany: res_express.ExpressName,
		// 		LogisticsNumber:  numStr, //返回运单号
		// 		GoodsNameArr:     gconv.String(_goodsNameArr),
		// 		OrderID:          reqData.OrderId,
		// 		ShipTime:         time.Now(),
		// 	}
		// }
		number = numStr //返回运单号
		return
	}

	return
}

//电子面单打印
//返回数据 物流单号，物流公司，电子面单模板
func EOrderPrintf(reqData *OrderTemplatePrintf, session *ghttp.Session) (resp *EOrderPrintfResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "电子面单打印失败"
		}
	}()
	var _shopId uint64
	_shopId = model.GetOrderIdToShopId(reqData.OrderId)
	if _shopId != sessionman.GetUserInfo(session).ShopID && _shopId != 0 {
		msg = "无权限打印面单"
		return
	}
	if shopvip, err := model.IsSeeMember(sessionman.GetUserInfo(session).UserID); shopvip.IsMember == 0 && err == nil {
		shopvipcount, err := model.ShopVipExplain(4, shopvip.IsMember)
		if err != nil {
			return nil, msg, err
		}
		if ordercount, err := model.OrderPrintingCount(sessionman.GetUserInfo(session).ShopID); ordercount.PrintingCount >= shopvipcount.OrdinaryExplain && err == nil {
			msg = "您还不是VIP用户，一天只能进行3单操作!"
			return nil, msg, err
		}
	}
	// //去数据库验证该订单已经发货了
	// _orderInfo := &entity.Orders{}
	// _orderInfo, err = model.ModelGetSendOrderDetail(reqData.OrderId, false)
	// if err != nil {
	// 	return
	// }
	// //获取物品名称数据
	// _goodsNameArr := gconv.Strings(_orderInfo.GoodsNameArr)
	// if len(_goodsNameArr) == 0 {
	// 	err = errors.New("该订单没有商品")
	// 	return
	// }
	var isFlag bool = true
	res_express := &entity.ShopExpress{}
	res_express, msg, err = model.ModelCheckShopExpress(reqData.ExpressCompanyId, _shopId)
	if err != nil || msg != "" || res_express == nil {
		return
	}
	if res_express.ExpressCompanyID == 0 {
		msg = "商铺没有绑定快递公司"
		return
	}
	//ExpressId快递公司ID为0,则表示需要取获取该店铺绑定的默认快递,反之按传输过来的信息来打印
	if reqData.ExpressCompanyId == 0 {
		reqData.ExpressCompanyId = res_express.ExpressCompanyID
		isFlag = true
	}

	_logistics := &entity.OrdersLogistics{}

	_logistics, err = model.ModelGetOrderReceiverInfo(reqData.OrderId, reqData.LogisticsID)
	template_param := &EOrderParam{
		ExpressNumber: _logistics.LogisticsNumber.String,
		Receiver: &kuaidi.LogisticOrder{
			Name:         _logistics.ReceiverName,
			Mobile:       _logistics.ReceiverIphone,
			ProvinceName: _logistics.ReceiverProvince.String,
			CityName:     _logistics.ReceiverCity.String,
			ExpAreaName:  _logistics.ReceiverDistrict.String,
			Address:      _logistics.ReceiverAddress.String,
		}, // 收件人信息
		Sender: &kuaidi.LogisticOrder{
			Name:         _logistics.SenderName.String,
			Mobile:       _logistics.SenderIphone.String,
			ProvinceName: _logistics.SenderProvince.String,
			CityName:     _logistics.SenderCity.String,
			ExpAreaName:  _logistics.SenderDistrict.String,
			Address:      _logistics.SenderAddress.String,
		}, // 寄件人信息
	}
	resp = &EOrderPrintfResp{}
	//给模板中的变量参数替换成数据
	resp.TempleteData, err = ReturnTempleteData(reqData, template_param, isFlag)
	if resp.TempleteData != "" && err == nil {
		err = model.OrderPrinting(sessionman.GetUserInfo(session).ShopID, reqData.OrderId)
		if err != nil {
			return
		}
	}
	zaplog.Infof("给模板中的变量参数替换成数据 Data:%s", resp.TempleteData)
	return
}

// //第三方电子面单打印
// //返回数据 物流单号，物流公司，电子面单模板
// func ThirdEOrderPrintf(reqData *EOrderPrintfReq, session *ghttp.Session) (resp *EOrderPrintfResp, msg string, err error) {
// 	defer func() {
// 		if err != nil {
// 			msg = "电子面单打印失败"
// 		}
// 	}()
// 	//验证是不是店主
// 	if !sessionman.IsShopOwner(session, reqData.ShopID) {
// 		return
// 	}
// 	resp = &EOrderPrintfResp{}
// 	//去数据库验证该订单已经发货了
// 	_orderInfo := &entity.Orders{}
// 	_orderInfo, err = model.ModelGetSendOrderStatus(reqData.OrderId)
// 	if err != nil {
// 		return
// 	}
// 	//获取物品名称数据
// 	_goodsNameArr := []string{}
// 	if respParse, errTemp := gjson.DecodeToJson(_orderInfo.GoodsNameArr); errTemp == nil {
// 		_goodsNameArr = gconv.Strings(respParse.Value())
// 	}
// 	if len(_goodsNameArr) == 0 {
// 		err = errors.New("该订单没有商品")
// 		return
// 	}

// 	//访问数据库获得 客户号和密码或者月结账户
// 	res_express, errExpress := model.ModelCheckShopExpress(reqData.ExpressName, reqData.ShopID)
// 	if errExpress != nil {
// 		err = errExpress
// 		return
// 	}
// 	//自动获取商铺默认快递公司
// 	if reqData.ExpressId == 0 {
// 		reqData.ExpressName = res_express.ExpressName
// 		reqData.ExpressId = res_express.ExpressID
// 	}

// 	//获取第三方平台物流公司配置信息
// 	_thirdCfg, err_third := model.ModelGetThirdPartyList()
// 	if err_third != nil {
// 		err = err_third
// 		return
// 	}

// 	//数据库获取第三平台账号和appkey，以及对应的功能接口链接
// 	_ThirdPlatformInterfaceInfo := &kuaidi.KuaiDiThirdPlatformInfo{}

// 	var numStr, eHTML, responseInfo_str string //返回结果分别表示快递单号，面单模板,第三方应答结果
// 	for i, _ := range _thirdCfg {
// 		if _ThirdPlatformInterfaceInfo, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "电子面单"); err != nil {
// 			return
// 		}
// 		// resp.ThirdCode = _thirdCfg[i].ID //先注释
// 		//请求打印电子面单接口
// 		numStr, eHTML, responseInfo_str, err = ParseRequstEOrder(reqData, res_express, _goodsNameArr, _thirdCfg[i].ThirdCompany.String, _ThirdPlatformInterfaceInfo)
// 		if err == nil && numStr != "" && eHTML != "" && responseInfo_str != "" {
// 			//物流订阅请求
// 			if _ThirdPlatformInterfaceInfo, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "轨迹订阅"); err != nil {
// 				return
// 			}

// 			switch _thirdCfg[i].ThirdCompany.String {
// 			case "快递鸟":
// 				DistOrderKdn(numStr, _ThirdPlatformInterfaceInfo)
// 			case "快递100":
// 				var _TPIInfoTemp *kuaidi.KuaiDiThirdPlatformInfo
// 				if _TPIInfoTemp, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "推送接口"); err != nil {
// 					//"https://cwyx.chengyouhd.com/daigou/api/v1/order/pushQueryDataKd100"
// 					return
// 				}
// 				DistOrderKd100(&kuaidi.ResultData{
// 					Com: reqData.ExpressCode,
// 					Nu:  numStr,
// 				}, _ThirdPlatformInterfaceInfo, _TPIInfoTemp.InterfaceUrl)
// 			}

// 			//打印面单已成功，直接返回结果
// 			break
// 		}
// 	}
// 	err = nil
// 	numStr = "YT4628769885731"
// 	//返回成功，则保存物流单号到数据库内
// 	if err == nil {
// 		//给模板中的变量参数替换成数据
// 		resp.TempleteData, err = ReturnTempleteData(reqData, numStr)
// 		if err == nil {
// 			logParam := &entity.OrdersLogistics{
// 				OrderID:          reqData.OrderId,
// 				Cost:             null.FloatFrom(reqData.Cost),
// 				Offer:            reqData.Offer,
// 				ReceiverName:     reqData.Receiver.Name,
// 				ReceiverIphone:   reqData.Receiver.Mobile,
// 				ReceiverProvince: null.StringFrom(reqData.Receiver.ProvinceName),
// 				ReceiverCity:     null.StringFrom(reqData.Receiver.CityName),
// 				ReceiverDistrict: null.StringFrom(reqData.Receiver.ExpAreaName),
// 				ReceiverAddress:  null.StringFrom(reqData.Receiver.Address),
// 				LogisticsCompany: null.StringFrom("圆通快递"),            //reqData.ExpressName 测试阶段不保存
// 				LogisticsCom:     null.StringFrom("YTO"),             //reqData.ExpressCode 测试阶段不保存
// 				LogisticsNumber:  null.StringFrom("YT4628769885731"), //num 测试阶段不保存
// 			}
// 			//保存物流信息,更新订单状态未已发货
// 			err = model.ModelSaveOrderData(logParam, 2)
// 		}

// 	}

// 	return
// }

//请求打印电子面单接口
func ParseRequstEOrder(reqData *OrderDeliverReq, res_express *entity.ShopExpress, _goodsNameArr []string, thirdCompany string, _ThirdPlatformInterfaceInfo *kuaidi.KuaiDiThirdPlatformInfo) (numStr, eHTML, responseInfo_str string, err error) {
	switch thirdCompany {
	case "快递鸟":
		reqEOrder_KDN := &kuaidi.RequestDataEOrder{
			CustomerName: res_express.PartnerID.String,
			CustomerPwd:  res_express.PartnerKey.String,
			ShipperCode:  res_express.ExpressCode,
			OrderCode:    reqData.OrderId,
			PayType:      "2", //到付
			ExpType:      "1",
			IsNotice:     1, //商家自己联系快递员上门取件
			Receiver:     reqData.Receiver,
			Sender:       reqData.Sender,
			Quantity:     1, //默认一个订单一个包裹
			Commodity: func(_count int) []*kuaidi.GoodsOrder {
				Goods_arr := make([]*kuaidi.GoodsOrder, _count)
				for i := 0; i < _count; i++ {
					Goods_arr[i] = &kuaidi.GoodsOrder{
						GoodsName: _goodsNameArr[i],
					}
				}
				return Goods_arr
			}(len(_goodsNameArr)),
			IsReturnPrintTemplate: 0,
			AddService:            []*string{},
		}
		//圆通使用的是月结字段
		if res_express.ExpressCode == "YTO" {
			reqEOrder_KDN.MonthCode = res_express.PartnerKey.String
		} else {
			reqEOrder_KDN.CustomerPwd = res_express.PartnerKey.String
		}
		//顺丰需要填写月结号
		if reqEOrder_KDN.PayType == "3" && reqEOrder_KDN.ShipperCode == "SF" {
			reqEOrder_KDN.MonthCode = res_express.PartnerID.String
		}

		numStr, _, responseInfo_str, err = ParseRequstEOrder_KDN(_ThirdPlatformInterfaceInfo, reqEOrder_KDN)
	case "快递100":
		//两种电子面单模板 图片和html
		var reqEOrder_KD100 interface{}
		if err != nil || numStr == "" {
			//html
			reqEOrder_KD100 = &kuaidi.KD100EOrderHTMLReq{
				PartnerId:  res_express.PartnerID.String,
				PartnerKey: res_express.PartnerKey.String,
				Net:        res_express.ExpressOutlets.String,
				Kuaidicom:  res_express.ExpressCode,
				RecMan: &kuaidi.Rec_SendMan{
					Name:      reqData.Receiver.Name,
					Mobile:    reqData.Receiver.Mobile,
					PrintAddr: reqData.Receiver.ProvinceName + reqData.Receiver.CityName + reqData.Receiver.ExpAreaName + reqData.Receiver.Address,
				},
				SendMan: &kuaidi.Rec_SendMan{
					Name:      reqData.Sender.Name,
					Mobile:    reqData.Sender.Mobile,
					PrintAddr: reqData.Sender.ProvinceName + reqData.Sender.CityName + reqData.Sender.ExpAreaName + reqData.Sender.Address,
				},
				Count:   "1",
				PayType: "SHIPPER",
				ExpType: "标准快递",
				OrderId: reqData.OrderId,
			}
			numStr, eHTML, responseInfo_str, err = ParseRequstEOrder_KD100(_ThirdPlatformInterfaceInfo, reqEOrder_KD100)
		}
	}

	return
}

//请求快递鸟电子面单
func ParseRequstEOrder_KDN(thirdPlatformInterfaceInfo *kuaidi.KuaiDiThirdPlatformInfo, reqEOrder_KDN *kuaidi.RequestDataEOrder) (num string, eHtml string, responseInfo_str string, err error) {

	responseInfo_str, err = thirdPlatformInterfaceInfo.PostEOrder_KDN(reqEOrder_KDN)
	//返回成功，则保存物流单号到数据库内
	if err == nil {
		if respParse, errTemp := gjson.DecodeToJson(responseInfo_str); errTemp == nil {
			num = gconv.String(respParse.Get("Order.LogisticCode")) //读取返回物流单号
			eHtml = gconv.String(respParse.Get("PrintTemplate"))    //电子面单模板数据
		} else {
			err = errTemp
		}
	}
	return
}

//请求快递100电子面单
func ParseRequstEOrder_KD100(thirdPlatformInterfaceInfo *kuaidi.KuaiDiThirdPlatformInfo, reqEOrder interface{}) (num string, eTemplate string, responseInfo_str string, err error) {

	responseInfo_str, err = thirdPlatformInterfaceInfo.PostEOrder(reqEOrder)
	//返回成功，则保存物流单号到数据库内
	if err == nil {
		if respParse, errTemp := gjson.DecodeToJson(responseInfo_str); errTemp == nil {
			num = gconv.String(respParse.Get("data.kuaidinum")) //读取返回物流单号
			switch reqEOrder.(type) {
			case *kuaidi.KD100EOrderIMGReq:
				eTemplate = gconv.String(respParse.Get("data.imgBase64")) //电子面单模板数据
			case *kuaidi.KD100EOrderHTMLReq:
				eTemplate = gconv.String(respParse.Get("data.template")) //电子面单模板数据
			default:
				return
			}

		} else {
			err = errTemp
		}
	}
	return
}

//组合面单模板数据，返回给前端打印
func ReturnTempleteData(data *OrderTemplatePrintf, reqData *EOrderParam, isFlag bool) (_template_data string, err error) {
	//拉取模板参数
	tb_data_template := &entity.ExpressTemplateConfig{}
	tb_data_template, err = model.ModelGetTemplete(data.OrderTemplateId, data.ExpressCompanyId, isFlag)
	if err != nil || tb_data_template.TempleteData == "" {
		return _template_data, errors.New("打印失败")
	}
	_template_data = tb_data_template.TempleteData
	_template_data = strings.Replace(_template_data, "[BackCode]", reqData.ExpressNumber, -1)
	_template_data = strings.Replace(_template_data, "[Rname]", reqData.Receiver.Name, -1)
	_template_data = strings.Replace(_template_data, "[Rphone]", reqData.Receiver.Mobile, -1)
	_template_data = strings.Replace(_template_data, "[Raddress]", reqData.Receiver.ProvinceName+reqData.Receiver.CityName+reqData.Receiver.ExpAreaName, -1)
	_template_data = strings.Replace(_template_data, "[RaddressDetail]", reqData.Receiver.Address, -1)
	_template_data = strings.Replace(_template_data, "[Sname]", reqData.Sender.Name, -1)
	_template_data = strings.Replace(_template_data, "[Sphone]", reqData.Sender.Mobile, -1)
	_template_data = strings.Replace(_template_data, "[Saddress]", reqData.Sender.ProvinceName+reqData.Sender.CityName+reqData.Sender.ExpAreaName, -1)
	_template_data = strings.Replace(_template_data, "[SaddressDetail]", reqData.Sender.Address, -1)
	_template_data = strings.Replace(_template_data, "[GoodsType]", "食品", -1)
	_template_data = strings.Replace(_template_data, "[Offer]", "4", -1)
	//.Format("2006-01-02 15:04:05")
	_template_data = strings.Replace(_template_data, "[Fdate]", time.Now().Format("2006-01-02"), -1)
	_template_data = strings.Replace(_template_data, "[Ftime]", time.Now().Format("15:04:05"), -1)
	_template_data = strings.Replace(_template_data, "[KuaiDiAddress]", "深圳市 宝安区 西乡", -1)
	return
}

//快递鸟物流轨迹订阅
func DistOrderKdn(logisticsNumber string, thirdPlatformInterfaceInfo *kuaidi.KuaiDiThirdPlatformInfo) {
	//通过运单号查询数据库获取寄件人和收件人的信息
	dbData, _ := model.ModelNumToLogisticsInfo(logisticsNumber)
	if dbData != nil {
		data_kdn := &kuaidi.DistOrderParam{
			LogisticCode: dbData.LogisticsNumber.String,
			CustomerName: dbData.ReceiverIphone[7:],
			PayType:      "1",
			ExpType:      "1",
		}
		thirdPlatformInterfaceInfo.PostOrderDist_KDN(data_kdn)
	}
}

//快递鸟接收物流推送的变化信息
func PushQueryDataKdn(reqData *kuaidi.OrderPushQueryDataReq) (res *kuaidi.OrderPushQueryDataResp) {
	res = &kuaidi.OrderPushQueryDataResp{
		EBusinessID: reqData.EBusinessID,
		UpdateTime:  entity.Time{Time: time.Now()}, // 更新时间
	}
	if gconv.Int(reqData.Count) > len(reqData.Data) {
		res.Success = false
		res.Reason = "个数大于集合元素个数"
		return
	}
	//获取第三方平台物流公司配置信息
	_thirdCfg, err_third := model.ModelGetThirdPartyList()
	if err_third != nil {
		return
	}
	//数据库获取第三平台账号和appkey，以及对应的功能接口链接
	_ThirdPlatformInterfaceInfo := &kuaidi.KuaiDiThirdPlatformInfo{}
	for i, _ := range _thirdCfg {
		if _thirdCfg[i].ThirdCompany.String == "快递鸟" {
			_ThirdPlatformInterfaceInfo, _ = model.ModelCheckThirdPlatform(_thirdCfg[i], "轨迹订阅")
			break
		}

	}

	var _logisticsRecords string
	for i := 0; i < gconv.Int(reqData.Count); i++ {
		if !gconv.Bool(reqData.Data[i].Success) {
			if (reqData.Data[i].Reason == "三天无轨迹" || reqData.Data[i].Reason == "七天内无轨迹变化") && 0 != gconv.Int(reqData.Data[i].State) {
				//需重新发起订阅
				DistOrderKdn(reqData.Data[i].LogisticCode, _ThirdPlatformInterfaceInfo)
			}
			continue
		}

		_logisticsRecords = gconv.String(reqData.Data[i].Traces)
		logParamMap := map[string]interface{}{
			"logistics_com":     reqData.Data[i].ShipperCode,
			"logistics_number":  reqData.Data[i].LogisticCode,
			"logistics_records": _logisticsRecords,
		}
		var order_status int32 = model.OSD
		if 3 == gconv.Int(reqData.Data[i].State) {
			// // 暂时不改，2020-09-26 lyh del
			// order_status = model.OSC
			logParamMap["status"] = 2 //已完成
		}
		//保存物流变化信息
		if err := model.ModelUpdateOrderData(logParamMap, order_status); err != nil {
			res.Success = false
		}
	}
	return
}

//快递100物流轨迹订阅
func DistOrderKd100(lastResult *kuaidi.ResultData, thirdPlatformInterfaceInfo *kuaidi.KuaiDiThirdPlatformInfo, callbackurl string) {
	data_kd100 := &kuaidi.DisOrderInfoReq{
		Company:    lastResult.Com,
		Number:     lastResult.Nu,
		Parameters: kuaidi.ParametersInfo{Callbackurl: callbackurl},
	}
	thirdPlatformInterfaceInfo.PostDistOrderRequst(data_kd100)
}

//快递100接收物流推送的变化信息
func PushQueryDataKd100(reqData *kuaidi.OrderPushQueryDataKd100Req) (res *kuaidi.OrderPushResp) {
	res = &kuaidi.OrderPushResp{
		Result:     "true",
		ReturnCode: "200",
		Message:    "",
	}

	//获取第三方平台物流公司配置信息
	_thirdCfg, err_third := model.ModelGetThirdPartyList()
	if err_third != nil {
		return
	}
	//数据库获取第三平台账号和appkey，以及对应的功能接口链接
	_ThirdPlatformInterfaceInfo := &kuaidi.KuaiDiThirdPlatformInfo{}
	var kd100Index int
	for i, _ := range _thirdCfg {
		if _thirdCfg[i].ThirdCompany.String == "快递100" {
			_ThirdPlatformInterfaceInfo, _ = model.ModelCheckThirdPlatform(_thirdCfg[i], "轨迹订阅")
			kd100Index = i
			break
		}
	}
	if reqData.Status == "abort" {
		if _TPIInfoTemp, err := model.ModelCheckThirdPlatform(_thirdCfg[kd100Index], "推送接口"); err == nil {
			//"https://cwyx.chengyouhd.com/daigou/api/v1/order/pushQueryDataKd100"
			DistOrderKd100(&reqData.LastResult, _ThirdPlatformInterfaceInfo, _TPIInfoTemp.InterfaceUrl) //重新订阅
			return
		}

	}

	//物流轨迹信息
	_logisticsRecords := gconv.String(reqData.LastResult.Data)
	logParamMap := map[string]interface{}{
		"logistics_com":     reqData.LastResult.Com,
		"logistics_number":  reqData.LastResult.Nu,
		"logistics_records": _logisticsRecords,
	}
	var order_status int32 = model.OSD
	if 3 == gconv.Int(reqData.LastResult.State) {
		// // 暂时不改，2020-09-26 lyh del
		// order_status = model.OSC
		logParamMap["status"] = 2 //已完成
	}
	//保存物流变化信息
	if err := model.ModelUpdateOrderData(logParamMap, order_status); err != nil {
		res.Result = "false"
		res.ReturnCode = "500"
		res.Message = "回调处理失败"
	}
	return
}
