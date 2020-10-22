package model

import (
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"fmt"
	"testing"
	"time"

	"github.com/gogf/gf/frame/g"
	"github.com/guregu/null"
	jsoniter "github.com/json-iterator/go"
)

//json操作
// https://www.jianshu.com/p/25161add5e4b
// https://www.jianshu.com/p/ff923486bc74
// https://blog.csdn.net/szxiaohe/article/details/82772881
type Goods struct {
	Nmae    string `json:"name"`
	Country string `json:"country"`
	Num     int32  `json:"num"`
}

type Movies struct {
	Nmae string `json:"name"`
	Type string `json:"type"`
}

type Record struct {
	Time time.Time `json:"time"`
	Name string    `json:"name"`
}

// 商品
type Detial struct {
	Good    *Goods    `json:"my_good"`
	Movie   *Movies   `json:"my_movie"`
	Records []*Record `json:"records"`
}

//测试gorm操作数据库json字段
func Test_JsonInit(t *testing.T) {
	//1.执行建表语句
	err := dbGorm.AutoMigrate(&entity.TestDb{}).Error
	if err != nil {
		zaplog.Errorf("test_db error:", err)
	}

	tb := dbGorm.Table("test_db")

	detial, err := jsoniter.Marshal(&Detial{
		Good:  &Goods{Nmae: "苹果", Country: "中国", Num: 2000},
		Movie: &Movies{Nmae: "天龙八部", Type: "武侠"}})
	if err != nil {
		err = fmt.Errorf("jsoniter.Marshal err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
	// 插入
	err = tb.Create(&entity.TestDb{TypeID: 123,
		Name:   null.NewString("json_test", true),
		Age:    null.NewInt(19, true),
		Detial: null.NewString(string(detial), true),
	}).Error
	if err != nil {
		err = fmt.Errorf("tb.Create err:%s", err)
		zaplog.Errorf("err=%s", err)
	}

	//3.查询结果
	type Result struct {
		UpdatedAt *entity.Time `json:"updated_at"`
		Name      null.String  ` json:"name"`
		Age       null.Int     ` json:"age"`
		Detial    null.String  ` json:"detial"`
	}
	var res Result
	err = tb.Where("name=?", "json_test").First(&res).Error
	if err != nil {
		err = fmt.Errorf("tb.Where err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
	g.Dump(res)

}

//如果是整个 json 更新的话，和插入时类似的。
func Test_INSERT(t *testing.T) {
	detial, err := jsoniter.Marshal(&Detial{
		Good:  &Goods{Nmae: "苹果", Country: "中国", Num: 2000},
		Movie: &Movies{Nmae: "天龙八部", Type: "武侠"},
		Records: []*Record{
			&Record{Time: time.Now(), Name: "record1"},
			&Record{Time: time.Now(), Name: "record2"},
			&Record{Time: time.Now(), Name: "record3"},
		},
	})

	sql1 := "update test_db set detial=? where id=?"
	err = dbGorm.Table("test_db").Exec(sql1, detial, 34).Error
	if err != nil {
		err = fmt.Errorf("Test_JSON_INSERT err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

// JSON_INSERT() 插入值（插入新值，但不替换已经存在的旧值）
func Test_JSON_INSERT(t *testing.T) {
	sql1 := `update test_db set detial=json_insert(detial,'$.name', ?, '$.age', ?) where id=?`
	err := dbGorm.Table("test_db").Exec(sql1, "lw", 18, 34).Error
	if err != nil {
		err = fmt.Errorf("Test_JSON_INSERT err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

// JSON_SET() 设置值（替换旧值，并插入不存在的新值）
func Test_JSON_SET(t *testing.T) {
	type ScrollInfo struct {
		Name           []string  `json:"name"`
		StartTime      time.Time `json:"start_time"`      //开始时间
		DeparturePoint string    `json:"departure_point"` //出发地
	}
	scrollInfo := &ScrollInfo{
		Name:           []string{"shanghai", "shengzhen"},
		StartTime:      time.Now(),
		DeparturePoint: "shanghai",
	}
	sql1 := `update test_db set detial=json_set(detial,'$.name', ?, '$.age', ?, '$.scrollInfo',?) where id=?`

	//序列化
	res, err := jsoniter.MarshalToString(scrollInfo)
	if err != nil {
		err = fmt.Errorf("Test_JSON_Str err:%s", err)
		zaplog.Errorf("err=%s", err)
	}

	err = dbGorm.Table("test_db").Exec(sql1, "lw", 19, res, 34).Error
	if err != nil {
		err = fmt.Errorf("Test_JSON_SET err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

// JSON_REPLACE() 替换值（只替换已经存在的旧值）
func Test_JSON_REPLACE(t *testing.T) {
	sql1 := `update test_db set detial=json_replace(detial,'$.name', ?, '$.age', ?, '$.arg1',?) where id=?`

	err := dbGorm.Table("test_db").Exec(sql1, "lw1", 20, "arg1", 34).Error
	if err != nil {
		err = fmt.Errorf("Test_JSON_REPLACE err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

// JSON_REMOVE() 删除JSON数据，删除指定值后的JSON文档
func Test_JSON_REMOVE(t *testing.T) {
	sql1 := "update test_db set detial=json_remove(detial,?) where id=?"

	err := dbGorm.Table("test_db").Exec(sql1, "$.records[1]", 34).Error
	if err != nil {
		err = fmt.Errorf("Test_JSON_REMOVE err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
}

func Test_JSON_Str(t *testing.T) {
	info := &entity.ShopInfo_ScrollInfo_TravelInfo{
		URL: []string{
			"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1",
			"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg",
			"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg",
		},
		StartTime:        entity.Now(),
		EndTime:          &entity.Time{Time: time.Now().AddDate(0, 0, 1)},
		DeparturePoint:   "上海",
		DestinationPoint: "北京",
	}

	res, err := jsoniter.MarshalToString(info)
	if err != nil {
		err = fmt.Errorf("Test_JSON_Str err:%s", err)
		zaplog.Errorf("err=%s", err)
	}

	zaplog.Infof("res=%s", res)
}

func Test_EditScrollInfo(t *testing.T) {
	res, err := EditScrollInfo(&DbEditScrollInfoIn{
		ShopID:     1000034,
		Index:      0,
		ScrollName: "travel_info",
		ScrollInfo: "{\"url\":[\"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api\u0026rs=1\",\"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg\",\"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg\"],\"start_time\":\"2020-07-03 13:13:56\",\"end_time\":\"2020-07-04 13:13:56\",\"departure_point\":\"上海\",\"destination_point\":\"北京\"}",
	})

	if err != nil {
		err = fmt.Errorf("Test_EditScrollInfo err:%s", err)
		zaplog.Errorf("err=%s", err)
	}
	zaplog.Infof("res=%s", res)
}
