//order 定义订单业务对外接口解析字段
package order

import (
	"daigou/app/model"
	"daigou/library/kuaidi"
)

//请求查看订单request
type CheckOrderReq struct {
	model.ModelCheckOrderReq
}

//查看订单应答
type CheckOrderResp struct {
	// OrderCount uint32                 `json:"order_count"` //所属下的总订单个数
	VipCode   int32                  `json:"vipCode"`   //确认订单限制次数
	PrintCode int32                  `json:"printCode"` //打印订单限制次数
	OrderArr  []*model.CheckOrderRes `json:"order_arr"` //当前页查询的订单数组
}

//请求查看订单个数request
type CheckOrderCountReq struct {
	ShopID      uint64  `json:"shop_id"`      //商铺ID 传0表示买家查看
	OrderStatus []int32 `json:"order_status"` //订单状态0待确认1待发货2已发货3已完成255查看全部
}

//请求查看订单个数应答
type CheckOrderCountResp struct {
	ShopID     uint64  `json:"shop_id"`     //商铺ID 传0表示买家查看
	OrderCount []int32 `json:"order_count"` //按照请求对应的订单状态回应订单个数
}

//请求查看订单详情request
type CheckOrderDetailReq struct {
	model.ModelCheckOrderDetailReq
}

//取消订单
type OrderCancelReq struct {
	// ShopID  uint64 `json:"shop_id"`  //商铺ID
	OrderId string `json:"order_id"` //被取消的订单ID
}

//删除订单
type OrderDeleteReq struct {
	// ShopID  uint64 `json:"shop_id"`  //商铺ID
	OrderId string `json:"order_id"` //被删除的订单ID
}

//确认订单
type OrderComfirmReq struct {
	// ShopID  uint64 `json:"shop_id"`  //商铺ID
	OrderId string `json:"order_id"` //确认的订单ID
}

//查看订单账单流水记录
type OrderLookUpBillReq struct {
	ShopID  uint64 `json:"shop_id"`  //商铺ID
	OrderId string `json:"order_id"` //订单ID
}

//订单收款和退款
type OrderCollectionOrReturnReq struct {
	// ShopID  uint64  `json:"shop_id"`  //商铺ID
	OrderId string  `json:"order_id"` //订单ID
	Aomoney float64 `json:"aomoney"`  //金额 大于0表示收 小于0表示退
	Remarks string  `json:"remarks"`  //备注
}

//修改标记未完成订单
type OrderModifyIncompleteReq struct {
	// ShopID      uint64 `json:"shop_id"`      //商铺ID
	OrderId     string `json:"order_id"`     //订单编号
	OrderStatus int32  `json:"order_status"` //设置订单状态
}

//修改收货地址
type OrderModifyAddressReq struct {
	// ShopID           uint64 `json:"shop_id"`                           //商铺ID
	OrderId          string `json:"order_id"`                          //订单ID
	ReceiverName     string `json:"receiver_name"`                     //收货人
	ReceiverIphone   string `json:"receiver_iphone" v:"phone#手机号格式错误"` //联系号码
	ReceiverProvince string `json:"receiver_province"`                 //省
	ReceiverCity     string `json:"receiver_city"`                     //市
	ReceiverDistrict string `json:"receiver_district"`                 //县/区
	ReceiverAddress  string `json:"receiver_address"`                  //收货详细地址
}

//修改订单
type ModifyOrderReq struct {
	OrderId string `json:"order_id"` // 订单编号
	// ShopID            uint64       `json:"shop_id"`            // 卖家用户编号
	UserID   uint32  `json:"user_id"`   // 买家用户编号
	NickName string  `json:"nick_name"` // 买家昵称
	Price    float64 `json:"price"`     // 总金额
	PayPrice float64 `json:"pay_price"` // 总收取金额
	// PreferentialPrice float64      `json:"preferential_price"` // 优惠金额
	Remark          string       `json:"remark"`           // 买家备注
	OrdersLogistics OrderLog     `json:"orders_logistics"` //地址信息
	OrderGoodsInfo  []OrderGoods `json:"order_goods_info"`
}
type OrderGoods struct {
	OrderId         string  `json:"order_id"`          // 订单编号
	Quantity        int     `json:"quantity"`          // 数目
	CurrencyType    int     `json:"currency_type"`     // 进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）
	InputPrice      float64 `json:"input_price"`       // 进价
	SinglePrice     float64 `json:"single_price"`      // 单价
	GoodsName       string  `json:"goods_name"`        // 商品名称
	TotalInputPrice float64 `json:"total_input_price"` // 进价总金额
	TotalPrice      float64 `json:"total_price"`       // 总金额
	Specifications  string  `json:"specifications"`    // 规格
	Image           string  `json:"image"`             // 图片地址
}

type OrderLog struct {
	ReceiverAddress  string  `json:"receiver_address"`                  // 详细地址
	Cost             float64 `json:"cost"`                              // 运费成本
	Offer            float64 `json:"offer"`                             // 运费报价
	ReceiverName     string  `json:"receiver_name"`                     // 收货人
	ReceiverProvince string  `json:"receiver_province"`                 //省
	ReceiverCity     string  `json:"receiver_city"`                     //市
	ReceiverDistrict string  `json:"receiver_district"`                 //县/区
	LogisticsCompany string  `json:"logistics_company"`                 //物流公司
	LogisticsNumber  string  `json:"logistics_number"`                  //物流编号
	ReceiverIphone   string  `json:"receiver_iphone" v:"phone#手机号格式错误"` // 收货联系方式
}

//发货订单
type OrderDeliverReq struct {
	model.OrderDeliverParam
}

//发货订单应答
type OrderDeliverResp struct {
	ExpressNumber string `json:"express_number"` //快递运单号
	LogisticsID   uint32 `json:"logistics_id"`   // 快递物流id
}

//搜索订单
type OrderSearchReq struct {
	model.OrderSearchParam
}

//搜索订单应答
type OrderSearchResp struct {
	AllData   []*model.CheckOrderRes `json:"all_data"`  //订单列表
	VipCode   int32                  `json:"vipCode"`   //确认订单限制次数
	PrintCode int32                  `json:"printCode"` //打印订单限制次数
	// SelectCount int                    `json:"select_count"` //订单总数
}

//查看订单物流消息(卖家查看)
type OrderLogisticsReq struct {
	*model.OrderLogisticsParam
}

//调用第三方平台获取运单号
type EOrderPrintfReq struct {
	ShopID      uint64                `json:"shop_id"`      // 商铺id
	OrderId     string                `json:"order_id"`     // 订单编号
	ExpressCode string                `json:"express_code"` // 快递编码 0表示人工寄货
	ExpressName string                `json:"express_name"` // 快递名称
	Offer       float64               `json:"offer"`        // 快递成本
	Cost        float64               `json:"cost"`         // 快递报价
	Receiver    *kuaidi.LogisticOrder `json:"receiver"`     // 收件人信息
	Sender      *kuaidi.LogisticOrder `json:"sender"`       // 寄件人信息
}

//打印面单
type OrderTemplatePrintf struct {
	// ShopID          uint64 `json:"shop_id"`          // 商铺id
	OrderId          string `json:"order_id"`           // 订单编号
	LogisticsID      uint32 `json:"logistics_id"`       // 快递物流id
	ExpressCompanyId uint32 `json:"express_company_id"` // 快递公司id 0表示自动获取默认快递标准模板
	OrderTemplateId  string `json:"order_template_id"`  // 订单模板id，ExpressCompanyId=0时该值为模板名称
}

//模板需要的参数
type EOrderParam struct {
	ExpressNumber string                `json:"express_number"` //快递运单号
	Receiver      *kuaidi.LogisticOrder `json:"receiver"`       // 收件人信息
	Sender        *kuaidi.LogisticOrder `json:"sender"`         // 寄件人信息
}

type EOrderTemplate struct {
	TempleteName string `json:"templete_name"` // 模板名称
	TempleteId   uint32 `json:"templete_id"`   // 模板ID
}

//查询商铺电子面单模板设置界面响应 请求为空
type LookUpEOrderSetResp struct {
	ExpressName      string            `json:"express_name"`       // 快递名称
	ExpressCompanyId uint32            `json:"express_company_id"` // 快递公司ID
	TemplateList     []*EOrderTemplate `json:"template_list"`      // 快递电子面单模板列表
}
