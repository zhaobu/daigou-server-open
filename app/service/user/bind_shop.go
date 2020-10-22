package user

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"errors"

	"github.com/gogf/gf/net/ghttp"
)

type BindShopReq struct {
	BindShopID uint64 `json:"bind_shop_id" v:"bind_shop_id@required#商店id不能为空"` //商店id
}

type BindShopResp struct {
}

func BindShop(req *BindShopReq, session *ghttp.Session) (resp *BindShopResp, err error) {
	zaplog.Debugf("req=%+v", req)
	userInfo := sessionman.GetUserInfo(session)
	confTestUser := conf.Conf.TestUser
	if req.BindShopID == uint64(confTestUser.Seller.UserID) ||
		userInfo.UserID == confTestUser.Seller.UserID || userInfo.UserID == confTestUser.Buyer.UserID {
		err = errors.New("体验账号不能做绑定操作")
		zaplog.Debugf("err=%s", err)
		return
	}
	res, err := model.BindShop(nil, &model.DbBindShopIn{UserID: userInfo.UserID, BindShopID: req.BindShopID})
	if err != nil {
		zaplog.Errorf("BindShop err:%s", err)
		return nil, err
	}
	//更新session信息
	userInfo.BindShopID = res.BindShopID
	sessionman.UpdateSession(session, userInfo)
	return
}

type BindCustomerReq struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type BindCustomerResp struct {
}

//用户成为商铺客户
func BindCustomer(req *BindCustomerReq, session *ghttp.Session) (resp *BindCustomerResp, msg string, err error) {
	zaplog.Debugf("req=%+v", req)
	userInfo := sessionman.GetUserInfo(session)
	if !model.IsCustomerBinding(&model.CustomerBindingReq{CustomerID: req.CustomerID}) {
		return resp, "该客户已经绑定用户，不能重复绑定", nil
	}
	customershopid, err := model.CustomerShopIDSee(&model.CustomerBindingReq{CustomerID: req.CustomerID})
	if err != nil {
		return resp, "", nil
	}
	avatarurl, err := model.CustomerUrl(userInfo.UserID)
	//添加客户
	if !model.IsUserBinding(&model.CustomerBindingReq{CrUserid: userInfo.UserID}, customershopid.ShopID) {
		err := model.CustomerBinding(&model.CustomerBindingReq{
			CustomerID: req.CustomerID,
			CrUserid:   userInfo.UserID,
		}, customershopid.ShopID, avatarurl.AvatarURL)
		if err != nil {
			zaplog.Infof("用户成为商铺客户失败:%v", resp)
			return resp, "", nil
		}
		//将订单表用户id更新为绑定后的微信注册id
		zaplog.Infof("将订单表用户id更新为绑定后的微信注册id 请求")
		if err = model.UpdateOrdersUserID(userInfo.UserID, req.CustomerID, customershopid.ShopID); err != nil {
			zaplog.Infof("将订单表用户id更新为绑定后的微信注册id失败:%v", err)
			return resp, "", nil
		}
	}
	return
}
