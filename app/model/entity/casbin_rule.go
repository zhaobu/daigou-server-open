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

// CasbinRule struct is a row record of the casbin_rule table in the daigou database
type CasbinRule struct {
	//[ 0] p_type                                         varchar              null: false  primary: true   isArray: false  auto: false  col: varchar         len: 0       default: []
	PType string `gorm:"primary_key;column:p_type;type:varchar;" json:"p_type"`
	//[ 1] v0                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V0 null.String `gorm:"column:v0;type:varchar;" json:"v_0"`
	//[ 2] v1                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V1 null.String `gorm:"column:v1;type:varchar;" json:"v_1"`
	//[ 3] v2                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V2 null.String `gorm:"column:v2;type:varchar;" json:"v_2"`
	//[ 4] v3                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V3 null.String `gorm:"column:v3;type:varchar;" json:"v_3"`
	//[ 5] v4                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V4 null.String `gorm:"column:v4;type:varchar;" json:"v_4"`
	//[ 6] v5                                             varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	V5 null.String `gorm:"column:v5;type:varchar;" json:"v_5"`
}

// TableName sets the insert table name for this struct type
func (c *CasbinRule) TableName() string {
	return "casbin_rule"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (c *CasbinRule) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (c *CasbinRule) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (c *CasbinRule) Validate(action Action) error {
	return nil
}
