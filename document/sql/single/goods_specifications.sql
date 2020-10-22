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

 Date: 10/06/2020 23:16:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods_specifications
-- ----------------------------
DROP TABLE IF EXISTS `goods_specifications`;
CREATE TABLE `goods_specifications`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `goods_id` int(0) NULL DEFAULT NULL COMMENT '商品id',
  `stock_num` int(0) NOT NULL COMMENT '库存数量',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '规格名称',
  `input_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '入库价格',
  `shop_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '销售价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_specifications
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
