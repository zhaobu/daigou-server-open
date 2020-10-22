package model

import (
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"fmt"

	"github.com/jinzhu/gorm"
)

//查询搜索我的客户request
type CustomerSeeReq struct {
	CrNick      string `json:"cr_nick"`      // 客户昵称
	IsBingUser  int    `json:"is_bing_user"` //0:查看全部  1：查看以绑定  2：查看未绑定
	Start_Index int    `json:"start_index"`  //查询起始索引
	Count       int    `json:"count"`        //页面列表个数
}

type CustomerSeeResp struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
	CrNick     string `json:"cr_nick"`     // 客户昵称
	CrHeadimg  string `json:"cr_headimg"`  // 头像
	NickName   string `json:"nick_name"`   // 微信名字
	CrUserid   uint32 `json:"cr_userid"`   // 平台用户id(未绑定时 该字段为0 ）
}

//查询搜索我的客户
func CustomerSee(req *CustomerSeeReq, ShopID uint64) (res []*CustomerSeeResp, err error) {
	tb := dbGorm.Table("h_customer")
	if req.CrNick != "" {
		if req.IsBingUser == 1 {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=? AND h_customer.cr_userid > 0 AND h_customer.cr_nick LIKE ?", ShopID, "%"+req.CrNick+"%").
				Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		} else if req.IsBingUser == 2 {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=? AND h_customer.cr_userid = 0 AND h_customer.cr_nick LIKE ?", ShopID, "%"+req.CrNick+"%").
				Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		} else {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=? AND h_customer.cr_nick LIKE ?", ShopID, "%"+req.CrNick+"%").
				Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		}
	} else {
		if req.IsBingUser == 1 {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=? AND h_customer.cr_userid > 0", ShopID).Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		} else if req.IsBingUser == 2 {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=? AND h_customer.cr_userid = 0", ShopID).Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		} else {
			rows := tb.Offset(req.Start_Index).Limit(req.Count).Select("h_customer.customer_id,h_customer.cr_nick,h_customer.cr_headimg,h_customer.cr_userid,user.nick_name").
				Joins("left join user on user.user_id = h_customer.cr_userid").Where("h_customer.shop_id=?", ShopID).Order("h_customer.created_at desc")
			rows.Scan(&res)
			err = rows.Error
		}
	}
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("SeeFollowShop Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//查看客户信息request
type CustomerInfoSeeReq struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type CustomerInfoSeeResp struct {
	CrNick    string `json:"cr_nick"`    // 客户昵称
	CrHeadimg string `json:"cr_headimg"` // 头像
}

//查看客户信息
func CustomerInfoSee(req *CustomerInfoSeeReq) (res *CustomerInfoSeeResp, err error) {
	tb := dbGorm.Table("h_customer")
	res = &CustomerInfoSeeResp{}
	err = tb.Where("customer_id =?", req.CustomerID).Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CustomerInfoSee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//下单时查看为的客户IDrequest
type CustomerIDSeeReq struct {
	ShopID uint64 `json:"shop_id"` //店铺id
	UserID uint32 `json:"user_id"` //绑定用户id
}

type CustomerIDSeeResp struct {
	CustomerID   uint32 `json:"customer_id"`   // 客户id
	CustomerName string `json:"customer_name"` // 客户名称
}

//下单时查看客户ID
func CustomerIDSee(req *CustomerIDSeeReq) (res *CustomerIDSeeResp, err error) {
	tb := dbGorm.Table("h_customer")
	res = &CustomerIDSeeResp{}
	err = tb.Select("customer_id,cr_nick as customer_name").Where("shop_id =? AND cr_userid =?", req.ShopID, req.UserID).Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("CustomerIDSee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//添加我的客户request
type CustomerIncreaseReq struct {
	CrNick      string `json:"cr_nick"`      // 客户昵称
	CrHeadimg   string `json:"cr_headimg"`   // 头像
	IsAddress   uint8  `json:"is_address"`   //0:没有地址  1：有地址
	Name        string `json:"name"`         // 姓名
	PhoneNumber string `json:"phone_number"` // 手机号码
	Province    string `json:"province"`     // 省
	City        string `json:"city"`         // 市
	Area        string `json:"area"`         // 区
	Detailed    string `json:"detailed"`     // 详细地址
	IsDefault   int32  `json:"is_default"`   // 0:不是默认地址 1:是
	UserID      uint32 //后台自用
}

type CustomerIncreaseResp struct {
	CustomerID   uint32 `json:"customer_id"`   // 客户id
	CustomerName string `json:"customer_name"` // 客户名称
}

type UserInfoResp struct {
	NickName  string `json:"nick_name"`  // 微信名字
	AvatarURL string `json:"avatar_url"` // 微信头像
}

//查询用户信息
func UserInfoSee(UserID uint32) (res *UserInfoResp, err error) {
	tb := dbGorm.Table("user")
	res = &UserInfoResp{}
	err = tb.Where("user_id=?", UserID).Scan(&res).Error
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("UserInfoSee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//查询添加的名字是否有相同的
func IsNameIncrease(req *CustomerIncreaseReq, ShopID uint64) bool {
	has, err := dbXorm.Table("h_customer").Where("cr_nick=? and shop_id=?", req.CrNick, ShopID).Exist()
	if err != nil {
		err = fmt.Errorf("IsNameIncrease Db err:%s", err)
		zaplog.Errorf(err.Error())
		return has
	}
	return has
}

//添加我的客户
func CustomerIncrease(req *CustomerIncreaseReq, ShopID uint64) (res *CustomerIncreaseResp, msg string, err error) {
	tb := dbGorm.Table("h_customer")
	Customer := &entity.HCustomer{}
	Customer.ShopID = ShopID
	Customer.CrNick = req.CrNick
	Customer.CrHeadimg = req.CrHeadimg
	if req.UserID > 99999 {
		Customer.CrUserid = req.UserID
	}
	err = tb.Create(Customer).Error
	if err != nil {
		err = fmt.Errorf("CustomerIncrease Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	res = &CustomerIncreaseResp{}
	err = tb.Select("customer_id,cr_nick as customer_name").Where("shop_id=? AND cr_nick=?", ShopID, req.CrNick).Scan(&res).Error
	if err != nil {
		err = fmt.Errorf("CustomerIncrease Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, "添加不成功,请重新添加!", err
	}
	if req.IsAddress == 1 {
		HCustomer := &entity.HCustomerAddr{}
		HCustomer.CustomerID = res.CustomerID
		HCustomer.Name = req.Name
		HCustomer.PhoneNumber = req.PhoneNumber
		HCustomer.Province = req.Province
		HCustomer.City = req.City
		HCustomer.Area = req.Area
		HCustomer.Detailed = req.Detailed
		HCustomer.IsDefault = req.IsDefault
		err = dbGorm.Table("h_customer_addr").Create(HCustomer).Error
		if err != nil {
			err = fmt.Errorf("CustomerIncrease Db err:%s", err)
			zaplog.Errorf(err.Error())
			return
		}
	}
	return
}

//修改我的客户request
type CustomerUpdateReq struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
	CrNick     string `json:"cr_nick"`     // 客户昵称
	CrHeadimg  string `json:"cr_headimg"`  // 头像
}

type CustomerUpdateResp struct {
}

//修改我的客户
func CustomerUpdate(req *CustomerUpdateReq, ShopID uint64) (res *CustomerUpdateResp, err error) {
	tb := dbGorm.Table("h_customer")
	err = tb.Where("shop_id=? AND customer_id=?", ShopID, req.CustomerID).Update(map[string]interface{}{"cr_nick": req.CrNick, "cr_headimg": req.CrHeadimg}).Error
	if err != nil {
		err = fmt.Errorf("CustomerUpdate Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	err = dbGorm.Table("orders").Where("customer_id=? AND order_status !=3 AND status = 1", req.CustomerID).Update(map[string]interface{}{"customer_name": req.CrNick}).Error
	if err != nil {
		err = fmt.Errorf("CustomerUpdate Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, err
}

//删除我的客户request
type CustomerDeleteReq struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type CustomerDeleteResp struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type IsCustomerIDCount struct {
	Count uint32 `json:"count"` // 是否存在订单
}

//判断该客户名下是否存在未完成的订单
func IsCustomerOrders(req *CustomerDeleteReq) bool {

	res := &IsCustomerIDCount{}
	has, err := dbXorm.Table("orders").Where("customer_id = ? AND status = 1 AND order_status != 3", req.CustomerID).Exist()
	if has {
		err = fmt.Errorf("IsCustomerOrders Db err:%s", err)
		zaplog.Errorf(err.Error())
		return false
	}
	rows := dbGorm.Table("h_preorder").Select("count(h_preorder.id) as count").Joins("left join orders_goods on orders_goods.hp_id=h_preorder.id").Where("h_preorder.customer_id = ? AND h_preorder.buy_status = 0 AND orders_goods.status != -1", req.CustomerID).Scan(&res)
	if res.Count > 0 {
		err = fmt.Errorf("IsCustomerOrders Db err:%s", rows.Error)
		zaplog.Errorf(err.Error())
		return false
	}
	return true
}

//删除我的客户
func CustomerDelete(req *CustomerDeleteReq) (res *CustomerDeleteResp, err error) {
	tb := dbGorm.Table("h_customer")
	res = &CustomerDeleteResp{}
	res.CustomerID = req.CustomerID
	err = tb.Where("customer_id = ?", req.CustomerID).Delete(res).Error
	if err != nil {
		return res, err
	}
	return res, err
}

//手动绑定客户与平台用户request
type CustomerBindingReq struct {
	CrUserid   uint32 `json:"cr_userid"`   // 平台用户id(未绑定时 该字段为0 ）
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type CustomerBindingResp struct {
	CustomerID uint32 `json:"customer_id"` // 客户id
}

type CustomerShopIDResp struct {
	ShopID uint64 `json:"shop_id"` // 客户绑定的shop_id
}

type CustomerUserIDResp struct {
	CrUserid uint32 `json:"cr_userid"` // 平台用户id(未绑定时 该字段为0 ）
}

type CustomerUrlResp struct {
	AvatarURL string `json:"avatar_url"` // 微信头像
}

//查询该用户是否是我名下平台粉丝
func IsFansBinding(req *CustomerBindingReq, ShopID uint64) bool {
	has, err := dbXorm.Table("shop_fans").Where("user_id=? and shop_id=?", req.CrUserid, ShopID).Exist()
	if err != nil {
		err = fmt.Errorf("IsFansBinding Db err:%s", err)
		zaplog.Errorf(err.Error())
		return has
	}
	return has
}

//查询该用户是否是否已经绑定在我名下其他用户
func IsUserBinding(req *CustomerBindingReq, ShopID uint64) bool {
	has, err := dbXorm.Table("h_customer").Where("cr_userid=? and shop_id=?", req.CrUserid, ShopID).Exist()
	if err != nil {
		err = fmt.Errorf("IsFansBinding Db err:%s", err)
		zaplog.Errorf(err.Error())
		return has
	}
	return has
}

//查询该客户是否已经绑定用户
func IsCustomerBinding(req *CustomerBindingReq) bool {
	res := &CustomerUserIDResp{}
	err := dbGorm.Table("h_customer").Where("customer_id=?", req.CustomerID).Scan(&res).Error
	if err != nil {
		err = fmt.Errorf("IsFansBinding Db err:%s", err)
		zaplog.Errorf(err.Error())
		return false
	}
	if res.CrUserid > 0 {
		return false
	} else {
		return true
	}
}

//查询该客户是否已经绑定用户
func CustomerUrl(UserID uint32) (res *CustomerUrlResp, err error) {
	res = &CustomerUrlResp{}
	err = dbGorm.Table("user").Select("avatar_url").Where("user_id=?", UserID).Scan(&res).Error
	if err != nil {
		err = fmt.Errorf("CustomerUrl Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, nil
	}
	return res, err
}

//查询客户绑定的shop_id
func CustomerShopIDSee(req *CustomerBindingReq) (res *CustomerShopIDResp, err error) {
	tb := dbGorm.Table("h_customer")
	res = &CustomerShopIDResp{}
	err = tb.Where("customer_id=?", req.CustomerID).Scan(&res).Error
	if err != nil {
		err = fmt.Errorf("CustomerShopIDSee Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	return
}

//手动绑定客户与平台用户
func CustomerBinding(req *CustomerBindingReq, ShopID uint64, url string) (err error) {
	tb := dbGorm.Table("h_customer")
	err = tb.Where("shop_id=? AND customer_id=?", ShopID, req.CustomerID).Update(map[string]interface{}{"cr_userid": req.CrUserid, "cr_headimg": url}).Error
	if err != nil {
		err = fmt.Errorf("CustomerBinding Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	return
}

//客户统计request
type CustomerStatisticsReq struct {
}

type CustomerStatisticsResp struct {
	CustomerCount  uint32 `json:"customer_count"`  // 总客户个数
	CustomerBind   uint32 `json:"customer_bind"`   // 绑定客户个数
	CustomerNoBind uint32 `json:"customer_nobind"` // 未绑定客户个数
}

//客户统计
func CustomerStatistics(ShopID uint64) (res *CustomerStatisticsResp, err error) {
	tb := dbGorm.Table("h_customer")
	res = &CustomerStatisticsResp{}
	err = tb.Where("shop_id=?", ShopID).Count(&res.CustomerCount).Error
	if err != nil {
		err = fmt.Errorf("CustomerStatistics Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	err = tb.Where("shop_id=? AND cr_userid != 0", ShopID).Count(&res.CustomerBind).Error
	if err != nil {
		err = fmt.Errorf("CustomerStatistics Db err:%s", err)
		zaplog.Errorf(err.Error())
		return
	}
	res.CustomerNoBind = res.CustomerCount - res.CustomerBind
	return
}

//查看地址request
type AddressSeeReq struct {
	CustomerID  uint32 `json:"customer_id"` // 客户id
	IsDefault   int32  `json:"is_default"`  //0:不是默认地址 1:是
	Start_Index int    `json:"start_index"` //查询起始索引
	Count       int    `json:"count"`       //页面列表个数
}

type AddressSeeResp struct {
	AddressID   uint32 `json:"address_id"`   //地址编号
	IsDefault   int32  `json:"is_default"`   //0:不是默认地址 1:是
	Name        string `json:"name"`         //姓名
	PhoneNumber string `json:"phone_number"` //手机号
	Province    string `json:"province"`     //省
	City        string `json:"city"`         //市
	Area        string `json:"area"`         //区
	Detailed    string `json:"detailed"`     //详细地址
}

//查看地址
func AddressSee(req *AddressSeeReq) (res []*AddressSeeResp, err error) {
	tb := dbGorm.Table("h_customer_addr")
	if req.IsDefault == 0 {
		err = tb.Offset(req.Start_Index).Limit(req.Count).Where("customer_id=?", req.CustomerID).Scan(&res).Error
	} else {
		err = tb.Where("customer_id=? AND is_default = 1", req.CustomerID).Scan(&res).Error
	}
	if err != nil && !gorm.IsRecordNotFoundError(err) {
		err = fmt.Errorf("SeeAddress Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, nil
}

//新增地址request
type AddressIncreaseReq struct {
	AddressID   uint32 `json:"address_id"`   //修改地址时使用
	CustomerID  uint32 `json:"customer_id"`  // 客户id
	IsDefault   int32  `json:"is_default"`   //0:不设为默认地址 1:设为
	Name        string `json:"name"`         //姓名
	PhoneNumber string `json:"phone_number"` //手机号
	Province    string `json:"province"`     //省
	City        string `json:"city"`         //市
	Area        string `json:"area"`         //区
	Detailed    string `json:"detailed"`     //详细地址
}

type AddressIncreaseResp struct {
}

//查询该客户这条地址信息是否已经存在
func IsAddress(req *AddressIncreaseReq) bool {
	has, err := dbXorm.Table("h_customer_addr").Where("customer_id=? and is_default=? and name=? and phone_number=? and province=? and city=? and area=? and detailed=?",
		req.CustomerID, req.IsDefault, req.Name, req.PhoneNumber, req.Province, req.City, req.Area, req.Detailed).Exist()
	if err != nil {
		err = fmt.Errorf("IsAddress Db err:%s", err)
		zaplog.Errorf(err.Error())
		return has
	}
	return has
}

//新增地址
func AddressIncrease(req *AddressIncreaseReq) (res *AddressIncreaseResp, err error) {
	tb := dbGorm.Table("h_customer_addr")
	if req.IsDefault == 1 {
		err = tb.Where("customer_id=?", req.CustomerID).Update(map[string]interface{}{"is_default": 0}).Error
		if err != nil {
			err = fmt.Errorf("AddressIncrease Db err:%s", err)
			zaplog.Errorf(err.Error())
			return res, err
		}
	}
	Address := &entity.HCustomerAddr{}
	Address.CustomerID = req.CustomerID
	Address.Name = req.Name
	Address.PhoneNumber = req.PhoneNumber
	Address.Province = req.Province
	Address.City = req.City
	Address.Area = req.Area
	Address.Detailed = req.Detailed
	Address.IsDefault = req.IsDefault
	err = tb.Create(Address).Error
	if err != nil {
		err = fmt.Errorf("IncreaseAddress Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}

	return res, err
}

//修改地址request
type AddressUpdateReq struct {
	AddressID   uint32 `json:"address_id"`   //地址编号
	CustomerID  uint32 `json:"customer_id"`  // 客户id
	IsDefault   int32  `json:"is_default"`   //0:不设为默认地址 1:设为
	Name        string `json:"name"`         //姓名
	PhoneNumber string `json:"phone_number"` //手机号
	Province    string `json:"province"`     //省
	City        string `json:"city"`         //市
	Area        string `json:"area"`         //区
	Detailed    string `json:"detailed"`     //详细地址
}

type AddressUpdateResp struct {
}

//修改地址
func AddressUpdate(req *AddressIncreaseReq) (res *AddressUpdateResp, err error) {
	tb := dbGorm.Table("h_customer_addr")
	if req.IsDefault == 1 {
		err = tb.Where("customer_id=?", req.CustomerID).Update(map[string]interface{}{"is_default": 0}).Error
		if err != nil {
			err = fmt.Errorf("AddressUpdate Db err:%s", err)
			zaplog.Errorf(err.Error())
			return res, err
		}
	}
	err = tb.Where("address_id=?", req.AddressID).Update(map[string]interface{}{"phone_number": req.PhoneNumber, "name": req.Name,
		"province": req.Province, "city": req.City, "area": req.Area, "detailed": req.Detailed, "is_default": req.IsDefault}).Error
	if err != nil {
		err = fmt.Errorf("AddressUpdate Db err:%s", err)
		zaplog.Errorf(err.Error())
		return res, err
	}
	return res, err
}

//删除地址request
type AddressDeleteReq struct {
	AddressID uint32 `json:"address_id"` //地址编号
}

type AddressDeleteResp struct {
	AddressID uint32 `json:"address_id"` //地址编号
}

//删除地址
func AddressDelete(req *AddressDeleteReq) (res *AddressDeleteResp, err error) {
	tb := dbGorm.Table("h_customer_addr")
	res = &AddressDeleteResp{}
	res.AddressID = req.AddressID
	err = tb.Where("address_id = ?", req.AddressID).Delete(res).Error
	if err != nil {
		return res, err
	}
	return res, err
}
