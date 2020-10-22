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

// ExpressTemplateConfig struct is a row record of the express_template_config table in the daigou database
type ExpressTemplateConfig struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"`
	//[ 1] templete_name                                  varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	TempleteName string `gorm:"column:templete_name;type:varchar;" json:"templete_name"` // 模板名称
	//[ 2] templete_data                                  text                 null: false  primary: false  isArray: false  auto: false  col: text            len: 0       default: []
	TempleteData string `gorm:"column:templete_data;type:text;" json:"templete_data"` // 模板数据
	//[ 3] express_company_id                             uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	ExpressCompanyID uint32 `gorm:"column:express_company_id;type:uint;" json:"express_company_id"` // 快递公司ID

}

// TableName sets the insert table name for this struct type
func (e *ExpressTemplateConfig) TableName() string {
	return "express_template_config"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (e *ExpressTemplateConfig) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (e *ExpressTemplateConfig) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (e *ExpressTemplateConfig) Validate(action Action) error {
	return nil
}
