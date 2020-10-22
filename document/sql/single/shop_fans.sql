/*
 Navicat Premium Data Transfer

 Source Server         : 开发测试库
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 127.0.0.1:3306
 Source Schema         : daigou_dev

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 21/07/2020 16:12:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_fans
-- ----------------------------
DROP TABLE IF EXISTS `shop_fans`;
CREATE TABLE `shop_fans`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺id',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '粉丝id',
  `category` int(11) NOT NULL COMMENT '用于排序：1置顶：为绑定用户 0：为关注用户',
  `transaction_number` int(11) NOT NULL DEFAULT 0 COMMENT '订单数量',
  `transaction_amount` decimal(10, 0) NOT NULL COMMENT '订单总金额',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '最后购买时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shop_id_2`(`shop_id`, `user_id`) USING BTREE COMMENT '粉丝绑定唯一约束',
  INDEX `shop_id`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代购粉丝表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
