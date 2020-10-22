package customer

import (
	"bytes"
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/conf"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/gogf/gf/net/ghttp"
)

// PaymentRequest 提交订单请求
type PaymentReq struct {
	model.PaymentParam
}

// PaymentResponse 下单回应
type PaymentResp struct {
	Code         int `json:"Code"`         //0成功，失败-1
	Stock_Status int `json:"Stock_Status"` //提示库存状态：0正常 1缺货
}

//购买商品模板内容
type SubTemplatGoodsData struct {
	Number1 string `json:"number1"` //订单编号
	Thing2  string `json:"thing2"`  //订单商品
	Amount3 string `json:"amount3"` //订单金额
	Time5   string `json:"time5"`   //确认时间
}

// customer payment 用户购买CustmoerPayment商品支付
//采用事务处理
func CustmoerOrdersGoods(req *PaymentReq, session *ghttp.Session) (msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "购买商品失败"
		}
	}()

	//获取用户信息
	userInfo := sessionman.GetUserInfo(session)
	if userInfo.UserID == 0 {
		msg = "无效用户"
		return
	}
	var _shopId uint64
	if len(req.OrderGoodsInfo) > 0 && req.OrderGoodsInfo[0].GoodsId != "" {
		_shopId = model.GetGoodsIdToShopId(req.OrderGoodsInfo[0].GoodsId)
	}
	userinfosee, err := model.UserInfoSee(userInfo.UserID)
	if err != nil {
		return "", nil
	}
	var CustomerID uint32
	var CustomerName string
	//添加客户
	if !model.IsUserBinding(&model.CustomerBindingReq{CrUserid: userInfo.UserID}, _shopId) {
		//下单成功该用户自动添加为代购的客户
		resp, msg, err := model.CustomerIncrease(&model.CustomerIncreaseReq{
			CrNick:      userinfosee.NickName,
			CrHeadimg:   userinfosee.AvatarURL,
			IsAddress:   1,
			Name:        req.PaymentParam.OrdersLogistics.ReceiverName,
			PhoneNumber: req.PaymentParam.OrdersLogistics.ReceiverIphone,
			Province:    req.PaymentParam.OrdersLogistics.ReceiverProvince,
			City:        req.PaymentParam.OrdersLogistics.ReceiverCity,
			Area:        req.PaymentParam.OrdersLogistics.ReceiverDistrict,
			Detailed:    req.PaymentParam.OrdersLogistics.ReceiverAddress,
			IsDefault:   0,
			UserID:      userInfo.UserID,
		}, _shopId)
		if err != nil {
			zaplog.Infof("下单时添加客户失败:%v", resp)
			return msg, nil
		}
		CustomerID = resp.CustomerID
		CustomerName = resp.CustomerName
	} else {
		resp, err := model.CustomerIDSee(&model.CustomerIDSeeReq{ShopID: _shopId, UserID: userInfo.UserID})
		if err != nil {
			zaplog.Infof("下单时查询客户id失败:%v", resp)
			return msg, nil
		}
		CustomerID = resp.CustomerID
		CustomerName = resp.CustomerName
	}
	// if sessionman.GetUserInfo(session).ShopID == uint64(sessionman.GetUserInfo(session).UserID) && sessionman.GetUserInfo(session).ShopID != _shopId {
	// 	msg = "店主不能购买商品"
	// 	return
	// }
	//校验
	if len(req.OrderGoodsInfo) <= 0 {
		msg = "订单不允许空商品"
		return
	}
	//校验
	if model.JudgeLogisticsNull(&req.OrdersLogistics) {
		msg = "订单不允许收货地址为空"
		return
	}
	//校验销售总价 精确小数点两位
	var sum_price float64 = 0.00
	for _, _temp := range req.OrderGoodsInfo {
		if _temp.TotalPrice != model.MultiplyFloat64(float64(_temp.Quantity), _temp.SinglePrice) {
			msg = "单商品总价参数校验异常，请联系客服"
			return
		}
		sum_price = model.AddFloat64(sum_price, _temp.TotalPrice)
	}
	sum_price = model.AddFloat64(sum_price, req.OrdersLogistics.Offer)

	if sum_price != req.Price {
		msg = "订单总价参数校验异常，请联系客服"
		zaplog.Infof("总价：%v，%v", sum_price, req.Price)
		return
	}

	//获取订单id
	StrOrderId := model.GetOrdersId(userInfo.UserID)
	zaplog.Debugf("打印订单id, StrOrderId=%s", StrOrderId)

	_pData := model.PaymentParam{
		ExpressID:       req.PaymentParam.ExpressID,
		Price:           req.PaymentParam.Price,
		Remark:          req.PaymentParam.Remark,
		OrdersLogistics: req.PaymentParam.OrdersLogistics,
		OrderGoodsInfo:  req.PaymentParam.OrderGoodsInfo,
	}
	if err = model.MainInsertOrders(&_pData, StrOrderId, userInfo.UserID, _shopId, CustomerID, CustomerName); err != nil {
		return
	}

	GzhServiceMessage(req, userinfosee.NickName, StrOrderId, _shopId)
	return
}

//下单成功，公众号推送消息给店家
func GzhServiceMessage(req *PaymentReq, userName string, StrOrderId string, _shopId uint64) {
	//获取店家openid
	_pagePath := fmt.Sprintf("pages/auth/index?page=/pages/ownerorder/index?order_type=1") //跳转待确认界面
	_miniprogram := wxapi.UniformMsgMiniprogram{
		AppID:    conf.Conf.Weapp.AppID,
		PagePath: _pagePath,
	}
	//订单注释
	_remark := req.Remark
	if _remark == "" {
		_remark = "用户选择了您，请及时处理，不要让用户等着急喽"
	}
	//订单商品详情
	var orderGoodsBuf bytes.Buffer
	_nameArr := model.CreateGoodsName(req.OrderGoodsInfo)
	for _, v := range _nameArr {
		orderGoodsBuf.WriteString(v)
		orderGoodsBuf.WriteString(";")
	}

	_msgData := wxapi.UniformMsgData{
		"first": wxapi.UniformMsgKeyword{
			Value: "您有一个订单未处理",
			Color: "#173177",
		},
		"keyword1": wxapi.UniformMsgKeyword{
			Value: userName,
			Color: "#173177",
		},
		"keyword2": wxapi.UniformMsgKeyword{
			Value: req.OrdersLogistics.ReceiverIphone,
			Color: "#173177",
		},
		"keyword3": wxapi.UniformMsgKeyword{
			Value: req.OrdersLogistics.ReceiverProvince + req.OrdersLogistics.ReceiverCity + req.OrdersLogistics.ReceiverDistrict + req.OrdersLogistics.ReceiverAddress,
			Color: "#173177",
		},
		"keyword4": wxapi.UniformMsgKeyword{
			Value: orderGoodsBuf.String(),
			Color: "#173177",
		},
		"keyword5": wxapi.UniformMsgKeyword{
			Value: time.Now().Format("2006-01-02 15:04:05"),
			Color: "#173177",
		},
		"remark": wxapi.UniformMsgKeyword{
			Value: _remark,
			Color: "#173177",
		},
	}
	//从数据库获取接收者open
	if _userInfo, errTmp := model.GetShopIdToUserInfo(_shopId); errTmp == nil && _userInfo.GzhOpenID.String != "" {
		_tmpMsg := &wxapi.UniformMpTmpMsg{
			ToUser:     _userInfo.GzhOpenID.String, //"oGstJwDKHCMh4NcB7Rod7kHTdkGY", // 接收者openid
			TemplateID: conf.Conf.Weapp.TemplateMessage.TemplatePurchase,
			// URL:         conf.Conf.Weapp.TemplateMessage.TemplateUrl,
			Miniprogram: _miniprogram,
			Data:        _msgData, //模板数据
		}
		wxapi.TemplateMessage(_tmpMsg)
	} else {
		zaplog.Infof("GetShopIdToUserInfo [error],err:%v", errTmp)
	}
	return
}
