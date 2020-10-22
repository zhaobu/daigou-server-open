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

// OrdersPrinting struct is a row record of the orders_printing table in the daigou database
type OrdersPrinting struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: [0]
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;default:0;" json:"shop_id"` // 店铺编号
	//[ 2] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 3] printing_count                                 uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	PrintingCount uint32 `gorm:"column:printing_count;type:uint;" json:"printing_count"` // 打印次数
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 5] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间

}

// TableName sets the insert table name for this struct type
func (o *OrdersPrinting) TableName() string {
	return "orders_printing"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (o *OrdersPrinting) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (o *OrdersPrinting) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (o *OrdersPrinting) Validate(action Action) error {
	return nil
}
