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

// GoodsMessage struct is a row record of the goods_message table in the daigou database
type GoodsMessage struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] goods_id                                       ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	GoodsID uint64 `gorm:"column:goods_id;type:ubigint;" json:"goods_id"` // 商品id
	//[ 2] userid                                         int                  null: true   primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Userid null.Int `gorm:"column:userid;type:int;" json:"userid"` // 留言用户
	//[ 3] comment                                        varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Comment null.String `gorm:"column:comment;type:varchar;" json:"comment"` // 留言内容
	//[ 4] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 留言时间

}

// TableName sets the insert table name for this struct type
func (g *GoodsMessage) TableName() string {
	return "goods_message"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (g *GoodsMessage) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (g *GoodsMessage) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (g *GoodsMessage) Validate(action Action) error {
	return nil
}
