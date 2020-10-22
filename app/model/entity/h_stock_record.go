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

// HStockRecord struct is a row record of the h_stock_record table in the daigou database
type HStockRecord struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] hgs_id                                         ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HgsID uint64 `gorm:"column:hgs_id;type:ubigint;" json:"hgs_id"` // 仓库商品id
	//[ 2] hsr_type                                       int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HsrType int32 `gorm:"column:hsr_type;type:int;" json:"hsr_type"` // 变化类型（-1 删除 0初始库存 1修改 2进货 3售卖）
	//[ 3] hsr_num                                        int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HsrNum int32 `gorm:"column:hsr_num;type:int;" json:"hsr_num"` // 变化数量
	//[ 4] hsr_price                                      udecimal             null: false  primary: false  isArray: false  auto: false  col: udecimal        len: -1      default: []
	HsrPrice float64 `gorm:"column:hsr_price;type:udecimal;" json:"hsr_price"` // 进价价格  （当为售卖类型时 保存售价）
	//[ 5] hsr_inputtype                                  int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HsrInputtype int32 `gorm:"column:hsr_inputtype;type:int;" json:"hsr_inputtype"` // 进价类型（0取平均值 1 直接更新进价）
	//[ 6] hsr_afternum                                   int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HsrAfternum int32 `gorm:"column:hsr_afternum;type:int;" json:"hsr_afternum"` // 变化后的库存
	//[ 7] hsr_remark                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	HsrRemark null.String `gorm:"column:hsr_remark;type:varchar;" json:"hsr_remark"` // 备注
	//[ 8] created_at                                     datetime             null: false  primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 9] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[10] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HStockRecord) TableName() string {
	return "h_stock_record"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HStockRecord) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HStockRecord) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HStockRecord) Validate(action Action) error {
	return nil
}
