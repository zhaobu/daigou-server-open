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

 Date: 06/08/2020 19:13:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_vip_explain
-- ----------------------------
DROP TABLE IF EXISTS `shop_vip_explain`;
CREATE TABLE `shop_vip_explain`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `limit_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '限制名称',
  `limit_explain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '限制说明',
  `vip_explain` int(11) NOT NULL COMMENT 'vip限制（）',
  `ordinary_explain` int(11) NOT NULL COMMENT '普通用户限制（）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
