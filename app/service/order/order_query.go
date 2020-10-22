package order

import (
	"daigou/app/model"
	"daigou/app/service/personal"
	"daigou/app/service/user/sessionman"
	"daigou/library/kuaidi"
	"errors"

	"github.com/gogf/gf/net/ghttp"
)

//CheckWOrder 查询订单详情列表
func CheckOrder(reqData *CheckOrderReq, session *ghttp.Session) (SearchDataResp *CheckOrderResp, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "查看订单失败"
		}
	}()
	//确认订单限制
	var OrderCount int32 = 0
	vipexplain1, err := personal.ShopVipExplain(1, session)
	if err != nil {
		return nil, "", err
	}
	ordercount, err := model.OrderCount(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, "", err
	}
	if vipexplain1.Explain != -1 {
		if vipexplain1.Explain >= ordercount.OrderCount {
			OrderCount = vipexplain1.Explain - ordercount.OrderCount
		} else {
			OrderCount = 0
		}
	} else {
		OrderCount = -1
	}
	//打印面单限制
	var PrintCount int32 = 0
	vipexplain4, err := personal.ShopVipExplain(4, session)
	if err != nil {
		return nil, "", err
	}
	printcount, err := model.OrderPrintingCount(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, "", err
	}
	if vipexplain1.Explain != -1 {
		if vipexplain4.Explain >= printcount.PrintingCount {
			PrintCount = vipexplain4.Explain - printcount.PrintingCount
		} else {
			PrintCount = 0
		}
	} else {
		PrintCount = -1
	}
	//通过传参的参数去查询请求的待确认订单
	//回复的是一个list
	//内容字段包含：
	//买家名称、下单时间、商品信息List（商品名+规格+（*个数）、（进价币种+金额/人民币金额））、买家备注、买家收货地址和联系方式、金额（运费，利润，优惠，收款额度（已收额度/总收取额度））
	//涉及到的表：订单表,订单商品详情表
	//查询订单商品
	var SearchDataRes []*model.CheckOrderRes
	SearchDataRes = []*model.CheckOrderRes{}

	if SearchDataRes, err = model.ModelCheckOrder(&reqData.ModelCheckOrderReq, &model.UserAndShopId{
		ShopID: reqData.ShopID,
		UserID: sessionman.GetUserInfo(session).UserID,
	}); err == nil {
		SearchDataResp = &CheckOrderResp{
			VipCode:   OrderCount,
			PrintCode: PrintCount,
			OrderArr:  SearchDataRes,
		}
		// //订单个数获取
		// if _OrderCount := model.ModelCheckOrderCount([]int32{int32(reqData.ModelCheckOrderReq.OrderStatus)}, &model.UserAndShopId{
		// 	ShopID: reqData.ModelCheckOrderReq.ShopID,
		// 	UserID: sessionman.GetUserInfo(session).UserID,
		// }); len(_OrderCount) > 0 {
		// 	SearchDataResp = &CheckOrderResp{
		// 		OrderCount: uint32(_OrderCount[0]),
		// 		VipCode:    OrderCount,
		// 		PrintCode:  PrintCount,
		// 		OrderArr:   SearchDataRes,
		// 	}
		// }
	}

	return
}

type CheckOrderOneDetail struct {
	*model.CheckOrderRes
	OsStatus uint32 `json:"os_status"` // 操作物流信息标识 0不能 1能
}

//CheckOrderDetail 查看指定订单详情
func CheckOrderDetail(reqData *CheckOrderDetailReq, session *ghttp.Session) (dataRes *CheckOrderOneDetail, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "查看订单详情失败"
		}
	}()
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限查看"
		return
	}
	dataRes = &CheckOrderOneDetail{}
	dataRes.CheckOrderRes, dataRes.OsStatus, err = model.ModelCheckOrderOne(&reqData.ModelCheckOrderDetailReq, &model.UserAndShopId{
		ShopID: _shopId,
		UserID: sessionman.GetUserInfo(session).UserID,
	})
	return
}

//SearchOrder 搜索订单
func SearchOrder(reqData *OrderSearchReq, session *ghttp.Session) (dataRes *OrderSearchResp, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "搜索订单为空"
		}
	}()
	//确认订单限制
	var OrderCount int32 = 0
	vipexplain1, err := personal.ShopVipExplain(1, session)
	if err != nil {
		return nil, "", err
	}
	ordercount, err := model.OrderCount(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, "", err
	}
	if vipexplain1.Explain >= ordercount.OrderCount {
		OrderCount = vipexplain1.Explain - ordercount.OrderCount
	} else {
		OrderCount = 0
	}
	//打印面单限制
	var PrintCount int32 = 0
	vipexplain4, err := personal.ShopVipExplain(4, session)
	if err != nil {
		return nil, "", err
	}
	printcount, err := model.OrderPrintingCount(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, "", err
	}
	if vipexplain4.Explain >= printcount.PrintingCount {
		PrintCount = vipexplain4.Explain - printcount.PrintingCount
	} else {
		PrintCount = 0
	}
	//通过like关键字去执行，这是目前方案,将搜索词去和用户昵称以及商品名称以及订单编号比对筛选
	_order_id := reqData.InputTerms
	reqData.InputTerms = "%" + reqData.InputTerms + "%"
	dataRes = &OrderSearchResp{
		AllData:   make([]*model.CheckOrderRes, 0),
		VipCode:   OrderCount,
		PrintCode: PrintCount,
	}
	dataRes.AllData, err = model.ModelCheckOrderSearch(&reqData.OrderSearchParam, _order_id, &model.UserAndShopId{
		ShopID: reqData.ShopID,
		UserID: sessionman.GetUserInfo(session).UserID,
	})
	return
}

//获取订单个数
func CheckOrderCount(reqData *CheckOrderCountReq, session *ghttp.Session) (res *CheckOrderCountResp, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "订单个数为零"
		}
	}()

	res = &CheckOrderCountResp{
		ShopID: reqData.ShopID,
	}
	res.OrderCount = model.ModelCheckOrderCount(reqData.OrderStatus, &model.UserAndShopId{
		ShopID: reqData.ShopID,
		UserID: sessionman.GetUserInfo(session).UserID,
	})
	return
}

//LookUpBillOrder 查看订单账单流水
func LookUpBillOrder(reqData *OrderLookUpBillReq) (r []*model.OrderLookUpBillRes, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "订单个数为零"
		}
	}()
	_pData := &model.OrderBillParam{
		OrderId: reqData.OrderId,
	}
	r, err = model.ModelLookUpBillOrder(_pData)
	return
}

//查看订单物流记录应答
type OrderLogisticsResp struct {
	ThirdCode        int32  `json:"third_code"`        //第三方平台编号 1表示快递鸟 2表示快递100
	LogisticsCompany string `json:"logistics_company"` //物流公司
	LogisticsNumber  string `json:"logistics_number"`  //物流单号
	LogisticsRecords string `json:"logistics_records"` //物流记录信息 json格式
}

//LookUpLogisticsOrder 查看订单物流消息
//返回数据：物流单号，物流公司，物流记录消息
func LookUpLogisticsOrder(reqData *OrderLogisticsReq) (res *OrderLogisticsResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "物流消息为空"
			err = nil
		}
	}()

	model_resp := &model.OrderLogisticsResp{}
	var _getDB bool = false //是否拉取数据库内物流信息
	model_resp, _getDB, err = model.ModelLookUpLogisticsOrder(reqData.OrderLogisticsParam)
	if err == nil {

		res = &OrderLogisticsResp{
			LogisticsCompany: model_resp.LogisticsCompany,
			LogisticsNumber:  model_resp.LogisticsNumber,
		}
		if _getDB {
			//读取数据库中缓存的物流信息
			res.LogisticsRecords = model_resp.LogisticsRecords
			res.ThirdCode = model_resp.ThirdPartyID
			return
		}

		//请求拉取第三方平台物流信息

		if model_resp.LogisticsRecords == "" {
			//获取第三方平台物流公司配置信息
			_thirdCfg, err_third := model.ModelGetThirdPartyList()
			if err_third != nil {
				err = err_third
				return
			}
			//获取快递公司配置信息
			_systemExpressCompany := model.ModelIdToExpressCodeEx(model_resp.LogisticsCom)
			if _systemExpressCompany == nil {
				msg = "该快递公司未绑定,请选择其他"
				return
			}
			//查询订单的物流状态 3表示已签收，反之未完成订单
			var _state int
			_ThirdPlatformInterfaceInfo := &kuaidi.KuaiDiThirdPlatformInfo{}
			for i, _ := range _thirdCfg {
				if _ThirdPlatformInterfaceInfo, err = model.ModelCheckThirdPlatform(_thirdCfg[i], "物流查询"); err != nil {
					return
				}

				res.ThirdCode = _thirdCfg[i].ID //平台ID
				switch _thirdCfg[i].ThirdCompany.String {
				case "快递鸟":
					//请求参数数据
					req_order := &kuaidi.OrderHandle{
						ShipperCode:  model_resp.LogisticsCom,
						LogisticCode: model_resp.LogisticsNumber,
					}
					res.LogisticsRecords, _state = _ThirdPlatformInterfaceInfo.PostOrderLog_KDN(req_order)
				case "快递100":
					res.LogisticsRecords, _state = _ThirdPlatformInterfaceInfo.PostOrderLog(_systemExpressCompany.ExoressCodeKd100.String, model_resp.LogisticsNumber)
				default:
					err = errors.New("平台配置非法，查询失败")
					return
				}
				//保存数据库
				if res.LogisticsRecords != "" {
					err = model.ModelUpdateLogisticsOrder(res.LogisticsRecords, reqData.OrderId, res.ThirdCode, _state, model_resp.LogisticsNumber)
					return
				}
			}
			return
		}

		return
	}
	return
}

//查看订单物流消息(买家查看)
type OrderLogisticsUserReq struct {
	*model.OrderLogisticsUserParam
}

//订单发货多个包裹
type OrderLogisticsMultipleResp struct {
	Count    int                               `json:"count"`     //列表个数
	DataList []*model.OrderLogisticsUserResult `json:"data_list"` //订单下物流包裹信息列表
}
type OrderLogisticsUserResp struct {
	Kind              uint32                      `json:"kind"`               // 0 未分包 1 分包
	MultipleLogistics *OrderLogisticsMultipleResp `json:"multiple_logistics"` //订单下多个物流包裹
	SingleLogistics   *OrderLogisticsResp         `json:"single_logistics"`   //订单下只有一个物流包裹
}

//LookUpLogistics 查看订单物流消息(买家查看)
//返回数据：物流单号，物流公司列表
func LookUpLogistics(reqData *OrderLogisticsUserReq) (res *OrderLogisticsMultipleResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "物流消息为空"
			err = nil
		}
	}()
	res = &OrderLogisticsMultipleResp{}
	res.DataList = make([]*model.OrderLogisticsUserResult, 0)
	if res.DataList, err = model.ModelLookUpLogisticsUser(reqData.OrderLogisticsUserParam); err == nil {
		res.Count = len(res.DataList)
	}
	return
	// defer func() {
	// 	if err != nil && msg == "" {
	// 		msg = "物流消息为空"
	// 		err = nil
	// 	}
	// }()
	// res = &OrderLogisticsUserResp{}
	// //先判断是否分包发货
	// if model.JudgeOrdersPartSend(reqData.OrderId) {
	// 	res.Kind = 1
	// 	res.MultipleLogistics = &OrderLogisticsMultipleResp{}
	// 	res.MultipleLogistics.DataList = make([]*model.OrderLogisticsUserResult, 0)
	// 	if res.MultipleLogistics.DataList, err = model.ModelLookUpLogisticsUser(reqData.OrderLogisticsUserParam); err == nil {
	// 		res.MultipleLogistics.Count = len(res.MultipleLogistics.DataList)
	// 	}
	// 	return
	// }

	// //未分包发货
	// res.SingleLogistics = &OrderLogisticsResp{}
	// res.SingleLogistics, msg, err = LookUpLogisticsOrder(&OrderLogisticsReq{&model.OrderLogisticsParam{OrderId: reqData.OrderId, LogisticsID: nil}})
}

//查看快递公司模板列表
func LookUpEOrderTemplate() (res []*LookUpEOrderSetResp, msg string, err error) {
	res = make([]*LookUpEOrderSetResp, 0)
	defer func() {
		if err != nil {
			msg = "查看快递公司模板列表失败"
		}
	}()

	data_arr := make([]*model.EOrderTemplate, 0)
	if data_arr, err = model.ModelLookUpEOrderTemplate(); err != nil {
		return
	}
	s_map := map[uint32]int{} //快递公司对应的模板个数
	for _, data := range data_arr {
		s_map[data.ExpressCompanyId]++
	}
	res = make([]*LookUpEOrderSetResp, len(s_map))
	var all_index int = 0
	for _, q_value := range data_arr {
		//判断是否重复插入
		if func() bool {

			var isTrue bool = false
			for _, all_value := range res {
				if all_value != nil && all_value.ExpressCompanyId == q_value.ExpressCompanyId {
					return true
				}
			}
			return isTrue
		}() {
			continue
		}
		if len(s_map) <= all_index {
			break
		}
		res[all_index] = &LookUpEOrderSetResp{
			ExpressName:      q_value.ExpressName,
			ExpressCompanyId: q_value.ExpressCompanyId,
		}
		// err = gconv.StructDeep(gconv.Map(q_value), &res[all_index])
		// if err != nil {
		// 	return
		// }
		res[all_index].TemplateList = make([]*EOrderTemplate, s_map[res[all_index].ExpressCompanyId])
		all_index++
	}
	var index int
	for i, q_value := range res {
		index = 0
		for _, v := range data_arr {
			if v != nil && v.ExpressCompanyId == q_value.ExpressCompanyId {
				res[i].TemplateList[index] = &EOrderTemplate{}
				res[i].TemplateList[index].TempleteId = v.TempleteId
				res[i].TemplateList[index].TempleteName = v.TempleteName
				index++
			}
		}
	}

	return
}
