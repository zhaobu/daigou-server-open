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

// ShopVipExplain struct is a row record of the shop_vip_explain table in the daigou database
type ShopVipExplain struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"`
	//[ 1] limit_name                                     varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	LimitName string `gorm:"column:limit_name;type:varchar;" json:"limit_name"` // 限制名称
	//[ 2] limit_explain                                  varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	LimitExplain string `gorm:"column:limit_explain;type:varchar;" json:"limit_explain"` // 限制说明
	//[ 3] vip_explain                                    int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	VipExplain int32 `gorm:"column:vip_explain;type:int;" json:"vip_explain"` // vip限制（）
	//[ 4] ordinary_explain                               int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	OrdinaryExplain int32 `gorm:"column:ordinary_explain;type:int;" json:"ordinary_explain"` // 普通用户限制（）

}

// TableName sets the insert table name for this struct type
func (s *ShopVipExplain) TableName() string {
	return "shop_vip_explain"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopVipExplain) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopVipExplain) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopVipExplain) Validate(action Action) error {
	return nil
}
