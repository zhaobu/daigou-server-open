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

// ShopVip struct is a row record of the shop_vip table in the daigou database
type ShopVip struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"`
	//[ 2] vip_level                                      uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	VipLevel uint32 `gorm:"column:vip_level;type:uint;" json:"vip_level"` // vip等级
	//[ 3] vip_name                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	VipName string `gorm:"column:vip_name;type:varchar;" json:"vip_name"` // 等级名称
	//[ 4] opening_time                                   datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	OpeningTime *Time `gorm:"column:opening_time;type:datetime;" json:"opening_time"` // 开通时间
	//[ 5] end_time                                       datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	EndTime *Time `gorm:"column:end_time;type:datetime;" json:"end_time"` // 到期时间
	//[ 6] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"`
	//[ 7] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"`
	//[ 8] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"`
}

// TableName sets the insert table name for this struct type
func (s *ShopVip) TableName() string {
	return "shop_vip"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopVip) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopVip) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopVip) Validate(action Action) error {
	return nil
}
