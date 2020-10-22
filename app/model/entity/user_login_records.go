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

// UserLoginRecords struct is a row record of the user_login_records table in the daigou database
type UserLoginRecords struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 2] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 登录时间
	//[ 3] type                                           int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Type int32 `gorm:"column:type;type:int;" json:"type"` // 登录类型

}

// TableName sets the insert table name for this struct type
func (u *UserLoginRecords) TableName() string {
	return "user_login_records"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (u *UserLoginRecords) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (u *UserLoginRecords) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (u *UserLoginRecords) Validate(action Action) error {
	return nil
}
