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

// ShopCode struct is a row record of the shop_code table in the daigou database
type ShopCode struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	ShopID uint32 `gorm:"column:shop_id;type:uint;" json:"shop_id"` // 店铺ID
	//[ 2] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 3] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 4] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[ 5] code                                           varchar(10)          null: true   primary: false  isArray: false  auto: false  col: varchar         len: 10      default: []
	Code null.String `gorm:"column:code;type:varchar;size:10;" json:"code"` // 店铺码
	//[ 6] end_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	EndTime *Time `gorm:"column:end_time;type:datetime;" json:"end_time"` // 到期时间

}

// TableName sets the insert table name for this struct type
func (s *ShopCode) TableName() string {
	return "shop_code"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopCode) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopCode) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopCode) Validate(action Action) error {
	return nil
}
