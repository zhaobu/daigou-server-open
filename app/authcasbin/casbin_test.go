package authcasbin

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"testing"

	jsoniter "github.com/json-iterator/go"
)

func init() {
	zaplog.InitLog(&zaplog.Config{
		Logdir:   "./",
		LogName:  "go_test.log",
		Loglevel: "debug",
		Debug:    true,
	})
	conf.InitConfig("../../bin/config/config1.toml")
	conf.InitConnect()
	InitCasbin()
}

var (
	_userID uint32 = 1000008
)

//修改用户拥有的角色
func Test_CasbinUserRole(t *testing.T) {
	res := entity.CasbinUserRole{}
	err := dbGorm.Table("casbin_user_role").Select("id").First(&res).Error
	if err != nil {
		zaplog.Errorf("Test_CasbinUserRole, err=%s", err)
		return
	}
	roleList := entity.CasbinUserRole_RoleList{
		uint32(model.UserRoleType_Buyer),
	}
	roleListStr, _ := jsoniter.Marshal(roleList)
	_casbinUserRole := &entity.CasbinUserRole{
		UserID:   _userID,
		RoleList: string(roleListStr),
	}
	if res.ID == 0 {
		err = dbGorm.Table("casbin_user_role").Create(_casbinUserRole).Error
	} else {
		err = dbGorm.Table("casbin_user_role").Where("id=?", res.ID).Update(_casbinUserRole).Error
	}
	if err != nil {
		zaplog.Errorf("Test_CasbinUserRole err:%s", err)
	}
}

func Test_CasbinRoleApi(t *testing.T) {
	res := entity.CasbinRoleAPI{}
	err := dbGorm.Table("casbin_role_api").Select("id").First(&res).Error
	if err != nil {
		zaplog.Errorf("Test_UpdateCasbinRoleApi, err=%s", err)
		return
	}
	apiList := entity.CasbinRole_APIList{1, 2, 3}
	apiListStr, _ := jsoniter.Marshal(apiList)
	casbinRoleAPI := &entity.CasbinRoleAPI{
		Name:    "用户",
		APIList: string(apiListStr),
	}
	if res.ID == 0 { //insert
		err = dbGorm.Table("casbin_role_api").Create(casbinRoleAPI).Error
	} else { //update
		err = dbGorm.Table("casbin_role_api").Where("id=?", res.ID).Update(casbinRoleAPI).Error
	}
}

func Test_Enforce(t *testing.T) {
	res := entity.CasbinAPI{}
	err := dbGorm.Table("casbin_api").Where("id=?", 1).First(&res).Error
	if err != nil {
		zaplog.Errorf("Test_Enforce, err=%s", err)
		return
	}
	has, err := Enforce(_userID, res.Path)
	if err != nil {
		zaplog.Errorf("Test_Enforce, err=%s", err)
		return
	}
	zaplog.Infof("has=%v", has)
}
