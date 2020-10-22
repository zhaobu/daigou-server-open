package user

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/redis"
	"daigou/library/utils"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type UseShopCodeReq struct {
	ShopCode string `json:"shop_code" v:"shop_code@required#店铺码不能为空"` //店铺码
}

type UseShopCodeResp struct {
	Code int32 `json:"code"` //错误码(0:使用成功 1:店铺码过期 2:商店已开通)
	*model.DbUseShopCodeOut
}

func UseShopCode(req *UseShopCodeReq, session *ghttp.Session) (resp *UseShopCodeResp, msg string, err error) {
	zaplog.Debugf("req=%+v", req)
	userInfo := sessionman.GetUserInfo(session)
	if userInfo.ShopID != 0 {
		return &UseShopCodeResp{Code: 2}, "商店已开通", nil
	}
	//验证店铺码信息
	out1, msg1, err1 := redis.CheckShopCode(req.ShopCode, true)
	if err1 != nil {
		zaplog.Errorf("UseShopCode err:%s", err1)
		return nil, "", err1
	}

	if out1.Code != 0 {
		zaplog.Errorf("UseShopCode fail,out:%s,msg:%s", utils.Dump(out1), msg1)
		return &UseShopCodeResp{Code: out1.Code}, msg1, nil
	}

	out2, err2 := model.UseShopCode(&model.DbUseShopCodeIn{GenType: out1.GenType, UserID: userInfo.UserID, BindShopID: out1.ShopID})
	if err2 != nil {
		zaplog.Errorf("UseShopCode err:%s", err2)
		return nil, "", err2
	}

	//更新session信息
	userInfo.BindShopID = out2.BindShopID
	userInfo.ShopID = out2.ShopID
	userInfo.Role = out2.Role
	sessionman.UpdateSession(session, userInfo)
	resp = &UseShopCodeResp{Code: 0, DbUseShopCodeOut: out2}
	return
}
