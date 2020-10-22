package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"
	"errors"

	"github.com/gogf/gf/net/ghttp"
)

type ShopWallet struct {
	TotalProfit        float64 `json:"total_profit"`         //累计总收益
	MonthProfit        float64 `json:"month_profit"`         //月收益
	MonthCost          float64 `json:"month_cost"`           //月成本
	PostalRevenue      float64 `json:"postal_revenue"`       //邮费总收益
	RevenueMonthProfit float64 `json:"revenue_month_profit"` //邮费月收益
	RevenueMonthCost   float64 `json:"revenue_month_cost"`   //邮费月成本
	VipCode            int32   `json:"vipCode"`              //限制次数
}

//我的钱包
func PersonalWallet(session *ghttp.Session) (resp *ShopWallet, err error) {
	wallet, err := model.PersonalWallet(sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return nil, err
	}
	zaplog.Infof("我的钱包:%s", resp)
	vipexplain, err := ShopVipExplain(3, session)
	if err != nil {
		return nil, err
	}
	resp = &ShopWallet{
		TotalProfit:        wallet.TotalProfit,
		MonthProfit:        wallet.MonthProfit,
		MonthCost:          wallet.MonthCost,
		PostalRevenue:      wallet.PostalRevenue,
		RevenueMonthProfit: wallet.RevenueMonthProfit,
		RevenueMonthCost:   wallet.RevenueMonthCost,
		VipCode:            vipexplain.Explain,
	}
	return
}

type OrderStream struct {
	OrderCount      int                      `json:"all_count"`
	TotalPayPrice   float64                  `json:"total_pay_price"`   //总售价
	TotalProfit     float64                  `json:"total_profit"`      //总收益
	TotalInputPrice float64                  `json:"total_input_price"` //总进价
	Order           []*model.OrderStreamResp `json:"order"`
}

//收支明细
func PersonalOrderStream(req *model.OrderStreamReq, session *ghttp.Session) (resp *OrderStream, Isvip uint8, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	if shopvip, err := ShopVipExplain(3, session); shopvip.Explain == 0 && err == nil {
		return nil, 1, errors.New("您还不是VIP用户，无法进行此操作!")
	}
	orderstream, totalorder, err := model.PersonalOrderStream(req, sessionman.GetUserInfo(session).ShopID)
	order := make([]*model.OrderStreamResp, 0)
	order = append(order, orderstream...)
	if err != nil {
		return nil, 0, err
	}
	zaplog.Infof("收支明细:%s", resp)
	resp = &OrderStream{
		OrderCount:      len(order),
		TotalPayPrice:   totalorder.TotalPayPrice,
		TotalProfit:     totalorder.TotalProfit,
		TotalInputPrice: totalorder.TotalInputPrice,
		Order:           order,
	}
	return
}

//搜索收支明细
func SearchOrderStream(req *model.OrderStreamReq, session *ghttp.Session) (resp *OrderStream, Isvip uint8, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	if shopvip, err := ShopVipExplain(3, session); shopvip.Explain == 0 && err == nil {
		return nil, 1, errors.New("您还不是VIP用户，无法进行此操作!")
	}
	orderstream, totalorder, err := model.SearchOrderStream(req, sessionman.GetUserInfo(session).ShopID)
	order := make([]*model.OrderStreamResp, 0)
	order = append(order, orderstream...)
	if err != nil {
		return nil, 0, err
	}
	zaplog.Infof("搜索收支明细:%s", resp)
	resp = &OrderStream{
		OrderCount:      len(order),
		TotalPayPrice:   totalorder.TotalPayPrice,
		TotalProfit:     totalorder.TotalProfit,
		TotalInputPrice: totalorder.TotalInputPrice,
		Order:           order,
	}
	return
}
