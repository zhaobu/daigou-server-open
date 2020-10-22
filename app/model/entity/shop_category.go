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

// ShopCategory struct is a row record of the shop_category table in the daigou database
type ShopCategory struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // id
	//[ 1] category_id                                    uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	CategoryID uint32 `gorm:"column:category_id;type:uint;" json:"category_id"` // 商品分类id
	//[ 2] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺ID
	//[ 3] category_name                                  varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	CategoryName string `gorm:"column:category_name;type:varchar;" json:"category_name"` // 分类名称
	//[ 4] category_sort                                  uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	CategorySort uint32 `gorm:"column:category_sort;type:uint;" json:"category_sort"` // 排序字段
	//[ 5] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间

}

// TableName sets the insert table name for this struct type
func (s *ShopCategory) TableName() string {
	return "shop_category"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopCategory) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopCategory) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopCategory) Validate(action Action) error {
	return nil
}
