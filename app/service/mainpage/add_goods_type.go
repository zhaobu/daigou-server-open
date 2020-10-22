package mainpage

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/user/sessionman"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
)

//商品规格
type GoodsSpecification struct {
	SpID       int64   `json:"sp_id"`       //规格编号
	Name       string  `json:"name"`        // 规格名称
	InputPrice float64 `json:"input_price"` // 入库价格
	ShopPrice  float64 `json:"shop_price"`  // 销售价格
	StockNum   int32   `json:"stock_num"`   // 库存数量
}

//商品图片
type GoodsImgUrlReq struct {
	ImgUrl []string `json:"img_url"`
}

// 新增商品参数
type AddGoodsTypeReq struct {
	HgsId          uint64    `json:"hgs_id"  v:"required"`         // 商品库id
	GoodsStatus    int32     `json:"goods_status"  v:"required"`   // 商品状态0下架1上架
	GoodsSource    string    `json:"goods_source"  v:"required"`   // 商品来源地
	ProducedTime   time.Time `json:"produced_time"`                //生产时间
	OverInfo       string    `json:"over_info"`                    //过期信息
	EsDeTime       *string   `json:"es_de_time"`                   //预计发货时间 时间范围
	GoodsName      string    `json:"goods_name"`                   // 商品名字
	CategoryId     int32     `json:"category_id"  v:"required"`    // 分类
	GoodsImgUrl    string    `json:"goods_img_url"`                // 商品图片（oss链接，一次性加载多张图片）
	GoodsComment   string    `json:"goods_comment"`                // 商品说明
	Price          float64   `json:"price"  v:"required"`          // 商品默认价格
	Specifications string    `json:"specifications" v:"required" ` //规格信息json  example:"[{\"sp_id\":1,\"input_price\": 10.99,\"name\": \"大力丸\",\"shop_price\": 15.98,\"stock_num\": 119}]"
}

type AddGoodsTypeResp struct {
}

//搜索商品请求
type SearchGoodsReq struct {
	model.DbSearchGoodsReq
}

//搜索商品回应
type SearchGoodsReps struct {
	Page      uint32                     `json:"page"`       //页数
	GoodsInfo []*model.DbGetGoodsInfoOut `json:"goods_info"` //商品信息
}

//单指令操作商品请求
type SingleCmdEditGoodsReq struct {
	model.DbSingleCmdEditGoodsReq
}

//查看指定商品详细信息
type LookUpGoodsDetailReq struct {
	GoodsId string `json:"goods_id" v:"required"` //商品id 前端务必传字符串
}

//编辑商品
type EditGoodsTypeReq struct {
	GoodsId        string    `json:"goods_id" v:"required"`       // 商品ID
	GoodsStatus    int32     `json:"goods_status" v:"required"`   // 商品状态0下架1上架
	GoodsSource    string    `json:"goods_source"`                // 商品来源地
	ProducedTime   time.Time `json:"produced_time"`               // 生产时间
	OverInfo       string    `json:"over_info"`                   // 过期信息
	EsDeTime       *string   `json:"es_de_time"`                  //预计发货时间 时间范围
	GoodsName      string    `json:"goods_name" v:"required"`     // 商品名字
	CategoryId     int32     `json:"category_id" v:"required"`    // 分类
	GoodsImgUrl    string    `json:"goods_img_url"`               // 商品图片（oss链接，一次性加载多张图片）
	GoodsComment   string    `json:"goods_comment"`               // 商品说明
	Price          float64   `json:"price" v:"required"`          // 商品默认价格
	Specifications string    `json:"specifications" v:"required"` //规格信息json
}

func AddGoodsType(req *AddGoodsTypeReq, session *gsession.Session) (resp *AddGoodsTypeResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "增加商品失败"
		}
	}()
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限增加商品"
		return
	}
	goods := &entity.Goods{
		HgsID:        req.HgsId,
		GoodsID:      utils.GenUniqueID(),
		ShopID:       _shopId,
		GoodsStatus:  req.GoodsStatus,
		CategoryID:   req.CategoryId,
		GoodsName:    req.GoodsName,
		GoodsComment: null.StringFrom(req.GoodsComment),
		GoodsImgURL:  null.StringFrom(req.GoodsImgUrl),
		InputTime:    &entity.Time{Time: time.Now()},
		AddTime: func() *entity.Time {
			if req.GoodsStatus == 1 {
				return &entity.Time{Time: time.Now()}
			}
			return nil
		}(), //商品状态0下架1上架2售空3即将过期4已过期5删除
		DownTime: func() *entity.Time {
			if req.GoodsStatus == 0 {
				return &entity.Time{Time: time.Now()}
			}
			return nil
		}(),
		ProducedTime:   &entity.Time{Time: req.ProducedTime},
		OverInfo:       null.StringFrom(req.OverInfo),
		GoodsSource:    null.StringFrom(req.GoodsSource),
		Price:          req.Price,
		Specifications: req.Specifications,
	}
	//判断预计发货时间
	if req.EsDeTime != nil {
		goods.EsDeTime = null.StringFrom(*req.EsDeTime)
	}
	if msg, err = model.AddGoodsType(goods); err != nil {
		err = fmt.Errorf("新增商品失败,%s", err)
		zaplog.Errorf("AddGoodsType err=%s", err)
		return
	}

	return
}

//搜索商品
func Search(req *SearchGoodsReq, session *gsession.Session) (resp *SearchGoodsReps, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "搜索商品失败"
		}
	}()

	//获取每种商品分类的信息
	goodsInfo, err := model.GetSearchGoodsInfo(&req.DbSearchGoodsReq, sessionman.GetUserInfo(session).UserID) //
	if err != nil {
		err = fmt.Errorf("搜索商品失败,%s", err)
		zaplog.Errorf("Search err=%s", err)
		return
	}

	for k, _goods := range goodsInfo {
		if respParse, errTemp := gjson.DecodeToJson(_goods.GoodsImgURL.String); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			goodsInfo[k].GoodsImgURL = null.StringFrom(default_img_str[0]) //只取默认封面图片
		}
	}

	resp = &SearchGoodsReps{
		Page:      req.Page,
		GoodsInfo: goodsInfo,
	}

	return
}

//单指令操作商品
func SingleCmdEditGoods(req *SingleCmdEditGoodsReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "操作失败"
		}
	}()
	var _shopId uint64
	if req.GoodsID != "" {
		_shopId = model.GetGoodsIdToShopId(req.GoodsID)
	}
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限操作商品"
		return
	}
	err = model.SingleCmdEditGoods(&req.DbSingleCmdEditGoodsReq, _shopId)
	if err != nil {
		err = fmt.Errorf("操作商品失败,%s", err)
		zaplog.Errorf("SingleCmdEditGoods err=%s", err)
		return
	}
	return
}

//查看指定商品详情
func LookUpGoodsDetail(req *LookUpGoodsDetailReq, session *gsession.Session) (resp *model.DbLookUpGoodsDetailReps, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "查看失败"
		}
	}()

	resp, msg, err = model.LookUpGoodsDetail(&model.DbLookUpGoodsDetail{UserID: sessionman.GetUserInfo(session).UserID, GoodsID: gconv.Uint64(req.GoodsId)})
	if err != nil {
		err = fmt.Errorf("查看指定商品详情失败,%s", err)
		zaplog.Errorf("LookUpGoodsDetail err=%s", err)
		return
	}
	return
}

//编辑商品
func EditGoods(req *EditGoodsTypeReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil {
			msg = "编辑失败"
		}
	}()

	var _shopId uint64
	if req.GoodsId != "" {
		_shopId = model.GetGoodsIdToShopId(req.GoodsId)
	}
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限编辑商品"
		return
	}

	goods := &entity.Goods{
		GoodsID:      gconv.Uint64(req.GoodsId),
		ShopID:       _shopId,
		GoodsStatus:  req.GoodsStatus,
		CategoryID:   req.CategoryId,
		GoodsName:    req.GoodsName,
		GoodsImgURL:  null.StringFrom(req.GoodsImgUrl),
		GoodsComment: null.StringFrom(req.GoodsComment),
		InputTime:    &entity.Time{Time: time.Now()},
		AddTime: func() *entity.Time {
			if req.GoodsStatus == 1 {
				return &entity.Time{Time: time.Now()}
			}
			return nil
		}(), //商品状态0下架1上架2售空3即将过期4已过期5删除
		DownTime: func() *entity.Time {
			if req.GoodsStatus == 0 {
				return &entity.Time{Time: time.Now()}
			}
			return nil
		}(), //商品状态0下架1上架2售空3即将过期4已过期5删除
		ProducedTime:   &entity.Time{Time: req.ProducedTime},
		OverInfo:       null.StringFrom(req.OverInfo),
		GoodsSource:    null.StringFrom(req.GoodsSource),
		Price:          req.Price,
		Specifications: req.Specifications,
	}
	if req.EsDeTime != nil {
		goods.EsDeTime = null.StringFrom(*req.EsDeTime)
	}

	if err = model.EditGoods(goods); err != nil {
		err = fmt.Errorf("编辑商品失败,%s", err)
		zaplog.Errorf("EditGoods err=%s", err)
		return
	}
	return
}
