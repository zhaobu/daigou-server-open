package sysreq

import (
	"daigou/library/redis"
)

type GetShopCodeReq struct {
	*redis.GenShopCodeIn
}

type UseShopCodeReq struct {
	ShopCode string `json:"shop_code" v:"shop_code@required#店铺码不能为空"` //店铺码
	UserID   uint32 `json:"user_id" v:"user_id@required#user_id不能为空"`
}
