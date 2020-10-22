package sessionman

import (
	"daigou/app/model"
	"daigou/library/conf"
	"daigou/library/redis"
	"daigou/library/zaplog"
	"time"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/os/gsession"
	jsoniter "github.com/json-iterator/go"
)

var (
	sessionMemory = gsession.NewStorageMemory()
)

const (
	Session_Info = "session_info"
	User_Info    = "user_info"
)

//用于用户携带token登录时直接从redis获取信息返回
type UserInfo struct {
	*model.DbWxLoginOut
	Type     int32  `json:"type,omitempty"`
	ShopCode string `json:"shop_code,omitempty"` //生成的店铺码
}

type SessionInfo struct {
	OpenId     string `json:"open_id"`
	SessionKey string `json:"session_key"`
	UnionId    string `json:"union_id"`
}

//CheckSession 检查session是否有效
func CheckSession(session *gsession.Session) bool {
	return session.Contains(Session_Info)
}

func GetSessionInfo(session *ghttp.Session) (out *SessionInfo) {
	if session.Contains(Session_Info) {
		jsoniter.Unmarshal([]byte(session.GetString(Session_Info)), &out)
	}
	return
}

func GetUserInfo(session *ghttp.Session) (out *UserInfo) {
	if session.Contains(User_Info) {
		jsoniter.Unmarshal([]byte(session.GetString(User_Info)), &out)
	}
	return
}

//更新session信息
func UpdateSession(session *ghttp.Session, info interface{}) {
	var key string
	switch info.(type) {
	case *SessionInfo:
		key = Session_Info
	case *UserInfo:
		key = User_Info
		userInfo := info.(*UserInfo)
		redis.UpdateSessionMap(&redis.SessionMap{UserID: userInfo.UserID, SessionID: key})
	default:
		zaplog.Errorf("UpdateSession type assert err")
		return
	}

	//保存微信信息
	session.Set(key, info)
	//刷新ttl
	duration, err := time.ParseDuration(conf.Conf.Server.SessionMaxAge)
	if err != nil {
		zaplog.Errorf(err.Error())
	}
	sessionMemory.UpdateTTL(session.Id(), duration)
}

//判断店铺是否属于自己
func IsShopOwner(session *ghttp.Session, _shopID uint64) bool {
	return _shopID != 0 && GetUserInfo(session).ShopID == _shopID
}
