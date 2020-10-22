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

// GoodsCategory struct is a row record of the goods_category table in the daigou database
type GoodsCategory struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] category_id                                    int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	CategoryID int32 `gorm:"column:category_id;type:int;" json:"category_id"` // 分类id
	//[ 2] category_name                                  varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	CategoryName string `gorm:"column:category_name;type:varchar;" json:"category_name"` // 分类名称

}

// TableName sets the insert table name for this struct type
func (g *GoodsCategory) TableName() string {
	return "goods_category"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (g *GoodsCategory) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (g *GoodsCategory) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (g *GoodsCategory) Validate(action Action) error {
	return nil
}
