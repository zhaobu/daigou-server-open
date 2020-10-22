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

// ShopProfit struct is a row record of the shop_profit table in the daigou database
type ShopProfit struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 2] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 买家用户编号
	//[ 3] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 卖家用户编号(或称店铺编号)
	//[ 4] price                                          decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Price float64 `gorm:"column:price;type:decimal;" json:"price"` // 总金额
	//[ 5] profit                                         decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Profit float64 `gorm:"column:profit;type:decimal;" json:"profit"` // 订单利润
	//[ 6] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间

}

// TableName sets the insert table name for this struct type
func (s *ShopProfit) TableName() string {
	return "shop_profit"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopProfit) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopProfit) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopProfit) Validate(action Action) error {
	return nil
}
