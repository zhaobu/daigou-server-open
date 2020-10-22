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

// ShopExpress struct is a row record of the shop_express table in the daigou database
type ShopExpress struct {
	//[ 0] express_id                                     uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ExpressID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:express_id;type:uint;" json:"express_id"` // 快递标识
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 2] express_code                                   varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExpressCode string `gorm:"column:express_code;type:varchar;" json:"express_code"` // 快递编码
	//[ 3] express_name                                   varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExpressName string `gorm:"column:express_name;type:varchar;" json:"express_name"` // 快递名称
	//[ 4] express_company_id                             uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	ExpressCompanyID uint32 `gorm:"column:express_company_id;type:uint;" json:"express_company_id"` // 快递公司id
	//[ 5] partner_id                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	PartnerID null.String `gorm:"column:partner_id;type:varchar;" json:"partner_id"` // 快递电子面单账号
	//[ 6] partner_key                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	PartnerKey null.String `gorm:"column:partner_key;type:varchar;" json:"partner_key"` // 快递电子面子key
	//[ 7] express_offer                                  decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	ExpressOffer null.Float `gorm:"column:express_offer;type:decimal;" json:"express_offer"` // 快递报价
	//[ 8] express_cost                                   decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	ExpressCost null.Float `gorm:"column:express_cost;type:decimal;" json:"express_cost"` // 快递成本
	//[ 9] is_default                                     int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	IsDefault int32 `gorm:"column:is_default;type:int;" json:"is_default"` // 0不是默认快递1默认快递
	//[10] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[11] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 修改时间
	//[12] express_outlets                                varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ExpressOutlets null.String `gorm:"column:express_outlets;type:varchar;" json:"express_outlets"` // 快递网点
	//[13] temp_id                                        uint                 null: true   primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	TempID null.Int `gorm:"column:temp_id;type:uint;" json:"temp_id"` // 默认模板id

}

// TableName sets the insert table name for this struct type
func (s *ShopExpress) TableName() string {
	return "shop_express"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopExpress) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopExpress) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopExpress) Validate(action Action) error {
	return nil
}
