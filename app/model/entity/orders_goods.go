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

// OrdersGoods struct is a row record of the orders_goods table in the daigou database
type OrdersGoods struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 2] hp_id                                          ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HpID uint64 `gorm:"column:hp_id;type:ubigint;" json:"hp_id"` // 预购清单表id
	//[ 3] hgs_id                                         ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HgsID uint64 `gorm:"column:hgs_id;type:ubigint;" json:"hgs_id"` // 商品库id
	//[ 4] logistics_id                                   uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	LogisticsID uint32 `gorm:"column:logistics_id;type:uint;" json:"logistics_id"` // 订单物流id
	//[ 5] quantity                                       int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Quantity int32 `gorm:"column:quantity;type:int;" json:"quantity"` // 数量
	//[ 6] currency_type                                  int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	CurrencyType int32 `gorm:"column:currency_type;type:int;default:0;" json:"currency_type"` // 进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）
	//[ 7] input_price                                    decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	InputPrice null.Float `gorm:"column:input_price;type:decimal;" json:"input_price"` // 进价
	//[ 8] single_price                                   decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	SinglePrice float64 `gorm:"column:single_price;type:decimal;" json:"single_price"` // 销售单价
	//[ 9] total_input_price                              decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	TotalInputPrice null.Float `gorm:"column:total_input_price;type:decimal;" json:"total_input_price"` // 进价总价
	//[10] total_price                                    decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	TotalPrice float64 `gorm:"column:total_price;type:decimal;" json:"total_price"` // 销售总价（单价*数量）
	//[11] specifications                                 varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Specifications null.String `gorm:"column:specifications;type:varchar;" json:"specifications"` // 商品规格（比如大小和颜色等）
	//[12] goods_name                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	GoodsName null.String `gorm:"column:goods_name;type:varchar;" json:"goods_name"` // 商品名称
	//[13] image                                          varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Image null.String `gorm:"column:image;type:varchar;" json:"image"` // 图片地址
	//[14] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[15] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[16] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[17] paidmoney                                      decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Paidmoney null.Float `gorm:"column:paidmoney;type:decimal;" json:"paidmoney"` // 定金
	//[18] pay_status                                     uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	PayStatus uint32 `gorm:"column:pay_status;type:uint;" json:"pay_status"` // 付款状态 (0 未付 1已付 ）
	//[19] order_goods_status                             uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	OrderGoodsStatus uint32 `gorm:"column:order_goods_status;type:uint;" json:"order_goods_status"` // 商品订单状态 0未买到 1已买到 2已发货 3已完成
	//[20] status                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	Status int32 `gorm:"column:status;type:int;default:0;" json:"status"` // 状态（-1 删除 0正常）
	//[21] buy_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	BuyTime *Time `gorm:"column:buy_time;type:datetime;" json:"buy_time"` // 商家买到时间
	//[22] pay_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	PayTime *Time `gorm:"column:pay_time;type:datetime;" json:"pay_time"` // 支付时间
	//[23] ship_time                                      datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	ShipTime *Time `gorm:"column:ship_time;type:datetime;" json:"ship_time"` // 发货时间
	//[24] complete_time                                  datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CompleteTime *Time `gorm:"column:complete_time;type:datetime;" json:"complete_time"` // 完成时间
	//[25] remark                                         varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Remark null.String `gorm:"column:remark;type:varchar;" json:"remark"` // 备注

}

// TableName sets the insert table name for this struct type
func (o *OrdersGoods) TableName() string {
	return "orders_goods"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (o *OrdersGoods) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (o *OrdersGoods) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (o *OrdersGoods) Validate(action Action) error {
	return nil
}
