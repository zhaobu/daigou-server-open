package model

import (
	"daigou/app/model/entity"
	"daigou/library/conf"
	"daigou/library/public"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"testing"
	"time"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gconv"
	"github.com/guregu/null"
	"github.com/jinzhu/gorm"
	jsoniter "github.com/json-iterator/go"
)

func init() {
	zaplog.InitLog(&zaplog.Config{
		Logdir:   "./",
		LogName:  "go_test.log",
		Loglevel: "debug",
		Debug:    true,
	})
	conf.InitConfig("../../bin/config/config1.toml")
	conf.InitConnect()
	InitModel()
}

func Test_XormJoin(t *testing.T) {
	has, err1 := dbXorm.Table("user").Select("a.user_id,a.role,a.phone_number,a.bind_shop_id,b.shop_id").Join("a left", "shop_info b", "a.user_id =b.user_id").Where("a.open_id=?", "o-_Ls4m-gSOyUmVQ1qC_Xb1y_Es4").Exist()
	zaplog.Infof("dbXorm has=%v,err=%s", has, err1)
	zaplog.Infof("id=%d", utils.GenUniqueID())
}

func Test_Concurrence(t *testing.T) {
	//判断表存在
	ok, err := dbXorm.IsTableExist("test_db")
	if !ok || err != nil {
		zaplog.Errorf("表test_db不存在:%s", err)
		return
	}

	maxNum := 1
	ch1 := make(chan int, 0)
	ch2 := make(chan int, 0)
	ch3 := make(chan int, 0)

	//插入
	go func(test bool) {
		num := 0
		if !test {
			ch1 <- num
			return
		}
		type Detial struct {
			Name   string `json:"name"`
			TypeID int32  `json:"type_id"`
		}
		detial, err := jsoniter.Marshal(&Detial{Name: "test_name", TypeID: 15})
		if err != nil {
			zaplog.Errorf("jsoniter.Marshal, err=%s", err)
			return
		}

		for {
			user := &entity.TestDb{
				TypeID:    12,
				Name:      null.NewString("test_name", true),
				CreatedAt: &entity.Time{Time: time.Now()},
				UpdatedAt: &entity.Time{Time: time.Now()},
				Age:       null.NewInt(18, true),
				Detial:    null.NewString(string(detial), true),
			}
			err = dbGorm.Table("test_db").Create(user).Error
			if err != nil {
				zaplog.Errorf("insert err:%s", err)
			}
			num++
			zaplog.Infof("第%d次insert", num)
			if num >= maxNum {
				ch1 <- num
				break
			}
		}
	}(true)

	//查询
	go func(test bool) {
		num := 0
		if !test {
			ch2 <- num
			return
		}
		type Result1 struct {
			TypeID uint64      `json:"type_id"`
			Name   null.String `json:"name"`
			Age    null.Int    `json:"age"`
		}

		for {

			var res1 []*Result1
			//查询
			err = dbXorm.Table("test_db").Select("type_id,name,age").Find(&res1)
			if err != nil {
				zaplog.Errorf("select err:%s", err)
				return
			}
			num++
			zaplog.Infof("第%d次查询,len=%d", num, len(res1))
			if num >= maxNum {
				ch2 <- num
				break
			}
		}
	}(true)

	//删除
	go func(test bool) {
		num := 0
		if !test {
			ch3 <- num
			return
		}

		for {

			var res1 entity.TestDb
			//查询
			delNum, err := dbXorm.Table("test_db").Where("type_id=?", 12).Unscoped().Delete(&res1)
			if err != nil {
				zaplog.Errorf("Delete err:%s", err)
				return
			}
			num++
			zaplog.Infof("第%d次 delete,删除了%d条数据", num, delNum)
			if num >= maxNum {
				ch3 <- num
				break
			}
		}
	}(true)
	//修改

	insertNum := <-ch1
	<-ch2
	deleteNum := <-ch3

	zaplog.Infof("总共insert了%d条数据,deletel%d条数据", insertNum, deleteNum)
}

func Test_Select(t *testing.T) {
	//查询1
	type Result struct {
		// CategoryInfo       string                        `json:"category_info"`        //分类信息
		// MainpageScrollInfo string                        `json:"mainpage_scroll_info"` //滚动信息
		// ShopInfo           GetMainPageBaseInfoOut1 `xorm:"-"`                    //店铺信息
		CategoryInfo       entity.ShopInfo_CategoryInfo `json:"category_info"` //分类信息
		MainpageScrollInfo *entity.ShopInfo_ScrollInfo  `json:"mainpage_scroll_info"`
	}
	out := Result{}

	err := dbGorm.Table("shop_info").Select("mainpage_scroll_info,category_info").Where("user_id=?", 1821198978).Scan(&out).Error
	// err := dbXorm.Table("shop_info").Cols("mainpage_scroll_info,category_info").Where("user_id=?", 1821198978).GetFirst(&out).Error
	if err != nil {
		zaplog.Errorf("dbGorm select err=%s", err)
		return
	}

	g.Dump(out)
}

//测试项shop_info表插入数据
func Test_InsertShopInfo(t *testing.T) {
	categoryInfo := &entity.ShopInfo_CategoryInfo{1, 2, 3}
	scrollInfo := &entity.ShopInfo_ScrollInfo{
		TravelInfo: []*entity.ShopInfo_ScrollInfo_TravelInfo{
			&entity.ShopInfo_ScrollInfo_TravelInfo{
				URL: []string{
					"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1",
					"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg",
					"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg",
				},
				StartTime:        entity.Now(),
				EndTime:          &entity.Time{Time: time.Now().AddDate(0, 0, 1)},
				DeparturePoint:   "上海",
				DestinationPoint: "北京",
			},
			&entity.ShopInfo_ScrollInfo_TravelInfo{
				URL: []string{
					"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1",
					"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg",
					"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg",
				},
				StartTime:        entity.Now(),
				EndTime:          &entity.Time{Time: time.Now().AddDate(0, 0, 2)},
				DeparturePoint:   "东京",
				DestinationPoint: "莫斯科",
			},
		},
	}

	jsonCategoryInfo, err := jsoniter.Marshal(categoryInfo)
	if err != nil {
		zaplog.Errorf("jsoniter.Marshal, err=%s", err)
		return
	}

	jsonScrollInfo, err := jsoniter.Marshal(scrollInfo)
	if err != nil {
		zaplog.Errorf("jsoniter.Marshal, err=%s", err)
		return
	}
	shopInfo := &entity.ShopInfo{
		ShopID:             1000034,
		UserID:             1000034,
		ShopName:           "lw的商店",
		ShopURL:            "http://www.86ps.com/UploadFiles/Article/2014-11/201411122332322.jpg",
		ShopDescription:    null.NewString("专业美食代购", true),
		QrCodeURL:          null.NewString("https://tse3-mm.cn.bing.net/th/id/OIP.Resbf9j-MDrJw5trdImrxAHaHa?pid=Api&rs=1", true),
		WechatNumber:       null.NewString("我的微信号", true),
		CategoryInfo:       null.NewString(string(jsonCategoryInfo), true),
		MainpageScrollInfo: null.NewString(string(jsonScrollInfo), true),
	}
	err = dbGorm.Table("shop_info").Create(shopInfo).Error
	if err != nil {
		zaplog.Errorf("insert err:%s", err)
	}
}

//测试gorm.Model字段
func Test_Model(t *testing.T) {

	type Result struct {
		UpdatedAt *entity.Time `json:"updated_at"`
	}
	type Result1 struct {
		UpdatedAt *entity.Time `json:"updated_at"`
	}
	var (
		res Result
		err error
	)

	tb := dbGorm.Table("test_db")
	//查询结果
	err = tb.Select("updated_at").Where("age=?", 18).First(&res).Error
	if err != nil {
		err = fmt.Errorf("tb.Select err:%s", err)
		zaplog.Errorf("err=%s", err)
	}

	zaplog.Infof("%+v", &res)
	g.Dump(res, &Result1{UpdatedAt: &entity.Time{Time: time.Now()}})

	// 插入
	err = tb.Create(&entity.TestDb{TypeID: 123,
		Name: null.NewString("lw", true),
		Age:  null.NewInt(19, true),
	}).Error
	if err != nil {
		err = fmt.Errorf("tb.Create err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
	//软删除
	err = tb.Delete(&entity.TestDb{}, "age=?", 19).Error
	if err != nil {
		err = fmt.Errorf("tb.Delete err:%s", err)
		zaplog.Errorf("err=%s", err)
	}

	//物理删除
	err = tb.Unscoped().Delete(&entity.TestDb{}, "age=?", 19).Error
	if err != nil {
		err = fmt.Errorf("tb.Delete err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

// 自动迁移数据结构(table schema)
// 注意:在gorm中，默认的表名都是结构体名称的复数形式，比如User结构体默认创建的表为users
// db.SingularTable(true) 可以取消表名的复数形式，使得表名和结构体名称一致
func Test_SynnDbFromStruct(t *testing.T) {
	defer dbGorm.Close()
	synctbs := []interface{}{
		&entity.TestDb{},
		&entity.GoodsCategory{},
		&entity.Goods{},
		&entity.OrdersBillFlow{},
		&entity.OrdersGoods{},
		&entity.User{},

		&entity.OrdersLogistics{},
		&entity.Orders{},
		&entity.ShopInfo{},
		&entity.SystemConfig{},
	}
	dbGorm.CreateTable(&entity.TestDb{})
	for index, tb := range synctbs {
		zaplog.Infof("正在同步%d", index)
		err := dbGorm.AutoMigrate(tb).Error
		if err != nil {
			zaplog.Panicf("%d同步出错", index)
		}
		zaplog.Infof("同步成功%d", index)
	}
}

func Test_InnerJoin(t *testing.T) {
	//insert shop_info

	out := &DbWxLoginOut{}
	err := dbGorm.Table("user a").Select("a.user_id,a.role,a.phone_number,a.bind_shop_id,b.shop_id").Joins("left join shop_info b on a.user_id =b.user_id").Where("a.open_id=?", "o-_Ls4m-gSOyUmVQ1qC_Xb1y_Es4").Find(out).Error
	if gorm.IsRecordNotFoundError(err) {
		zaplog.Errorf("not find")
		return
	}
	zaplog.Infof("out=%+v", out)
}

func Test_GetRecommendShop(t *testing.T) {
	info, err := GetRecommendShop(nil)
	if err != nil {
		zaplog.Errorf("err=%s", err)
	}
	g.Dump(info)
}

// func Test_BindShop(t *testing.T) {
// 	err := BindShop(&DbBindShopIn{UserID: 657353715, BindShopID: 10})
// 	if err != nil {
// 		zaplog.Errorf("err=%s", err)
// 	}
// }

func Test_UseShopCode(t *testing.T) {
	res, err := UseShopCode(&DbUseShopCodeIn{GenType: public.ShopCodeType_Shop, UserID: 1000004, BindShopID: 1000001})
	if err != nil {
		zaplog.Errorf("err=%s", err)
		return
	}
	zaplog.Infof("res=%s", utils.Dump(res))
}

func Test_GormSet(t *testing.T) {
	tb := dbGorm.Table("shop_fans").Set("gorm:insert_modifier", "ignore").Create(&entity.ShopFans{ShopID: 1110, UserID: 13, Category: 1})
	if err := tb.Error; err != nil {
		err = fmt.Errorf("IncreaseFans Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}

	zaplog.Infof("res=%d", tb.RowsAffected)
}

func Test_IncreaseFans(t *testing.T) {
	err := IncreaseFans(nil, &IncreaseFansReq{ShopID: 1110, UserID: 13, Category: 1})
	if err != nil {
		zaplog.Errorf("BindShop Db err:%s", err)
		return
	}
}

func Test_UserAddress(t *testing.T) {
	shopInfo := &entity.UserAddress{
		UserID:          1000000,
		PhoneNumber:     18746191484,
		Name:            "哈哈哈",
		Gender:          0,
		Province:        "sdfsdfsfdsfdsf",
		City:            "sdfsfsfdsfsdfsf",
		Area:            "sdfsfsdf",
		DetailedAddress: "sdfsdf",
		IsDefault:       0,
		Classification:  0,
	}
	err := dbGorm.Table("user_address").Create(shopInfo).Error
	if err != nil {
		zaplog.Errorf("insert err:%s", err)
	}
}

func Test_Shop_Info(t *testing.T) {
	err := dbGorm.Table("shop_info").Where("shop_id=?", 1000025).Updates(map[string]interface{}{"shop_fans_count": gorm.Expr("shop_fans_count + ?", 1)}).Error
	if err != nil {
		zaplog.Errorf("insert err:%s", err)
	}
}

func Test_StructDeep(t *testing.T) {
	res := entity.ShopInfo{}
	err := dbGorm.Where("id=1").First(&res).Error
	if err != nil {
		zaplog.Errorf("Test_StructDeep err:%s", err)
	}

	v, _ := jsoniter.Marshal(res)

	count := 10000
	var (
		temp1 *entity.ShopInfo
		temp2 *entity.ShopInfo
		temp3 *entity.ShopInfo
	)
	t1 := time.Now()
	for i := 0; i < count; i++ {
		// var temp1 *entity.ShopInfo
		err = json.Unmarshal(v, &temp1)
	}
	t2 := time.Now()
	for i := 0; i < count; i++ {
		// var temp2 *entity.ShopInfo
		gconv.Struct(gconv.Map(res), &temp2)
	}
	t3 := time.Now()

	for i := 0; i < count; i++ {
		// var temp3 *entity.ShopInfo
		err = jsoniter.Unmarshal(v, &temp3)
	}

	t4 := time.Now()
	zaplog.Infof("t2-t1=%dms,t3-t2=%dms,t4-t3=%dms", t2.Sub(t1).Milliseconds(), t3.Sub(t2).Milliseconds(), t4.Sub(t3).Milliseconds())

	if err != nil {
		zaplog.Errorf("err=%s", err)
	}
	zaplog.Infof("temp1:%s,temp2:%s,temp3:%s", utils.Dump(temp1), utils.Dump(temp2), utils.Dump(temp3))
}

//插入电子面单模板数据
func Test_CreateTemplateDb(t *testing.T) {
	inputFile := "E:\\GoSrc\\template.txt"
	buf, err := ioutil.ReadFile(inputFile)
	if err != nil {
		panic(err.Error())
	}
	fmt.Printf("%s", string(buf))
	company := entity.SystemExpressCompany{} //system_express_company
	insert_name := "%中通%"
	err = dbGorm.Table("system_express_company").Where("express_name like ?", insert_name).First(&company).Error
	if err != nil {
		panic(err.Error())
	}
	teConfigInfo := entity.ExpressTemplateConfig{
		TempleteName:     company.ExpressName + " 50*110",
		TempleteData:     string(buf),
		ExpressCompanyID: company.ID,
	}
	err = dbGorm.Table("express_template_config").Create(&teConfigInfo).Error
	if err != nil {
		zaplog.Errorf("insert err:%s", err)
	}
}

func Test_LoadTestUser(t *testing.T) {
	LoadTestUser()
}
