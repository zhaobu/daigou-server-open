package response

import (
	"github.com/gogf/gf/net/ghttp"
)

// 数据返回通用JSON数据结构
type JsonResponse struct {
	Code RespCode    `json:"code"` // 错误码(-1:请求错误 0:请求成功 1:请求失败,一般指业务方面 2:鉴权失败,3:token失效 4:没有操作权限 )
	Msg  string      `json:"msg"`  // 提示信息
	Data interface{} `json:"data"` // 返回数据(业务接口定义具体数据结构)
}

type RespCode int32

const (
	ERROR         RespCode = iota - 1 //请求错误
	SUCCESS                           //请求成功
	FAIL                              //请求失败,一般指业务方面
	UNAUTHORIZED                      //鉴权失败
	EXPIRED                           //token失效(只在访问登录接口时使用)
	UNAUTHOPERATE                     //没有操作权限
)

// 返回JSON数据并退出当前HTTP执行函数。
func JsonExit(r *ghttp.Request, code RespCode, msg string, data interface{}) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: code,
		Msg:  msg,
		Data: data,
	})
}

func SuccExit(r *ghttp.Request, data interface{}) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: SUCCESS,
		Data: data,
	})
}

func SuccExitMsg(r *ghttp.Request, msg string, data interface{}) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: SUCCESS,
		Msg:  msg,
		Data: data,
	})
}

//客户端显示提示信息
func FailExit(r *ghttp.Request, msg string) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: FAIL,
		Msg:  msg,
	})
}

//客户端显示提示信息
func FailExitData(r *ghttp.Request, msg string, data interface{}) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: FAIL,
		Msg:  msg,
		Data: data,
	})
}

//客户端不显示提示信息
func ErrorExit(r *ghttp.Request, msg string) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: ERROR,
		Msg:  msg,
	})
}

func UnauthorizedExit(r *ghttp.Request) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: UNAUTHORIZED,
		Msg:  "鉴权失败,请登录",
	})
}

func ExpiredExit(r *ghttp.Request) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: EXPIRED,
		Msg:  "登录过期,请重新登录",
	})
}

func UnauthOperateExit(r *ghttp.Request) {
	r.Response.WriteJsonExit(JsonResponse{
		Code: UNAUTHOPERATE,
		Msg:  "没有权限进行该操作",
	})
}
