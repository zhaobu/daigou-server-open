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

// TestDb struct is a row record of the test_db table in the daigou database
type TestDb struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] created_at                                     datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 2] updated_at                                     datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 3] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[ 4] type_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: [0]
	TypeID uint64 `gorm:"column:type_id;type:ubigint;default:0;" json:"type_id"`
	//[ 5] name                                           varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Name null.String `gorm:"column:name;type:varchar;" json:"name"`
	//[ 6] age                                            int                  null: true   primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Age null.Int `gorm:"column:age;type:int;" json:"age"`
	//[ 7] avatar_url                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	AvatarURL null.String `gorm:"column:avatar_url;type:varchar;" json:"avatar_url"`
	//[ 8] passwd                                         varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Passwd string `gorm:"column:passwd;type:varchar;" json:"passwd"`
	//[ 9] created                                        datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	Created *Time `gorm:"column:created;type:datetime;" json:"created"`
	//[10] updated                                        datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	Updated *Time `gorm:"column:updated;type:datetime;" json:"updated"`
	//[11] gender                                         char                 null: true   primary: false  isArray: false  auto: false  col: char            len: 0       default: []
	Gender null.String `gorm:"column:gender;type:char;" json:"gender"`
	//[12] birthday                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	Birthday *Time `gorm:"column:birthday;type:datetime;" json:"birthday"`
	//[13] email                                          varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Email null.String `gorm:"column:email;type:varchar;" json:"email"`
	//[14] price                                          udecimal             null: true   primary: false  isArray: false  auto: false  col: udecimal        len: -1      default: []
	Price null.Float `gorm:"column:price;type:udecimal;" json:"price"`
	//[15] detial                                         json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	Detial null.String `gorm:"column:detial;type:json;" json:"detial"`
}

// TableName sets the insert table name for this struct type
func (t *TestDb) TableName() string {
	return "test_db"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (t *TestDb) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (t *TestDb) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (t *TestDb) Validate(action Action) error {
	return nil
}
