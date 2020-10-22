package mainpage

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
)

type GetPageInfoReq struct {
	model.DbGetPageInfoIn
}

//分页详情
type GetPageInfoResp struct {
	CategoryID   int32               `json:"category_id"`   //分类id
	CategoryName string              `json:"category_name"` //分类名称
	Page         uint32              `json:"page"`          //页数
	GoodsInfo    []*DbGetPageInfoOut `json:"goods_info"`    //商品信息
}

//首页商品列表信息
type DbGetPageInfoOut struct {
	GoodsName   string      `json:"goods_name"`    //商品名字
	GoodsImgURL null.String `json:"goods_img_url"` //商品图片
	GoodsSource null.String `json:"goods_source"`  //商品来源
	GoodsID     string      `json:"goods_id"`      //商品id
	GoodsStatus int32       `json:"goods_status"`  //商品状态0下架1上架2售空3即将过期4已过期5删除
	Price       float64     `gorm:"column:price;type:udecimal;" json:"price"`
}

//商品详情信息
type DbGetGoodsInfoOut struct {
	GoodsName    string       `json:"goods_name"`    //商品名字
	GoodsComment null.String  `json:"goods_comment"` //商品说明
	GoodsImgURL  null.String  `json:"goods_img_url"` //商品图片
	ProducedTime *entity.Time `json:"produced_time"` //生产时间
	OverInfo     null.String  `json:"over_info"`     //过期信息
	GoodsSource  null.String  `json:"goods_source"`  //商品来源
	GoodsID      string       `json:"goods_id"`      //商品id
	GoodsStatus  int32        `json:"goods_status"`  //商品状态0下架1上架2售空3即将过期4已过期5删除
	Price        float64      `gorm:"column:price;type:udecimal;" json:"price"`
}

//获取分页信息
func GetPageInfo(_req *GetPageInfoReq, session *ghttp.Session) (resp *GetPageInfoResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "商品查看为空"
		}
	}()

	var goodsInfo []*model.ModelDbGetPageInfoOut
	//获取商品列表
	goodsInfo, err = model.GetPageInfo(&_req.DbGetPageInfoIn, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		zaplog.Errorf("GetPageInfo err=%s", err)
		return
	}
	resp = &GetPageInfoResp{
		CategoryID: _req.DbGetPageInfoIn.QueryType,
		Page:       _req.Page,
		GoodsInfo:  []*DbGetPageInfoOut{},
	}
	for k, _goods := range goodsInfo {
		if respParse, errTemp := gjson.DecodeToJson(_goods.GoodsImgURL.String); errTemp == nil {
			default_img_str := gconv.Strings(respParse.Value())
			goodsInfo[k].GoodsImgURL = null.StringFrom(default_img_str[0]) //只取默认封面图片
		}
	}
	resp.GoodsInfo = make([]*DbGetPageInfoOut, len(goodsInfo))
	for k, _data := range goodsInfo {
		resp.GoodsInfo[k] = &DbGetPageInfoOut{
			GoodsName:   _data.GoodsName,
			GoodsImgURL: _data.GoodsImgURL,
			GoodsSource: _data.GoodsSource,
			GoodsID:     _data.GoodsID,
			GoodsStatus: _data.GoodsStatus,
			Price:       _data.Price,
		}
	}
	// if err = gconv.Structs(gconv.Maps(goodsInfo), &resp.GoodsInfo); err != nil {
	// 	return
	// }
	if 0 == _req.DbGetPageInfoIn.QueryType {
		resp.CategoryName = "全部"
	} else {
		//获取分类信息
		goodsCategory, err := model.CategoryNameSee(&model.CategoryNameSeeReq{CategoryID: _req.DbGetPageInfoIn.QueryType}, sessionman.GetUserInfo(session).ShopID)
		if err != nil {
			zaplog.Errorf("GetPageInfo err=%s", err)
			msg = "此分类不存在"
			return nil, "", err
		}
		resp.CategoryName = goodsCategory.CategoryName
	}

	return
}
