/*
 Navicat Premium Data Transfer

 Source Server         : weapp_test
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 119.23.138.52:3306
 Source Schema         : daigou_bak

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 22/06/2020 12:22:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for express_company
-- ----------------------------
DROP TABLE IF EXISTS `express_company`;
CREATE TABLE `express_company`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `express_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递公司名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
