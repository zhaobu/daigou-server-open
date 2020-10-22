package router

import (
	"daigou/app/admin/sysapi"
	"daigou/app/api"
	"daigou/app/middleware"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/net/ghttp"
)

func InitRouter() (err error) {
	s := g.Server()
	//url example /daigou/api/v{:version}/mainPage/search
	s.Group("/daigou/api/v{version}", func(group *ghttp.RouterGroup) {
		//允许跨域
		group.Middleware(middleware.CORS)

		//全局日志拦截
		group.Middleware(middleware.Log)

		group.Group("/admin", adminGroup)

		//不需要鉴权的路由
		group.Group("/", noAuthGroup)
		// // 鉴权
		group.Middleware(middleware.Auth)

		// //鉴定访问权限
		group.Middleware(middleware.CasbinMiddleware)

		//全局错误处理
		group.Middleware(middleware.ErrorHandler)
		group.Group("/common", commonGroup)
		group.Group("/user", userGroup)
		group.Group("/mainPage", mainPageGroup)
		group.Group("/personal", personalPageGroup)
		group.Group("/order", orderPageGroup)
		group.Group("/customer", customerPageGroup)
		group.Group("/house", housePageGroup)

	})

	return
}

//不需要鉴权的路由
func noAuthGroup(group *ghttp.RouterGroup) {
	group.ALL("/user/wxGetToken", api.WxGetToken)                 //验证code获取token
	group.ALL("/user/wxLoginWithSession", api.WxLoginWithSession) //带token微信登录
	group.ALL("/user/testUserLogin", api.TestUserLogin)           //游客登录

	// 以下接口需要鉴定访问权限
	group.ALL("/order/pushQueryDataKdn", api.PushQueryDataKdn)     //第三方平台推送物流轨迹信息接收接口(快递鸟)
	group.ALL("/order/pushQueryDataKd100", api.PushQueryDataKd100) //第三方平台推送物流轨迹信息接收接口(快递100)

	//微信公众号推送订阅和取消订阅事件消息
	group.ALL("/customer/subscribeGzh", api.SubscribeGzh) //微信公众号推送

	//微信接收小程序事件推送消息
	group.ALL("/customer/wxSmallEvent", api.WxSmallEvent) //小程序事件推送

	//微信回调支付不需要鉴定访问权限
	group.ALL("/common/paymentCallback", api.PaymentCallback) //微信回调

	//同步商品旧数据到商品库中
	group.ALL("/house/synchronizationGoods", api.SynchronizationGoods)
}

//管理后台分组路由
func adminGroup(group *ghttp.RouterGroup) {
	//TODO 添加token鉴权
	group.ALL("/", new(sysapi.AdminAction))
}

//通用分组路由
func commonGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.CommonAction))
}

//用户分组路由
func userGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.UserAction))
}

//首页分组路由
func mainPageGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.MainPageAction))
}

//我的分组路由
func personalPageGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.PersonalAction))
}

//订单分组路由
func orderPageGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.OrderPageAction))
}

//客户端路由，支付
func customerPageGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.CustomerAction))
}

//客户端路由，仓库
func housePageGroup(group *ghttp.RouterGroup) {
	group.ALL("/", new(api.HouseAction))
}
