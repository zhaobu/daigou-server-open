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

// ShopFans struct is a row record of the shop_fans table in the daigou database
type ShopFans struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺id
	//[ 2] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 3] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 4] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[ 5] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 粉丝id
	//[ 6] category                                       int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Category int32 `gorm:"column:category;type:int;" json:"category"` // 用于排序：1置顶：为绑定用户 0：为关注用户
	//[ 7] transaction_number                             int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	TransactionNumber int32 `gorm:"column:transaction_number;type:int;default:0;" json:"transaction_number"` // 订单数量
	//[ 8] transaction_amount                             decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	TransactionAmount float64 `gorm:"column:transaction_amount;type:decimal;" json:"transaction_amount"` // 订单总金额
	//[ 9] end_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	EndTime *Time `gorm:"column:end_time;type:datetime;" json:"end_time"` // 最后购买时间

}

// TableName sets the insert table name for this struct type
func (s *ShopFans) TableName() string {
	return "shop_fans"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopFans) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopFans) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopFans) Validate(action Action) error {
	return nil
}
