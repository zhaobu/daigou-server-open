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

// OrdersBillFlow struct is a row record of the orders_bill_flow table in the daigou database
type OrdersBillFlow struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 2] before                                         decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Before null.Float `gorm:"column:before;type:decimal;" json:"before"` // 之前金额
	//[ 3] last                                           decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Last null.Float `gorm:"column:last;type:decimal;" json:"last"` // 之后金额
	//[ 4] change_value                                   decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	ChangeValue null.Float `gorm:"column:change_value;type:decimal;" json:"change_value"` // 变化金额
	//[ 5] remarks                                        varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Remarks null.String `gorm:"column:remarks;type:varchar;" json:"remarks"` // 备注
	//[ 6] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 7] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 8] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (o *OrdersBillFlow) TableName() string {
	return "orders_bill_flow"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (o *OrdersBillFlow) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (o *OrdersBillFlow) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (o *OrdersBillFlow) Validate(action Action) error {
	return nil
}
