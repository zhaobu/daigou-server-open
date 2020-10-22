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

// SystemAnn struct is a row record of the system_ann table in the daigou database
type SystemAnn struct {
	//[ 0] id                                             int                  null: false  primary: true   isArray: false  auto: false  col: int             len: -1      default: []
	ID int32 `gorm:"primary_key;column:id;type:int;" json:"id"`
	//[ 1] system_ann_version                             varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SystemAnnVersion string `gorm:"column:system_ann_version;type:varchar;" json:"system_ann_version"` // 版本号
	//[ 2] system_ann_target                              uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	SystemAnnTarget uint32 `gorm:"column:system_ann_target;type:uint;" json:"system_ann_target"` // 0所有 1普通用户2代购
	//[ 3] system_ann_type                                uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	SystemAnnType uint32 `gorm:"column:system_ann_type;type:uint;" json:"system_ann_type"` // 0拉取信息 1滚动展示 2弹框展示
	//[ 4] system_ann_msg                                 text                 null: false  primary: false  isArray: false  auto: false  col: text            len: 0       default: []
	SystemAnnMsg string `gorm:"column:system_ann_msg;type:text;" json:"system_ann_msg"` // 内容
	//[ 5] system_ann_status                              uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	SystemAnnStatus uint32 `gorm:"column:system_ann_status;type:uint;" json:"system_ann_status"` // 状态 0禁用 1开启
	//[ 6] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 7] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 8] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (s *SystemAnn) TableName() string {
	return "system_ann"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *SystemAnn) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *SystemAnn) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *SystemAnn) Validate(action Action) error {
	return nil
}
