package personal

import (
	"daigou/app/service/user/sessionman"
	"daigou/library/public"
	"daigou/library/redis"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type GetShopCodeReq struct {
	GenType public.ShopCodeType `json:"gen_type" v:"gen_type@required#店铺码类型不正确"` //店铺码类型(0:系统生成,1:商店生成)
}
type GetShopCodeResp struct {
	*redis.GenShopCodeOut
}

//获取推广码
func GetShopCode(req *GetShopCodeReq, session *ghttp.Session) (resp *GetShopCodeResp, err error) {
	//TODO判断是否有权限获取
	userInfo := sessionman.GetUserInfo(session)

	out1, err1 := redis.GenShopCode(&redis.GenShopCodeIn{GenType: req.GenType, ShopID: userInfo.ShopID, OldShopCode: userInfo.ShopCode})
	if err != nil {
		zaplog.Errorf("GetShopCode err:%s", err1)
		return resp, err1
	}
	//更新session
	userInfo.ShopCode = out1.ShopCode
	sessionman.UpdateSession(session, userInfo)
	resp = &GetShopCodeResp{GenShopCodeOut: out1}
	return
}
