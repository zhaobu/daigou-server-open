package model

import (
	"daigou/app/model/entity"
	"daigou/library/zaplog"

	"github.com/jinzhu/gorm"
)

type DbApiTestIn struct {
	UserID uint32 `json:"user_id"`
}

type DbApiTestInOut struct {
	entity.User
}

func TestApi(_args *DbApiTestIn) (out *DbApiTestInOut, err error) {
	out = &DbApiTestInOut{}
	err = dbXorm.Table("user").Where("user_id=?", _args.UserID).GetFirst(out).Error
	if gorm.IsRecordNotFoundError(err) {
		zaplog.Errorf("TestApi:err=%s", err)
		return
	}
	if err != nil {
		zaplog.Errorf("TestApi:err=%s", err)
		return
	}
	return
}
