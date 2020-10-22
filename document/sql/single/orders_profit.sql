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

 Date: 28/07/2020 18:04:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders_profit
-- ----------------------------
DROP TABLE IF EXISTS `orders_profit`;
CREATE TABLE `orders_profit`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '买家用户编号',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '卖家用户编号(或称店铺编号)',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NOT NULL COMMENT '订单利润',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
