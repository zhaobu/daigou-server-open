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

// HCustomer struct is a row record of the h_customer table in the daigou database
type HCustomer struct {
	//[ 0] customer_id                                    uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	CustomerID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:customer_id;type:uint;" json:"customer_id"` // 客户id
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺ID
	//[ 2] cr_nick                                        varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	CrNick string `gorm:"column:cr_nick;type:varchar;" json:"cr_nick"` // 客户昵称
	//[ 3] cr_headimg                                     varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	CrHeadimg string `gorm:"column:cr_headimg;type:varchar;" json:"cr_headimg"` // 头像
	//[ 4] cr_userid                                      uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: [0]
	CrUserid uint32 `gorm:"column:cr_userid;type:uint;default:0;" json:"cr_userid"` // 平台用户id(未绑定时 该字段为0 ）
	//[ 5] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 注册时间
	//[ 6] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 修改时间
	//[ 7] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HCustomer) TableName() string {
	return "h_customer"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HCustomer) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HCustomer) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HCustomer) Validate(action Action) error {
	return nil
}
