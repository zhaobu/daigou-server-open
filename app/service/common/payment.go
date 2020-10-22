package common

import (
	"daigou/app/model"
	"daigou/library/wxapi"
	"daigou/library/zaplog"

	"github.com/milkbobo/gopay/common"
)

func WeChatCallback(req *wxapi.CallbackReq) (resp *common.WechatBaseResult, err error) {
	//判断签名串并订单金额 返回微信结果
	resp, err = wxapi.WeChatCallback(req)
	if err != nil {
		zaplog.Errorf("WeChatCallback err:%s", err)
		return nil, err
	}
	status, err := model.OpenMemberStatus(&model.OpenMembershipReq{
		TrandID: req.OutTradeNO,
	})
	if err != nil {
		return nil, err
	}
	//修改数据库
	if resp.ReturnCode == "SUCCESS" {
		if status.Status == 1 {
			return nil, err
		} else {
			err := model.OpenMembership(&model.OpenMembershipReq{
				ID:         status.FeeType,
				OpenID:     req.OpenID,
				TrandID:    req.OutTradeNO,
				RechargeID: req.TransactionID,
				Status:     1,
			})
			if err != nil {
				return nil, err
			}
		}
	} else {
		err := model.OpenMembership(&model.OpenMembershipReq{
			ID:         status.FeeType,
			OpenID:     req.OpenID,
			TrandID:    req.OutTradeNO,
			RechargeID: req.TransactionID,
			Status:     2,
		})
		if err != nil {
			return nil, err
		}
	}
	return
}
