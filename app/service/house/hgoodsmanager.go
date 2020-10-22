package house

//商品库商品管理
import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"

	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/gf/util/gconv"
)

//入库添加
type CreateHouseReq struct {
	*model.HouseInfoReq
}

func CreateHouse(req *CreateHouseReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限创建商品库存"
		return
	}
	//数据校验
	if model.RepeatHGoodsName(req.HgsName, 0, _shopId) {
		msg = "商品名称已存在，请重新输入"
		return
	}
	if req.HgsInprice < 0 || req.HgsSaleprice < 0 {
		msg = "商品价格为非负数，请重新输入"
		return
	}
	//数据插入保存
	if _, err = model.CreateHouseInfo(req.HouseInfoReq, _shopId); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//入库编辑
type EditHouseReq struct {
	*model.HouseGoodsInfo // 仓库商品 id
}

func EditHouse(req *EditHouseReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限修改商品库"
		return
	}
	//数据校验
	if model.RepeatHGoodsName(req.HgsName, gconv.Uint64(req.HgsID), _shopId) {
		msg = "商品名称已存在，请重新输入"
		return
	}
	//数据修改
	if err = model.EditHouse(req.HouseGoodsInfo); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//修改库存数量
type HouseNumReq struct {
	*model.HouseNum
}

func ModHouseNum(req *HouseNumReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限修改库存"
		return
	}
	if req.HgsSurplusnum < 0 {
		msg = "修改库存无效，请输入非负数库存"
		return
	}
	//数据修改
	if err = model.ModHouseNum(req.HouseNum); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//入库查看详情
type GetHouseDetailReq struct {
	*model.OSHouseReq
}
type GetHouseDetailResp struct {
	HouseInfo *model.HouseDetailInfo `json:"house_info"`
}

func GetHouseDetail(req *GetHouseDetailReq, session *gsession.Session) (resp *GetHouseDetailResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	resp = &GetHouseDetailResp{}
	//数据获取
	if resp.HouseInfo, err = model.GetHouseDetail(req.OSHouseReq); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//库存简易详情
type GetHouseEasyReq struct {
	*model.OSHouseReq
}
type GetHouseEasyResp struct {
	*model.HouseEasyInfo
}

//获取库存简易详情
func GetHouseEasy(req *GetHouseEasyReq, session *gsession.Session) (resp *GetHouseEasyResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	resp = &GetHouseEasyResp{}

	//数据获取
	if resp.HouseEasyInfo, err = model.GetHouseEasy(req.OSHouseReq); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//库存记录详情
type GetHouseStockRecordReq struct {
	*model.OSHouseReq
	*model.PageHouseReq
}
type GetHouseStockRecordResp struct {
	Count     int                       `json:"count"`      //数目
	StockList []*model.HouseStockRecord `json:"stock_list"` //库存记录列表
}

//获取库存记录详情
func GetHouseStockRecord(req *GetHouseStockRecordReq, session *gsession.Session) (resp *GetHouseStockRecordResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	resp = &GetHouseStockRecordResp{}

	resp.StockList = make([]*model.HouseStockRecord, 0)
	//数据获取
	if resp.Count, resp.StockList, err = model.GetHouseStockRecord(req.OSHouseReq, req.PageHouseReq); err != nil {
		return
	} else { //返回结果
		msg = ""
		err = nil
	}
	return
}

//入库查看列表
type GetHouseListReq struct {
	*model.PageHouseReq
	InputTerms      string `json:"input_terms"`      //搜索输入词 为空表示查看全部
	InventoryStatus uint32 `json:"inventory_status"` //1:在售  2:在库  4:即将过期  8:库存<3
}

type GetHouseListResp struct {
	HouseCount int                    `json:"house_count"` // 列表个数
	HouseList  []*model.HouseInfoResp `json:"house_list"`  //列表
}

func GetHouseList(req *GetHouseListReq, session *gsession.Session) (resp *GetHouseListResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	//校验数据
	if req.Count <= 0 || req.StartIndex < 0 {
		msg = "查看参数非法"
		return
	}
	resp = &GetHouseListResp{}
	resp.HouseList = make([]*model.HouseInfoResp, 0)
	if req.InventoryStatus > 0 {
		//状态搜索
		resp.HouseCount, resp.HouseList, err = model.StatusHouseList(req.PageHouseReq, req.InputTerms, req.InventoryStatus, _shopId)
	} else {
		if req.InputTerms == "" {
			//查看列表
			resp.HouseCount, resp.HouseList, err = model.GetHouseList(req.PageHouseReq, _shopId)
		} else {
			//搜索请求
			resp.HouseCount, resp.HouseList, err = model.SearchHouseList(req.PageHouseReq, req.InputTerms, _shopId)
		}
	}
	return
}

//进货
type InputHouseGoodsReq struct {
	model.OSHouseReq
	*model.InputHouse
}

func InputHouseGoods(req *InputHouseGoodsReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限进货操作"
		return
	}
	//数据校验
	if req.HsrNum <= 0 {
		msg = "进货不能填写数量为0"
		return
	}
	msg, err = model.InputHouseGoods(req.InputHouse, gconv.Uint64(req.HgsID))
	return
}

//商品库删除
type DelHouseReq struct {
	*model.OSHouseReq
}

func DelHouse(req *DelHouseReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限删除商品库存"
		return
	}
	msg, err = model.DelHouseGoods(gconv.Uint64(req.HgsID), _shopId)
	return
}

//商品库中下架商品
type DownGoodsReq struct {
	*model.OSHouseReq
}

func DownGoods(req *DownGoodsReq, session *gsession.Session) (msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限下架商品"
		return
	}
	msg, err = model.DownGoods(gconv.Uint64(req.HgsID), _shopId)
	return
}

//订单统计
func OrderStatistics(req *model.OrderStatisticsReq, session *gsession.Session) (resp []*model.OrderStatisticsResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	//校验数据
	if req.Count <= 0 || req.StartIndex < 0 {
		msg = "查看参数非法"
		return
	}
	resp, err = model.OrderStatistics(req, _shopId)
	return
}

//预购清单统计
func PreOrderListStatistics(req *model.PreOrderListStatisticsReq, session *gsession.Session) (resp *model.PreOrderListStatisticsResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	resp, err = model.PreOrderListStatistics(req, _shopId)
	return
}

//收款发货统计
func CollectionDeliveryStatistics(req *model.CollectionDeliveryStatisticsReq, session *gsession.Session) (resp *model.CollectionDeliveryStatisticsResp, msg string, err error) {
	//权限校验
	_shopId := sessionman.GetUserInfo(session).ShopID
	if _shopId != uint64(sessionman.GetUserInfo(session).UserID) || _shopId == 0 {
		msg = "无权限获取信息"
		return
	}
	resp, err = model.CollectionDeliveryStatistics(req, _shopId)
	return
}
