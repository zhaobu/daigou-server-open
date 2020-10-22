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

 Date: 18/06/2020 11:00:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
