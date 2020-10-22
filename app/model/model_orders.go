//model 处理数据库语句操作逻辑
package model

import (
	"bytes"
	"daigou/app/model/entity"
	"daigou/library/kuaidi"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"time"

	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
	"github.com/jinzhu/gorm"
)

//订单状态
const (
	OSTBC int32 = iota // 0 待确定 To be confirmed
	OSTBD              // 1 待发货 To be delivered
	OSD                // 2 已发货 Delivered
	OSC                // 3 已完成 Completed
)

//物流轨迹信息拉取第三方平台时间间隔
const querytime float64 = 3

type QueryOrderList struct {
	OrderId           string      `json:"order_id"`           // 订单编号
	ShopID            uint64      `json:"shop_id"`            // 卖家用户编号
	UserID            uint32      `json:"user_id"`            // 买家用户编号
	AvatarUrl         string      `json:"avatar_url"`         // 买家头像 或者店铺头像
	ObjectName        string      `json:"object_name"`        // 对象（商铺或买家）昵称
	OrderStatus       int         `json:"order_status"`       // 订单状态0待确认1待发货2已发货3已完成
	Price             float64     `json:"price"`              // 总金额
	PayPrice          float64     `json:"pay_price"`          // 总收取金额
	PreferentialPrice float64     `json:"preferential_price"` // 优惠金额
	Remark            string      `json:"remark"`             // 买家备注
	Ispay             int         `json:"ispay"`              // 是否已支付
	CreateTime        entity.Time `json:"create_time"`        // 创建时间
	Profit            float64     `json:"profit"`             // 订单利润
	ReceiverAddress   string      `json:"receiver_address"`   // 详细地址
	Cost              float64     `json:"cost"`               // 运费成本
	Offer             float64     `json:"offer"`              // 运费报价
	ReceiverName      string      `json:"receiver_name"`      // 收货人
	ReceiverProvince  string      `json:"receiver_province"`  //省
	ReceiverCity      string      `json:"receiver_city"`      //市
	ReceiverDistrict  string      `json:"receiver_district"`  //县/区
	LogisticsCompany  string      `json:"logistics_company"`  //物流公司
	LogisticsNumber   string      `json:"logistics_number"`   //物流编号
	ReceiverIphone    string      `json:"receiver_iphone" `   // 收货联系方式
	Quantity          int         `json:"quantity"`           // 数目
	CurrencyType      int         `json:"currency_type"`      // 进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）
	InputPrice        float64     `json:"input_price"`        // 进价
	SinglePrice       float64     `json:"single_price"`       // 单价
	GoodsName         string      `json:"goods_name"`         // 商品名称
	TotalInputPrice   float64     `json:"total_input_price"`  // 进价总金额
	TotalPrice        float64     `json:"total_price"`        // 总金额
	Specifications    string      `json:"specifications"`     // 规格
	Image             string      `json:"image"`              // 图片地址
}

//应答查看待确定订单response
type CheckOrderRes struct {
	OrderId         string        `json:"order_id"`         // 订单编号
	ShopId          uint64        `json:"shop_id"`          // 店铺编号
	UserId          uint32        `json:"user_id"`          // 买家用户编号
	AvatarUrl       string        `json:"avatar_url"`       // 买家头像 或者店铺头像
	ObjectName      string        `json:"object_name"`      // 对象（商铺或买家）昵称
	OrderStatus     int           `json:"order_status"`     // 订单状态0待确认1待发货2已发货3已完成
	Price           float64       `json:"price"`            // 总金额
	Remark          string        `json:"remark"`           // 买家备注
	CreateTime      entity.Time   `json:"create_time"`      // 创建时间
	OrdersLogistics OrderLog      `json:"orders_logistics"` //地址信息
	OrderGoodsInfo  []*OrderGoods `json:"order_goods_info"`
}
type OrderGoods struct {
	OrderId  string `json:"order_id"` // 订单编号
	Quantity int    `json:"quantity"` // 数目
	// CurrencyType    int     `json:"currency_type"`     // 进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）
	InputPrice      float64 `json:"input_price"`       // 进价
	SinglePrice     float64 `json:"single_price"`      // 单价
	GoodsName       string  `json:"goods_name"`        // 商品名称
	TotalInputPrice float64 `json:"total_input_price"` // 进价总金额
	TotalPrice      float64 `json:"total_price"`       // 总金额
	Specifications  string  `json:"specifications"`    // 规格
	Image           string  `json:"image"`             // 图片地址
}

type OrderLog struct {
	ReceiverAddress  string  `json:"receiver_address"`  // 详细地址
	Cost             float64 `json:"cost"`              // 运费成本
	Offer            float64 `json:"offer"`             // 运费报价
	ReceiverName     string  `json:"receiver_name"`     // 收货人
	ReceiverProvince string  `json:"receiver_province"` //省
	ReceiverCity     string  `json:"receiver_city"`     //市
	ReceiverDistrict string  `json:"receiver_district"` //县/区
	ReceiverIphone   string  `json:"receiver_iphone"`   // 收货联系方式
	LogisticsCompany string  `json:"logistics_company"` //物流公司
	LogisticsNumber  string  `json:"logistics_number"`  //物流单号
}

//取消订单
type OrderCancelParam struct {
	UserID  uint32 //用户ID
	OrderId string //被取消的订单ID
}

//删除订单
type OrderDeleteParam struct {
	ShopID  uint64 //商铺ID
	OrderId string //被删除的订单ID
}

//搜索订单
type OrderSearchParam struct {
	ShopID      uint64 `json:"shop_id"`      //商铺ID
	InputTerms  string `json:"input_terms"`  //搜索输入词
	OrderStatus int    `json:"order_status"` //订单状态0待确认1待发货2已发货3已完成255查看全部
	StartIndex  int    `json:"start_index"`  //分页查询初始索引
	OrderCount  int    `json:"order_count"`  //页内个数

}

//搜索结果订单id列表
type OrderSearchList struct {
	OrderId string `json:"order_id"` //商品名称匹配 或者 买家昵称匹配
}

//确认订单
type OrderComfirmParam struct {
	UserID  uint32 `json:"user_id"`  //店主ID
	ShopID  uint64 `json:"shop_id"`  //商铺ID
	OrderId string `json:"order_id"` //确认的订单ID
}

//订单收款和退款
type OrderCollectionOrReturnParam struct {
	ShopID  uint64  `json:"shop_id"`  //商铺ID
	OrderId string  `json:"order_id"` //订单ID
	Aomoney float64 `json:"aomoney"`  //金额 大于0表示收 小于0表示退
	Remarks string  `json:"remarks"`  //备注
}

type OrderPayPrice struct {
	PPrice null.Float `json:"p_price"` //已支付的金额
	Price  null.Float `json:"price"`   //总售价
	Ispay  int32      `json:"ispay"`   //是否已全部支付
}

//查看收退款流水订单
type OrderBillParam struct {
	ShopID  uint64 //商铺ID
	OrderId string //订单ID
}

//查看订单账单流水记录应答
type OrderLookUpBillRes struct {
	Last        null.Float  `json:"last"`         //变动后的金额
	ChangeValue null.Float  `json:"change_value"` //变动的金额
	Remarks     null.String `json:"remarks"`      //备注
	CreateTime  entity.Time `json:"create_time"`  // 创建时间
}

//修改标记未完成订单
type OrderModifyIncompleteParam struct {
	OrderId     string `json:"order_id"`     //订单编号
	OrderStatus int32  `json:"order_status"` //设置订单状态
}

//订单收益统计
type OrderRevenueStatistics struct {
	OrderId         string  `json:"order_id"`          //订单编号
	TotalInputPrice float64 `json:"total_input_price"` // 进价总价
	TotalPrice      float64 `json:"total_price"`       // 销售总价（单价*数量）
}

//修改收货地址
type OrderModifyAddressParam struct {
	OrderId          string `json:"order_id"`          //订单ID
	ReceiverName     string `json:"receiver_name"`     //收货人
	ReceiverIphone   string `json:"receiver_iphone"`   //联系号码
	ReceiverProvince string `json:"receiver_province"` //省
	ReceiverCity     string `json:"receiver_city"`     //市
	ReceiverDistrict string `json:"receiver_district"` //县/区
	ReceiverAddress  string `json:"receiver_address"`  //收货详细地址
}

//修改订单信息
type ModifyOrderParam struct {
	OrderId           string   `json:"order_id"`           // 订单编号
	ShopID            uint64   `json:"shop_id"`            // 卖家用户编号
	UserID            uint32   `json:"user_id"`            // 买家用户编号
	NickName          string   `json:"nick_name"`          // 买家昵称
	Price             float64  `json:"price"`              // 总金额
	PayPrice          float64  `json:"pay_price"`          // 总收取金额
	PreferentialPrice float64  `json:"preferential_price"` // 优惠金额
	Remark            string   `json:"remark"`             // 买家备注
	Profit            float64  `json:"profit"`             // 订单利润
	OrdersLogistics   OrderLog //地址信息
	OrderGoodsInfo    []OrderGoods
}

//发货订单
type OrderDeliverParam struct {
	// ShopID           uint64                `json:"shop_id"`            // 商铺id
	OrderId          string   `json:"order_id"`           // 订单编号
	ExpressCompanyId uint32   `json:"express_company_id"` // 快递公司ID 0表示人工寄货
	OrderGoodsId     []uint32 `json:"order_goods_id"`     // 订单商品编号为空表示全部发货
	ExpressNumber    string   `json:"express_number"`     // 物流单号
	// Offer            float64               `json:"offer"`              // 快递成本
	// Cost             float64               `json:"cost"`               // 快递报价
	Receiver *kuaidi.LogisticOrder `json:"receiver"` // 收件人信息
	Sender   *kuaidi.LogisticOrder `json:"sender"`   // 寄件人信息
}

//查看订单物流消息
type OrderLogisticsParam struct {
	OrderId     string  `json:"order_id"`     // 订单编号
	LogisticsID *uint32 `json:"logistics_id"` // 快递物流id
}

//查看订单物流记录应答
type OrderLogisticsResp struct {
	ThirdPartyID     int32  //第三方平台编号
	LogisticsCompany string //物流公司
	LogisticsCom     string //物流公司编码
	LogisticsNumber  string //物流单号
	LogisticsRecords string //物流记录信息 json格式
}

type UserAndShopId struct {
	ShopID uint64
	UserID uint32
}

//判断是否为店主
func (us *UserAndShopId) IsShopkeeper() bool {
	return us.ShopID == uint64(us.UserID) && us.ShopID != 0
}

//查看订单列表请求
type ModelCheckOrderReq struct {
	ShopID      uint64 `json:"shop_id"`      //商铺ID 传0表示买家查看
	OrderStatus int    `json:"order_status"` //订单状态0待确认1待发货2已发货3已完成255查看全部
	StartIndex  int    `json:"start_index"`  //分页查询初始索引
	OrderCount  int    `json:"order_count"`  //页内个数
}

//查看订详情请求
type ModelCheckOrderDetailReq struct {
	OrderId string `json:"order_id"` //查看的指定订单编号
}

//完成订单时查询
type ModelOrderResp struct {
	OrderId      string       `json:"order_id"`       //查看的指定订单编号
	ShopID       uint64       `json:"shop_id"`        //商铺ID
	UserID       uint32       `json:"user_id"`        // 买家用户编号
	Price        float64      `json:"price"`          // 总金额
	Profit       float64      `json:"profit"`         // 订单利润
	CreatedAt    *entity.Time `json:"created_at"`     // 创建时间
	GoodsNameArr string       `json:"goods_name_arr"` // 订单商品名称
}

//ModelCheckOrder 查询订单详情列表
//
//searchOrderId 查询条件指定订单id信息，可为nil
//agentid 查询所在的（店铺ID）代购ID
func ModelCheckOrder(reqParam *ModelCheckOrderReq, shop_user *UserAndShopId) (allData []*CheckOrderRes, err error) {
	var sql_buf bytes.Buffer
	sql := " SELECT a.*,a.created_at as create_time,c.quantity,c.single_price,c.goods_name,c.total_price,c.specifications,c.image,d.receiver_address,d.offer,d.receiver_name,d.receiver_iphone,d.receiver_province,d.receiver_city,d.receiver_district,d.logistics_company,d.logistics_number,"
	sql_buf.WriteString(sql)
	if shop_user.IsShopkeeper() {
		sql_buf.WriteString(" b.nick_name as object_name,b.avatar_url ")

		sql_buf.WriteString(fmt.Sprintf(" FROM ( SELECT * FROM orders where status=1 and shop_id=%d ", shop_user.ShopID))
	} else {
		sql_buf.WriteString(" b.shop_name as object_name,b.shop_url as avatar_url ")
		sql_buf.WriteString(fmt.Sprintf(" FROM ( SELECT * FROM orders where status=1 and user_id=%d", shop_user.UserID))
	}
	//订单状态条件
	if reqParam.OrderStatus != 255 {
		sql_buf.WriteString(fmt.Sprintf(" and order_status=%d", reqParam.OrderStatus))
	}

	sql_buf.WriteString(fmt.Sprintf(" ORDER BY created_at desc LIMIT %d OFFSET %d ) as a ", reqParam.OrderCount, reqParam.StartIndex))

	if shop_user.IsShopkeeper() {
		sql_buf.WriteString(" left join user as b on a.user_id = b.user_id")
	} else {
		sql_buf.WriteString(" left join shop_info as b on a.shop_id = b.shop_id")
	}

	sql_buf.WriteString(fmt.Sprintf(" left join orders_goods  as c on a.order_id = c.order_id left join orders_logistics as d on a.order_id = d.order_id and d.is_default=1 and c.status=%d", OG_NORMAL))

	sql_buf.WriteString(" ORDER BY a.created_at desc ")
	dbResult := dbGorm.Raw(sql_buf.String())
	//得到不重复订单数据列表
	allData = make([]*CheckOrderRes, 0)
	query_data := []*QueryOrderList{}
	dbResult.Scan(&query_data) //查询

	if dbResult.Error != nil {
		err = errors.New("订单不存在")
		return
	}
	if len(query_data) == 0 {
		return
	}
	//获取订单个数
	orderssMap := map[string]int{} //key=订单id value=订单所属的商品数
	for i := 0; i < len(query_data); i++ {
		orderssMap[query_data[i].OrderId]++
	}

	//得到不重复订单数据列表
	allData = make([]*CheckOrderRes, len(orderssMap))
	var all_index int = 0
	for _, q_value := range query_data {
		if respParse, errTemp := gjson.DecodeToJson(q_value.Image); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			q_value.Image = default_img_str[0] //只取默认封面图片
		}
		//判断是否重复插入
		if func() bool {
			for _, all_value := range allData {
				if all_value != nil && all_value.OrderId == q_value.OrderId {
					all_value.OrderGoodsInfo = append(all_value.OrderGoodsInfo, &OrderGoods{
						OrderId:         q_value.OrderId,
						Quantity:        q_value.Quantity,
						InputPrice:      q_value.InputPrice,
						SinglePrice:     q_value.SinglePrice,
						GoodsName:       q_value.GoodsName,
						TotalInputPrice: q_value.TotalInputPrice,
						TotalPrice:      q_value.TotalPrice,
						Specifications:  q_value.Specifications,
						Image:           q_value.Image,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}
		allData[all_index] = &CheckOrderRes{
			OrderId:     q_value.OrderId,
			ShopId:      q_value.ShopID,
			UserId:      q_value.UserID,
			AvatarUrl:   q_value.AvatarUrl,
			ObjectName:  q_value.ObjectName,
			OrderStatus: q_value.OrderStatus,
			Price:       q_value.Price,
			Remark:      q_value.Remark,
			CreateTime:  q_value.CreateTime,
			OrdersLogistics: OrderLog{
				ReceiverAddress:  q_value.ReceiverAddress,
				Cost:             q_value.Cost,
				Offer:            q_value.Offer,
				ReceiverName:     q_value.ReceiverName,
				ReceiverProvince: q_value.ReceiverProvince,
				ReceiverCity:     q_value.ReceiverCity,
				ReceiverDistrict: q_value.ReceiverDistrict,
				ReceiverIphone:   q_value.ReceiverIphone,
				LogisticsCompany: q_value.LogisticsCompany,
				LogisticsNumber:  q_value.LogisticsNumber,
			},
		}

		allData[all_index].OrderGoodsInfo = append(allData[all_index].OrderGoodsInfo, &OrderGoods{
			OrderId:         q_value.OrderId,
			Quantity:        q_value.Quantity,
			InputPrice:      q_value.InputPrice,
			SinglePrice:     q_value.SinglePrice,
			GoodsName:       q_value.GoodsName,
			TotalInputPrice: q_value.TotalInputPrice,
			TotalPrice:      q_value.TotalPrice,
			Specifications:  q_value.Specifications,
			Image:           q_value.Image,
		})

		all_index++
	}
	return
}

//search 按用户昵称或者店铺名称、商品名称搜索订单
func ModelCheckOrderSearch(reqParam *OrderSearchParam, orderId string, shop_user *UserAndShopId) (allData []*CheckOrderRes, err error) {
	allData = make([]*CheckOrderRes, 0)
	var sql_buf bytes.Buffer
	sql := "SELECT a.*,c.quantity,c.single_price,c.goods_name,c.total_price,c.specifications,c.image,d.receiver_address,d.offer,d.receiver_name,d.receiver_iphone,d.receiver_province,d.receiver_city,d.receiver_district,d.logistics_company,d.logistics_number FROM ( SELECT  f.*,f.created_at as create_time,"
	sql_buf.WriteString(sql)
	if shop_user.IsShopkeeper() {
		sql_buf.WriteString(fmt.Sprintf(" b.nick_name as object_name,b.avatar_url  FROM orders as f left join user as b on f.user_id = b.user_id  where f.status=1 and f.shop_id=%d and (b.nick_name like '%s' or f.goods_name_arr like '%s' or f.order_id =%s) ", shop_user.ShopID, reqParam.InputTerms, reqParam.InputTerms, orderId))
	} else {
		sql_buf.WriteString(fmt.Sprintf(" b.shop_name as object_name,b.shop_url as avatar_url FROM orders as f  left join shop_info as b on f.shop_id = b.shop_id where f.status=1 and f.user_id=%d and (b.shop_name like '%s' or f.goods_name_arr like '%s' or f.order_id =%s) ", shop_user.UserID, reqParam.InputTerms, reqParam.InputTerms, orderId))
	}
	//左连接语句
	left_join_tb := fmt.Sprintf(" left join orders_goods  as c on a.order_id = c.order_id left join orders_logistics as d on a.order_id = d.order_id and d.is_default=1 and c.status=%d", OG_NORMAL)

	// //订单状态条件 订单个数
	// if reqParam.OrderStatus != 255 {
	// 	sql_buf.WriteString(fmt.Sprintf(" and order_status=%d", reqParam.OrderStatus))
	// 	if reqParam.OrderStatus == int(OSTBC) || reqParam.OrderStatus == int(OSTBD) {
	// 		//获取搜索订单总个数
	// 		var sql_select_count_buf bytes.Buffer
	// 		sql_select_count_buf.WriteString(sql_buf.String())
	// 		sql_select_count_buf.WriteString(" ) as a")
	// 		sql_select_count_buf.WriteString(left_join_tb)
	// 		select_count_db := dbGorm.Raw(sql_select_count_buf.String())
	// 		query_count_data := []*QueryOrderList{}
	// 		if select_count_db.Scan(&query_count_data).Error == nil {
	// 			//获取搜索订单总数
	// 			orderssMapTemp := map[string]int{} //key=订单id value=订单所属的商品数
	// 			for i := 0; i < len(query_count_data); i++ {
	// 				orderssMapTemp[query_count_data[i].OrderId]++
	// 			}
	// 			select_count = len(orderssMapTemp)
	// 		}
	// 	}
	// }

	sql_limit := fmt.Sprintf(" LIMIT %d OFFSET %d ", reqParam.OrderCount, reqParam.StartIndex)

	sql_buf.WriteString(fmt.Sprintf(" ORDER BY created_at desc %s ) as a ", sql_limit))

	sql_buf.WriteString(left_join_tb)
	dbResult := dbGorm.Raw(sql_buf.String())

	query_data := []*QueryOrderList{}
	dbResult.Scan(&query_data)
	if dbResult.Error != nil {
		err = errors.New("订单不存在")
		return
	}
	if len(query_data) == 0 {
		return
	}
	// zaplog.Infof("query_data param:%v", gconv.String(query_data))

	//获取订单个数
	orderssMap := map[string]int{} //key=订单id value=订单所属的商品数
	for i := 0; i < len(query_data); i++ {
		orderssMap[query_data[i].OrderId]++
	}

	//得到不重复订单数据列表
	allData = make([]*CheckOrderRes, len(orderssMap))
	var all_index int = 0
	for _, q_value := range query_data {
		if respParse, errTemp := gjson.DecodeToJson(q_value.Image); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			q_value.Image = default_img_str[0] //只取默认封面图片
		}
		//判断是否重复插入
		if func() bool {
			for _, all_value := range allData {
				if all_value != nil && all_value.OrderId == q_value.OrderId {
					all_value.OrderGoodsInfo = append(all_value.OrderGoodsInfo, &OrderGoods{
						OrderId:         q_value.OrderId,
						Quantity:        q_value.Quantity,
						InputPrice:      q_value.InputPrice,
						SinglePrice:     q_value.SinglePrice,
						GoodsName:       q_value.GoodsName,
						TotalInputPrice: q_value.TotalInputPrice,
						TotalPrice:      q_value.TotalPrice,
						Specifications:  q_value.Specifications,
						Image:           q_value.Image,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}

		allData[all_index] = &CheckOrderRes{
			OrderId:     q_value.OrderId,
			ShopId:      q_value.ShopID,
			UserId:      q_value.UserID,
			AvatarUrl:   q_value.AvatarUrl,
			ObjectName:  q_value.ObjectName,
			OrderStatus: q_value.OrderStatus,
			Price:       q_value.Price,
			Remark:      q_value.Remark,
			CreateTime:  q_value.CreateTime,
			OrdersLogistics: OrderLog{
				ReceiverAddress:  q_value.ReceiverAddress,
				Cost:             q_value.Cost,
				Offer:            q_value.Offer,
				ReceiverName:     q_value.ReceiverName,
				ReceiverProvince: q_value.ReceiverProvince,
				ReceiverCity:     q_value.ReceiverCity,
				ReceiverDistrict: q_value.ReceiverDistrict,
				ReceiverIphone:   q_value.ReceiverIphone,
				LogisticsCompany: q_value.LogisticsCompany,
				LogisticsNumber:  q_value.LogisticsNumber,
			},
		}

		allData[all_index].OrderGoodsInfo = append(allData[all_index].OrderGoodsInfo, &OrderGoods{
			OrderId:         q_value.OrderId,
			Quantity:        q_value.Quantity,
			InputPrice:      q_value.InputPrice,
			SinglePrice:     q_value.SinglePrice,
			GoodsName:       q_value.GoodsName,
			TotalInputPrice: q_value.TotalInputPrice,
			TotalPrice:      q_value.TotalPrice,
			Specifications:  q_value.Specifications,
			Image:           q_value.Image,
		})
		all_index++
	}
	return
}

//统计订单状态为未确认和待发货的订单总数
func ModelCheckOrderCount(OrderStatus []int32, shop_user *UserAndShopId) (orderCount []int32) {
	orderCount = make([]int32, len(OrderStatus))
	for i := 0; i < len(OrderStatus); i++ {
		dbGorm_res := dbGorm.Table("orders").Where("status=1 and order_status =?", OrderStatus[i])
		if shop_user.IsShopkeeper() {
			dbGorm_res = dbGorm_res.Where("shop_id=?", shop_user.ShopID)
		} else {
			dbGorm_res = dbGorm_res.Where("user_id=?", shop_user.UserID)
		}
		dbGorm_res.Count(&orderCount[i])
	}

	return
}

// 查看指定订单详情
//searchOrderId 指定订单id
//返回值 osStatus 表示是否可以操作修改物流信息
func ModelCheckOrderOne(reqParam *ModelCheckOrderDetailReq, shop_user *UserAndShopId) (allData *CheckOrderRes, osStatus uint32, err error) {
	osStatus = 0
	var sql_buf bytes.Buffer
	sql := " SELECT a.order_id,a.shop_id,a.remark,a.price,a.created_at as create_time,c.quantity,c.single_price,c.goods_name,c.total_price,c.input_price,c.total_input_price,c.currency_type,c.specifications,c.image,d.receiver_address,d.cost,d.offer,d.receiver_name,d.receiver_iphone,d.receiver_province,d.receiver_city,d.receiver_district,d.logistics_company,d.logistics_number,"
	sql_buf.WriteString(sql)
	if shop_user.IsShopkeeper() {
		sql_buf.WriteString(" b.cr_nick as object_name,b.cr_headimg as avatar_url,b.customer_id as user_id ")
		sql_buf.WriteString(fmt.Sprintf(" FROM ( SELECT * FROM orders where status=1 and shop_id=%d  ", shop_user.ShopID))
	} else {
		sql_buf.WriteString(" b.shop_name as object_name,b.shop_url as avatar_url,a.user_id ")
		sql_buf.WriteString(fmt.Sprintf(" FROM ( SELECT * FROM orders where status=1 and user_id=%d ", shop_user.UserID))
	}
	sql_buf.WriteString(fmt.Sprintf(" and order_id=%s) as a ", reqParam.OrderId))

	if shop_user.IsShopkeeper() {
		sql_buf.WriteString(" left join h_customer as b on a.customer_id = b.customer_id")
	} else {
		sql_buf.WriteString(" left join shop_info as b on a.shop_id = b.shop_id")
	}

	sql_buf.WriteString(" left join orders_goods  as c on a.order_id = c.order_id left join orders_logistics as d on a.order_id = d.order_id and d.is_default=1 ")

	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := []*QueryOrderList{}
	allData = &CheckOrderRes{}
	dbResult.Scan(&query_data)
	if dbResult.Error != nil {
		err = errors.New("订单不存在")
		return
	}
	if len(query_data) == 0 {
		return
	}

	q_value := query_data[0]
	if q_value == nil {
		return
	}
	allData = &CheckOrderRes{
		OrderId:     q_value.OrderId,
		ShopId:      q_value.ShopID,
		UserId:      q_value.UserID,
		AvatarUrl:   q_value.AvatarUrl,
		ObjectName:  q_value.ObjectName,
		OrderStatus: q_value.OrderStatus,
		Price:       q_value.Price,
		Remark:      q_value.Remark,
		CreateTime:  q_value.CreateTime,
		OrdersLogistics: OrderLog{
			ReceiverAddress:  q_value.ReceiverAddress,
			Cost:             q_value.Cost,
			Offer:            q_value.Offer,
			ReceiverName:     q_value.ReceiverName,
			ReceiverProvince: q_value.ReceiverProvince,
			ReceiverCity:     q_value.ReceiverCity,
			ReceiverDistrict: q_value.ReceiverDistrict,
			ReceiverIphone:   q_value.ReceiverIphone,
			LogisticsCompany: q_value.LogisticsCompany,
			LogisticsNumber:  q_value.LogisticsNumber,
		},
	}

	//得到所有订单商品列表信息
	arrGoods := make([]*OrderGoods, len(query_data))
	for k, _data := range query_data {
		if respParse, errTemp := gjson.DecodeToJson(_data.Image); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			_data.Image = default_img_str[0] //只取默认封面图片
		}
		arrGoods[k] = &OrderGoods{
			OrderId:         _data.OrderId,
			Quantity:        _data.Quantity,
			InputPrice:      _data.InputPrice,
			SinglePrice:     _data.SinglePrice,
			GoodsName:       _data.GoodsName,
			TotalInputPrice: _data.TotalInputPrice,
			TotalPrice:      _data.TotalPrice,
			Specifications:  _data.Specifications,
			Image:           _data.Image,
		}
	}

	//按订单编号筛选出订单数据，再保存订单商品数组
	var goods_count int
	allData.OrderGoodsInfo = make([]*OrderGoods, len(query_data))
	goods_count = 0
	for _, aGoods := range arrGoods {
		if aGoods.OrderId == allData.OrderId {
			allData.OrderGoodsInfo[goods_count] = aGoods
			goods_count++
			if goods_count >= len(query_data) {
				break
			}
		}
	}

	//判断是否可以修改物流信息
	_ol_data := entity.OrdersLogistics{}
	dbGorm.Table("orders_logistics").Where("order_id=? and is_default=1 and status=0", q_value.OrderId).First(&_ol_data)
	if _ol_data.ID > 0 {
		osStatus = 1 //能操作
	}
	return
}

//ModelCancelOrder 取消订单
func ModelCancelOrder(param *OrderCancelParam) (err error) {
	//通过订单编号 取消指定的数据
	if returnData := dbGorm.Table("orders").Where("user_id=? and order_id=? and order_status=?", param.UserID, param.OrderId, OSTBC).Update("status", -1); returnData.Error == nil {
		if returnData.RowsAffected == 0 {
			return errors.New("重复取消")
		}
		return nil
	}
	return errors.New("取消失败，具体原因请联系客服")
}

//ModelDeleteOrder 删除订单
func ModelDeleteOrder(param *OrderDeleteParam) (err error) {
	//通过订单编号删除指定的数据
	if returnData := dbGorm.Table("orders").Where("shop_id=? and order_id=?", param.ShopID, param.OrderId).Update("status", -1); returnData.Error == nil {
		return nil
	}
	return errors.New("删除失败，具体原因请联系客服")
}

//removeRepByMap slice去重
func removeRepByMap(slc []*string) []*string {
	result := []*string{}        //存放返回的不重复切片
	tempMap := map[string]byte{} // 存放不重复主键
	for _, e := range slc {
		l := len(tempMap)
		tempMap[*e] = 0 //当e存在于tempMap中时，再次添加是添加不进去的，，因为key不允许重复
		//如果上一行添加成功，那么长度发生变化且此时元素一定不重复
		if len(tempMap) != l { // 加入map后，map长度变化，则元素不重复
			result = append(result, e) //当元素不重复时，将元素添加到切片result中
		}
	}
	return result
}

//查询搜索不同类型关键字得到的订单编号
//searchType 搜索类型，1按商品名称，2按用户或者店铺名称
//user_id 买家id,买家搜索的时候有值，反之没有
func ModelSearchOrderSub(param *OrderSearchParam, searchType int, user_id uint32) (order_id_List []*string) {
	order_id_List = []*string{}
	dbResult := dbGorm.Table("orders as a").Select("a.order_id").Where("a.status=1") //distinct(a.order_id) as
	if user_id == 0 {
		switch searchType {
		case 1:
			//卖家搜索
			dbResult = dbResult.Joins("Left Join orders_goods as b ON a.order_id=b.order_id").Where("b.goods_name like ? and a.shop_id=?", param.InputTerms, param.ShopID)
		case 2:
			//买家搜索
			dbResult = dbResult.Joins("Left Join user as b ON a.user_id=b.user_id").Where("b.nick_name like ? and a.shop_id=?", param.InputTerms, param.ShopID)
		default:
			return
		}
	} else {
		switch searchType {
		case 1:
			//卖家搜索
			dbResult = dbResult.Joins("Left Join orders_goods as b ON a.order_id=b.order_id").Where("b.goods_name like ? and a.user_id=?", param.InputTerms)
		case 2:
			//买家搜索
			dbResult = dbResult.Joins("Left Join shop_info as b ON a.shop_id=b.shop_id").Where("b.shop_name like ? and a.user_id=?", param.InputTerms)
		default:
			return
		}
	}

	//按订单状态查询
	if param.OrderStatus != 255 {
		dbResult = dbResult.Where("a.order_status =?", param.OrderStatus)
	}
	orderid_list := []OrderSearchList{}
	dbResult = dbResult.Order("a.created_at desc").Limit(param.OrderCount).Offset(param.StartIndex).Scan(&orderid_list)
	if dbResult.Error != nil {
		return
	}
	order_id_List = make([]*string, len(orderid_list))
	for i, _order := range orderid_list {
		order_id_List[i] = &_order.OrderId
	}
	return
}

//ModelSearchOrder 搜索订单
//param 搜索关键字和所在代购ID
func ModelSearchOrder(param *OrderSearchParam, shop_user *UserAndShopId) (order_id_List []*string) {
	order_id_List = []*string{}
	_count_type := 2
	_userid := uint32(0)
	order_id_ListTemp := make([]*string, 0)
	if !shop_user.IsShopkeeper() {
		_userid = shop_user.UserID
	}
	for i := 0; i < _count_type; i++ {
		OrderId := ModelSearchOrderSub(param, i+1, _userid)
		order_id_ListTemp = append(order_id_ListTemp, OrderId...)
	}

	order_id_List = removeRepByMap(order_id_ListTemp)

	return
}

//根据订单id获取所属店铺ID
func GetOrderIdToShopId(OrderId string) (shopId uint64) {
	_orders := entity.Orders{}
	if err := dbGorm.Table("orders").Where("order_id=?", OrderId).First(&_orders).Error; err == nil {
		shopId = _orders.ShopID
	}
	return
}

//ModelComfirmOrder 通过订单编号确认指定订单
func ModelComfirmOrder(param *OrderComfirmParam) (orderInfo *ModelOrderResp, msg string, err error) {

	if shopvip, err := IsSeeMember(param.UserID); shopvip.IsMember == 0 && err == nil {
		shopvipcount, err := ShopVipExplain(1, shopvip.IsMember)
		if err != nil {
			return nil, "", err
		}
		if ordercount, err := OrderCount(param.ShopID); ordercount.OrderCount >= shopvipcount.OrdinaryExplain && err == nil {
			msg = "您还不是VIP用户，一天只能进行3单操作!"
			return nil, msg, nil
		}
	}

	if returnData := dbGorm.Table("orders").Where("order_id=? and shop_id=? and status=1", param.OrderId, param.ShopID).Updates(map[string]interface{}{"order_status": OSTBD, "confirm_time": time.Now(), "ispay": 1}); returnData.Error == nil {
		if returnData.RowsAffected == 0 {
			msg = "订单不存在，具体原因请联系客服"
			return nil, msg, nil
		}
		orderInfo = &ModelOrderResp{}
		err = dbGorm.Table("orders").Select("order_id,user_id,price,profit,created_at,goods_name_arr").Where("order_id=? and shop_id=?", param.OrderId, param.ShopID).Scan(orderInfo).Error
		if err != nil {
			zaplog.Errorf("ModelComfirmOrder 订单查询 Db err:%s", err)
			return nil, "", err
		}
		// if ordersprofit := dbGorm.Table("shop_profit").Create(&entity.ShopProfit{OrderID: param.OrderId, UserID: orderInfo.UserID, ShopID: param.ShopID, Price: orderInfo.Price, Profit: orderInfo.Profit}); ordersprofit.Error != nil {
		// 	zaplog.Errorf("ModelComfirmOrder 订单利润 Db err:%s", err)
		// 	return nil, "", err
		// }
		// if shopfans := dbGorm.Table("shop_fans").Where("user_id=? and shop_id=?", orderInfo.UserID, param.ShopID).Update(map[string]interface{}{"transaction_number": gorm.Expr("transaction_number + ?", 1), "transaction_amount": gorm.Expr("transaction_amount + ?", orderInfo.Price), "end_time": orderInfo.CreatedAt}); shopfans.Error != nil {
		// 	zaplog.Errorf("ModelComfirmOrder 我的粉丝 Db err:%s", err)
		// 	return nil, "", err
		// }
		// has, err := dbXorm.Table("shop_wallet").Where("shop_id=? AND DATE_FORMAT(created_at,'%Y%m') = DATE_FORMAT(CURDATE(),'%Y%m')", param.ShopID).Exist()
		// if has {
		// 	if shopwallet := dbGorm.Table("shop_wallet").Where("shop_id=? AND DATE_FORMAT(created_at,'%Y%m') = DATE_FORMAT(CURDATE(),'%Y%m')", param.ShopID).Update(map[string]interface{}{"month_orders": gorm.Expr("month_orders + ?", 1), "month_profit": gorm.Expr("month_profit + ?", orderInfo.Profit), "month_cost": gorm.Expr("month_cost + ?", orderInfo.Price-orderInfo.Profit)}); shopwallet.Error != nil {
		// 		zaplog.Errorf("ModelComfirmOrder 我的钱包 Db err:%s", err)
		// 		return nil, "", err
		// 	}
		// } else {
		// 	if shopwallet := dbGorm.Table("shop_wallet").Create(&entity.ShopWallet{ShopID: param.ShopID, MonthOrders: 1, MonthProfit: orderInfo.Profit, MonthCost: orderInfo.Price - orderInfo.Profit}); shopwallet.Error != nil {
		// 		zaplog.Errorf("ModelComfirmOrder 我的钱包 Db err:%s", err)
		// 		return nil, "", err
		// 	}
		// }
		return orderInfo, msg, err
	}
	return nil, "确认订单失败，具体原因请联系客服", nil
}

//ModelGetOpenId 通过订单编号获取用户的openid
func ModelGetOpenId(orderId string) (openId string, err error) {
	_orderInfo := entity.Orders{}
	_userInfo := entity.User{}
	if returnData := dbGorm.Table("orders").Where("order_id=?", orderId).First(&_orderInfo); returnData.Error == nil {
		if err = dbGorm.Table("user").Where("user_id=?", _orderInfo.UserID).Select("open_id").First(&_userInfo).Error; err == nil {
			openId = _userInfo.OpenID
			return
		}
	}
	return "", errors.New("获取用户信息失败")
}

//ModelCollectionOrReturnOrder 收款或退款编辑
func ModelCollectionOrReturnOrder(param *OrderCollectionOrReturnParam) error {
	var resErr error
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if resErr != nil {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//获取变化前金额
		_orderPayPrice := OrderPayPrice{}
		rRecord := tx.Table("orders").Select("pay_price as p_price,price,ispay").Where("shop_id=? and order_id=? and status=1", param.ShopID, param.OrderId).Scan(&_orderPayPrice)
		if rRecord.Error != nil {
			resErr = errors.New("订单不存在，具体原因请联系客服")
			return resErr
		}
		//更新订单变动款项
		if rowCount := tx.Table("orders").Where("shop_id=? and order_id=? and status=1", param.ShopID, param.OrderId).Updates(g.Map{"pay_price": gorm.Expr("pay_price  + ?", param.Aomoney), "pay_time": time.Now()}).RowsAffected; rowCount == 0 {
			resErr = errors.New("订单不存在，具体原因请联系客服")
			return resErr
		} else {
			//更新是否支付全部金额
			if _orderPayPrice.PPrice.Float64+param.Aomoney == _orderPayPrice.Price.Float64 {
				tx.Table("orders").Where("shop_id=? and order_id=? and  price=pay_price  and status=1", param.ShopID, param.OrderId).Update("ispay", 1)
			} else if _orderPayPrice.Ispay == 1 {
				tx.Table("orders").Where("shop_id=? and order_id=? and  price>pay_price  and status=1", param.ShopID, param.OrderId).Update("ispay", 0)
			}

			//记录收款或退款流水 未完成 2020-6-2 add lyh
			tb_orders_bill_flow := tx.Table("orders_bill_flow")
			flowEntity := &entity.OrdersBillFlow{
				OrderID:     param.OrderId,
				Before:      _orderPayPrice.PPrice,
				Last:        null.FloatFrom(_orderPayPrice.PPrice.Float64 + param.Aomoney),
				ChangeValue: null.FloatFrom(param.Aomoney),
				Remarks:     null.StringFrom(param.Remarks),
			}
			if resErr = tb_orders_bill_flow.Create(flowEntity).Error; resErr != nil {
				return resErr
			}
			return resErr
		}
	}
	resErr = errors.New("订单收款失败，具体原因请联系客服")
	return resErr
}

//ModelLookUpBillOrder 查看订单账单流水
func ModelLookUpBillOrder(param *OrderBillParam) (res []*OrderLookUpBillRes, err error) {
	//校验是否该订单是当前店铺的 目前不确认
	//限制流水记录条数，防止历史数据太大
	res = []*OrderLookUpBillRes{}
	if dbResult := dbGorm.Table("orders_bill_flow").Select("*,created_at as create_time").Where("order_id=? ", param.OrderId).Limit(30).Order("created_at desc").Find(&res); dbResult.Error != nil {
		err = errors.New("查询失败")
		return
	}
	return
}

//ModelModifyStatusOrder 修改标记为未完成或完成订单
func ModelModifyStatusOrder(tx *gorm.DB, param *OrderModifyIncompleteParam) (err error) {
	// _order_status := OSTBC
	// if int32(param.OrderStatus) == OSC {
	// 	_order_status = OSD
	// } else if int32(param.OrderStatus) == OSD {
	// 	_order_status = OSC
	// } else {
	// 	return errors.New("订单状态设置非法，具体原因请联系客服")
	// }
	// order_status=? and
	// _order_status,
	tb := &gorm.DB{}
	if tx == nil {
		tb = dbGorm
	} else {
		tb = tx
	}
	if tb = tb.Table("orders").Where(" status=1 and order_id=? ", param.OrderId).Update(map[string]interface{}{"order_status": param.OrderStatus, "complete_time": time.Now()}); tb.Error != nil {
		return errors.New("订单不存在或者未发货，具体原因请联系客服")
	}
	return
}

func InsertData(param *OrderRevenueStatistics) (err error) {
	orderInfo := &ModelOrderResp{}
	err = dbGorm.Table("orders").Select("user_id,created_at,shop_id").Where("order_id=? ", param.OrderId).Scan(orderInfo).Error
	if err != nil {
		zaplog.Errorf("ModelComfirmOrder 订单查询 Db err:%s", err)
		return err
	}
	if ordersprofit := dbGorm.Table("shop_profit").Create(&entity.ShopProfit{OrderID: param.OrderId, UserID: orderInfo.UserID, ShopID: orderInfo.ShopID, Price: param.TotalPrice, Profit: param.TotalPrice - param.TotalInputPrice}); ordersprofit.Error != nil {
		zaplog.Errorf("ModelComfirmOrder 订单利润 Db err:%s", err)
		return err
	}
	if shopfans := dbGorm.Table("shop_fans").Where("user_id=? and shop_id=?", orderInfo.UserID, orderInfo.ShopID).Update(map[string]interface{}{"transaction_number": gorm.Expr("transaction_number + ?", 1), "transaction_amount": gorm.Expr("transaction_amount + ?", param.TotalPrice), "end_time": orderInfo.CreatedAt}); shopfans.Error != nil {
		zaplog.Errorf("ModelComfirmOrder 我的粉丝 Db err:%s", err)
		return err
	}
	has, err := dbXorm.Table("shop_wallet").Where("shop_id=? AND DATE_FORMAT(created_at,'%Y%m') = DATE_FORMAT(CURDATE(),'%Y%m')", orderInfo.ShopID).Exist()
	if has {
		if shopwallet := dbGorm.Table("shop_wallet").Where("shop_id=? AND DATE_FORMAT(created_at,'%Y%m') = DATE_FORMAT(CURDATE(),'%Y%m')", orderInfo.ShopID).Update(map[string]interface{}{"month_orders": gorm.Expr("month_orders + ?", 1), "month_profit": gorm.Expr("month_profit + ?", param.TotalPrice-param.TotalInputPrice), "month_cost": gorm.Expr("month_cost + ?", param.TotalInputPrice)}); shopwallet.Error != nil {
			zaplog.Errorf("ModelComfirmOrder 我的钱包 Db err:%s", err)
			return err
		}
	} else {
		if shopwallet := dbGorm.Table("shop_wallet").Create(&entity.ShopWallet{ShopID: orderInfo.ShopID, MonthOrders: 1, MonthProfit: param.TotalPrice - param.TotalInputPrice, MonthCost: param.TotalInputPrice}); shopwallet.Error != nil {
			zaplog.Errorf("ModelComfirmOrder 我的钱包 Db err:%s", err)
			return err
		}
	}
	return
}

//ModelModifyAddressOrder 修改订单收货信息
func ModelModifyAddressOrder(param *OrderModifyAddressParam) (err error) {
	tb_lo := dbGorm.Table("orders_logistics").Where("order_id=? and status =0  and is_default=1", param.OrderId).Updates(g.Map{
		"receiver_name":     param.ReceiverName,
		"receiver_iphone":   param.ReceiverIphone,
		"receiver_province": param.ReceiverProvince,
		"receiver_city":     param.ReceiverCity,
		"receiver_district": param.ReceiverDistrict,
		"receiver_address":  param.ReceiverAddress,
	})
	if err = tb_lo.Error; err != nil {
		return errors.New("订单地址不存在，具体原因请联系客服")
	}
	return
}

//ModelModifyOrder 修改订单信息
func ModelModifyOrder(param *ModifyOrderParam) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		if dbResult := tx.Table("orders").Where("order_id=? and status=1", param.OrderId).Update(g.Map{
			"preferential_price": param.PreferentialPrice,
			"price":              param.Price,
			"profit":             param.Profit,
			"remark":             param.Remark,
		}); dbResult.Error == nil {
			if dbResult.RowsAffected == 1 {
				//修改订单商品详情表 先删除该订单商品信息
				if dbResult = tx.Table("orders_goods").Where("order_id=?", param.OrderId).Unscoped().Delete(&entity.OrdersGoods{}); dbResult.Error != nil {
					isErr = true
					return err
				}
				//重新插入订单商品
				var Buffer bytes.Buffer
				sql := "INSERT INTO `orders_goods` (`created_at`,`updated_at`,`order_id`,`hp_id`,`hgs_id`,`logistics_id`,`pay_status`,`order_goods_status`,`quantity`,`input_price`,`single_price`,`total_input_price`,`total_price`,`specifications`,`goods_name`,`image`) VALUES "
				Buffer.WriteString(sql)
				curTimeStr := time.Now().Format(timeFormat)
				for i, oginfo := range param.OrderGoodsInfo {
					sql = fmt.Sprintf("('%s','%s','%s',%d,%d,%d,%d,%d,%d,%20.2f,%20.2f,%20.2f,%20.2f,'%s','%s','%s')", curTimeStr, curTimeStr, oginfo.OrderId, 0, 0, 0, 0, PONOBUY, oginfo.Quantity, oginfo.InputPrice, oginfo.SinglePrice, oginfo.TotalInputPrice, oginfo.TotalPrice, oginfo.Specifications, oginfo.GoodsName, oginfo.Image)

					Buffer.WriteString(sql)
					if len(param.OrderGoodsInfo)-1 == i {
						//最后一条数据 以分号结尾
						// sql += (";")
						Buffer.WriteString(";")
					} else {
						// sql += (",")
						Buffer.WriteString(",")
					}
				}
				if err = tx.Table("orders_goods").Exec(Buffer.String()).Error; err != nil {
					isErr = true
					return err
				}
			}
			//插入收货地址信息
			entity_logistics := entity.OrdersLogistics{
				OrderID:          param.OrderId,
				Cost:             null.FloatFrom(param.OrdersLogistics.Cost),
				Offer:            param.OrdersLogistics.Offer,
				ReceiverName:     param.OrdersLogistics.ReceiverName,
				ReceiverIphone:   param.OrdersLogistics.ReceiverIphone,
				ReceiverProvince: null.StringFrom(param.OrdersLogistics.ReceiverProvince),
				ReceiverCity:     null.StringFrom(param.OrdersLogistics.ReceiverCity),
				ReceiverDistrict: null.StringFrom(param.OrdersLogistics.ReceiverDistrict),
				ReceiverAddress:  null.StringFrom(param.OrdersLogistics.ReceiverAddress),
			}
			if dbResult := tx.Table("orders_logistics").Where("order_id=? and is_default=1", param.OrderId).Updates(&entity_logistics); dbResult.Error == nil {
				return
			} else {
				isErr = true
				return errors.New("订单不存在，具体原因请联系客服")
			}
		} else {
			isErr = true
			return errors.New("订单不存在，具体原因请联系客服")
		}
	} else {
		isErr = true
	}
	return
}

//发货微信订阅消息
type OrderLogsInfo struct {
	LogisticsCompany string    `json:"logistics_company"` // 物流公司
	LogisticsNumber  string    `json:"logistics_number"`  // 物流快递单号
	GoodsNameArr     string    `json:"goods_name_arr"`    //订单名称
	OrderID          string    `json:"order_id"`          // 订单编号
	ShipTime         time.Time `json:"ship_time"`         // 发货时间
}

//修改订单状态为完成
func ModelModOrderStatusComplete(_orderId string, logisticsNumber string) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		orderLog_sql := &entity.OrdersLogistics{}
		if dbResult := tx.Where("order_id=? and logistics_number=?", _orderId, logisticsNumber).First(orderLog_sql); dbResult.Error == nil {
			orderGoods_sql := make([]*entity.OrdersGoods, 0)
			if err = tx.Where("order_id=? and logistics_id=? and status=0", _orderId, logisticsNumber).First(&orderGoods_sql).Error; err == nil && len(orderGoods_sql) > 0 {
				//商品订单状态也要更新
				og_id := make([]uint32, len(orderGoods_sql))
				for k, _ := range orderGoods_sql {
					og_id[k] = orderGoods_sql[k].ID
				}
				_, err = HandleCompleteEvent(tx, 1, og_id, PT_COMPLETE, "")
				return
			}
		}
	}
	return errors.New("修改订单状态失败")
}

//判断重复快递包裹发货
func JudgmentRepetitionLogis(param *OrderDeliverParam, shopId uint64) (msg string, err error) {
	if param.ExpressCompanyId == 0 {
		return
	}
	// 如果是同一个快递公司以及快递运单号，那不需要创建（只需更新订单商品绑定物流id），提示有重复快递
	res_express := &entity.ShopExpress{}
	if res_express, msg, err = ModelCheckShopExpress(param.ExpressCompanyId, shopId); err != nil {
		return "", err
	}
	_logts := &entity.OrdersLogistics{}
	if err = dbGorm.Table("orders_logistics").Where("order_id=? and  logistics_company=? and logistics_com=? and logistics_number=?", param.OrderId, res_express.ExpressName, res_express.ExpressCode, param.ExpressNumber).First(_logts).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return "", err
	}
	err = nil
	if _logts.ID > 0 {
		return "已存在相同快递，无法发货", nil
	}
	return
}

//发货处理订单商品状态以及新增物流信息
//isDeliver 表示订单下商品全部发货
func HandleOrderGoodsAndLogistics(tx *gorm.DB, param *OrderDeliverParam) (_logts *entity.OrdersLogistics, isDeliver bool, err error) {
	//获取商铺发货地址
	_logts = &entity.OrdersLogistics{}
	//获取最早的订单物流数据（也就是创建订单时的默认物流信息）
	if err = tx.Where("order_id=? and is_default=1", param.OrderId).First(&_logts).Error; err != nil {
		return nil, false, err
	}

	var og_query *gorm.DB //订单商品数据库操作指针

	_update_Data := map[string]interface{}{} //更新订单商品
	//订单商品状态
	_update_Data["order_goods_status"] = POSD
	_update_Data["updated_at"] = time.Now().Format(timeFormat)
	_update_Data["ship_time"] = time.Now().Format(timeFormat) //发货时间
	if len(param.OrderGoodsId) > 0 {
		//需要创建一行订单物流数据
		if param.ExpressCompanyId == 0 {
			_logts = &entity.OrdersLogistics{}
		} else {
			_logts.ID = 0
			_logts.IsDefault = 0
			_logts.Status = int32(1) //发货请求创建，默认状态收货中
		}
		_logts.OrderID = param.OrderId
		_logts.ReceiverName = param.Receiver.Name
		_logts.ReceiverIphone = param.Receiver.Mobile
		if err = tx.Create(&_logts).Error; err != nil {
			return nil, false, err
		}
		//发货的订单商品绑定创建的物流id
		_update_Data["logistics_id"] = _logts.ID
		og_query = tx.Table("orders_goods").Where("order_id=? and id in(?)", param.OrderId, param.OrderGoodsId).Updates(_update_Data)
		if err = og_query.Error; err != nil {
			return nil, false, err
		}
	} else {
		_update_Data["logistics_id"] = _logts.ID

		og_query = tx.Table("orders_goods").Where("order_id=? and logistics_id =? ", param.OrderId, _logts.ID).Updates(_update_Data)

		if err = og_query.Error; err != nil {
			return nil, false, err
		}
	}
	//查看是否订单下所有商品订单已发货
	_og_data := entity.OrdersGoods{}
	if err = tx.Table("orders_goods").Where("order_id=? and order_goods_status<>?", param.OrderId, POSD).First(&_og_data).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return nil, false, err
	}
	err = nil
	if _og_data.ID == 0 {
		isDeliver = true //已全部发货
	}
	return
}

//发货完成后处理库存
func HandleCompleteStock(tx *gorm.DB, param *OrderDeliverParam, shopId uint64) (err error) {
	//处理库存表商品库存
	//先找到订单商品数据
	_og_data_arr := make([]*entity.OrdersGoods, 0) //"order_goods_status"] = POSD
	_og_tb := tx.Table("orders_goods")
	if len(param.OrderGoodsId) > 0 {
		if err = _og_tb.Where("order_id=? and id in(?) and order_goods_status=?", param.OrderId, param.OrderGoodsId, POSD).Find(&_og_data_arr).Error; err != nil {
			return
		}
	} else {
		if err = _og_tb.Where("order_id=? and order_goods_status=?", param.OrderId, POSD).Find(&_og_data_arr).Error; err != nil {
			return
		}
	}
	if len(_og_data_arr) > 0 {
		_HouseChange := make([]*HandleHouseChangeData, len(_og_data_arr))
		for k, og_data := range _og_data_arr {
			if og_data == nil {
				return
			}
			_HouseChange[k] = &HandleHouseChangeData{
				ShopId:   shopId,
				HgsId:    og_data.HgsID,       //通过商品id获取商品仓库id
				StockNum: og_data.Quantity,    //售卖个数
				Price:    og_data.SinglePrice, //售价
			}
		}
		if err = HandleHouseChange(_HouseChange); err != nil {
			return
		}
	}
	return
}

//ModelDeliverOrder 发货订单
func ModelDeliverOrder(param *OrderDeliverParam, shopId uint64) (resOrder *OrderLogsInfo, msg string, err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//获取商铺发货地址
		_logts := &entity.OrdersLogistics{}
		var _isDeliver bool = false //订单下商品全部发货
		if _logts, _isDeliver, err = HandleOrderGoodsAndLogistics(tx, param); err != nil || _logts == nil {
			isErr = true
			return
		}
		//更新订单物流数据
		_logts_update_Data := map[string]interface{}{}
		//不是自行配送
		if param.ExpressCompanyId != 0 {
			if res_express, _, errExpress := ModelCheckShopExpress(param.ExpressCompanyId, shopId); errExpress == nil {
				_logts_update_Data["logistics_company"] = res_express.ExpressName
				_logts_update_Data["logistics_com"] = res_express.ExpressCode
			}
			_logts_update_Data["sender_name"] = param.Sender.Name
			_logts_update_Data["sender_iphone"] = param.Sender.Mobile
			_logts_update_Data["sender_province"] = param.Sender.ProvinceName
			_logts_update_Data["sender_city"] = param.Sender.CityName
			_logts_update_Data["sender_district"] = param.Sender.ExpAreaName
			_logts_update_Data["sender_address"] = param.Sender.Address

			_logts_update_Data["logistics_number"] = param.ExpressNumber

		} else {
			_logts_update_Data["logistics_company"] = "自行配送"
			_logts_update_Data["logistics_number"] = "无"
		}
		//收货信息
		if param.Receiver != nil {
			_logts_update_Data["receiver_name"] = param.Receiver.Name
			_logts_update_Data["receiver_iphone"] = param.Receiver.Mobile
			_logts_update_Data["receiver_province"] = param.Receiver.ProvinceName
			_logts_update_Data["receiver_city"] = param.Receiver.CityName
			_logts_update_Data["receiver_district"] = param.Receiver.ExpAreaName
			_logts_update_Data["receiver_address"] = param.Receiver.Address
		}
		_logts_update_Data["status"] = 1 //等待收货

		// //历史运费
		// _history_offer := _logts.Offer
		// _history_cost := _logts.Cost.Float64

		// _logts.Cost = null.FloatFrom(param.Cost)
		// _logts.Offer = param.Offer

		//修改订单表
		if dbResult := tx.Table("orders_logistics").Where("id=?", _logts.ID).Updates(_logts_update_Data); dbResult.Error == nil && dbResult.RowsAffected == 1 {
			order_sql := &entity.Orders{}
			if dbResult = tx.Where("order_id=?", param.OrderId).First(order_sql); dbResult.Error == nil {
				//更新订单数据
				_order_update_Data := map[string]interface{}{}
				//订单状态
				_order_update_Data["order_status"] = OSD
				_order_update_Data["ship_time"] = time.Now().Format(timeFormat) //发货时间
				if _isDeliver {
					_order_update_Data["isdeliver"] = 1
				}
				// //运费增加到总金额
				// order_sql.Price = SubtractFloat64(AddFloat64(order_sql.Price, _logts.Offer), _history_offer)
				// //计算运费利润
				// var logts_profit_old, logts_profit_new float64 = SubtractFloat64(_history_offer, _history_cost), SubtractFloat64(_logts.Offer, _logts.Cost.Float64)
				// order_sql.Profit = AddFloat64(order_sql.Profit, SubtractFloat64(logts_profit_new, logts_profit_old)) //利润

				if dbResult = tx.Table("orders").Where("id=?", order_sql.ID).Updates(_order_update_Data); dbResult.Error == nil && dbResult.RowsAffected == 1 {
					resOrder = &OrderLogsInfo{
						LogisticsCompany: gconv.String(_logts_update_Data["logistics_company"]),
						LogisticsNumber:  gconv.String(_logts_update_Data["logistics_number"]),
						GoodsNameArr:     order_sql.GoodsNameArr.String,
						OrderID:          order_sql.OrderID,
						ShipTime:         time.Now(),
					}
					if err = HandleCompleteStock(tx, param, shopId); err != nil {
						isErr = true
						return
					}
					return
				}
			}
		} else {
			isErr = true
			return
		}
	}
	return nil, msg, errors.New("订单不存在，具体原因请联系客服")
}

type OrdersLogisResult struct {
	OrderGoodsStatus int32        `json:"order_goods_status"` // 订单状态0待确认1待发货2已发货3已完成
	LogisticsId      uint32       `json:"logistics_id"`       // 订单物流id
	LogisticsCompany string       `json:"logistics_company"`  // 物流公司
	LogisticsCom     string       `json:"logistics_com"`      // 物流公司编码（如：顺丰编码(SF)）
	LogisticsNumber  string       `json:"logistics_number"`   // 物流编号
	LogisticsRecords string       `json:"logistics_records"`  // 快递物流记录
	ThirdPartyID     int32        `json:"third_party_id"`     // 物流第三方平台编号
	UpdatedAt        *entity.Time `json:"updated_at"`         // 更新时间
}

//ModelLookUpLogisticsOrder 查看订单物流信息
func ModelLookUpLogisticsOrder(param *OrderLogisticsParam) (res *OrderLogisticsResp, isGetDB bool, err error) {
	//校验是否该订单是当前店铺的 目前不确认
	//1.先确认表中更新时间字段是否已超过5分钟或者已完成订单、从来没有拉取过第三方平台数据
	//2.超过时间限制，需要重新到第三方平台拉取物流信息，存入数据库中，并且推送给显示端
	//3.如果订单状态已完成，那不在从第三方平台拉取信息，直接到数据库中获取

	//1.
	_orders_result := OrdersLogisResult{}
	if param.LogisticsID == nil {
		//默认物流信息
		if dbResult := dbGorm.Table("orders_goods as a").Select("a.order_goods_status,a.logistics_id,b.logistics_company,b.logistics_com,b.logistics_number,b.updated_at,b.logistics_records,b.third_party_id").Joins("right join orders_logistics as b on a.order_id= b.order_id").Where("a.order_id=? and b.is_default=1 and a.status=0", param.OrderId).First(&_orders_result); dbResult.Error != nil || &_orders_result == nil {
			return nil, false, errors.New("查询失败")
		}
	} else {
		if dbResult := dbGorm.Table("orders_goods as a").Select("a.order_goods_status,a.logistics_id,b.logistics_company,b.logistics_com,b.logistics_number,b.updated_at,b.logistics_records,b.third_party_id").Joins("right join orders_logistics as b on a.order_id= b.order_id and a.logistics_id=b.id").Where("a.order_id=? and b.id=? and a.status=0", param.OrderId, param.LogisticsID).First(&_orders_result); dbResult.Error != nil || &_orders_result == nil {
			return nil, false, errors.New("查询失败")
		}
	}

	res = &OrderLogisticsResp{
		LogisticsCom:     _orders_result.LogisticsCom,
		LogisticsCompany: _orders_result.LogisticsCompany,
		LogisticsNumber:  _orders_result.LogisticsNumber,
	}
	t := time.Now().Sub(_orders_result.UpdatedAt.Time).Hours() //调取第三方平台获取物流信息间隔时间 3H

	if (_orders_result.LogisticsRecords != "" && t <= querytime) || _orders_result.OrderGoodsStatus == POSC {
		res.LogisticsRecords = _orders_result.LogisticsRecords
		res.ThirdPartyID = _orders_result.ThirdPartyID
		return res, true, nil
	}

	return res, false, nil
}

//判断是否分包发送
//返回值isPart true表示分包 false表示未分包
func JudgeOrdersPartSend(orderID string) (isPart bool) {
	og_data_arr := make([]*entity.OrdersGoods, 0)
	td_og := dbGorm.Table("orders_goods").Where("order_id=? and status=0 and logistics_id>0", orderID)
	if err := td_og.Find(&og_data_arr); err != nil || len(og_data_arr) == 0 {
		return false
	}
	//遍历查找是否存在绑定不同物流数据
	for _, value := range og_data_arr {
		if value.LogisticsID != og_data_arr[0].LogisticsID {
			return true
		}
	}
	return false
}

//买家查看订单物流包裹列表消息请求
type OrderLogisticsUserParam struct {
	OrderId string `json:"order_id"` // 订单编号
}

//查看订单物流记录应答
type OrderLogisticsUserInfo struct {
	OrderGoodsStatus int32        `json:"order_goods_status"` // 订单状态0待确认1待发货2已发货3已完成
	LogisticsId      uint32       `json:"logistics_id"`       // 订单物流id
	LogisticsCompany string       `json:"logistics_company"`  // 物流公司
	LogisticsNumber  string       `json:"logistics_number"`   // 物流运单号
	ShipTime         *entity.Time `json:"ship_time"`          // 发货时间
	Quantity         int          `json:"quantity"`           // 数目
	GoodsName        string       `json:"goods_name"`         // 商品名称
	Specifications   string       `json:"specifications"`     // 规格
	Image            string       `json:"image"`              // 图片地址
}

//包裹商品信息
type OrdersUserGoods struct {
	Quantity       int    `json:"quantity"`       // 数目
	GoodsName      string `json:"goods_name"`     // 商品名称
	Specifications string `json:"specifications"` // 规格
	Image          string `json:"image"`          // 图片地址
}

type OrderLogisticsUserResult struct {
	OrderGoodsStatus int32              `json:"order_goods_status"` // 订单状态0待确认1待发货2已发货3已完成
	LogisticsId      uint32             `json:"logistics_id"`       // 订单物流id
	LogisticsCompany string             `json:"logistics_company"`  // 物流公司
	LogisticsNumber  string             `json:"logistics_number"`   // 物流运单号
	ShipTime         *entity.Time       `json:"ship_time"`          // 发货时间
	Count            int                `json:"count"`              // 包裹商品列表个数
	GoodsInfo        []*OrdersUserGoods `json:"goods_info"`         // 包裹商品信息
}

//ModelLookUpLogisticsUser 查看订单物流信息
func ModelLookUpLogisticsUser(param *OrderLogisticsUserParam) (res []*OrderLogisticsUserResult, err error) {
	query_data := make([]*OrderLogisticsUserInfo, 0)
	if dbResult := dbGorm.Table("orders_goods as a").Select("a.order_goods_status,a.logistics_id,a.quantity,a.goods_name,a.specifications,a.image,b.logistics_company,b.logistics_com,b.logistics_number,a.ship_time").Joins("right join orders_logistics as b on a.order_id= b.order_id and a.logistics_id=b.id").Where("a.order_id=?", param.OrderId).Find(&query_data); dbResult.Error != nil || query_data == nil {
		return nil, errors.New("查询失败")
	}
	psMap := map[uint32]int{} //key=订单物流id value=标签id所属的商品数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].LogisticsId]++
	}

	//处理数据
	res = make([]*OrderLogisticsUserResult, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0
	for _, q_value := range query_data {
		if respParse, errTemp := gjson.DecodeToJson(q_value.Image); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			q_value.Image = default_img_str[0] //只取默认封面图片
		}
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.LogisticsId == q_value.LogisticsId {
					all_value.Count++
					all_value.GoodsInfo = append(all_value.GoodsInfo, &OrdersUserGoods{
						Quantity:       q_value.Quantity,
						GoodsName:      q_value.GoodsName,
						Specifications: q_value.Specifications,
						Image:          q_value.Image,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}
		res[all_index] = &OrderLogisticsUserResult{
			OrderGoodsStatus: q_value.OrderGoodsStatus,
			LogisticsId:      q_value.LogisticsId,
			LogisticsCompany: q_value.LogisticsCompany,
			LogisticsNumber:  q_value.LogisticsNumber,
			ShipTime:         q_value.ShipTime,
		}
		res[all_index].Count++
		res[all_index].GoodsInfo = append(res[all_index].GoodsInfo, &OrdersUserGoods{
			Quantity:       q_value.Quantity,
			GoodsName:      q_value.GoodsName,
			Specifications: q_value.Specifications,
			Image:          q_value.Image,
		})
		all_index++
	}

	return res, nil
}

//ModelUpdateLogisticsOrder 更新订单物流信息
func ModelUpdateLogisticsOrder(logistics_records string, orderId string, thirdPlatformID int32, state int, logisticsNumber string) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		logistics := g.Map{
			"logistics_records": logistics_records,
			"third_party_id":    thirdPlatformID,
			"updated_at":        time.Now(),
		}
		if state == 3 {
			logistics["status"] = 2 //已完成
			//目前不更新状态 2020-09-16 lyh del
			// if err = ModelModOrderStatusComplete(orderId, logisticsNumber); err != nil {
			// 	isErr = true
			// 	return errors.New("更新订单物流信息失败")
			// }
		}

		if dbResult := dbGorm.Table("orders_logistics").Where("order_id=?  and logistics_number=? ", orderId, logisticsNumber).Update(logistics); dbResult.Error != nil {
			isErr = true
			return errors.New("更新订单物流信息失败")
		}
	}
	return nil
}

//获取商铺设置的快递信息
func ModelCheckShopExpress(code uint32, shop_id uint64) (res *entity.ShopExpress, msg string, err error) {
	res = &entity.ShopExpress{}
	if code == 0 { //取默认绑定快递公司
		dbGorm.Where("is_default=1 and shop_id=?", shop_id).First(res)
		if res.ExpressCompanyID == 0 {
			msg = "店铺没有设置默认快递公司"
			return
		}

	} else {
		dbGorm.Where("express_company_id=? and shop_id=?", code, shop_id).First(res)
		if res.ExpressCompanyID == 0 {
			msg = "店铺未绑定该快递公司"
			return
		}
	}
	if res.PartnerID.IsZero() || res.PartnerKey.IsZero() {
		msg = "店铺没有添加电子面单账户和密码"
		return
	}
	return
}

//获取订单的收货地址信息
func ModelGetOrderReceiverInfo(orderId string, logisticsID uint32) (res *entity.OrdersLogistics, err error) {
	res = &entity.OrdersLogistics{}
	if logisticsID == 0 {
		err = dbGorm.Table("orders_logistics").Where("order_id=? and is_default=1", orderId).First(res).Error
	} else {
		err = dbGorm.Table("orders_logistics").Where("order_id=? and id=?", orderId, logisticsID).First(res).Error
	}

	if res == nil || err != nil {
		err = errors.New("订单收货地址未找到")
		return nil, err
	}
	return
}

//获取第三方平台物流公司配置信息 商户号和appkey,
func ModelGetThirdPartyList() (res []*entity.ThirdParty, err error) {
	res = []*entity.ThirdParty{}
	dbGorm.Find(&res)
	if len(res) == 0 {
		err = errors.New("平台参数不存在")
	}
	return
}

//获取系统配置第三方平台的调用接口
func ModelCheckThirdPlatform(platformInfo *entity.ThirdParty, interfaceName string) (res *kuaidi.KuaiDiThirdPlatformInfo, err error) {
	_count := 0
	res_thirdPartyInterface := &entity.ThirdPartyInterface{}
	dbGorm.Where("third_party_id=? and third_name=?", platformInfo.ID, interfaceName).First(res_thirdPartyInterface).Count(&_count)
	if _count == 0 {
		err = errors.New("接口参数不存在")
		return nil, err
	}
	res = &kuaidi.KuaiDiThirdPlatformInfo{
		AppKey:       platformInfo.ThirdAccountKey.String,
		EBusinessID:  platformInfo.ThirdAccountID.String,
		InterfaceUrl: res_thirdPartyInterface.ThirdURL.String,
	}
	return
}

//获取指定快递公司ID的快递编码(根据平台获取)
func ModelIdToExpressCode(expressCompanyId uint32) (systemExpressCompany *entity.SystemExpressCompany) {
	systemExpressCompany = &entity.SystemExpressCompany{}
	dbGorm.Table("system_express_company").Where("id=?", expressCompanyId).First(systemExpressCompany)
	return
}

//获取指定快递公司ID的快递编码(根据快递鸟快递编码获取)
func ModelIdToExpressCodeEx(expressCodeKdn string) (systemExpressCompany *entity.SystemExpressCompany) {
	systemExpressCompany = &entity.SystemExpressCompany{}
	dbGorm.Table("system_express_company").Where("express_code=?", expressCodeKdn).First(systemExpressCompany)
	return
}

//获取订单单独商品信息【商品名信息】
func ModelGetSendOrderGoodsDetail(order_id string, orderGoods_id []uint32) (goodsName []string, err error) {
	res := make([]*entity.OrdersGoods, 0)
	var _count int
	dbGorm.Where("order_id=? and id in(?)", order_id, orderGoods_id).Find(&res).Count(&_count)
	if _count == 0 || res == nil {
		return nil, errors.New("订单不存在")
	}
	goodsName = make([]string, len(res))
	for k, value := range res {
		goodsName[k] = value.GoodsName.String
	}
	return
}

//获取订单信息【商品名信息】
func ModelGetSendOrderDetail(order_id string, needCheck bool) (res *entity.Orders, err error) {
	res = &entity.Orders{}
	var _count int
	dbGorm.Where("order_id=?", order_id).First(res).Count(&_count)
	if _count == 0 || res == nil {
		return nil, errors.New("订单不存在")
	}
	if res.OrderStatus == OSD && needCheck {
		return nil, errors.New("订单已经发货，请勿重复发货")
	}
	return
}

type CreateLogisticsOrderParam struct {
	Cost               float64
	Offer              float64
	ReceiverName       string
	ReceiverIphone     string
	ReceiverProvince   string
	ReceiverCity       string
	ReceiverDistrict   string
	ReceiverAddress    string
	LogisticsCompany   string
	LogisticsCom       string
	LogisticsNumber    string
	LogisticsOrderHTML string
}

//ModelGetTemplete 获取打印快递面单模板数据库数据
func ModelGetTemplete(templeteId string, expressId uint32, isFlag bool) (tb_data_templete *entity.ExpressTemplateConfig, err error) {
	tb_data_templete = &entity.ExpressTemplateConfig{}
	dbOs := dbGorm.Table("express_template_config")
	if isFlag {
		term := "%" + templeteId + "%"
		err = dbOs.Where("templete_name like ? and express_company_id =?", term, expressId).First(tb_data_templete).Error
	} else {
		err = dbOs.Where("ID=?", templeteId).First(tb_data_templete).Error
	}

	return
}

func ModelUpdateOrderData(req map[string]interface{}, orderStatus int32) (err error) {
	//ModelUpdateOrderData 订单物流信息 更新数据库数据
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//返回成功
		SearchID := &entity.OrdersLogistics{}
		err = dbGorm.Where("logistics_number=? and logistics_com=?", gconv.String(req["logistics_number"]), gconv.String(req["logistics_com"])).First(SearchID).Error
		if err != nil {
			return
		}

		if dbResult := dbGorm.Where("id=?", SearchID.ID).Updates(req); dbResult.Error != nil || dbResult.RowsAffected == 0 {
			isErr = true
			return errors.New("发货失败")
		}
		//暂时不改 2020-09-16 lyh del
		// if err = ModelModOrderStatusComplete(req.OrderID, req.LogisticsNumber); err != nil {
		// 	isErr = true
		// 	return errors.New("发货失败")
		// }
	}

	return nil
}

//通过快递单号获取物流信息
func ModelNumToLogisticsInfo(num string) (res *entity.OrdersLogistics, err error) {
	res = &entity.OrdersLogistics{}

	dbResult := dbGorm.Table("orders_logistics").Order("created_at asc").First(&res).Where("logistic_number=? and status=2", num)
	if err = dbResult.Error; err != nil {
		return nil, err
	}
	return
}

//查询所有电子面单模板
type EOrderTemplate struct {
	ExpressName      string `json:"express_name"`       // 快递名称
	ExpressCompanyId uint32 `json:"express_company_id"` // 快递公司ID
	TempleteName     string `json:"templete_name"`      // 模板名称
	TempleteId       uint32 `json:"templete_id"`        // 模板ID
}

//ModelLookUpEOrderTemplate 查看模板列表
func ModelLookUpEOrderTemplate() (res []*EOrderTemplate, err error) {
	res = make([]*EOrderTemplate, 0)
	if dbResult := dbGorm.Table("express_template_config as a").Joins("Left join system_express_company as b on a.express_company_id=b.id").Select("a.express_company_id,a.ID as templete_id,a.templete_name as templete_name,b.express_name as express_name").Find(&res); dbResult.Error != nil {
		return res, errors.New("查看模板列表失败")
	}
	return
}

//查询确认订单次数
type OrderCountResp struct {
	OrderCount int32
}

//查询确认订单次数
func OrderCount(ShopId uint64) (res *OrderCountResp, err error) {
	tb := dbGorm.Table("shop_profit")
	res = &OrderCountResp{}
	err = tb.Where("shop_id = ? AND to_days(created_at) = to_days(now())", ShopId).Count(&res.OrderCount).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("OrderCount Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return
}

//修改打印面单次数
func OrderPrinting(ShopId uint64, OrderId string) (err error) {
	tb := dbGorm.Table("orders_printing")
	has, err := dbXorm.Table("orders_printing").Where("shop_id=? AND order_id=? AND to_days(created_at) = to_days(now())", ShopId, OrderId).Exist()
	if has {
		if ordersprinting := tb.Where("shop_id=? AND order_id=? AND to_days(created_at) = to_days(now())", ShopId, OrderId).Update(map[string]interface{}{"printing_count": gorm.Expr("printing_count + ?", 1)}); ordersprinting.Error != nil {
			zaplog.Errorf("OrderPrinting 修改打印面单次数 Db err:%s", err)
			return err
		}
	} else {
		if ordersprinting := tb.Create(&entity.OrdersPrinting{ShopID: ShopId, OrderID: OrderId, PrintingCount: 1}); ordersprinting.Error != nil {
			zaplog.Errorf("OrderPrinting 修改打印面单次数 Db err:%s", err)
			return err
		}
	}
	return
}

//查询确认订单次数
type OrderPrintingResp struct {
	PrintingCount int32 `json:"printing_count"` //打印订单次数
}

//查询确认订单次数
func OrderPrintingCount(ShopId uint64) (res *OrderPrintingResp, err error) {
	tb := dbGorm.Table("orders_printing")
	res = &OrderPrintingResp{}
	err = tb.Where("shop_id=? AND to_days(created_at) = to_days(now())", ShopId).Count(&res.PrintingCount).Error
	if err != nil {
		zaplog.Errorf("OrderPrintingCount 查询确认订单次数 Db err:%s", err)
		return nil, err
	}
	return
}
