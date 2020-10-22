/*
 Navicat Premium Data Transfer

 Source Server         : webapp正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : gz-cdb-ayisxc69.sql.tencentcdb.com:60002
 Source Schema         : daigou

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 07/07/2020 16:30:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `class_id` int(10) UNSIGNED NOT NULL COMMENT '字典编号',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典说明',
  `class_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统参数' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 1, 'mainpage_max_url', '6');
INSERT INTO `system_config` VALUES (2, 2, 'mainpage_max_spec', '10');
INSERT INTO `system_config` VALUES (3, 3, 'mainpage_max_category', '7');
INSERT INTO `system_config` VALUES (5, 4, 'mainpage_scroll_image', '[\"https://s1.ax1x.com/2020/07/06/UiQPxJ.jpg\",\"https://s1.ax1x.com/2020/07/06/UiQMxH.jpg\",\"https://s1.ax1x.com/2020/07/06/UiQ0Mj.jpg\"]');

SET FOREIGN_KEY_CHECKS = 1;
