package model

import (
	"daigou/app/model/entity"
	"daigou/library/conf"
	"daigou/library/zaplog"

	"github.com/jinzhu/gorm"
	"github.com/xormplus/xorm"
)

var (
	dbGorm *gorm.DB
	dbXorm *xorm.Engine
)

func InitModel() {
	dbGorm = conf.GetGormDb()
	dbXorm = conf.GetXormDB()
	if dbXorm == nil || dbGorm == nil {
		zaplog.Fatalf("InitModel err")
	}
	LoadTestUser()
	return
}

//增加商店访问记录
func AddShopAccessRecord(_args *entity.ShopAccessRecords) (err error) {
	tb := dbGorm.Table("shop_access_records")
	err = tb.Create(_args).Error
	if err != nil {
		zaplog.Errorf("AddShopAccessRecord Db err:%s", err)
	}
	return
}

//增加登录流水
func AddLoginRecord(_args *entity.UserLoginRecords) (err error) {
	tb := dbGorm.Table("user_login_records")
	err = tb.Create(_args).Error
	if err != nil {
		zaplog.Errorf("AddLoginRecord Db err:%s", err)
	}
	return
}

//增加商品访问记录
func AddGoodsAccessRecord(_args *entity.GoodsAccessRecords) (err error) {
	tb := dbGorm.Table("goods_access_records")
	err = tb.Create(_args).Error
	if err != nil {
		zaplog.Errorf("AddGoodsAccessRecord Db err:%s", err)
	}
	return
}

//增加商铺码使用记录
func AddShopCodeRecord(tx *gorm.DB, _args *entity.ShopCodeRecords) (err error) {
	if tx == nil {
		tx = dbGorm
	}
	tb := tx.Table("shop_code_records")
	err = tb.Create(_args).Error
	if err != nil {
		zaplog.Errorf("AddShopCodeRecord Db err:%s", err)
	}
	return
}

//获取商店信息
func GetShopInfo(tx *gorm.DB, _shopID uint64) (out *entity.ShopInfo, err error) {
	if tx == nil {
		tx = dbGorm
	}
	//获取店铺信息
	out = &entity.ShopInfo{}
	err = dbGorm.Table("shop_info").Where("shop_id=?", _shopID).First(out).Error
	if err != nil {
		zaplog.Errorf("GetShopInfo Db err=%s", err)
	}
	return
}

//判断商店是否存在
func IsShopExist(tx *gorm.DB, _shopID uint64) bool {
	if tx == nil {
		tx = dbGorm
	}
	//获取店铺信息
	out := &entity.ShopInfo{}
	err := dbGorm.Table("shop_info").Select("shop_id").Where("shop_id=?", _shopID).First(out).Error
	return err == nil
}

//精确两位数
//相加
func AddFloat64(g float64, h float64) float64 {
	return ((g * 100) + (h * 100)) / 100
}

//相减
func SubtractFloat64(g float64, h float64) float64 {
	return ((g * 100) - (h * 100)) / 100
}

//相乘
func MultiplyFloat64(g float64, h float64) float64 {
	return ((g * 100) * (h * 100)) / 10000
}
