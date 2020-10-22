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

// GoodsAccessRecords struct is a row record of the goods_access_records table in the daigou database
type GoodsAccessRecords struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] goods_id                                       ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	GoodsID uint64 `gorm:"column:goods_id;type:ubigint;" json:"goods_id"` // 商品id
	//[ 2] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 3] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 访问时间

}

// TableName sets the insert table name for this struct type
func (g *GoodsAccessRecords) TableName() string {
	return "goods_access_records"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (g *GoodsAccessRecords) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (g *GoodsAccessRecords) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (g *GoodsAccessRecords) Validate(action Action) error {
	return nil
}
