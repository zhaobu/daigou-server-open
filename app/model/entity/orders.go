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

// Orders struct is a row record of the orders table in the daigou database
type Orders struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 2] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 买家用户编号
	//[ 3] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 卖家用户编号(或称店铺编号)
	//[ 4] customer_id                                    uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	CustomerID uint32 `gorm:"column:customer_id;type:uint;" json:"customer_id"` // 客户id
	//[ 5] customer_name                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	CustomerName null.String `gorm:"column:customer_name;type:varchar;" json:"customer_name"` // 客户名称
	//[ 6] order_status                                   int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	OrderStatus int32 `gorm:"column:order_status;type:int;" json:"order_status"` // 订单状态0待确认1待发货2已发货3已完成
	//[ 7] preferential_price                             decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	PreferentialPrice null.Float `gorm:"column:preferential_price;type:decimal;" json:"preferential_price"` // 优惠金额
	//[ 8] price                                          decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Price float64 `gorm:"column:price;type:decimal;" json:"price"` // 总金额
	//[ 9] profit                                         decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Profit float64 `gorm:"column:profit;type:decimal;" json:"profit"` // 订单利润
	//[10] goods_name_arr                                 json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	GoodsNameArr null.String `gorm:"column:goods_name_arr;type:json;" json:"goods_name_arr"` // 订单商品列表
	//[11] remark                                         varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Remark null.String `gorm:"column:remark;type:varchar;" json:"remark"` // 买家备注
	//[12] ispay                                          int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Ispay int32 `gorm:"column:ispay;type:int;" json:"ispay"` // 是否已支付
	//[13] isdeliver                                      uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: [0]
	Isdeliver uint32 `gorm:"column:isdeliver;type:uint;default:0;" json:"isdeliver"` // 是否已全部发货 0不是 1是
	//[14] pay_price                                      decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	PayPrice float64 `gorm:"column:pay_price;type:decimal;" json:"pay_price"` // 收取金额
	//[15] status                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [1]
	Status int32 `gorm:"column:status;type:int;default:1;" json:"status"` // 此订单状态1正常0禁用-1删除
	//[16] pay_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	PayTime *Time `gorm:"column:pay_time;type:datetime;" json:"pay_time"` // 支付时间
	//[17] ship_time                                      datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	ShipTime *Time `gorm:"column:ship_time;type:datetime;" json:"ship_time"` // 发货时间
	//[18] complete_time                                  datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CompleteTime *Time `gorm:"column:complete_time;type:datetime;" json:"complete_time"` // 完成时间
	//[19] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[20] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[21] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[22] confirm_time                                   datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	ConfirmTime *Time `gorm:"column:confirm_time;type:datetime;" json:"confirm_time"` // 确认时间

}

// TableName sets the insert table name for this struct type
func (o *Orders) TableName() string {
	return "orders"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (o *Orders) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (o *Orders) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (o *Orders) Validate(action Action) error {
	return nil
}
