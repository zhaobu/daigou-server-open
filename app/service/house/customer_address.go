package house

import (
	"daigou/app/model"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

//查看地址
func AddressSee(req *model.AddressSeeReq, session *ghttp.Session) (resp []*model.AddressSeeResp, err error) {
	resp, err = model.AddressSee(req)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看地址:%s", resp)
	return
}

//新增地址
func AddressIncrease(req *model.AddressIncreaseReq, session *ghttp.Session) (resp *model.AddressIncreaseResp, msg string, err error) {
	msg = IsAddressNull(req)
	if msg != "" {
		return nil, msg, err
	}
	if model.IsAddress(req) {
		msg = "该地址您已经添加过了，请勿重复添加！"
		return
	}
	resp, err = model.AddressIncrease(req)
	if err != nil {
		return resp, "新增失败", err
	}
	return
}

//修改地址
func AddressUpdate(req *model.AddressIncreaseReq, session *ghttp.Session) (resp *model.AddressUpdateResp, msg string, err error) {
	msg = IsAddressNull(req)
	if msg != "" {
		return nil, msg, err
	}
	resp, err = model.AddressUpdate(req)
	if err != nil {
		return resp, "", err
	}
	return
}

//删除地址
func AddressDelete(req *model.AddressDeleteReq) (resp *model.AddressDeleteResp, err error) {
	resp, err = model.AddressDelete(req)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("删除地址:%s", resp)
	return
}

//校验传入地址数据是否为空
func IsAddressNull(req *model.AddressIncreaseReq) (msg string) {
	if req.Name == "" {
		msg = "用户姓名需要填写!"
		return msg
	}
	if req.PhoneNumber == "" {
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
	if req.Detailed == "" {
		msg = "详细地址需要填写!"
		return msg
	}
	return ""
}
