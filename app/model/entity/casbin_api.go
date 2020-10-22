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

// CasbinAPI struct is a row record of the casbin_api table in the daigou database
type CasbinAPI struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] name                                           varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Name null.String `gorm:"column:name;type:varchar;" json:"name"` // 名字
	//[ 2] menu_type                                      char                 null: false  primary: false  isArray: false  auto: false  col: char            len: 0       default: [主页]
	MenuType string `gorm:"column:menu_type;type:char;default:主页;" json:"menu_type"` // 菜单类型
	//[ 3] path                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Path string `gorm:"column:path;type:varchar;" json:"path"` // 访问路径
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 5] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 6] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (c *CasbinAPI) TableName() string {
	return "casbin_api"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (c *CasbinAPI) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (c *CasbinAPI) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (c *CasbinAPI) Validate(action Action) error {
	return nil
}
