package mainpage

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gsession"
)

type EditClassifyReq struct {
	// ShopID     uint64  `json:"shop_id" v:"required#不能为空"`     // 商铺ID
	CategoryID []int32 `json:"category_id" v:"required#不能为空"` //分类id
}

type EditClassifyResp struct {
	CategoryID []int32 `json:"category_id"` //分类id
}

// //查看配置分类请求
// type CheckCfgClassifyReq struct {
// 	ShopID uint64 `json:"shop_id" v:"required"` // 商铺ID
// }

//查看配置分类信息应答
type CheckCfgClassifyResp struct {
	CategoryInfoCfg []*GetMainPageBaseInfoResp1 `json:"category_info_cfg"`
}

//编辑分类
func EditClassify(req *EditClassifyReq, session *ghttp.Session) (resp *EditClassifyResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "编辑失败"
		}
	}()
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId == 0 {
		msg = "无权限编辑分类"
		return
	}
	if err = model.EditClassify(_shopId, req.CategoryID); err != nil {
		zaplog.Errorf("EditClassify err=%s", err)
		return
	}
	resp = &EditClassifyResp{
		CategoryID: req.CategoryID,
	}
	return
}

//查看配置分类信息
func CheckCfgClassify(session *gsession.Session) (resp *CheckCfgClassifyResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "查看失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限查看分类"
		return
	}
	resp = &CheckCfgClassifyResp{}
	resp.CategoryInfoCfg, err = getSystemCategoryInfo()
	return
}

type CategoryInfoSee struct {
	AllCount int                      `json:"all_count"` //分类个数
	Category []*model.CategorySeeResp `json:"see_address"`
}

//查看分类
func CategorySee(req *model.CategorySeeReq, session *gsession.Session) (resp *CategoryInfoSee, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "查看失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限查看分类"
		return
	}
	category, err := model.CategorySee(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		msg = "查询分类失败"
		return
	}
	categorysee := make([]*model.CategorySeeResp, 0)
	categorysee = append(categorysee, category...)
	zaplog.Infof("查看分类:%v", categorysee)
	resp = &CategoryInfoSee{
		AllCount: len(category),
		Category: categorysee,
	}
	return
}

//增加分类
func CategoryIncrease(req *model.CategoryIncreaseReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "增加分类失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限增加分类"
		return
	}
	msg, err = model.CategoryIncrease(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		msg = "增加分类失败"
		return
	}
	return
}

//编辑分类
func CategoryUpdate(req *model.CategoryUpdateReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "编辑分类失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限编辑分类"
		return
	}
	err = model.CategoryUpdate(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		msg = "编辑分类失败"
		return
	}
	return
}

//删除分类
func CategoryDelete(req *model.CategoryDeleteReq, session *gsession.Session) (resp *model.CategoryDeleteResp, msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "删除分类失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限删除分类"
		return
	}
	if !model.IsCategoryDelete(req, sessionman.GetUserInfo(session).ShopID) {
		msg = "请先下架分类下的商品，才可删除分类"
		return
	}
	resp, err = model.CategoryDelete(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		msg = "删除分类失败"
		return
	}
	return
}

//分类排序
func CategorySort(req *model.CategorySortReq, session *gsession.Session) (msg string, err error) {
	defer func() {
		if err != nil && msg == "" {
			msg = "分类排序失败"
		}
	}()
	if !sessionman.IsShopOwner(session, uint64(sessionman.GetUserInfo(session).UserID)) {
		msg = "无权限分类排序"
		return
	}
	err = model.CategorySort(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		msg = "分类排序失败"
		return
	}
	return
}
