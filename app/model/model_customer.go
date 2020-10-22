package model

import (
	"bytes"
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"time"

	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
	"github.com/jinzhu/gorm"
	jsoniter "github.com/json-iterator/go"
)

type GoodsListParam struct {
	GoodsId        string  `json:"goods_id"`       //#商品id
	SpID           int64   `json:"sp_id"`          //规格编号
	Quantity       int32   `json:"quantity"`       //#数量
	SinglePrice    float64 `json:"single_price"`   //#单价
	TotalPrice     float64 `json:"total_price"`    //#总金额
	Specifications string  `json:"specifications"` //#商品规格
	GoodsName      string  `json:"goods_name"`     //#商品名称
	Image          string  `json:"image"`          //#商品图片
}
type OrderLogParam struct {
	ReceiverAddress  string  `json:"receiver_address"`                  // 详细地址
	Cost             float64 `json:"cost"`                              // 运费成本
	Offer            float64 `json:"offer"`                             // 运费报价
	ReceiverName     string  `json:"receiver_name"`                     // 收货人
	ReceiverProvince string  `json:"receiver_province"`                 //省
	ReceiverCity     string  `json:"receiver_city"`                     //市
	ReceiverDistrict string  `json:"receiver_district"`                 //县/区
	ReceiverIphone   string  `json:"receiver_iphone" v:"phone#手机号格式错误"` // 收货联系方式
}

//PaymentParam 提交订单请求
type PaymentParam struct {
	// ShopID          uint64           `json:"shop_id"`          //#商铺所归属用户id熟成代购id
	ExpressID       uint32           `json:"express_id"`       //#商铺寄货快递信息ID
	Price           float64          `json:"price"`            //总金额
	Remark          string           `json:"remark"`           //#定单备注
	OrdersLogistics OrderLogParam    `json:"orders_logistics"` //地址信息
	OrderGoodsInfo  []GoodsListParam `json:"order_goods_info"` //#产品列表
}

//商品进价信息
type DbUpdateGoodsNumRes struct {
	HgsId           uint64  `json:"hgs_id"`            //#商品库id
	GoodsId         uint64  `json:"goodsid"`           //#商品id
	SpID            int64   `json:"sp_id"`             //规格编号
	InputPrice      float64 `json:"input_price"`       //进价单价
	TotalInputPrice float64 `json:"total_input_price"` //总进价
}

//商品规格
type GoodsSpecification struct {
	SpID       int64   `json:"sp_id"`       //规格编号  放在json字符串存入数据库
	Name       string  `json:"name"`        // 规格名称
	InputPrice float64 `json:"input_price"` // 入库价格
	ShopPrice  float64 `json:"shop_price"`  // 销售价格
	StockNum   int32   `json:"stock_num"`   // 库存数量
}

//更新商品库存,返回库存和进货成本
func UpdateGoodsStockNum(tx *gorm.DB, _goods_spec_list []GoodsListParam, shop_id uint64) (res []*DbUpdateGoodsNumRes, totalInputPrice float64, err error) {
	resList := make([]*DbUpdateGoodsNumRes, len(_goods_spec_list))
	var _goods_id uint64
	for i, _goods_spec := range _goods_spec_list {
		_goods_id = gconv.Uint64(_goods_spec.GoodsId)
		_goods_result := entity.Goods{}
		if err = tx.Table("goods").Where("goods_id=? and shop_id=?", _goods_id, shop_id).Find(&_goods_result).Error; err != nil {
			return nil, 0, err
		}
		_sp_result := []*GoodsSpecification{}
		if _goods_result.Specifications != "" {
			err = jsoniter.Unmarshal([]byte(_goods_result.Specifications), &_sp_result)
			if err != nil {
				zaplog.Errorf("UpdateStockNum, err=%s", err)
				return nil, 0, err
			}
			//统计所有规格的库存总数，如果小于等于0，则将商品状态设置为售空，这功能先不处理，2020-6-20
			var is_spid bool = false
			for index, _sp := range _sp_result {
				if _goods_spec.SpID != _sp.SpID {

					continue
				}
				//暂时不需要管理库存不足处理问题
				resList[i] = &DbUpdateGoodsNumRes{
					HgsId:           _goods_result.HgsID,
					GoodsId:         _goods_id,
					SpID:            _goods_spec.SpID,
					InputPrice:      _sp.InputPrice,
					TotalInputPrice: _sp.InputPrice * float64(_goods_spec.Quantity), //总进价
				}

				totalInputPrice += resList[i].TotalInputPrice
				if _sp_result[index].StockNum > 0 {
					_sp_result[index].StockNum -= _goods_spec.Quantity //更新库存
				}

				is_spid = true

			}
			if !is_spid {
				return nil, 0, errors.New("商品规格不存在")
			}
			jsonBytes, err := jsoniter.Marshal(_sp_result)
			if err != nil {
				fmt.Println(err)
			}
			json_sp := string(jsonBytes) //规格信息json-》string
			//更新规格信息字段
			if err = tx.Table("goods").Where("goods_id=?", _goods_spec.GoodsId).Update("specifications", json_sp).Error; err != nil {
				return nil, 0, err
			}
			res = resList
		}
	}

	return
}

//组合订单所有商品详情
func CreateGoodsName(orderGoodsInfo []GoodsListParam) (_goods_nameArr []string) {
	//获取单独商品名称和规格保存到订单表内
	_goods_nameArr = make([]string, len(orderGoodsInfo))
	for i, _ := range orderGoodsInfo {
		if orderGoodsInfo[i].Specifications == "" {
			_goods_nameArr[i] = orderGoodsInfo[i].GoodsName
		} else {
			_goods_nameArr[i] = orderGoodsInfo[i].GoodsName + " " + orderGoodsInfo[i].Specifications
		}
	}
	return
}

//GetOrdersId 生产订单编号1000000000-9999999999
//order_id生成格式：用户ID(7个)+时间戳（10个）
func GetOrdersId(userid uint32) string {
	strDate := int32(time.Now().Unix())
	strRes := fmt.Sprintf("%d%d", userid, strDate)
	return strRes
}

//判断地址信息为空
func JudgeLogisticsNull(param *OrderLogParam) bool {
	if param == nil {
		return true
	}
	return (param.ReceiverProvince == "" || param.ReceiverCity == "" || param.ReceiverDistrict == "" || param.ReceiverIphone == "" || param.ReceiverName == "" || param.ReceiverAddress == "")
}

//MainInsertOrders 下单
func MainInsertOrders(param *PaymentParam, strOrderId string, userId uint32, shopId uint64, CustomerID uint32, CustomerName string) (err error) {
	//更新库存信息，返回目前库存数,还有总进价成本
	query_data := make([]GoodsListParam, len(param.OrderGoodsInfo))
	for k, _Info := range param.OrderGoodsInfo {
		query_data[k] = GoodsListParam{
			GoodsId:        _Info.GoodsId,
			SpID:           _Info.SpID,
			Quantity:       _Info.Quantity,
			SinglePrice:    _Info.SinglePrice,
			TotalPrice:     _Info.TotalPrice,
			Specifications: _Info.Specifications,
			GoodsName:      _Info.GoodsName,
			Image:          _Info.Image,
		}
	}

	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {

		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//查询物流快递成本和费用
		get_express := &entity.ShopExpress{}
		if param.ExpressID > 0 {
			tb := dbGorm.Table("shop_express")
			err = tb.Where("shop_id=? and express_id=?", shopId, param.ExpressID).Scan(&get_express).Error
			if get_express.ExpressOffer.Float64 != param.OrdersLogistics.Offer {
				isErr = true
				err = errors.New("快递费用校验错误")
				return
			}
		} else {
			get_express.ExpressName = "自行配送"
		}
		//更新商品库存,返回库存和进货成本
		_goodsNumResInfo, TotalInputPrice, errT := UpdateGoodsStockNum(tx, query_data, shopId)
		if errT != nil {
			isErr = true
			return errT
		}
		//获取单独商品名称和规格保存到订单表内
		_goods_nameArr := CreateGoodsName(param.OrderGoodsInfo)
		//根据订单信息入库
		if err = tx.Create(&entity.Orders{
			OrderID:           strOrderId,
			UserID:            userId,
			ShopID:            shopId,
			CustomerID:        CustomerID,
			CustomerName:      null.StringFrom(CustomerName),
			OrderStatus:       0,
			PreferentialPrice: null.Float{},
			Price:             param.Price,
			Profit:            SubtractFloat64(SubtractFloat64(param.Price, TotalInputPrice), get_express.ExpressCost.Float64), //利润(要算上运费成本)
			Remark:            null.NewString(param.Remark, true),
			GoodsNameArr:      null.StringFrom(gconv.String(_goods_nameArr)),
			Ispay:             0,
			PayPrice:          0,
			Status:            1,
			// PayTime:           &entity.Time{Time: time.Now()},
			// ShipTime:          &entity.Time{Time: time.Now()},
			// CompleteTime:      &entity.Time{Time: time.Now()},
		}).Error; err != nil {
			isErr = true
			return err
		}

		//根据订单物流信息入库
		_logistics := entity.OrdersLogistics{
			OrderID:          strOrderId,
			Status:           0, //发送中（或称未发送）
			Cost:             get_express.ExpressCost,
			Offer:            get_express.ExpressOffer.Float64,
			ReceiverName:     param.OrdersLogistics.ReceiverName,
			ReceiverIphone:   param.OrdersLogistics.ReceiverIphone,
			ReceiverProvince: null.StringFrom(param.OrdersLogistics.ReceiverProvince),
			ReceiverCity:     null.StringFrom(param.OrdersLogistics.ReceiverCity),
			ReceiverDistrict: null.StringFrom(param.OrdersLogistics.ReceiverDistrict),
			ReceiverAddress:  null.StringFrom(param.OrdersLogistics.ReceiverAddress),
			LogisticsCompany: null.StringFrom(get_express.ExpressName),
			LogisticsCom:     null.StringFrom(get_express.ExpressCode),
			UfPayStatus:      0,
			IsDefault:        1, //标记为默认邮寄地址
		}
		if err = tx.Create(&_logistics).Error; err != nil {
			isErr = true
			return err
		}
		preorderParam := &PreorderOrderGoodsParam{
			LogisticsId:      _logistics.ID,
			HpId:             uint64(0),
			PayStatus:        uint32(0),
			OrderGoodsStatus: uint32(POBUY),
			Remark:           param.Remark,
		}
		//插入订单下的商品列表到数据库中
		if err = BatchInsertOrderGoods(tx, strOrderId, preorderParam, query_data, _goodsNumResInfo); err != nil {
			isErr = true
			return
		}

	}
	return
}

//批量插入订单商品表
//strOrderId表示订单id, preorderPram表示预购清单信息,productList表示下单的商品信息记录，goodsNumResInfo表示对应的商品进价信息
func BatchInsertOrderGoods(tx *gorm.DB, strOrderId string, preorderPram *PreorderOrderGoodsParam, productList []GoodsListParam, goodsNumResInfo []*DbUpdateGoodsNumRes) (err error) {
	var Buffer bytes.Buffer

	//插入订单下的商品列表到数据库中
	sql := "INSERT INTO `orders_goods` (`hp_id`,`logistics_id`,`pay_status`,`order_goods_status`,`paidmoney`,`remark`,`created_at`,`updated_at`,`order_id`,`quantity`,`single_price`,`total_price`,`specifications`,`goods_name`,`image`,`input_price`,`total_input_price`,`hgs_id`) VALUES "
	Buffer.WriteString(sql)
	curTimeStr := time.Now().Format("2006-01-02 15:04:05")
	var _goods_id uint64
	for i, products := range productList {
		_goods_id = gconv.Uint64(products.GoodsId)
		sql = fmt.Sprintf("(%d,%d,%d,%d,%20.2f,'%s','%s','%s','%s',%d,%20.2f,%20.2f,'%s','%s','%s', ", preorderPram.HpId, preorderPram.LogisticsId, preorderPram.PayStatus, preorderPram.OrderGoodsStatus, preorderPram.Paidmoney, preorderPram.Remark, curTimeStr, curTimeStr, strOrderId, products.Quantity, products.SinglePrice, products.TotalPrice, products.Specifications, products.GoodsName, products.Image)
		Buffer.WriteString(sql)
		//筛选比对规格信息(价格和商品库id)
		for _, cur_info := range goodsNumResInfo {

			if cur_info.GoodsId == _goods_id && cur_info.SpID == products.SpID {
				sql = fmt.Sprintf("%20.2f,%20.2f, %d)", cur_info.InputPrice, cur_info.TotalInputPrice, cur_info.HgsId)
				Buffer.WriteString(sql)
				break
			}
		}
		if len(productList)-1 == i {
			//最后一条数据 以分号结尾
			Buffer.WriteString(";")
		} else {
			Buffer.WriteString(",")
		}
	}
	if len(productList) > 0 {
		if err = tx.Exec(Buffer.String()).Error; err != nil {
			return err
		}
	}

	return
}

type WxUserInfoUnionID struct {
	Subscribe      int           `json:"subscribe"`       //用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息
	OpenID         string        `json:"openid"`          //用户的标识，对当前公众号唯一
	NickName       string        `json:"nickname"`        //用户的昵称
	Sex            int           `json:"sex"`             //用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
	Language       string        `json:"language"`        //用户所在城市
	City           string        `json:"city"`            //用户所在国家
	Province       string        `json:"province"`        //用户所在省份
	Country        string        `json:"country"`         //用户的语言，简体中文为zh_CN
	HeadImgUrl     string        `json:"headimgurl"`      //用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。
	SubscribeTime  time.Duration `json:"subscribe_time"`  //用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间
	UnionID        string        `json:"unionid"`         //只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。
	Remark         string        `json:"remark"`          //公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注
	GroupID        int           `json:"groupid"`         //用户所在的分组ID（兼容旧的用户分组接口）
	TragIdList     []int         `json:"tagid_list"`      //用户被打上的标签ID列表
	SubscribeScene string        `json:"subscribe_scene"` //返回用户关注的渠道来源，ADD_SCENE_SEARCH 公众号搜索，ADD_SCENE_ACCOUNT_MIGRATION 公众号迁移，ADD_SCENE_PROFILE_CARD 名片分享，ADD_SCENE_QR_CODE 扫描二维码，ADD_SCENE_PROFILE_LINK 图文页内名称点击，ADD_SCENE_PROFILE_ITEM 图文页右上角菜单，ADD_SCENE_PAID 支付后关注，ADD_SCENE_WECHAT_ADVERTISEMENT 微信广告，ADD_SCENE_OTHERS 其他
	QrScene        int           `json:"qr_scene"`        //二维码扫码场景（开发者自定义）
	QrSceneStr     string        `json:"qr_scene_str"`    //二维码扫码场景描述（开发者自定义）
}

//保存关注微信公众号用户信息
func SaveGzhUserInfo(req *WxUserInfoUnionID) (err error) {
	tb := dbGorm.Table("user")
	err = tb.Update("gzh_open_id", req.OpenID).Where("union_id=?", req.UnionID).Error
	return
}

type GzhUserInfo struct {
	GzhOpenID string `json:"gzh_open_id"` //公众号openid
}

//查询关注微信公众号用户信息openid是否存在
func CheckGzhOpenID(gzhOpenID string) bool {
	tb := dbGorm.Table("user")
	sqlRes := &GzhUserInfo{}
	if err := tb.Select("gzh_open_id").Where("gzh_open_id=?", gzhOpenID).First(sqlRes).Error; err != nil || sqlRes.GzhOpenID == "" {
		return false
	}
	return true
}

type SystemAnnParam struct {
	SystemAnnVersion string // 版本号
	SystemAnnTarget  uint32 // 0所有 1普通用户2代购
}

//获取公告
func SystemAnnInfo(param *SystemAnnParam) (_sysAnn *entity.SystemAnn) {
	_sysAnn = &entity.SystemAnn{}
	tb := dbGorm.Table("system_ann")
	if err := tb.Order("created_at desc, updated_at desc").Where("system_ann_version=? and system_ann_target=? and system_ann_status=1", param.SystemAnnVersion, param.SystemAnnTarget).First(&_sysAnn).Error; err != nil {
		return
	}
	return
}
