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

 Date: 18/06/2020 11:00:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员充值流水' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
