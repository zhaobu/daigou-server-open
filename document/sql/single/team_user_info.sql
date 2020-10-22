/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : daigou

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 10/06/2020 23:16:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for team_user_info
-- ----------------------------
DROP TABLE IF EXISTS `team_user_info`;
CREATE TABLE `team_user_info`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `shopid` int(0) NOT NULL,
  `teamuserid` int(0) NOT NULL,
  `status` int(0) NOT NULL COMMENT '0表示申请1表示同意2表示拒绝3表示删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shopid`(`shopid`) USING BTREE,
  UNIQUE INDEX `teamuserid`(`teamuserid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of team_user_info
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
