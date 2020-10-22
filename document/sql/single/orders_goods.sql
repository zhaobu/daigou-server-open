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

 Date: 10/06/2020 23:16:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders_goods
-- ----------------------------
DROP TABLE IF EXISTS `orders_goods`;
CREATE TABLE `orders_goods`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `orders_goods_id` int(0) NOT NULL COMMENT '流水编号',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `quantity` int(0) NULL DEFAULT NULL COMMENT '数量',
  `currency_type` int(0) NULL DEFAULT 0 COMMENT '进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）',
  `input_price` decimal(20, 2) UNSIGNED NULL DEFAULT NULL COMMENT '进价',
  `single_price` decimal(20, 2) UNSIGNED ZEROFILL NOT NULL COMMENT '销售单价',
  `total_input_price` decimal(20, 2) UNSIGNED NULL DEFAULT NULL COMMENT '进价总价',
  `total_price` decimal(20, 2) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '销售总价（单价*数量）',
  `specifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品规格（比如大小和颜色等）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orders_goods_id`(`orders_goods_id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单对应商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_goods
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
