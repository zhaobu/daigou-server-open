/*
 Navicat Premium Data Transfer

 Source Server         : 外网
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 119.23.138.52:3306
 Source Schema         : daigou

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 18/06/2020 10:59:55
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访问流水表' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
