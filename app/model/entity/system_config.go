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

// SystemConfig struct is a row record of the system_config table in the daigou database
type SystemConfig struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] class_id                                       uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	ClassID uint32 `gorm:"column:class_id;type:uint;" json:"class_id"` // 字典编号
	//[ 2] class_name                                     varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ClassName string `gorm:"column:class_name;type:varchar;" json:"class_name"` // 字典说明
	//[ 3] class_value                                    json                 null: false  primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	ClassValue string `gorm:"column:class_value;type:json;" json:"class_value"` // 字典值

}

// TableName sets the insert table name for this struct type
func (s *SystemConfig) TableName() string {
	return "system_config"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *SystemConfig) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *SystemConfig) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *SystemConfig) Validate(action Action) error {
	return nil
}
