package mainpage

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/personal"
	"daigou/app/service/user/sessionman"
	"daigou/library/redis"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	jsoniter "github.com/json-iterator/go"
)

type GetMainPageBaseInfoReq struct {
	model.GetMainPageBaseInfoIn
}

//分类信息
type GetMainPageBaseInfoResp1 struct {
	CategoryID   int32  `json:"category_id"`   //分类id
	CategoryName string `json:"category_name"` //分类名称
}

type GetMainPageBaseInfoResp2 struct {
	*entity.ShopInfo_ScrollInfo
	VipCode      int32  `json:"vipCode"`                 //限制次数
	DefaultImage string `json:"default_image,omitempty"` //默认图片`
}

type NewGetMainPageBaseInfoResp2 struct {
	*entity.ShopInfo_ScrollInfo_New
	VipCode      int32  `json:"vipCode"`                 //限制次数
	DefaultImage string `json:"default_image,omitempty"` //默认图片`
}

type GetMainPageBaseInfoResp struct {
	ShopInfo     *model.GetMainPageBaseInfoOut1 `json:"shop_info"`     //店铺信息
	CategoryInfo []*GetMainPageBaseInfoResp1    `json:"category_info"` //分类信息
	ScrollInfo   *GetMainPageBaseInfoResp2      `json:"scroll_info"`   //滚动信息
}

func getScrollInfo(_arg string, session *ghttp.Session) (out *GetMainPageBaseInfoResp2, err error) {
	out = &GetMainPageBaseInfoResp2{}
	//查询vip权益
	vipexplain, err := personal.ShopVipExplain(2, session)
	if err != nil {
		return
	}
	if vipexplain.Explain == -1 {
		if _arg != "" {
			err = jsoniter.Unmarshal([]byte(_arg), &out.ShopInfo_ScrollInfo)
			if err != nil {
				return nil, err
			}

		}

		//如果没有自定义信息就显示默认信息
		if nil == out.ShopInfo_ScrollInfo || len(out.ShopInfo_ScrollInfo.TravelInfo) == 0 {
			out.DefaultImage, err = redis.GetSystemConfigValue("mainpage_scroll_image")
			if err != nil {
				return nil, err
			}
		}
	} else {
		out.DefaultImage, err = redis.GetSystemConfigValue("mainpage_scroll_image")
		if err != nil {
			return nil, err
		}
	}

	return
}

func NewgetScrollInfo(_arg string, session *ghttp.Session) (out *NewGetMainPageBaseInfoResp2, err error) {
	out = &NewGetMainPageBaseInfoResp2{}
	//查询vip权益
	vipexplain, err := personal.ShopVipExplain(2, session)
	if err != nil {
		return
	}
	if vipexplain.Explain == -1 {
		if _arg != "" {
			err = jsoniter.Unmarshal([]byte(_arg), &out.ShopInfo_ScrollInfo_New)
			if err != nil {
				return nil, err
			}

		}
		out.DefaultImage, err = redis.GetSystemConfigValue("mainpage_scroll_image")
		if err != nil {
			return nil, err
		}
	} else {
		out.DefaultImage, err = redis.GetSystemConfigValue("mainpage_scroll_image")
		if err != nil {
			return nil, err
		}
	}

	return
}

//获取系统配置的分类信息
func getSystemCategoryInfo() (out []*GetMainPageBaseInfoResp1, err error) {
	goodsCategory, err := redis.GetGoodsCategory()
	if err != nil {
		zaplog.Errorf("GetMainPageBaseInfo err=%s", err)
		return nil, err
	}
	out = make([]*GetMainPageBaseInfoResp1, 0, len(goodsCategory))
	//解析分类信息
	for k, v := range goodsCategory {
		out = append(out, &GetMainPageBaseInfoResp1{CategoryID: k, CategoryName: v})
	}
	return
}

//获取首页基本信息
func GetMainPageBaseInfo(_req *GetMainPageBaseInfoReq, session *ghttp.Session) (resp *GetMainPageBaseInfoResp, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "获取首页数据失败"
		}
	}()
	goodsCategory, err := redis.GetGoodsCategory()
	if err != nil {
		zaplog.Errorf("GetMainPageBaseInfo err=%s", err)
		return
	}

	baseInfo, err := model.GetMainPageBaseInfo(&(_req.GetMainPageBaseInfoIn))
	if err != nil {
		zaplog.Errorf("GetMainPageBaseInfo err=%s", err)
		return
	}

	//解析分类信息
	categoryInfo := make([]*GetMainPageBaseInfoResp1, 0, len(goodsCategory))
	categoryInfoDb := make(entity.ShopInfo_CategoryInfo, 0, len(goodsCategory))
	if baseInfo.CategoryInfo != "" {
		err = jsoniter.Unmarshal([]byte(baseInfo.CategoryInfo), &categoryInfoDb)
		if err != nil {
			zaplog.Errorf("GetMainPageBaseInfo, err=%s", err)
			return
		}
		for _, id := range categoryInfoDb {
			categoryInfo = append(categoryInfo, &GetMainPageBaseInfoResp1{CategoryID: id, CategoryName: goodsCategory[id]})
		}
	}

	//解析滚动信息
	scrollInfo, err := getScrollInfo(baseInfo.MainpageScrollInfo, session)
	if err != nil {
		zaplog.Errorf("GetMainPageBaseInfo, err=%s", err)
		return
	}

	resp = &GetMainPageBaseInfoResp{
		ShopInfo:     &baseInfo.GetMainPageBaseInfoOut1,
		CategoryInfo: categoryInfo,
		ScrollInfo:   scrollInfo,
	}

	return
}

type GetMainPageShopInfoReq struct {
	ShopID uint64 `json:"shop_id"  v:"shop_id@required#商铺信息不能为空"`
}
type GetMainPageShopInfoResp struct {
	*model.GetMainPageShopInfoOut
}

//获取首页商店信息
func GetMainPageShopInfo(_req *GetMainPageShopInfoReq, session *ghttp.Session) (resp *GetMainPageShopInfoResp, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "商铺信息为空"
		}
	}()

	res1, err := model.GetMainPageShopInfo(&model.GetMainPageShopInfoIn{ShopID: _req.ShopID, UserID: sessionman.GetUserInfo(session).UserID})
	if err != nil {
		zaplog.Errorf("GetMainPageShopInfo err=%s", err)
		return
	}
	resp = &GetMainPageShopInfoResp{GetMainPageShopInfoOut: res1}
	return
}

//获取首页分类信息
func GetMainPageCategoryInfo(_req *GetMainPageBaseInfoReq) (resp []*GetMainPageBaseInfoResp1, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "分类信息为空"
		}
	}()
	resp = make([]*GetMainPageBaseInfoResp1, 0)

	res, err := model.CategoryName(uint64(_req.ShopID))
	if err != nil {
		return nil, "", err
	}
	categoryInfo := make([]*GetMainPageBaseInfoResp1, 0, len(res))

	for _, id := range res {
		categoryInfo = append(categoryInfo, &GetMainPageBaseInfoResp1{CategoryID: id.CategoryID, CategoryName: id.CategoryName})
	}

	resp = categoryInfo

	return
}

//获取首页行程滚动信息
func GetMainPageScrollInfo(_req *GetMainPageBaseInfoReq, session *ghttp.Session) (resp *GetMainPageBaseInfoResp2, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "行程查看为空"
		}
	}()
	//查询vip权益
	vipexplain, err := personal.ShopVipExplain(2, session)
	if err != nil {
		return
	}
	baseInfo, err := model.GetMainPageBaseInfo(&(_req.GetMainPageBaseInfoIn))
	if err != nil {
		zaplog.Errorf("GetMainPageScrollInfo err=%s", err)
		return
	}

	//解析滚动信息
	scrollInfo, err := getScrollInfo(baseInfo.MainpageScrollInfo, session)
	if err != nil {
		zaplog.Errorf("GetMainPageScrollInfo, err=%s", err)
		return
	}
	scrollInfo.VipCode = vipexplain.Explain
	resp = scrollInfo

	return
}

//获取首页行程滚动信息(新)
func NewGetMainPageScrollInfo(_req *GetMainPageBaseInfoReq, session *ghttp.Session) (resp *NewGetMainPageBaseInfoResp2, msg string, err error) {
	defer func() {
		if err != nil {
			msg = "行程查看为空"
		}
	}()
	//查询vip权益
	vipexplain, err := personal.ShopVipExplain(2, session)
	if err != nil {
		return
	}
	baseInfo, err := model.GetMainPageBaseInfo(&(_req.GetMainPageBaseInfoIn))
	if err != nil {
		zaplog.Errorf("GetMainPageScrollInfo err=%s", err)
		return
	}

	//解析滚动信息
	scrollInfo, err := NewgetScrollInfo(baseInfo.MainpageScrollInfo, session)
	if err != nil {
		zaplog.Errorf("GetMainPageScrollInfo, err=%s", err)
		return
	}
	scrollInfo.VipCode = vipexplain.Explain
	resp = scrollInfo

	return
}
