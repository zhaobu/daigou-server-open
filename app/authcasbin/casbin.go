package authcasbin

import (
	"daigou/app/model/entity"
	"daigou/library/conf"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"fmt"

	"github.com/casbin/casbin/v2"
	casbin_model "github.com/casbin/casbin/v2/model"
	gormadapter "github.com/casbin/gorm-adapter/v2"
	"github.com/jinzhu/gorm"
	jsoniter "github.com/json-iterator/go"
)

var (
	userNameFmt = "user:%d"
	roleNameFmt = "role:%d"
	dbGorm      *gorm.DB
	isEnable    = false //是否初始化成功
	casbinAuth  *CasbinAuth
)

type CasbinAuth struct {
	Enforcer *casbin.CachedEnforcer
}

func InitCasbin() {
	dbGorm = conf.GetGormDb()
	if dbGorm == nil {
		zaplog.Fatalf("InitCasbin err")
	}
	err := newCasbin()
	if err != nil {
		zaplog.Fatalf("InitCasbin err")
	}
	isEnable = true
}

func IsEnable() bool {
	return isEnable
}

func newCasbin() (err error) {
	a, err := gormadapter.NewAdapterByDB(dbGorm)
	if err != nil {
		zaplog.Errorf("initCasbin 连接数据库错误: %s", err)
		return
	}
	casbinModel, err := casbin_model.NewModelFromString(conf.Conf.Casbin.ModelConf)
	if err != nil {
		zaplog.Errorf("initCasbin 读取model配置错误: %s", err)
		return
	}
	e, err := casbin.NewCachedEnforcer(casbinModel, a)
	if err != nil {
		zaplog.Errorf("initCasbin 初始化casbin错误: %s", err)
		return
	}
	casbinAuth = &CasbinAuth{Enforcer: e}
	casbinAuth.Enforcer.EnableLog(true)
	casbinAuth.Enforcer.EnableAutoSave(conf.Conf.Casbin.Autosave)
	loadAllPolicy()
	zaplog.Debugf("GetAllSubjects:%s", utils.Dump(casbinAuth.Enforcer.GetAllSubjects()))
	zaplog.Debugf("GetAllObjects:%s", utils.Dump(casbinAuth.Enforcer.GetAllObjects()))
	zaplog.Debugf("GetAllRoles:%s", utils.Dump(casbinAuth.Enforcer.GetAllRoles()))
	zaplog.Debugf("GetPolicy:%s", utils.Dump(casbinAuth.Enforcer.GetPolicy()))
	return
}

func loadAllPolicy() {
	//查询所有的权限数据
	var out1 []*entity.CasbinAPI
	err := dbGorm.Table("casbin_api").Find(&out1).Error
	if err != nil {
		zaplog.Errorf("loadAllPolicy err: %s", err)
		return
	}
	//查询每个角色拥有的权限
	var out2 []*entity.CasbinRoleAPI
	err = dbGorm.Table("casbin_role_api").Find(&out2).Error
	if err != nil {
		zaplog.Errorf("loadAllPolicy err: %s", err)
		return
	}

	apiToPath := make(map[uint32]*entity.CasbinAPI, 10)
	roleIDToName := make(map[uint32]*entity.CasbinRoleAPI, 10)
	//建立api的id到path映射
	for _, v := range out1 {
		apiToPath[v.ID] = v
	}

	//加载角色权限数据
	for _, v := range out2 {
		if v.APIList == "" {
			continue
		}
		roleIDToName[v.ID] = v
		res := make(entity.CasbinRole_APIList, 0, 10)
		//解析角色拥有的权限id列表
		if err = jsoniter.Unmarshal([]byte(v.APIList), &res); err != nil {
			zaplog.Errorf("loadAllPolicy err:%s", err)
			return
		}

		//为角色添加权限
		roleName := fmt.Sprintf(roleNameFmt, v.ID)
		for _, v2 := range res {
			if api, ok := apiToPath[v2]; ok {
				casbinAuth.Enforcer.AddPermissionForUser(roleName, api.Path)
			}
		}
	}

	//查询每个用户拥有的角色
	var out3 []*entity.CasbinUserRole
	err = dbGorm.Table("casbin_user_role").Find(&out3).Error
	if err != nil {
		zaplog.Errorf("loadAllPolicy err: %s", err)
		return
	}

	//加载用户角色数据
	for _, v := range out3 {
		if v.RoleList == "" {
			continue
		}
		res := make(entity.CasbinUserRole_RoleList, 0, 5)
		//解析角色拥有的权限id列表
		if err = jsoniter.Unmarshal([]byte(v.RoleList), &res); err != nil {
			zaplog.Errorf("loadAllPolicy err:%s", err)
			return
		}
		userName := fmt.Sprintf(userNameFmt, v.UserID)
		roleNames := make([]string, 0, len(res))
		for _, v2 := range res {
			roleNames = append(roleNames, fmt.Sprintf(roleNameFmt, v2))
		}
		casbinAuth.Enforcer.AddRolesForUser(userName, roleNames)
	}
}

func Enforce(_userID uint32, _path string) (has bool, err error) {
	userName := fmt.Sprintf(userNameFmt, _userID)
	zaplog.Debugf("_userID:%d,_path:%s", _userID, _path)
	return casbinAuth.Enforcer.Enforce(userName, _path)
}
