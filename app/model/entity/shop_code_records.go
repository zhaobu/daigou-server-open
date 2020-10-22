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

// ShopCodeRecords struct is a row record of the shop_code_records table in the daigou database
type ShopCodeRecords struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺ID(使用此店铺码开通的商店id)
	//[ 2] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 3] bind_shop_id                                   ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	BindShopID uint64 `gorm:"column:bind_shop_id;type:ubigint;" json:"bind_shop_id"` // 生成店铺码的店铺ID
	//[ 4] gen_type                                       uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	GenType uint32 `gorm:"column:gen_type;type:uint;" json:"gen_type"` // 生成方式

}

// TableName sets the insert table name for this struct type
func (s *ShopCodeRecords) TableName() string {
	return "shop_code_records"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopCodeRecords) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopCodeRecords) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopCodeRecords) Validate(action Action) error {
	return nil
}
