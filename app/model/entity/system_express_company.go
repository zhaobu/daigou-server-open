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

// SystemExpressCompany struct is a row record of the system_express_company table in the daigou database
type SystemExpressCompany struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] express_code                                   varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExpressCode null.String `gorm:"column:express_code;type:varchar;" json:"express_code"` // 快递编码(快递鸟)
	//[ 2] express_name                                   varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExpressName string `gorm:"column:express_name;type:varchar;" json:"express_name"` // 快递公司名称
	//[ 3] exoress_code_kd100                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExoressCodeKd100 null.String `gorm:"column:exoress_code_kd100;type:varchar;" json:"exoress_code_kd_100"` // 快递编码(快递100)

}

// TableName sets the insert table name for this struct type
func (s *SystemExpressCompany) TableName() string {
	return "system_express_company"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *SystemExpressCompany) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *SystemExpressCompany) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *SystemExpressCompany) Validate(action Action) error {
	return nil
}
