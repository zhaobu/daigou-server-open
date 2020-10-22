package kuaidi

import (
	"github.com/gogf/gf/frame/g"
)

var (
	c = g.Client()
)

//系统配置的商户号和appkey,以及对应调用接口
type KuaiDiThirdPlatformInfo struct {
	AppKey       string //
	EBusinessID  string //平台开通的商户号
	InterfaceUrl string //功能接口调用链接
}
