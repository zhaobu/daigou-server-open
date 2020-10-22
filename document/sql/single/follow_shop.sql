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

 Date: 18/06/2020 11:04:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for follow_shop
-- ----------------------------
DROP TABLE IF EXISTS `follow_shop`;
CREATE TABLE `follow_shop`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '加入时间',
  `user_id` int(0) UNSIGNED NOT NULL COMMENT '用户id',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '店铺id',
  `shop_fans_count` int(0) NOT NULL COMMENT '店铺粉丝数',
  `shop_status` int(0) NOT NULL COMMENT '0：关注的店铺   1：绑定的店铺 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '关注店铺' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
