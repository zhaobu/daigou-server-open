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

// HCustomerAddr struct is a row record of the h_customer_addr table in the daigou database
type HCustomerAddr struct {
	//[ 0] address_id                                     uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	AddressID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:address_id;type:uint;" json:"address_id"` // 地址编号
	//[ 1] customer_id                                    uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	CustomerID uint32 `gorm:"column:customer_id;type:uint;" json:"customer_id"` // 客户id
	//[ 2] name                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Name string `gorm:"column:name;type:varchar;" json:"name"` // 姓名
	//[ 3] phone_number                                   varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	PhoneNumber string `gorm:"column:phone_number;type:varchar;" json:"phone_number"` // 手机号码
	//[ 4] province                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Province string `gorm:"column:province;type:varchar;" json:"province"` // 省
	//[ 5] city                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	City string `gorm:"column:city;type:varchar;" json:"city"` // 市
	//[ 6] area                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Area string `gorm:"column:area;type:varchar;" json:"area"` // 区
	//[ 7] detailed                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Detailed string `gorm:"column:detailed;type:varchar;" json:"detailed"` // 详细地址
	//[ 8] is_default                                     int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	IsDefault int32 `gorm:"column:is_default;type:int;default:0;" json:"is_default"` // 0:不是默认地址 1:是
	//[ 9] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 注册时间
	//[10] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 修改时间
	//[11] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HCustomerAddr) TableName() string {
	return "h_customer_addr"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HCustomerAddr) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HCustomerAddr) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HCustomerAddr) Validate(action Action) error {
	return nil
}
