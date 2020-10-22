package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SeeFansInfo struct {
	UserCount int                  `json:"all_count"`
	UserFans  []*model.SeeFansResp `json:"user_fans"`
}

//查看代购粉丝
func SeeFans(req *model.SeeFansReq, session *ghttp.Session) (resp *SeeFansInfo, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	fans, bingfans, err := model.SeeFans(req, sessionman.GetUserInfo(session).ShopID)
	for i := 0; i < len(fans); i++ {
		for j := 0; j < len(bingfans); j++ {
			if fans[i].UserID == bingfans[j].UserID {
				fans[i].IsRed = 1
				continue
			}
		}
	}
	userfans := make([]*model.SeeFansResp, 0)
	userfans = append(userfans, fans...)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看代购粉丝:%s", fans)
	resp = &SeeFansInfo{
		UserCount: len(fans),
		UserFans:  userfans,
	}
	return
}

type SearchFansInfo struct {
	UserCount int                     `json:"all_count"`
	UserFans  []*model.SearchFansResp `json:"user_fans"`
}

//搜索代购粉丝
func SearchFans(req *model.SearchFansReq, session *ghttp.Session) (resp *SearchFansInfo, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	fans, bingfans, err := model.SearchFans(req, sessionman.GetUserInfo(session).ShopID)
	for i := 0; i < len(fans); i++ {
		for j := 0; j < len(bingfans); j++ {
			if fans[i].UserID == bingfans[j].UserID {
				fans[i].IsRed = 1
				continue
			}
		}
	}
	userfans := make([]*model.SearchFansResp, 0)
	userfans = append(userfans, fans...)
	if err != nil {
		return resp, err
	}
	zaplog.Infof("查看代购粉丝:%s", fans)
	resp = &SearchFansInfo{
		UserCount: len(fans),
		UserFans:  userfans,
	}
	return
}
