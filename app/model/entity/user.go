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

// User struct is a row record of the user table in the daigou database
type User struct {
	//[ 0] user_id                                        uint                 null: false  primary: true   isArray: false  auto: true   col: uint            len: -1      default: []
	UserID uint32 `gorm:"primary_key;AUTO_INCREMENT;column:user_id;type:uint;" json:"user_id"` // 自增长用户id
	//[ 1] role                                           int                  null: false  primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	Role int32 `gorm:"column:role;type:int;" json:"role"` // 在此平台角色1用户2个体商户3推广员4代购5总代
	//[ 2] union_id                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	UnionID string `gorm:"column:union_id;type:varchar;" json:"union_id"` // 微信唯一索引
	//[ 3] open_id                                        varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	OpenID string `gorm:"column:open_id;type:varchar;" json:"open_id"` // 微信openid
	//[ 4] gzh_open_id                                    varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	GzhOpenID null.String `gorm:"column:gzh_open_id;type:varchar;" json:"gzh_open_id"` // 公众号openid
	//[ 5] nick_name                                      varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	NickName string `gorm:"column:nick_name;type:varchar;" json:"nick_name"` // 微信名字
	//[ 6] avatar_url                                     varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	AvatarURL string `gorm:"column:avatar_url;type:varchar;" json:"avatar_url"` // 微信头像
	//[ 7] small_wx_code                                  varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	SmallWxCode null.String `gorm:"column:small_wx_code;type:varchar;" json:"small_wx_code"` // 小程序码
	//[ 8] gender                                         tinyint              null: false  primary: false  isArray: false  auto: false  col: tinyint         len: -1      default: []
	Gender int32 `gorm:"column:gender;type:tinyint;" json:"gender"` // 0未知1男生2女生
	//[ 9] country                                        varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Country string `gorm:"column:country;type:varchar;" json:"country"` // 所在国家
	//[10] province                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Province string `gorm:"column:province;type:varchar;" json:"province"` // 身份
	//[11] city                                           varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	City string `gorm:"column:city;type:varchar;" json:"city"` // 城市
	//[12] language                                       varchar              null: false  primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	Language string `gorm:"column:language;type:varchar;" json:"language"` // 语种
	//[13] bind_shop_id                                   int                  null: true   primary: false  isArray: false  auto: false  col: int             len: -1      default: []
	BindShopID null.Int `gorm:"column:bind_shop_id;type:int;" json:"bind_shop_id"` // 绑定的商店id
	//[14] phone_number                                   varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: []
	PhoneNumber null.String `gorm:"column:phone_number;type:varchar;" json:"phone_number"` // 手机号码
	//[15] country_code                                   varchar              null: true   primary: false  isArray: false  auto: false  col: varchar         len: 0       default: [86]
	CountryCode null.String `gorm:"column:country_code;type:varchar;default:86;" json:"country_code"` // 手机区号
	//[16] created_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	CreatedAt *Time `gorm:"column:created_at;type:datetime;" json:"created_at"` // 注册时间
	//[17] updated_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	UpdatedAt *Time `gorm:"column:updated_at;type:datetime;" json:"updated_at"` // 修改时间
	//[18] deleted_at                                     datetime             null: true   primary: false  isArray: false  auto: false  col: datetime        len: -1      default: []
	DeletedAt *Time `gorm:"column:deleted_at;type:datetime;" json:"deleted_at"` // 删除时间

}

// TableName sets the insert table name for this struct type
func (u *User) TableName() string {
	return "user"
}

// BeforeSave invoked before saving, return an error if field is not populated.
func (u *User) BeforeSave() error {
	return nil
}

// Prepare invoked before saving, can be used to populate fields etc.
func (u *User) Prepare() {
}

// Validate invoked before performing action, return an error if field is not populated.
func (u *User) Validate(action Action) error {
	return nil
}
