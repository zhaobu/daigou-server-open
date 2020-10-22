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

 Date: 07/08/2020 19:40:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_ann
-- ----------------------------
DROP TABLE IF EXISTS `system_ann`;
CREATE TABLE `system_ann`  (
  `id` int(11) NOT NULL,
  `system_ann_version` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '版本号',
  `system_ann_target` int(10) UNSIGNED NOT NULL COMMENT '0所有 1普通用户2代购',
  `system_ann_type` int(10) UNSIGNED NOT NULL COMMENT '0拉取信息 1滚动展示 2弹框展示',
  `system_ann_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '内容',
  `system_ann_status` int(255) UNSIGNED NOT NULL COMMENT '状态 0禁用 1开启',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统公告' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
