package public

//该包只给其他package导入使用,不导入其他package,定义公共部分,作用是避免同一个内容在多个package重复定义或者交叉引用package

type ShopCodeType uint32 //商铺码生成类型

const (
	ShopCodeType_System ShopCodeType = iota //系统生成
	ShopCodeType_Shop                       //商店生成
)
