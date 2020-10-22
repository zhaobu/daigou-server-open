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

 Date: 29/07/2020 18:26:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_vip_price
-- ----------------------------
DROP TABLE IF EXISTS `shop_vip_price`;
CREATE TABLE `shop_vip_price`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称',
  `member_discount_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '商品折扣价格',
  `member_original_price` decimal(10, 2) NOT NULL COMMENT '商品原始价格',
  `member_jian_shao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品简绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
