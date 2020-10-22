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

// HGoods struct is a row record of the h_goods table in the daigou database
type HGoods struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商铺id
	//[ 2] hgs_id                                         ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HgsID uint64 `gorm:"column:hgs_id;type:ubigint;" json:"hgs_id"` // 商品库id
	//[ 3] hgs_name                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	HgsName string `gorm:"column:hgs_name;type:varchar;" json:"hgs_name"` // 商品名称 不能重复
	//[ 4] hgs_salenum                                    uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	HgsSalenum uint32 `gorm:"column:hgs_salenum;type:uint;" json:"hgs_salenum"` // 已售数量
	//[ 5] hgs_surplusnum                                 int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HgsSurplusnum int32 `gorm:"column:hgs_surplusnum;type:int;" json:"hgs_surplusnum"` // 剩余库存
	//[ 6] hgs_source                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	HgsSource null.String `gorm:"column:hgs_source;type:varchar;" json:"hgs_source"` // 货源地
	//[ 7] hgs_builddate                                  datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	HgsBuilddate *Time `gorm:"column:hgs_builddate;type:datetime;" json:"hgs_builddate"` // 生产日期
	//[ 8] hgs_expday                                     int                  null: true   primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HgsExpday null.Int `gorm:"column:hgs_expday;type:int;" json:"hgs_expday"` // 保质期（天）
	//[ 9] hgs_explain                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	HgsExplain null.String `gorm:"column:hgs_explain;type:varchar;" json:"hgs_explain"` // 商品介绍
	//[10] hgs_inprice                                    decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	HgsInprice float64 `gorm:"column:hgs_inprice;type:decimal;" json:"hgs_inprice"` // 进价
	//[11] hgs_saleprice                                  decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	HgsSaleprice float64 `gorm:"column:hgs_saleprice;type:decimal;" json:"hgs_saleprice"` // 售价
	//[12] hgs_img                                        varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	HgsImg null.String `gorm:"column:hgs_img;type:varchar;" json:"hgs_img"` // 商品图片
	//[13] hgs_status                                     int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	HgsStatus int32 `gorm:"column:hgs_status;type:int;" json:"hgs_status"` // 商品库状态 （-1 删除 0  在库 1 在售）
	//[14] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[15] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[16] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (h *HGoods) TableName() string {
	return "h_goods"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (h *HGoods) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (h *HGoods) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (h *HGoods) Validate(action Action) error {
	return nil
}
