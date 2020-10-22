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

// CasbinRoleAPI struct is a row record of the casbin_role_api table in the daigou database
type CasbinRoleAPI struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] name                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: [用户]
	Name string `gorm:"column:name;type:varchar;default:用户;" json:"name"` // 角色名称
	//[ 2] api_list                                       json                 null: false  primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	APIList string `gorm:"column:api_list;type:json;" json:"api_list"` // 角色不能能访问的api列表
	//[ 3] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 4] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 5] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (c *CasbinRoleAPI) TableName() string {
	return "casbin_role_api"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (c *CasbinRoleAPI) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (c *CasbinRoleAPI) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (c *CasbinRoleAPI) Validate(action Action) error {
	return nil
}
