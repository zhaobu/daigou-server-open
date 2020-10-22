package entity

import (
	jsoniter "github.com/json-iterator/go"
)

// -------------table start----------------

// -------------table end----------------

// -------------shop_info start----------------
//用户分类信息
type ShopInfo_CategoryInfo []int32

//行程信息
type ShopInfo_ScrollInfo_TravelInfo struct {
	URL              []string `json:"url"`               //图片地址
	StartTime        *Time    `json:"start_time"`        //开始时间
	EndTime          *Time    `json:"end_time"`          //结束时间
	DeparturePoint   string   `json:"departure_point"`   //出发地
	DestinationPoint string   `json:"destination_point"` //目的地
}

//用户首页滚动信息
type ShopInfo_ScrollInfo struct {
	TravelInfo []*ShopInfo_ScrollInfo_TravelInfo `json:"travel_info"` //行程信息
}

//创建新商店时,需初始化滚动信息为json对象
func NewShopInfoScrollInfo() string {
	jsonScrollInfo, _ := jsoniter.Marshal(&ShopInfo_ScrollInfo{
		TravelInfo: []*ShopInfo_ScrollInfo_TravelInfo{},
	})
	return string(jsonScrollInfo)
}

//行程信息(新)
type ShopInfo_ScrollInfo_TravelInfo_New struct {
	Type             string   `json:"type"`              //1行程     2促销
	URL              []string `json:"url"`               //图片地址
	ShopURL          []string `json:"shop_url"`          //商品图片地址
	StartTime        *Time    `json:"start_time"`        //开始时间
	EndTime          *Time    `json:"end_time"`          //结束时间
	DeparturePoint   string   `json:"departure_point"`   //出发地
	DestinationPoint string   `json:"destination_point"` //目的地
}

//用户首页滚动信息(新)
type ShopInfo_ScrollInfo_New struct {
	TravelInfoNew []*ShopInfo_ScrollInfo_TravelInfo_New `json:"travel_info"` //行程信息
}

//创建新商店时,需初始化滚动信息为json对象(新)
func ShopInfoScrollInfoNew() string {
	jsonScrollInfo, _ := jsoniter.Marshal(&ShopInfo_ScrollInfo_New{
		TravelInfoNew: []*ShopInfo_ScrollInfo_TravelInfo_New{},
	})
	return string(jsonScrollInfo)
}

// -------------shop_info end----------------

// -------------casbin_role start----------------
type CasbinRole_APIList []uint32

// -------------casbin_role end----------------

// -------------casbin_role start----------------
type CasbinUserRole_RoleList []uint32

// -------------casbin_role end----------------
