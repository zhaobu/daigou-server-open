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

 Date: 18/08/2020 09:22:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_category
-- ----------------------------
DROP TABLE IF EXISTS `shop_category`;
CREATE TABLE `shop_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '商品分类id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺ID',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  `category_sort` int(10) UNSIGNED NOT NULL COMMENT '排序字段',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
