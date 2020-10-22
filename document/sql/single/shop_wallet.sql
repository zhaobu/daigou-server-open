/*
 Navicat Premium Data Transfer

 Source Server         : 开发测试库
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 127.0.0.1:3306
 Source Schema         : daigou_test

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 03/08/2020 16:51:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_wallet
-- ----------------------------
DROP TABLE IF EXISTS `shop_wallet`;
CREATE TABLE `shop_wallet`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `month_orders` int(10) UNSIGNED NOT NULL COMMENT '月订单个数',
  `month_profit` decimal(10, 0) NOT NULL COMMENT '月收益',
  `month_cost` decimal(10, 0) NOT NULL COMMENT '月成本',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员财富表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
