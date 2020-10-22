package model

import (
	"bytes"
	"daigou/app/model/entity"
	"daigou/library/utils"
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

//当前时间格式化
const (
	timeFormat = "2006-01-02 15:04:05"
)

//仓库状态 （-1 删除 0  在库 1 在售）
const (
	HGDEL    int32 = iota - 1 // -1 删除
	HGING                     // 0 在库
	HGBUYING                  // 1 在售
)

//仓库变化类型（-1 删除 0初始库存 1修改 2进货 3售卖）
const (
	CH_HGDEL    int32 = iota - 1 // -1 删除
	CH_HGCREATE                  // 0 初始库存
	CH_HGMOD                     // 1修改
	CH_HGINPUT                   // 2进货
	CH_HGBUY                     // 3售卖
)

//进价类型（0取平均值 1 直接更新进价）
const (
	IN_AGV   int32 = iota // 0 取平均值
	IN_VALUE              // 1直接更新进价
)

//订单状态
const (
	// 0 未买到
	PONOBUY int32 = iota
	// 1 已买到
	POBUY
	// 2 已发货
	POSD
	// 3 已完成
	POSC
)

//订单商品状态（-1删除 0正常）
const (
	OG_DEL    int32 = iota - 1 // -1 删除
	OG_NORMAL                  // 0 正常
)

//入库商品信息
type HouseBaseInfo struct {
	HgsName       string  `json:"hgs_name" v:"required#商品名称不能为空"` // 商品名称 不能重复
	HgsSurplusnum int32   `json:"hgs_surplusnum"`                 // 剩余库存
	HgsSource     string  `json:"hgs_source"`                     // 货源地
	HgsExpday     int32   `json:"hgs_expday"`                     // 保质期（天）
	HgsInprice    float64 `json:"hgs_inprice"`                    // 进价
	HgsSaleprice  float64 `json:"hgs_saleprice"`                  // 售价
	HgsImg        string  `json:"hgs_img"`                        // 商品图片
	HgsExplain    string  `json:"hgs_explain"`                    // 说明
}

//json请求
type HouseInfoReq struct {
	HouseBaseInfo
	HgsBuilddate time.Time `json:"hgs_builddate"` // 生产日期
}

//json回复
type HouseInfoResp struct {
	OSHouseReq
	HgsName       string       `json:"hgs_name"`       // 商品名称 不能重复
	HgsSurplusnum int32        `json:"hgs_surplusnum"` // 剩余库存
	HgsExpday     int32        `json:"hgs_expday"`     // 保质期（天）
	HgsInprice    float64      `json:"hgs_inprice"`    // 进价
	HgsSaleprice  float64      `json:"hgs_saleprice"`  // 售价
	HgsImg        string       `json:"hgs_img"`        // 商品默认图片
	HgsSalenum    uint32       `json:"hgs_salenum"`    // 已售数量
	HgsBuilddate  *entity.Time `json:"hgs_builddate"`  // 生产日期
	HgsStatus     int          `json:"hgs_status"`     // 商品库状态 （-1 删除 0  在库 1 在售）
}

//查看仓库详情
type HouseDetailInfo struct {
	OSHouseReq
	HgsName       string       `json:"hgs_name"`       // 商品名称 不能重复
	HgsSalenum    uint32       `json:"hgs_salenum"`    // 已售数量
	HgsSurplusnum int32        `json:"hgs_surplusnum"` // 剩余库存
	HgsInprice    float64      `json:"hgs_inprice"`    // 进价
	HgsSaleprice  float64      `json:"hgs_saleprice"`  // 售价
	HgsImg        string       `json:"hgs_img"`        // 商品图片
	HgsBuilddate  *entity.Time `json:"hgs_builddate"`  // 生产日期
	HgsExpday     int32        `json:"hgs_expday"`     // 保质期（天）
	HgsExplain    string       `json:"hgs_explain"`    // 说明
	HgsSource     string       `json:"hgs_source"`     // 货源地
}

//入库操作
type OSHouseReq struct {
	HgsID string `json:"hgs_id"` // 仓库商品 id
}

//按页商品查询
type PageHouseReq struct {
	StartIndex uint32 `json:"start_index"  v:"required#不能为空"` //页起始
	Count      uint32 `json:"count"  v:"required#不能为空"`       //每页数量
}

//进货信息
type InputHouse struct {
	HsrNum       int32   `json:"hsr_num" v:"required#数量不能为空"` // 变化数量
	HsrPrice     float64 `json:"hsr_price"`                   // 进价价格  （当为售卖类型时 保存售价）
	HsrInputtype int32   `json:"hsr_inputtype"`               // 进价类型（0取平均值 1 直接更新进价）
	HsrRemark    string  `json:"hsr_remark"`                  // 备注
}

//将订单表用户id更新为绑定后的微信注册id
func UpdateOrdersUserID(userId uint32, customerId uint32, shopId uint64) error {
	tb := dbGorm.Table("orders").Where("shop_id=?  and customer_id=? and status=1 and user_id=0", shopId, customerId).Update("user_id", userId)
	return tb.Error
}

//判断是否商品名称重复
func RepeatHGoodsName(name string, hgsid uint64, shopId uint64) bool {
	tb := dbGorm.Table("h_goods")
	_hgoods := &entity.HGoods{}
	var err error
	if hgsid == 0 {
		tb = tb.Where("hgs_name = ? and shop_id=? and hgs_status<>? ", name, shopId, CH_HGDEL)
	} else {
		tb = tb.Where("hgs_name = ? and hgs_id<>?  and shop_id=? and hgs_status<>? ", name, hgsid, shopId, CH_HGDEL)
	}
	if err = tb.First(_hgoods).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return true
	}
	if _hgoods.HgsID == 0 {
		return false
	}
	return true
}

//修改商品库状态
func ModHGoodsStatus(tx *gorm.DB, shopId uint64, hgsId uint64, status int32) (err error) {
	if err = tx.Table("h_goods").Where("shop_id=? and hgs_id=? and hgs_status<>?", shopId, hgsId, HGDEL).Update("hgs_status", status).Error; err != nil {
		return
	}
	return
}

//入库添加
func CreateHouseInfo(req *HouseInfoReq, shopid uint64) (hgsInfo *entity.HGoods, err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb := tx.Table("h_goods")
		hgsID := utils.GenUniqueID()
		_hgoods := entity.HGoods{
			HgsID:         hgsID,
			ShopID:        shopid,
			HgsName:       req.HgsName,
			HgsSurplusnum: req.HgsSurplusnum,
			HgsSource:     null.StringFrom(req.HgsSource),
			HgsBuilddate:  &entity.Time{Time: req.HgsBuilddate},
			HgsExpday:     null.IntFrom(int64(req.HgsExpday)),
			HgsExplain:    null.StringFrom(req.HgsExplain),
			HgsInprice:    req.HgsInprice,
			HgsSaleprice:  req.HgsSaleprice,
			HgsImg:        null.StringFrom(req.HgsImg),
			HgsStatus:     HGING,
		}
		if err = tb.Create(&_hgoods).Error; err != nil {
			return nil, err
		}
		zaplog.Infof("入库添加ID：%d", _hgoods.ID)
		HStock := entity.HStockRecord{
			HgsID:        _hgoods.HgsID,
			HsrType:      CH_HGCREATE,
			HsrNum:       req.HgsSurplusnum,
			HsrPrice:     req.HgsInprice,
			HsrInputtype: IN_VALUE,
			HsrAfternum:  req.HgsSurplusnum,
			HsrRemark:    null.StringFrom(req.HgsExplain),
		}
		//保存数据
		if err = tx.Table("h_stock_record").Create(&HStock).Error; err != nil {
			isErr = true
			return nil, err
		}
		return &_hgoods, nil
	}
	return
}

//编辑商品库
type HouseGoodsInfo struct {
	HouseInfoReq
	OSHouseReq
}

//编辑商品库
func EditHouse(req *HouseGoodsInfo) (err error) {
	tb := dbGorm.Table("h_goods")
	//得到当前行id
	if err = tb.Where("hgs_id=? and hgs_status<>? ", req.HgsID, HGDEL).Updates(map[string]interface{}{
		"hgs_name":      req.HgsName,
		"hgs_source":    req.HgsSource,
		"hgs_builddate": req.HgsBuilddate.Format(timeFormat),
		"hgs_explain":   req.HgsExplain,
		"hgs_expday":    int64(req.HgsExpday),
		"hgs_inprice":   req.HgsInprice,
		"hgs_saleprice": req.HgsSaleprice,
		"hgs_img":       req.HgsImg,
		// "hgs_status":    HGING,
	}).Error; err != nil {
		return
	}
	return
}

//修改库存数量
type HouseNum struct {
	OSHouseReq
	HgsSurplusnum int32  `json:"hgs_surplusnum"` // 剩余库存
	HsrRemark     string `json:"hgs_remark"`     // 备注
}

//修改库存数量
func ModHouseNum(req *HouseNum) (err error) {
	tb := dbGorm.Table("h_goods")
	_hgoods := entity.HGoods{}
	if err = tb.Where("hgs_id=? and hgs_status<>? ", req.HgsID, HGDEL).First(&_hgoods).Error; err != nil {
		return
	}
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		if err = tx.Table("h_goods").Where("id=? and hgs_status<>?", _hgoods.ID, HGDEL).Updates(map[string]interface{}{
			"hgs_surplusnum": req.HgsSurplusnum,
		}).Error; err != nil {
			return
		}

		HStock := entity.HStockRecord{
			HgsID:        _hgoods.HgsID,
			HsrType:      CH_HGMOD,
			HsrNum:       req.HgsSurplusnum - _hgoods.HgsSurplusnum,
			HsrPrice:     _hgoods.HgsInprice,
			HsrInputtype: IN_VALUE,
			HsrAfternum:  req.HgsSurplusnum,
			HsrRemark:    null.StringFrom(req.HsrRemark),
		}
		//保存数据
		if err = tx.Table("h_stock_record").Create(&HStock).Error; err != nil {
			isErr = true
			return
		}
	}
	return
}

//入库查看详情
func GetHouseDetail(req *OSHouseReq) (hInfo *HouseDetailInfo, err error) {
	tb := dbGorm.Table("h_goods")
	hInfo = &HouseDetailInfo{}
	if err = tb.Where("hgs_id=? and hgs_status<>?", req.HgsID, HGDEL).First(&hInfo).Error; err != nil {
		return
	}
	return
}

//库存简易信息
type HouseEasyInfo struct {
	HgsName       string  `json:"hgs_name"`       // 商品名称 不能重复
	HgsSurplusnum int32   `json:"hgs_surplusnum"` // 剩余库存
	HgsInprice    float64 `json:"hgs_inprice"`    // 进价
	HgsImg        string  `json:"hgs_img"`        // 商品图片
	HgsSalenum    uint32  `json:"hgs_salenum"`    // 已售数量
}

//商品库查看简易详情
func GetHouseEasy(req *OSHouseReq) (hInfo *HouseEasyInfo, err error) {
	tb := dbGorm.Table("h_goods")
	hInfo = &HouseEasyInfo{}
	if err = tb.Where("hgs_id=? and hgs_status<>?", req.HgsID, HGDEL).First(&hInfo).Error; err != nil {
		return
	}
	if respParse, errTemp := gjson.DecodeToJson(hInfo.HgsImg); errTemp == nil {
		default_img_str := gconv.Strings(respParse.Value())
		if len(default_img_str) >= 0 {
			hInfo.HgsImg = default_img_str[0] //只取默认封面图片
		}
	}
	return
}

//库存操作记录信息
type HouseStockRecord struct {
	OSHouseReq
	HsrType      int32        `json:"hsr_type"`      // 变化类型（-1 删除 0初始库存 1修改 2进货 3售卖）
	HsrNum       int32        `json:"hsr_num"`       // 变化数量
	HsrPrice     float64      `json:"hsr_price"`     // 进价价格  （当为售卖类型时 保存售价）
	HsrInputtype int32        `json:"hsr_inputtype"` // 进价类型（0取平均值 1 直接更新进价）
	HsrAfternum  int32        `json:"hsr_afternum"`  // 变化后的库存
	HsrRemark    string       `json:"hsr_remark"`    // 备注
	CreatedAt    *entity.Time `json:"created_at"`    // 创建时间
}

//获取库存记录详情
func GetHouseStockRecord(req *OSHouseReq, reqPage *PageHouseReq) (count int, res []*HouseStockRecord, err error) {
	tb := dbGorm.Table("h_stock_record")
	res = make([]*HouseStockRecord, 0)
	//获取字段
	sql := "hgs_id,hsr_type,hsr_num,hsr_price,hsr_inputtype,hsr_afternum,hsr_remark,created_at"
	tb = tb.Select(sql).Order("created_at desc").Where("hgs_id=? and hsr_type<>? and hsr_type<>?", req.HgsID, CH_HGDEL, CH_HGBUY).Offset(reqPage.StartIndex).Limit(reqPage.Count)
	if err = tb.Find(&res).Error; err != nil {
		return
	}
	count = len(res)
	return
}

//获取库存商品列表
func GetHouseList(req *PageHouseReq, shopid uint64) (count int, res []*HouseInfoResp, err error) {
	tb := dbGorm.Table("h_goods")
	res = make([]*HouseInfoResp, 0)
	//获取字段
	if err = tb.Order("created_at desc").Offset(req.StartIndex).Limit(req.Count).Where("shop_id=? and hgs_status<>?", shopid, HGDEL).Find(&res).Error; err != nil {
		return
	}
	for _, hInfo := range res {
		if respParse, errTemp := gjson.DecodeToJson(hInfo.HgsImg); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			if len(default_img_str) >= 0 {
				hInfo.HgsImg = default_img_str[0] //只取默认封面图片
			}
		}
	}

	count = len(res)
	return
}

//搜索关键字获取库存商品列表
func SearchHouseList(req *PageHouseReq, inputTerms string, shopid uint64) (count int, res []*HouseInfoResp, err error) {
	tb := dbGorm.Table("h_goods")
	res = make([]*HouseInfoResp, 0)
	tb = tb.Order("created_at desc").Offset(req.StartIndex).Limit(req.Count)
	//获取字段
	if err = tb.Where("shop_id=? and hgs_name like ? and hgs_status<>?", shopid, "%"+inputTerms+"%", HGDEL).Find(&res).Error; err != nil {
		return
	}
	for _, hInfo := range res {
		if respParse, errTemp := gjson.DecodeToJson(hInfo.HgsImg); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			if len(default_img_str) >= 0 {
				hInfo.HgsImg = default_img_str[0] //只取默认封面图片
			}
		}
	}
	count = len(res)
	return
}

//状态搜索获取库存商品列表
func StatusHouseList(req *PageHouseReq, inputTerms string, InventoryStatus uint32, shopid uint64) (count int, res []*HouseInfoResp, err error) {
	tb := dbGorm.Table("h_goods")
	res = make([]*HouseInfoResp, 0)
	tb = tb.Order("created_at desc").Offset(req.StartIndex).Limit(req.Count)
	//获取字段
	if err = tb.Where("shop_id=? and hgs_name like ? and hgs_status<>?", shopid, "%"+inputTerms+"%", HGDEL).Find(&res).Error; err != nil {
		return
	}
	if inputTerms == "" {
		//1:在售  2:在库  4:即将过期  8:库存<3
		if InventoryStatus == 1 {
			err = tb.Where("shop_id=? and hgs_status =?", shopid, HGBUYING).Find(&res).Error
		} else if InventoryStatus == 2 {
			err = tb.Where("shop_id=? and hgs_status =?", shopid, HGING).Find(&res).Error
		} else if InventoryStatus == 4 {
			err = tb.Where("shop_id=? and hgs_status<>? and date_sub(date_sub(hgs_builddate, INTERVAL -hgs_expday DAY),INTERVAL 3 DAY) < NOW() AND date_sub(hgs_builddate, INTERVAL -hgs_expday DAY) > NOW()", shopid, HGDEL).Find(&res).Error
		} else {
			err = tb.Where("shop_id=? and hgs_status<>? and hgs_surplusnum < 3", shopid, HGDEL).Find(&res).Error
		}
	} else {
		//1:在售  2:在库  4:即将过期  8:库存<3
		if InventoryStatus == 1 {
			err = tb.Where("shop_id=? and hgs_name like ? and hgs_status =?", shopid, "%"+inputTerms+"%", HGBUYING).Find(&res).Error
		} else if InventoryStatus == 2 {
			err = tb.Where("shop_id=? and hgs_name like ? and hgs_status =?", shopid, "%"+inputTerms+"%", HGING).Find(&res).Error
		} else if InventoryStatus == 4 {
			err = tb.Where("shop_id=? and hgs_status<>? and hgs_name like ? and date_sub(date_sub(hgs_builddate, INTERVAL -hgs_expday DAY),INTERVAL 3 DAY) < NOW() AND date_sub(hgs_builddate, INTERVAL -hgs_expday DAY) > NOW()", shopid, HGDEL, "%"+inputTerms+"%").Find(&res).Error
		} else {
			err = tb.Where("shop_id=? and hgs_status<>? and hgs_name like ? and hgs_surplusnum < 3", shopid, HGDEL, "%"+inputTerms+"%").Find(&res).Error
		}
	}
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("SeeFans Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	for _, hInfo := range res {
		if respParse, errTemp := gjson.DecodeToJson(hInfo.HgsImg); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			if len(default_img_str) >= 0 {
				hInfo.HgsImg = default_img_str[0] //只取默认封面图片
			}
		}
	}
	count = len(res)
	return
}

//进货
func InputHouseGoods(req *InputHouse, hgsId uint64) (msg string, err error) {
	tb_goods := dbGorm.Table("h_goods")
	//获取字段
	hgoods := &entity.HGoods{}

	if err = tb_goods.Where("hgs_id=? and hgs_status<>?", hgsId, HGDEL).First(hgoods).Error; err != nil {
		return
	}
	if hgoods == nil {
		return "商品库不存在，无法进货", nil
	}

	res := entity.HStockRecord{
		HgsID:        hgsId,
		HsrType:      CH_HGINPUT,
		HsrNum:       req.HsrNum,
		HsrPrice:     req.HsrPrice,
		HsrInputtype: req.HsrInputtype,
		HsrAfternum:  hgoods.HgsSurplusnum + req.HsrNum,
		HsrRemark:    null.StringFrom(req.HsrRemark),
	}
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//保存数据
		if err = tx.Table("h_stock_record").Create(&res).Error; err != nil {
			isErr = true
			return
		}
		hgoods.HgsSurplusnum = res.HsrAfternum
		if req.HsrInputtype == IN_VALUE {
			hgoods.HgsInprice = req.HsrPrice
		} else if req.HsrInputtype == IN_AGV {
			hgoods.HgsInprice = AddFloat64(MultiplyFloat64(req.HsrPrice, float64(req.HsrNum)), MultiplyFloat64(hgoods.HgsInprice, float64(hgoods.HgsSurplusnum))) / float64(hgoods.HgsSurplusnum+req.HsrNum)
		}
		//更新仓库表剩余库存
		if err = tx.Save(&hgoods).Error; err != nil {
			isErr = true
			return
		}
	}
	return
}

//处理仓库库存变化函数
type HandleHouseChangeData struct {
	ShopId   uint64
	HgsId    uint64
	StockNum int32
	Price    float64
}

//处理仓库库存变化函数
func HandleHouseChange(req []*HandleHouseChangeData) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb_goods := tx.Table("h_goods")
		for _, value := range req {
			//获取字段
			hgoods := &entity.HGoods{}
			if err = tb_goods.Where("hgs_id=? and hgs_status<>?", value.HgsId, HGDEL).First(hgoods).Error; err != nil {
				isErr = true
				return
			}
			if value.StockNum < 0 {
				value.StockNum *= (-1)
			}
			//库存不能为负数
			_hsrAfternum := hgoods.HgsSurplusnum - value.StockNum
			if (_hsrAfternum) < 0 {
				_hsrAfternum = 0
			}
			res := entity.HStockRecord{
				HgsID:       value.HgsId,
				HsrType:     CH_HGBUY,
				HsrNum:      (-1) * value.StockNum,
				HsrPrice:    value.Price,
				HsrAfternum: _hsrAfternum,
			}
			hgoods.HgsSalenum += uint32(value.StockNum)
			hgoods.HgsSurplusnum = res.HsrAfternum
			if err = tx.Save(hgoods).Error; err != nil {
				isErr = true
				return
			}
			//保存数据
			if err = tx.Table("h_stock_record").Create(&res).Error; err != nil {
				isErr = true
				return
			}
		}
	}
	return
}

//通过商品id获取商品仓库id
func GoodsIdToHsgID(goodsId string) uint64 {
	tb_goods := dbGorm.Table("goods")
	//获取字段
	goods := &entity.Goods{}

	if err := tb_goods.Where("goods_id=?", goodsId).First(goods).Error; err != nil {
		return uint64(0)
	}

	return goods.HgsID
}

//通过商品仓库id获取商品id
func HsgIdToGoodsId(hgsId uint64) uint64 {
	tb_goods := dbGorm.Table("goods")
	//获取字段
	goods := &entity.Goods{}

	if err := tb_goods.Where("hgs_id=? and goods_status=?", hgsId, COM_UP).First(goods).Error; err != nil {
		return 0
	}

	return goods.GoodsID
}

//检查商品库下存在未完成订单
func CheckExistOrdersing(hgsId uint64, shopId uint64) (res []*OrdersGoodsResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.order_goods_status from orders_goods as a left join  h_goods as b on a.hgs_id=b.hgs_id where a.`status`=0 and b.shop_id=%d and b.hgs_status<>%d and a.order_goods_status<>%d and b.hgs_id = %d "
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, HGDEL, POSC, hgsId))
	dbResult := dbGorm.Raw(sql_buf.String())
	res = make([]*OrdersGoodsResult, 0)
	if err = dbResult.Scan(&res).Error; err != nil {
		return
	}
	return
}

//删除商品库
func DelHouseGoods(hgsId uint64, shopId uint64) (msg string, err error) {

	//如果该商品有存在订单未完成，则不能删除商品库
	res_statistics := make([]*OrdersGoodsResult, 0)
	if res_statistics, err = CheckExistOrdersing(hgsId, shopId); err != nil {
		return
	}
	for _, v_stat := range res_statistics {
		if v_stat.OrderGoodsStatus != uint32(POSC) {
			msg = "有存在订单未完成，不能删除商品库"
			return
		}
	}
	//处理货架上商品信息（删除）
	_handleData := DbSingleCmdEditGoodsReq{
		GoodsID: gconv.String(HsgIdToGoodsId(hgsId)),
		Cmd:     COM_DEL,
	}
	if _handleData.GoodsID != "0" {
		err = SingleCmdEditGoods(&_handleData, shopId)
		if err != nil {
			msg = "删除商品库,自动下架商品失败，请手动尝试先下架商品"
			zaplog.Errorf("SingleCmdEditGoods err=%s", err)
			return
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
		tb_goods := tx.Table("h_goods")
		//获取字段
		hgoods := &entity.HGoods{}
		if err = tb_goods.Where("shop_id=? and hgs_id=? and hgs_status<>?", shopId, hgsId, HGDEL).Update("hgs_status", HGDEL).Error; err != nil {
			return
		}
		res := entity.HStockRecord{
			HgsID:        hgsId,
			HsrType:      CH_HGDEL,
			HsrNum:       0,
			HsrPrice:     0,
			HsrInputtype: IN_VALUE,
			HsrAfternum:  hgoods.HgsSurplusnum,
		}
		//保存数据记录
		if err = tx.Table("h_stock_record").Create(&res).Error; err != nil {
			isErr = true
			return
		}

	}
	return
}

//商品库中下架商品
func DownGoods(hgsId uint64, shopId uint64) (msg string, err error) {

	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb_goods := tx.Table("goods")
		if err = tb_goods.Where("shop_id=? and hgs_id=? and goods_status<>?", shopId, hgsId, GDDEL).Update("goods_status", GDOFTS).Error; err != nil {
			isErr = true
			return
		}

		tb_h_goods := tx.Table("h_goods")
		if err = tb_h_goods.Where("shop_id=? and hgs_id=? and hgs_status<>?", shopId, hgsId, HGDEL).Update("hgs_status", HGING).Error; err != nil {
			isErr = true
			return
		}
	}
	return
}

//添加预购清单
type PreorderData struct {
	// TagID     uint32  `json:"tag_id"`     // 标签id
	TagName string `json:"tag_name"` // 标签名称
	// HgsID     string  `json:"hgs_id"`     // 商品库id
	GoodsName string `json:"goods_name"` // 商品名称
	// UserID    uint32  `json:"user_id"`    // 客户id 0表示非会员
	UserName  string  `json:"user_name"`  // 客户昵称
	Num       uint32  `json:"num"`        // 商品个数
	Remark    string  `json:"remark"`     // 备注
	PayStatus uint32  `json:"pay_status"` // 付款状态 (0 未付 1已付 )
	Inprice   float64 `json:"inprice"`    // 进价
	Saleprice float64 `json:"saleprice"`  // 售价
	Paidmoney float64 `json:"paidmoney"`  // 定金
	Discount  float64 `json:"discount"`   // 其他优惠 （可正负)
}

func CreatePreorder(req *PreorderData, shopId uint64) (msg string, err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		//检查是否有该商品名称
		tb_hg := tx.Table("h_goods")
		hInfo := &entity.HGoods{}
		tb_hg.Where("hgs_name=? and shop_id=? and hgs_status<>? ", req.GoodsName, shopId, HGDEL).First(&hInfo)
		if hInfo.HgsID == 0 {
			//需要创建一条商品库存
			if hInfo, err = CreateHouseInfo(&HouseInfoReq{
				HouseBaseInfo: HouseBaseInfo{
					HgsInprice:   req.Inprice,
					HgsSaleprice: req.Saleprice,
					HgsName:      req.GoodsName,
				},
			}, shopId); err != nil || hInfo == nil {
				isErr = true
				return
			}
		} else {
			//修改进价和售价
			hInfo.HgsInprice = req.Inprice
			hInfo.HgsSaleprice = req.Saleprice
		}
		//判断客户存在
		tb_cu := tx.Table("h_customer")
		_cu := entity.HCustomer{}
		tb_cu.Where("cr_nick=?  and shop_id=?", req.UserName, shopId).First(&_cu)
		if _cu.CustomerID == 0 {
			//创建客户
			_cu = entity.HCustomer{
				ShopID: shopId,
				CrNick: req.UserName,
			}
			if err = tb_cu.Create(&_cu).Error; err != nil {
				isErr = true
				return
			}
		}
		//判断标签存在
		tb_tag := tx.Table("h_tag")
		_tag := entity.HTag{}
		if err = tb_tag.Where("name=? and shop_id=? ", req.TagName, shopId).First(&_tag).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
			isErr = true
			return
		}
		if _tag.ID == 0 {
			//创建标签
			_tag = entity.HTag{
				ShopID: shopId,
				Name:   req.TagName,
			}
			if err = tb_tag.Create(&_tag).Error; err != nil {
				isErr = true
				return
			}
		}

		tb_p := tx.Table("h_preorder")
		_preorder := entity.HPreorder{}
		//先判断是否已存在相同预购单
		if err = tb_p.Where("tag_id=? and shop_id=? and hgs_id=? and customer_id=?  and buy_status=0", _tag.ID, shopId, hInfo.HgsID, _cu.CustomerID).First(&_preorder).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
			isErr = true
			return
		}
		err = nil
		if _preorder.ID == 0 {
			//插入预购清单表
			_preorder = entity.HPreorder{
				TagID:      _tag.ID,
				HgsID:      hInfo.HgsID,
				ShopID:     shopId,
				CustomerID: _cu.CustomerID,
				Discount:   null.FloatFrom(req.Discount),
			}
			if err = tb_p.Create(&_preorder).Error; err != nil {
				isErr = true
				return
			}
			//创建订单商品表
			preorderParam := &PreorderOrderGoodsParam{
				HpId:             _preorder.ID,
				PayStatus:        req.PayStatus,
				OrderGoodsStatus: uint32(PONOBUY),
				Remark:           req.Remark,
				Paidmoney:        req.Paidmoney,
			}
			if err = InsertOrderGoods_Preorder(tx, hInfo, req.Num, preorderParam, ""); err != nil {
				return
			}
		} else {
			//已存在
			//数据合并
			_preorder.Discount = null.FloatFrom(req.Discount)
			if err = tb_p.Where("tag_id=? and shop_id=? and hgs_id=? and customer_id=? and buy_status=0 ", _tag.ID, shopId, hInfo.HgsID, _cu.CustomerID).Updates(map[string]interface{}{
				"discount": req.Discount,
			}).Error; err != nil {
				isErr = true
				return
			}

			//先获取商品订单信息
			_orders_goods := &entity.OrdersGoods{}
			if _orders_goods, err = PreorderIDToss(_preorder.ID); err != nil {
				isErr = true
				return
			}
			_quantity := _orders_goods.Quantity + int32(req.Num)
			//更新商品订单
			tb_og := dbGorm.Table("orders_goods").Where("hp_id=? and status=? ", _preorder.ID, OG_NORMAL).Updates(map[string]interface{}{
				"quantity":          _quantity,
				"input_price":       req.Inprice,
				"single_price":      req.Saleprice,
				"total_input_price": (req.Inprice * float64(_quantity)),
				"total_price":       (req.Saleprice * float64(_quantity)),
				"paidmoney":         req.Paidmoney,
			})
			if err = tb_og.Error; err != nil {
				isErr = true
				return
			}
		}
	}
	return
}

//预购清单插入商品订单参数
type PreorderOrderGoodsParam struct {
	LogisticsId      uint32  `json:"logistics_id"`       // 订单物流id
	HpId             uint64  `json:"hp_id"`              // 预购清单id
	PayStatus        uint32  `json:"pay_status"`         // 付款状态 (0 未付 1已付 )
	OrderGoodsStatus uint32  `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	Paidmoney        float64 `json:"paidmoney"`          // 定金
	Remark           string  `json:"remark"`             // 备注
}

//插入清单商品信息带订单商品表内
//hInfo商品库信息，hpNum清单商品数目，hpId清单id,strOrderId订单id
func InsertOrderGoods_Preorder(tx *gorm.DB, hInfo *entity.HGoods, hpNum uint32, preorderPram *PreorderOrderGoodsParam, strOrderId string) (err error) {
	_productList := make([]GoodsListParam, 1)
	_productList[0] = GoodsListParam{
		GoodsId:        "0",
		SpID:           0,
		Quantity:       int32(hpNum),
		SinglePrice:    hInfo.HgsSaleprice,
		TotalPrice:     hInfo.HgsSaleprice * float64(hpNum),
		Specifications: "",
		GoodsName:      hInfo.HgsName,
		Image:          hInfo.HgsImg.String,
	}
	_goodsNumResInfo := make([]*DbUpdateGoodsNumRes, 1)
	_goodsNumResInfo[0] = &DbUpdateGoodsNumRes{
		HgsId:           hInfo.HgsID, //#商品库id
		GoodsId:         0,
		SpID:            0,
		InputPrice:      hInfo.HgsInprice,
		TotalInputPrice: hInfo.HgsInprice * float64(hpNum),
	}
	err = BatchInsertOrderGoods(tx, strOrderId, preorderPram, _productList, _goodsNumResInfo)
	return
}

//清单id获取订单商品信息
func PreorderIDToss(PreorderID uint64) (res *entity.OrdersGoods, err error) {
	//需要先获取订单商品信息
	res = &entity.OrdersGoods{}
	tb_og := dbGorm.Table("orders_goods")
	if err = tb_og.Where("hp_id=? and status=?", PreorderID, OG_NORMAL).First(res).Error; err != nil {
		return
	}
	return
}

//搜索对象名称列表结果
type SearchNameListResult struct {
	ObjectID   string `json:"object_id"`   // 对象id(标签id,客户id,商品id)
	ObjectName string `json:"object_name"` // 对象名称
}

//预购清单搜索已存在对象名称请求
func SearchPreorderObjectName(kind uint32, searchName string, shopId uint64) (res []*SearchNameListResult, msg string, err error) {
	var tb *gorm.DB
	res = make([]*SearchNameListResult, 0)
	switch kind {
	case 0:
		//搜索标签
		tb = dbGorm.Table("h_tag").Where("deleted_at is null and name like ? and shop_id=?", "%"+searchName+"%", shopId).Select("name as object_name,id as object_id")
	case 1:
		//搜索客户名
		tb = dbGorm.Table("h_customer").Where("deleted_at is null and cr_nick like ? and shop_id=?", "%"+searchName+"%", shopId).Select("cr_nick as object_name,customer_id as object_id")
	case 2:
		//搜索商品名
		tb = dbGorm.Table("h_goods").Where("hgs_status<>? and hgs_name like ? and shop_id=?", HGDEL, "%"+searchName+"%", shopId).Select("hgs_name as object_name,hgs_id as object_id")
	default:
		return nil, "不存在该类型", nil
	}
	if err = tb.Find(&res).Error; err != nil {
		return
	}
	return
}

//预购清单派单列表结果
type PreorderTaskListResultInfo struct {
	TagName    string `json:"tag_name"`    // 标签名称
	GoodsName  string `json:"goods_name"`  // 商品名称
	GoodsCount uint32 `json:"goods_count"` // 数量
	Remark     string `json:"remark"`      // 备注
}
type PreorderTaskListResult struct {
	GoodsName  string `json:"goods_name"`  // 商品名称
	GoodsCount uint32 `json:"goods_count"` // 数量
	Remark     string `json:"remark"`      // 备注
}

//预购清单搜索已存在对象名称请求
func PreorderTask(tagId uint32, shopId uint64) (res []*PreorderTaskListResult, tagName string, msg string, err error) {

	query_data := make([]*PreorderTaskListResultInfo, 0)
	tb := dbGorm.Table("h_preorder as a").Joins("left join h_tag as b on b.id=a.tag_id").Joins("left join orders_goods as c on c.hp_id=a.id").Select("b.name as tag_name,c.goods_name,c.quantity as goods_count,c.remark").Where("a.deleted_at is null and b.deleted_at is null and a.shop_id=? and b.id=? and a.buy_status=0", shopId, tagId)
	if err = tb.Find(&query_data).Error; err != nil || len(query_data) == 0 {
		return
	}
	res = make([]*PreorderTaskListResult, len(query_data))
	for k, value := range query_data {
		res[k] = &PreorderTaskListResult{
			GoodsName:  value.GoodsName,
			GoodsCount: value.GoodsCount,
			Remark:     value.Remark,
		}
		if tagName == "" && value.TagName != "" {
			tagName = value.TagName
		}
	}

	return
}

//预购清单商品买到请求
type PreorderBuyData struct {
	PreorderID *uint64 `json:"preorder_id"` // 预购单id 传null表示不使用该值,非空表示只操作单个预购商品
	*GoodsKindData
	UserID *uint32 `json:"user_id"` // 用户ID 传null表示不使用该值
}
type GoodsKindData struct {
	HgsID *string `json:"hgs_id"` // 商品库ID 传null表示不使用该值
	TagID *uint32 `json:"tag_id"` // 标签ID 传null表示不使用该值
}

func PreorderBuy(req *PreorderBuyData, shopId uint64) (err error) {

	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb_p := tx.Table("h_preorder")
		tb_p_main := tb_p
		if req.PreorderID != nil {
			tb_p_main = tb_p.Where("id=? and shop_id=? and buy_status=0", req.PreorderID, shopId)
		} else if req.HgsID != nil && req.TagID != nil {
			tb_p_main = tb_p.Where("hgs_id=? and tag_id=? and shop_id=? and buy_status=0", req.HgsID, req.TagID, shopId)
		} else {
			tb_p_main = tb_p.Where("customer_id=? and shop_id=? and buy_status=0", req.UserID, shopId)
		}
		//查找店铺下所有预购清单ID
		_hpreorder_Arr := make([]*entity.HPreorder, 0)
		if err = tb_p_main.Order("created_at asc").Find(&_hpreorder_Arr).Error; err != nil {
			isErr = true
			return
		}
		for k, _preorder := range _hpreorder_Arr {
			if _preorder == nil {
				isErr = true
				return
			}
			//更新预购订单 购买状态为商家已买到
			tb_update := tb_p.Where("id=? and shop_id=?", _preorder.ID, shopId).Update("buy_status", 1)
			if err = tb_update.Error; err != nil {
				isErr = true
				return
			}
			//获取买家对外id（userid 非customerId）
			_hCustomer := entity.HCustomer{}
			if err = tx.Table("h_customer").Where("customer_id=?", _preorder.CustomerID).First(&_hCustomer).Error; err != nil {
				isErr = true
				return
			}

			//获取商品库id对应的数据
			_orders_goods := &entity.OrdersGoods{}
			if _orders_goods, err = PreorderIDToss(_preorder.ID); err != nil {
				isErr = true
				return
			}
			//创建订单表
			if err = HPInsertOrders(tx, uint64(k), &_hCustomer, _preorder, _orders_goods); err != nil {
				isErr = true
				return
			}

		}
	}
	return
}

//预购清单插入订单表数据以及更新修改对应的订单商品表、插入订单物流默认数据
//index表示批量序号,userId对外用户id,_preorder预购单信息，hInfo商品库信息
func HPInsertOrders(tx *gorm.DB, index uint64, hcustomer *entity.HCustomer, _preorder *entity.HPreorder, hInfo *entity.OrdersGoods) (err error) {
	//新建orders表 插入订单信息显示给用户查看，订单状态为未确认（或者未付款）
	//获取订单id
	var strOrderId string
	if hcustomer.CrUserid == 0 {
		strOrderId = GetOrdersId(_preorder.CustomerID) //使用客户id（表示给未注册用户生成的订单）
	} else {
		strOrderId = GetOrdersId(hcustomer.CrUserid)
	}

	strOrderId = gconv.String(gconv.Uint64(strOrderId) + index) //批量处理防止订单号生成重复
	zaplog.Debugf("【预购清单商品买到】打印订单id, StrOrderId=%s", strOrderId)
	_goods_nameArr := hInfo.GoodsName //订单商品
	//计算利润
	_profit := SubtractFloat64(hInfo.TotalPrice, hInfo.TotalInputPrice.Float64)
	if err = tx.Create(&entity.Orders{
		OrderID:           strOrderId,
		UserID:            hcustomer.CrUserid,
		CustomerID:        hcustomer.CustomerID,
		CustomerName:      null.StringFrom(hcustomer.CrNick),
		ShopID:            _preorder.ShopID,
		PreferentialPrice: null.Float{},
		Price:             hInfo.TotalPrice,
		Profit:            _profit, //利润
		Remark:            hInfo.Remark,
		GoodsNameArr:      null.StringFrom(gconv.String(_goods_nameArr)),
		Status:            1,
	}).Error; err != nil {
		return
	}

	//创建订单物流
	_ol_data := entity.OrdersLogistics{
		OrderID:     strOrderId,
		IsDefault:   1,
		UfPayStatus: 0, //默认未付
		Status:      0,
	}
	if err = tx.Create(&_ol_data).Error; err != nil {
		return
	}

	//更新修改对应的订单商品表订单ID值 以及状态为已买到和买到时间，订单物流id
	tb_og := tx.Table("orders_goods").Where("hp_id=? and status=0", _preorder.ID).Updates(g.Map{"order_id": strOrderId, "order_goods_status": POBUY, "buy_time": time.Now().Format(timeFormat), "logistics_id": _ol_data.ID})
	if err = tb_og.Error; (err != nil && !gorm.IsRecordNotFoundError(err)) || tb_og.RowsAffected == 0 {
		return
	}
	return
}

//预购清单商品修改标签请求
type ModPreorderTagData struct {
	MoveTagID uint32 `json:"move_tag_id"` // 要移动的标签id
	TagID     uint32 `json:"tag_id"`      // 移动后的标签id
	HgsID     string `json:"hgs_id"`      // 商品库ID
}

func ModPreorderTag(req *ModPreorderTagData, shopId uint64) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb_p := tx.Table("h_preorder")
		tb_p_main := tb_p.Where("hgs_id=? and tag_id=? and shop_id=? and buy_status=0", req.HgsID, req.MoveTagID, shopId)
		//查找店铺下所有预购清单ID
		_hpreorder_Arr := make([]*entity.HPreorder, 0)
		if err = tb_p_main.Order("created_at asc").Find(&_hpreorder_Arr).Error; err != nil {
			isErr = true
			return
		}
		for _, _preorder := range _hpreorder_Arr {
			if _preorder == nil {
				isErr = true
				return
			}
			//更新预购订单标签ID
			tb_update := tb_p.Where("id=? and shop_id=?", _preorder.ID, shopId).Update("tag_id", req.TagID)
			if err = tb_update.Error; err != nil {
				isErr = true
				return
			}
		}
	}
	return
}

//预购清单买家分类查看账单请求
type PreorderCheckBillParam struct {
	UserID uint32 `json:"user_id"` // 买家ID
}

//应答
type PreorderCheckBillInfo struct {
	GoodsName    string  `json:"goods_name"`     // 订单商品商品
	OrderGoodsID uint32  `json:"order_goods_id"` // 订单商品id
	PreorderNum  uint32  `json:"preorder_num"`   // 预购商品数目
	InputPrice   float64 `json:"input_price"`    // 进价
	SinglePrice  float64 `json:"single_price"`   // 售价
	Paidmoney    float64 `json:"paidmoney"`      // 定金
	PayStatus    uint32  `json:"pay_status"`     // 付款状态 0未付 1已付
}
type PreorderCheckBillResult struct {
	UserName     string  `json:"user_name"`      //  客户名称
	GoodsName    string  `json:"goods_name"`     // 订单商品名称
	OrderGoodsID uint32  `json:"order_goods_id"` // 订单商品id
	PreorderNum  uint32  `json:"preorder_num"`   // 预购商品数目
	InputPrice   float64 `json:"input_price"`    // 进价
	SinglePrice  float64 `json:"single_price"`   // 售价
	Paidmoney    float64 `json:"paidmoney"`      // 定金
	PayStatus    uint32  `json:"pay_status"`     // 付款状态 0未付 1已付
}

func PreorderCheckBill(req *PreorderCheckBillParam, shopId uint64) (res []*PreorderCheckBillInfo, userName string, err error) {
	_query := make([]*PreorderCheckBillResult, 0)
	tb := dbGorm.Table("h_preorder as a").Joins("left join orders_goods as b on b.hp_id =a.id and a.buy_status=0").Joins("left join h_customer as c on a.customer_id =c.customer_id").Select("c.cr_nick as user_name,b.goods_name,b.id as order_goods_id,b.quantity as preorder_num,b.input_price,b.single_price,b.paidmoney,b.pay_status").Where("a.customer_id=? and a.shop_id=? and b.status=0", req.UserID, shopId)
	if err = tb.Find(&_query).Error; err != nil || len(_query) == 0 {
		return
	}

	res = make([]*PreorderCheckBillInfo, len(_query))
	for i, _ := range _query {
		res[i] = &PreorderCheckBillInfo{
			GoodsName:    _query[i].GoodsName,
			OrderGoodsID: _query[i].OrderGoodsID,
			PreorderNum:  _query[i].PreorderNum,
			InputPrice:   _query[i].InputPrice,
			SinglePrice:  _query[i].SinglePrice,
			Paidmoney:    _query[i].Paidmoney,
			PayStatus:    _query[i].PayStatus,
		}
		if userName == "" {
			userName = _query[i].UserName
		}
	}
	return
}

//清单列表总数获取结果
func CheckPreorderGoodsCount(shopId uint64) (pCount int, oCount int) {

	//未买到总数
	dbGorm.Table("h_preorder").Where("shop_id=? and buy_status=0  and deleted_at is null", shopId).Group("tag_id").Count(&pCount)
	//未完成总数
	dbGorm.Table("orders").Where("shop_id=? and order_status<>? and status=1 and deleted_at is null", shopId, OSC).Count(&oCount)
	return
}

//查看预购清单列表

//商品分类清单列表结果
type PreorderGoodsListInfoResult struct {
	TagID        uint32 `json:"tag_id"`         // 标签编号
	TagName      string `json:"tag_name"`       // 标签名称
	GoodsName    string `json:"goods_name"`     // 商品名称
	HgsID        string `json:"hgs_id"`         // 商品库ID
	SurplusNum   int32  `json:"surplus_num"`    // 库存数目
	PreorderID   uint64 `json:"preorder_id"`    // 预购单id
	UserID       uint32 `json:"user_id"`        // 买家id
	UserName     string `json:"user_name"`      // 买家昵称
	PreorderNum  uint32 `json:"preorder_num"`   // 预购商品数目
	Remark       string `json:"remark"`         // 备注
	OrderGoodsID uint32 `json:"order_goods_id"` // 订单商品id
}

type PreorderGoodsListResult struct {
	TagID        uint32                   `json:"tag_id"`        // 标签编号
	TagName      string                   `json:"tag_name"`      // 标签名称
	PreorderList []*PreorderGoodsListInfo `json:"preorder_list"` // 商品信息
}
type PreorderGoodsListInfo struct {
	HgsID      string                  `json:"hgs_id"`      // 商品库ID
	GoodsName  string                  `json:"goods_name"`  // 商品名称
	GoodsCount uint32                  `json:"goods_count"` // 商品总数目
	SurplusNum int32                   `json:"surplus_num"` // 库存数目
	UserInfo   []*PreorderGoodsSubInfo `json:"user_info"`   // 买家信息
}
type PreorderGoodsSubInfo struct {
	PreorderID   uint64 `json:"preorder_id"`    // 预购单id
	OrderGoodsID uint32 `json:"order_goods_id"` // 订单商品id
	UserID       uint32 `json:"user_id"`        // 买家id
	UserName     string `json:"user_name"`      // 买家昵称
	PreorderNum  uint32 `json:"preorder_num"`   // 预购商品数目
	Remark       string `json:"remark"`         // 备注
}

//商品分类清单列表结果
func PreorderGoodsList(req *PageHouseReq, shopId uint64) (res []*PreorderGoodsListResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.shop_id,a.tag_id,b.name as tag_name,a.hgs_id,d.hgs_name as goods_name,d.hgs_surplusnum as surplus_num,	e.quantity as preorder_num,a.id as preorder_id,a.customer_id as user_id,c.cr_nick as user_name,e.remark,a.buy_status,e.id as order_goods_id from (select * from  h_preorder where shop_id=%d and buy_status=%d ORDER BY created_at ASC LIMIT %d OFFSET %d)as a left join  h_tag as b on a.tag_id = b.id left join h_customer as c on a.customer_id=c.customer_id left join  h_goods as d on a.hgs_id=d.hgs_id LEFT JOIN orders_goods AS e ON e.hp_id = a.id where a.hgs_id<>0 and e.status=%d ORDER BY b.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, 0, req.Count, req.StartIndex, OG_NORMAL))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*PreorderGoodsListInfoResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil || len(query_data) == 0 {
		return
	}
	res = PreorderListFunc(query_data)
	return
}

func PreorderListFunc(query_data []*PreorderGoodsListInfoResult) (res []*PreorderGoodsListResult) {
	psMap := map[uint32]int{} //key=标签id value=标签id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].TagID]++
	}

	//处理数据
	res = make([]*PreorderGoodsListResult, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0

	for _, q_value := range query_data {
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.TagID == q_value.TagID {
					//重复的标签下的重复商品
					var isRepeat bool = false //标签下重复商品
					for _, p_value := range all_value.PreorderList {
						if p_value != nil && p_value.HgsID == q_value.HgsID {
							//找到重复
							p_value.GoodsCount += q_value.PreorderNum
							p_value.UserInfo = append(p_value.UserInfo, &PreorderGoodsSubInfo{
								OrderGoodsID: q_value.OrderGoodsID,
								PreorderID:   q_value.PreorderID,
								UserID:       q_value.UserID,
								UserName:     q_value.UserName,
								PreorderNum:  q_value.PreorderNum,
								Remark:       q_value.Remark,
							})
							isRepeat = true
							break
						}
					}
					if !isRepeat {
						//需要新的商品分类
						all_value.PreorderList = append(all_value.PreorderList, &PreorderGoodsListInfo{
							HgsID:      q_value.HgsID,
							GoodsName:  q_value.GoodsName,
							GoodsCount: q_value.PreorderNum,
							SurplusNum: q_value.SurplusNum,
						})
						all_value.PreorderList[len(all_value.PreorderList)-1].UserInfo = append(all_value.PreorderList[len(all_value.PreorderList)-1].UserInfo, &PreorderGoodsSubInfo{
							OrderGoodsID: q_value.OrderGoodsID,
							PreorderID:   q_value.PreorderID,
							UserID:       q_value.UserID,
							UserName:     q_value.UserName,
							PreorderNum:  q_value.PreorderNum,
							Remark:       q_value.Remark,
						})
					}
					return true
				}
			}
			return false
		}() {
			continue
		}

		res[all_index] = &PreorderGoodsListResult{
			TagID:   q_value.TagID,
			TagName: q_value.TagName,
		}
		res[all_index].PreorderList = append(res[all_index].PreorderList, &PreorderGoodsListInfo{
			HgsID:      q_value.HgsID,
			GoodsName:  q_value.GoodsName,
			GoodsCount: q_value.PreorderNum,
			SurplusNum: q_value.SurplusNum,
		})
		res[all_index].PreorderList[len(res[all_index].PreorderList)-1].UserInfo = append(res[all_index].PreorderList[len(res[all_index].PreorderList)-1].UserInfo, &PreorderGoodsSubInfo{
			OrderGoodsID: q_value.OrderGoodsID,
			PreorderID:   q_value.PreorderID,
			UserID:       q_value.UserID,
			UserName:     q_value.UserName,
			PreorderNum:  q_value.PreorderNum,
			Remark:       q_value.Remark,
		})
		all_index++
	}
	return
}

//商品分类订单列表结果
type OrdersGoodsListInfoResult struct {
	OrderID          string `json:"order_id"`           // 订单id
	UfPayStatus      uint32 `json:"uf_pay_status"`      // 邮费付款状态 0未付 1已付
	PayStatus        uint32 `json:"pay_status"`         // 付款状态 0未付 1已付
	OrderGoodsStatus string `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsName        string `json:"goods_name"`         // 商品名称
	Specifications   string `json:"specifications"`     // 商品规格
	HgsID            string `json:"hgs_id"`             // 商品库ID
	SurplusNum       int32  `json:"surplus_num"`        // 商品库剩余
	OrderGoodsID     uint32 `json:"order_goods_id"`     // 订单商品编号
	UserID           uint32 `json:"user_id"`            // 买家名称
	UserName         string `json:"user_name"`          // 买家名称
	GoodsCount       uint32 `json:"goods_count"`        // 买家商品数目
	Remark           string `json:"remark"`             // 备注
}
type OrdersOrderListResult struct {
	OrderID     string                 `json:"order_id"`      // 订单id
	UserID      uint32                 `json:"user_id"`       // 买家名称
	UserName    string                 `json:"user_name"`     // 买家名称
	GoodsCount  uint32                 `json:"goods_count"`   // 买家商品数目
	UfPayStatus uint32                 `json:"uf_pay_status"` // 邮费付款状态 0未付 1已付
	GoodsList   []*OrdersGoodsListInfo `json:"goods_list"`    // 订单列表
}
type OrdersGoodsListInfo struct {
	HgsID            string `json:"hgs_id"`             // 商品库ID
	OrderGoodsID     uint32 `json:"order_goods_id"`     // 订单商品编号
	GoodsName        string `json:"goods_name"`         // 商品名称
	Specifications   string `json:"specifications"`     // 商品规格
	GoodsNum         uint32 `json:"goods_num"`          // 商品总数目
	SurplusNum       int32  `json:"surplus_num"`        // 商品库剩余
	PayStatus        uint32 `json:"pay_status"`         // 付款状态 0未付 1已付
	OrderGoodsStatus string `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	Remark           string `json:"remark"`             // 备注
}

//订单列表结果
func OrdersGoodsList(req *PageHouseReq, shopId uint64) (res []*OrdersOrderListResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.order_id,a.quantity as goods_count ,c.customer_id as user_id,c.cr_nick as user_name,a.hgs_id,a.goods_name as goods_name,d.hgs_surplusnum as surplus_num , a.id as order_goods_id,a.specifications,a.order_goods_status,a.`status`,a.pay_status,a.remark,e.uf_pay_status ,b.created_at FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d and order_status < %d order by created_at desc  LIMIT %d OFFSET %d) as b on a.order_id=b.order_id left join h_customer  as c on c.customer_id=b.customer_id and c.shop_id=b.shop_id left join  h_goods as d on a.hgs_id=d.hgs_id LEFT JOIN orders_logistics AS e ON e.order_id = a.order_id  and e.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id <>'' order by b.created_at  desc" //and c.customer_id<>0  and a.order_goods_status in (%d,%d) , POBUY, POSD
	//0表示清单 1表示收款发货 2表示已完成
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, OSC, req.Count, req.StartIndex))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*OrdersGoodsListInfoResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil || len(query_data) == 0 {
		return
	}
	res = OrdersListFunc(query_data)
	// zaplog.Infof("订单分类查看:%s", gconv.String(res))
	return
}

//商品分类订单列表结果
func OrdersListFunc(query_data []*OrdersGoodsListInfoResult) (res []*OrdersOrderListResult) {
	//获取详细列表数据
	psMap := map[string]int{} //key=订单id value=标签id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].OrderID] += int(query_data[i].GoodsCount)
	}

	//处理数据
	res = make([]*OrdersOrderListResult, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0
	for _, q_value := range query_data {

		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.OrderID == q_value.OrderID {
					all_value.GoodsCount += q_value.GoodsCount
					//重复的订单下的重复商品
					var isRepeat bool = false //标签下重复商品
					for _, preorder_value := range all_value.GoodsList {
						if preorder_value != nil && preorder_value.OrderGoodsID == q_value.OrderGoodsID {
							//找到重复
							preorder_value.GoodsNum += q_value.GoodsCount
							isRepeat = true
						}
						break
					}
					if !isRepeat {
						//需要新的商品分类
						all_value.GoodsList = append(all_value.GoodsList, &OrdersGoodsListInfo{
							OrderGoodsID:     q_value.OrderGoodsID,
							HgsID:            q_value.HgsID,
							GoodsName:        q_value.GoodsName,
							Specifications:   q_value.Specifications,
							GoodsNum:         q_value.GoodsCount,
							SurplusNum:       q_value.SurplusNum,
							Remark:           q_value.Remark,
							PayStatus:        q_value.PayStatus,
							OrderGoodsStatus: q_value.OrderGoodsStatus,
						})
					}
					return true
				}
			}
			return false
		}() {
			continue
		}
		res[all_index] = &OrdersOrderListResult{
			OrderID:     q_value.OrderID,
			UserID:      q_value.UserID,
			UserName:    q_value.UserName,
			GoodsCount:  q_value.GoodsCount,
			UfPayStatus: q_value.UfPayStatus,
		}
		res[all_index].GoodsList = append(res[all_index].GoodsList, &OrdersGoodsListInfo{
			OrderGoodsID:     q_value.OrderGoodsID,
			HgsID:            q_value.HgsID,
			GoodsName:        q_value.GoodsName,
			Specifications:   q_value.Specifications,
			GoodsNum:         q_value.GoodsCount,
			SurplusNum:       q_value.SurplusNum,
			Remark:           q_value.Remark,
			PayStatus:        q_value.PayStatus,
			OrderGoodsStatus: q_value.OrderGoodsStatus,
		})
		all_index++
	}

	return
}

//商品分类清单列表结果
func PreorderGoodsListEx(req *PageHouseReq, searchType uint32, inputTerms string, shopId uint64) (res []*PreorderGoodsListResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.shop_id,a.tag_id,b.name as tag_name,a.hgs_id,d.hgs_name as goods_name,d.hgs_surplusnum as surplus_num,	e.quantity as preorder_num,a.id as preorder_id,a.customer_id as user_id,c.cr_nick as user_name,e.remark,a.buy_status,e.id as order_goods_id from (select * from  h_preorder where shop_id=%d and buy_status=%d)as a left join  h_tag as b on a.tag_id = b.id left join h_customer as c on a.customer_id=c.customer_id left join  h_goods as d on a.hgs_id=d.hgs_id LEFT JOIN orders_goods AS e ON e.hp_id = a.id where a.hgs_id<>0 and e.status=%d"
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, 0, OG_NORMAL))

	if inputTerms != "" {
		if (searchType & 0x20) > 0 {
			sql = " and (goods_name like '%s' or b.name like '%s' )"
			sql_buf.WriteString(fmt.Sprintf(sql, "%"+inputTerms+"%", "%"+inputTerms+"%"))
		} else if (searchType & 0x40) > 0 {
			sql = " and c.cr_nick like '%s' "
			sql_buf.WriteString(fmt.Sprintf(sql, "%"+inputTerms+"%"))
		}
	}

	sql = "	ORDER BY b.created_at ASC  LIMIT %d OFFSET %d"
	sql_buf.WriteString(fmt.Sprintf(sql, req.Count, req.StartIndex))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*PreorderGoodsListInfoResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil || len(query_data) == 0 {
		return
	}
	res = PreorderListFunc(query_data)
	return
}

//订单列表结果
//searchType搜索类型 0不选择 1按订单状态已全付 2已全发 4未全付 8未全发 16按订单号 32按订单商品名 64按客户名
func OrdersGoodsListEx(req *PageHouseReq, searchType uint32, inputTerms string, shopId uint64) (res []*OrdersOrderListResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.order_id,a.quantity as goods_count ,f.customer_id as user_id,f.cr_nick as user_name,a.hgs_id,d.hgs_name as goods_name,d.hgs_surplusnum as surplus_num , a.id as order_goods_id,a.specifications,a.order_goods_status,a.`status`,a.pay_status,a.remark,e.uf_pay_status ,f.created_at FROM orders_goods as a left join (SELECT b.*,c.cr_nick FROM orders as b left join h_customer  as c on c.customer_id=b.customer_id and c.shop_id=b.shop_id  WHERE status=1 and b.shop_id=%d  "
	sql_buf.WriteString(fmt.Sprintf(sql, shopId))

	if inputTerms != "" {
		if (searchType & 0x10) > 0 {
			sql = " and b.order_id='%s' "
			sql_buf.WriteString(fmt.Sprintf(sql, inputTerms))
		} else if (searchType & 0x20) > 0 {
			sql = " and b.goods_name_arr  like '%s' "
			sql_buf.WriteString(fmt.Sprintf(sql, "%"+inputTerms+"%"))
		} else if (searchType & 0x40) > 0 {
			sql = " and c.cr_nick like '%s' "
			sql_buf.WriteString(fmt.Sprintf(sql, "%"+inputTerms+"%"))
		}
	}

	//付款状态
	if (searchType & 0x01) > 0 {
		sql = " and b.ispay=%d "
		sql_buf.WriteString(fmt.Sprintf(sql, 1))
	} else if (searchType & 0x04) > 0 {
		sql = " and b.ispay=%d "
		sql_buf.WriteString(fmt.Sprintf(sql, 0))
	}
	if (searchType & 0x02) > 0 {
		sql = " and b.isdeliver=%d "
		sql_buf.WriteString(fmt.Sprintf(sql, 1))
	} else if (searchType & 0x08) > 0 {
		sql = " and b.isdeliver<>%d "
		sql_buf.WriteString(fmt.Sprintf(sql, 1))
	}

	sql = " ORDER BY b.created_at desc LIMIT %d OFFSET %d) as f on a.order_id=f.order_id  left join  h_goods as d on a.hgs_id=d.hgs_id LEFT JOIN orders_logistics AS e ON e.order_id = a.order_id  and e.id=a.logistics_id where a.`status`=0 and f.status=1 and f.order_id<>'' and f.customer_id<>0  and a.order_goods_status in (%d,%d)"

	sql_buf.WriteString(fmt.Sprintf(sql, req.Count, req.StartIndex, POBUY, POSD))
	if inputTerms != "" && (searchType&0x20) > 0 {
		sql = " and d.hgs_name  like '%s' "
		sql_buf.WriteString(fmt.Sprintf(sql, "%"+inputTerms+"%"))
	}
	sql_buf.WriteString("  ORDER BY a.created_at desc ")
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*OrdersGoodsListInfoResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil || len(query_data) == 0 {
		return
	}
	res = OrdersListFunc(query_data)
	return
}

//查看单个商品所属的买家订单信息
type SingleGoodsListResult struct {
	GoodsName  string                 `json:"goods_name"`       //商品名称
	GoodsCount uint32                 `json:"goods_count"`      //商品总数
	Count      int                    `json:"count"`            //列表个数
	GoodsList  []*SingleGoodsListInfo `json:"order_order_list"` //买家订单分类列表
}
type SingleGoodsListInfo struct {
	UserName     string  `json:"user_name"`      // 买家名称
	GoodsCount   uint32  `json:"goods_count"`    // 买家商品数目
	OrderGoodsID uint32  `json:"order_goods_id"` // 订单商品编号
	InputPrice   float64 `json:"input_price"`    // 进价
	SinglePrice  float64 `json:"single_price"`   // 售价
	PayStatus    uint32  `json:"pay_status"`     // 付款状态 0未付 1已付
}

func SingleGoodsList(hgsID string, shopID uint64) (res *SingleGoodsListResult, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.id as order_goods_id, a.goods_name,a.pay_status,a.paidmoney,a.quantity as goods_count,a.order_goods_status,a.input_price,a.single_price,a.hp_id,c.customer_id,c.cr_nick as user_name from orders_goods as a left join orders as b on a.order_id=b.order_id left join h_customer as c on c.customer_id=b.customer_id where b.shop_id=%d and a.hgs_id='%s' and a.order_goods_status between %d and %d  and a.status=0 and b.status=1 ORDER BY a.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, hgsID, PONOBUY, POSD))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*PreorderBillListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}
	//处理数据
	res = &SingleGoodsListResult{}
	res.Count = len(query_data)
	res.GoodsList = make([]*SingleGoodsListInfo, len(query_data))

	for i := 0; i < len(query_data); i++ {
		res.GoodsList[i] = &SingleGoodsListInfo{
			OrderGoodsID: query_data[i].OrderGoodsID,
			UserName:     query_data[i].UserName,
			GoodsCount:   query_data[i].GoodsCount,
			InputPrice:   query_data[i].InputPrice,
			SinglePrice:  query_data[i].SinglePrice,
			PayStatus:    query_data[i].PayStatus,
		}
		res.GoodsCount += query_data[i].GoodsCount
		if res.GoodsName == "" {
			res.GoodsName = query_data[i].GoodsName
		}
	}
	return
}

//买家账单列表 预购清单界面
type PreorderBillListResult struct {
	UserName         string  `json:"user_name"`          // 客户名称
	HpID             string  `json:"hp_id"`              // 预购清单id
	GoodsCount       uint32  `json:"goods_count"`        // 买家商品数目
	OrderGoodsID     uint32  `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32  `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsName        string  `json:"goods_name"`         // 商品名称
	PayStatus        uint32  `json:"pay_status"`         // 付款状态 0未付 1已付
	InputPrice       float64 `json:"input_price"`        // 进价
	SinglePrice      float64 `json:"single_price"`       // 售价
	Paidmoney        float64 `json:"paidmoney"`          // 定金
}

type PreorderBillListInfo struct {
	GoodsCount       uint32  `json:"goods_count"`        // 买家商品数目
	OrderGoodsID     uint32  `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32  `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsName        string  `json:"goods_name"`         // 商品名称
	Specifications   string  `json:"specifications"`     // 商品规格
	PayStatus        uint32  `json:"pay_status"`         // 付款状态 0未付 1已付
	InputPrice       float64 `json:"input_price"`        // 进价
	SinglePrice      float64 `json:"single_price"`       // 售价
	Paidmoney        float64 `json:"paidmoney"`          // 定金
}

func UserPreorderBill(UserID uint32, shopID uint64) (res []*PreorderBillListInfo, userName string, err error) {
	//获取指定客户的账单
	//
	var sql_buf bytes.Buffer
	sql := "select a.id as order_goods_id, a.goods_name,a.pay_status,a.paidmoney,a.quantity as goods_count,a.order_goods_status,a.input_price,a.single_price,a.hp_id,c.customer_id,c.cr_nick as user_name from orders_goods as a left join h_preorder AS b ON b.id = a.hp_id left join h_customer as c on c.customer_id=b.customer_id where b.shop_id=%d and c.customer_id=%d and a.order_goods_status=%d and a.status=0 and b.status=0 ORDER BY a.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, UserID, PONOBUY))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*PreorderBillListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}
	//处理数据
	res = make([]*PreorderBillListInfo, len(query_data))

	for i := 0; i < len(query_data); i++ {
		res[i] = &PreorderBillListInfo{
			OrderGoodsID:     query_data[i].OrderGoodsID,
			GoodsName:        query_data[i].GoodsName,
			GoodsCount:       query_data[i].GoodsCount,
			PayStatus:        query_data[i].PayStatus,
			InputPrice:       query_data[i].InputPrice,
			SinglePrice:      query_data[i].SinglePrice,
			Paidmoney:        query_data[i].Paidmoney,
			OrderGoodsStatus: query_data[i].OrderGoodsStatus,
		}
		if userName == "" {
			userName = query_data[i].UserName
		}
	}
	return
}

//买家账单列表
type BillListResult struct {
	UserName         string  `json:"user_name"`          // 客户名称
	UserID           uint32  `json:"user_id"`            // 用户id
	OrderID          string  `json:"order_id"`           // 订单id
	Cost             float64 `json:"cost"`               // 邮费成本
	Offer            float64 `json:"offer"`              // 实收邮费
	GoodsCount       uint32  `json:"goods_count"`        // 买家商品数目
	OrderGoodsID     uint32  `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32  `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsName        string  `json:"goods_name"`         // 商品名称
	Specifications   string  `json:"specifications"`     // 商品规格
	PayStatus        uint32  `json:"pay_status"`         // 付款状态 0未付 1已付
	InputPrice       float64 `json:"input_price"`        // 进价
	SinglePrice      float64 `json:"single_price"`       // 售价
	Paidmoney        float64 `json:"paidmoney"`          // 定金
	UfPayStatus      uint32  `json:"uf_pay_status"`      // 邮费付款状态 0未付 1已付
	LogisticsCom     string  `json:"logistics_com"`      // 快递编号
	LogisticsCompany string  `json:"logistics_company"`  // 快递公司名称
}

type OrderBillListInfo struct {
	OrderID          string          `json:"order_id"`          // 订单id
	Cost             float64         `json:"cost"`              // 邮费成本
	Offer            float64         `json:"offer"`             // 实收邮费
	UfPayStatus      uint32          `json:"uf_pay_status"`     // 邮费付款状态 0未付 1已付
	LogisticsCom     string          `json:"logistics_com"`     // 快递编号
	LogisticsCompany string          `json:"logistics_company"` // 快递公司名称
	BillList         []*BillListInfo `json:"bill_list"`         // 买家账单列表
}
type BillListInfo struct {
	GoodsCount       uint32  `json:"goods_count"`        // 买家商品数目
	OrderGoodsID     uint32  `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32  `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsName        string  `json:"goods_name"`         // 商品名称
	Specifications   string  `json:"specifications"`     // 商品规格
	PayStatus        uint32  `json:"pay_status"`         // 付款状态 0未付 1已付
	InputPrice       float64 `json:"input_price"`        // 进价
	SinglePrice      float64 `json:"single_price"`       // 售价
	Paidmoney        float64 `json:"paidmoney"`          // 定金

}

//买家分类请求账单
func OrderBill(userID uint32, shopID uint64) (res []*OrderBillListInfo, userName string, UserID uint32, err error) {
	//获取指定客户的账单
	//
	var sql_buf bytes.Buffer
	sql := "select a.id as order_goods_id,a.goods_name,a.specifications,a.pay_status,a.paidmoney,a.quantity as goods_count,a.order_goods_status,a.input_price,a.single_price,b.order_id,b.shop_id,c.customer_id as user_id,c.cr_nick as user_name,d.cost,d.offer,d.uf_pay_status,d.logistics_com,d.logistics_company from orders_goods as a left join orders as b on a.order_id=b.order_id left join h_customer as c on c.customer_id=b.customer_id  LEFT JOIN orders_logistics AS d ON d.order_id = a.order_id and d.id=a.logistics_id  where b.shop_id=%d and c.customer_id=%d and a.order_goods_status between %d and %d and a.status=0 and b.status=1 and b.order_id<>'' ORDER BY a.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, userID, POBUY, POSD))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*BillListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}

	psMap := map[string]int{} //key=订单id value=订单id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].OrderID]++
		if userName == "" {
			userName = query_data[i].UserName
		}
		if UserID != 0 {
			UserID = query_data[i].UserID
		}
	}

	//处理数据
	res = make([]*OrderBillListInfo, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0

	for _, q_value := range query_data {
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.OrderID == q_value.OrderID {
					//重复的订单
					all_value.BillList = append(all_value.BillList, &BillListInfo{
						OrderGoodsID:     q_value.OrderGoodsID,
						GoodsName:        q_value.GoodsName,
						GoodsCount:       q_value.GoodsCount,
						Specifications:   q_value.Specifications,
						PayStatus:        q_value.PayStatus,
						InputPrice:       q_value.InputPrice,
						SinglePrice:      q_value.SinglePrice,
						Paidmoney:        q_value.Paidmoney,
						OrderGoodsStatus: q_value.OrderGoodsStatus,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}

		res[all_index] = &OrderBillListInfo{
			OrderID:          q_value.OrderID,
			Cost:             q_value.Cost,
			Offer:            q_value.Offer,
			UfPayStatus:      q_value.UfPayStatus,
			LogisticsCom:     q_value.LogisticsCom,
			LogisticsCompany: q_value.LogisticsCompany,
		}
		res[all_index].BillList = append(res[all_index].BillList, &BillListInfo{
			OrderGoodsID:     q_value.OrderGoodsID,
			GoodsName:        q_value.GoodsName,
			GoodsCount:       q_value.GoodsCount,
			Specifications:   q_value.Specifications,
			PayStatus:        q_value.PayStatus,
			InputPrice:       q_value.InputPrice,
			SinglePrice:      q_value.SinglePrice,
			Paidmoney:        q_value.Paidmoney,
			OrderGoodsStatus: q_value.OrderGoodsStatus,
		})
		all_index++
	}
	return
}

//订单分类请求账单
func UserBill(OrderID string, shopID uint64) (res []*OrderBillListInfo, userName string, UserID uint32, err error) {
	//获取指定客户的账单
	//
	var sql_buf bytes.Buffer
	sql := "select a.id as order_goods_id, a.goods_name,a.specifications,a.pay_status,a.paidmoney,a.quantity as goods_count,a.order_goods_status,a.input_price,a.single_price,b.order_id,b.shop_id,c.customer_id,c.customer_id as user_id,c.cr_nick as user_name,d.cost,d.offer,d.uf_pay_status,d.logistics_com,d.logistics_company from orders_goods as a left join orders as b on a.order_id=b.order_id left join h_customer as c on c.customer_id=b.customer_id LEFT JOIN orders_logistics AS d ON d.order_id = a.order_id and d.id=a.logistics_id  where b.shop_id=%d and b.order_id='%s' and c.customer_id<>0 and a.order_goods_status between %d and %d and a.status=0 and b.status=1 ORDER BY a.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, OrderID, POBUY, POSD))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*BillListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}

	psMap := map[string]int{} //key=订单id value=订单id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].OrderID]++
		if userName == "" {
			userName = query_data[i].UserName
		}
		if UserID == 0 {
			UserID = query_data[i].UserID
		}
	}

	//处理数据
	res = make([]*OrderBillListInfo, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0

	for _, q_value := range query_data {
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.OrderID == q_value.OrderID {
					//重复的订单
					all_value.BillList = append(all_value.BillList, &BillListInfo{
						OrderGoodsID:     q_value.OrderGoodsID,
						GoodsName:        q_value.GoodsName,
						GoodsCount:       q_value.GoodsCount,
						Specifications:   q_value.Specifications,
						PayStatus:        q_value.PayStatus,
						InputPrice:       q_value.InputPrice,
						SinglePrice:      q_value.SinglePrice,
						Paidmoney:        q_value.Paidmoney,
						OrderGoodsStatus: q_value.OrderGoodsStatus,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}

		res[all_index] = &OrderBillListInfo{
			OrderID:          q_value.OrderID,
			Cost:             q_value.Cost,
			Offer:            q_value.Offer,
			UfPayStatus:      q_value.UfPayStatus,
			LogisticsCom:     q_value.LogisticsCom,
			LogisticsCompany: q_value.LogisticsCompany,
		}
		res[all_index].BillList = append(res[all_index].BillList, &BillListInfo{
			OrderGoodsID:     q_value.OrderGoodsID,
			GoodsName:        q_value.GoodsName,
			GoodsCount:       q_value.GoodsCount,
			Specifications:   q_value.Specifications,
			PayStatus:        q_value.PayStatus,
			InputPrice:       q_value.InputPrice,
			SinglePrice:      q_value.SinglePrice,
			Paidmoney:        q_value.Paidmoney,
			OrderGoodsStatus: q_value.OrderGoodsStatus,
		})
		all_index++
	}
	return
}

//买家快递包裹信息列表
type PayRecivceInfo struct {
	OrderID          string `gorm:"column:order_id;type:varchar;" json:"order_id"`                   // 订单编号
	ReceiverName     string `gorm:"column:receiver_name;type:varchar;" json:"receiver_name"`         // 收货人
	ReceiverIphone   string `gorm:"column:receiver_iphone;type:varchar;" json:"receiver_iphone"`     // 收货联系方式
	ReceiverProvince string `gorm:"column:receiver_province;type:varchar;" json:"receiver_province"` // 省
	ReceiverCity     string `gorm:"column:receiver_city;type:varchar;" json:"receiver_city"`         // 市
	ReceiverDistrict string `gorm:"column:receiver_district;type:varchar;" json:"receiver_district"` // 区/县
	ReceiverAddress  string `gorm:"column:receiver_address;type:varchar;" json:"receiver_address"`   // 详细地址
}

func GetPayRecivceInfo(userID uint32, shopID uint64) (res []*PayRecivceInfo, err error) {
	var sql_buf bytes.Buffer
	sql := "SELECT a.order_id,a.receiver_name,a.receiver_iphone,a.receiver_province,a.receiver_city,a.receiver_district,a.receiver_address,a.created_at FROM `orders_logistics` as a LEFT JOIN orders as b on a.order_id=b.order_id  LEFT JOIN orders_goods as c on c.order_id=a.order_id and b.logistics_id=a.id  where b.shop_id=%d and b.customer_id=%d and c.order_goods_status between %d and %d  and c.status=0 and b.status=1 and a.order_id<>'' ORDER BY a.created_at ASC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, userID, POBUY, POSD))
	dbResult := dbGorm.Raw(sql_buf.String())
	res = make([]*PayRecivceInfo, 0)
	if err = dbResult.Scan(&res).Error; err != nil {
		return
	}

	return
}

//修改清单单个参数信息请求
type ModSValue struct {
	ParamType uint32 `json:"param_type"` // 参数类型 1 数量 2 备注 3 已付全款 4 进单价 5 售单价 6 完成 7 定金 8 删除
	Value     string `json:"value"`      // 参数值 其中（0 未付 1已付）
}

//参数类型
const (
	PT_NIL      uint32 = iota // 0 空类型
	PT_NUM                    // 1 数量
	PT_REM                    // 2 备注
	PT_PAYED                  // 3 已付全款
	PT_INPUT                  // 4 进单价
	PT_SINGLE                 // 5 售单价
	PT_COMPLETE               // 6 完成
	PT_PAID                   // 7 定金
	PT_DEL                    // 8 删除
)

//筛选字段名
func ScreenField(paramType uint32) func(*gorm.DB, uint32, []uint32, uint32, string) (string, error) {
	switch paramType {
	case PT_NUM:
		return HandlePriceOrQuantityEvent
	case PT_REM:
		return HandleRemarkEvent
	case PT_PAYED:
		return HandlePreorderPayEvent //只用于预购清单编辑付款状态使用
	case PT_INPUT:
		return HandlePriceOrQuantityEvent
	case PT_SINGLE:
		return HandlePriceOrQuantityEvent
	case PT_COMPLETE:
		return HandleCompleteEvent
	case PT_PAID:
		return HandlePaidmoneyEvent
	case PT_DEL:
		return HandleDeleteEvent
	}
	return nil
}

//备注编辑处理
func HandleRemarkEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	tb_og := tx.Table("orders_goods")
	tb_og = tb_og.Where("id in (?) and status=0  and order_goods_status<>? ", orderGoodsID, POSC).Updates(map[string]interface{}{
		"remark":     value,
		"updated_at": time.Now().Format(timeFormat),
	})
	//更新操作
	if err = tb_og.Error; err != nil {

		return "", err
	}
	if tb_og.RowsAffected == 0 {
		return "备注更新失败", nil
	}
	return
}

//预购清单付款编辑处理
func HandlePreorderPayEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	tb_og := tx.Table("orders_goods")
	tb_og = tb_og.Where("id in (?) and status=0 and order_goods_status<>? ", orderGoodsID, POSC)
	_og_data_Arr := make([]entity.OrdersGoods, 0)
	if err = tb_og.Select("distinct(order_id) as order_id").Find(&_og_data_Arr).Error; err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return "该数据不存在，请重试", nil
		}
		return "", err
	}
	_payStatus := gconv.Uint32(value)
	_payTime := time.Now().Format(timeFormat)
	var sql_buf bytes.Buffer
	sql := " update orders_goods set pay_status=%d,pay_time='%s',updated_at='%s' where id in (%s) and status=0 and order_goods_status<>%d "
	str := gconv.String(orderGoodsID)
	str = str[1 : len(str)-1]
	zaplog.Info(str)
	sql_buf.WriteString(fmt.Sprintf(sql, _payStatus, _payTime, time.Now().Format(timeFormat), str, POSC))
	tb_result := tx.Exec(sql_buf.String())

	//更新操作
	if err = tb_result.Error; err != nil {
		return "", err
	}
	if tb_result.RowsAffected == 0 {
		return "付款更新失败", nil
	}
	return
}

//处理单个已付状态判断是否大订单为确定状态
func HandleComfirmStatus(tx *gorm.DB, OrderID string) (orderInfo *ModelOrderResp, msg string, err error) {

	//确认是否该订单所有商品都已确认付款，如果是，那么更新订单表的订单确认状态，反之不更新
	_og_data := entity.OrdersGoods{}
	//是否存在未付订单商品
	if err = tx.Table("orders_goods").Where("order_id=? and status=0 and pay_status=0", OrderID).First(&_og_data).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return nil, "", err
	}
	err = nil
	if _og_data.ID > 0 {
		return nil, "", nil
	}
	//是否存在未付订单邮费
	_ol_data := entity.OrdersLogistics{}
	if err = tx.Table("orders_logistics").Where("order_id=? and uf_pay_status=0 and is_default=1", OrderID).First(&_ol_data).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return nil, "", err
	}
	err = nil
	if _ol_data.ID > 0 {
		return nil, "", nil
	}

	o_data := entity.Orders{}
	tb_o := tx.Table("orders").Where("order_id=? and status=1 and order_status=?", OrderID, OSTBC).First(&o_data)
	if err = tb_o.Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return nil, "", err
	}
	err = nil
	if o_data.ID == 0 {
		if err = tx.Table("orders").Where("order_id=? and status=1", OrderID).Update("ispay", 1).Error; err != nil {
			return
		}
		//已是确认状态
		return nil, "", nil
	}

	//待确认更新为确认状态
	_pData := &OrderComfirmParam{
		UserID:  o_data.UserID,
		ShopID:  o_data.ShopID,
		OrderId: o_data.OrderID,
	}
	orderInfo = &ModelOrderResp{}
	if orderInfo, msg, err = ModelComfirmOrder(_pData); err != nil || msg != "" || orderInfo == nil {
		return nil, msg, err
	}
	return
}

//付款状态编辑处理（发货付款界面）
//oSType 操作类型 0表示单个 1表示批量
//如果时批量操作，那么就是包含订单商品和邮费支付状态全部选中
func HandlePayEvent(tx *gorm.DB, orderGoodsID []uint32, oSType uint32, value string) (orderInfo []*ModelOrderResp, msg string, err error) {
	tb_og := tx.Table("orders_goods")
	tb_og = tb_og.Where("id in (?) and status=0  and order_goods_status<>?", orderGoodsID, POSC)
	_og_data_Arr := make([]entity.OrdersGoods, 0)
	if err = tb_og.Select("distinct(order_id) as order_id").Find(&_og_data_Arr).Error; err != nil {
		return nil, "", err
	}
	_payStatus := gconv.Uint32(value)
	_payTime := time.Now().Format(timeFormat)
	var sql_buf bytes.Buffer
	sql := " update orders_goods set pay_status=%d,pay_time='%s',updated_at='%s' where id in (%s) and status=0 and order_goods_status<>%d "
	str := gconv.String(orderGoodsID)
	str = str[1 : len(str)-1]
	zaplog.Info(str)
	sql_buf.WriteString(fmt.Sprintf(sql, _payStatus, _payTime, time.Now().Format(timeFormat), str, POSC))
	tb_result := tx.Exec(sql_buf.String())

	//更新操作（订单商品）
	if err = tb_result.Error; err != nil {
		return nil, "", err
	}
	if tb_result.RowsAffected == 0 {
		return nil, "费用更新失败", nil
	}
	_orderID_Arr := make([]string, len(_og_data_Arr))
	for k, data := range _og_data_Arr {
		_orderID_Arr[k] = data.OrderID
	}
	//更新（邮费）【超过1个的选中，默认为一键全选操作】
	if len(orderGoodsID) > 0 && oSType == 1 {
		// 	logistics_up["uf_pay_status"] = req.UfPayStatus
		if err = tx.Table("orders_logistics").Where("order_id in(?) and is_default=1", _orderID_Arr).Updates(map[string]interface{}{
			"uf_pay_status": _payStatus,
			"updated_at":    time.Now().Format(timeFormat),
		}).Error; err != nil {
			return nil, "", err
		}
	}
	//修改为已付时
	if gconv.Int(value) == 1 {
		orderInfo = make([]*ModelOrderResp, len(_og_data_Arr))
		for j, OrderID := range _orderID_Arr {
			orderInfo[j] = &ModelOrderResp{}
			if orderInfo[j], msg, err = HandleComfirmStatus(tx, OrderID); err != nil || msg != "" {
				return
			}

		}
		return orderInfo, "", nil
	} else {
		//未付
		for _, OrderID := range _orderID_Arr {
			if err = tx.Table("orders").Where("order_id=? and status=1", OrderID).Update("ispay", 0).Error; err != nil {
				return
			}
		}
	}
	return
}

//处理商品订单价格变动事件
func HandlePriceChangeResult(tx *gorm.DB, orderID string) (err error) {
	//先重新计算该订单下所有订单商品的总价
	type TempOrdersTotalValue struct {
		Price   float64 `json:"price"`   // 总售价
		Inprice float64 `json:"inprice"` // 总进价价
	}
	tb_total_Price := TempOrdersTotalValue{}
	//订单商品价格
	tb_og := tx.Table("orders_goods").Where("order_id=? and status=0 and order_goods_status<>?", orderID, POSC).Select("SUM(total_price) AS price,SUM(total_input_price) AS inprice")
	if err = tb_og.First(&tb_total_Price).Error; err != nil {
		return err
	}

	//邮费
	_logistics := entity.OrdersLogistics{}
	tb_logis := tx.Table("orders_logistics").Order("created_at asc").Where("order_id=? and is_default=1", orderID).Select("cost,offer")
	if err = tb_logis.First(&_logistics).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return err
	}
	err = nil

	//订单表的价格也得变化
	tb_o := tx.Table("orders")
	tb_o = tb_o.Where("order_id=? and status=1", orderID)
	_o_data := entity.Orders{}
	if err = tb_o.First(&_o_data).Error; err != nil {
		return err
	}

	//更新操作 总售价和总利润
	_total_price := AddFloat64(tb_total_Price.Price, _logistics.Offer)
	_total_input_price := AddFloat64(tb_total_Price.Inprice, _logistics.Cost.Float64)
	_profit := SubtractFloat64(_total_price, _total_input_price)
	if err = tb_o.Where("order_id=?", orderID).Updates(map[string]interface{}{
		"price":      _total_price,
		"profit":     _profit,
		"updated_at": time.Now().Format(timeFormat),
	}).Error; err != nil {
		return err
	}
	return
}

//价格和数量编辑处理（数量和售价只有未付状态才能修改）
func HandlePriceOrQuantityEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	tb_og := tx.Table("orders_goods")
	str := gconv.String(orderGoodsID) //订单商品id数组
	str = str[1 : len(str)-1]
	zaplog.Info(str)
	var tb_result *gorm.DB
	var sql_buf bytes.Buffer
	switch paramType {
	case 1: //数量
		_uantity := gconv.Int32(value)
		//更新操作
		sql := " update orders_goods set quantity=%d,total_input_price=(input_price*%d),total_price=(single_price*%d),updated_at='%s' where id in (%s) and status=0 and pay_status=0 and order_goods_status<>%d"

		sql_buf.WriteString(fmt.Sprintf(sql, _uantity, _uantity, _uantity, time.Now().Format(timeFormat), str, POSC))
		tb_result = tx.Exec(sql_buf.String())

		if err = tb_result.Error; err != nil {
			return "", err
		}
		if tb_result.RowsAffected == 0 {
			return "已付订单无法修改数量", nil
		}
	case 4: //进价
		_inputPrice := gconv.Float64(value)
		sql := " update orders_goods set input_price=%20.2f,total_input_price=(quantity*%20.2f),updated_at='%s'   where id in (%s) and status=0 and order_goods_status<>%d"
		sql_buf.WriteString(fmt.Sprintf(sql, _inputPrice, _inputPrice, time.Now().Format(timeFormat), str, POSC))
		tb_result = tx.Exec(sql_buf.String())
		if err = tb_result.Error; err != nil {
			return "", err
		}
	case 5: //售价
		_singlePrice := gconv.Float64(value)
		sql := " update orders_goods set single_price=%20.2f,total_price=(quantity*%20.2f),updated_at='%s' where id in (%s) and status=0 and pay_status=0 and order_goods_status<>%d"

		sql_buf.WriteString(fmt.Sprintf(sql, _singlePrice, _singlePrice, time.Now().Format(timeFormat), str, POSC))
		tb_result = tx.Exec(sql_buf.String())
		if err = tb_result.Error; err != nil {
			return "", err
		}
		if tb_result.RowsAffected == 0 {
			return "已付订单无法修改售价", nil
		}
	default:
		return "非法类型值", nil
	}
	if kind == 1 {
		_og_data_Arr := make([]entity.OrdersGoods, 0)
		if err = tb_og.Select("distinct(order_id) as order_id").Where("id in(?) and status=0 and order_goods_status<>?", orderGoodsID, POSC).Find(&_og_data_Arr).Error; err != nil {
			if gorm.IsRecordNotFoundError(err) {
				return "该数据不存在，请重试", nil
			}
			return "", err
		}
		for _, _og_data := range _og_data_Arr {
			if err = HandlePriceChangeResult(tx, _og_data.OrderID); err != nil {
				return
			}
		}
	}

	return
}

//完成编辑处理
func HandleCompleteEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	_orderGoodsStatus := uint32(POSC)
	tb_og := tx.Table("orders_goods")
	tb_og = tb_og.Where("id in (?) and status=0  and order_goods_status<>? ", orderGoodsID, _orderGoodsStatus)
	_og_data_Arr := make([]entity.OrdersGoods, 0)
	if err = tb_og.Select("distinct(order_id) as order_id").Find(&_og_data_Arr).Error; err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return "该数据不存在，请重试", nil
		}
		return "", err
	}
	orderprofit := make([]entity.OrdersGoods, 0)
	if err = tb_og.Find(&orderprofit).Error; err != nil {
		return "", err
	}
	for _, a := range orderprofit {
		if err = InsertData(&OrderRevenueStatistics{
			OrderId:         a.OrderID,
			TotalInputPrice: gconv.Float64(a.TotalInputPrice),
			TotalPrice:      a.TotalPrice,
		}); err != nil {
			return "", err
		}
	}

	//更新操作
	tb_result := tb_og.Updates(map[string]interface{}{"order_goods_status": _orderGoodsStatus, "updated_at": time.Now().Format(timeFormat)})
	if err = tb_result.Error; err != nil {
		return "", err
	}
	if tb_result.RowsAffected == 0 {
		return "完成编辑失败", nil
	}
	if kind == 1 {
		for _, _og_data := range _og_data_Arr {
			//判断是否所有订单商品状态为完成，则更新订单的状态为完成
			_orderID := _og_data.OrderID
			_og_data := entity.OrdersGoods{}
			if err = tx.Table("orders_goods").Where("order_id=? and status=0 and order_goods_status<>?", _orderID, _orderGoodsStatus).First(&_og_data).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
				return "", err
			}

			err = nil
			if _og_data.ID != 0 {
				//还有未完成商品订单
				return
			}
			_pData := &OrderModifyIncompleteParam{
				OrderId:     _orderID,
				OrderStatus: OSC,
			}
			if err = ModelModifyStatusOrder(tx, _pData); err != nil {
				return "", err
			}
		}
	}
	return
}

//定金编辑处理
func HandlePaidmoneyEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	tb_og := tx.Table("orders_goods")
	tb_og = tb_og.Where("id in (?) and status=0 and pay_status=0  and order_goods_status<>? ", orderGoodsID, POSC)
	tb_og = tb_og.Updates(map[string]interface{}{"paidmoney": gconv.Float64(value), "updated_at": time.Now().Format(timeFormat)})
	//更新操作
	if err = tb_og.Error; err != nil {
		return "", err
	}
	if tb_og.RowsAffected == 0 {
		return "定金编辑失败", nil
	}
	return
}

//删除订单处理
func HandleDeleteEvent(tx *gorm.DB, kind uint32, orderGoodsID []uint32, paramType uint32, value string) (msg string, err error) {
	tb_og := tx.Table("orders_goods")
	//更新操作
	tb_result := tb_og.Where("id in (?) and status=0", orderGoodsID).Update("status", -1)
	if err = tb_result.Error; err != nil {
		return "", err
	}
	if tb_result.RowsAffected == 0 {
		return "删除失败", nil
	}
	_og_data_Arr := make([]entity.OrdersGoods, 0)
	if kind == 1 {
		if err = tb_og.Select("distinct(order_id) as order_id").Where("id in(?)", orderGoodsID).Find(&_og_data_Arr).Error; err != nil {
			if gorm.IsRecordNotFoundError(err) {
				return "该数据不存在，请重试", nil
			}
			return "", err
		}

		for _, _og_data := range _og_data_Arr {
			orderID := _og_data.OrderID

			//如果订单所属下的全部商品都被删除，订单也会修改为删除状态
			_og_data := entity.OrdersGoods{}
			if err = tb_og.Where("order_id=? and status=0", orderID).First(&_og_data).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
				return "", err
			}
			err = nil
			if _og_data.ID > 0 {
				if err = HandlePriceChangeResult(tx, orderID); err != nil {
					return
				}
				continue
			}
			//全部订单商品删除
			//更新为删除
			if err = tx.Table("orders").Where("order_id=? and status=1", orderID).Update("status", 0).Error; err != nil {
				return "", err
			}
		}
	} else {

		//预购清单删除
		if err = tb_og.Select("distinct(hp_id) as hp_id").Where("id in(?)", orderGoodsID).Find(&_og_data_Arr).Error; err != nil || len(_og_data_Arr) == 0 {
			if gorm.IsRecordNotFoundError(err) {
				return "该数据不存在，请重试", nil
			}
			return "", errors.New("查看订单商品信息不存在")
		}

		for _, _og_data := range _og_data_Arr {
			hpID := _og_data.HpID
			//更新为删除
			_hp_result := tx.Table("h_preorder").Where("id=?", hpID).Delete(&entity.HPreorder{})
			if err = _hp_result.Error; err != nil {
				return "", err
			}
			if _hp_result.RowsAffected == 0 {
				return "删除失败", nil
			}
		}
	}

	return
}

//修改单个商品信息（付款状态【商品付款】不包括邮费付款）
func ModSinglePayOs(req *ModSValue, kind uint32, orderGoodsID uint32, shopId uint64) (orderInfo *ModelOrderResp, msg string, err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		orderInfoArr := make([]*ModelOrderResp, 0)
		if orderInfoArr, msg, err = HandlePayEvent(tx, []uint32{orderGoodsID}, 0, req.Value); err != nil || msg != "" {
			isErr = true
			return
		}
		if len(orderInfoArr) > 0 {
			orderInfo = orderInfoArr[0]
		}
	}
	return
}

//修改单个商品信息
func ModSingleParam(req *ModSValue, kind uint32, orderGoodsID uint32, shopId uint64) (msg string, err error) {
	//筛选
	HandleFunc := ScreenField(req.ParamType)
	if HandleFunc == nil {
		return "参数类型不合法", nil
	}
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		if msg, err = HandleFunc(tx, kind, []uint32{orderGoodsID}, req.ParamType, req.Value); err != nil || msg != "" {
			isErr = true
			return
		}
	}
	return
}

//获取批量商品信息
type OrdersGoodsResult struct {
	OrderID          string `json:"order_id"`           // 订单编号
	OrderGoodsID     uint32 `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32 `json:"order_goods_status"` // 订单商品状态
	PayStatus        uint32 `json:"pay_status"`         // 订单商品付款状态
}

//获取批量商品信息
//BatchID查询id,Object对象类型(0商品分类 1买家分类),shopId店铺ID
func GetPreorderBatchInfo(BatchID string, Object uint32, shopId uint64) (res []*OrdersGoodsResult, msg string, err error) {
	//先获取该分类对象下所有的商品订单id
	var sql_buf bytes.Buffer
	sql := "select a.order_id, a.id as order_goods_id ,a.order_goods_status,a.pay_status from orders_goods as a left join h_preorder as b on a.hp_id=b.id left join h_customer as c on c.customer_id=b.customer_id and c.shop_id=b.shop_id left join  h_goods as d on a.hgs_id=d.hgs_id where a.`status`=0 and b.deleted_at is null and b.id<>0 and c.customer_id<>0 and b.shop_id=%d  and a.order_goods_status<>%d "
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, POSC))
	//对象类型 0商品分类 1买家分类
	if Object == 0 {
		sql = " and d.hgs_id = '%s' "
	} else if Object == 1 {
		sql = " and c.customer_id = '%s' "
	} else {
		msg = "查看类型无效"
		return
	}
	sql_buf.WriteString(fmt.Sprintf(sql, BatchID))
	dbResult := dbGorm.Raw(sql_buf.String())
	res = make([]*OrdersGoodsResult, 0)
	if err = dbResult.Scan(&res).Error; err != nil {
		return
	}
	return
}

//获取批量商品信息(只针对发货付款列表)
//BatchID查询id,Object对象类型(0商品分类 1买家分类 2订单分类),shopId店铺ID
func GetBatchInfo(BatchID string, Object uint32, shopId uint64) (res []*OrdersGoodsResult, msg string, err error) {
	//先获取该分类对象下所有的商品订单id
	var sql_buf bytes.Buffer
	sql := "select a.order_id, a.id as order_goods_id ,a.order_goods_status,a.pay_status from orders_goods as a left join orders as b on a.order_id=b.order_id left join h_customer  as c on c.customer_id=b.customer_id and c.shop_id=b.shop_id left join  h_goods as d on a.hgs_id=d.hgs_id where a.`status`=0 and b.status=1 and b.order_id <>''  and c.customer_id<>0 and b.shop_id=%d and a.order_goods_status<>%d "
	sql_buf.WriteString(fmt.Sprintf(sql, shopId, POSC))
	//对象类型 0商品分类 1买家分类 2订单分类
	if Object == 0 {
		sql = " and d.hgs_id = '%s' "
	} else if Object == 1 {
		sql = " and c.customer_id = '%s' "
	} else if Object == 2 {
		sql = " and a.order_id = '%s' "
	} else {
		msg = "查看类型无效"
		return
	}
	sql_buf.WriteString(fmt.Sprintf(sql, BatchID))
	dbResult := dbGorm.Raw(sql_buf.String())
	res = make([]*OrdersGoodsResult, 0)
	if err = dbResult.Scan(&res).Error; err != nil {
		return
	}
	return
}

//修改批量商品信息（付款状态【商品付款以及邮费】）
func ModBatchPayOs(req *ModSValue, kind uint32, BatchID string, Object uint32, shopId uint64) (orderInfo []*ModelOrderResp, msg string, err error) {
	//先获取该分类对象下所有的商品订单id
	res := make([]*OrdersGoodsResult, 0)
	res, msg, err = GetBatchInfo(BatchID, Object, shopId)
	if err != nil || msg != "" {
		return
	}
	orderInfo = make([]*ModelOrderResp, len(res))
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		_orderGoodsID := make([]uint32, len(res))
		for k, value := range res {
			_orderGoodsID[k] = value.OrderGoodsID
		}
		if orderInfo, msg, err = HandlePayEvent(tx, _orderGoodsID, 1, req.Value); err != nil || msg != "" {
			isErr = true
			return
		}
	}
	return
}

//批量修改商品信息
func ModBatchInfo(req *ModSValue, kind uint32, BatchID string, Object uint32, shopId uint64) (msg string, err error) {
	//筛选
	HandleFunc := ScreenField(req.ParamType)
	if HandleFunc == nil {
		return "参数类型不合法", nil
	}
	//先获取该分类对象下所有的商品订单id
	res := make([]*OrdersGoodsResult, 0)
	if kind == 0 {
		res, msg, err = GetPreorderBatchInfo(BatchID, Object, shopId)
	} else {
		res, msg, err = GetBatchInfo(BatchID, Object, shopId)
	}

	if err != nil || msg != "" {
		return
	}
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		_orderGoodsID := make([]uint32, len(res))
		for k, value := range res {
			_orderGoodsID[k] = value.OrderGoodsID
		}

		if msg, err = HandleFunc(tx, kind, _orderGoodsID, req.ParamType, req.Value); err != nil || msg != "" {
			isErr = true
			return
		}
	}
	return
}

//编辑邮费数据
type PostageInfo struct {
	LogisticsCompany *string  `json:"logistics_company"` // 快递公司名称
	LogisticsCom     *string  `json:"logistics_com"`     // 快递编号
	Cost             *float64 `json:"cost"`              // 邮费成本值
	Offer            *float64 `json:"offer"`             // 实收邮费
	UfPayStatus      *uint32  `json:"uf_pay_status"`     // 邮费付款状态 0未付 1已付
}

//数据库查询获取订单邮费数据
type GetDBResult struct {
	Price       float64    `gorm:"column:price;type:decimal;" json:"price"`              // 总金额
	Profit      float64    `gorm:"column:profit;type:decimal;" json:"profit"`            // 订单利润
	Cost        null.Float `gorm:"column:cost;type:decimal;" json:"cost"`                // 运费成本
	Offer       float64    `gorm:"column:offer;type:decimal;" json:"offer"`              // 运费报价
	UfPayStatus null.Int   `gorm:"column:uf_pay_status;type:uint;" json:"uf_pay_status"` // 邮费付款状态 （0未付 1已付）
}

//编辑邮费数据
func EditPostageInfo(req *PostageInfo, orderID string, shopID uint64) (orderInfo *ModelOrderResp, msg string, err error) {
	//修改订单表内的数据
	//修改利润
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		orderInfo = &ModelOrderResp{}

		tb := tx.Table("orders as a")
		tb = tb.Select("b.cost,b.offer,b.uf_pay_status,a.price,a.profit").Order("b.created_at asc").Where("a.shop_id=? and a.order_id=? and a.status=1 and a.order_status>=? and a.order_status<? and b.is_default=1", shopID, orderID, OSTBC, OSC).Joins("right join orders_logistics as b on a.order_id = b.order_id")

		//先获取表中数据
		_order := GetDBResult{}
		if err = tb.First(&_order).Error; err != nil {
			isErr = true
			if gorm.IsRecordNotFoundError(err) {
				return nil, "该订单不存在，请重试或联系客服", nil
			}
			return
		}

		orders_up := map[string]interface{}{}
		logistics_up := map[string]interface{}{}
		Curprofit := _order.Profit * 100
		if req.Cost != nil {
			logistics_up["cost"] = req.Cost
			Curprofit -= ((*req.Cost * 100) - (_order.Cost.Float64 * 100))
			Curprofit /= 100
			orders_up["profit"] = Curprofit
		}
		if req.Offer != nil {
			logistics_up["offer"] = req.Offer
			_difference := ((*req.Offer * 100) - (_order.Offer * 100))
			orders_up["price"] = ((_order.Price * 100) + _difference) / 100
			orders_up["profit"] = (Curprofit + _difference) / 100
		}
		if req.UfPayStatus != nil {
			logistics_up["uf_pay_status"] = req.UfPayStatus
		}
		if req.LogisticsCom != nil {
			logistics_up["logistics_com"] = req.LogisticsCom
		}
		if req.LogisticsCompany != nil {
			logistics_up["logistics_company"] = req.LogisticsCompany
		}

		if err = tx.Table("orders_logistics").Where("order_id=? and is_default=1", orderID).Updates(logistics_up).Error; err != nil {
			isErr = true
			return
		}

		if req.UfPayStatus != nil {
			if *req.UfPayStatus == 1 {
				if orderInfo, msg, err = HandleComfirmStatus(tx, orderID); err != nil || msg != "" {
					isErr = true
					return
				}
			} else {
				if err = tx.Table("orders").Where("order_id=? and status=1", orderID).Update("ispay", 0).Error; err != nil {
					isErr = true
					return
				}
			}

		}

		//必须放在处理确认状态方法之后，因为事务会锁住订单表，导致不能操作订单表其他修改
		if req.Offer != nil || req.Cost != nil {
			if err = tx.Table("orders").Where("shop_id=? and order_id=? and status=1 and order_status>=? and order_status<?", shopID, orderID, OSTBC, OSC).Updates(orders_up).Error; err != nil {
				isErr = true
				return
			}
		}

	}
	return
}

//订单数据详情查看
type OrderRecordDetailResult struct {
	GoodsName        string       `json:"goods_name"`         // 商品名称
	Specifications   string       `json:"specifications"`     // 商品规格
	UserId           uint32       `json:"user_id"`            // 客户id
	UserName         string       `json:"user_name"`          // 买家名称
	OrderID          string       `json:"order_id"`           // 订单编号
	OrderGoodsID     uint32       `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32       `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsCount       uint32       `json:"goods_count"`        // 买家商品数目
	CreateTime       *entity.Time `json:"create_time"`        // 下单时间
	BuyTime          *entity.Time `json:"buy_time"`           // 买到时间
	Remark           string       `json:"remark"`             // 备注
	PayStatus        uint32       `json:"pay_status"`         // 付款状态 (0 未付 1已付 )
	Inprice          float64      `json:"inprice"`            // 进价
	Saleprice        float64      `json:"saleprice"`          // 售价
	Paidmoney        float64      `json:"paidmoney"`          // 定金
	LogisticsStatus  uint32       `json:"logistics_status"`   // 0发送中1收货中2完成-1异常
}
type OrderRecordDetailInfo struct {
	GoodsName        string       `json:"goods_name"`         // 商品名称
	Specifications   string       `json:"specifications"`     // 商品规格
	UserId           uint32       `json:"user_id"`            // 客户id
	UserName         string       `json:"user_name"`          // 买家名称
	OrderID          string       `json:"order_id"`           // 订单编号
	OrderGoodsID     uint32       `json:"order_goods_id"`     // 订单商品编号
	OrderGoodsStatus uint32       `json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	GoodsCount       uint32       `json:"goods_count"`        // 买家商品数目
	CreateTime       *entity.Time `json:"create_time"`        // 下单时间
	BuyTime          *entity.Time `json:"buy_time"`           // 买到时间
	Remark           string       `json:"remark"`             // 备注
	PayStatus        uint32       `json:"pay_status"`         // 付款状态 (0 未付 1已付 )
	Inprice          float64      `json:"inprice"`            // 进价
	Saleprice        float64      `json:"saleprice"`          // 售价
	Paidmoney        float64      `json:"paidmoney"`          // 定金
	LogisticsStatus  uint32       `json:"logistics_status"`   // 0未发货1已发货
}

func GetOrderRecordDetail(OrderGoodsID uint32, kind uint32, shopId uint64) (res *OrderRecordDetailInfo, msg string, err error) {
	tb := dbGorm.Table("orders_goods as a")
	sql := "a.goods_name,a.specifications,a.order_id,a.id as order_goods_id,c.customer_id as user_id,a.order_goods_status,a.quantity as goods_count,a.created_at as create_time,a.buy_time,a.remark,a.pay_status,a.input_price as inprice,a.single_price as saleprice,a.paidmoney,d.status as logistics_status"
	if kind == 0 {
		sql += ",c.cr_nick as user_name "
		tb = tb.Select(sql)
		tb = tb.Joins("left join h_preorder as b on a.hp_id=b.id and b.deleted_at is null")
	} else {
		sql += ",b.customer_name as user_name "
		tb = tb.Select(sql)
		tb = tb.Joins("left join orders as b on a.order_id=b.order_id and b.status=1")
	}

	tb = tb.Joins("left join h_customer as c on c.customer_id=b.customer_id")
	tb = tb.Joins("left join orders_logistics as d on d.order_id=a.order_id and d.id=a.logistics_id")
	tb = tb.Where("a.status=0 and a.id=? and b.shop_id=? ", OrderGoodsID, shopId)
	query_data := OrderRecordDetailResult{}
	if err = tb.First(&query_data).Error; err != nil {
		return
	}
	if gorm.IsRecordNotFoundError(err) {
		msg = "该信息未找到"
	}
	res = &OrderRecordDetailInfo{
		GoodsName:        query_data.GoodsName,
		Specifications:   query_data.Specifications,
		UserId:           query_data.UserId,
		UserName:         query_data.UserName,
		OrderID:          query_data.OrderID,
		OrderGoodsID:     query_data.OrderGoodsID,
		OrderGoodsStatus: query_data.OrderGoodsStatus,
		GoodsCount:       query_data.GoodsCount,
		CreateTime:       query_data.CreateTime,
		BuyTime:          query_data.BuyTime,
		Remark:           query_data.Remark,
		PayStatus:        query_data.PayStatus,
		Inprice:          query_data.Inprice,
		Saleprice:        query_data.Saleprice,
		Paidmoney:        query_data.Paidmoney,
	}
	if query_data.LogisticsStatus > 0 {
		res.LogisticsStatus = 1
	}

	return
}

//查看指定订单商品发货信息结果
type SingleCompleteDeliverListInfo struct {
	LogisticsStatus  uint32        `json:"logistics_status"`  // 0未发货1已发货
	Receiver         *ReceiverInfo `json:"receiver"`          // 收货信息
	Sender           *SenderInfo   `json:"sender"`            // 发货信息
	LogisticsID      uint32        `json:"logistics_id"`      // 快递物流id
	LogisticsNumber  string        `json:"logistics_number"`  // 快递单号
	LogisticsCompany string        `json:"logistics_company"` // 快递公司名称
}

//查看指定订单商品发货信息
func SingleCompleteDeliverInfoUser(OrderGoodsID uint32, shopID uint64) (res *SingleCompleteDeliverListInfo, msg string, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.logistics_id,b.logistics_number,b.logistics_company,b.sender_name,b.sender_iphone,b.sender_province,b.sender_city,b.sender_district,b.sender_address,b.receiver_name,b.receiver_iphone,b.receiver_province,b.receiver_city,b.receiver_district,b.receiver_address,b.status as logistics_status,e.id as express_company_id from orders_goods as a left join orders_logistics as b on b.order_id=a.order_id and b.id=a.logistics_id left join orders  as c on a.order_id=c.order_id left join h_customer as d on d.customer_id=c.customer_id left join system_express_company as e on b.logistics_company=e.express_name where c.shop_id=%d and c.customer_id<>0 and a.status=0 and c.status=1 and a.order_goods_status>=%d and a.id=%d ORDER BY a.ship_time DESC"
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, POSD, OrderGoodsID))
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := CompleteDeliverListResult{}
	if err = dbResult.First(&query_data).Error; err != nil {
		return
	}
	//未发货不展示
	if query_data.LogisticsStatus == 0 {
		return
	}
	query_data.LogisticsStatus = 1 //已发货
	//处理数据
	res = &SingleCompleteDeliverListInfo{
		LogisticsNumber:  query_data.LogisticsNumber,
		LogisticsCompany: query_data.LogisticsCompany,
		LogisticsID:      query_data.LogisticsID,
		Sender: &SenderInfo{
			SenderName:     query_data.SenderName,
			SenderIphone:   query_data.SenderIphone,
			SenderProvince: query_data.SenderProvince,
			SenderCity:     query_data.SenderCity,
			SenderDistrict: query_data.SenderDistrict,
			SenderAddress:  query_data.SenderAddress,
		},
		Receiver: &ReceiverInfo{
			ReceiverName:     query_data.ReceiverName,
			ReceiverIphone:   query_data.ReceiverIphone,
			ReceiverProvince: query_data.ReceiverProvince,
			ReceiverCity:     query_data.ReceiverCity,
			ReceiverDistrict: query_data.ReceiverDistrict,
			ReceiverAddress:  query_data.ReceiverAddress,
		},
	}
	return
}

//发货 需要更新商品库的已售数量和库存数量
type DeliverListResult struct {
	OrderID          string `json:"order_id"`           // 订单编号
	UserName         string `json:"user_name"`          // 买家名称
	UserID           uint32 `json:"user_id"`            // 买家id(客户id)
	ReceiverName     string `json:"receiver_name"`      // 收货人
	ReceiverIphone   string `json:"receiver_iphone"`    // 收货联系方式
	ReceiverProvince string `json:"receiver_province"`  // 省
	ReceiverCity     string `json:"receiver_city"`      // 市
	ReceiverDistrict string `json:"receiver_district"`  // 区/县
	ReceiverAddress  string `json:"receiver_address"`   // 详细地址
	SenderName       string `json:"sender_name"`        // 寄货人
	SenderIphone     string `json:"sender_iphone"`      // 寄货联系方式
	SenderProvince   string `json:"sender_province"`    // 寄货省
	SenderCity       string `json:"sender_city"`        // 寄货市
	SenderDistrict   string `json:"sender_district"`    // 寄货区/县
	SenderAddress    string `json:"sender_address"`     // 寄货详细地址
	GoodsName        string `json:"goods_name"`         // 商品名称
	Specifications   string `json:"specifications"`     // 商品规格
	OrderGoodsID     uint32 `json:"order_goods_id"`     // 订单商品编号
	GoodsCount       uint32 `json:"goods_count"`        // 买家商品数目
	Remark           string `json:"remark"`             // 备注
	LogisticsCom     string `json:"logistics_com"`      // 快递编号
	LogisticsCompany string `json:"logistics_company"`  // 快递公司名称
	ExpressCompanyId uint32 `json:"express_company_id"` // 快递公司ID 0表示人工寄货
}

type ReceiverInfo struct {
	ReceiverName     string `json:"receiver_name"`     // 收货人
	ReceiverIphone   string `json:"receiver_iphone"`   // 收货联系方式
	ReceiverProvince string `json:"receiver_province"` // 省
	ReceiverCity     string `json:"receiver_city"`     // 市
	ReceiverDistrict string `json:"receiver_district"` // 区/县
	ReceiverAddress  string `json:"receiver_address"`  // 详细地址
}
type SenderInfo struct {
	SenderName     string `json:"sender_name"`     // 寄货人
	SenderIphone   string `json:"sender_iphone"`   // 寄货联系方式
	SenderProvince string `json:"sender_province"` // 寄货省
	SenderCity     string `json:"sender_city"`     // 寄货市
	SenderDistrict string `json:"sender_district"` // 寄货区/县
	SenderAddress  string `json:"sender_address"`  // 寄货详细地址
}

//发货地址下的商品信息
type GoodsSubInfo struct {
	GoodsName      string `json:"goods_name"`     // 商品名称
	Specifications string `json:"specifications"` // 商品规格
	OrderGoodsID   uint32 `json:"order_goods_id"` // 订单商品编号
	GoodsCount     uint32 `json:"goods_count"`    // 买家商品数目
	Remark         string `json:"remark"`         // 备注
}
type DeliverListInfo struct {
	OrderID          string          `json:"order_id"`           // 订单编号
	Receiver         *ReceiverInfo   `json:"receiver"`           // 收货信息
	Sender           *SenderInfo     `json:"sender"`             // 发货信息
	GoodsList        []*GoodsSubInfo `json:"goods_list"`         // 订单商品信息
	ExpressCompanyId uint32          `json:"express_company_id"` // 快递公司ID 0表示人工寄货
	LogisticsCom     string          `json:"logistics_com"`      // 快递编号
	LogisticsCompany string          `json:"logistics_company"`  // 快递公司名称
}

func DeliverInfoUser(userID uint32, OrderID string, shopID uint64) (res []*DeliverListInfo, userName string, UserID uint32, msg string, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.order_id,d.cr_nick as user_name,d.customer_id as user_id,a.goods_name,a.order_goods_status,a.id as order_goods_id, a.specifications,a.quantity as goods_count,a.remark,b.logistics_com,b.logistics_company,b.receiver_name,b.receiver_iphone,b.receiver_province,b.receiver_city,b.receiver_district,b.receiver_address,b.sender_name,b.sender_iphone,b.sender_province,b.sender_city,b.sender_district,b.sender_address,e.id as express_company_id  from orders_goods as a left join orders_logistics as b on b.order_id=a.order_id and b.id=a.logistics_id left join orders  as c on a.order_id=c.order_id left join h_customer as d on d.customer_id=c.customer_id left join system_express_company as e on b.logistics_company=e.express_name where c.shop_id=%d and c.customer_id<>0 and a.status=0 and c.status=1 and a.order_goods_status=%d "
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, POBUY))

	if OrderID != "" {
		sql = " and a.order_id='%s' "
		sql_buf.WriteString(fmt.Sprintf(sql, OrderID))
	}
	if userID > 0 {
		sql = " and d.customer_id=%d "
		sql_buf.WriteString(fmt.Sprintf(sql, userID))
	}

	sql_buf.WriteString(" ORDER BY a.created_at ASC")
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*DeliverListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}
	psMap := map[string]int{} //key=订单id value=订单id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].OrderID]++
		if userName == "" {
			userName = query_data[i].UserName
		}
		if UserID == 0 {
			UserID = query_data[i].UserID
		}
	}

	//处理数据
	res = make([]*DeliverListInfo, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0

	for _, q_value := range query_data {
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.OrderID == q_value.OrderID {
					//重复的订单
					all_value.GoodsList = append(all_value.GoodsList, &GoodsSubInfo{
						OrderGoodsID:   q_value.OrderGoodsID,
						GoodsName:      q_value.GoodsName,
						GoodsCount:     q_value.GoodsCount,
						Specifications: q_value.Specifications,
						Remark:         q_value.Remark,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}

		res[all_index] = &DeliverListInfo{
			OrderID:          q_value.OrderID,
			LogisticsCom:     q_value.LogisticsCom,
			LogisticsCompany: q_value.LogisticsCompany,
			ExpressCompanyId: q_value.ExpressCompanyId,
			Sender: &SenderInfo{
				SenderName:     q_value.SenderName,
				SenderIphone:   q_value.SenderIphone,
				SenderProvince: q_value.SenderProvince,
				SenderCity:     q_value.SenderCity,
				SenderDistrict: q_value.SenderDistrict,
				SenderAddress:  q_value.SenderAddress,
			},
			Receiver: &ReceiverInfo{
				ReceiverName:     q_value.ReceiverName,
				ReceiverIphone:   q_value.ReceiverIphone,
				ReceiverProvince: q_value.ReceiverProvince,
				ReceiverCity:     q_value.ReceiverCity,
				ReceiverDistrict: q_value.ReceiverDistrict,
				ReceiverAddress:  q_value.ReceiverAddress,
			},
		}
		res[all_index].GoodsList = append(res[all_index].GoodsList, &GoodsSubInfo{
			OrderGoodsID:   q_value.OrderGoodsID,
			GoodsName:      q_value.GoodsName,
			GoodsCount:     q_value.GoodsCount,
			Specifications: q_value.Specifications,
			Remark:         q_value.Remark,
		})
		all_index++
	}
	return
}

//发货 需要更新商品库的已售数量和库存数量
type CompleteDeliverListResult struct {
	UserName         string        `json:"user_name"`         // 买家名称
	GoodsName        string        `json:"goods_name"`        // 商品名称
	Specifications   string        `json:"specifications"`    // 商品规格
	GoodsCount       uint32        `json:"goods_count"`       // 买家商品数目
	Remark           string        `json:"remark"`            // 备注
	OrderID          string        `json:"order_id"`          // 订单编号
	Receiver         *ReceiverInfo `json:"receiver"`          // 收货信息
	LogisticsID      uint32        `json:"logistics_id"`      // 快递物流id
	LogisticsNumber  string        `json:"logistics_number"`  // 快递单号
	LogisticsCompany string        `json:"logistics_company"` // 快递公司名称
	ReceiverName     string        `json:"receiver_name"`     // 收货人
	ReceiverIphone   string        `json:"receiver_iphone"`   // 收货联系方式
	ReceiverProvince string        `json:"receiver_province"` // 省
	ReceiverCity     string        `json:"receiver_city"`     // 市
	ReceiverDistrict string        `json:"receiver_district"` // 区/县
	ReceiverAddress  string        `json:"receiver_address"`  // 详细地址
	SenderName       string        `json:"sender_name"`       // 寄货人
	SenderIphone     string        `json:"sender_iphone"`     // 寄货联系方式
	SenderProvince   string        `json:"sender_province"`   // 寄货省
	SenderCity       string        `json:"sender_city"`       // 寄货市
	SenderDistrict   string        `json:"sender_district"`   // 寄货区/县
	SenderAddress    string        `json:"sender_address"`    // 寄货详细地址
	LogisticsStatus  uint32        `json:"logistics_status"`  // 0发送中1收货中2完成-1异常
}

//已发货地址下的商品信息
type CompleteGoodsSubInfo struct {
	GoodsName      string `json:"goods_name"`     // 商品名称
	Specifications string `json:"specifications"` // 商品规格
	GoodsCount     uint32 `json:"goods_count"`    // 买家商品数目
	Remark         string `json:"remark"`         // 备注
}
type CompleteDeliverListInfo struct {
	OrderID          string          `json:"order_id"`          // 订单编号
	Receiver         *ReceiverInfo   `json:"receiver"`          // 收货信息
	Sender           *SenderInfo     `json:"sender"`            // 发货信息
	GoodsList        []*GoodsSubInfo `json:"goods_list"`        // 订单商品信息
	LogisticsID      uint32          `json:"logistics_id"`      // 快递物流id
	LogisticsNumber  string          `json:"logistics_number"`  // 快递单号
	LogisticsCompany string          `json:"logistics_company"` // 快递公司名称
}

func CompleteDeliverInfoUser(userID uint32, OrderID string, shopID uint64) (res []*CompleteDeliverListInfo, userName string, msg string, err error) {
	var sql_buf bytes.Buffer
	sql := "select a.logistics_id, a.order_id,d.cr_nick as user_name,a.goods_name,a.order_goods_status,a.specifications,a.quantity as goods_count,a.remark,b.logistics_number,b.logistics_company,b.receiver_name,b.receiver_iphone,b.receiver_province,b.receiver_city,b.receiver_district,b.receiver_address,b.sender_name,b.sender_iphone,b.sender_province,b.sender_city,b.sender_district,b.sender_address,e.id as express_company_id from orders_goods as a left join orders_logistics as b on b.order_id=a.order_id and b.id=a.logistics_id left join orders  as c on a.order_id=c.order_id left join h_customer as d on d.customer_id=c.customer_id left join system_express_company as e on b.logistics_company=e.express_name where c.shop_id=%d and c.customer_id<>0 and a.status=0 and c.status=1 and a.order_goods_status=%d "
	sql_buf.WriteString(fmt.Sprintf(sql, shopID, POSD))

	if OrderID != "" {
		sql = " and a.order_id='%s' "
		sql_buf.WriteString(fmt.Sprintf(sql, OrderID))
	}
	if userID > 0 {
		sql = " and d.customer_id=%d "
		sql_buf.WriteString(fmt.Sprintf(sql, userID))
	}

	sql_buf.WriteString(" ORDER BY a.ship_time DESC")
	dbResult := dbGorm.Raw(sql_buf.String())
	query_data := make([]*CompleteDeliverListResult, 0)
	if err = dbResult.Scan(&query_data).Error; err != nil {
		return
	}

	psMap := map[uint32]int{} //key=快递物流id value=订单id所属的商品种类数
	for i := 0; i < len(query_data); i++ {
		psMap[query_data[i].LogisticsID]++
		if userName == "" {
			userName = query_data[i].UserName
		}
	}

	//处理数据
	res = make([]*CompleteDeliverListInfo, len(psMap))

	//得到不重复订单数据列表
	var all_index int = 0

	for _, q_value := range query_data {
		//判断是否重复插入
		if func() bool {
			for _, all_value := range res {
				if all_value != nil && all_value.OrderID == q_value.OrderID && all_value.LogisticsID == q_value.LogisticsID {
					//重复的订单
					all_value.GoodsList = append(all_value.GoodsList, &GoodsSubInfo{
						GoodsName:      q_value.GoodsName,
						GoodsCount:     q_value.GoodsCount,
						Specifications: q_value.Specifications,
						Remark:         q_value.Remark,
					})
					return true
				}
			}
			return false
		}() {
			continue
		}

		res[all_index] = &CompleteDeliverListInfo{
			OrderID:          q_value.OrderID,
			LogisticsNumber:  q_value.LogisticsNumber,
			LogisticsCompany: q_value.LogisticsCompany,
			LogisticsID:      q_value.LogisticsID,
			Receiver: &ReceiverInfo{
				ReceiverName:     q_value.ReceiverName,
				ReceiverIphone:   q_value.ReceiverIphone,
				ReceiverProvince: q_value.ReceiverProvince,
				ReceiverCity:     q_value.ReceiverCity,
				ReceiverDistrict: q_value.ReceiverDistrict,
				ReceiverAddress:  q_value.ReceiverAddress,
			},
			Sender: &SenderInfo{
				SenderName:     q_value.SenderName,
				SenderIphone:   q_value.SenderIphone,
				SenderProvince: q_value.SenderProvince,
				SenderCity:     q_value.SenderCity,
				SenderDistrict: q_value.SenderDistrict,
				SenderAddress:  q_value.SenderAddress,
			},
		}
		res[all_index].GoodsList = append(res[all_index].GoodsList, &GoodsSubInfo{
			GoodsName:      q_value.GoodsName,
			GoodsCount:     q_value.GoodsCount,
			Specifications: q_value.Specifications,
			Remark:         q_value.Remark,
		})
		all_index++
	}
	return
}

//判断是否商品名称重复
func RepeatHGoodsNameEx(tx *gorm.DB, name string, hgsid uint64, shopId uint64) bool {
	tb := tx.Table("h_goods")
	_hgoods := &entity.HGoods{}
	var err error
	if hgsid == 0 {
		tb = tb.Where("hgs_name = ? and shop_id=?", name, shopId)
	} else {
		tb = tb.Where("hgs_name = ? and hgs_id<>?  and shop_id=?", name, hgsid, shopId)
	}
	if err = tb.First(_hgoods).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
		return true
	}
	if _hgoods.HgsID == 0 {
		return false
	}
	return true
}

func SynchronizationGoods() (msg string, err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		_goods := make([]*entity.Goods, 0)
		if err = tx.Table("goods").Where("goods_status in(0,1)").Find(&_goods).Error; err != nil {
			isErr = true
			return
		}
		for _, v := range _goods {
			if RepeatHGoodsNameEx(tx, v.GoodsName, 0, v.ShopID) {
				continue
			}
			status := HGBUYING
			if v.GoodsStatus == GDOFTS {
				status = HGING
			}
			_hgoods := entity.HGoods{
				ShopID:       v.ShopID,
				HgsID:        utils.GenUniqueID(),
				HgsName:      v.GoodsName,
				HgsSource:    v.GoodsSource,
				HgsBuilddate: v.ProducedTime,
				HgsExplain:   v.GoodsComment,
				HgsImg:       v.GoodsImgURL,
				HgsStatus:    status,
			}
			if err = tx.Table("h_goods").Create(&_hgoods).Error; err != nil {
				isErr = true
				return
			}
			v.HgsID = _hgoods.HgsID
			if err = tx.Table("goods").Where("goods_id=? and  goods_name=?", v.GoodsID, v.GoodsName).Updates(&v).Error; err != nil {
				isErr = true
				return
			}
		}
	}
	return
}

//商品记录统计
type CommodityRecordsReq struct {
}

type CommodityRecordsResp struct {
	TotalMerchandise uint32 `json:"total_merchandise"` //商品总数
	GoodsSale        uint32 `json:"goods_sale"`        //在售商品
	GoodsStock       uint32 `json:"goods_stock"`       //在库商品
	TotalWarehousing uint32 `json:"total_warehousing"` //入库总数
	TotalSold        uint32 `json:"total_sold"`        //已售总数
	TotalInventory   uint32 `json:"total_inventory"`   //库存总数
}

//商品记录统计
func CommodityRecords(req *CommodityRecordsReq, ShopID uint64) (res *CommodityRecordsResp, err error) {
	tb := dbGorm.Table("h_goods")
	res = &CommodityRecordsResp{}
	err = tb.Where("shop_id =? AND hgs_status = 1", ShopID).Count(&res.GoodsSale).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CommodityRecords Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	err = tb.Where("shop_id =? AND hgs_status = 0", ShopID).Count(&res.GoodsStock).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CommodityRecords Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	res.TotalMerchandise = res.GoodsSale + res.GoodsStock
	err = tb.Select("SUM(hgs_salenum) as total_sold,SUM(hgs_surplusnum) as total_inventory").Where("shop_id =? AND hgs_status != -1", ShopID).Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CommodityRecords Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	res.TotalWarehousing = res.TotalSold + res.TotalInventory
	return res, nil
}

//订单统计
type OrderStatisticsReq struct {
	InputTerms  string    `json:"input_terms"`  //搜索输入词 为空表示查看全部
	OrderStatus uint32    `json:"order_status"` //1:搜买家  2:搜商品  3:搜订单
	StartTime   time.Time `json:"start_time"`   //起始时间
	EndTime     time.Time `json:"end_time"`     //结束时间
	StartIndex  uint32    `json:"start_index"`  //页起始
	Count       uint32    `json:"count"`        //每页数量
}

type OrderStatisticsResp struct {
	ID             uint32  `json:"id"`             // 订单商品编号
	OrderID        string  `json:"order_id"`       // 订单编号
	CrNick         string  `json:"cr_nick"`        // 客户昵称
	GoodsName      string  `json:"goods_name"`     // 商品名称 不能重复
	Specifications string  `json:"specifications"` // 商品规格（比如大小和颜色等）
	Quantity       int32   `json:"quantity"`       // 数量
	InputPrice     float64 `json:"input_price"`    // 进价
	SinglePrice    float64 `json:"single_price"`   // 售价
}

//订单统计
func OrderStatistics(req *OrderStatisticsReq, ShopID uint64) (res []*OrderStatisticsResp, err error) {
	tb := dbGorm.Table("orders")
	tb = tb.Offset(req.StartIndex).Limit(req.Count).Select("orders.order_id,orders.customer_name as cr_nick,orders_goods.id,orders_goods.goods_name,orders_goods.specifications,orders_goods.quantity,orders_goods.input_price,orders_goods.single_price")
	tb = tb.Joins("left join orders_goods on orders_goods.order_id=orders.order_id")
	//OrderStatus 1:搜买家  2:搜商品  3:搜订单
	if req.InputTerms == "" {
		tb = tb.Where("orders.shop_id = ? AND orders.created_at >= ? AND orders.created_at <= ? AND orders_goods.order_goods_status = ? AND orders.status != -1 AND orders_goods.status != -1", ShopID, req.StartTime, req.EndTime, OSC).Order("orders.created_at desc")
	} else {
		if req.OrderStatus == 1 {
			tb = tb.Where("orders.shop_id = ? AND orders.created_at >= ? AND orders.created_at <= ? AND orders_goods.order_goods_status = ? AND orders.status != -1 AND orders_goods.status != -1 AND orders.customer_name LIKE ?", ShopID, req.StartTime, req.EndTime, OSC, "%"+req.InputTerms+"%").Order("orders.created_at desc")
		} else if req.OrderStatus == 2 {
			tb = tb.Where("orders.shop_id = ? AND orders.created_at >= ? AND orders.created_at <= ? AND orders_goods.order_goods_status = ? AND orders.status != -1 AND orders_goods.status != -1 AND orders_goods.goods_name LIKE ?", ShopID, req.StartTime, req.EndTime, OSC, "%"+req.InputTerms+"%").Order("orders.created_at desc")
		} else {
			tb = tb.Where("orders.shop_id = ? AND orders.created_at >= ? AND orders.created_at <= ? AND orders_goods.order_goods_status = ? AND orders.status != -1 AND orders_goods.status != -1 AND orders.order_id = ?", ShopID, req.StartTime, req.EndTime, OSC, req.InputTerms).Order("orders.created_at desc")
		}
	}
	if err = tb.Scan(&res).Error; err != nil {
		return
	}
	return
}

type PreOrderList struct {
	PaymentReceivedWhole   float64 `json:"payment_received_whole"`   // 已收货款(全收)
	PaymentReceivedDeposit float64 `json:"payment_received_deposit"` // 已收货款(定金)
	OfferWhole             float64 `json:"offer_whole"`              // 已收运费(全收)
	OfferDeposit           float64 `json:"offer_deposit"`            // 已收运费(定金)
}

//预购清单统计
type PreOrderListStatisticsReq struct {
}

type PreOrderListStatisticsResp struct {
	GoodsType         uint32  `json:"goods_type"`          // 预购商品种类
	GoodsTotal        uint32  `json:"goods_total"`         // 预购商品总数
	CustomersFate     uint32  `json:"customers_fate"`      // 预购客户数
	TotalInputPrice   float64 `json:"total_input_price"`   // 商品总进价
	TotalPrice        float64 `json:"total_price"`         // 商品总售价
	ExpectedProfit    float64 `json:"expected_profit"`     // 预计利润、
	TodayProfitMargin float64 `json:"today_profit_margin"` // 预计利润率
	PaymentReceived   float64 `json:"payment_received"`    // 已收货款
	CollectedReceived float64 `json:"collected_received"`  // 待收货款
	TodayTotal        float64 `json:"today_total"`         // 今日加单总额
	TodayProfit       float64 `json:"today_profit"`        // 今日预计利润
}

//预购清单统计
func PreOrderListStatistics(req *PreOrderListStatisticsReq, ShopID uint64) (res *PreOrderListStatisticsResp, err error) {
	res = &PreOrderListStatisticsResp{}
	PreOrder := &PreOrderList{}
	var sql_buf1 bytes.Buffer
	sql1 := "SELECT COUNT(distinct a.hgs_id) as goods_type,SUM(b.quantity) as goods_total,COUNT(distinct a.customer_id) as customers_fate,SUM(b.total_input_price) as total_input_price,SUM(b.total_price) as total_price FROM h_preorder as a LEFT JOIN orders_goods as b on a.id = b.hp_id WHERE a.shop_id = %d and a.buy_status = %d and b.status = %d "
	sql_buf1.WriteString(fmt.Sprintf(sql1, ShopID, PONOBUY, OG_NORMAL))
	dbResult1 := dbGorm.Raw(sql_buf1.String())
	if err = dbResult1.Scan(&res).Error; err != nil {
		return
	}
	var sql_buf2 bytes.Buffer
	sql2 := "SELECT SUM(total_price) as payment_received_whole FROM h_preorder as a LEFT JOIN orders_goods as b on a.id = b.hp_id WHERE a.shop_id = %d and a.buy_status = %d and b.status = %d and pay_status = 1 "
	sql_buf2.WriteString(fmt.Sprintf(sql2, ShopID, PONOBUY, OG_NORMAL))
	dbResult2 := dbGorm.Raw(sql_buf2.String())
	if err = dbResult2.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf4 bytes.Buffer
	sql4 := "SELECT SUM(paidmoney) as payment_received_deposit FROM h_preorder as a LEFT JOIN orders_goods as b on a.id = b.hp_id WHERE a.shop_id = %d and a.buy_status = %d and b.status = %d and pay_status = 0 "
	sql_buf4.WriteString(fmt.Sprintf(sql4, ShopID, PONOBUY, OG_NORMAL))
	dbResult4 := dbGorm.Raw(sql_buf4.String())
	if err = dbResult4.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf3 bytes.Buffer
	sql3 := "SELECT SUM(total_price) as today_total,SUM(total_price - total_input_price) as today_profit FROM h_preorder as a LEFT JOIN orders_goods as b on a.id = b.hp_id WHERE a.shop_id = %d and a.buy_status = %d and b.status = %d AND to_days(a.created_at) = to_days(now()) "
	sql_buf3.WriteString(fmt.Sprintf(sql3, ShopID, PONOBUY, OG_NORMAL))
	dbResult3 := dbGorm.Raw(sql_buf3.String())
	if err = dbResult3.Scan(&res).Error; err != nil {
		return
	}
	res.ExpectedProfit = SubtractFloat64(res.TotalPrice, res.TotalInputPrice)
	res.CollectedReceived = SubtractFloat64(res.TotalPrice, res.PaymentReceived)
	res.PaymentReceived = AddFloat64(PreOrder.PaymentReceivedDeposit, PreOrder.PaymentReceivedWhole)
	if res.TotalInputPrice == 0 {
		res.TodayProfitMargin = 0
	} else {
		res.TodayProfitMargin = SubtractFloat64(res.TotalPrice, res.TotalInputPrice) / res.TotalInputPrice
	}
	return
}

//收款发货统计
type CollectionDeliveryStatisticsReq struct {
}

type CollectionDeliveryStatisticsResp struct {
	TotalInputPrice    float64 `json:"total_input_price"`    // 商品总进价
	TotalPrice         float64 `json:"total_price"`          // 商品总售价
	FreightCost        float64 `json:"freight_cost"`         // 邮费总成本
	FreightOffer       float64 `json:"freight_offer"`        // 邮费总实收
	TodayProfit        float64 `json:"today_profit"`         // 预计利润
	TodayProfitMargin  float64 `json:"today_profit_margin"`  // 预计利润率
	TotalReceivables   float64 `json:"total_receivables"`    // 应收总额
	AmountReceived     float64 `json:"amount_received"`      // 已收总额
	TotalAmount        float64 `json:"total_amount"`         // 待收总额
	CustomersFate      uint32  `json:"customers_fate"`       // 客户总数
	IssuedCustomers    uint32  `json:"issued_customers"`     // 以全发客户
	NotIssuedCustomers uint32  `json:"not_issued_customers"` // 未全发客户
}

//收款发货统计
func CollectionDeliveryStatistics(req *CollectionDeliveryStatisticsReq, ShopID uint64) (res *CollectionDeliveryStatisticsResp, err error) {
	res = &CollectionDeliveryStatisticsResp{}
	PreOrder := &PreOrderList{}
	var sql_buf1 bytes.Buffer
	sql1 := "select SUM(a.total_input_price) as total_input_price,SUM(a.total_price) as total_price,SUM(c.cost) as freight_cost,SUM(c.offer) as freight_offer FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id LEFT JOIN orders_logistics AS c ON c.order_id = a.order_id  and c.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id<>''  and a.order_goods_status in (%d,%d) "
	sql_buf1.WriteString(fmt.Sprintf(sql1, ShopID, POBUY, POSD))
	dbResult1 := dbGorm.Raw(sql_buf1.String())
	if err = dbResult1.Scan(&res).Error; err != nil {
		return
	}
	var sql_buf2 bytes.Buffer
	sql2 := "select SUM(a.total_price) as payment_received_whole FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id LEFT JOIN orders_logistics AS c ON c.order_id = a.order_id  and c.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id<>''  and a.order_goods_status in (%d,%d) and a.pay_status = 1 "
	sql_buf2.WriteString(fmt.Sprintf(sql2, ShopID, POBUY, POSD))
	dbResult2 := dbGorm.Raw(sql_buf2.String())
	if err = dbResult2.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf5 bytes.Buffer
	sql5 := "select SUM(a.paidmoney) as payment_received_whole FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id LEFT JOIN orders_logistics AS c ON c.order_id = a.order_id  and c.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id<>'' and a.order_goods_status in (%d,%d) and a.pay_status = 0 "
	sql_buf5.WriteString(fmt.Sprintf(sql5, ShopID, POBUY, POSD))
	dbResult5 := dbGorm.Raw(sql_buf5.String())
	if err = dbResult5.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf6 bytes.Buffer
	sql6 := "select SUM(c.offer) as offer_whole FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id LEFT JOIN orders_logistics AS c ON c.order_id = a.order_id  and c.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id<>''  and a.order_goods_status in (%d,%d) and a.pay_status = 1 and c.uf_pay_status = 1"
	sql_buf6.WriteString(fmt.Sprintf(sql6, ShopID, POBUY, POSD))
	dbResult6 := dbGorm.Raw(sql_buf6.String())
	if err = dbResult6.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf7 bytes.Buffer
	sql7 := "select SUM(c.offer) as offer_deposit FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id LEFT JOIN orders_logistics AS c ON c.order_id = a.order_id  and c.id=a.logistics_id where a.`status`=0 and b.status=1 and b.order_id<>'' and a.order_goods_status in (%d,%d) and a.pay_status = 0  and c.uf_pay_status = 1"
	sql_buf7.WriteString(fmt.Sprintf(sql7, ShopID, POBUY, POSD))
	dbResult7 := dbGorm.Raw(sql_buf7.String())
	if err = dbResult7.Scan(&PreOrder).Error; err != nil {
		return
	}
	var sql_buf3 bytes.Buffer
	sql3 := "select COUNT(distinct b.customer_id) as customers_fate FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d) as b on a.order_id=b.order_id  where a.`status`=0 and b.status=1 and b.order_id<>'' and a.order_goods_status in (%d,%d) and b.customer_id !=0 "
	sql_buf3.WriteString(fmt.Sprintf(sql3, ShopID, POBUY, POSD))
	dbResult3 := dbGorm.Raw(sql_buf3.String())
	if err = dbResult3.Scan(&res).Error; err != nil {
		return
	}
	var sql_buf4 bytes.Buffer
	sql4 := "select COUNT(distinct b.customer_id) as not_issued_customers FROM orders_goods as a left join (SELECT * FROM orders WHERE status=1 and shop_id=%d and isdeliver = 0) as b on a.order_id=b.order_id  where a.`status`=0 and b.status=1 and b.order_id<>''  and a.order_goods_status in (%d,%d) and b.customer_id !=0  "
	sql_buf4.WriteString(fmt.Sprintf(sql4, ShopID, POBUY, POSD))
	dbResult4 := dbGorm.Raw(sql_buf4.String())
	if err = dbResult4.Scan(&res).Error; err != nil {
		return
	}
	res.TodayProfit = SubtractFloat64(AddFloat64(res.TotalPrice, res.FreightOffer), AddFloat64(res.TotalInputPrice, res.FreightCost))
	res.TotalReceivables = AddFloat64(res.TotalPrice, res.FreightOffer)
	res.AmountReceived = AddFloat64(AddFloat64(PreOrder.PaymentReceivedDeposit, PreOrder.OfferDeposit), AddFloat64(PreOrder.PaymentReceivedWhole, PreOrder.OfferWhole))
	res.TotalAmount = SubtractFloat64(res.TotalReceivables, res.AmountReceived)
	res.IssuedCustomers = res.CustomersFate - res.NotIssuedCustomers
	if (res.TotalInputPrice + res.FreightCost) == 0 {
		res.TodayProfitMargin = 0
	} else {
		res.TodayProfitMargin = res.TodayProfit / AddFloat64(res.TotalInputPrice, res.FreightCost)
	}
	return
}

//收货地址修改
func ModReceiverAddress(AddressID uint32, orderID string) (msg string, err error) {
	defer func() {
		if err != nil {
			err = nil
			msg = "修改失败"
		}
	}()
	tb_hca := dbGorm.Table("h_customer_addr")
	hca_data := entity.HCustomerAddr{}
	if err = tb_hca.Where("address_id = ?", AddressID).First(&hca_data).Error; err != nil {
		err = fmt.Errorf("ModReceiverAddress Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}

	_pData := &OrderModifyAddressParam{
		OrderId:          orderID,
		ReceiverName:     hca_data.Name,
		ReceiverIphone:   hca_data.PhoneNumber,
		ReceiverProvince: hca_data.Province,
		ReceiverCity:     hca_data.City,
		ReceiverDistrict: hca_data.Area,
		ReceiverAddress:  hca_data.Detailed,
	}
	//修改收货地址
	if err = ModelModifyAddressOrder(_pData); err != nil {
		err = fmt.Errorf("ModelModifyAddressOrder Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	return
}

//快递公司修改
//修改默认物流数据
func ModExpressCompany(Com string, CompanyName string, orderID string) (msg string, err error) {
	tb_hca := dbGorm.Table("orders_logistics")
	tb_hca = tb_hca.Where("order_id=? and  is_default=1 and status =0", orderID).Updates(map[string]interface{}{"logistics_company": CompanyName, "logistics_com": Com, "updated_at": time.Now().Format(timeFormat)})
	if err = tb_hca.Error; err != nil {
		err = fmt.Errorf("ModExpressCompany Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	if tb_hca.RowsAffected == 0 {
		msg = "修改失败"
		return
	}

	return
}
