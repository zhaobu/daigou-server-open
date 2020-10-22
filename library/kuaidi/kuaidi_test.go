package kuaidi

import (
	"fmt"
	"testing"
)

func Test_OrderEOrder(t *testing.T) {
	data_kdn := &RequestDataEOrder{
		OrderCode:   "012657018199",
		ShipperCode: "SF",
		PayType:     "1",
		MonthCode:   "1234567890",
		ExpType:     "1",
		Cost:        1.0,
		OtherCost:   1.0,
		Sender: &LogisticOrder{
			Company:      "LV",
			Name:         "Taylor",
			Mobile:       "15018442396",
			ProvinceName: "上海",
			CityName:     "上海市",
			ExpAreaName:  "青浦区",
			Address:      "明珠路",
		},
		Receiver: &LogisticOrder{
			Company:      "GCCUI",
			Name:         "Yann",
			Mobile:       "15018442396",
			ProvinceName: "北京",
			CityName:     "北京市",
			ExpAreaName:  "朝阳区",
			Address:      "三里屯街道",
		},
		Commodity: []*GoodsOrder{
			&GoodsOrder{
				GoodsName:     "鞋子",
				Goodsquantity: 1,
				GoodsWeight:   1.0,
			}, &GoodsOrder{
				GoodsName:     "衣服",
				Goodsquantity: 1,
				GoodsWeight:   1.0,
			}},
		Weight:   1.0,
		Quantity: 1,
		Volume:   0.0,
		Remark:   "你好",
	}
	thirdPlatformInterfaceInfo := &KuaiDiThirdPlatformInfo{
		AppKey:       "f269d5bb-23ed-44ad-9d2c-2c00ca758a54",
		EBusinessID:  "test1653950",
		InterfaceUrl: "http://sandboxapi.kdniao.com:8080/kdniaosandbox/gateway/exterfaceInvoke.json",
	}
	resDataInfo, _ := thirdPlatformInterfaceInfo.PostEOrder_KDN(data_kdn)
	fmt.Sprintln(resDataInfo)
}

func Test_OrderDist(t *testing.T) {
	data_kdn := &DistOrderParam{
		ShipperCode:  "STO",
		LogisticCode: "773047797625511",
		// CustomerName: dbData.ReceiverIphone[7:],
		PayType: "1",
		ExpType: "1",
	}
	thirdPlatformInterfaceInfo := &KuaiDiThirdPlatformInfo{
		AppKey:       "92e84912-48e2-4078-b4a6-588a7e6e5931",
		EBusinessID:  "1648855",
		InterfaceUrl: "http://api.kdniao.com/api/dist",
	}
	thirdPlatformInterfaceInfo.PostOrderDist_KDN(data_kdn)
}

func Test_OrderSelect(t *testing.T) {
	data_kdn := &OrderHandle{
		ShipperCode:  "STO",
		LogisticCode: "773047797625511",
	}
	thirdPlatformInterfaceInfo := &KuaiDiThirdPlatformInfo{
		AppKey:       "92e84912-48e2-4078-b4a6-588a7e6e5931",
		EBusinessID:  "1648855",
		InterfaceUrl: "http://api.kdniao.com/Ebusiness/EbusinessOrderHandle.aspx",
	}
	thirdPlatformInterfaceInfo.PostOrderLog_KDN(data_kdn)
}
