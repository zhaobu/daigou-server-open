package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SeeFollowShopInfo struct {
	FollowCount   int                       `json:"all_count"`
	SeeFollowShop []*model.SeeFollowShoResp `json:"see_follow_shop"`
}

//查看关注的店铺
func SeeFollowShop(req *model.SeeFollowShopReq, session *ghttp.Session) (resp *SeeFollowShopInfo, err error) {
	follow, bingfans, err := model.SeeFollowShop(req, sessionman.GetUserInfo(session).UserID)
	for i := 0; i < len(follow); i++ {
		if follow[i].ShopID == bingfans.BindShopID {
			follow[i].ShopStatus = 1
		}
	}
	shop := make([]*model.SeeFollowShoResp, 0)
	shop = append(shop, follow...)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("查看关注的店铺:%s", follow)
	resp = &SeeFollowShopInfo{
		FollowCount:   len(follow),
		SeeFollowShop: shop,
	}

	return
}

type SearchFollowShopInfo struct {
	FollowCount      int                          `json:"all_count"`
	SearchFollowShop []*model.SearchFollowShoResp `json:"see_follow_shop"`
}

//搜索关注的店铺
func SearchFollowShop(req *model.SearchFollowShopReq, session *ghttp.Session) (resp *SearchFollowShopInfo, err error) {
	follow, bingfans, err := model.SearchFollowShop(req, sessionman.GetUserInfo(session).UserID)
	for i := 0; i < len(follow); i++ {
		if follow[i].ShopID == bingfans.BindShopID {
			follow[i].ShopStatus = 1
		}
	}
	shop := make([]*model.SearchFollowShoResp, 0)
	shop = append(shop, follow...)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("搜索关注的店铺:%s", follow)
	resp = &SearchFollowShopInfo{
		FollowCount:      len(follow),
		SearchFollowShop: shop,
	}

	return
}

//增加关注的店铺
func IncreaseFollowShop(req *model.IncreaseFollowShopReq, session *ghttp.Session) (resp *model.IncreaseFollowShopResp, err error) {
	resp, err = model.IncreaseFollowShop(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("增加关注的店铺:%s", resp)

	return
}

//取消关注的店铺
func DeleteFollowShop(req *model.DeleteFollowShopReq, session *ghttp.Session) (resp *model.DeleteFollowShopResp, err error) {
	resp, err = model.DeleteFollowShop(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("取消关注的店铺:%s", resp)

	return
}
