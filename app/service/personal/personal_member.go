package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/wxapi"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"time"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
	"github.com/milkbobo/gopay/common"
)

//查看会员界面
func SeeMember(session *ghttp.Session) (res *model.SeeMemberResp, err error) {
	res, err = model.SeeMember(sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return res, err
	}
	zaplog.Infof("查看会员界面:%s", res)
	return
}

//GetOrdersId 生产订单编号1000000000-9999999999
//order_id生成格式：时间戳（10个） + 用户ID(7个)
func GetMemberId(userid uint32) string {
	strDate := int32(time.Now().Unix())
	strRes := fmt.Sprintf("%d%d", strDate, userid)
	return strRes
}

//开通会员
func OpenMembership(req *model.Membership, session *ghttp.Session) (resp *wxapi.UnifyOrderResp, IsVip uint8, err error) {
	userInfo := sessionman.GetUserInfo(session)
	if req.ID == 1 {
		//是否开通过会员
		isvip, err := model.IsSeeVip(userInfo.UserID)
		if err != nil {
			return nil, 0, err
		}
		if isvip.IsMember == 1 {
			return nil, 1, errors.New("下单失败，请选择其他套餐!")
		}
	}
	//查看商品价格
	price, err := model.SeePriceID(req.ID)
	if err != nil {
		return resp, 0, err
	}
	TradeNum := GetMemberId(userInfo.UserID)
	charge := &common.Charge{}
	charge.OpenID = sessionman.GetSessionInfo(session).OpenId
	charge.MoneyFee = price.MemberDiscountPrice
	charge.TradeNum = TradeNum
	charge.Describe = gconv.String(req.ID)
	resp, err = wxapi.PayMent(charge)
	if err != nil {
		return resp, 0, err
	}
	if resp.Return_code == "SUCCESS" {
		if resp.Result_code == "SUCCESS" {
			//保存充值流水发起状态
			err := model.SeeMemberPrice(&model.SeeMemberPriceReq{
				ID:          req.ID,
				MemberPrice: price.MemberDiscountPrice,
				MemberName:  price.MemberName,
				UserID:      userInfo.UserID,
				TrandID:     TradeNum,
			})
			if err != nil {
				return resp, 0, err
			}
		}
	}
	zaplog.Infof("开通会员:%s", resp)
	return
}
