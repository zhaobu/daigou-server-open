/*
 Navicat Premium Data Transfer

 Source Server         : 正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : gz-cdb-ayisxc69.sql.tencentcdb.com:60002
 Source Schema         : daigou_test

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 18/07/2020 16:03:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop_express
-- ----------------------------
DROP TABLE IF EXISTS `shop_express`;
CREATE TABLE `shop_express`  (
  `express_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '快递标识',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `express_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递编码',
  `express_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递名称',
  `express_company_id` int(11) UNSIGNED NOT NULL COMMENT '快递公司id',
  `partner_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递电子面单账号',
  `partner_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递电子面子key',
  `express_offer` decimal(10, 2) NULL DEFAULT NULL COMMENT '快递报价',
  `express_cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '快递成本',
  `is_default` int(11) NOT NULL COMMENT '0不是默认快递1默认快递',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `express_outlets` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递网点',
  `temp_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '默认模板id',
  PRIMARY KEY (`express_id`) USING BTREE,
  UNIQUE INDEX `express_name`(`shop_id`, `express_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

alter table `shop_express` AUTO_INCREMENT=1
