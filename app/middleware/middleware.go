package middleware

import (
	"daigou/app/authcasbin"
	"daigou/app/service/user/sessionman"
	"daigou/library/conf"
	"daigou/library/response"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

var (
	wxLogin = "/daigou/api/v{version}/user/wxLogin"
)

// 允许接口跨域请求
func CORS(r *ghttp.Request) {
	corsOptions := r.Response.DefaultCORSOptions()
	// corsOptions.AllowDomain = []string{"goframe.org", "johng.cn"}
	r.Response.CORS(corsOptions)
	r.Middleware.Next()
}

// 鉴权中间件，只有登录成功之后才能通过
func Auth(r *ghttp.Request) {
	zaplog.Infof("url=%s", r.GetUrl())
	if sessionman.CheckSession(r.Session) {
		r.Middleware.Next()
	} else {
		response.UnauthorizedExit(r)
	}
}

func Log(r *ghttp.Request) {
	//打印参数日志
	var jsonStr string
	tmp, err := r.GetJson()
	if err == nil {
		jsonStr, err = tmp.ToJsonString()
	}
	zaplog.Infof("***Request***:url=%s,sessionId=%s,args=%s,err=%s", r.Router.Uri, r.Header.Get(conf.Conf.Server.SessionIdName), jsonStr, err)
	r.Middleware.Next()
}

//错误处理
func ErrorHandler(r *ghttp.Request) {
	r.Middleware.Next()
	//过滤掉服务器敏感信息
	// resp := (*response.JsonResponse)(nil)
	// err := jsoniter.Unmarshal(r.Response.Buffer(), &resp)
	// if err != nil {
	// 	zaplog.Infof("ErrorHandler:jsoniter.Unmarshal err=%s", err)
	// 	return
	// }
	// if resp.Code != response.SUCCESS {
	// 	//去除错误描述
	// 	resp.Msg = ""
	// 	r.Response.ClearBuffer()
	// 	r.Response.WriteJsonExit(resp)
	// }
}

func CasbinMiddleware(r *ghttp.Request) {
	//获取path
	path := r.Router.Uri
	if path == wxLogin {
		r.Middleware.Next()
	} else {
		//获取user_id
		out := sessionman.GetUserInfo(r.Session)
		if out == nil {
			zaplog.Errorf("CasbinMiddleware err:无法找到session")
			response.ExpiredExit(r)
			return
		}
		has, err := authcasbin.Enforce(out.UserID, path)
		if err != nil {
			response.ErrorExit(r, err.Error())
		} else if has { //权限记录的是无法操作的api
			response.UnauthOperateExit(r)
		}
		r.Middleware.Next()
	}
}
