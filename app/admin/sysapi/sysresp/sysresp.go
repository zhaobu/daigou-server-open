package sysresp

import (
	"daigou/app/model"
	"daigou/library/redis"
)

type GetShopCodeResp struct {
	*redis.GenShopCodeOut
}

type UseShopCodeResp struct {
	*model.DbUseShopCodeOut
}
