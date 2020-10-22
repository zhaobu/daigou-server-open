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

// Goods struct is a row record of the goods table in the daigou database
type Goods struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] goods_id                                       ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	GoodsID uint64 `gorm:"column:goods_id;type:ubigint;" json:"goods_id"` // 商品id
	//[ 2] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 商品所属商铺id
	//[ 3] hgs_id                                         ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	HgsID uint64 `gorm:"column:hgs_id;type:ubigint;" json:"hgs_id"` // 仓库商品id
	//[ 4] goods_name                                     varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	GoodsName string `gorm:"column:goods_name;type:varchar;" json:"goods_name"` // 商品名字
	//[ 5] goods_comment                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	GoodsComment null.String `gorm:"column:goods_comment;type:varchar;" json:"goods_comment"` // 商品说明
	//[ 6] goods_source                                   varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	GoodsSource null.String `gorm:"column:goods_source;type:varchar;" json:"goods_source"` // 商品来源
	//[ 7] goods_img_url                                  json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	GoodsImgURL null.String `gorm:"column:goods_img_url;type:json;" json:"goods_img_url"` // 商品图片（oss链接，一次性加载多张图片）
	//[ 8] goods_status                                   int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	GoodsStatus int32 `gorm:"column:goods_status;type:int;" json:"goods_status"` // 商品状态0下架1上架2售空3即将过期4已过期5删除
	//[ 9] category_id                                    int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	CategoryID int32 `gorm:"column:category_id;type:int;" json:"category_id"` // 分类编号
	//[10] price                                          decimal              null: false  primary: false  isArray: false  auto: false  col: decimal         len: -1      default: []
	Price float64 `gorm:"column:price;type:decimal;" json:"price"` // 商品价格
	//[11] specifications                                 json                 null: false  primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	Specifications string `gorm:"column:specifications;type:json;" json:"specifications"` // 规格信息（以Json格式保存）
	//[12] over_info                                      text                 null: true   primary: false  isArray: false  auto: false  col: text            len: 0       default: []
	OverInfo null.String `gorm:"column:over_info;type:text;" json:"over_info"` // 过期信息
	//[13] input_time                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	InputTime *Time `gorm:"column:input_time;type:datetime;" json:"input_time"` // 入库时间
	//[14] produced_time                                  datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	ProducedTime *Time `gorm:"column:produced_time;type:datetime;" json:"produced_time"` // 生产日期
	//[15] add_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	AddTime *Time `gorm:"column:add_time;type:datetime;" json:"add_time"` // 上架时间
	//[16] down_time                                      datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DownTime *Time `gorm:"column:down_time;type:datetime;" json:"down_time"` // 下架时间
	//[17] top_time                                       datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	TopTime *Time `gorm:"column:top_time;type:datetime;" json:"top_time"` // 置顶时间
	//[18] es_de_time                                     varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	EsDeTime null.String `gorm:"column:es_de_time;type:varchar;" json:"es_de_time"` // 预计发货时间

}

// TableName sets the insert table name for this struct type
func (g *Goods) TableName() string {
	return "goods"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (g *Goods) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (g *Goods) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (g *Goods) Validate(action Action) error {
	return nil
}
