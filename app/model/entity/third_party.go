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

// ThirdParty struct is a row record of the third_party table in the daigou database
type ThirdParty struct {
	//[ 0] id                                             int                  null: false  primary: true   isArray: false  auto: true   col: int             len: -1      default: []
	ID int32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:int;" json:"id"`
	//[ 1] third_company                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ThirdCompany null.String `gorm:"column:third_company;type:varchar;" json:"third_company"`
	//[ 2] third_account_id                               varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ThirdAccountID null.String `gorm:"column:third_account_id;type:varchar;" json:"third_account_id"`
	//[ 3] third_account_key                              varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ThirdAccountKey null.String `gorm:"column:third_account_key;type:varchar;" json:"third_account_key"`
	//[ 4] create_at                                      datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreateAt *Time `gorm:"column:create_at;type:datetime;" json:"create_at"`
}

// TableName sets the insert table name for this struct type
func (t *ThirdParty) TableName() string {
	return "third_party"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (t *ThirdParty) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (t *ThirdParty) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (t *ThirdParty) Validate(action Action) error {
	return nil
}
