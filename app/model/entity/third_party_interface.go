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

// ThirdPartyInterface struct is a row record of the third_party_interface table in the daigou database
type ThirdPartyInterface struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] third_party_id                                 int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	ThirdPartyID int32 `gorm:"column:third_party_id;type:int;" json:"third_party_id"` // 第三方接口平台id
	//[ 2] third_name                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ThirdName null.String `gorm:"column:third_name;type:varchar;" json:"third_name"` // 第三方接口名称
	//[ 3] third_url                                      varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ThirdURL null.String `gorm:"column:third_url;type:varchar;" json:"third_url"` // 第三方接口url链接
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 编辑时间

}

// TableName sets the insert table name for this struct type
func (t *ThirdPartyInterface) TableName() string {
	return "third_party_interface"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (t *ThirdPartyInterface) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (t *ThirdPartyInterface) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (t *ThirdPartyInterface) Validate(action Action) error {
	return nil
}
