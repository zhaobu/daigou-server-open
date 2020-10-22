/*
 Navicat Premium Data Transfer

 Source Server         : weapp_test
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 119.23.138.52:3306
 Source Schema         : daogou_bak

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 19/06/2020 10:09:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access_records
-- ----------------------------
DROP TABLE IF EXISTS `access_records`;
CREATE TABLE `access_records`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户ID',
  `created_at` datetime(0) NOT NULL COMMENT '访问时间',
  `shop_id` int(0) NOT NULL COMMENT '商店ID',
  `goods_id` int(0) NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '访问流水表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of access_records
-- ----------------------------

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `address_id` int(0) UNSIGNED NOT NULL COMMENT '地址编号',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `phone_number` bigint(0) NOT NULL COMMENT '手机号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `gender` int(0) NOT NULL DEFAULT 0 COMMENT '性别,0男生1女生',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '区',
  `detailed_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '详细地址',
  `is_default` int(0) NOT NULL DEFAULT 0 COMMENT '0:不是默认地址 1:是',
  `classification` int(0) NOT NULL COMMENT '0:代购自己地址 1;名下成员员地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '地址管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (7, '2020-06-18 15:22:27', '2020-06-18 15:22:27', NULL, 3713450327, 100003, 13582848248, '凤凤', 0, '广东省', '深圳市', '宝安区', '宝安大道新航路', 1, 0);
INSERT INTO `address` VALUES (10, '2020-06-18 15:25:59', '2020-06-18 15:25:59', NULL, 204658786, 100003, 15335588258, '丰', 0, '广东省', '深圳市', '宝安区', '天河大街一号', 0, 0);
INSERT INTO `address` VALUES (11, '2020-06-18 15:26:33', '2020-06-18 15:26:33', NULL, 3999324227, 100003, 15685258858, '福哈', 0, '广东省', '东莞市', '广东省东莞市', '龙门石窟白马寺', 0, 0);

-- ----------------------------
-- Table structure for express
-- ----------------------------
DROP TABLE IF EXISTS `express`;
CREATE TABLE `express`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `express_id` int(0) UNSIGNED NOT NULL COMMENT '快递标识',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '店铺ID',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `express_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递名称',
  `express_cost` int(0) NOT NULL COMMENT '快递成本',
  `express_offer` int(0) NOT NULL COMMENT '快递报价',
  `is_default` int(0) NOT NULL COMMENT '0:不是默认快递 1：默认快递',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '快递表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of express
-- ----------------------------
INSERT INTO `express` VALUES (4, 1, 100002, '2020-06-18 17:14:39', '2020-06-18 17:14:42', NULL, '顺丰快递', 2, 10, 1);
INSERT INTO `express` VALUES (5, 3556908801, 2, '2020-06-18 17:23:42', '2020-06-18 17:23:42', NULL, '韵达快递', 8, 11, 0);
INSERT INTO `express` VALUES (7, 3094558486, 2, '2020-06-18 18:13:47', '2020-06-18 18:13:47', NULL, '顺丰快递', 100, 100, 1);

-- ----------------------------
-- Table structure for express_company
-- ----------------------------
DROP TABLE IF EXISTS `express_company`;
CREATE TABLE `express_company`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `express_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递公司名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of express_company
-- ----------------------------
INSERT INTO `express_company` VALUES (5, '顺丰快递');
INSERT INTO `express_company` VALUES (6, '韵达快递');

-- ----------------------------
-- Table structure for follow_shop
-- ----------------------------
DROP TABLE IF EXISTS `follow_shop`;
CREATE TABLE `follow_shop`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '加入时间',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '店铺id',
  `shop_fans_count` int(0) NOT NULL COMMENT '店铺粉丝数',
  `shop_status` int(0) NOT NULL COMMENT '0：关注的店铺   1：绑定的店铺 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '关注店铺' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of follow_shop
-- ----------------------------
INSERT INTO `follow_shop` VALUES (5, '2020-06-16 19:44:56', 100003, 2, 1111, 1);
INSERT INTO `follow_shop` VALUES (11, '2020-06-17 09:26:54', 100003, 3, 0, 0);
INSERT INTO `follow_shop` VALUES (17, '2020-06-17 18:54:50', 100003, 4, 0, 0);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `goods_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品id',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '商店id',
  `goods_status` int(0) NOT NULL DEFAULT 0 COMMENT '商品状态0下架1上架2售空3即将过期4已过期5删除',
  `category_id` int(0) NOT NULL DEFAULT 0 COMMENT '分类id',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名字',
  `goods_comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品说明',
  `goods_img_url` json NULL COMMENT '商品图片（oss链接，一次性加载多张图片）',
  `input_time` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `produced_time` datetime(0) NULL DEFAULT NULL COMMENT '生产日期',
  `over_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '过期信息（天数或年数或者过期时间）',
  `add_time` datetime(0) NULL DEFAULT NULL COMMENT '上架时间',
  `down_time` datetime(0) NULL DEFAULT NULL COMMENT '下架时间',
  `goods_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品来源',
  `price` decimal(20, 2) UNSIGNED NOT NULL COMMENT '商品价格（默认规格销售价格）',
  `top_time` datetime(0) NULL DEFAULT NULL COMMENT '置顶时间',
  `es_de_time` datetime(0) NULL DEFAULT NULL COMMENT '预计发货时间estimated_delivery_time',
  `specifications` json NOT NULL COMMENT '规格信息（以Json格式保存）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `goods_id`(`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (25, '2020-06-18 19:05:48', '2020-06-18 20:10:51', NULL, '13gjwqs74w0c3k6glnzkqwg100fa8kko', 1821198978, 1, 2, 'de球香水', '代购100瓶香水,从月球', '[\"http://s.laoyaoba.com/jwImg/news/2020/03/25/15851278347613.png\", \"http://s.laoyaoba.com/jwImg/news/2020/03/25/15851278347613.png\"]', '2020-06-18 20:09:56', '2020-06-17 15:30:10', '二天', NULL, NULL, 'de球', 12220.00, NULL, NULL, '[{\"name\": \"大力丸\", \"sp_id\": 1, \"stock_num\": 119, \"shop_price\": 15.98, \"input_price\": 10.99}, {\"name\": \"小力丸\", \"sp_id\": 2, \"stock_num\": 10, \"shop_price\": 7.98, \"input_price\": 6.99}]');
INSERT INTO `goods` VALUES (26, '2020-06-18 19:12:30', '2020-06-18 19:12:30', NULL, '13gjwqs9i00c3k6lqccq4gc1000n4uvj', 1821198978, 1, 2, 'de球香水', '代购100瓶香水,从月球', '[\"http://s.laoyaoba.com/jwImg/news/2020/03/25/15851278347613.png\", \"http://s.laoyaoba.com/jwImg/news/2020/03/25/15851278347613.png\"]', '2020-06-18 19:12:30', '2020-06-17 15:30:10', '二天', '2020-06-18 19:12:30', NULL, 'de球', 1.00, NULL, NULL, '[{\"name\": \"大力丸\", \"sp_id\": 1, \"stock_num\": 119, \"shop_price\": 15.98, \"input_price\": 10.99}, {\"name\": \"小力丸\", \"sp_id\": 2, \"stock_num\": 10, \"shop_price\": 7.98, \"input_price\": 6.99}]');

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` int(0) NOT NULL COMMENT '分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `category_id`(`category_id`, `category_name`) USING BTREE COMMENT '分类id和分类名称唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES (1, 1, '数码');
INSERT INTO `goods_category` VALUES (2, 2, '护肤');
INSERT INTO `goods_category` VALUES (3, 3, '轻奢');
INSERT INTO `goods_category` VALUES (4, 4, '服装');
INSERT INTO `goods_category` VALUES (5, 5, '美妆');

-- ----------------------------
-- Table structure for goods_specifications
-- ----------------------------
DROP TABLE IF EXISTS `goods_specifications`;
CREATE TABLE `goods_specifications`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `goods_id` int(0) NOT NULL COMMENT '商品id',
  `stock_num` int(0) NOT NULL COMMENT '库存数量',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '规格名称',
  `input_price` decimal(20, 2) NOT NULL COMMENT '入库价格',
  `shop_price` decimal(20, 2) NOT NULL COMMENT '销售价格',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_specifications
-- ----------------------------
INSERT INTO `goods_specifications` VALUES (1, '2020-06-15 16:49:48', '2020-06-15 16:49:51', NULL, 3, 96, '白色', 10.00, 12.00);
INSERT INTO `goods_specifications` VALUES (2, '2020-06-15 16:49:48', '2020-06-15 16:49:51', NULL, 3, 10, '黑色', 12.99, 14.99);
INSERT INTO `goods_specifications` VALUES (3, '2020-06-18 17:34:45', '2020-06-18 17:34:45', NULL, 989930383, 119, '大力丸', 10.99, 15.98);

-- ----------------------------
-- Table structure for open_member_ship
-- ----------------------------
DROP TABLE IF EXISTS `open_member_ship`;
CREATE TABLE `open_member_ship`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `opening_time` datetime(0) NULL DEFAULT NULL COMMENT '开通时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `opening_status` int(0) NULL DEFAULT 0 COMMENT '开通状态  0：未开通 1：以开通',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员时间表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of open_member_ship
-- ----------------------------

-- ----------------------------
-- Table structure for open_member_turnover
-- ----------------------------
DROP TABLE IF EXISTS `open_member_turnover`;
CREATE TABLE `open_member_turnover`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) UNSIGNED NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '充值时间',
  `amount_of_money` int(0) NOT NULL COMMENT '充值金额',
  `recharge_day` int(0) NULL DEFAULT NULL COMMENT '充值天数',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间（从那天开始加会员天数）',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间（那天结束会员时间）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员充值流水' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of open_member_turnover
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '买家用户编号',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '卖家用户编号(或称店铺编号)',
  `order_status` int(0) NOT NULL COMMENT '订单状态0待确认1待发货2已发货3已完成',
  `preferential_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NULL DEFAULT NULL COMMENT '订单利润',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '买家备注',
  `ispay` int(0) NOT NULL COMMENT '是否已支付',
  `pay_price` decimal(20, 2) NOT NULL COMMENT '收取金额',
  `status` int(0) NOT NULL DEFAULT 1 COMMENT '此订单状态1正常0禁用-1删除',
  `pay_time` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `ship_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `complete_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2020-06-11 10:27:21', '2020-06-11 10:27:27', NULL, 'e202006111026100001', 100001, 1000001, 2, 0.00, 20.00, 14.00, '加急', 0, 9.00, 1, '2020-06-18 12:09:32', NULL, NULL);
INSERT INTO `orders` VALUES (2, '2020-06-15 17:03:57', '2020-06-15 17:03:57', NULL, '1592211686100001', 100001, 1000001, 0, NULL, 12.00, -8.00, '加急2', 0, 0.00, 1, '2020-06-15 17:02:53', '2020-06-15 17:02:53', '2020-06-15 17:02:53');
INSERT INTO `orders` VALUES (3, '2020-06-18 19:36:49', '2020-06-18 19:36:49', NULL, '1592480208100001', 100001, 0, 0, NULL, 12.00, -9.98, '加急2', 0, 0.00, 1, '2020-06-18 19:36:49', '2020-06-18 19:36:49', '2020-06-18 19:36:49');
INSERT INTO `orders` VALUES (4, '2020-06-18 19:38:33', '2020-06-18 19:38:33', NULL, '1592480313100001', 100001, 1000001, 0, NULL, 12.00, -9.98, '加急2', 0, 0.00, 1, '2020-06-18 19:38:33', '2020-06-18 19:38:33', '2020-06-18 19:38:33');

-- ----------------------------
-- Table structure for orders_bill_flow
-- ----------------------------
DROP TABLE IF EXISTS `orders_bill_flow`;
CREATE TABLE `orders_bill_flow`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `before` decimal(20, 2) NULL DEFAULT NULL COMMENT '之前金额',
  `last` decimal(20, 2) NULL DEFAULT NULL COMMENT '之后金额',
  `change_value` decimal(20, 2) NULL DEFAULT NULL COMMENT '变化金额',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单账单流水记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_bill_flow
-- ----------------------------
INSERT INTO `orders_bill_flow` VALUES (1, '2020-06-11 10:34:59', '2020-06-11 10:35:01', NULL, 'e202006111026100001', 0.00, 10.00, 10.00, '第一笔收款');
INSERT INTO `orders_bill_flow` VALUES (4, '2020-06-18 12:09:32', '2020-06-18 12:09:32', NULL, 'e202006111026100001', 10.00, 9.00, -1.00, '退款1元');

-- ----------------------------
-- Table structure for orders_goods
-- ----------------------------
DROP TABLE IF EXISTS `orders_goods`;
CREATE TABLE `orders_goods`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `quantity` int(0) NOT NULL COMMENT '数量',
  `currency_type` int(0) NULL DEFAULT 0 COMMENT '进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）',
  `input_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '进价',
  `single_price` decimal(20, 2) NOT NULL COMMENT '销售单价',
  `total_input_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '进价总价',
  `total_price` decimal(20, 2) NOT NULL COMMENT '销售总价（单价*数量）',
  `specifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品规格（比如大小和颜色等）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单对应商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_goods
-- ----------------------------
INSERT INTO `orders_goods` VALUES (8, '2020-06-15 17:12:07', '2020-06-15 17:12:07', NULL, '1592211686100001', 2, 0, 10.00, 6.00, 10.00, 12.00, '白色 XL', '牛怒', 'http://www.xxx.com/1.img');
INSERT INTO `orders_goods` VALUES (9, '2020-06-17 09:23:36', '2020-06-17 09:23:36', NULL, 'e202006111026100001', 2, 0, 3.00, 6.00, 6.00, 12.00, '白色 XL', '牛怒', 'http://www.xxx.com/1.img');
INSERT INTO `orders_goods` VALUES (10, '2020-06-18 19:36:49', '2020-06-18 19:36:49', NULL, '1592480208100001', 2, 0, 10.99, 6.00, 21.98, 12.00, '白色 XL', '大力丸', 'http://www.xxx.com/1.img');
INSERT INTO `orders_goods` VALUES (11, '2020-06-18 19:38:33', '2020-06-18 19:38:33', NULL, '1592480313100001', 2, 0, 10.99, 6.00, 21.98, 12.00, '白色 XL', '大力丸', 'http://www.xxx.com/1.img');

-- ----------------------------
-- Table structure for orders_logistics
-- ----------------------------
DROP TABLE IF EXISTS `orders_logistics`;
CREATE TABLE `orders_logistics`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `status` int(0) NOT NULL COMMENT '0发送中1收货中2完成-1异常',
  `cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费成本',
  `offer` decimal(10, 2) NOT NULL COMMENT '运费报价',
  `receiver_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '收货人',
  `receiver_iphone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '收货联系方式',
  `receiver_province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '市',
  `receiver_district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '区/县',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '详细地址',
  `logistics_company` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流公司',
  `logistics_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流编号',
  `logistics_records` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '快递物流记录',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单物流信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_logistics
-- ----------------------------
INSERT INTO `orders_logistics` VALUES (1, '2020-06-11 10:30:11', '2020-06-11 10:30:13', NULL, 'e202006111026100001', 0, 0.00, 8.00, '李世民', '13247711988', '陕西省', '长安市', '长安县', '大唐皇宫太极殿', '圆通快递', 'W100000000000211', '[{\"context\":\"[广东深圳公司宝安区渔业社区分部]【代收点】您的快件已签收，签收人在【碧湾雅园小区出入口左侧单车棚靠墙（原e栈）(碧湾雅园小区出入口左侧单车棚靠墙（原e栈）)】领取。\",\"ftime\":\"2020-06-03 18:10:58\",\"time\":\"2020-06-03 18:10:58\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【代收点】您的快件已送达 碧湾雅园小区出入口左侧单车棚靠墙（原e栈） 保管，地址：碧湾雅园小区出入口左侧单车棚靠墙（原e栈），请及时领取，如有疑问请电联快递员：叶云龙【19879167110】。\",\"ftime\":\"2020-06-03 15:21:41\",\"time\":\"2020-06-03 15:21:41\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：已签收，如有疑问请电联快递员：叶云龙【19879167110】。\",\"ftime\":\"2020-06-02 17:06:30\",\"time\":\"2020-06-02 17:06:30\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 叶云龙19879167110 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-05-31 22:32:38\",\"time\":\"2020-05-31 22:32:38\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-05-30 02:24:23\",\"time\":\"2020-05-30 02:24:23\"},{\"context\":\"[江苏南通分拨中心]【南通市】已离开 江苏南通分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-05-28 20:43:03\",\"time\":\"2020-05-28 20:43:03\"},{\"context\":\"[江苏南通分拨中心]【南通市】已到达 江苏南通分拨中心\",\"ftime\":\"2020-05-28 20:37:57\",\"time\":\"2020-05-28 20:37:57\"},{\"context\":\"[江苏南通通州区公司]【南通市】已离开 江苏南通通州区公司；发往 深西地区包\",\"ftime\":\"2020-05-28 18:40:26\",\"time\":\"2020-05-28 18:40:26\"},{\"context\":\"[江苏南通通州区公司]【南通市】江苏南通通州区公司 已揽收\",\"ftime\":\"2020-05-28 18:15:31\",\"time\":\"2020-05-28 18:15:31\"}]');
INSERT INTO `orders_logistics` VALUES (2, '2020-06-15 17:12:08', '2020-06-15 17:12:08', NULL, '1592211686100001', 1, 1.00, 0.00, '李世民', '13246711991', '江西', '萍乡', '莲花', '湖上乡 江背村', NULL, NULL, '[{\"context\":\"[广东深圳公司宝安区渔业社区分部]【代收点】您的快件已签收，签收人在【碧湾雅园小区出入口左侧单车棚靠墙（原e栈）(碧湾雅园小区出入口左侧单车棚靠墙（原e栈）)】领取。\",\"ftime\":\"2020-06-03 18:10:58\",\"time\":\"2020-06-03 18:10:58\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【代收点】您的快件已送达 碧湾雅园小区出入口左侧单车棚靠墙（原e栈） 保管，地址：碧湾雅园小区出入口左侧单车棚靠墙（原e栈），请及时领取，如有疑问请电联快递员：叶云龙【19879167110】。\",\"ftime\":\"2020-06-03 15:21:41\",\"time\":\"2020-06-03 15:21:41\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：已签收，如有疑问请电联快递员：叶云龙【19879167110】。\",\"ftime\":\"2020-06-02 17:06:30\",\"time\":\"2020-06-02 17:06:30\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 叶云龙19879167110 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-05-31 22:32:38\",\"time\":\"2020-05-31 22:32:38\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-05-30 02:24:23\",\"time\":\"2020-05-30 02:24:23\"},{\"context\":\"[江苏南通分拨中心]【南通市】已离开 江苏南通分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-05-28 20:43:03\",\"time\":\"2020-05-28 20:43:03\"},{\"context\":\"[江苏南通分拨中心]【南通市】已到达 江苏南通分拨中心\",\"ftime\":\"2020-05-28 20:37:57\",\"time\":\"2020-05-28 20:37:57\"},{\"context\":\"[江苏南通通州区公司]【南通市】已离开 江苏南通通州区公司；发往 深西地区包\",\"ftime\":\"2020-05-28 18:40:26\",\"time\":\"2020-05-28 18:40:26\"},{\"context\":\"[江苏南通通州区公司]【南通市】江苏南通通州区公司 已揽收\",\"ftime\":\"2020-05-28 18:15:31\",\"time\":\"2020-05-28 18:15:31\"}]');
INSERT INTO `orders_logistics` VALUES (3, '2020-06-18 19:36:49', '2020-06-18 19:36:49', NULL, '1592480208100001', 1, 1.00, 0.00, '李世民', '13246711991', '江西', '萍乡', '莲花', '湖上乡 江背村', NULL, NULL, NULL);
INSERT INTO `orders_logistics` VALUES (4, '2020-06-18 19:38:33', '2020-06-18 19:38:33', NULL, '1592480313100001', 1, 1.00, 0.00, '李世民', '13246711991', '江西', '萍乡', '莲花', '湖上乡 江背村', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for personal_wallet
-- ----------------------------
DROP TABLE IF EXISTS `personal_wallet`;
CREATE TABLE `personal_wallet`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) UNSIGNED NOT NULL,
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '当天，就不需要查询统计，否则统计更新此表数据',
  `total_profit` int(0) NULL DEFAULT NULL COMMENT '累计总收益',
  `month_profit` bigint(0) NULL DEFAULT NULL COMMENT '月收益',
  `month_cost` int(0) NULL DEFAULT NULL COMMENT '月成本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '个人钱包' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personal_wallet
-- ----------------------------

-- ----------------------------
-- Table structure for shop_fans
-- ----------------------------
DROP TABLE IF EXISTS `shop_fans`;
CREATE TABLE `shop_fans`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '店铺id',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NOT NULL COMMENT '删除时间',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '粉丝id',
  `category` int(0) NOT NULL COMMENT '0:绑定用户 1:关注用户',
  `transaction_number` int(0) NOT NULL COMMENT '订单数量',
  `transaction_amount` int(0) NOT NULL COMMENT '订单总金额',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '最后购买时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '我的商铺粉丝' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_fans
-- ----------------------------
INSERT INTO `shop_fans` VALUES (1, 2, '2020-06-16 15:18:59', '2020-06-16 15:19:04', '2020-06-16 15:19:06', 100002, 1, 100, 10000, '2020-06-16 15:19:44');
INSERT INTO `shop_fans` VALUES (2, 2, '2020-06-16 15:23:50', '2020-06-16 15:23:53', '2020-06-16 15:23:55', 100004, 0, 10101, 123453453, '2020-06-16 15:24:06');

-- ----------------------------
-- Table structure for shop_info
-- ----------------------------
DROP TABLE IF EXISTS `shop_info`;
CREATE TABLE `shop_info`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '店铺ID',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(0) UNSIGNED NOT NULL,
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '店铺名称',
  `shop_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '店铺头像',
  `shop_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '店铺说明',
  `establish_time` datetime(0) NOT NULL COMMENT '创建时间',
  `qr_code_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '收款二维码',
  `wechat_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信号',
  `is_enable` int(0) NOT NULL DEFAULT 1 COMMENT '商铺状态0不启用1启用',
  `category_info` json NULL COMMENT '用户分类信息',
  `mainpage_scroll_info` json NULL COMMENT '用户首页滚动信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '店铺资料' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_info
-- ----------------------------
INSERT INTO `shop_info` VALUES (6, 1821198978, '2020-06-18 18:57:18', '2020-06-18 18:57:18', NULL, 1821198978, 'lw的shop', 'http://www.86ps.com/UploadFiles/Article/2014-11/201411122332322.jpg', '专业美食代购', '2020-06-18 18:57:18', 'https://tse3-mm.cn.bing.net/th/id/OIP.Resbf9j-MDrJw5trdImrxAHaHa?pid=Api&rs=1', '我的微信号', 1, '[1, 2, 3]', '{\"travel_info\": [{\"url\": [\"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1\", \"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg\", \"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg\"], \"end_time\": \"2020-06-19 18:57:18\", \"start_time\": \"2020-06-18 18:57:18\", \"departure_point\": \"上海\", \"destination_point\": \"北京\"}, {\"url\": [\"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1\", \"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg\", \"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg\"], \"end_time\": \"2020-06-20 18:57:18\", \"start_time\": \"2020-06-18 18:57:18\", \"departure_point\": \"东京\", \"destination_point\": \"莫斯科\"}]}');
INSERT INTO `shop_info` VALUES (7, 657353715, '2020-06-18 18:59:21', '2020-06-18 18:59:21', NULL, 657353715, 'lw的shop', 'http://www.86ps.com/UploadFiles/Article/2014-11/201411122332322.jpg', '专业美食代购', '2020-06-18 18:59:21', 'https://tse3-mm.cn.bing.net/th/id/OIP.Resbf9j-MDrJw5trdImrxAHaHa?pid=Api&rs=1', '我的微信号', 1, '[1, 2, 3]', '{\"travel_info\": [{\"url\": [\"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1\", \"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg\", \"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg\"], \"end_time\": \"2020-06-19 18:59:20\", \"start_time\": \"2020-06-18 18:59:20\", \"departure_point\": \"上海\", \"destination_point\": \"北京\"}, {\"url\": [\"https://tse2-mm.cn.bing.net/th/id/OIP.daU37AomxiLTdW9RRSZKyQHaE8?pid=Api&rs=1\", \"http://pic10.nipic.com/20101015/5023775_092050032919_2.jpg\", \"http://img18.3lian.com/d/file/201710/14/3645d2a383402afe9adfe4d75dc4e934.jpg\"], \"end_time\": \"2020-06-20 18:59:20\", \"start_time\": \"2020-06-18 18:59:20\", \"departure_point\": \"东京\", \"destination_point\": \"莫斯科\"}]}');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `mainpage_max_url` tinyint(0) NOT NULL COMMENT '首页商品图片上传数量上限',
  `mainpage_max_spec` tinyint(0) NOT NULL COMMENT '首页商品规格上限',
  `mainpage_max_category` tinyint(0) NOT NULL COMMENT '商品分类上限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, '2020-06-18 20:19:51', '2020-06-18 20:19:54', 6, 10, 7);

-- ----------------------------
-- Table structure for test_db
-- ----------------------------
DROP TABLE IF EXISTS `test_db`;
CREATE TABLE `test_db`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `type_id` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `passwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  `gender` enum('one','two') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `birthday` datetime(0) NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT NULL,
  `detial` json NULL,
  PRIMARY KEY (`id`, `type_id`) USING BTREE,
  UNIQUE INDEX `uix_test_db_email`(`email`) USING BTREE,
  INDEX `idx_test_db_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_db
-- ----------------------------
INSERT INTO `test_db` VALUES (15, '2020-06-14 02:45:12', '2020-06-14 02:45:12', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (16, '2020-06-14 02:49:06', '2020-06-14 02:49:06', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (17, '2020-06-14 02:49:40', '2020-06-14 02:49:40', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (18, '2020-06-14 02:50:28', '2020-06-14 02:50:28', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (19, '2020-06-14 02:50:44', '2020-06-14 02:50:44', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (20, '2020-06-14 02:51:34', '2020-06-14 02:51:34', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (21, '2020-06-14 02:51:59', '2020-06-14 02:51:59', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (22, '2020-06-14 02:52:43', '2020-06-14 02:52:43', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (23, '2020-06-14 02:55:49', '2020-06-14 02:55:49', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (24, '2020-06-14 02:56:41', '2020-06-14 02:56:41', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (25, '2020-06-14 02:57:39', '2020-06-14 02:57:39', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (26, '2020-06-14 02:58:28', '2020-06-14 02:58:28', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (27, '2020-06-14 02:58:54', '2020-06-14 02:58:54', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (28, '2020-06-15 15:36:40', '2020-06-15 15:36:40', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (29, '2020-06-15 16:31:18', '2020-06-15 16:31:18', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (30, '2020-06-15 16:31:52', '2020-06-15 16:31:52', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (31, '2020-06-15 16:32:04', '2020-06-15 16:32:04', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (32, '2020-06-15 16:32:25', '2020-06-15 16:32:25', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (33, '2020-06-15 16:32:43', '2020-06-15 16:32:43', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (34, '2020-06-15 16:33:10', '2020-06-15 16:33:10', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (35, '2020-06-15 16:34:28', '2020-06-15 16:34:28', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (36, '2020-06-15 16:34:49', '2020-06-15 16:34:49', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `test_db` VALUES (37, '2020-06-15 16:35:01', '2020-06-15 16:35:01', NULL, 12, 'test_name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `role` int(0) NOT NULL DEFAULT 0 COMMENT '在此平台角色0用户1代购2个体商户3推广员4总代',
  `vip_level` int(0) NULL DEFAULT NULL COMMENT 'vip等级',
  `union_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '微信唯一索引',
  `open_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '微信openid',
  `nick_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '微信昵称',
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '微信头像',
  `gender` tinyint(0) NOT NULL COMMENT '性别(0:未知1:男生2女生)',
  `country` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所在国家',
  `province` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '省份',
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '城市',
  `language` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '语种',
  `bind_shop_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '绑定商店id',
  `phone_number` bigint(0) NULL DEFAULT NULL COMMENT '手机号码',
  `due_time` datetime(0) NULL DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid_UNIQUE`(`open_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, '2020-06-11 10:45:40', '2020-06-11 10:45:44', NULL, 100001, 0, 0, '_Ls4uLQ0nOrCW1Cio9vh84gkvU', '_Ls4uLQ0nOrCW1Cio9vh84gkvU', '夕雨林径牛', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIpKeVNicCvL2E7icgbnAZdt2s2FJpaE6r96KBWlgLs80FK9Nvbvb8oqIxNgKxibSDaELiaaBF8yrqYHg/132', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000001, NULL, '2020-06-11 10:45:29');
INSERT INTO `user` VALUES (5, '2020-06-12 15:46:57', '2020-06-12 15:46:57', NULL, 657353715, 0, NULL, '', 'o-_Ls4lWttE7E6YXdTSQasQnG3LU', '緣', 'https://wx.qlogo.cn/mmopen/vi_32/X6N4q8Ime5z5xodeLichJ4sjPic4PSb8UStQSuxicAc3xnzQgDdBB4Fkc1nOuKXiaCncDDDD85tjmBwcJvGFzYphibw/132', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, NULL, NULL);
INSERT INTO `user` VALUES (6, '2020-06-16 15:15:17', '2020-06-16 15:15:25', NULL, 100002, 0, NULL, 'sdfsdfsfsfsfsfs', 'sdfsdf', '小丰', 'http://tmp/wx0eb6f2b892efbc70.o6zAJsxtObx_a5I_DX6si3NaUbiw.5TChRyUM1pxR138c420d6bfa6480b043a5a88e2300f0.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 100003, NULL, '2020-06-16 15:17:18');
INSERT INTO `user` VALUES (7, '2020-06-16 15:17:29', '2020-06-16 15:17:33', NULL, 100003, 0, NULL, 'rfrfrfrfrfr', 'sgvgrefgberg', '哈哈', 'http://tmp/wx0eb6f2b892efbc70.o6zAJsxtObx_a5I_DX6si3NaUbiw.5TChRyUM1pxR138c420d6bfa6480b043a5a88e2300f0.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, NULL, '2020-06-16 15:18:18');
INSERT INTO `user` VALUES (8, '2020-06-16 15:19:59', '2020-06-16 15:20:02', NULL, 100004, 0, NULL, 'fdghfghrhdfghsdrt', 'dfgsdfgsdfgdfg', '嘿嘿', 'http://tmp/wx0eb6f2b892efbc70.o6zAJsxtObx_a5I_DX6si3NaUbiw.5TChRyUM1pxR138c420d6bfa6480b043a5a88e2300f0.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 100003, NULL, '2020-06-16 15:20:43');
INSERT INTO `user` VALUES (10, '2020-06-17 17:45:09', '2020-06-17 17:45:09', NULL, 451698673, 0, NULL, '', 'o-_Ls4jwDv-nl8aLY-pM3cdqqpa0', '空山石', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erWrGjD40JI6SdxmBYO6xIVlqlp1oGibGeK80VA5Vicm9SFeia2My9f4QbpRrXdxibMUKv7PVZM45HJzQ/132', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, NULL, NULL);
INSERT INTO `user` VALUES (11, '2020-06-18 16:10:04', '2020-06-18 16:10:04', NULL, 1716525, 0, NULL, '', 'o-_Ls4joKCoNO1oMu2EJ0au8MJRk', '易葱', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLFrQibt5nJOQONMC68nNKB5q0OEXzAPwsUVDxB8E1iaQk126hFsvQ0GII2zQfWYib4QZnE4icKDSYvUg/132', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
