package customer

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"errors"

	"github.com/gogf/gf/net/ghttp"
)

// 系统公告 请求
type SystemAnnReq struct {
	Version string `json:"version"` //版本号v1.0.0
}

// 系统公告回应
type SystemAnnResp struct {
	Version string `json:"version"` //版本号v1.0.0
	Target  uint32 `json:"target"`  //0所有 1普通用户 2代购
	Type    uint32 `json:"type"`    //0拉取信息 1滚动展示 2弹框展示
	Msg     string `json:"msg"`     //内容
}

//处理用户请求拉取系统公告
func SystemAnnHandle(req *SystemAnnReq, session *ghttp.Session) (resp *SystemAnnResp, err error) {
	resp = &SystemAnnResp{
		Version: req.Version,
	}
	//获取用户信息
	userInfo := sessionman.GetUserInfo(session)
	if userInfo == nil || userInfo.UserID == 0 {
		return resp, errors.New("用户id为0")
	}

	switch {
	case userInfo.Role == model.UserRoleType_Buyer:
		resp.Target = 1
	case userInfo.Role >= model.UserRoleType_Agent:
		resp.Target = 2
	default:
		resp.Target = 0
	}
	resDb := model.SystemAnnInfo(&model.SystemAnnParam{
		SystemAnnVersion: req.Version,
		SystemAnnTarget:  resp.Target})
	if resDb == nil {
		return resp, errors.New("系统公告无数据")
	}
	resp = &SystemAnnResp{
		Version: resDb.SystemAnnVersion,
		Target:  resDb.SystemAnnTarget,
		Type:    resDb.SystemAnnType,
		Msg:     resDb.SystemAnnMsg,
	}
	return resp, nil
}
