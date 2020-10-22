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

// UserAddress struct is a row record of the user_address table in the daigou database
type UserAddress struct {
	//[ 0] address_id                                     uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	AddressID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:address_id;type:uint;" json:"address_id"` // 地址编号
	//[ 1] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 2] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 3] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[ 4] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 5] phone_number                                   bigint               null: false  primary: false  isArray: false  auto: false  col: bigint          len: -1      default: []
	PhoneNumber int64 `gorm:"column:phone_number;type:bigint;" json:"phone_number"` // 手机号
	//[ 6] name                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Name string `gorm:"column:name;type:varchar;" json:"name"` // 姓名
	//[ 7] gender                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	Gender int32 `gorm:"column:gender;type:int;default:0;" json:"gender"` // 性别,0男生1女生
	//[ 8] province                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Province string `gorm:"column:province;type:varchar;" json:"province"` // 省
	//[ 9] city                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	City string `gorm:"column:city;type:varchar;" json:"city"` // 市
	//[10] area                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Area string `gorm:"column:area;type:varchar;" json:"area"` // 区
	//[11] detailed_address                               varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	DetailedAddress string `gorm:"column:detailed_address;type:varchar;" json:"detailed_address"` // 详细地址
	//[12] is_default                                     int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	IsDefault int32 `gorm:"column:is_default;type:int;default:0;" json:"is_default"` // 0:不是默认地址 1:是
	//[13] classification                                 int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Classification int32 `gorm:"column:classification;type:int;" json:"classification"` // 0:代购自己地址 1;名下成员员地址

}

// TableName sets the insert table name for this struct type
func (u *UserAddress) TableName() string {
	return "user_address"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (u *UserAddress) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (u *UserAddress) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (u *UserAddress) Validate(action Action) error {
	return nil
}
