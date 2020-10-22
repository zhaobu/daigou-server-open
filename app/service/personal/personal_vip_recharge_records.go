package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type VipRechargeRecord struct {
	AllCount       int                             `json:"all_count"` //充值记录个数
	RechargeRecord []*model.VipRechargeRecordsResp `json:"recharge_records"`
}

//查询用户VIP充值记录
func VipRechargeRecords(req *model.VipRechargeRecordsReq, session *ghttp.Session) (resp *VipRechargeRecord, err error) {
	recharge, err := model.VipRechargeRecords(req, sessionman.GetUserInfo(session).UserID)
	records := make([]*model.VipRechargeRecordsResp, 0)
	records = append(records, recharge...)
	if err != nil {
		return nil, err
	}
	resp = &VipRechargeRecord{
		AllCount:       len(recharge),
		RechargeRecord: records,
	}
	zaplog.Infof("查询用户VIP充值记录:%s", resp)
	return
}

type VipExplain struct {
	Explain int32 //限制次数（-1为会员无限制，0普通用户无此数，大于0为限制次数）
}

//查询限制次数
func ShopVipExplain(PayId uint32, session *ghttp.Session) (resp *VipExplain, err error) {
	isvip, err := model.IsSeeMember(sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return nil, err
	}
	explains, err := model.ShopVipExplain(PayId, isvip.IsMember)
	if err != nil {
		return nil, err
	}
	if isvip.IsMember == 0 {
		resp = &VipExplain{
			Explain: explains.OrdinaryExplain,
		}
	} else {
		resp = &VipExplain{
			Explain: explains.VipExplain,
		}
	}
	zaplog.Infof("查询限制次数:%v", resp)
	return
}
