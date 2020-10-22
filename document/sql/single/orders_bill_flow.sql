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

 Date: 10/06/2020 23:16:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders_bill_flow
-- ----------------------------
DROP TABLE IF EXISTS `orders_bill_flow`;
CREATE TABLE `orders_bill_flow`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `before` decimal(20, 2) NULL DEFAULT NULL COMMENT '之前金额',
  `last` decimal(20, 2) NULL DEFAULT NULL COMMENT '之后金额',
  `change_value` decimal(20, 2) NULL DEFAULT NULL COMMENT '变化金额',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单账单流水记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_bill_flow
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
