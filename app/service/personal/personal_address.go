package personal

import (
	"daigou/app/model"
	"daigou/app/model/entity"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SeeAddressInfo struct {
	AllCount   int                     `json:"all_count"` //地址个数
	SeeAddress []*model.SeeAddressResp `json:"see_address"`
}

//获取用户默认收货地址
type UserDefaultAdress struct {
	AddressID       uint32 `json:"aid"`      // 用户地址ID
	PhoneNumber     int64  `json:"phone"`    // 手机号
	Name            string `json:"name"`     // 姓名
	Gender          int32  `json:"gender"`   // 性别,0男生1女生
	Province        string `json:"province"` // 省
	City            string `json:"city"`     // 市
	Area            string `json:"area"`     // 区
	DetailedAddress string `json:"add"`      // 详细地址
}

//查看默认地址
func SeeDefaultAddress(session *ghttp.Session) (resp *UserDefaultAdress, err error) {
	var sql_res *entity.UserAddress
	if sql_res, err = model.SeeDefaultAddress(sessionman.GetUserInfo(session).UserID); err == nil {
		resp = &UserDefaultAdress{
			AddressID:       sql_res.AddressID,
			PhoneNumber:     sql_res.PhoneNumber,
			Name:            sql_res.Name,
			Gender:          sql_res.Gender,
			Province:        sql_res.Province,
			City:            sql_res.City,
			Area:            sql_res.Area,
			DetailedAddress: sql_res.DetailedAddress,
		}
	}

	return
}

//查看地址
func SeeAddress(req *model.SeeAddressReq, session *ghttp.Session) (resp *SeeAddressInfo, err error) {
	address, err := model.SeeAddress(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return resp, err
	}
	addressresp := make([]*model.SeeAddressResp, 0)
	addressresp = append(addressresp, address...)
	zaplog.Infof("查看地址:%s", address)
	resp = &SeeAddressInfo{
		AllCount:   len(address),
		SeeAddress: addressresp,
	}
	return
}

//新增地址
func IncreaseAddress(req *model.IncreaseAddressReq, session *ghttp.Session) (resp *model.IncreaseAddressResp, msg string, err error) {
	msg = IsAddressNull(req)
	if msg != "" {
		return nil, msg, err
	}
	resp, err = model.IncreaseAddress(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return resp, "", err
	}
	return
}

//修改地址
func ModifyAddress(req *model.IncreaseAddressReq, session *ghttp.Session) (resp *model.ModifyAddressResp, msg string, err error) {
	msg = IsAddressNull(req)
	if msg != "" {
		return nil, msg, err
	}
	resp, err = model.ModifyAddress(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return resp, "", err
	}
	return
}

//删除地址
func DeleteAddress(req *model.DeleteAddressReq) (resp *model.DeleteAddressResp, err error) {
	resp, err = model.DeleteAddress(req)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("删除地址:%s", resp)
	return
}

//校验传入地址数据是否为空
func IsAddressNull(req *model.IncreaseAddressReq) (msg string) {
	if req.Name == "" {
		msg = "用户姓名需要填写!"
		return msg
	}
	if req.PhoneNumber < 10000000000 {
		msg = "用户手机号填写错误!"
		return msg
	}
	if req.Province == "" {
		msg = "省地址需要填写!"
		return msg
	}
	if req.City == "" {
		msg = "市地址需要填写!"
		return msg
	}
	if req.Area == "" {
		msg = "区地址需要填写!"
		return msg
	}
	if req.Address == "" {
		msg = "详细地址需要填写!"
		return msg
	}
	return ""
}
