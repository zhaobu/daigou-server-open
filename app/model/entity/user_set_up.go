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

// UserSetUp struct is a row record of the user_set_up table in the daigou database
type UserSetUp struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"`
	//[ 1] privacy_policy                                 varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	PrivacyPolicy null.String `gorm:"column:privacy_policy;type:varchar;" json:"privacy_policy"` // 隐私政策
	//[ 2] user_service_agreement                         varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	UserServiceAgreement null.String `gorm:"column:user_service_agreement;type:varchar;" json:"user_service_agreement"` // 用户服务协议

}

// TableName sets the insert table name for this struct type
func (u *UserSetUp) TableName() string {
	return "user_set_up"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (u *UserSetUp) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (u *UserSetUp) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (u *UserSetUp) Validate(action Action) error {
	return nil
}
