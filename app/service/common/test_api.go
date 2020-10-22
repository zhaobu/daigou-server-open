package common

import (
	"daigou/library/wxapi"
	"daigou/library/zaplog"

	"github.com/medivhzhan/weapp/v2"
)

//商品规格
type TestApiReq struct {
	weapp.UnlimitedQRCode
}

type TestApiResp struct {
	WebappCode []byte `json:"webapp_code"`
}

func TestApi(req *TestApiReq) (resp *TestApiResp, err error) {
	zaplog.Debugf("req=%+v", req)
	res1, err := wxapi.GetUnlimited(&req.UnlimitedQRCode)
	if err != nil {
		zaplog.Errorf("TestApi err:%s", err)
		return nil, err
	}
	resp = &TestApiResp{WebappCode: res1}
	return
}
