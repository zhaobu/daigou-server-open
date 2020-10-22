// config1.toml到结体的映射
package conf

import (
	"daigou/library/zaplog"
	"fmt"
	"os"

	"github.com/BurntSushi/toml"
	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/os/gcfg"
	"github.com/gogf/gf/os/gfile"
)

var (
	Conf        *Config                                 //Goframe全局配置文件到struct的映射
	GfConf      *gcfg.Config                            //Goframe全局配置文件
	tryConfPath = []string{"./bin/config/config1.toml"} //添加可配置的路径
)

func tryConfig(confPath string) string {
	tryConfPath = append(tryConfPath, confPath)
	for _, v := range tryConfPath {
		if gfile.Exists(v) {
			zaplog.Infof("读取到可用的配置文件路径%s", v)
			return v
		}
	}
	zaplog.Panicf("所有的配置文件路径都无效:%+V", tryConfPath)
	return ""
}

func InitConfig(confPath string) error {
	confPath = tryConfig(confPath)
	GfConf = g.Cfg()
	//设置配置文件查找的路径(可设置多个)
	GfConf.SetFileName(confPath)
	//获取当前工作目录
	workPath, err := os.Getwd()
	if err != nil {
		return err
	}
	zaplog.Infof("当前工作目录=%s", workPath)
	zaplog.Infof("正在以%s文件启动", confPath)

	_, err = toml.DecodeFile(confPath, &Conf)
	if err != nil {
		zaplog.Panicf("配置文件解析失败:%s,err=%s", confPath, err)
	}

	//给每种日志加上路径前缀
	addLogPrefix()
	return err
}

func addLogPrefix() {
	Conf.Env.Logdir = fmt.Sprintf("%s/%d", Conf.Env.Logdir, Conf.Env.ServerID)
	Conf.Server.LogPath = fmt.Sprintf("%s/%s", Conf.Env.Logdir, Conf.Server.LogPath)
	Conf.Logger.Logdir = fmt.Sprintf("%s/%s", Conf.Env.Logdir, Conf.Logger.Logdir)
	Conf.Database["default"].Logdir = fmt.Sprintf("%s/%s", Conf.Env.Logdir, Conf.Database["default"].Logdir)
	Conf.Cron.Logdir = fmt.Sprintf("%s/%s", Conf.Env.Logdir, Conf.Cron.Logdir)
}

type Config struct {
	Env      *env                     `toml:"env"`
	Server   *server                  `toml:"server"`
	Logger   *zaplog.Config           `toml:"logger"`
	Database map[string]*databaseConf `toml:"database"`
	Redis    map[string]string        `toml:"redis"`
	Weapp    *weapp                   `toml:"weapp"`
	Alioss   *alioss                  `toml:"alioss"`
	Cron     *cron                    `toml:"cron"`
	Smscode  *smscode                 `toml:"smscode"`
	TxCloud  *txcloud                 `toml:"txcloud"`
	Casbin   *casbin                  `toml:"casbin"`
	TestUser *testUser                `toml:"test_user"`
}

type env struct {
	Debug    bool   `toml:"Debug"`
	Logdir   string `toml:"Logdir"`
	ServerID uint16 `toml:"ServerID"`
}

type server struct {
	Address          string   `toml:"Address"`
	ServerRoot       string   `toml:"ServerRoot"`
	NameToUriType    int32    `toml:"NameToUriType"`
	RouteOverWrite   bool     `toml:"RouteOverWrite"`
	LogPath          string   `toml:"LogPath"`
	LogStdout        bool     `toml:"LogStdout"`
	AccessLogEnabled bool     `toml:"AccessLogEnabled"`
	ErrorLogEnabled  bool     `toml:"ErrorLogEnabled"`
	PProfEnabled     bool     `toml:"PProfEnabled"`
	SessionMaxAge    string   `toml:"SessionMaxAge"`
	DumpRouterMap    bool     `toml:"DumpRouterMap"`
	SessionIdName    string   `toml:"SessionIdName"`
	SearchPaths      []string `toml:"SearchPaths"`
}

type databaseConf struct {
	Link     string `toml:"Link"`
	Debug    bool   `toml:"Debug"`
	Logdir   string `toml:"Logdir"`
	Loglevel string `toml:"Loglevel"`
	LogName  string `toml:"LogName"`
}

type weapp struct {
	AppID   string `toml:"appID"`
	Secret  string `toml:"secret"`
	PayMent *struct {
		Key       string `toml:"key"`
		MchID     string `toml:"mchid"`
		NotifyUrl string `toml:"notifyurl"`
	} `toml:"payment"`
	SubscribeMessage *struct {
		TemplateComfirm string `toml:"templatecomfirm"` //确认订单通知
		TemplateDeliver string `toml:"templatedeliver"` //发货通知
	} `toml:"subscribemessage"`
	GongZhongHao *struct {
		AppID  string `toml:"appID"`
		Secret string `toml:"secret"`
	} `toml:"gongzhonghao"`
	TemplateMessage *struct {
		TemplatePurchase string `toml:"templatepurchase"` //下单成功通知
		TemplateUrl      string `toml:"templateurl"`      //模块点击跳转链接

	} `toml:"templatemessage"`
}

type txcloud struct {
	AppID string `toml:"appid"`
	Sts   *struct {
		Bucket    string `toml:"bucket"`
		Region    string `toml:"region"`
		SecretID  string `toml:"secretid"`
		SecretKey string `toml:"secretkey"`
	} `toml:"sts"`
}

type alioss struct {
	AccessKeyId     string `toml:"accessKeyId"`
	AccessKeySecret string `toml:"accessKeySecret"`
	Expire_time     int64  `toml:"expire_time"`
}

type cron struct {
	Logdir   string `toml:"Logdir"`
	LogName  string `toml:"LogName"`
	Loglevel string `toml:"Loglevel"`
}

type smscode struct {
	Width     int32  `toml:"width"`
	Frequency int32  `toml:"frequency"`
	ValidTime int32  `toml:"validTime"`
	SignName  string `toml:"signName"`
}

type casbin struct {
	ModelConf string `toml:"modelconf"`
	Autosave  bool   `toml:"autosave"`
}

type user struct {
	UserID uint32 `toml:"user_id"`
	OpenID string `toml:"open_id"`
}
type testUser struct {
	Seller *user `toml:"seller"`
	Buyer  *user `toml:"buyer"`
}
