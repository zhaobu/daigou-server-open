package user

import (
	"daigou/app/model"
	"daigou/library/zaplog"

	"github.com/gogf/gf/os/gsession"
)

type GetRecommendShopReq struct {
}

type GetRecommendShopResp struct {
	*model.DbGetRecommendShopOut1
	CategoryInfo []string `json:"category_info"` //分类信息
}

func GetRecommendShop(req *GetRecommendShopReq, session *gsession.Session) (resp []*GetRecommendShopResp, err error) {
	zaplog.Debugf("req=%+v", req)
	dbOut, err := model.GetRecommendShop(nil)
	if err != nil {
		zaplog.Errorf("GetRecommendShop err:%s", err)
		return nil, err
	}
	//解析分类信息

	resp = make([]*GetRecommendShopResp, 0, len(dbOut))

	for _, v := range dbOut {
		info := &GetRecommendShopResp{DbGetRecommendShopOut1: v.DbGetRecommendShopOut1}
		//分类信息
		if v.ShopID > 999999 {
			res, err := model.CategoryName(uint64(v.ShopID))
			if err != nil {
				return nil, err
			}
			categoryInfo := make([]string, 0, len(res))

			for _, id := range res {
				categoryInfo = append(categoryInfo, id.CategoryName)
			}
			info.CategoryInfo = categoryInfo
		}
		resp = append(resp, info)
	}
	return
}
