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

 Date: 23/07/2020 12:06:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vip_recharge_records
-- ----------------------------
DROP TABLE IF EXISTS `vip_recharge_records`;
CREATE TABLE `vip_recharge_records`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `recharge_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '充值流水编号',
  `trand_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商户流水编号',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `member_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '充值金额',
  `fee_type` int(10) UNSIGNED NOT NULL COMMENT '充值类型（1：一个月 2：一个季度 3：一年 4：自定义月数）',
  `status` int(11) NOT NULL COMMENT '订单状态0发起1成功-1异常',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单描述',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `trand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员充值流水表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
