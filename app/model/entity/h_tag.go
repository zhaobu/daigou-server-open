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

// HTag struct is a row record of the h_tag table in the daigou database
type HTag struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺id
	//[ 2] name                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Name string `gorm:"column:name;type:varchar;" json:"name"` // 标签名称
	//[ 3] created_at                                     datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 4] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 5] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HTag) TableName() string {
	return "h_tag"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HTag) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HTag) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HTag) Validate(action Action) error {
	return nil
}
