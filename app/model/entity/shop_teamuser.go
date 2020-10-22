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

// ShopTeamuser struct is a row record of the shop_teamuser table in the daigou database
type ShopTeamuser struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 2] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 3] status                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Status int32 `gorm:"column:status;type:int;" json:"status"` // 0表示申请1表示同意2表示拒绝3表示删除
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 申请时间
	//[ 5] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 修改时间

}

// TableName sets the insert table name for this struct type
func (s *ShopTeamuser) TableName() string {
	return "shop_teamuser"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopTeamuser) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopTeamuser) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopTeamuser) Validate(action Action) error {
	return nil
}
