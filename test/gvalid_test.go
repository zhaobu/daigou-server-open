package test

import (
	"daigou/library/zaplog"
	"fmt"
	"testing"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/util/gvalid"
)

// 校验数据类型及大小，并且使用自定义的错误提示
func TestGvalid_required(t *testing.T) {
	rule := "integer|between:6,16"
	msgs := "请输入一个整数|参数大小不对啊老铁"
	if e := gvalid.Check(123, rule, msgs); e != nil {
		zaplog.Infof(e.String())
	}
	if e := gvalid.Check(123456, rule, msgs); e != nil {
		zaplog.Infof(e.String())
	}
	if e := gvalid.Check("123456", rule, msgs); e != nil {
		zaplog.Infof(e.String())
	}
	if e := gvalid.Check("123kk4", rule, msgs); e != nil {
		zaplog.Infof(e.String())
	}
}

// 使用map指定规则及提示信息
func TestGvalid_CheckStruct1(t *testing.T) {
	type Object struct {
		Name string
		Age  int
	}
	rules := map[string]string{
		"Name": "required|length:6,16",
		"Age":  "between:18,30",
	}
	msgs := map[string]interface{}{
		"Name": map[string]string{
			"required": "名称不能为空",
			"length":   "名称长度为:min到:max个字符",
		},
		"Age": "年龄为18到30周岁",
	}
	obj := Object{Name: "john"}
	// 也可以是指针
	// obj := &Object{Name : "john"}
	if e := gvalid.CheckStruct(obj, rules, msgs); e != nil {
		g.Dump(e.Maps())
	}
}

// 使用gvalid tag绑定规则及提示信息
func TestGvalid_CheckStruct2(t *testing.T) {
	// type User struct {
	// 	Uid   int    `valid:"uid@integer|min:1"`
	// 	Name  string `valid:"myname@required|length:6,30#请输入用户名称|用户名称长度非法"`
	// 	Pass1 string `valid:"password1@required|password3"`
	// 	Pass2 string `valid:"password2@required|password3|same:password1#||两次密码不一致，请重新输入"`
	// }
	type User struct {
		Uid   int    `v:"uid@integer|min:1"`
		Name  string `v:"myname@required|length:6,30#请输入用户名称|用户名称长度非法"`
		Pass1 string `v:"password1@required|password3"`
		// Pass2 string `v:"password2@required|password3|same:password1#||两次密码不一致，请重新输入"`
		Pass2 string `v:"password2@required|password3|same:Pass1#||两次密码不一致，请重新输入"`
	}

	user := &User{
		Name:  "john",
		Pass1: "Abc123!@#",
		Pass2: "123",
	}

	// 使用结构体定义的校验规则和错误提示进行校验
	if e := gvalid.CheckStruct(user, nil); e != nil {
		g.Dump(e.Maps())
	}

	// 自定义校验规则和错误提示，对定义的特定校验规则和错误提示进行覆盖
	rules := map[string]string{
		"uid": "min:6",
	}
	msgs := map[string]interface{}{
		"password2": map[string]string{
			"password3": "名称不能为空",
		},
	}
	if e := gvalid.CheckStruct(user, rules, msgs); e != nil {
		g.Dump(e.Maps())
	}
}

//相加
func AddFloat64(g float64, h float64) float64 {
	t := (h * 100)
	return ((g * 100) + t) / 100
}

//相乘
func MultiplyFloat64(g float64, h float64) float64 {
	return ((g * 100) * (h * 100)) / 10000
}
func Test_sdjhjk(t *testing.T) {

	var (
		g float64
		// h  float64
		// k  float64
		gh float64
	)
	g = 20.33
	gh = 0
	// h = 0.00
	// k = 20
	// gh = ((g * 100) + (h * 100)) / 100
	// gh = MultiplyFloat64(g, gh)
	gh = AddFloat64(gh, g)
	fmt.Println(gh)
	return
}
