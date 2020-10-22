package sysservice

import (
	"daigou/app/admin/sysapi/sysreq"
	"daigou/app/admin/sysapi/sysresp"
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/library/conf"
	"daigou/library/redis"
	"daigou/library/zaplog"
	"fmt"
)

func UseShopCode(req *sysreq.UseShopCodeReq) (resp *sysresp.UseShopCodeResp, err error) {
	resp = &sysresp.UseShopCodeResp{}

	tb := &entity.ShopInfo{UserID: req.UserID}
	dbGorm := conf.GetGormDb().Model(tb)
	if !dbGorm.Select("id").Where("user_id=?", req.UserID).First(tb).RecordNotFound() {
		err = fmt.Errorf("商店已开通")
		return
	}

	//验证店铺码信息
	out, msg, err := redis.CheckShopCode(req.ShopCode, true)
	if err != nil {
		zaplog.Errorf("UseShopCode err:%s", err)
		return
	}

	if out.Code != 0 {
		err = fmt.Errorf("%s", msg)
		zaplog.Errorf("UseShopCode err:%s", err)
		return
	}

	resp.DbUseShopCodeOut, err = model.UseShopCode(&model.DbUseShopCodeIn{GenType: out.GenType, UserID: req.UserID, BindShopID: out.ShopID})
	if err != nil {
		zaplog.Errorf("UseShopCode err:%s", err)
		return
	}

	//删除用户的session信息,让用户重新登录
	out1, err := redis.DelSession(req.UserID)
	if out1 == 0 {
		zaplog.Errorf("用户session信息删除失败")
	}
	return
}
