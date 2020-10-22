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

 Date: 18/06/2020 11:00:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `address_id` int(0) NOT NULL COMMENT '地址编号',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `phone_number` bigint(0) NOT NULL COMMENT '手机号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `gender` int(0) NOT NULL DEFAULT 0 COMMENT '性别,0男生1女生',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '区',
  `detailed_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '详细地址',
  `is_default` int(0) NOT NULL DEFAULT 0 COMMENT '0:不是默认地址 1:是',
  `classification` int(0) NOT NULL COMMENT '0:代购自己地址 1;名下成员员地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '地址管理' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
