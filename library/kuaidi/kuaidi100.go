package kuaidi

import (
	"daigou/library/zaplog"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/gogf/gf/crypto/gmd5"
	"github.com/gogf/gf/encoding/gjson"
	"github.com/gogf/gf/util/gconv"
	jsoniter "github.com/json-iterator/go"
)

var (
	secret_kd100      = "7611726d909c428a809ce0e2f13133b9"
	key_kd100         = "FWLHzPYR8520"                      //快递100平台密钥
	contenttype_kd100 = "application/x-www-form-urlencoded" //请求接口类型
)

//请求第三方快递100获取快递信息
type PostOtherLogistics struct {
	Com      string `json:"com"` //物流公司编号
	Num      string `json:"num"` //物流单号
	From     string `json:"from"`
	Phone    string `json:"phone"`
	To       string `json:"to"`
	Resultv2 string `json:"resultv2"`
	Show     string `json:"show"`
	Order    string `json:"order"` //时间排序
}

//请求第三方平台获取快递物流即时信息
//com 快递公司编码，num 快递编号
func (s *KuaiDiThirdPlatformInfo) PostOrderLog(com string, num string) (dataInfo string, state int) {
	customer := s.EBusinessID //"2BEA0ED9C9D87994062A3BE3F62C4590"
	_reqData := PostOtherLogistics{
		Com:      com, //"yunda"
		Num:      num, //"3504390169664"
		Resultv2: "0",
		Show:     "0",
		Order:    "asc",
	}
	jsonBytes, err := jsoniter.Marshal(_reqData)
	if err != nil {
		fmt.Println(err)
	}
	param := string(jsonBytes)
	key := s.AppKey //"FWLHzPYR8520"
	sign, _ := gmd5.Encrypt(param + key + customer)
	sign = strings.ToUpper(sign)
	req := "customer=" + customer + "&param=" + param + "&sign=" + sign
	c.SetContentType(contenttype_kd100)
	dataInfo = c.PostContent(s.InterfaceUrl, req)
	if _reParse, err := gjson.DecodeToJson(dataInfo); err == nil {
		if gconv.Int(_reParse.Get("status")) == 200 {
			dataInfo = gconv.String(_reParse.Get("data"))
			state = gconv.Int(_reParse.Get("state"))
			return
		} else {
			zaplog.Infof("物流即时信息失败 原因:%s ", _reParse.Get("Reason"))
		}
	}
	return "", 0
}

//电子面单请求参数 图片模板返回
type KD100EOrderIMGReq struct {
	Type             string `json:"type"`             //业务类型，默认为 10 是
	PartnerId        string `json:"partnerId"`        //电子面单客户账户或月结账号，需贵司向当地快递公司网点申请； 是否必填该属性，请查看参数字典 是
	PartnerKey       string `json:"partnerKey"`       //电子面单密码，需贵司向当地快递公司网点申请； 是否必填该属性，请查看参数字典
	Net              string `json:"net"`              //收件网点名称,由快递公司当地网点分配， 若使用淘宝授权填入（taobao），使用菜鸟授权填入（cainiao）。 是否必填该属性，请查看参数字典
	Kuaidicom        string `json:"kuaidicom"`        //快递公司的编码，一律用小写字母，见参数字典
	RecManName       string `json:"recManName"`       //收件人姓名 是
	RecManMobile     string `json:"recManMobile"`     //收件人的手机号，手机号和电话号二者其一必填 是
	RecManPrintAddr  string `json:"recManPrintAddr"`  //收件人所在完整地址，如广东深圳市深圳市南山区科技南十二路 2 号金蝶软件园 是
	SendManName      string `json:"sendManName"`      //寄件人姓名 是
	SendManMobile    string `json:"sendManMobile"`    //寄件人的手机号，手机号和电话号二者其一必填 是
	SendManPrintAddr string `json:"sendManPrintAddr"` //寄件人所在的完整地址，如广东深圳市深圳市南山区科技南十二路 2 号金蝶软件园 B10 是
	Tempid           string `json:"tempid"`           //通过管理后台的打印模板配置信息获取 是
	Cargo            string `json:"cargo"`            //物品名称,例：文件 否
	Count            string `json:"count"`            //物品总数量。 另外该属性与子单有关，如果需要子单（指同一个订单打印出多张电子面单，即同一个订单返回多个面单号），needChild = 1、count 需要大于 1，如 count = 2 则一个主单 一个子单，count = 3 则一个主单 二个子单；返回的子单号码见返回结果的 childNum 字段 是
	Weight           string `json:"weight"`           //物品总重量 KG，例：1.5，单位 kg 否
	PayType          string `json:"payType"`          //支付方式： SHIPPER：寄方付（默认） CONSIGNEE：到付 MONTHLY：月结 THIRDPARTY：第三方支付 （详细请参考参数字典） 否
	ExpType          string `json:"expType"`          //快递类型： 标准快递（默认） 顺丰标快（陆运） EMS 经济 （详细请参考参数字典） 否
	Remark           string `json:"remark"`           //备注 否
	//面单扩展属性
	ValinsPay       string `json:"valinsPay"`       //保价额度 否
	Collection      string `json:"collection"`      //代收货款额度 	否
	NeedChild       string `json:"needChild"`       //是否需要子单： 1：需要 0：不需要(默认) 如果需要子单（指同一个订单打印出多张电子面单，即同一个订单返回多个面单号）； needChild = 1、count 需要大于 1，如 count = 2 一个主单 一个子单，count = 3 一个主单 二个子单，返回的子单号码见返回结果的 childNum 字段 否
	NeedBack        string `json:"needBack"`        //是否需要回单： 1：需要 0：不需要(默认) 返回的回单号见返回结果的 returnNum 字段 否
	OrderId         string `json:"orderId"`         //贵司内部自定义的订单编号,需要保证唯一性 否
	Height          string `json:"height"`          //生成图片的高，以 mm 为单位，例如：100 否
	Width           string `json:"width"`           //生成图片的宽，以 mm 为单位，例如：75 否
	Salt            string `json:"salt"`            //签名用随机字符串 否
	Op              string `json:"op"`              //是否开启订阅功能 0：不开启(默认) 1：开启 说明开启订阅功能时：pollCallBackUrl 必须填入 此功能只针对有快递单号的单 否
	PollCallBackUrl string `json:"pollCallBackUrl"` //如果 op 设置为 1 时，pollCallBackUrl 必须填入，用于跟踪回调 否
	Resultv2        string `json:"resultv2"`        //添加此字段表示开通行政区域解析功能, 详细见：快递信息推送接口文档相关说明。 0：关闭（默认） 1：开通行政区域解析功能 否
}

type Rec_SendMan struct {
	Name      string `json:"name"`      //寄收件人姓名 是
	Mobile    string `json:"mobile"`    //寄收件人的手机号，手机号和电话号二者其一必填 是
	PrintAddr string `json:"printAddr"` //寄收件人所在完整地址，如广东深圳市深圳市南山区科技南十二路 2 号金蝶软件园 是
	Company   string `json:"company"`   //寄收件人所在公司名称
}

//电子面单请求参数 HTML模板返回
type KD100EOrderHTMLReq struct {
	PartnerId  string       `json:"partnerId"`  //电子面单客户账户或月结账号，需贵司向当地快递公司网点申请； 是否必填该属性，请查看参数字典 是
	PartnerKey string       `json:"partnerKey"` //电子面单密码，需贵司向当地快递公司网点申请； 是否必填该属性，请查看参数字典
	Net        string       `json:"net"`        //收件网点名称,由快递公司当地网点分配， 若使用淘宝授权填入（taobao），使用菜鸟授权填入（cainiao）。 是否必填该属性，请查看参数字典
	Kuaidicom  string       `json:"kuaidicom"`  //快递公司的编码，一
	RecMan     *Rec_SendMan `json:"recMan"`     //  收件人信息
	SendMan    *Rec_SendMan `json:"sendMan"`    // 寄件人信息
	Cargo      string       `json:"cargo"`      //物品名称,例：文件 否
	Count      string       `json:"count"`      //物品总数量。 另外该属性与子单有关，如果需要子单（指同一个订单打印出多张电子面单，即同一个订单返回多个面单号），needChild = 1、count 需要大于 1，如 count = 2 则一个主单 一个子单，count = 3 则一个主单 二个子单；返回的子单号码见返回结果的 childNum 字段 是
	Weight     string       `json:"weight"`     //物品总重量 KG，例：1.5，单位 kg 否
	PayType    string       `json:"payType"`    //支付方式： SHIPPER：寄方付（默认） CONSIGNEE：到付 MONTHLY：月结 THIRDPARTY：第三方支付 （详细请参考参数字典） 否
	ExpType    string       `json:"expType"`    //快递类型： 标准快递（默认） 顺丰标快（陆运） EMS 经济 （详细请参考参数字典） 否
	Remark     string       `json:"remark"`     //备注 否
	//面单扩展属性
	ValinsPay       string `json:"valinsPay"`       //保价额度 否
	Collection      string `json:"collection"`      //代收货款额度 	否
	NeedChild       string `json:"needChild"`       //是否需要子单： 1：需要 0：不需要(默认) 如果需要子单（指同一个订单打印出多张电子面单，即同一个订单返回多个面单号）； needChild = 1、count 需要大于 1，如 count = 2 一个主单 一个子单，count = 3 一个主单 二个子单，返回的子单号码见返回结果的 childNum 字段 否
	NeedBack        string `json:"needBack"`        //是否需要回单：1:需要、0:不需要(默认)。返回的回单号见返回结果的returnNum字段
	NeedTemplate    string `json:"needTemplate"`    //是否需要回单： 1：需要 0：不需要(默认) 返回的回单号见返回结果的 returnNum 字段 否
	OrderId         string `json:"orderId"`         //贵司内部自定义的订单编号,需要保证唯一性 否
	Salt            string `json:"salt"`            //签名用随机字符串 否
	Op              string `json:"op"`              //是否开启订阅功能 0：不开启(默认) 1：开启 说明开启订阅功能时：pollCallBackUrl 必须填入 此功能只针对有快递单号的单 否
	PollCallBackUrl string `json:"pollCallBackUrl"` //如果 op 设置为 1 时，pollCallBackUrl 必须填入，用于跟踪回调 否
	Resultv2        string `json:"resultv2"`        //添加此字段表示开通行政区域解析功能, 详细见：快递信息推送接口文档相关说明。 0：关闭（默认） 1：开通行政区域解析功能 否
}

//请求第三方平台获取电子面单
func (s *KuaiDiThirdPlatformInfo) PostEOrder(reqData interface{}) (dataInfo string, err error) {
	method := ""          //业务类型
	url := s.InterfaceUrl //请求接口url
	switch reqData.(type) {
	case *KD100EOrderIMGReq:
		method = "getPrintImg" //业务类型
		url = "https://poll.kuaidi100.com/printapi/printtask.do"
	case *KD100EOrderHTMLReq:
		method = "getElecOrder" //业务类型
		url = "http://poll.kuaidi100.com/eorderapi.do"
	default:
		fmt.Println("unknown type!")
		return
	}

	jsonBytes, err1 := jsoniter.Marshal(reqData)
	if err1 != nil {
		fmt.Println(err1)
		return "", err1
	}
	param := string(jsonBytes)
	key := s.AppKey
	secret := s.EBusinessID
	t := gconv.String(time.Now().Unix()) //当前时间戳
	sign, _ := gmd5.Encrypt(param + t + key + secret)
	sign = strings.ToUpper(sign)
	req := "method=" + method + "&param=" + param + "&key=" + key + "&t=" + t + "&sign=" + sign
	c.SetContentType(contenttype_kd100)
	dataInfo = c.PostContent(url, req)
	if _reParse, err := gjson.DecodeToJson(dataInfo); err == nil {
		if gconv.Bool(_reParse.Get("result")) {
			// dataInfo = gconv.string(_reParse.Get("data"))
			return dataInfo, nil
		} else {
			zaplog.Infof("电子面单失败 原因:%s ", _reParse.Get("message"))
		}
	}
	return "", errors.New("发货失败")
}

// 提供运单号的物流跟踪信息，一个单交给快递100后，快递100对运单进行监控，如果监控到有更新，就主动将物流跟踪信息推送到贵方的服务器，贵方将之保存到数据库。然后当用户登录贵方网站、系统或手机APP时，直接从贵方的数据库读取数据，并显示于贵方的网站、系统或手机APP
//物流订阅请求
//接口地址:https://poll.kuaidi100.com/poll

type ParametersInfo struct {
	Callbackurl        string `json:"callbackurl"`        //必须 https://cwyx.chengyouhd.com/daigou/api/v1/order/pushQueryDataKdn	回调接口的地址。如果需要在推送信息回传自己业务参数，可以在回调地址URL后面拼接上去，如示例中的orderId
	Salt               string `json:"salt"`               //可选 签名用随机字符串。32位自定义字符串。添加该参数，则推送的时候会增加sign给贵司校验消息的可靠性
	Resultv2           string `json:"resultv2"`           //可选 1 添加此字段表示开通行政区域解析功能。0：关闭（默认），1：开通行政区域解析功能
	AutoCom            string `json:"autoCom"`            //可选 1 添加此字段且将此值设为1，则表示开始智能判断单号所属公司的功能，开启后，company字段可为空,即只传运单号（number字段），我方收到后会根据单号判断出其所属的快递公司（即company字段）。建议只有在无法知道单号对应的快递公司（即company的值）的情况下才开启此功能
	InterCom           string `json:"interCom"`           //可选 1 添加此字段表示开启国际版，开启后，若订阅的单号（即number字段）属于国际单号，会返回出发国与目的国两个国家的跟踪信息，本功能暂时只支持邮政体系（国际类的邮政小包、EMS）内的快递公司，若单号我方识别为非国际单，即使添加本字段，也不会返回destResult元素组
	DepartureCountry   string `json:"departureCountry"`   //可选 CN 出发国家编码
	DepartureCom       string `json:"departureCom"`       //可选 ems 出发国家快递公司的编码
	DestinationCountry string `json:"destinationCountry"` //可选 JP 目的国家编码
	DestinationCom     string `json:"destinationCom"`     //可选 japanposten 目的国家快递公司的编码
	Phone              string `json:"phone"`              //可选 13868688888 收件人或寄件人的手机号或固话（顺丰单号必填，也可以填写后四位，如果是固话，请不要上传分机号）
}

//请求结构体
type DisOrderInfoReq struct {
	Company    string         `json:"company"`    //必须 ems 订阅的快递公司的编码，一律用小写字母
	Number     string         `json:"number"`     //必须 EM263999513JP	订阅的快递单号，单号的最大长度是32个字符
	From       string         `json:"from"`       //可选 广东省深圳市南山区，出发地城市，省-市-区，非必填，填了有助于提升签收状态的判断的准确率，请尽量提供
	To         string         `json:"to"`         //可选 北京市朝阳区，目的地城市，省-市-区，非必填，填了有助于提升签收状态的判断的准确率，且到达目的地后会加大监控频率，请尽量提供
	Key        string         `json:"key"`        //必须 我方分配给贵司的的授权key，点击查看账号信息
	Parameters ParametersInfo `json:"parameters"` //必须 附加参数信息
}

//订阅请求方法
func (s *KuaiDiThirdPlatformInfo) PostDistOrderRequst(reqData *DisOrderInfoReq) (string, error) {
	schema := "json"      //返回数据格式
	url := s.InterfaceUrl // "https://poll.kuaidi100.com/poll" //请求接口url
	reqData.Key = key_kd100
	jsonBytes, err1 := jsoniter.Marshal(reqData)
	if err1 != nil {
		fmt.Println(err1)
		return "", err1
	}
	param := string(jsonBytes)
	req := "schema=" + schema + "&param=" + param
	c.SetContentType(contenttype_kd100)
	dataInfo := c.PostContent(url, req)
	if _reParse, err := gjson.DecodeToJson(dataInfo); err == nil {
		if gconv.Bool(_reParse.Get("result")) && gconv.Int(_reParse.Get("returnCode")) == 200 {
			return dataInfo, nil
		} else {
			zaplog.Infof("物流订阅请求失败 原因:%s ", _reParse.Get("message"))
		}
	}
	return "", errors.New("物流订阅请求失败")
}

//接收第三方物流平台推送的轨迹信息
type OrderPushQueryDataKd100Req struct {
	Status     string     `p:"status"`     //polling	监控状态:polling:监控中，shutdown:结束，abort:中止，updateall：重新推送。其中当快递单为已签收时status=shutdown，当message为“3天查询无记录”或“60天无变化时”status= abort ，对于stuatus=abort的状态，需要增加额外的处理逻辑：若贵司校验快递公司编码和单号无误后仍需继续跟踪，则隔半小时再发起该单的订阅即可
	Message    string     `p:"message"`    //监控状态相关消息，如:3天查询无记录，60天无变化
	AutoCheck  string     `p:"autoCheck"`  //1	快递公司编码是否出错，0为本推送信息对应的是贵司提交的原始快递公司编码，1为本推送信息对应的是我方纠正后的新的快递公司编码。一个单如果我们连续3天都查不到结果，我方会（1）判断一次贵司提交的快递公司编码是否正确，如果正确，给贵司的回调接口（callbackurl）推送带有如下字段的信息：autoCheck=0、comOld与comNew都为空；（2）如果贵司提交的快递公司编码出错，我们会帮忙用正确的快递公司编码+原来的运单号重新提交订阅并开启监控（后续如果监控到单号有更新就给贵司的回调接口（callbackurl）推送带有如下字段的信息：autoCheck=1、comOld=原来的公司编码、comNew=新的公司编码）；并且给贵方的回调接口（callbackurl）推送一条含有如下字段的信息：status=abort、autoCheck=0、comOld为空、comNew=纠正后的快递公司编码。
	ComOld     string     `p:"comOld"`     //yuantong	贵司提交的原始的快递公司编码。详细见autoCheck后说明。若开启了国际版（即在订阅请求中增加字段interCom=1），则回调请求中暂无此字段
	ComNew     string     `p:"comNew"`     //	ems	我司纠正后的新的快递公司编码。详细见autoCheck后说明。若开启了国际版（即在订阅请求中增加字段interCom=1），则回调请求中暂无此字段
	LastResult ResultData `p:"lastResult"` //	 	最新查询结果，若在订阅报文中通过interCom字段开通了国际版，则此lastResult表示出发国的查询结果，全量，倒序（即时间最新的在最前）
	DestResult ResultData `p:"destResult"` //表示最新的目的国家的查询结果，只有在订阅报文中通过interCom=1字段开通了国际版才会显示此数据元，全量，倒序（即时间最新的在最前）
}

type ResultData struct {
	Message   string       `p:"message"`   //OK	消息体，请忽略
	State     int          `p:"state"`     //0	快递单当前状态，包括0在途，1揽收，2疑难，3签收，4退签，5派件，6退回，7转投 等7个状态
	Status    int          `p:"status"`    //200	通讯状态，请忽略
	Condition string       `p:"condition"` //F00	快递单明细状态标记，暂未实现，请忽略
	Ischeck   int          `p:"ischeck"`   //0	是否签收标记
	Com       string       `p:"com"`       //yuantong	快递公司编码,一律用小写字母，点击查看快递公司编码
	Nu        string       `p:"nu"`        //V030344422	快递单号
	Data      []*OrderData `p:"data"`      //数组，包含多个对象，每个对象字段如展开所示
}

type OrderData struct {
	Context  string `p:"context"`  //上海分拨中心 物流轨迹节点内容
	Time     string `p:"time"`     //2012-08-28 16:33:19	时间，原始格式
	Ftime    string `p:"ftime"`    //2012-08-28 16:33:19	格式化后时间
	Status   string `p:"status"`   //在途 本数据元对应的签收状态。只有在开通签收状态服务（见上面"status"后的说明）且在订阅接口中提交resultv2标记后才会出现
	AreaCode string `p:"areaCode"` //310000000000 本数据元对应的行政区域的编码，只有在开通签收状态服务（见上面"status"后的说明）且在订阅接口中提交resultv2标记后才会出现
	AreaName string `p:"areaName"` //上海市	本数据元对应的行政区域的名称，开通签收状态服务（见上面"status"后的说明）且在订阅接口中提交resultv2标记后才会出现
}

//推送信息返回结果
type OrderPushResp struct {
	Result     string `json:"result"`     //true表示成功，false表示失败。如果提交回调接口的地址失败，30分钟后重新回调，3次仍旧失败的，自动放弃
	ReturnCode string `json:"returnCode"` //200: 接收成功 500: 服务器错误 其他错误请自行定义
	Message    string `json:"message"`    //返回的提示
}
