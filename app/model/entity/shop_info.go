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

// ShopInfo struct is a row record of the shop_info table in the daigou database
type ShopInfo struct {
	//[ 0] id                                             uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	ID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:id;type:uint;" json:"id"` // 主键
	//[ 1] shop_id                                        ubigint              null: false  primary: false  isArray: false  auto: false  col: ubigint         len: -1      default: []
	ShopID uint64 `gorm:"column:shop_id;type:ubigint;" json:"shop_id"` // 店铺ID
	//[ 2] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 创建时间
	//[ 3] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 更新时间
	//[ 4] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间
	//[ 5] user_id                                        uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	UserID uint32 `gorm:"column:user_id;type:uint;" json:"user_id"` // 用户id
	//[ 6] shop_name                                      varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ShopName string `gorm:"column:shop_name;type:varchar;" json:"shop_name"` // 店铺名称
	//[ 7] shop_url                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ShopURL string `gorm:"column:shop_url;type:varchar;" json:"shop_url"` // 店铺头像
	//[ 8] shop_description                               varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	ShopDescription null.String `gorm:"column:shop_description;type:varchar;" json:"shop_description"` // 店铺说明
	//[ 9] qr_code_url                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	QrCodeURL null.String `gorm:"column:qr_code_url;type:varchar;" json:"qr_code_url"` // 收款二维码
	//[10] shop_fans_count                                int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [0]
	ShopFansCount int32 `gorm:"column:shop_fans_count;type:int;default:0;" json:"shop_fans_count"` // 店铺粉丝数
	//[11] wechat_number                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	WechatNumber null.String `gorm:"column:wechat_number;type:varchar;" json:"wechat_number"` // 微信号
	//[12] is_recommend                                   uint                 null: false  primary: false  isArray: false  auto: false  col: uint            len: -1      default: []
	IsRecommend uint32 `gorm:"column:is_recommend;type:uint;" json:"is_recommend"` // 0:不推荐 1:推荐店铺
	//[13] is_enable                                      int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: [1]
	IsEnable int32 `gorm:"column:is_enable;type:int;default:1;" json:"is_enable"` // 商铺状态0不启用1启用
	//[14] category_info                                  json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	CategoryInfo null.String `gorm:"column:category_info;type:json;" json:"category_info"` // 用户分类信息
	//[15] mainpage_scroll_info                           json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	MainpageScrollInfo null.String `gorm:"column:mainpage_scroll_info;type:json;" json:"mainpage_scroll_info"` // 用户首页滚动信息
	//[16] shop_watermark                                 json                 null: true   primary: false  isArray: false  auto: false  col: json            len: -1      default: []
	ShopWatermark null.String `gorm:"column:shop_watermark;type:json;" json:"shop_watermark"` // 图片水印配置

}

// TableName sets the insert table name for this struct type
func (s *ShopInfo) TableName() string {
	return "shop_info"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (s *ShopInfo) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (s *ShopInfo) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (s *ShopInfo) Validate(action Action) error {
	return nil
}
