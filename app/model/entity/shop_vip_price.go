package entity

import (
	"database/sql"
	"time"

	"github.com/guregu/null"
	uuid "github.com/satori/go.uuid"
)

var (
	_ = time.Second
	_ = sql.LevelDefault
	_ = null.Bool{}
	_ = uuid.UUID{}
)

// ShopVipPrice struct is a row record of the shop_vip_price table in the daigou database
type ShopVipPrice struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"`
	//[ 1] member_name                                    varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	MemberName string `gorm:"column:member_name;type:varchar;" json:"member_name"` // 商品名称
	//[ 2] member_discount_price                          udecimal             null: false  primary: false  isArray: false  auto: false  col: udecimal        len: -1      default: []
	MemberDiscountPrice float64 `gorm:"column:member_discount_price;type:udecimal;" json:"member_discount_price"` // 商品折扣价格
	//[ 3] member_original_price                          decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	MemberOriginalPrice float64 `gorm:"column:member_original_price;type:decimal;" json:"member_original_price"` // 商品原始价格
	//[ 4] member_jian_shao                               varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	MemberJianShao string `gorm:"column:member_jian_shao;type:varchar;" json:"member_jian_shao"` // 商品简绍

}

// TableName sets the insert table name for this struct type
func (s *ShopVipPrice) TableName() string {
	return "shop_vip_price"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopVipPrice) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopVipPrice) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopVipPrice) Validate(action Action) error {
	return nil
}
