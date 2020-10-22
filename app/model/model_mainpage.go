package model

import (
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"time"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
	"github.com/jinzhu/gorm"
)

//商品状态 0下架1上架2售空3即将过期4已过期5删除
const (
	GDOFTS int32 = iota // 0 下架 Off the shelf
	GDOTS               // 1 上架  On the shelf
	GDSS                // 2 售空 Short sale
	GDATE               // 3 即将过期 About to expire
	GDED                // 4 已过期 Expired
	GDDEL               // 5 删除 Delete
)

//单操作指令：0无指令，1上架，2下架，3删除，4置顶
const (
	COM_NULL uint32 = iota
	COM_UP
	COM_DOWN
	COM_DEL
	COM_TOP
)

//新增商品
func AddGoodsType(_goods *entity.Goods) (msg string, err error) {
	//获取商品分类id
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()

		//先判断该商品绑定的商品库状态是否是在库，反之不能上架商品
		_hgoods := entity.HGoods{}
		if err = tx.Table("h_goods").Where("hgs_id=? and hgs_status=? AND shop_id=?", _goods.HgsID, HGING, _goods.ShopID).First(&_hgoods).Error; err != nil && !gorm.IsRecordNotFoundError(err) {
			isErr = true
			zaplog.Errorf("h_goods db err:%s", err)
			return
		}
		if _hgoods.ID == 0 {
			if _goods.HgsID == 0 {
				//老版本自动创建该商品到商品库内
				hInfo := &entity.HGoods{}
				if hInfo, err = CreateHouseInfo(&HouseInfoReq{
					HouseBaseInfo: HouseBaseInfo{
						HgsInprice:   0,
						HgsSaleprice: _goods.Price,
						HgsName:      _goods.GoodsName,
					},
				}, _goods.ShopID); err != nil || hInfo == nil {
					isErr = true
					msg = "该商品添加失败"
					return
				}
				_goods.HgsID = hInfo.HgsID
			} else {
				isErr = true
				msg = "该商品已经在售，无法重复上架"
				return
			}
		}

		tb := tx.Table("shop_category")
		var num int32
		err = tb.Where("category_id=? AND shop_id=?", _goods.CategoryID, _goods.ShopID).Count(&num).Error
		if err != nil || num == 0 {
			isErr = true
			zaplog.Errorf("AddGoodsType db err:%s", err)
			msg = "商品类型非法，请联系客服"
			return
		}
		err = tx.Table("goods").Create(_goods).Error
		if err != nil {
			isErr = true
			zaplog.Errorf("AddGoodsType db err:%s", err)
			return
		}

		//修改商品库状态为在售
		if err = ModHGoodsStatus(tx, _goods.ShopID, _goods.HgsID, HGBUYING); err != nil {
			isErr = true
			zaplog.Errorf("h_goods db err:%s", err)
			return
		}
	}
	return
}

type DbEditClassifyOut struct {
	CategoryID   int32  `json:"category_id"`   // 商品分类id
	CategorySort uint32 `json:"category_sort"` // 排序字段
}

type DbEditClassifyName struct {
	CategoryName string `json:"category_name"` // 分类名称
}

// //新增分类
// func EditClassify(_userId uint32, _name string) (err error) {

// 	//找到最大的序号
// 	tb := dbGorm.Table("goods_category")
// 	var res DbEditClassifyOut
// 	err = tb.Order("category_id desc").Select("category_id").Find(&res, "user_id=?", _userId).Error
// 	if err != nil {
// 		if !gorm.IsRecordNotFoundError(err) {
// 			zaplog.Errorf("EditClassify err=%s", err)
// 			return err
// 		}
// 		res.CategoryID = 0
// 	}

// 	//插入新的分类
// 	newClassify := &entity.GoodsCategory{
// 		CategoryID:   res.CategoryID + 1,
// 		CategoryName: _name,
// 	}

// 	err = tb.Create(newClassify).Error
// 	if err != nil {
// 		zaplog.Errorf("EditClassify err=%s", err)
// 		return err
// 	}
// 	return
// }

//编辑分类
func EditClassify(_shopId uint64, id []int32) (err error) {
	tb := dbGorm.Table("shop_category")
	res := []DbEditClassifyOut{}
	resp := &DbEditClassifyName{}
	//确认分类ID
	err = tb.Select("category_id,category_sort").Where("shop_id=?", _shopId).Scan(&res).Error
	if err != nil {
		zaplog.Errorf("EditClassify err=%s", err)
		return err
	}
	var a bool = true
	//筛选存在的数据,并保持次序
	for i := 0; i < len(id); i++ {
		for j := 0; j < len(res); j++ {
			a = true
			if res[j].CategoryID == id[i] {
				err = tb.Where("category_id=? AND shop_id=?", res[j].CategoryID, _shopId).Update(map[string]interface{}{"category_sort": i + 1}).Error
				if err != nil {
					zaplog.Errorf("EditClassify err=%s", err)
					return err
				}
				a = false
				break
			}
		}
		if a {
			err = dbGorm.Table("goods_category").Select("category_name").Where("category_id=?", id[i]).Scan(&resp).Error
			if err != nil {
				zaplog.Errorf("EditClassify err=%s", err)
				return err
			}
			err = tb.Create(&entity.ShopCategory{CategoryID: uint32(id[i]), ShopID: _shopId, CategoryName: resp.CategoryName, CategorySort: uint32(i + 1)}).Error
			if err != nil {
				zaplog.Errorf("EditClassify err=%s", err)
				return err
			}
		}
	}
	err = tb.Where("category_id not in(?) and shop_id=?", id, _shopId).Delete(&res).Error
	//同时删除分类的商品
	if len(res) == 0 || len(id) == 0 {
		err = dbGorm.Table("goods").Where("shop_id=?", _shopId).Update("goods_status", GDDEL).Error //.Unscoped().Delete(&entity.Goods{}).Error
	} else {
		err = dbGorm.Table("goods").Where("category_id not in(?) and shop_id=?", id, _shopId).Update("goods_status", GDDEL).Error //.Unscoped().Delete(&entity.Goods{}).Error
	}

	return
}

//首页商品列表信息
type ModelDbGetPageInfoOut struct {
	GoodsName   string      `json:"goods_name"`    //商品名字
	GoodsImgURL null.String `json:"goods_img_url"` //商品图片
	GoodsSource null.String `json:"goods_source"`  //商品来源
	GoodsID     string      `json:"goods_id"`      //商品id
	GoodsStatus int32       `json:"goods_status"`  //商品状态0下架1上架2售空3即将过期4已过期5删除
	Price       float64     `gorm:"column:price;type:udecimal;" json:"price"`
}

//首页信息排序类型
type EnumMainPageOrder uint32

const (
	EnumAddTime EnumMainPageOrder = iota //按照上架时间
	EnumPrice                            //按照价格
)

type DbGetPageInfoIn struct {
	ShopID    uint64 `json:"shop_id"  v:"shop_id@required#目标用户id不能为空"`                    //目标用户id
	Page      uint32 `json:"page"       v:"page@required|min:1#目标用户id不能为空|页数最小为1"`        //页数
	PageSize  uint32 `json:"page_size"  v:"page_size@required|min:1#目标用户id不能为空|每页数量最小为1"` //每页数量
	Order     uint32 `json:"order"      v:"order@required#目标用户id不能为空"`                    //排序规则(默认都是从大到小,0:按照上架时间,1:按照价格)
	QueryType int32  `json:"query_type" v:"query_type@required#分类类型不能为空,"`                //分类类型(0:全部)
}

//获取商品列表
func GetPageInfo(_args *DbGetPageInfoIn, _userid uint32) (out []*ModelDbGetPageInfoOut, err error) {
	//查询该用户所有的商品
	out = make([]*ModelDbGetPageInfoOut, 30)
	tb := dbGorm.Table("goods")

	if _args.Page > 0 {
		offset := (_args.Page - 1) * _args.PageSize
		tb = tb.Offset(offset).Limit(_args.PageSize)
	} else {
		tb = tb.Limit(_args.PageSize)
	}
	tb = tb.Order("goods_status desc") //商品状态

	tb = tb.Order("top_time desc") //置顶
	//确定排序规则
	switch _args.Order {
	case 0:
		tb = tb.Order("add_time desc")
	case 1:
		tb = tb.Order("price desc")
	default:
		tb = tb.Order("add_time desc")
	}

	tb = tb.Order("down_time desc") //下架时间
	tb = tb.Where("goods_status =? ", GDOTS)
	// 2020-8-27 del lyh
	// if uint64(_userid) == _args.ShopID {
	// 	tb = tb.Where("goods_status =? ", GDOTS) //排除删除的商品
	// } else {
	// 	tb = tb.Where("goods_status=1") //买家只展示上架商品
	// }

	//确定分类类型
	if _args.QueryType != 0 {
		tb = tb.Where("category_id=?", _args.QueryType)
	}

	err = tb.Find(&out, "shop_id=?", _args.ShopID).Error
	if err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			zaplog.Errorf("SelfGetMainPageInfo err=%s", err)
			return nil, err
		}
	}
	return
}

type GetMainPageBaseInfoOut1 struct {
	ShopID          uint64      `json:"shop_id"`          //商店id
	WechatNumber    null.String `json:"wechat_number"`    //微信号
	ShopURL         string      `json:"shop_url"`         //店铺头像
	ShopName        string      `json:"shop_name"`        //商店名称
	ShopDescription null.String `json:"shop_description"` //店铺说明
	QrCodeURL       null.String `json:"qr_code_url"`      //收款二维码
}

type GetMainPageBaseInfoOut struct {
	GetMainPageBaseInfoOut1
	CategoryInfo       string `json:"category_info"`        //分类信息
	MainpageScrollInfo string `json:"mainpage_scroll_info"` //滚动信息
}

type GetMainPageBaseInfoIn struct {
	ShopID uint64 `json:"shop_id"  v:"shop_id@required#商铺信息不能为空"` //目标用户id
}

//获取首页基本信息
func GetMainPageBaseInfo(_args *GetMainPageBaseInfoIn) (out *GetMainPageBaseInfoOut, err error) {
	out = &GetMainPageBaseInfoOut{}
	//获取店铺信息
	err = dbGorm.Table("shop_info").Where("user_id=?", _args.ShopID).First(out).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			zaplog.Errorf("GetMainPageBaseInfo, err=%s", err)
			return out, nil
		}
		zaplog.Errorf("GetMainPageBaseInfo, err=%s", err)
		return nil, err
	}
	return
}

type GetMainPageShopInfoIn struct {
	ShopID uint64 `json:"shop_id"`
	UserID uint32 `json:"user_id"`
}

type GetMainPageShopInfoOut struct {
	ShopID          uint64      `json:"shop_id"`          //商店id
	WechatNumber    null.String `json:"wechat_number"`    //微信号
	ShopURL         string      `json:"shop_url"`         //店铺头像
	ShopName        string      `json:"shop_name"`        //商店名称
	ShopDescription null.String `json:"shop_description"` //店铺说明
	QrCodeURL       null.String `json:"qr_code_url"`      //收款二维码
}

//获取首页商店信息
func GetMainPageShopInfo(_args *GetMainPageShopInfoIn) (out *GetMainPageShopInfoOut, err error) {
	out = &GetMainPageShopInfoOut{}
	//获取店铺信息
	err = dbGorm.Table("shop_info").Where("shop_id=?", _args.ShopID).First(out).Error
	if err != nil {
		zaplog.Errorf("GetMainPageShopInfo Db err=%s", err)
		return
	}

	AddShopAccessRecord(&entity.ShopAccessRecords{UserID: _args.UserID, ShopID: _args.ShopID})
	IncreaseFans(nil, &IncreaseFansReq{ShopID: _args.ShopID, UserID: _args.UserID, Category: 0})
	return
}

//搜索商品
type DbSearchGoodsReq struct {
	ShopID     uint64 `json:"shop_id" `                                                    //店铺id
	InputTerms string `json:"input_terms" v:"InputTerms@required#搜索词不能为空"`                 //搜索输入词
	Page       uint32 `json:"page"       v:"page@required|min:1#目标用户id不能为空|页数最小为1"`        //页数
	PageSize   uint32 `json:"page_size"  v:"page_size@required|min:1#目标用户id不能为空|每页数量最小为1"` //每页数量
}

//商品信息
type DbGetGoodsInfoOut struct {
	ShopID    uint64 `json:"shop_id"`    //商铺ID
	ShopName  string `json:"shop_name"`  //商铺名字
	GoodsName string `json:"goods_name"` //商品名字
	// GoodsComment null.String  `json:"goods_comment"` //商品说明
	GoodsImgURL null.String `json:"goods_img_url"` //商品图片
	// ProducedTime *entity.Time `json:"produced_time"` //生产时间
	// OverInfo     null.String  `json:"over_info"`     //过期信息
	GoodsSource null.String `json:"goods_source"` //商品来源
	GoodsID     string      `json:"goods_id"`     //商品id
	GoodsStatus int32       `json:"goods_status"` //商品状态0下架1上架2售空3即将过期4已过期5删除
	Price       float64     `gorm:"column:price;type:udecimal;" json:"price"`
}
type GetFanShopID struct {
	ShopID uint64 `json:"shop_id"` // 店铺id
}

//搜索商品结果查询
func GetSearchGoodsInfo(_args *DbSearchGoodsReq, user_id uint32) (out []*DbGetGoodsInfoOut, err error) {
	//查询该用户所有的商品
	out = make([]*DbGetGoodsInfoOut, _args.PageSize)
	fans_shop := []*GetFanShopID{}
	if dbGorm.Table("shop_fans").Select("shop_id").Where("user_id=? ", user_id).Find(&fans_shop).Error != nil {
		return nil, errors.New("当前未关注任何商铺,无法搜索商品")
	}
	tb := dbGorm.Table("goods as a").Joins("left join shop_info as b on a.shop_id=b.shop_id").Select("a.*,b.shop_name")

	tb = tb.Where("a.goods_status=? and a.goods_name like ?", GDOTS, "%"+_args.InputTerms+"%")
	if _args.ShopID >= 1000000 {
		tb = tb.Where("b.shop_id = ?  ", _args.ShopID) //指定商铺所属的商品
	} else {
		if len(fans_shop) > 0 {
			fansShopIdArr := make([]uint64, len(fans_shop)) //粉丝列表
			for k, v := range fans_shop {
				fansShopIdArr[k] = v.ShopID
			}
			tb = tb.Where("b.shop_id = ? or b.shop_id in (?) ", uint64(user_id), fansShopIdArr) //关注的店铺或者用户商铺的店主
		} else {
			tb = tb.Where("b.shop_id = ?", uint64(user_id)) //或者用户商铺的店主
		}
	}

	if _args.Page > 0 {
		offset := (_args.Page - 1) * _args.PageSize
		tb = tb.Offset(offset).Limit(_args.PageSize)
	} else {
		tb = tb.Limit(_args.PageSize)
	}
	tb = tb.Order("a.top_time desc,a.add_time desc") //置顶

	err = tb.Find(&out).Error
	if err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			zaplog.Errorf("GetSearchGoodsInfo err=%s", err)
			return nil, err
		}
	}
	return
}

//单指令操作商品请求
type DbSingleCmdEditGoodsReq struct {
	// ShopID  uint64 `json:"shop_id" v:"required"`  // 商铺ID
	GoodsID string `json:"goods_id" v:"required"` //商品id  前端务必传字符串
	Cmd     uint32 `json:"cmd" v:"required"`      //指令：0无指令，1上架，2下架，3删除，4置顶
}

//单指令操作商品请求
func SingleCmdEditGoods(_args *DbSingleCmdEditGoodsReq, shopId uint64) (err error) {
	var isErr bool = false
	if tx := dbGorm.Begin(); tx.Error == nil {
		defer func() {
			if isErr {
				tx.Rollback()
			}
			tx.Commit()
		}()
		tb := tx.Table("goods")
		tb = tb.Where("goods_id= ? and shop_id=?", gconv.Uint64(_args.GoodsID), shopId)

		switch _args.Cmd {
		case COM_UP:
			err = tb.Update(g.Map{
				"goods_status": GDOTS,
				"add_time":     time.Now(),
			}).Error
		case COM_DOWN:
			tb_temp := tx.Table("goods").Where("goods_id= ? and shop_id=? and goods_status=?", gconv.Uint64(_args.GoodsID), shopId, GDOTS)
			//先记录要修改的记录信息
			_goods := entity.Goods{}
			if err = tb_temp.First(&_goods).Error; err != nil {
				break
			}

			if err = tb_temp.Update(g.Map{
				"goods_status": GDOFTS,
				"down_time":    time.Now(),
				"top_time":     nil, //下架商品，置顶时间清空
			}).Error; err != nil {
				break
			}
			//商品库状态改为在库
			if err = ModHGoodsStatus(tx, shopId, _goods.HgsID, HGING); err != nil {
				break
			}
		case COM_DEL:
			err = tb.Update("goods_status", GDDEL).Error
		case COM_TOP:
			err = tb.Update("top_time", time.Now()).Error
		default:
			return errors.New("操作非法，请联系客服")
		}

		if err != nil {
			isErr = true
			if !gorm.IsRecordNotFoundError(err) {
				zaplog.Errorf("SingleCmdEditGoods err=%s", err)
				return err
			}
		}
	}
	return
}

//查看指定商品详细信息
type DbLookUpGoodsDetail struct {
	UserID  uint32 `json:"user_id"`
	GoodsID uint64 `json:"goods_id" v:"required"` //商品id 前端务必传字符串
}

// //商品规格
// type DbGoodsSpecification struct {
// 	Name       string  `json:"name"`        // 规格名称
// 	InputPrice float64 `json:"input_price"` // 入库价格
// 	ShopPrice  float64 `json:"shop_price"`  // 销售价格
// 	StockNum   int32   `json:"stock_num"`   // 库存数量
// }

//查看指定商品详细信息回应
type DbLookUpGoodsDetailReps struct {
	ShopID         uint64       `json:"shop_id"`        // 商铺ID
	ShopName       string       `json:"shop_name"`      // 商铺名称
	CategoryID     int32        `json:"category_id"`    //分类id
	GoodsID        string       `json:"goods_id"`       //商品id
	GoodsName      null.String  `json:"goods_name"`     //商品名字
	GoodsComment   null.String  `json:"goods_comment"`  //商品说明
	GoodsImgURL    null.String  `json:"goods_img_url"`  //商品图片
	ProducedTime   *entity.Time `json:"produced_time"`  //生产时间 年月日
	OverInfo       null.String  `json:"over_info"`      //过期信息
	EsDeTime       null.String  `json:"es_de_time"`     //预计发货时间 时间范围
	GoodsSource    null.String  `json:"goods_source"`   //商品来源
	GoodsStatus    int32        `json:"goods_status"`   //商品状态0下架1上架2售空3即将过期4已过期5删除
	Price          float64      `json:"price"`          //默认规格的销售价格
	Specifications string       `json:"specifications"` //规格信息json
	ShopWatermark  string       `json:"shop_watermark"` //图片水印配置信息
	SurplusNum     int32        `json:"surplus_num"`    // 商品库库存数目
	// GoodsSpec    []*DbGoodsSpecification `json:"goods_spec"`    // 商品规格
}

//查看指定商品详细
func LookUpGoodsDetail(_args *DbLookUpGoodsDetail) (reps *DbLookUpGoodsDetailReps, msg string, err error) {
	tb := dbGorm.Table("goods as a").Joins("left join shop_info as b on a.shop_id=b.shop_id").Joins("left join h_goods as c on a.hgs_id=c.hgs_id and a.shop_id=c.shop_id").Select("a.*,b.shop_name,c.hgs_surplusnum as surplus_num")
	tb = tb.Where("(a.goods_id= ? or a.hgs_id=?) and a.goods_status=? ", gconv.Uint64(_args.GoodsID), gconv.Uint64(_args.GoodsID), GDOTS)
	reps = &DbLookUpGoodsDetailReps{}

	dbRes := tb.First(reps)
	if err = dbRes.Error; err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			zaplog.Errorf("LookUpGoodsDetail err=%s", err)
			return nil, "", err
		}
	}
	if dbRes.RowsAffected < 1 {
		return nil, "商品已下架", nil
	}

	//查看图片水印配置
	_watermark, _ := ShopWatermarkAnalysis(reps.ShopID)
	if _watermark != nil && _watermark.IsEnable == 1 {
		reps.ShopWatermark = _watermark.Watermark
	}

	IncreaseFans(nil, &IncreaseFansReq{ShopID: reps.ShopID, UserID: _args.UserID, Category: 0})
	//记录商品访问记录
	AddGoodsAccessRecord(&entity.GoodsAccessRecords{UserID: _args.UserID, GoodsID: gconv.Uint64(_args.GoodsID), ShopID: reps.ShopID})
	return
}

//根据商品id获取所属店铺ID
func GetGoodsIdToShopId(GoodsId string) (shopId uint64) {
	_goods := entity.Goods{}
	if err := dbGorm.Table("goods").Where("goods_id=?", GoodsId).First(&_goods).Error; err == nil {
		shopId = _goods.ShopID
	}
	return
}

//根据店铺ID获取所属店主user信息
func GetShopIdToUserInfo(shopId uint64) (userInfo *entity.User, err error) {
	_shopInfo := entity.ShopInfo{}
	userInfo = &entity.User{}
	if returnData := dbGorm.Table("shop_info").Where("shop_id=?", shopId).First(&_shopInfo); returnData.Error == nil {
		if err = dbGorm.Table("user").Where("user_id=?", _shopInfo.UserID).First(userInfo).Error; err == nil {
			return
		}
	}
	return nil, errors.New("获取用户信息失败")
}

//编辑商品
func EditGoods(_goods *entity.Goods) (err error) {

	tb := dbGorm.Table("shop_category")
	var num int32
	err = tb.Where("category_id=? AND shop_id=?", _goods.CategoryID, _goods.ShopID).Count(&num).Error
	if err != nil || num == 0 {
		zaplog.Errorf("EditGoods db err:%s", err)
		return errors.New("商品类型非法，请联系客服")
	}
	_goods_tmp := &entity.Goods{}
	err = dbGorm.Table("goods").Select("id,hgs_id").Where("goods_id=?", _goods.GoodsID).First(_goods_tmp).Error
	if err != nil || _goods_tmp == nil {
		zaplog.Errorf("EditGoods db err:%s", err)
		return errors.New("商品不存在，请联系客服")
	}
	if _goods_tmp.ID > 0 {
		//老版本修改名称该商品到商品库内
		hInfo := entity.HGoods{}
		err = dbGorm.Table("h_goods").Where("hgs_id=? and hgs_name=? and hgs_status<>?", _goods_tmp.HgsID, _goods.GoodsName, HGDEL).First(&hInfo).Error
		if hInfo.ID == 0 {
			return errors.New("商品名不允许修改，请联系客服")
		}
		if err != nil {
			zaplog.Errorf("EditGoods db err:%s", err)
			return err
		}
	}
	_goods.ID = _goods_tmp.ID
	_goods.HgsID = _goods_tmp.HgsID
	err = dbGorm.Table("goods").Save(_goods).Error
	if err != nil {
		zaplog.Errorf("EditGoods db err:%s", err)
		return err
	}
	return
}

type DbEditScrollInfoIn struct {
	ShopID     uint64 `json:"shop_id" v:"required#不能为空"`     // 商铺ID
	ScrollName string `json:"scroll_name" v:"required#不能为空"` //修改的名称
	ScrollInfo string `json:"scroll_info"`                   //修改后的内容
	Index      int32  `json:"index" v:"required#不能为空"`       //修改的内容索引
}

type DbEditScrollInfoOut struct {
	MainpageScrollInfo string `json:"mainpage_scroll_info"`
}

//编辑滚动信息
func EditScrollInfo(_args *DbEditScrollInfoIn) (out *DbEditScrollInfoOut, err error) {
	var (
		sql    string
		values []interface{}
	)

	if _args.ScrollInfo == "" { //删除
		sql = "update shop_info set mainpage_scroll_info=json_remove(mainpage_scroll_info,?) where shop_id=?"
		values = []interface{}{fmt.Sprintf("$.%s[%d]", _args.ScrollName, _args.Index), _args.ShopID}
	} else { //修改
		sql = "update shop_info set mainpage_scroll_info=json_set(mainpage_scroll_info,?,cast(? as json)) where shop_id=?"
		values = []interface{}{fmt.Sprintf("$.%s[%d]", _args.ScrollName, _args.Index), _args.ScrollInfo, _args.ShopID}
	}

	err = dbGorm.Exec(sql, values...).Error
	if err != nil {
		zaplog.Errorf("EditScrollInfo db err:%s", err)
		return
	}
	out = &DbEditScrollInfoOut{}
	err = dbGorm.Table("shop_info").Select("mainpage_scroll_info").Where("shop_id=?", _args.ShopID).Scan(out).Error
	return
}

//查看分类request
type CategorySeeReq struct {
	Start_Index int `json:"start_index"` //查询起始索引
	Count       int `json:"count"`       //页面列表个数
}

type CategorySeeResp struct {
	CategoryID   uint32 `json:"category_id"`   // 商品分类id
	ShopID       uint64 `json:"shop_id"`       // 店铺ID
	CategoryName string `json:"category_name"` // 分类名称
}

//查看分类
func CategorySee(req *CategorySeeReq, ShopID uint64) (res []*CategorySeeResp, err error) {
	tb := dbGorm.Table("shop_category")
	err = tb.Offset(req.Start_Index).Limit(req.Count).Where("shop_id =?", ShopID).Order("category_sort").Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CategorySee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//增加分类request
type CategoryIncreaseReq struct {
	CategoryName string `json:"category_name"` // 分类名称
}

type CategoryIncreaseresp struct {
	CategorySort uint32 `json:"category_sort"` //排序字段
	CategoryID   uint32 `json:"category_id"`   // 商品分类id
}

//增加分类
func CategoryIncrease(req *CategoryIncreaseReq, ShopID uint64) (msg string, err error) {
	tb := dbGorm.Table("shop_category")
	has, err := dbXorm.Table("shop_category").Where("category_name=? AND shop_id=?", req.CategoryName, ShopID).Exist()
	if !has {
		res := &CategoryIncreaseresp{}
		err = tb.Select("IFNULL(category_sort,0) as category_sort").Where("shop_id =?", ShopID).Order("category_sort desc").First(&res).Error
		err = tb.Select("IFNULL(category_id,0) as category_id").Where("shop_id =?", ShopID).Order("category_id desc").First(&res).Error
		Category := &entity.ShopCategory{}
		Category.CategoryID = res.CategoryID + 1
		Category.ShopID = ShopID
		Category.CategoryName = req.CategoryName
		Category.CategorySort = res.CategorySort + 1
		err = tb.Create(Category).Error
		if err != nil {
			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
			zaplog.Errorf(err.Error())
			return "", err
		}
	} else {
		return "请勿重复添加已有分类!", err
	}

	return "", err
}

//编辑分类request
type CategoryUpdateReq struct {
	CategoryID   uint32 `json:"category_id"`   // 商品分类id
	CategoryName string `json:"category_name"` // 分类名称
}

//编辑分类
func CategoryUpdate(req *CategoryUpdateReq, ShopID uint64) (err error) {
	tb := dbGorm.Table("shop_category")
	err = tb.Where("category_id=? AND shop_id=?", req.CategoryID, ShopID).Update(map[string]interface{}{"category_name": req.CategoryName}).Error
	if err != nil {
		err = fmt.Errorf("CategoryUpdate Db err:%s", err)
		zaplog.Errorf(err.Error())
		return err
	}
	return err
}

//删除分类request
type CategoryDeleteReq struct {
	CategoryID uint32 `json:"category_id"` // 商品分类id
}

type CategoryDeleteResp struct {
	CategoryID uint32 `json:"category_id"` // 商品分类id
}

//是否可以删除分类
func IsCategoryDelete(req *CategoryDeleteReq, ShopID uint64) bool {
	has, err := dbXorm.Table("goods").Where("shop_id=? AND category_id=? AND goods_status != 0  AND goods_status != 5", ShopID, req.CategoryID).Exist()
	if has {
		err = fmt.Errorf("IsCategoryDelete Db err:%s", err)
		zaplog.Errorf(err.Error())
		return false
	}
	return true
}

//删除分类
func CategoryDelete(req *CategoryDeleteReq, ShopID uint64) (res *CategoryDeleteResp, err error) {
	tb := dbGorm.Table("shop_category")
	res = &CategoryDeleteResp{}
	res.CategoryID = req.CategoryID
	err = tb.Where("category_id = ? AND shop_id=?", req.CategoryID, ShopID).Delete(res).Error
	if err != nil {
		return res, err
	}
	return res, err
}

//分类排序request
type CategorySortReq struct {
	Category []*CategoryInfoSort `json:"category"`
}

type CategoryInfoSort struct {
	CategoryID   uint32 `json:"category_id"`   // 商品分类id
	CategorySort uint32 `json:"category_sort"` //排序字段
}

//分类排序
func CategorySort(req *CategorySortReq, ShopID uint64) (err error) {
	tb := dbGorm.Table("shop_category")
	for _, v := range req.Category {
		err = tb.Where("category_id=? AND shop_id=?", v.CategoryID, ShopID).Update(map[string]interface{}{"category_sort": v.CategorySort}).Error
		if err != nil {
			err = fmt.Errorf("CategorySort Db err:%s", err)
			zaplog.Errorf(err.Error())
			return err
		}
	}
	return err
}

type CategoryNameResp struct {
	CategoryID   int32  `json:"category_id"`   // 商品分类id
	CategoryName string `json:"category_name"` // 分类名称
}

//商品分类名称和id
func CategoryName(ShopID uint64) (res []*CategoryNameResp, err error) {
	tb := dbGorm.Table("shop_category")
	err = tb.Where("shop_id =?", ShopID).Order("category_sort").Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CategoryName Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//根据指定分类id查询分类名称request
type CategoryNameSeeReq struct {
	CategoryID int32 `json:"category_id"` // 商品分类id
}

type CategoryNameSeeResp struct {
	CategoryName string `json:"category_name"` // 分类名称
}

//根据指定分类id查询分类名称
func CategoryNameSee(req *CategoryNameSeeReq, ShopID uint64) (res *CategoryNameSeeResp, err error) {
	tb := dbGorm.Table("shop_category")
	res = &CategoryNameSeeResp{}
	err = tb.Where("shop_id =? AND category_id=?", ShopID, req.CategoryID).Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CategoryNameSee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

// //增加分类request
// type CategoryIncreaseReq struct {
// 	CategoryName string `json:"category_name"` // 分类名称
// }

// type CategoryIncreaseresp struct {
// 	CategoryID   int32  `json:"category_id"`   // 分类id
// 	CategorySort uint32 `json:"category_sort"` //排序字段
// 	CategoryInfo string `json:"category_info"` // 用户分类信息
// }

// //增加分类
// func CategoryIncrease(req *CategoryIncreaseReq, ShopID uint64) (msg string, err error) {
// 	tb := dbGorm.Table("goods_category")
// 	res := &CategoryIncreaseresp{}
// 	has, err := dbXorm.Table("goods_category").Where("category_name=?", req.CategoryName).Exist()
// 	if !has {
// 		err = tb.Select("IFNULL(category_id,0)").Order("category_id desc").First(&res).Error
// 		GoodsCategory := &entity.GoodsCategory{}
// 		GoodsCategory.CategoryID = res.CategoryID + 1
// 		GoodsCategory.CategoryName = req.CategoryName
// 		err = dbGorm.Table("goods_category").Create(GoodsCategory).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		err = dbGorm.Table("shop_info").Select("category_info").Where("shop_id=?", ShopID).Scan(&res).Error
// 		res.CategoryInfo = res.CategoryInfo + "[" + string(res.CategoryID+1) + "]"
// 		//存入shop_info表中
// 		if dbResult := dbGorm.Table("shop_info").Where("shop_id=?", ShopID).Update("category_info", res.CategoryInfo); dbResult.Error != nil {
// 			return "", dbResult.Error
// 		}
// 	} else {
// 		err := dbGorm.Table("goods_category").Select("category_id").Where("category_name=?", req.CategoryName).Scan(&res).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		err = dbGorm.Table("shop_info").Select("category_info").Where("shop_id=?", ShopID).Scan(&res).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		categoryInfoDb := make([]int32, 0)
// 		err = jsoniter.Unmarshal([]byte(res.CategoryInfo), &categoryInfoDb)
// 		if err != nil {
// 			zaplog.Errorf("GetRecommendShop, err=%s", err)
// 			return "", err
// 		}
// 		var IsExistence bool = false
// 		for i := 0; i < len(categoryInfoDb); i++ {
// 			if res.CategoryID == categoryInfoDb[i] {
// 				IsExistence = true
// 			}
// 		}
// 		if IsExistence {
// 			return "请勿重复添加已有分类!", err
// 		} else {
// 			res.CategoryInfo = res.CategoryInfo + "[" + string(res.CategoryID) + "]"
// 			//存入shop_info表中
// 			if dbResult := dbGorm.Table("shop_info").Where("shop_id=?", ShopID).Update("category_info", res.CategoryInfo); dbResult.Error != nil {
// 				return "", dbResult.Error
// 			}
// 		}
// 	}
// 	return "", err
// }

// //编辑分类request
// type CategoryUpdateReq struct {
// 	CategoryName string `json:"category_name"` // 分类名称
// }

// //编辑分类
// func CategoryUpdate(req *CategoryUpdateReq, ShopID uint64) (msg string, err error) {
// 	tb := dbGorm.Table("goods_category")
// 	res := &CategoryIncreaseresp{}
// 	has, err := dbXorm.Table("goods_category").Where("category_name=?", req.CategoryName).Exist()
// 	if !has {
// 		err = tb.Select("IFNULL(category_id,0)").Order("category_id desc").First(&res).Error
// 		GoodsCategory := &entity.GoodsCategory{}
// 		GoodsCategory.CategoryID = res.CategoryID + 1
// 		GoodsCategory.CategoryName = req.CategoryName
// 		err = dbGorm.Table("goods_category").Create(GoodsCategory).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		err = dbGorm.Table("shop_info").Select("category_info").Where("shop_id=?", ShopID).Scan(&res).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		categoryInfoDb := make([]int32, 0)
// 		err = jsoniter.Unmarshal([]byte(res.CategoryInfo), &categoryInfoDb)
// 		if err != nil {
// 			zaplog.Errorf("GetRecommendShop, err=%s", err)
// 			return "", err
// 		}
// 		for i := 0; i < len(categoryInfoDb); i++ {
// 			if res.CategoryID == categoryInfoDb[i] {
// 				categoryInfoDb[i] = res.CategoryID + 1
// 			}
// 		}
// 		jsonBytes, err := jsoniter.Marshal(categoryInfoDb)
// 		if err != nil {
// 			fmt.Println(err)
// 		}
// 		str := string(jsonBytes)
// 		//存入shop_info表中
// 		if dbResult := dbGorm.Table("shop_info").Where("shop_id=?", ShopID).Update("category_info", str); dbResult.Error != nil {
// 			return "", dbResult.Error
// 		}
// 	} else {
// 		err := dbGorm.Table("goods_category").Select("category_id").Where("category_name=?", req.CategoryName).Scan(&res).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		err = dbGorm.Table("shop_info").Select("category_info").Where("shop_id=?", ShopID).Scan(&res).Error
// 		if err != nil {
// 			err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 			zaplog.Errorf(err.Error())
// 			return "", err
// 		}
// 		categoryInfoDb := make([]int32, 0)
// 		err = jsoniter.Unmarshal([]byte(res.CategoryInfo), &categoryInfoDb)
// 		if err != nil {
// 			zaplog.Errorf("GetRecommendShop, err=%s", err)
// 			return "", err
// 		}
// 		var IsExistence bool = false
// 		for i := 0; i < len(categoryInfoDb); i++ {
// 			if res.CategoryID == categoryInfoDb[i] {
// 				IsExistence = true
// 			}
// 		}
// 		if IsExistence {
// 			return "请勿重复添加已有分类!", err
// 		} else {
// 			for i := 0; i < len(categoryInfoDb); i++ {
// 				if res.CategoryID == categoryInfoDb[i] {
// 					categoryInfoDb[i] = res.CategoryID
// 				}
// 			}
// 			jsonBytes, err := jsoniter.Marshal(categoryInfoDb)
// 			if err != nil {
// 				fmt.Println(err)
// 			}
// 			str := string(jsonBytes)
// 			//存入shop_info表中
// 			if dbResult := dbGorm.Table("shop_info").Where("shop_id=?", ShopID).Update("category_info", str); dbResult.Error != nil {
// 				return "", dbResult.Error
// 			}
// 		}
// 	}
// 	return "", err
// }

// //删除分类request
// type CategoryDeleteReq struct {
// 	CategoryID uint32 `json:"category_id"` // 商品分类id
// }

// type CategoryDeleteResp struct {
// 	CategoryID uint32 `json:"category_id"` // 商品分类id
// }

// //删除分类
// func CategoryDelete(req *CategoryDeleteReq, ShopID uint64) (res *CategoryDeleteResp, err error) {
// 	resp := &CategoryIncreaseresp{}
// 	res.CategoryID = req.CategoryID
// 	err = dbGorm.Table("shop_info").Select("category_info").Where("shop_id=?", ShopID).Scan(&resp).Error
// 	if err != nil {
// 		err = fmt.Errorf("CategoryIncrease Db err:%s", err)
// 		zaplog.Errorf(err.Error())
// 		return nil, err
// 	}
// 	categoryInfoDb := make([]uint32, 0)
// 	err = jsoniter.Unmarshal([]byte(resp.CategoryInfo), &categoryInfoDb)
// 	if err != nil {
// 		zaplog.Errorf("GetRecommendShop, err=%s", err)
// 		return nil, err
// 	}
// 	category := make([]uint32, 0)
// 	var j int = 0
// 	for i := 0; i < len(categoryInfoDb); i++ {
// 		if req.CategoryID != categoryInfoDb[i] {
// 			category[j] = categoryInfoDb[i]
// 			j++
// 		}
// 	}
// 	jsonBytes, err := jsoniter.Marshal(category)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	str := string(jsonBytes)
// 	//存入shop_info表中
// 	if dbResult := dbGorm.Table("shop_info").Where("shop_id=?", ShopID).Update("category_info", str); dbResult.Error != nil {
// 		return nil, dbResult.Error
// 	}
// 	return res, err
// }
