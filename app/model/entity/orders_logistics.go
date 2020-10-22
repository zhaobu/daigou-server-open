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

// OrdersLogistics struct is a row record of the orders_logistics table in the daigou database
type OrdersLogistics struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] order_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OrderID string `gorm:"column:order_id;type:varchar;" json:"order_id"` // 订单编号
	//[ 2] is_default                                     int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	IsDefault int32 `gorm:"column:is_default;type:int;default:0;" json:"is_default"` // 默认物流 1表示默认，0表示其他
	//[ 3] status                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	Status int32 `gorm:"column:status;type:int;default:0;" json:"status"` // 0发送中1收货中2完成-1异常
	//[ 4] cost                                           decimal              null: true   primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Cost null.Float `gorm:"column:cost;type:decimal;" json:"cost"` // 运费成本
	//[ 5] offer                                          decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Offer float64 `gorm:"column:offer;type:decimal;" json:"offer"` // 运费报价
	//[ 6] uf_pay_status                                  uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: [0]
	UfPayStatus uint32 `gorm:"column:uf_pay_status;type:uint;default:0;" json:"uf_pay_status"` // 邮费付款状态 （0未付 1已付）
	//[ 7] receiver_name                                  varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverName string `gorm:"column:receiver_name;type:varchar;" json:"receiver_name"` // 收货人
	//[ 8] receiver_iphone                                varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverIphone string `gorm:"column:receiver_iphone;type:varchar;" json:"receiver_iphone"` // 收货联系方式
	//[ 9] receiver_province                              varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverProvince null.String `gorm:"column:receiver_province;type:varchar;" json:"receiver_province"` // 省
	//[10] receiver_city                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverCity null.String `gorm:"column:receiver_city;type:varchar;" json:"receiver_city"` // 市
	//[11] receiver_district                              varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverDistrict null.String `gorm:"column:receiver_district;type:varchar;" json:"receiver_district"` // 区/县
	//[12] receiver_address                               varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ReceiverAddress null.String `gorm:"column:receiver_address;type:varchar;" json:"receiver_address"` // 详细地址
	//[13] sender_name                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderName null.String `gorm:"column:sender_name;type:varchar;" json:"sender_name"` // 寄货人
	//[14] sender_iphone                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderIphone null.String `gorm:"column:sender_iphone;type:varchar;" json:"sender_iphone"` // 寄货联系方式
	//[15] sender_province                                varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderProvince null.String `gorm:"column:sender_province;type:varchar;" json:"sender_province"` // 寄货省
	//[16] sender_city                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderCity null.String `gorm:"column:sender_city;type:varchar;" json:"sender_city"` // 寄货市
	//[17] sender_district                                varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderDistrict null.String `gorm:"column:sender_district;type:varchar;" json:"sender_district"` // 寄货区/县
	//[18] sender_address                                 varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SenderAddress null.String `gorm:"column:sender_address;type:varchar;" json:"sender_address"` // 寄货详细地址
	//[19] logistics_company                              varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	LogisticsCompany null.String `gorm:"column:logistics_company;type:varchar;" json:"logistics_company"` // 物流公司
	//[20] logistics_com                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	LogisticsCom null.String `gorm:"column:logistics_com;type:varchar;" json:"logistics_com"` // 物流公司编码（如：顺丰编码(SF)）
	//[21] logistics_number                               varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	LogisticsNumber null.String `gorm:"column:logistics_number;type:varchar;" json:"logistics_number"` // 物流编号
	//[22] third_party_id                                 int                  null: true   primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	ThirdPartyID null.Int `gorm:"column:third_party_id;type:int;" json:"third_party_id"` // 物流第三方平台编号
	//[23] logistics_records                              text                 null: true   primary: false  isArray: false  auto: false  col: text            len: 0       default: []
	LogisticsRecords null.String `gorm:"column:logistics_records;type:text;" json:"logistics_records"` // 快递物流记录
	//[24] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[25] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[26] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (o *OrdersLogistics) TableName() string {
	return "orders_logistics"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (o *OrdersLogistics) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (o *OrdersLogistics) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (o *OrdersLogistics) Validate(action Action) error {
	return nil
}
