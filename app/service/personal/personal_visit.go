package personal

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"time"

	"github.com/gogf/gf/net/ghttp"
	"github.com/gogf/gf/util/gconv"
)

type Visitinfo struct {
	AllCount   int                               `json:"all_count"`   //有多少数据
	TodayVisit int                               `json:"today_visit"` //今日访问量
	TotalVisit int                               `json:"total_visit"` //今日访问人数
	Visit      map[string][]*model.VisitInfoResp `json:"visit_info"`
}

//访问信息
func VisitInfo(req *model.VisitInfoReq, session *ghttp.Session) (resp *Visitinfo, err error) {
	if sessionman.GetUserInfo(session).ShopID != uint64(sessionman.GetUserInfo(session).UserID) {
		return
	}
	visit, visitcount, err := model.VisitInfo(req, sessionman.GetUserInfo(session).ShopID)
	if err != nil {
		return resp, err
	}
	resp = &Visitinfo{
		AllCount:   len(visit),
		TodayVisit: visitcount.TodayVisit,
		TotalVisit: visitcount.TotalVisit,
		Visit:      map[string][]*model.VisitInfoResp{},
	}

	for _, v := range visit {
		t := v.CreatedAt.Format("2006-01-02")
		resp.Visit[t] = append(resp.Visit[t], v)
	}
	return
}

type Visithistory struct {
	AllCount int                                  `json:"all_count"` //每一天的访问数量
	Visit    map[string][]*model.VisitHistoryResp `json:"visit_history"`
}

//访问历史（用户）
func VisitHistory(req *model.VisitHistoryReq, session *ghttp.Session) (resp *Visithistory, err error) {
	visit, err := model.VisitHistory(req, sessionman.GetUserInfo(session).UserID)
	if err != nil {
		return resp, err
	}

	resp = &Visithistory{AllCount: len(visit), Visit: map[string][]*model.VisitHistoryResp{}}

	for _, v := range visit {
		t := time.Unix(gconv.Int64(v.CreatedAt), 0).Format("2006-01-02")
		resp.Visit[t] = append(resp.Visit[t], v)
	}
	return
}
