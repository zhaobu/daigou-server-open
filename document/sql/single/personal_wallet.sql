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

 Date: 18/06/2020 11:00:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '个人钱包' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
