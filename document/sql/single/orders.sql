/*
 Navicat Premium Data Transfer

 Source Server         : 正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : gz-cdb-ayisxc69.sql.tencentcdb.com:60002
 Source Schema         : daigou_dev

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 18/07/2020 16:24:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '买家用户编号',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '卖家用户编号(或称店铺编号)',
  `order_status` int(11) NOT NULL COMMENT '订单状态0待确认1待发货2已发货3已完成',
  `preferential_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NOT NULL COMMENT '订单利润',
  `goods_name_arr` json NULL COMMENT '订单商品列表',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '买家备注',
  `ispay` int(11) NOT NULL COMMENT '是否已支付',
  `pay_price` decimal(20, 2) NOT NULL COMMENT '收取金额',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '此订单状态1正常0禁用-1删除',
  `pay_time` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `ship_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `complete_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `shop_id`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
