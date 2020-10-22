/*
 Navicat Premium Data Transfer

 Source Server         : 正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 127.0.0.1:3306
 Source Schema         : daigou_online

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 17/08/2020 18:23:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_info
-- ----------------------------
DROP TABLE IF EXISTS `shop_info`;
CREATE TABLE `shop_info`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺ID',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '店铺名称',
  `shop_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '店铺头像',
  `shop_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '店铺说明',
  `qr_code_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '收款二维码',
  `shop_fans_count` int(11) NOT NULL DEFAULT 0 COMMENT '店铺粉丝数',
  `wechat_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信号',
  `is_recommend` int(10) UNSIGNED NOT NULL COMMENT '0:不推荐 1:推荐店铺',
  `is_enable` int(11) NOT NULL DEFAULT 1 COMMENT '商铺状态0不启用1启用',
  `category_info` json NULL COMMENT '用户分类信息',
  `mainpage_scroll_info` json NULL COMMENT '用户首页滚动信息',
  `shop_watermark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片水印配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shop_id`(`shop_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商铺' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
