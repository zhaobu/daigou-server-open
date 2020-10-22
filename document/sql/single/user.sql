/*
 Navicat Premium Data Transfer

 Source Server         : 正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : gz-cdb-ayisxc69.sql.tencentcdb.com:60002
 Source Schema         : daigou_online

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 05/08/2020 16:49:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长用户id',
  `role` int(11) NOT NULL COMMENT '在此平台角色1用户2个体商户3推广员4代购5总代',
  `union_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '微信唯一索引',
  `open_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '微信openid',
  `gzh_open_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '公众号openid',
  `nick_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '微信名字',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '微信头像',
  `small_wx_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '小程序码',
  `gender` tinyint(4) NOT NULL COMMENT '0未知1男生2女生',
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '所在国家',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '身份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '城市',
  `language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '语种',
  `bind_shop_id` int(11) NULL DEFAULT NULL COMMENT '绑定的商店id',
  `phone_number` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '手机号码',
  `country_code` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '86' COMMENT '手机区号',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `open_id`(`open_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000036 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
