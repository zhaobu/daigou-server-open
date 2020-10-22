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

// VipRechargeRecords struct is a row record of the vip_recharge_records table in the daigou database
type VipRechargeRecords struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] recharge_id                                    varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	RechargeID string `gorm:"column:recharge_id;type:varchar;" json:"recharge_id"` // 充值流水编号
	//[ 2] trand_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	TrandID string `gorm:"column:trand_id;type:varchar;" json:"trand_id"` // 商户流水编号
	//[ 3] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 4] member_price                                   udecimal             null: false  primary: false  isArray: false  auto: false  col: udecimal        len: -1      default: []
	MemberPrice float64 `gorm:"column:member_price;type:udecimal;" json:"member_price"` // 充值金额
	//[ 5] fee_type                                       uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	FeeType uint32 `gorm:"column:fee_type;type:uint;" json:"fee_type"` // 充值类型（1：一个月 2：一个季度 3：一年 4：自定义月数）
	//[ 6] status                                         int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Status int32 `gorm:"column:status;type:int;" json:"status"` // 订单状态0发起1成功-1异常
	//[ 7] remark                                         varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Remark string `gorm:"column:remark;type:varchar;" json:"remark"` // 订单描述
	//[ 8] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"`
	//[ 9] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"`
}

// TableName sets the insert table name for this struct type
func (v *VipRechargeRecords) TableName() string {
	return "vip_recharge_records"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (v *VipRechargeRecords) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (v *VipRechargeRecords) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (v *VipRechargeRecords) Validate(action Action) error {
	return nil
}
