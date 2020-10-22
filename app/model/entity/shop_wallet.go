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

// ShopWallet struct is a row record of the shop_wallet table in the daigou database
type ShopWallet struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 2] month_orders                                   uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	MonthOrders uint32 `gorm:"column:month_orders;type:uint;" json:"month_orders"` // 月订单个数
	//[ 3] month_profit                                   decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	MonthProfit float64 `gorm:"column:month_profit;type:decimal;" json:"month_profit"` // 月收益
	//[ 4] month_cost                                     decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	MonthCost float64 `gorm:"column:month_cost;type:decimal;" json:"month_cost"` // 月成本
	//[ 5] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"`
	//[ 6] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"`
}

// TableName sets the insert table name for this struct type
func (s *ShopWallet) TableName() string {
	return "shop_wallet"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopWallet) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopWallet) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopWallet) Validate(action Action) error {
	return nil
}
