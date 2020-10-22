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

// HPreorder struct is a row record of the h_preorder table in the daigou database
type HPreorder struct {
	//[ 0] id                                             ubigint              null: false  primary: true   isArray: false  auto: true   col: ubigint         len: -1      default: []
	ID uint64 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:ubigint;" json:"id"` // 主键
	//[ 1] tag_id                                         uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	TagID uint32 `gorm:"column:tag_id;type:uint;" json:"tag_id"` // 预购标签id
	//[ 2] hgs_id                                         ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HgsID uint64 `gorm:"column:hgs_id;type:ubigint;" json:"hgs_id"` // 商品库id
	//[ 3] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 4] customer_id                                    uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	CustomerID uint32 `gorm:"column:customer_id;type:uint;" json:"customer_id"` // 客户id
	//[ 5] buy_status                                     uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: [0]
	BuyStatus uint32 `gorm:"column:buy_status;type:uint;default:0;" json:"buy_status"` // 购买状态 （0 预购 1 已买)
	//[ 6] discount                                       decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Discount null.Float `gorm:"column:discount;type:decimal;" json:"discount"` // 其他优惠 （可正负 ）
	//[ 7] created_at                                     datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 8] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 9] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HPreorder) TableName() string {
	return "h_preorder"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HPreorder) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HPreorder) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HPreorder) Validate(action Action) error {
	return nil
}
