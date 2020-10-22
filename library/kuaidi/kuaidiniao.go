package kuaidi

import (
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"net/url"
	"time"

	"github.com/gogf/gf/crypto/gmd5"
	"github.com/gogf/gf/encoding/gbase64"
	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/util/gconv"
	jsoniter "github.com/json-iterator/go"
)

//快递鸟平台
//订单寄收信息
type LogisticOrder struct {
	Company      string //寄收件人公司
	Name         string //寄收件人 【必填】
	Mobile       string //【必填】
	PostCode     string //寄收件地邮编(ShipperCode 为 EMS、YZPY、YZBK 时必填)
	ProvinceName string //寄收件省(如广东省，不要缺少“省”；如 是直辖市，请直接传北京、上海等；如是自治区，请直接传广西壮族自治区等)【必填】
	CityName     string //寄收件市(如深圳市，不要缺少 “市； 如是市辖区，请直接传北京 市、上海市等”)【必填】
	ExpAreaName  string //寄收件区/县(如福田区，不要缺 少“区”或“县”)【必填】
	Address      string //寄收件人详细地址【必填】
}

//订单寄收信息 必填信息判断是否为空
func (s *LogisticOrder) JudgeLogisticsNull() bool {
	return (s.ProvinceName == "" || s.CityName == "" || s.ExpAreaName == "" || s.Mobile == "" || s.Name == "" || s.Address == "")
}

//订单商品信息
type GoodsOrder struct {
	GoodsName     string  //名称 【必填】
	GoodsCode     string  //编码
	Goodsquantity int     //件数
	GoodsPrice    float64 //价格
	GoodsWeight   float64 //重量 kg
	GoodsVol      int     //体积 m3
	GoodsDesc     string  //商品描述
}

//申报价值
type Dutiable struct {
	DeclaredValue float64 //订单货物总声明价值，包含子母件，精确到小数点后3位 (ShipperCode为SF且收件地址为港澳台地区，必填)
}

//请求电子面单数据
type RequestDataEOrder struct {
	MemberID              string  //ERP 系统、电商平台等系统或 平台类型用户的会员 ID 或店 铺账号等唯一性标识，用于区 分其用户
	CustomerName          string  //客户号
	CustomerPwd           string  //客户密码 其他快递【必填】
	MonthCode             string  //密钥串 圆通【必填】使用
	SendSite              string  //网点名称
	ShipperCode           string  //快递公司编码 【必填】
	CustomArea            string  //商家自定义区域（根据物流公司是否支持）
	ThrOrderCode          string  //京东商城的订单号 (ShipperCode 为 JD 且 ExpType 为 1 时必填)
	OrderCode             string  //订单编号(自定义，不可重复)
	PayType               string  //运费支付方式： 1-现付，2-到付，3-月结，4- 第三方付(仅 SF、KYSY 支持)【必填】
	ExpType               string  //详细快递类型参考《快递公司 快递业务类型.xlsx》【必填】
	IsReturnSignBill      int     //是否要求签回单 0-不要求，1-要求
	OperateRequire        string  //签回单操作要求(如：签名、盖 章、身份证复印件等)
	Cost                  float64 //快递运费 Double(5)
	OtherCost             float64 //其他费用 Double(5)
	Receiver              *LogisticOrder
	Sender                *LogisticOrder
	IsNotice              int       //是否通知快递员上门揽件 0-通知，1-不通知，不填则默 认为 1
	StartDate             string    //上门揽件时间段，格式： EndDate YYYY-MM-DD HH24:MM:SS
	EndDate               string    //YYYY-MM-DD HH24:MM:SS
	Weight                float64   //包裹总重量 kg 1、 当为快运的订单时必填； 2、ShipperCode 为 JD 时必 填；
	Quantity              int       //包裹数(最多支持 300 件) 一个包裹对应一个运单号，如 果是大于 1 个包裹，返回则按 照子母件的方式返回母运单 号和子运单号 【必填】
	Volume                float64   //包裹总体积 （单位：m3） 1、当为快运的订单时必填；2、ShipperCode为 JD 时必填
	Remark                string    //备注
	AddService            []*string //增值服务名称 (数组形式，可以有多个增值服务)
	Commodity             []*GoodsOrder
	IsReturnPrintTemplate int    //是否返回电子面单模板： 0-不需要，1-需要
	IsSendMessage         int    //是否订阅短信： 0-不需要，1-需要
	IsSubscribe           int    //是否订阅轨迹推送 0-不订阅，1-订阅，不填默认 为 1
	TemplateSize          int    //模板规格 (默认的模板无需传值，非默认 模板传对应模板尺寸)
	PackingType           int    //包装类型(快运字段)； 0-纸，1-纤，2-木，3-托膜， 4-木托，99-其他
	DeliveryMethod        int    //送货方式/派送类型(快运字 段)： 0-自提 1-送货上门（不含上楼） 2-送货上楼 当 ShipperCode 为 JTSD 时必 填，支持以下传值： 3-派送上门 4-站点自提 5-快递柜自提 6-代收点自提
	CurrencyCode          string //货物单价的币种： CNY: 人民币 HKD: 港币 NTD: 新台币 MOP: 澳门元 (ShipperCode 为 SF 且收件 地址为港澳台地区，必填)
	Dutiable                     //申报订单价值
}

//快递鸟平台请求基础数据
type KNiaoBase struct {
	AppKey      string
	EBusinessID string
	DataType    string
	RequestType string
	RequestData string
	DataSign    string
}

//获取快递鸟平台数据
func (s *KNiaoBase) GetKNiaoDataString() (reqForm string) {
	reqForm = "EBusinessID=" + s.EBusinessID + "&DataType=" + s.DataType + "&RequestType=" + s.RequestType + "&DataSign=" + s.DataSign + "&RequestData=" + s.RequestData
	return
}

var (
	kniao_appKey      = "c00f4295-0270-4309-b3e3-e6ebc525624f"
	kniao_eBusinessID = "test1648855"
	kniao_dataType    = "2" //
	kniao_url         = "http://sandboxapi.kdniao.com:8080/kdniaosandbox/gateway/exterfaceInvoke.json"
	kniao_contentType = "application/x-www-form-urlencoded"
)

// PostEOrder 电子面单接口 ，应用级参数只使用json传输
//reqData==数据内容(URL 编码:UTF-8);EBusinessID==用户 ID;RequestType=请求指令类型;DataSign== 数据内容签名：把(请求内容(未编码)+ApiKey)进行 MD5 加密，然后 Base64编码，最后进行 URL(utf-8)编码; DataType==2(返回数据类型为 json)
func (s *KuaiDiThirdPlatformInfo) PostEOrder_KDN(reqData *RequestDataEOrder) (resDataInfo string, err error) {

	jsonBytes, err := jsoniter.Marshal(reqData)
	if err != nil {
		fmt.Println(err)
	}
	param := string(jsonBytes)
	md5ing_str := param + s.AppKey
	//md5
	DataSign, _ := gmd5.Encrypt(md5ing_str)
	//进行Base64编码
	DataSign = string(gbase64.Encode([]byte(DataSign)))
	//DataSign utf-8
	DataSign = url.QueryEscape(DataSign)
	//请求内容 utf-8
	param = url.QueryEscape(param)

	//应用级参数组合请求发送数据
	req_base := &KNiaoBase{
		AppKey:      s.AppKey,
		EBusinessID: s.EBusinessID,
		DataType:    kniao_dataType,
		RequestType: "1007",
		RequestData: param,
		DataSign:    DataSign,
	}
	reqFrom := req_base.GetKNiaoDataString() //
	//post
	c.SetContentType(kniao_contentType)
	resDataInfo = c.PostContent(s.InterfaceUrl, reqFrom)
	// zaplog.Infof("接收结果:%s ", resDataInfo)
	//响应结果解析
	if respParse, errTemp := gjson.DecodeToJson(resDataInfo); errTemp == nil {
		if gconv.Int(respParse.Get("ResultCode")) == 100 && (gconv.String(respParse.Get("Order.OrderCode")) == reqData.OrderCode || reqData.ShipperCode == "HTKY") {
			return resDataInfo, nil
		} else {
			zaplog.Infof("发货失败 原因:%s ", respParse.Get("Reason"))
			return resDataInfo, errors.New("发货失败")
		}
	}
	return "", errors.New("发货失败")
}

//即时查询物流信息
type OrderHandle struct {
	OrderCode    string //订单编号
	ShipperCode  string //物流公司编码
	LogisticCode string //快递单号
	CustomerName string //ShipperCode为SF且快递单号非快递鸟渠道返回时【必填】，对应收件人/寄件人手机号后四位
}

//查询物流即时信息
//该接口主流快递仅支持中通快递、申通快递、圆通速递 3 家，
//如需查询所有主流快递公司， 请选用在途监控服务
func (s *KuaiDiThirdPlatformInfo) PostOrderLog_KDN(reqData *OrderHandle) (resDataInfo string, state int) {
	jsonBytes, err := jsoniter.Marshal(reqData)
	if err != nil {
		fmt.Println(err)
	}
	param := string(jsonBytes)
	md5ing_str := param + s.AppKey
	//md5
	DataSign, _ := gmd5.Encrypt(md5ing_str)
	//进行Base64编码
	DataSign = string(gbase64.Encode([]byte(DataSign)))
	//DataSign utf-8
	DataSign = url.QueryEscape(DataSign)
	//请求内容 utf-8
	param = url.QueryEscape(param)

	//应用级参数组合请求发送数据
	req_base := &KNiaoBase{
		AppKey:      s.AppKey,
		EBusinessID: s.EBusinessID,
		DataType:    kniao_dataType,
		RequestType: "1002",
		RequestData: param,
		DataSign:    DataSign,
	}
	reqFrom := req_base.GetKNiaoDataString() //
	//post
	c.SetContentType(kniao_contentType)
	resDataInfo = c.PostContent(s.InterfaceUrl, reqFrom)
	zaplog.Infof("接收结果:%s ", resDataInfo)
	//响应结果解析
	if respParse, errTemp := gjson.DecodeToJson(resDataInfo); errTemp == nil {
		if gconv.Bool(respParse.Get("Success")) && gconv.String(respParse.Get("EBusinessID")) == s.EBusinessID {
			resDataInfo = gconv.String(respParse.Get("Traces")) //物流信息
			state = gconv.Int(respParse.Get("State"))
			return
		} else {
			zaplog.Infof("查询失败 原因:%s ", respParse.Get("Reason"))
			return "", 0
		}
	}
	return "", 0
}

type DistOrderParam struct {
	// OrderCode    string
	ShipperCode  string
	LogisticCode string
	CustomerName string // //ShipperCode 为 SF，且快递单号非快递鸟渠道返回时， 必填，对应收件人/寄件人手机号后四位
	ExpType      string //《快递公 司快递业务类型.xlsx》
	PayType      string //运费支付方式： 1-现付，2-到付，3-月结，4- 第三方付(仅 SF、KYSY 支 持)
	// Receiver     *LogisticOrder //收件人信息
	// Sender       *LogisticOrder //寄件人信息
}

//轨迹订阅
//该接口主流快递仅支持中通快递、申通快递、圆通速递 3 家，
//如需查询所有主流快递公司， 请选用在途监控服务
func (s *KuaiDiThirdPlatformInfo) PostOrderDist_KDN(reqData *DistOrderParam) (resDataInfo string) {
	jsonBytes, err := jsoniter.Marshal(reqData)
	if err != nil {
		fmt.Println(err)
	}
	param := string(jsonBytes)
	md5ing_str := param + s.AppKey
	//md5
	DataSign, _ := gmd5.Encrypt(md5ing_str)
	//进行Base64编码
	DataSign = string(gbase64.Encode([]byte(DataSign)))
	//DataSign utf-8
	DataSign = url.QueryEscape(DataSign)
	//请求内容 utf-8
	param = url.QueryEscape(param)

	//应用级参数组合请求发送数据
	req_base := &KNiaoBase{
		AppKey:      s.AppKey,
		EBusinessID: s.EBusinessID,
		DataType:    kniao_dataType,
		RequestType: "1008",
		RequestData: param,
		DataSign:    DataSign,
	}
	reqFrom := req_base.GetKNiaoDataString() //
	//post
	c.SetContentType(kniao_contentType)
	resDataInfo = c.PostContent(s.InterfaceUrl, reqFrom)
	zaplog.Infof("接收结果:%s ", resDataInfo)
	//响应结果解析
	if respParse, errTemp := gjson.DecodeToJson(resDataInfo); errTemp == nil {
		if gconv.Bool(respParse.Get("Success")) && gconv.String(respParse.Get("EBusinessID")) == s.EBusinessID {
			resDataInfo = gconv.String(respParse.Get("UpdateTime")) //物流信息
			return
		} else {
			zaplog.Infof("轨迹订阅失败 原因:%s ", respParse.Get("Reason"))
			return ""
		}
	}
	return ""
}

type TracesInfo struct {
	AcceptTime    time.Time `json:"AcceptTime"`    //轨迹发生时间
	AcceptStation string    `json:"AcceptStation"` //轨迹描述
}

//轨迹数据集合
type OrderPushQueryDataList struct {
	EBusinessID  string        `json:"EBusinessID"`  //用户 ID
	ShipperCode  string        `json:"ShipperCode"`  //快递公司编码
	LogisticCode string        `json:"LogisticCode"` //快递单号
	Success      bool          `json:"Success"`      //成功与否(true/false)
	State        string        `json:"State"`        //物流状态:0-暂无轨迹信息 1-已揽收 2-在途中 3-签收 4-问题件
	Reason       string        `json:"Reason"`       //失败原因
	Traces       []*TracesInfo `json:"Traces"`       //轨迹记录
}

//轨迹推送接口
type OrderPushQueryDataReq struct {
	EBusinessID string                    `json:"EBusinessID"` //用户 ID
	PushTime    time.Time                 `json:"PushTime"`    // 推送时间
	Count       string                    `json:"Count"`       //推送轨迹的快递单号个数
	Data        []*OrderPushQueryDataList `json:"Data"`        //推送轨迹的轨迹数据集合
}

//轨迹推送接口
// 1. 返回的物流轨迹信息按照发生时间的升序排列。
// 2. 轨迹推送是异步推送的，系统拉取到轨迹后调用用户推送接口推送轨迹数据。
// 3. 若 Data 接收到推送 Success 为 false，且 Reason 为三天无轨迹，需重新发起订阅。
// 4. 若 Data 接收到推送 Success 为 false，且 Reason 为七天内无轨迹变化，需重新发起 订阅。
// 5. 若 Data 接收到推送 Success 为 false，且 State 为 0，属于正常推送，需耐心等待下次 推送即可。
// 6. 在没有返回信息或者返回不符合规定的情况下，会判断为推送失败。推送失败后会重试 推送 2 次，首次间隔 15 分钟，二次间隔半个小时，两次都失败就不会再推送，直到下 次有轨迹更新才会再次推送，建议您严格按照技术文档进行返回。
type OrderPushQueryDataResp struct {
	EBusinessID string      `json:"EBusinessID"` //用户 ID
	UpdateTime  entity.Time `json:"UpdateTime"`  //更新时间
	Success     bool        `json:"Success"`     //成功(true)失败（false）
	Reason      string      `json:"Reason"`      //失败原因
}
