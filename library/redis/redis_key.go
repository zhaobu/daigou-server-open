package redis

//redis键
const (
	Cache_Hash_Get_ExchangeRate = "Cache_Hash_Get_ExchangeRate" //获取汇率
	Cache_Str_Get_Currencies    = "Cache_Str_Get_Currencies"    //获取汇率货币列表
	Cache_Str_WxAccess_token    = "Cache_Str_WxAccess_token"    //微信小程序接口调用凭证
	Cache_Str_WxGzhAccess_token = "Cache_Str_WxGzhAccess_token" //微信公众号接口调用凭证
	Cache_Str_System_Config     = "Cache_Str_System_Config"     //系统配置表
	Cache_Str_Goods_Category    = "Cache_Str_Goods_Category"    //分类信息表
	Cache_Hash_Sms_Code         = "Cache_Hash_Sms_Code"         //短信验证码
	Cache_Set_Shop_Code         = "Cache_Set_Shop_Code"         //店铺码信息set
	Cache_Str_Shop_Code         = "Cache_Str_Shop_Code:%s"      //店铺码信息
	Cache_Str_WxTemp_Media      = "Cache_Str_WxTemp_Media"      //上传微信素材库媒体文件信息
	Cache_Hash_Session          = "Cache_Hash_Session"          //user_id到session_id的映射
)
