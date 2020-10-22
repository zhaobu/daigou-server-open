/*
 Navicat Premium Data Transfer

 Source Server         : webapp正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : gz-cdb-ayisxc69.sql.tencentcdb.com:60002
 Source Schema         : daigou_online

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 01/09/2020 18:07:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for casbin_api
-- ----------------------------
DROP TABLE IF EXISTS `casbin_api`;
CREATE TABLE `casbin_api`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '名字',
  `menu_type` enum('主页','订单','我的') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '主页' COMMENT '菜单类型',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '访问路径',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of casbin_api
-- ----------------------------

-- ----------------------------
-- Table structure for casbin_role_api
-- ----------------------------
DROP TABLE IF EXISTS `casbin_role_api`;
CREATE TABLE `casbin_role_api`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '用户' COMMENT '角色名称',
  `api_list` json NOT NULL COMMENT '角色不能能访问的api列表',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE COMMENT '唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色api表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of casbin_role_api
-- ----------------------------

-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule`  (
  `p_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v0` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `v5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------

-- ----------------------------
-- Table structure for casbin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `casbin_user_role`;
CREATE TABLE `casbin_user_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `role_list` json NOT NULL COMMENT '用户拥有的角色列表',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of casbin_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for express_template_config
-- ----------------------------
DROP TABLE IF EXISTS `express_template_config`;
CREATE TABLE `express_template_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `templete_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '模板名称',
  `templete_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '模板数据',
  `express_company_id` int(10) UNSIGNED NOT NULL COMMENT '快递公司ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of express_template_config
-- ----------------------------
INSERT INTO `express_template_config` VALUES (2, '顺丰76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 1);
INSERT INTO `express_template_config` VALUES (3, '申通快递 76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 4);
INSERT INTO `express_template_config` VALUES (4, '圆通速递 76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 5);
INSERT INTO `express_template_config` VALUES (5, '中通快递 76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 3);
INSERT INTO `express_template_config` VALUES (6, '邮政快递包裹 76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 7);
INSERT INTO `express_template_config` VALUES (7, '邮政快递包裹 76*120', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 7);
INSERT INTO `express_template_config` VALUES (8, '顺丰速运 76*120', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 1);
INSERT INTO `express_template_config` VALUES (9, '顺丰速运 50*110', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 1);
INSERT INTO `express_template_config` VALUES (10, '中通快递 50*110', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 3);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `h_goodsid` int(11) NOT NULL COMMENT '商品库id',
  `goods_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品所属商铺id',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名字',
  `goods_comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品说明',
  `goods_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品来源',
  `goods_img_url` json NULL COMMENT '商品图片（oss链接，一次性加载多张图片）',
  `goods_status` int(11) NOT NULL COMMENT '商品状态0下架1上架2售空3即将过期4已过期5删除',
  `category_id` int(11) NOT NULL COMMENT '分类编号',
  `price` decimal(20, 2) NOT NULL COMMENT '商品价格',
  `specifications` json NOT NULL COMMENT '规格信息（以Json格式保存）',
  `over_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '过期信息',
  `input_time` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `produced_time` datetime(0) NULL DEFAULT NULL COMMENT '生产日期',
  `add_time` datetime(0) NULL DEFAULT NULL COMMENT '上架时间',
  `down_time` datetime(0) NULL DEFAULT NULL COMMENT '下架时间',
  `top_time` datetime(0) NULL DEFAULT NULL COMMENT '置顶时间',
  `es_de_time` datetime(0) NULL DEFAULT NULL COMMENT '预计发货时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `goodid`(`goods_id`) USING BTREE,
  INDEX `shopid`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 0, 313162521215238146, 1000004, '敷尔佳水杨酸蛋壳膜', '\n1⃣️ 敷尔佳水杨酸蛋壳膜 团购 两支💰189\n2⃣️娇韵诗粉水 现货💰289\n3⃣️雅诗兰黛智妍 精华霜 75ml💰659\n4⃣️菲洛嘉十全大补 国内专柜 💰229', '国内专柜', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/KAE3WBMZ5b.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/RTcGFKPMpY.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311858/rzDhMcPjEE.png\"]', 5, 2, 189.00, '[{\"name\": \"敷尔佳水杨酸蛋壳膜\", \"sp_id\": 0, \"stock_num\": 168, \"shop_price\": 189, \"input_price\": 50}, {\"name\": \"娇韵诗粉水\", \"sp_id\": 1, \"stock_num\": 200, \"shop_price\": 289, \"input_price\": 20}, {\"name\": \"雅诗兰黛智妍\", \"sp_id\": 2, \"stock_num\": 200, \"shop_price\": 659, \"input_price\": 300}, {\"name\": \"菲洛嘉十全大补\", \"sp_id\": 3, \"stock_num\": 198, \"shop_price\": 229, \"input_price\": 200}]', '', '2020-07-31 18:58:48', NULL, '2020-08-05 10:49:02', '2020-08-05 10:41:06', NULL, NULL);
INSERT INTO `goods` VALUES (2, 0, 313164264502198274, 1000004, '敷尔佳 灯泡膜', '🌸医美   敷尔佳 灯泡膜 团购活动❣️\n🛒💰185/3盒💰350/6盒包邮\n\n熬夜必备 一定多囤\n美白提亮抗氧化巨强💪🏻', '国内专柜', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png\"]', 5, 2, 185.00, '[{\"name\": \"三盒\", \"sp_id\": 0, \"stock_num\": 187, \"shop_price\": 185, \"input_price\": 100}, {\"name\": \"六盒\", \"sp_id\": 1, \"stock_num\": 200, \"shop_price\": 350, \"input_price\": 250}]', '', '2020-07-31 18:09:13', NULL, '2020-07-31 18:09:13', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (3, 0, 313297254087655426, 1000004, '悦薇水乳', '', '韩国', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020841032/Yx8ADpwCRc.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png\"]', 5, 2, 999.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 992, \"shop_price\": 999, \"input_price\": 888}]', '1年', '2020-08-04 10:32:09', '2022-08-01 00:00:00', '2020-08-04 10:32:09', NULL, '2020-08-04 17:52:39', '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (4, 0, 313311614411472897, 1000017, '金丝蜜枣', '核小，肉多，甜度高，肉结实！如果想吃更甜的，那只有蜂蜜了！吃新鲜现摘的枣，甜过初恋', '云南金丝', '[\"https://cwimg.szxjcheng.com/1000017/2020861150/WMdTz74pDy.png\", \"https://cwimg.szxjcheng.com/1000017/2020861150/sdPQQNZFkm.png\", \"https://cwimg.szxjcheng.com/1000017/2020861150/eRXJMpDSKj.png\", \"https://cwimg.szxjcheng.com/1000017/2020861150/4rH4775AsT.png\", \"https://cwimg.szxjcheng.com/1000017/2020861150/rFN6jZAPTe.png\"]', 1, 6, 29.90, '[{\"name\": \"2斤装\", \"sp_id\": 0, \"stock_num\": 2, \"shop_price\": 29.9, \"input_price\": 24}]', '7天', '2020-08-20 22:48:47', '2020-08-07 00:00:00', '2020-08-20 22:48:47', NULL, NULL, '2020-08-07 00:00:00');
INSERT INTO `goods` VALUES (5, 0, 313312545697955841, 1000018, '哈哈', '', 'qq', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000018/2020832025/KXhM3kjNzb.png\"]', 1, 2, 20.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": -1, \"shop_price\": 20, \"input_price\": 12}]', '', '2020-08-03 20:25:25', NULL, '2020-08-03 20:25:25', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (6, 0, 313312981200928769, 1000017, '凯特芒', '一只比脸还大，切半只就能装一盘！芒果，就是要吃现摘的，新鲜，原汁原味', '云南凯特', '[\"https://cwimg.szxjcheng.com/1000017/20208101725/t52mTxCt8x.png\", \"https://cwimg.szxjcheng.com/1000017/20208101725/pmAh38DAc3.png\", \"https://cwimg.szxjcheng.com/1000017/20208101725/XnxWwCMRQt.png\", \"https://cwimg.szxjcheng.com/1000017/20208101725/Kx54NNDdnc.png\", \"https://cwimg.szxjcheng.com/1000017/20208101725/Rjwr7BWEAM.png\"]', 1, 6, 29.90, '[{\"name\": \"特大\", \"sp_id\": 0, \"stock_num\": -1, \"shop_price\": 29.9, \"input_price\": 20}]', '14天', '2020-08-10 17:25:46', '2020-08-01 00:00:00', '2020-08-20 22:18:30', '2020-08-18 18:32:55', NULL, '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (7, 0, 313313473142456322, 1000017, '芙蓉李', '盼星星，盼月亮，我爱的芙蓉李终于来啦！皮脆，肉紧实，口感极佳果肉中含有多种维生素和氨基酸，5斤装', '福建屏南县', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811849/EaPPy5Wr2K.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811849/4fpkJisyPf.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811849/EspXQCeQsx.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811849/Qa8SmEZBaT.png\"]', 0, 6, 29.90, '[{\"name\": \"大大\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 29.9, \"input_price\": 20}]', '10天', '2020-08-03 11:38:23', '2020-08-01 00:00:00', '2020-08-03 11:38:23', '2020-08-03 20:14:54', NULL, '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (8, 0, 313314026622812162, 1000017, '苹果', '嘎拉苹果快来啦，是今年新下树的苹果哦！ 小宝宝辅食最佳人选，特别特别好刮泥，苹果味儿浓郁，今年的第一波新鲜现摘苹果，带着大自然的气息而来', '山东烟台', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811855/ciJGrraDJc.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811855/J6ZpAwzShG.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811855/7Z6GXhcKMe.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811855/fyhyNdKJxt.png\"]', 0, 6, 26.00, '[{\"name\": \"香脆\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 26, \"input_price\": 20}]', '10', '2020-08-03 11:38:03', '2020-08-01 00:00:00', '2020-08-03 11:38:03', '2020-08-03 20:14:56', NULL, '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (9, 0, 313314764132450306, 1000017, '火龙果', '原汁原味的火龙果', '海南', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202081192/r6NDZBYYS3.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202081192/8EajxmpPQp.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202081192/YGrawbbxMy.png\"]', 0, 6, 39.90, '[{\"name\": \"红色\", \"sp_id\": 0, \"stock_num\": 4, \"shop_price\": 39.9, \"input_price\": 30}]', '7天', '2020-08-03 11:37:49', '2020-08-01 00:00:00', '2020-08-03 11:37:49', '2020-08-03 20:14:58', NULL, '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (10, 0, 313315386265174018, 1000017, '香蕉', '', '海口', '[\"https://cwimg.szxjcheng.com/1000017/2020828112/Jwy7sXjYWA.png\", \"https://cwimg.szxjcheng.com/1000017/2020828112/pGjRjRhPCf.png\", \"https://cwimg.szxjcheng.com/1000017/2020828112/CSK3pxQpdf.png\"]', 1, 6, 29.90, '[{\"name\": \"绿色\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 29.9, \"input_price\": 20}]', '6', '2020-08-28 11:02:41', '2020-08-01 00:00:00', '2020-08-28 11:02:41', NULL, NULL, '2020-08-01 00:00:00');
INSERT INTO `goods` VALUES (11, 0, 313563438913683457, 1000017, '红心木瓜', '广东雷州红心木瓜\n推荐指数：★★★★★\n“百益果王”，现摘现发，软糯细致、清甜香浓[色]、嫩滑多汁💦，丰胸减肥～', '广东雷州', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831212/2hnYcs6ii2.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831212/3aMGwfXtfa.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831212/ncrzCNedPR.png\"]', 0, 6, 29.90, '[{\"name\": \"绿皮红心\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 29.9, \"input_price\": 20}]', '7天', '2020-08-03 12:12:54', '2020-08-03 00:00:00', '2020-08-03 12:12:54', '2020-08-03 20:14:49', NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (12, 0, 313563926375694338, 1000017, '蜜瓜', '推荐♥️民勤蜜瓜\n\n从地头到世界餐桌，\n北纬17度的沙漠，\n3600多小时的日照，\n接近20度的昼夜温差，\n加上农民4个多月的悉心照料，\n才换来的20％的含糖量的优质蜜瓜。 \n助农价2️⃣5️⃣元6斤 \n2个装 🌟顺丰包邮！！！', '民勤', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831217/YDGpAAFYym.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831217/AkjNPNtZWs.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831217/W4fnjGEhij.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831217/xdsSzS74i4.png\"]', 0, 6, 25.00, '[{\"name\": \"黄皮红心\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 25, \"input_price\": 20}]', '7天', '2020-08-03 12:17:44', '2020-08-01 00:00:00', '2020-08-03 12:17:44', '2020-08-03 20:14:47', NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (13, 0, 313565493434777601, 1000017, '六鳌蜜薯', '【六鳌蜜薯】\n🍠它产自福建漳浦县六鳌半岛， 以香、甜、糯、可口诱人著称！\n🍠六鳌海边沙地种植的红薯与普通红薯的区别之处是：海边沙地种植吸收海水含有天然的盐分，口感香甜糯…\n特价1️⃣9️⃣.9️⃣元5斤包邮', '福建漳浦县', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/FCpiyJDFkZ.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/Y6zswCeh4w.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/Z8aabNXHwn.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/E7S7mEs4eS.png\"]', 1, 7, 19.90, '[{\"name\": \"红皮黄心\", \"sp_id\": 0, \"stock_num\": 8, \"shop_price\": 19.9, \"input_price\": 15}]', '20天', '2020-08-03 12:33:19', '2020-08-03 00:00:00', '2020-08-03 21:52:48', '2020-08-03 20:14:45', NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (14, 0, 313593227649220610, 1000017, '宝贝南瓜', '\n贝贝南瓜上架🎉\n❺斤2️⃣9️⃣.9️⃣包邮 粉糯自带栗子香 瓜肉香甜皮也甜 连皮都能吃的它 个头小 隔水蒸熟就能吃 可咸可甜 既解馋又能解饿  最重要的是低脂！！', '四川攀枝花', '[\"https://cwimg.szxjcheng.com/1000017/20208101859/eh5GJDx8Ri.png\", \"https://cwimg.szxjcheng.com/1000017/20208101859/TiHPBdKDbM.png\", \"https://cwimg.szxjcheng.com/1000017/20208101859/hpXEhtz24t.png\", \"https://cwimg.szxjcheng.com/1000017/20208101859/tp7ECGfBPF.png\", \"https://cwimg.szxjcheng.com/1000017/20208111513/k6DbTWAe2F.png\"]', 1, 7, 29.90, '[{\"name\": \"绿皮黄心\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 29.9, \"input_price\": 20}]', '10天', '2020-08-11 15:13:42', '2020-08-03 00:00:00', '2020-08-11 15:13:42', NULL, NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (15, 0, 313593231021441026, 1000017, '南瓜', '\n贝贝南瓜上架🎉\n❺斤2️⃣9️⃣.9️⃣包邮 粉糯自带栗子香 瓜肉香甜皮也甜 连皮都能吃的它 个头小 隔水蒸熟就能吃 可咸可甜 既解馋又能解饿  最重要的是低脂！！', '山东', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/7Y5CXDQCxA.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/yHktP2B853.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/smWiD6dpPi.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/EimwYfCafx.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/ZjzDehFpkM.png\"]', 5, 6, 29.90, '[{\"name\": \"绿皮黄心\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 29.9, \"input_price\": 20}]', '10天', '2020-08-03 17:08:51', '2020-08-03 00:00:00', '2020-08-03 17:08:51', NULL, NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (16, 0, 313595667257753601, 1000017, '椰子', '❣️泰国奶椰🥥回归！\n❣️去年65元4⃣个，今年59元！\n\n泰国椰青，减肥神器，清热解渴，排毒利尿，补充电解质，椰子肉还可以用来熬汤或直接吃   冷藏过后更好喝[色] 赶快扔掉你手中的加工饮料吧！\n❺❾元（❹个装）帮你从泰国邮到家！', '泰国', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831733/Y7WFbMEnYG.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831733/SThNcaDcZA.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831733/7K6naFReA4.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831733/Wzt8By6aRZ.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831733/2CdtPxjkmF.png\"]', 0, 6, 59.90, '[{\"name\": \"大白\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 59.9, \"input_price\": 40}]', '15天', '2020-08-03 17:33:56', '2020-08-03 00:00:00', '2020-08-03 21:52:46', '2020-08-04 15:43:20', NULL, '2020-08-03 00:00:00');
INSERT INTO `goods` VALUES (23, 0, 313739674306740225, 1000004, 'Dior墨镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020841723/TnwZDcjmeh.png\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020841723/jh2psKkEcN.png\"]', 5, 3, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 19, \"shop_price\": 1880, \"input_price\": 1660}]', '', '2020-08-04 17:23:38', NULL, '2020-08-04 17:52:43', '2020-08-04 17:52:41', NULL, NULL);
INSERT INTO `goods` VALUES (24, 0, 313755454318575618, 1000013, '吕布', '三国战神', '包头', '[\"https://cwimg.szxjcheng.com/1000013/2020861220/R3NW88SQMk.png\"]', 1, 4, 22.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 22, \"input_price\": 0}]', '1000年', '2020-08-06 12:20:58', NULL, '2020-08-06 12:20:58', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (25, 0, 313844337676910593, 1000017, '红心猕猴桃', '红心猕猴桃被誉为“水果之王”、“维C冠军”，其维生素C的含量是柑橘的5-10倍、苹果的20-80倍。\n\n同时还含有具有抗癌、抗衰老功效的花青素，常吃红心猕猴桃有助于美容养颜、可以有效消除细纹、使皮肤更加细腻有光泽。', '浦江', '[\"https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png\", \"https://cwimg.szxjcheng.com/1000017/2020861155/EtsFbD8fWW.png\", \"https://cwimg.szxjcheng.com/1000017/2020851043/2xxKp3BDMT.png\", \"https://cwimg.szxjcheng.com/1000017/2020851043/ssfsAP2bsh.png\", \"https://cwimg.szxjcheng.com/1000017/2020861155/iZFhjZ3f6x.png\"]', 1, 6, 39.90, '[{\"name\": \"红心4.8斤装\", \"sp_id\": 0, \"stock_num\": -4, \"shop_price\": 39.9, \"input_price\": 35}]', '7天', '2020-08-06 11:55:33', '2020-08-05 00:00:00', '2020-08-06 11:55:33', NULL, '2020-08-06 11:55:54', '2020-08-05 00:00:00');
INSERT INTO `goods` VALUES (26, 0, 313845355265392641, 1000004, 'CBP隔离', '🛒现货 新款CPB隔离 \n特价💰330🉐 之前价格都在370\n\n新款37ml  spf从20增加到25 \n抗氧化效果非常好 越夜越美  转油为光', '韩国', '[\"https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png\", \"https://cwimg.szxjcheng.com/1000004/2020851053/ZeePQ4JPj6.png\"]', 1, 5, 330.00, '[{\"name\": \"新款37ml\", \"sp_id\": 0, \"stock_num\": 481, \"shop_price\": 330, \"input_price\": 300}]', '', '2020-08-05 17:34:11', NULL, '2020-08-05 17:34:11', NULL, '2020-08-05 17:34:21', NULL);
INSERT INTO `goods` VALUES (27, 0, 313846248736030721, 1000004, ' 娇韵诗粉水 ', '\n1⃣️敷尔佳水杨酸蛋壳膜 团购 两支💰189\n2⃣️ 娇韵诗粉水 现货💰289\n3⃣️雅诗兰黛智妍 精华霜 75ml💰659\n4⃣️菲洛嘉十全大补 国内专柜 💰229', '国内专柜', '[\"https://cwimg.szxjcheng.com/1000004/202085112/84scR2BEwJ.png\", \"https://cwimg.szxjcheng.com/1000004/202085112/RG4dd27SGD.png\", \"https://cwimg.szxjcheng.com/1000004/202085112/Cs3WwE7SFR.png\", \"https://cwimg.szxjcheng.com/1000004/202085112/KCsjJ6MBBT.png\"]', 1, 2, 189.00, '[{\"name\": \"敷尔佳水杨酸蛋壳膜\", \"sp_id\": 0, \"stock_num\": 20, \"shop_price\": 189, \"input_price\": 170}, {\"name\": \"娇韵诗粉水\", \"sp_id\": 1, \"stock_num\": 60, \"shop_price\": 289, \"input_price\": 250}, {\"name\": \"雅诗兰黛智妍\", \"sp_id\": 2, \"stock_num\": 300, \"shop_price\": 659, \"input_price\": 600}, {\"name\": \"菲洛嘉十全大补\", \"sp_id\": 3, \"stock_num\": 900, \"shop_price\": 229, \"input_price\": 200}]', '', '2020-08-05 11:02:22', NULL, '2020-08-05 11:02:22', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (28, 0, 313846422631874562, 1000004, '雪花秀明星套', '‭‮新最‬‬️❗直邮‭预定 💰7××\n7月‭‮国韩‬‬🇰🇷Sulwhasoo‭‮花雪‬‬秀明星套\n\n雪花秀‭‮阴滋‬‬全套装，集抗皱，‭‮润滋‬‬\n延缓衰老为一体！‭‮阴滋‬‬去黄保湿\n坚持‭使用2~3个月，气色会‭‮得变‬‬不一样！\n清爽好‭‮收吸‬‬～', '韩国', '[\"https://cwimg.szxjcheng.com/1000004/202085114/RcQaQEKyaw.png\", \"https://cwimg.szxjcheng.com/1000004/202085114/jPEaNzebhK.png\", \"https://cwimg.szxjcheng.com/1000004/202085114/h7h2bifHMz.png\"]', 1, 2, 789.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": -1, \"shop_price\": 789, \"input_price\": 600}]', '', '2020-08-05 11:04:05', NULL, '2020-08-05 11:04:05', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (29, 0, 313846495260442625, 1000004, 'Dior墨镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://cwimg.szxjcheng.com/1000004/202085114/h3FtA3NGke.png\", \"https://cwimg.szxjcheng.com/1000004/202085114/yGH2RbihFT.png\"]', 1, 2, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 197, \"shop_price\": 1880, \"input_price\": 1660}]', '', '2020-08-05 11:04:49', NULL, '2020-08-05 17:34:28', '2020-08-05 17:33:41', NULL, NULL);
INSERT INTO `goods` VALUES (30, 0, 313846707022462978, 1000004, '敷尔佳 灯泡膜', '🌸医美   敷尔佳 灯泡膜 团购活动❣️\n🛒💰185/3盒💰350/6盒包邮\n\n熬夜必备 一定多囤\n美白提亮抗氧化巨强💪🏻', '专柜', '[\"https://cwimg.szxjcheng.com/1000004/202085116/4SKRJT4GAb.png\"]', 1, 2, 185.00, '[{\"name\": \"三盒\", \"sp_id\": 0, \"stock_num\": 196, \"shop_price\": 185, \"input_price\": 160}, {\"name\": \"六盒\", \"sp_id\": 1, \"stock_num\": 200, \"shop_price\": 350, \"input_price\": 260}]', '', '2020-08-05 11:06:55', NULL, '2020-08-05 11:06:55', NULL, '2020-08-06 18:12:15', NULL);
INSERT INTO `goods` VALUES (31, 0, 313846830771208193, 1000004, 'sraN‬‬腮红', '‭‮国韩‬‬🇰🇷直邮   ‭‮sraN‬‬腮红\n超低‭‮价扣折‬‬预定 💰‭‮071‬‬🉐 超美腻！\n\n今日到货1⃣️爱茉莉染发剂2⃣️敷尔佳绿膜', '韩国', '[\"https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png\"]', 1, 5, 170.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 93, \"shop_price\": 170, \"input_price\": 140}]', '', '2020-08-05 11:08:09', NULL, '2020-08-05 11:08:09', NULL, '2020-08-05 17:33:32', NULL);
INSERT INTO `goods` VALUES (32, 0, 313854588908208130, 1000017, '榴莲酥', '【超级好吃的榴莲酥】\n\n54/两盒！12枚装！！\n真的榴莲肉！！不是榴莲酱！！\n微波炉叮20秒🛎\n简直人间极品！！', '广州', '[\"https://cwimg.szxjcheng.com/1000017/2020851225/ZfWBeS2Mcj.png\", \"https://cwimg.szxjcheng.com/1000017/2020851225/A3i33dpzYa.png\", \"https://cwimg.szxjcheng.com/1000017/2020851225/2d4QctZpf2.png\", \"https://cwimg.szxjcheng.com/1000017/2020851225/MJAZHBnQbD.png\", \"https://cwimg.szxjcheng.com/1000017/2020851225/7Sc5Wz3dSa.png\"]', 1, 8, 54.00, '[{\"name\": \"小包装\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 54, \"input_price\": 48}]', '30天', '2020-08-05 12:25:13', '2020-08-05 00:00:00', '2020-08-05 12:25:13', NULL, NULL, '2020-08-05 00:00:00');
INSERT INTO `goods` VALUES (33, 0, 313864793062637570, 1000035, '一座山', '', '深圳', '[\"https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png\"]', 5, 5, 200.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 96, \"shop_price\": 200, \"input_price\": 10}]', '', '2020-08-05 17:39:07', NULL, '2020-08-05 17:39:07', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (34, 0, 313871434172596226, 1000017, '黄桃', '锦绣黄桃儿\n它的核儿是红的，然后肉是黄的\n非常非常的好吃，这款桃儿才是每年夏天就是桃子里边儿的南波儿万就是牛逼到爆，真的就是太好吃太甜太香了[呲牙]\n买它！买它！', '湖南长沙', '[\"https://cwimg.szxjcheng.com/1000017/2020851512/PETsKewiJk.png\", \"https://cwimg.szxjcheng.com/1000017/2020851512/fyTGDXm4Bj.png\", \"https://cwimg.szxjcheng.com/1000017/2020851512/5cfT64pPsd.png\"]', 0, 6, 29.90, '[{\"name\": \"4.5斤装\", \"sp_id\": 0, \"stock_num\": 9, \"shop_price\": 29.9, \"input_price\": 20}]', '7天', '2020-08-10 16:56:09', '2020-08-05 00:00:00', '2020-08-10 16:56:09', '2020-08-18 18:32:45', NULL, '2020-08-05 00:00:00');
INSERT INTO `goods` VALUES (35, 0, 313983896783945730, 1000035, '2', '', '2', '[\"https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png\"]', 5, 6, 100.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 69, \"shop_price\": 100, \"input_price\": 20}]', '', '2020-08-06 21:27:48', NULL, '2020-08-06 21:34:28', '2020-08-06 21:27:48', NULL, NULL);
INSERT INTO `goods` VALUES (36, 0, 313999430606913538, 1000013, '曹操', '', '安徽亳州', '[\"https://cwimg.szxjcheng.com/1000013/2020861224/RefMrFrZys.png\"]', 1, 4, 100.98, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 100.98, \"input_price\": 0}]', '', '2020-08-06 12:24:05', NULL, '2020-08-06 12:24:05', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (37, 0, 313999526673252353, 1000013, '诸葛亮', '', '山东沂南', '[\"https://cwimg.szxjcheng.com/1000013/2020861225/r2aFBjN3RM.png\"]', 1, 4, 2000.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 2000, \"input_price\": 0}]', '', '2020-08-06 12:25:02', NULL, '2020-08-06 12:25:02', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (38, 0, 313999617320550402, 1000013, '典韦', '', '商丘市', '[\"https://cwimg.szxjcheng.com/1000013/2020861225/bRXYn3jHtP.png\"]', 1, 4, 50.69, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 50.69, \"input_price\": 0}]', '', '2020-08-06 12:25:57', NULL, '2020-08-06 12:25:57', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (39, 0, 313999684966285313, 1000013, '关羽', '关羽（？—220年），本字长生，后改字云长，河东郡解县（今山西运城）人，雅号“美髯公”。早年跟随刘备颠沛流离，辗转各地，和刘备、张飞情同兄弟，因而虽然受到了曹操的厚待，但关羽仍然借机离开曹操，去追随刘备。赤壁之战后，关羽助刘备、周瑜攻打曹仁所驻守的南郡，而后刘备势力逐渐壮大，关羽则长期镇守荆州。\n建安二十四年，关羽在与曹仁之间的军事摩擦中逐渐占据上风，随后水陆并进，围襄阳，攻樊城，并利用秋季大雨，水淹七军，将前来救援的于禁打的全军覆没，进而包围樊城。关羽威震华夏，使得曹操一度产生迁都以避关羽锋锐的想法。\n但随后东吴孙权派遣吕蒙、陆逊袭击了关羽的后方，麋芳、士仁都背弃关羽。同时，关羽又在与徐晃的交战中失利，最终进退失据，兵败被杀。谥曰壮缪侯。\n关羽去世后，逐渐被神化，民间尊其为“关公”，历代朝廷多有褒封，清代奉为“忠义神武灵佑仁勇威显关圣大帝”，崇为“武圣”，与“文圣” 孔子齐名。《三国演义》尊其为蜀国“五虎上将”之首，毛宗岗称其为《演义》三绝中的“义绝”。', '山西运城', '[\"https://cwimg.szxjcheng.com/1000013/2020861226/45FZe7yhi2.png\"]', 1, 4, 99999.89, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 99999.89, \"input_price\": 0}]', '', '2020-08-06 12:38:18', NULL, '2020-08-06 12:38:18', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (40, 0, 314010741554282497, 1000013, '花老板', '', '平里', '[\"https://cwimg.szxjcheng.com/1000013/2020861416/rywr4GHCBx.png\"]', 1, 1, 1.99, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 1.99, \"input_price\": 0}]', '', '2020-08-06 14:16:27', NULL, '2020-08-06 14:16:27', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (41, 0, 314012992620462082, 1000013, '大头', '头老板', '良坊', '[\"https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png\", \"https://cwimg.szxjcheng.com/1000013/20208111516/NzxYZM8Mk2.png\"]', 1, 1, 0.50, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 0.5, \"input_price\": 0}]', '', '2020-08-11 15:16:13', NULL, '2020-08-11 15:16:13', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (42, 0, 314173471976325122, 1000082, 'Dior墨镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://cwimg.szxjcheng.com/1000082/2020871713/Z6bjsyy5Zw.png\", \"https://cwimg.szxjcheng.com/1000082/2020871713/7XAFsjGyGN.png\"]', 5, 2, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 100, \"shop_price\": 1880, \"input_price\": 1600}]', '', '2020-08-07 17:13:02', NULL, '2020-08-07 17:13:02', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (43, 0, 314173560056709121, 1000082, 'Dior墨镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://cwimg.szxjcheng.com/1000082/2020871713/C8njpiWpzA.png\", \"https://cwimg.szxjcheng.com/1000082/2020871713/zmewC3s7YN.png\"]', 1, 3, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 100, \"shop_price\": 1880, \"input_price\": 1600}]', '', '2020-08-07 17:13:54', NULL, '2020-08-07 17:13:54', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (44, 0, 314191578082050050, 1000035, 'QQ', '', 'QQ', '[\"https://cwimg.szxjcheng.com/1000035/2020872012/mh8mnNsTkH.png\"]', 5, 6, 20.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 20, \"input_price\": 10}]', '', '2020-08-07 20:12:54', NULL, '2020-08-07 20:12:54', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (45, 0, 314191605663793153, 1000035, '叮叮', '', '那你', '[\"https://cwimg.szxjcheng.com/1000035/2020872013/tsHKiPWYrA.png\"]', 5, 6, 20.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 20, \"input_price\": 0}]', '', '2020-08-07 20:13:10', NULL, '2020-08-07 20:13:10', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (46, 0, 314191633060986881, 1000035, '好', '', '呢', '[\"https://cwimg.szxjcheng.com/1000035/2020872013/ZQGmtMJKer.png\"]', 5, 6, 20.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 20, \"input_price\": 0}]', '', '2020-08-07 20:13:27', NULL, '2020-08-07 20:13:27', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (47, 0, 314191661213155330, 1000035, '呢', '', '呢', '[\"https://cwimg.szxjcheng.com/1000035/2020872013/yDPJBe5p47.png\"]', 5, 6, 20.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 20, \"input_price\": 0}]', '', '2020-08-07 20:13:44', NULL, '2020-08-07 20:13:44', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (48, 0, 314197914115112962, 1000084, 'CPB隔离', '🛒现货 新款CPB隔离 \n特价💰330🉐 之前价格都在370\n\n新款37ml  spf从20增加到25 \n抗氧化效果非常好 越夜越美  转油为光', '韩国', '[\"https://cwimg.szxjcheng.com/1000084/2020872115/p3czJSEr8w.png\", \"https://cwimg.szxjcheng.com/1000084/2020872115/MsMceYsD8c.png\"]', 5, 1, 330.00, '[{\"name\": \"37ml\", \"sp_id\": 0, \"stock_num\": 5, \"shop_price\": 330, \"input_price\": 0}]', '', '2020-08-07 21:16:05', '2020-05-01 00:00:00', '2020-08-07 21:16:05', NULL, NULL, '2020-08-07 00:00:00');
INSERT INTO `goods` VALUES (49, 0, 314197946109263873, 1000084, 'Dior眼镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://cwimg.szxjcheng.com/1000084/2020872116/QbffASyYNT.png\", \"https://cwimg.szxjcheng.com/1000084/2020872116/PpsGhCnh2N.png\"]', 5, 3, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 200, \"shop_price\": 1880, \"input_price\": 1660}]', '', '2020-08-07 21:16:10', NULL, '2020-08-07 21:16:10', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (50, 0, 314198174128406530, 1000084, 'Dior墨镜', '🇰🇷直邮  Dior墨镜 💰1880 预定\n\n迪奥眼镜免税店今日放折扣！\n免税店原包装寄回  两周到国内❣️\n已买单一波 明天去补剩下的\n原价2700！！去掉国际运费快六折了！', '法国', '[\"https://cwimg.szxjcheng.com/1000084/2020872118/C8Y5ZDNPCW.png\", \"https://cwimg.szxjcheng.com/1000084/2020872118/3mwAXzGK3f.png\"]', 1, 3, 1880.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 199, \"shop_price\": 1880, \"input_price\": 1660}]', '', '2020-08-07 21:18:26', NULL, '2020-08-07 21:18:26', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (51, 0, 314263802805747713, 1000035, '喷泉', '美丽的喷泉，好漂亮', '上海', '[\"https://cwimg.szxjcheng.com/1000035/202088810/DHCGFmdCjD.png\", \"https://cwimg.szxjcheng.com/1000035/202088810/aR3JpdWAnt.png\"]', 5, 4, 2.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 2, \"input_price\": 1}]', '', '2020-08-08 08:11:10', NULL, '2020-08-08 08:11:10', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (52, 0, 314269202250727426, 1000035, 'CPB长管隔离', '自用cpb长管隔离💰310', '专柜', '[\"https://cwimg.szxjcheng.com/1000035/20208894/PrwHc5izW3.png\"]', 5, 5, 310.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 4, \"shop_price\": 310, \"input_price\": 250}]', '', '2020-08-08 09:13:55', NULL, '2020-08-08 09:13:55', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (53, 0, 314269292797362178, 1000035, '兰蔻小黑瓶', '此时不囤待何时🉐️活动，最后一波活动，兰蔻小黑瓶肌底液促进后续护肤品五倍吸收！！“十滴水乳不及一滴精华”', '专柜', '[\"https://cwimg.szxjcheng.com/1000035/20208894/dfz4w8N6Md.png\"]', 5, 5, 300.00, '[{\"name\": \"50ml\", \"sp_id\": 0, \"stock_num\": 9, \"shop_price\": 300, \"input_price\": 250}, {\"name\": \"100ml\", \"sp_id\": 1, \"stock_num\": 20, \"shop_price\": 600, \"input_price\": 500}]', '', '2020-08-08 09:12:24', NULL, '2020-08-08 09:12:24', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (54, 0, 314269349722456065, 1000035, '小棕瓶', '第7代小棕瓶长这样\n换了件马甲，你们得多掏300块😁 \n趁现在第6代还能买到，囤两瓶没错咯~', '专柜', '[\"https://cwimg.szxjcheng.com/1000035/20208895/sHzNEkiMsm.png\"]', 5, 5, 400.00, '[{\"name\": \"第6代\", \"sp_id\": 0, \"stock_num\": 9, \"shop_price\": 400, \"input_price\": 300}]', '', '2020-08-08 09:10:17', NULL, '2020-08-08 09:10:17', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (55, 0, 314600264470364161, 1000017, '青皮核桃', '青皮核桃上架❷❾.❾❸斤\n它富含丰富的维生素，\n被誉为\"万岁子\"、“长寿果”，\n每天早晚各吃几枚鲜核桃不但具有美白的作用，还可补大脑、益心脏、治失眠、已经受到了越来越多的人的推崇。\n\n吃新鲜核桃的好处：\n1、减少患乳腺癌的风险\n2、减少患抑郁症几率\n核桃中富含丰富的ω-3脂肪酸，可以减少患抑郁症、注意力缺失多动症(ADHD)、癌症和老年痴呆症等的几率。\n3、降低患糖尿病的风险\n每周坚持食用5次坚果的女性患2型糖尿病的风险减少近30%。坚果中的不饱和脂肪有益于胰岛素分解。\n4、含抗氧化剂促进心脏健康\n核桃中含有的高质量抗氧化剂，能很好的保护心脏机能健康，预防心脏功能疾病。\n5、减除压力\n核桃中的核桃油具有减除血液静压的作用，饮食习惯的改变能更好的帮助我们的身体应对外界压力。', '陕西大荔', '[\"https://cwimg.szxjcheng.com/1000017/20208101552/QFHQezEwCB.png\", \"https://cwimg.szxjcheng.com/1000017/20208101552/5ZKiG66RJ3.png\", \"https://cwimg.szxjcheng.com/1000017/20208101552/byJYahHDT6.png\", \"https://cwimg.szxjcheng.com/1000017/20208101552/rzJwPAZWPb.png\", \"https://cwimg.szxjcheng.com/1000017/20208101552/YkQQhiksyW.png\"]', 0, 6, 29.90, '[{\"name\": \"3斤装\", \"sp_id\": 0, \"stock_num\": 7, \"shop_price\": 29.9, \"input_price\": 22.5}]', '30天', '2020-08-10 15:53:50', '2020-08-10 00:00:00', '2020-08-10 15:53:50', '2020-08-18 18:33:08', NULL, '2020-08-10 00:00:00');
INSERT INTO `goods` VALUES (56, 0, 314637217479786498, 1000099, '杏色外套', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102159/pyHCJFkx26.png\", \"https://cwimg.szxjcheng.com/1000099/20208102159/Hpe3pkA6Dr.png\"]', 1, 4, 100.00, '[{\"name\": \"S M L\", \"sp_id\": 0, \"stock_num\": 15, \"shop_price\": 100, \"input_price\": 0}]', '', '2020-08-10 22:01:06', '2019-09-10 00:00:00', '2020-08-10 22:01:06', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (57, 0, 314637508379934722, 1000065, '兰蔻小黑瓶', '', '香港', '[\"https://cwimg.szxjcheng.com/1000065/2020810222/nh2DsBff7B.png\", \"https://cwimg.szxjcheng.com/1000065/2020810222/K6MceczN2b.png\", \"https://cwimg.szxjcheng.com/1000065/2020810222/pzWbD76Kit.png\"]', 1, 2, 1010.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 1010, \"input_price\": 0}]', '3', '2020-08-10 22:02:49', NULL, '2020-08-10 22:02:49', NULL, NULL, '2020-08-10 00:00:00');
INSERT INTO `goods` VALUES (58, 0, 314637905060429825, 1000065, '雅诗兰黛小棕瓶', '', '香港', '[\"https://cwimg.szxjcheng.com/1000065/2020810226/rH3KThExRS.png\", \"https://cwimg.szxjcheng.com/1000065/2020810226/PQaMDB7kCj.png\", \"https://cwimg.szxjcheng.com/1000065/2020810226/AiJ5xf7PHS.png\"]', 1, 2, 980.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 980, \"input_price\": 0}]', '', '2020-08-10 22:06:46', NULL, '2020-08-10 22:06:46', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (59, 0, 314637929504833537, 1000099, '针织个性鞋', '舒适透气 好穿不累脚', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810226/TdQQe8HKb3.png\", \"https://cwimg.szxjcheng.com/1000099/2020810226/fF8h8ihCRe.png\"]', 1, 4, 80.00, '[{\"name\": \"37码 38码\", \"sp_id\": 0, \"stock_num\": 5, \"shop_price\": 80, \"input_price\": 0}]', '', '2020-08-10 22:07:00', NULL, '2020-08-10 22:07:00', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (60, 0, 314638122577035266, 1000099, '咖色格子大衣', '超大牌长款外套，', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810228/cykJee5DdC.png\", \"https://cwimg.szxjcheng.com/1000099/2020810228/eZYTeZS83k.png\"]', 1, 4, 280.00, '[{\"name\": \"S M L\", \"sp_id\": 0, \"stock_num\": 20, \"shop_price\": 280, \"input_price\": 0}]', '', '2020-08-10 22:08:55', NULL, '2020-08-10 22:08:55', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (61, 0, 314638384653926401, 1000099, '斜挎包', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102211/FBPmmjsSjP.png\"]', 5, 4, 1.00, '[{\"name\": \"红色\", \"sp_id\": 0, \"stock_num\": 3, \"shop_price\": 1, \"input_price\": 0}]', '', '2020-08-10 22:11:32', NULL, '2020-08-10 22:11:32', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (62, 0, 314640016657612801, 1000099, '黑色高档羽绒', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102227/NR7ZNbHHXB.png\", \"https://cwimg.szxjcheng.com/1000099/20208102227/ErERmmkwTc.png\"]', 1, 4, 400.00, '[{\"name\": \"黑 S M\", \"sp_id\": 0, \"stock_num\": 40, \"shop_price\": 400, \"input_price\": 0}]', '', '2020-08-10 22:27:44', NULL, '2020-08-10 22:27:44', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (63, 0, 314640465548804098, 1000099, '毛呢格子外套', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102232/4nrBiYxFDC.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/j7RN2SsCtw.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/2XTYSBicrx.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/N6m38dsJdk.png\"]', 1, 4, 220.00, '[{\"name\": \"黑\", \"sp_id\": 0, \"stock_num\": 36, \"shop_price\": 220, \"input_price\": 0}]', '', '2020-08-10 22:32:12', NULL, '2020-08-10 22:32:12', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (64, 0, 314640474423951361, 1000099, '毛呢格子外套', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102232/Fr7Fz5xAkA.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/tZ8CYiKaSn.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/G4GtkD78fJ.png\", \"https://cwimg.szxjcheng.com/1000099/20208102232/2JskMt4QGQ.png\"]', 5, 4, 220.00, '[{\"name\": \"黑\", \"sp_id\": 0, \"stock_num\": 36, \"shop_price\": 220, \"input_price\": 0}]', '', '2020-08-10 22:32:17', NULL, '2020-08-10 22:32:17', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (65, 0, 314643413255323650, 1000013, '萍乡麻辣', '辣豆皮', '萍乡市', '[\"https://cwimg.szxjcheng.com/1000013/2020810231/Cjf4MHFsk5.png\", \"https://cwimg.szxjcheng.com/1000013/2020810231/Rwb6Mdt288.png\"]', 1, 8, 6.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 9997, \"shop_price\": 6, \"input_price\": 0}]', '', '2020-08-10 23:02:17', NULL, '2020-08-10 23:02:17', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (66, 0, 314643710799249409, 1000099, '波点连衣裙', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810233/pTc5yXXCyJ.png\", \"https://cwimg.szxjcheng.com/1000099/2020810233/kbEAjERzdk.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/fjw58fSbB6.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/ECK45xtHrH.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/fnA47X7P68.png\"]', 1, 4, 315.00, '[{\"name\": \"蓝色 S M L\", \"sp_id\": 0, \"stock_num\": 39, \"shop_price\": 315, \"input_price\": 0}, {\"name\": \"\", \"sp_id\": 1, \"stock_num\": 0, \"shop_price\": 0, \"input_price\": 0}]', '', '2020-08-10 23:04:26', NULL, '2020-08-10 23:04:26', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (67, 0, 314643751584661506, 1000099, '波点连衣裙', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810234/7exWnaKERa.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/yJZfaWiewM.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/PkScpSaMsm.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/GcCHmQjxAS.png\", \"https://cwimg.szxjcheng.com/1000099/2020810234/KBWEwR3Mj7.png\"]', 5, 4, 315.00, '[{\"name\": \"蓝色 S M L\", \"sp_id\": 0, \"stock_num\": 39, \"shop_price\": 315, \"input_price\": 0}, {\"name\": \"\", \"sp_id\": 1, \"stock_num\": 0, \"shop_price\": 0, \"input_price\": 0}]', '', '2020-08-10 23:04:50', NULL, '2020-08-10 23:04:50', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (68, 0, 314643959034937345, 1000099, '格子西装', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810236/mZMkFRpP3d.png\", \"https://cwimg.szxjcheng.com/1000099/2020810236/YHX8DwYbQ4.png\", \"https://cwimg.szxjcheng.com/1000099/2020810236/iH7SXzWjpa.png\"]', 1, 4, 300.00, '[{\"name\": \"黑 M L\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 300, \"input_price\": 0}]', '', '2020-08-10 23:06:54', NULL, '2020-08-10 23:06:54', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (69, 0, 314644149657665538, 1000099, '白T', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/2020810238/z5RZsrQM4B.png\", \"https://cwimg.szxjcheng.com/1000099/2020810238/NRTAKzRfwY.png\", \"https://cwimg.szxjcheng.com/1000099/2020810238/WxZp3a8Dwb.png\"]', 1, 4, 160.00, '[{\"name\": \"白 M L\", \"sp_id\": 0, \"stock_num\": 55, \"shop_price\": 160, \"input_price\": 0}]', '', '2020-08-10 23:08:48', NULL, '2020-08-10 23:08:48', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (70, 0, 314644329727524865, 1000099, '粉色街拍T恤', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102310/QxkNEMJzye.png\", \"https://cwimg.szxjcheng.com/1000099/20208102310/TrnfwPMTfj.png\", \"https://cwimg.szxjcheng.com/1000099/20208102310/K5XH8kyTXW.png\"]', 1, 4, 160.00, '[{\"name\": \"粉 M L\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 160, \"input_price\": 0}]', '', '2020-08-10 23:10:35', NULL, '2020-08-10 23:10:35', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (71, 0, 314644409939394562, 1000099, '焦糖色双面尼', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102311/4cPSc6RKFH.png\", \"https://cwimg.szxjcheng.com/1000099/20208102311/cES5RkRpfm.png\"]', 1, 4, 300.00, '[{\"name\": \"焦糖色\", \"sp_id\": 0, \"stock_num\": 4, \"shop_price\": 300, \"input_price\": 0}]', '', '2020-08-10 23:11:23', NULL, '2020-08-10 23:11:23', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (72, 0, 314644506743930881, 1000099, '紫色羽绒', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102312/KzZQR4iYc5.png\", \"https://cwimg.szxjcheng.com/1000099/20208102312/eb2r3QBxRa.png\"]', 1, 4, 220.00, '[{\"name\": \"紫色M L\", \"sp_id\": 0, \"stock_num\": 25, \"shop_price\": 220, \"input_price\": 0}]', '', '2020-08-10 23:12:21', NULL, '2020-08-10 23:12:21', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (73, 0, 314644715687378945, 1000099, '宫廷风连衣裙', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208102314/JRdhKReFyQ.png\", \"https://cwimg.szxjcheng.com/1000099/20208102314/HeHF3wNyrt.png\", \"https://cwimg.szxjcheng.com/1000099/20208102314/2sek8CwKDG.png\", \"https://cwimg.szxjcheng.com/1000099/20208102314/wMfBQmFP27.png\"]', 1, 4, 180.00, '[{\"name\": \"S M L\", \"sp_id\": 0, \"stock_num\": 33, \"shop_price\": 180, \"input_price\": 0}]', '', '2020-08-10 23:14:25', NULL, '2020-08-10 23:14:25', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (74, 0, 314660191427624961, 1000022, '红腰子精华', '', '香港专柜', '[\"https://cwimg.szxjcheng.com/1000022/2020811148/4hncEDcfQs.png\", \"https://cwimg.szxjcheng.com/1000022/2020811148/h4eMYyiM57.png\", \"https://cwimg.szxjcheng.com/1000022/2020811148/fGFmMWywm4.png\"]', 1, 5, 650.00, '[{\"name\": \"75ml\", \"sp_id\": 0, \"stock_num\": 20, \"shop_price\": 650, \"input_price\": 480}, {\"name\": \"100ml\", \"sp_id\": 1, \"stock_num\": 2, \"shop_price\": 938, \"input_price\": 810}]', '3年', '2020-08-11 01:48:09', NULL, '2020-08-11 01:48:09', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (75, 0, 314660606193958913, 1000022, 'Mk相机包', '', '香港', '[\"https://cwimg.szxjcheng.com/1000022/2020811152/BnHsm88cSa.png\", \"https://cwimg.szxjcheng.com/1000022/2020811152/xCPYtsN6fy.png\", \"https://cwimg.szxjcheng.com/1000022/2020811152/beksG65jQG.png\", \"https://cwimg.szxjcheng.com/1000022/2020811152/eQsJpnHRAY.png\", \"https://cwimg.szxjcheng.com/1000022/2020811152/Gw3CYFMczN.png\"]', 1, 4, 999.00, '[{\"name\": \"红色\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 999, \"input_price\": 800}, {\"name\": \"米色\", \"sp_id\": 1, \"stock_num\": 1, \"shop_price\": 999, \"input_price\": 800}]', '', '2020-08-11 01:52:17', NULL, '2020-08-11 01:52:17', NULL, NULL, '2020-09-11 00:00:00');
INSERT INTO `goods` VALUES (76, 0, 314661028560371714, 1000022, 'ajuste防晒喷雾', '', '香港', '[\"https://cwimg.szxjcheng.com/1000022/2020811156/XcGZGPxDzz.png\"]', 0, 5, 90.00, '[{\"name\": \"白色\", \"sp_id\": 0, \"stock_num\": 40, \"shop_price\": 90, \"input_price\": 65}]', '', '2020-08-11 01:56:28', NULL, NULL, '2020-08-11 01:56:28', NULL, '2020-08-11 00:00:00');
INSERT INTO `goods` VALUES (77, 0, 314710433518845954, 1000106, '黄桃', '陕西黄桃，现摘现发，5斤装，山泉水灌溉，品相好，味道佳，新疆，西藏，海南不发货，其他地方包邮', '陕西', '[\"https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png\", \"https://cwimg.szxjcheng.com/1000106/2020811106/bGEGzC48rR.png\", \"https://cwimg.szxjcheng.com/1000106/2020811106/7MtRFWdDWh.png\", \"https://cwimg.szxjcheng.com/1000106/2020811106/Qjz4e7NjxT.png\", \"https://cwimg.szxjcheng.com/1000106/2020811107/PfGcRih8P5.png\"]', 1, 6, 48.00, '[{\"name\": \"5斤装\", \"sp_id\": 0, \"stock_num\": 94, \"shop_price\": 48, \"input_price\": 35}]', '7日', '2020-08-11 10:11:38', '2020-08-11 00:00:00', '2020-08-11 10:11:38', NULL, NULL, '2020-08-12 00:00:00');
INSERT INTO `goods` VALUES (78, 0, 314737497114411010, 1000099, '格子连衣裙', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208111436/m88SQEzYNY.png\", \"https://cwimg.szxjcheng.com/1000099/20208111436/H2eANjRH47.png\", \"https://cwimg.szxjcheng.com/1000099/20208111436/bc3RsJJDwh.png\"]', 1, 4, 114.00, '[{\"name\": \"S M L\", \"sp_id\": 0, \"stock_num\": 23, \"shop_price\": 114, \"input_price\": 0}]', '', '2020-08-11 14:36:07', NULL, '2020-08-11 14:36:07', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (79, 0, 314737635660660737, 1000099, '白色风衣', '', '香港品牌', '[\"https://cwimg.szxjcheng.com/1000099/20208111437/WaK7Si3YSP.png\", \"https://cwimg.szxjcheng.com/1000099/20208111437/m7MrTzG5AQ.png\", \"https://cwimg.szxjcheng.com/1000099/20208111437/kAfk4SMmbD.png\"]', 1, 4, 154.00, '[{\"name\": \"L\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 154, \"input_price\": 0}]', '', '2020-08-11 14:37:30', NULL, '2020-08-11 14:37:30', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (80, 0, 314760538842202113, 1000017, '黄桃', '一年一次的陕西黄桃又来了，欲购从速，自家种植、不催熟、不染色、无公害、色泽艳丽、口感香甜，水分充足\n预约当天采摘包装发货，确保绝对新鲜\n网套+泡沫拖外加纸箱保证果子不受伤，保证满足您的味蕾，错过只能等明年\n现特惠尝鲜价5斤装50元，除新疆西藏海南不发货，全国包邮\nTEL:18706821922', '陕西澄城', '[\"https://cwimg.szxjcheng.com/1000017/20208111825/KZwpStTZzn.png\", \"https://cwimg.szxjcheng.com/1000017/20208111825/GWSZpYwHxA.png\", \"https://cwimg.szxjcheng.com/1000017/20208111825/AhHiFB7k7N.png\", \"https://cwimg.szxjcheng.com/1000017/20208111825/m7ENJJKXbH.png\", \"https://cwimg.szxjcheng.com/1000017/20208111825/k4ArBDnZpK.png\"]', 0, 6, 40.00, '[{\"name\": \"5斤装\", \"sp_id\": 0, \"stock_num\": 6, \"shop_price\": 40, \"input_price\": 35}]', '7天', '2020-08-11 18:29:47', '2020-08-11 00:00:00', '2020-08-11 18:29:47', '2020-08-23 16:18:15', NULL, '2020-08-11 00:00:00');
INSERT INTO `goods` VALUES (81, 0, 314762681712115714, 1000035, '雅诗兰黛洗面奶', '现货秒发', '香港', '[\"https://cwimg.szxjcheng.com/1000035/20208111846/DCjjJ3WCrZ.png\"]', 5, 5, 198.00, '[{\"name\": \"125ml\", \"sp_id\": 0, \"stock_num\": 8, \"shop_price\": 198, \"input_price\": 0}]', '', '2020-08-11 18:46:51', NULL, '2020-08-11 18:46:51', '2020-08-12 18:48:16', NULL, NULL);
INSERT INTO `goods` VALUES (82, 0, 315191397462310914, 1000035, '2', '33', '22', '[\"https://cwimg.szxjcheng.com/1000035/20208141745/mdbCRPT6hb.png\"]', 1, 5, 22.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 22, \"input_price\": 0}]', '', '2020-08-14 17:45:13', NULL, '2020-08-14 17:45:13', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (83, 0, 315201545010413570, 1000035, '小羊208', '63', '44', '[\"https://cwimg.szxjcheng.com/1000035/20208141925/N4HSEByzJT.png\"]', 0, 5, 99.90, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 99.9, \"input_price\": 10}]', '', '2020-08-14 19:26:36', NULL, NULL, '2020-08-14 19:26:36', NULL, NULL);
INSERT INTO `goods` VALUES (84, 0, 315769377737670657, 1000017, '山竹', '【泰国山竹上新！】\n这个山竹可不是一般的新鲜哦！泰国专线运输，更快，到货立马打包顺丰发出。没有保鲜剂防腐剂，每一口都新鲜健康！\n来自泰国优质果园，果肉雪白、美味多汁，清甜甘香，水分十足，甜而不腻【大果五斤31个左右79.9，小果五斤40个左右72】', '泰国', '[\"https://cwimg.szxjcheng.com/1000017/20208181726/RfAYQaXHfb.png\", \"https://cwimg.szxjcheng.com/1000017/20208181726/EtCGsjNM7G.png\", \"https://cwimg.szxjcheng.com/1000017/20208181726/yAwpwkyShe.png\", \"https://cwimg.szxjcheng.com/1000017/20208181726/Cdyh26bTZj.png\", \"https://cwimg.szxjcheng.com/1000017/20208181726/stBpYrJBdA.png\"]', 1, 6, 79.00, '[{\"name\": \"31个大个\", \"sp_id\": 0, \"stock_num\": 3, \"shop_price\": 79, \"input_price\": 70}, {\"name\": \"40个中小个\", \"sp_id\": 1, \"stock_num\": 6, \"shop_price\": 72, \"input_price\": 65}]', '7天', '2020-08-18 17:26:56', '2020-08-18 00:00:00', '2020-08-18 17:26:56', NULL, '2020-08-18 17:27:03', '2020-08-18 00:00:00');
INSERT INTO `goods` VALUES (85, 0, 315776510302617601, 1000017, '石榴', '蒙自处于北纬23°，位于北回归线上，属于亚热带季风气候，年平均气温在18°，年日照时间在2234小时以上，十分适合石榴等农作物生长，故此这里长出的石榴粒粒饱满，鲜甜多汁。\n蒙自石榴还有一个特点是果实饱满圆润、光鲜亮丽，表皮为白色着粉红、籽粒较大，晶莹似宝石，因此也常被作为供果。', '云南蒙自', '[\"https://cwimg.szxjcheng.com/1000017/20208181837/wAdhHkiJ2m.png\", \"https://cwimg.szxjcheng.com/1000017/20208181837/zQWJPP2GEY.png\", \"https://cwimg.szxjcheng.com/1000017/20208181837/nxkXFXWhJz.png\", \"https://cwimg.szxjcheng.com/1000017/20208181837/r5rpiK2DzK.png\", \"https://cwimg.szxjcheng.com/1000017/20208181837/DGibnmWJhR.png\"]', 0, 6, 29.90, '[{\"name\": \"5斤12个\", \"sp_id\": 0, \"stock_num\": 1, \"shop_price\": 29.9, \"input_price\": 21}]', '7天', '2020-08-20 22:18:14', '2020-08-18 00:00:00', '2020-08-20 22:18:14', '2020-08-20 22:18:22', NULL, '2020-08-18 00:00:00');
INSERT INTO `goods` VALUES (86, 0, 315857081238290433, 1000095, '元贝干货', '好东西分享', '潮州', '[\"https://cwimg.szxjcheng.com/1000095/2020819758/wcMrW2az3N.png\"]', 1, 8, 140.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 140, \"input_price\": 130}]', '一年', '2020-08-19 07:58:11', NULL, '2020-08-19 07:58:11', NULL, NULL, '2020-08-21 00:00:00');
INSERT INTO `goods` VALUES (87, 0, 315857431294902274, 1000095, '干虾', '当季【对虾🦐干】\n\n👏🏻 虾控的首选🦐 对虾干，壳薄肉厚，爽脆，鲜甜，满满的肉，夏天来杯啤酒[啤酒] 配虾干，好吃😋', '潮州', '[\"https://cwimg.szxjcheng.com/1000095/202081981/YfcPc3Y344.png\", \"https://cwimg.szxjcheng.com/1000095/202081981/M8bXjhXhz8.png\", \"https://cwimg.szxjcheng.com/1000095/202081981/QBSSpHGzxd.png\", \"https://cwimg.szxjcheng.com/1000095/202081981/6WsXZnbzdR.png\"]', 1, 8, 100.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 10, \"shop_price\": 100, \"input_price\": 90}]', '半年', '2020-08-19 08:01:40', NULL, '2020-08-19 08:01:40', NULL, NULL, '2020-08-21 00:00:00');
INSERT INTO `goods` VALUES (88, 0, 315857912096358401, 1000095, '橄榄菜', '现货，梅菜油香橄榄！一瓶净重2斤装！精选归湖本地上等香橄榄，南姜、梅菜 、食用油、芝麻酱油和少量的糖，精心熬制岀来的油香橄榄，配饭过“杀嘴”[色]。欢迎批发零售🍒🍒', '潮州', '[\"https://cwimg.szxjcheng.com/1000095/202081986/yBT6r4zpn2.png\", \"https://cwimg.szxjcheng.com/1000095/202081986/cCQ42J8z8S.png\", \"https://cwimg.szxjcheng.com/1000095/202081986/ByQhFdHcfJ.png\", \"https://cwimg.szxjcheng.com/1000095/202081986/NC6W45ZWaJ.png\"]', 1, 8, 35.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 35, \"input_price\": 25}]', '', '2020-08-19 08:06:27', NULL, '2020-08-19 08:06:27', NULL, NULL, '2020-08-21 00:00:00');
INSERT INTO `goods` VALUES (89, 0, 316012772913577986, 1000013, '测试', '', '中国', '[\"https://cwimg.szxjcheng.com/1000013/2020820944/KSkBHQbjB4.png\"]', 1, 1, 12.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 12, \"input_price\": 0}]', '', '2020-08-20 09:44:51', NULL, '2020-08-20 09:44:51', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (90, 0, 316013063998275586, 1000013, '1', '', '2', '[\"https://cwimg.szxjcheng.com/1000013/2020820947/mnzAtirm74.png\"]', 1, 1, 2.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 2, \"input_price\": 0}]', '1', '2020-08-20 09:47:44', '2020-08-20 00:00:00', '2020-08-20 09:47:44', NULL, NULL, '2020-08-20 00:00:00');
INSERT INTO `goods` VALUES (91, 0, 316079898638680065, 1000017, '云南蜜橘', '【不是那种打蜡的橘子‼】\n\n云南华宁蜜橘，一箱五斤18-25个左右，甜中带微酸，饱满柔滑，质地脆嫩多汁。特别适合榨汁，香气清爽宜人。今年第一波新鲜橘子，是好久没有吃到的橘子味，不打蜡，不泡药哦！', '云南华宁', '[\"https://cwimg.szxjcheng.com/1000017/20208202051/HHANpmmPfZ.png\", \"https://cwimg.szxjcheng.com/1000017/20208202051/R6TDrS6BAn.png\", \"https://cwimg.szxjcheng.com/1000017/20208202051/4cFRcFyjWH.png\", \"https://cwimg.szxjcheng.com/1000017/20208202051/fRkDwQndzJ.png\"]', 1, 6, 29.00, '[{\"name\": \"5斤装\", \"sp_id\": 0, \"stock_num\": 3, \"shop_price\": 29, \"input_price\": 22.5}]', '7天', '2020-08-20 21:30:12', '2020-08-20 00:00:00', '2020-08-20 21:30:12', NULL, NULL, '2020-08-20 00:00:00');
INSERT INTO `goods` VALUES (92, 0, 316091230540791810, 1000148, '卤豆干', '武冈卤豆干，采用本地上好黄豆制成普通豆干，后经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202244/xGkt6TTxr8.png\", \"https://cwimg.szxjcheng.com/1000148/20208202244/CSWCijzxtF.png\", \"https://cwimg.szxjcheng.com/1000148/20208202244/xxsefTF5i8.png\"]', 1, 8, 5.00, '[{\"name\": \"原味5片\", \"sp_id\": 0, \"stock_num\": 100, \"shop_price\": 5, \"input_price\": 0}, {\"name\": \"原味10片\", \"sp_id\": 1, \"stock_num\": 100, \"shop_price\": 10, \"input_price\": 0}, {\"name\": \"辣味10片\", \"sp_id\": 2, \"stock_num\": 0, \"shop_price\": 10, \"input_price\": 0}, {\"name\": \"辣味切片300克\", \"sp_id\": 3, \"stock_num\": 0, \"shop_price\": 10, \"input_price\": 0}, {\"name\": \"散装500克\", \"sp_id\": 4, \"stock_num\": 0, \"shop_price\": 20, \"input_price\": 0}]', '一个月', '2020-08-20 23:13:28', '2020-08-10 00:00:00', '2020-08-20 23:13:28', NULL, NULL, '2020-08-23 00:00:00');
INSERT INTO `goods` VALUES (93, 0, 316095841775386625, 1000148, '卤牛肉干', '武冈卤牛肉干，采用本地新鲜牛肉经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202330/cQ6J3NnnhJ.png\", \"https://cwimg.szxjcheng.com/1000148/20208202330/xTfinh5wSi.png\", \"https://cwimg.szxjcheng.com/1000148/20208202330/6KwBAfC42C.png\"]', 1, 8, 25.00, '[{\"name\": \"80克\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 25, \"input_price\": 0}]', '一个月', '2020-08-20 23:44:25', '2020-08-16 00:00:00', '2020-08-20 23:44:25', NULL, NULL, '2020-08-25 00:00:00');
INSERT INTO `goods` VALUES (94, 0, 316096318936186881, 1000148, '卤牛肚', '武冈卤牛肚，采用本地新鲜牛肚经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202334/X4ZRbsFMBj.png\"]', 1, 8, 60.00, '[{\"name\": \"250克\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 60, \"input_price\": 0}]', '', '2020-08-20 23:44:09', NULL, '2020-08-20 23:44:09', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (95, 0, 316096663858970625, 1000148, '卤鸭脖', '武冈卤鸭脖，采用本地新鲜鸭脖经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202338/Ez3AmZyxHr.png\", \"https://cwimg.szxjcheng.com/1000148/20208202338/w3an4EphRk.png\"]', 1, 8, 10.00, '[{\"name\": \"一根\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 10, \"input_price\": 0}]', '', '2020-08-20 23:43:43', NULL, '2020-08-20 23:43:43', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (96, 0, 316096753868734466, 1000148, '卤鸭边腿', '武冈卤鸭边腿，采用本地新鲜鸭腿经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202339/SH5yaEe48H.png\"]', 1, 8, 12.00, '[{\"name\": \"1个\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 12, \"input_price\": 0}]', '', '2020-08-20 23:43:23', NULL, '2020-08-20 23:43:23', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (97, 0, 316096900468047873, 1000148, '卤鸭爪', '武冈卤鸭爪，采用本地新鲜鸭爪经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202340/QwST8S35xi.png\"]', 1, 8, 6.00, '[{\"name\": \"2个\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 6, \"input_price\": 0}]', '', '2020-08-20 23:42:48', NULL, '2020-08-20 23:42:48', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (98, 0, 316097083222261762, 1000148, '卤鸡翅', '武冈卤鸡翅，采用本地新鲜鸡翅经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202342/D553nQaxNY.png\", \"https://cwimg.szxjcheng.com/1000148/20208202342/Kwj7hFeTrK.png\"]', 1, 8, 10.00, '[{\"name\": \"1个\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 10, \"input_price\": 0}]', '', '2020-08-20 23:42:24', NULL, '2020-08-20 23:42:24', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (99, 0, 316097733003837442, 1000148, '卤猪血丸子', '武冈卤猪血丸子，采用本地新鲜豆腐、猪肉及猪血混合制成新鲜丸子烘干后经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202348/YYZrkmP5cR.png\", \"https://cwimg.szxjcheng.com/1000148/20208202348/ZtD66dK4Ef.png\"]', 1, 8, 8.00, '[{\"name\": \"1个\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 8, \"input_price\": 0}]', '', '2020-08-20 23:48:51', NULL, '2020-08-20 23:48:51', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (100, 0, 316098037627748354, 1000148, '秘制辣油', '', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/20208202351/ejxhPH4JBH.png\"]', 1, 8, 3.00, '[{\"name\": \"辣油小包\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 3, \"input_price\": 0}, {\"name\": \"秘制辣油500克\", \"sp_id\": 1, \"stock_num\": 0, \"shop_price\": 40, \"input_price\": 0}]', '', '2020-08-20 23:51:52', NULL, '2020-08-20 23:51:52', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (101, 0, 316099162355531777, 1000148, '卤鸡翅', '武冈卤鸡翅，采用本地新鲜鸡翅经特配中药材卤料多次熬制晾干而成，晾干时间足够则劲道十足，库存紧张，日期新鲜。即食食品，无任何防腐剂添加物，保质期较短，熟食请收到后半个月内食用，需放于冰箱中保鲜或冷藏。有指定快递要求的亲请备注或联系卖家并告知，否则由卖家决定，店家建议亲选择顺丰快递，快速又保鲜！本店产品均不包邮，邮费需自理，食品一般情况于下单后3天内发货！', '湖南', '[\"https://cwimg.szxjcheng.com/1000148/202082103/ysN4ZeHjhW.png\"]', 1, 8, 10.00, '[{\"name\": \"1个\", \"sp_id\": 0, \"stock_num\": 0, \"shop_price\": 10, \"input_price\": 0}]', '', '2020-08-21 00:03:03', NULL, '2020-08-21 00:03:03', NULL, NULL, NULL);
INSERT INTO `goods` VALUES (102, 0, 317679076930224130, 1000172, '圣罗兰小金条28#', 'YSL新‮小款‬金条#28\n\n你‮的要‬烂番茄‮到色‬啦☀，涂上简直‮要不‬太显白好吧‼️ 黄皮亲‮，妈‬上嘴秒变白嫩‮子妹‬。👄 血‮番橙‬茄酱，非常‮合适‬春夏，偏红调的浓‮烂郁‬番茄色，‮漉湿‬漉的质感‮爱，‬了❤', '1', '[\"https://cwimg.szxjcheng.com/1000172/20208312138/aTXF4j3ifQ.png\", \"https://cwimg.szxjcheng.com/1000172/20208312142/aapGZzcGkd.png\", \"https://cwimg.szxjcheng.com/1000172/20208312142/dRHQH8kzkN.png\", \"https://cwimg.szxjcheng.com/1000172/20208312142/EiPQdsSBkf.png\"]', 1, 5, 288.00, '[{\"name\": \"\", \"sp_id\": 0, \"stock_num\": 50, \"shop_price\": 288, \"input_price\": 0}]', '', '2020-08-31 21:42:54', NULL, '2020-08-31 21:42:54', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for goods_access_records
-- ----------------------------
DROP TABLE IF EXISTS `goods_access_records`;
CREATE TABLE `goods_access_records`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1647 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_access_records
-- ----------------------------
INSERT INTO `goods_access_records` VALUES (72, 313312545697955841, 1000018, 1000018, '2020-08-01 18:40:40');
INSERT INTO `goods_access_records` VALUES (73, 313312545697955841, 1000018, 1000018, '2020-08-01 18:50:38');
INSERT INTO `goods_access_records` VALUES (74, 313314026622812162, 1000017, 1000018, '2020-08-01 18:57:06');
INSERT INTO `goods_access_records` VALUES (75, 313313473142456322, 1000017, 1000018, '2020-08-01 18:57:18');
INSERT INTO `goods_access_records` VALUES (76, 313314026622812162, 1000017, 1000019, '2020-08-01 18:57:35');
INSERT INTO `goods_access_records` VALUES (79, 313314026622812162, 1000017, 1000001, '2020-08-01 18:58:26');
INSERT INTO `goods_access_records` VALUES (82, 313314764132450306, 1000017, 1000019, '2020-08-01 19:03:08');
INSERT INTO `goods_access_records` VALUES (83, 313314764132450306, 1000017, 1000019, '2020-08-01 19:03:50');
INSERT INTO `goods_access_records` VALUES (84, 313314026622812162, 1000017, 1000008, '2020-08-01 19:10:40');
INSERT INTO `goods_access_records` VALUES (85, 313315386265174018, 1000017, 1000008, '2020-08-01 19:10:47');
INSERT INTO `goods_access_records` VALUES (86, 313314764132450306, 1000017, 1000008, '2020-08-01 19:10:51');
INSERT INTO `goods_access_records` VALUES (87, 313312981200928769, 1000017, 1000008, '2020-08-01 19:10:59');
INSERT INTO `goods_access_records` VALUES (88, 313312981200928769, 1000017, 1000008, '2020-08-01 19:11:07');
INSERT INTO `goods_access_records` VALUES (89, 313311614411472897, 1000017, 1000008, '2020-08-01 19:11:09');
INSERT INTO `goods_access_records` VALUES (90, 313314026622812162, 1000017, 1000008, '2020-08-01 19:11:15');
INSERT INTO `goods_access_records` VALUES (91, 313313473142456322, 1000017, 1000008, '2020-08-01 19:11:17');
INSERT INTO `goods_access_records` VALUES (92, 313315386265174018, 1000017, 1000008, '2020-08-01 19:11:22');
INSERT INTO `goods_access_records` VALUES (93, 313314764132450306, 1000017, 1000008, '2020-08-01 19:11:27');
INSERT INTO `goods_access_records` VALUES (94, 313314026622812162, 1000017, 1000017, '2020-08-01 19:17:47');
INSERT INTO `goods_access_records` VALUES (95, 313315386265174018, 1000017, 1000017, '2020-08-01 19:46:33');
INSERT INTO `goods_access_records` VALUES (97, 313315386265174018, 1000017, 1000017, '2020-08-01 19:49:07');
INSERT INTO `goods_access_records` VALUES (98, 313315386265174018, 1000017, 1000017, '2020-08-01 19:49:12');
INSERT INTO `goods_access_records` VALUES (99, 313314764132450306, 1000017, 1000017, '2020-08-01 19:49:17');
INSERT INTO `goods_access_records` VALUES (100, 313314026622812162, 1000017, 1000017, '2020-08-01 19:49:23');
INSERT INTO `goods_access_records` VALUES (101, 313312545697955841, 1000018, 1000018, '2020-08-01 19:49:31');
INSERT INTO `goods_access_records` VALUES (102, 313312545697955841, 1000018, 1000018, '2020-08-01 19:49:42');
INSERT INTO `goods_access_records` VALUES (103, 313312545697955841, 1000018, 1000018, '2020-08-01 19:50:31');
INSERT INTO `goods_access_records` VALUES (104, 313312545697955841, 1000018, 1000018, '2020-08-01 19:50:53');
INSERT INTO `goods_access_records` VALUES (105, 313312545697955841, 1000018, 1000018, '2020-08-01 19:51:58');
INSERT INTO `goods_access_records` VALUES (106, 313312545697955841, 1000018, 1000018, '2020-08-01 19:52:09');
INSERT INTO `goods_access_records` VALUES (107, 313314026622812162, 1000017, 1000006, '2020-08-01 21:48:10');
INSERT INTO `goods_access_records` VALUES (108, 313312981200928769, 1000017, 1000006, '2020-08-01 21:48:27');
INSERT INTO `goods_access_records` VALUES (109, 313311614411472897, 1000017, 1000006, '2020-08-01 21:48:35');
INSERT INTO `goods_access_records` VALUES (110, 313314026622812162, 1000017, 1000000, '2020-08-02 06:22:17');
INSERT INTO `goods_access_records` VALUES (112, 313315386265174018, 1000017, 1000001, '2020-08-03 11:17:18');
INSERT INTO `goods_access_records` VALUES (120, 313313473142456322, 1000017, 1000017, '2020-08-03 11:27:41');
INSERT INTO `goods_access_records` VALUES (121, 313313473142456322, 1000017, 1000001, '2020-08-03 11:28:04');
INSERT INTO `goods_access_records` VALUES (122, 313315386265174018, 1000017, 1000017, '2020-08-03 11:37:18');
INSERT INTO `goods_access_records` VALUES (123, 313315386265174018, 1000017, 1000017, '2020-08-03 11:37:38');
INSERT INTO `goods_access_records` VALUES (124, 313314764132450306, 1000017, 1000017, '2020-08-03 11:37:42');
INSERT INTO `goods_access_records` VALUES (125, 313314764132450306, 1000017, 1000017, '2020-08-03 11:37:49');
INSERT INTO `goods_access_records` VALUES (126, 313314026622812162, 1000017, 1000017, '2020-08-03 11:37:54');
INSERT INTO `goods_access_records` VALUES (127, 313314026622812162, 1000017, 1000017, '2020-08-03 11:38:03');
INSERT INTO `goods_access_records` VALUES (128, 313313473142456322, 1000017, 1000017, '2020-08-03 11:38:18');
INSERT INTO `goods_access_records` VALUES (129, 313313473142456322, 1000017, 1000017, '2020-08-03 11:38:24');
INSERT INTO `goods_access_records` VALUES (130, 313312981200928769, 1000017, 1000017, '2020-08-03 11:38:30');
INSERT INTO `goods_access_records` VALUES (131, 313315386265174018, 1000017, 1000001, '2020-08-03 11:38:32');
INSERT INTO `goods_access_records` VALUES (132, 313312981200928769, 1000017, 1000017, '2020-08-03 11:38:35');
INSERT INTO `goods_access_records` VALUES (133, 313311614411472897, 1000017, 1000017, '2020-08-03 11:38:41');
INSERT INTO `goods_access_records` VALUES (134, 313313473142456322, 1000017, 1000001, '2020-08-03 11:38:42');
INSERT INTO `goods_access_records` VALUES (135, 313311614411472897, 1000017, 1000017, '2020-08-03 11:38:47');
INSERT INTO `goods_access_records` VALUES (136, 313313473142456322, 1000017, 1000001, '2020-08-03 11:38:51');
INSERT INTO `goods_access_records` VALUES (137, 313315386265174018, 1000017, 1000001, '2020-08-03 11:39:00');
INSERT INTO `goods_access_records` VALUES (139, 313311614411472897, 1000017, 1000017, '2020-08-03 11:39:35');
INSERT INTO `goods_access_records` VALUES (140, 313311614411472897, 1000017, 1000001, '2020-08-03 11:39:40');
INSERT INTO `goods_access_records` VALUES (141, 313311614411472897, 1000017, 1000001, '2020-08-03 11:40:08');
INSERT INTO `goods_access_records` VALUES (142, 313311614411472897, 1000017, 1000001, '2020-08-03 11:40:17');
INSERT INTO `goods_access_records` VALUES (143, 313311614411472897, 1000017, 1000017, '2020-08-03 11:40:26');
INSERT INTO `goods_access_records` VALUES (144, 313313473142456322, 1000017, 1000001, '2020-08-03 11:40:27');
INSERT INTO `goods_access_records` VALUES (145, 313313473142456322, 1000017, 1000001, '2020-08-03 11:40:33');
INSERT INTO `goods_access_records` VALUES (146, 313311614411472897, 1000017, 1000017, '2020-08-03 11:40:45');
INSERT INTO `goods_access_records` VALUES (147, 313313473142456322, 1000017, 1000001, '2020-08-03 11:41:00');
INSERT INTO `goods_access_records` VALUES (148, 313311614411472897, 1000017, 1000006, '2020-08-03 11:42:20');
INSERT INTO `goods_access_records` VALUES (149, 313311614411472897, 1000017, 1000006, '2020-08-03 11:42:45');
INSERT INTO `goods_access_records` VALUES (150, 313311614411472897, 1000017, 1000001, '2020-08-03 11:43:05');
INSERT INTO `goods_access_records` VALUES (151, 313313473142456322, 1000017, 1000012, '2020-08-03 11:48:24');
INSERT INTO `goods_access_records` VALUES (152, 313311614411472897, 1000017, 1000006, '2020-08-03 11:48:58');
INSERT INTO `goods_access_records` VALUES (153, 313312981200928769, 1000017, 1000006, '2020-08-03 11:50:35');
INSERT INTO `goods_access_records` VALUES (154, 313313473142456322, 1000017, 1000027, '2020-08-03 12:01:35');
INSERT INTO `goods_access_records` VALUES (155, 313311614411472897, 1000017, 1000006, '2020-08-03 12:02:35');
INSERT INTO `goods_access_records` VALUES (156, 313311614411472897, 1000017, 1000006, '2020-08-03 12:02:50');
INSERT INTO `goods_access_records` VALUES (157, 313311614411472897, 1000017, 1000006, '2020-08-03 12:03:19');
INSERT INTO `goods_access_records` VALUES (160, 313311614411472897, 1000017, 1000006, '2020-08-03 12:09:41');
INSERT INTO `goods_access_records` VALUES (161, 313563438913683457, 1000017, 1000017, '2020-08-03 12:12:57');
INSERT INTO `goods_access_records` VALUES (162, 313311614411472897, 1000017, 1000006, '2020-08-03 12:18:33');
INSERT INTO `goods_access_records` VALUES (166, 313311614411472897, 1000017, 1000006, '2020-08-03 12:28:31');
INSERT INTO `goods_access_records` VALUES (170, 313593227649220610, 1000017, 1000017, '2020-08-03 17:08:54');
INSERT INTO `goods_access_records` VALUES (171, 313593227649220610, 0, 1000017, '2020-08-03 17:09:26');
INSERT INTO `goods_access_records` VALUES (172, 313565493434777601, 0, 1000017, '2020-08-03 17:09:42');
INSERT INTO `goods_access_records` VALUES (173, 313593227649220610, 0, 1000017, '2020-08-03 17:11:08');
INSERT INTO `goods_access_records` VALUES (174, 313593231021441026, 0, 1000017, '2020-08-03 17:11:22');
INSERT INTO `goods_access_records` VALUES (178, 313593227649220610, 1000017, 1000017, '2020-08-03 17:26:31');
INSERT INTO `goods_access_records` VALUES (180, 313593227649220610, 1000017, 1000017, '2020-08-03 17:26:58');
INSERT INTO `goods_access_records` VALUES (181, 313593227649220610, 1000017, 1000017, '2020-08-03 17:27:28');
INSERT INTO `goods_access_records` VALUES (182, 313593231021441026, 1000017, 1000017, '2020-08-03 17:27:32');
INSERT INTO `goods_access_records` VALUES (183, 313595667257753601, 1000017, 1000017, '2020-08-03 17:33:06');
INSERT INTO `goods_access_records` VALUES (184, 313595667257753601, 1000017, 1000017, '2020-08-03 17:33:22');
INSERT INTO `goods_access_records` VALUES (185, 313595667257753601, 1000017, 1000017, '2020-08-03 17:33:57');
INSERT INTO `goods_access_records` VALUES (225, 313593227649220610, 1000017, 1000028, '2020-08-03 20:15:23');
INSERT INTO `goods_access_records` VALUES (226, 313312545697955841, 1000018, 1000018, '2020-08-03 20:25:12');
INSERT INTO `goods_access_records` VALUES (227, 313312545697955841, 1000018, 1000018, '2020-08-03 20:25:25');
INSERT INTO `goods_access_records` VALUES (228, 313312545697955841, 1000018, 1000018, '2020-08-03 20:29:48');
INSERT INTO `goods_access_records` VALUES (229, 313593227649220610, 1000017, 1000019, '2020-08-03 20:30:09');
INSERT INTO `goods_access_records` VALUES (230, 313593227649220610, 1000017, 1000008, '2020-08-03 20:33:38');
INSERT INTO `goods_access_records` VALUES (232, 313312545697955841, 1000018, 1000018, '2020-08-03 20:35:36');
INSERT INTO `goods_access_records` VALUES (233, 313312545697955841, 1000018, 1000029, '2020-08-03 20:35:46');
INSERT INTO `goods_access_records` VALUES (236, 313312545697955841, 1000018, 1000029, '2020-08-03 20:57:16');
INSERT INTO `goods_access_records` VALUES (250, 313593227649220610, 1000017, 1000016, '2020-08-03 22:06:56');
INSERT INTO `goods_access_records` VALUES (251, 313593227649220610, 1000017, 1000017, '2020-08-03 22:07:18');
INSERT INTO `goods_access_records` VALUES (263, 313565493434777601, 1000017, 1000017, '2020-08-04 11:44:57');
INSERT INTO `goods_access_records` VALUES (264, 313565493434777601, 1000017, 1000017, '2020-08-04 11:47:46');
INSERT INTO `goods_access_records` VALUES (265, 313595667257753601, 1000017, 1000017, '2020-08-04 11:47:50');
INSERT INTO `goods_access_records` VALUES (266, 313593227649220610, 1000017, 1000017, '2020-08-04 11:55:16');
INSERT INTO `goods_access_records` VALUES (267, 313593227649220610, 1000017, 1000017, '2020-08-04 11:55:55');
INSERT INTO `goods_access_records` VALUES (268, 313593227649220610, 1000017, 1000017, '2020-08-04 11:59:16');
INSERT INTO `goods_access_records` VALUES (284, 313593227649220610, 1000017, 1000001, '2020-08-04 19:55:25');
INSERT INTO `goods_access_records` VALUES (288, 313755454318575618, 1000013, 1000013, '2020-08-04 20:00:25');
INSERT INTO `goods_access_records` VALUES (300, 313312545697955841, 1000018, 1000018, '2020-08-05 10:14:58');
INSERT INTO `goods_access_records` VALUES (303, 313312545697955841, 1000018, 1000018, '2020-08-05 10:28:59');
INSERT INTO `goods_access_records` VALUES (304, 313312545697955841, 1000018, 1000033, '2020-08-05 10:29:22');
INSERT INTO `goods_access_records` VALUES (305, 313312545697955841, 1000018, 1000033, '2020-08-05 10:29:24');
INSERT INTO `goods_access_records` VALUES (306, 313312545697955841, 1000018, 1000033, '2020-08-05 10:29:33');
INSERT INTO `goods_access_records` VALUES (307, 313312545697955841, 1000018, 1000033, '2020-08-05 10:29:57');
INSERT INTO `goods_access_records` VALUES (322, 313565493434777601, 1000017, 1000017, '2020-08-05 10:44:01');
INSERT INTO `goods_access_records` VALUES (327, 313844337676910593, 1000017, 1000008, '2020-08-05 10:47:07');
INSERT INTO `goods_access_records` VALUES (328, 313565493434777601, 1000017, 1000008, '2020-08-05 10:47:17');
INSERT INTO `goods_access_records` VALUES (334, 313844337676910593, 1000017, 1000017, '2020-08-05 10:50:32');
INSERT INTO `goods_access_records` VALUES (335, 313844337676910593, 1000017, 1000017, '2020-08-05 10:50:47');
INSERT INTO `goods_access_records` VALUES (336, 313844337676910593, 1000017, 1000017, '2020-08-05 10:51:09');
INSERT INTO `goods_access_records` VALUES (338, 313844337676910593, 1000017, 1000017, '2020-08-05 10:51:24');
INSERT INTO `goods_access_records` VALUES (340, 313312545697955841, 1000018, 1000019, '2020-08-05 10:52:43');
INSERT INTO `goods_access_records` VALUES (357, 313755454318575618, 1000013, 1000013, '2020-08-05 11:03:25');
INSERT INTO `goods_access_records` VALUES (360, 313755454318575618, 1000013, 1000013, '2020-08-05 11:41:01');
INSERT INTO `goods_access_records` VALUES (366, 313593227649220610, 1000017, 1000001, '2020-08-05 11:47:24');
INSERT INTO `goods_access_records` VALUES (367, 313565493434777601, 1000017, 1000001, '2020-08-05 11:47:38');
INSERT INTO `goods_access_records` VALUES (369, 313844337676910593, 1000017, 1000001, '2020-08-05 11:47:53');
INSERT INTO `goods_access_records` VALUES (372, 313755454318575618, 1000013, 1000013, '2020-08-05 11:54:58');
INSERT INTO `goods_access_records` VALUES (386, 313755454318575618, 1000013, 1000017, '2020-08-05 13:17:41');
INSERT INTO `goods_access_records` VALUES (387, 313864793062637570, 1000035, 1000035, '2020-08-05 14:06:42');
INSERT INTO `goods_access_records` VALUES (401, 313755454318575618, 1000013, 1000013, '2020-08-05 15:17:41');
INSERT INTO `goods_access_records` VALUES (406, 313755454318575618, 1000013, 1000013, '2020-08-05 16:23:14');
INSERT INTO `goods_access_records` VALUES (466, 313864793062637570, 1000035, 1000035, '2020-08-05 17:38:57');
INSERT INTO `goods_access_records` VALUES (467, 313864793062637570, 1000035, 1000035, '2020-08-05 17:39:07');
INSERT INTO `goods_access_records` VALUES (471, 313864793062637570, 1000035, 1000035, '2020-08-05 17:44:19');
INSERT INTO `goods_access_records` VALUES (483, 313864793062637570, 1000035, 1000035, '2020-08-05 18:00:10');
INSERT INTO `goods_access_records` VALUES (485, 313864793062637570, 1000035, 1000035, '2020-08-05 18:01:50');
INSERT INTO `goods_access_records` VALUES (486, 313864793062637570, 1000035, 1000035, '2020-08-05 18:25:21');
INSERT INTO `goods_access_records` VALUES (487, 313755454318575618, 1000013, 1000013, '2020-08-05 18:28:32');
INSERT INTO `goods_access_records` VALUES (494, 313755454318575618, 1000013, 1000013, '2020-08-05 18:36:05');
INSERT INTO `goods_access_records` VALUES (512, 313755454318575618, 1000013, 1000013, '2020-08-05 19:07:46');
INSERT INTO `goods_access_records` VALUES (526, 313864793062637570, 1000035, 1000035, '2020-08-05 20:06:27');
INSERT INTO `goods_access_records` VALUES (528, 313864793062637570, 1000035, 1000035, '2020-08-05 20:19:15');
INSERT INTO `goods_access_records` VALUES (529, 313864793062637570, 1000035, 1000035, '2020-08-05 21:07:25');
INSERT INTO `goods_access_records` VALUES (530, 313864793062637570, 1000035, 1000001, '2020-08-05 21:07:42');
INSERT INTO `goods_access_records` VALUES (531, 313864793062637570, 1000035, 1000013, '2020-08-05 21:25:56');
INSERT INTO `goods_access_records` VALUES (532, 313755454318575618, 1000013, 1000013, '2020-08-05 21:26:12');
INSERT INTO `goods_access_records` VALUES (533, 313312981200928769, 1000017, 1000035, '2020-08-05 21:43:45');
INSERT INTO `goods_access_records` VALUES (534, 313871434172596226, 1000017, 1000035, '2020-08-05 21:44:18');
INSERT INTO `goods_access_records` VALUES (535, 313871434172596226, 1000017, 1000035, '2020-08-05 21:45:50');
INSERT INTO `goods_access_records` VALUES (536, 313311614411472897, 1000017, 1000035, '2020-08-05 21:45:56');
INSERT INTO `goods_access_records` VALUES (537, 313565493434777601, 1000017, 1000035, '2020-08-05 21:46:02');
INSERT INTO `goods_access_records` VALUES (538, 313864793062637570, 1000035, 1000035, '2020-08-05 21:46:18');
INSERT INTO `goods_access_records` VALUES (539, 313565493434777601, 1000017, 1000035, '2020-08-05 21:46:20');
INSERT INTO `goods_access_records` VALUES (540, 313864793062637570, 1000035, 1000035, '2020-08-05 21:46:23');
INSERT INTO `goods_access_records` VALUES (548, 313312981200928769, 1000017, 1000035, '2020-08-05 21:51:31');
INSERT INTO `goods_access_records` VALUES (549, 313593227649220610, 1000017, 1000035, '2020-08-05 21:51:38');
INSERT INTO `goods_access_records` VALUES (550, 313565493434777601, 1000017, 1000035, '2020-08-05 21:51:56');
INSERT INTO `goods_access_records` VALUES (551, 313593227649220610, 1000017, 1000043, '2020-08-05 22:01:12');
INSERT INTO `goods_access_records` VALUES (552, 313844337676910593, 1000017, 1000035, '2020-08-05 22:01:38');
INSERT INTO `goods_access_records` VALUES (553, 313311614411472897, 1000017, 1000035, '2020-08-05 22:03:11');
INSERT INTO `goods_access_records` VALUES (554, 313593227649220610, 1000017, 1000035, '2020-08-05 22:05:40');
INSERT INTO `goods_access_records` VALUES (555, 313871434172596226, 1000017, 1000018, '2020-08-05 22:06:03');
INSERT INTO `goods_access_records` VALUES (556, 313864793062637570, 1000035, 1000014, '2020-08-05 22:06:29');
INSERT INTO `goods_access_records` VALUES (559, 313565493434777601, 1000017, 1000035, '2020-08-05 22:08:22');
INSERT INTO `goods_access_records` VALUES (561, 313311614411472897, 1000017, 1000035, '2020-08-05 22:08:37');
INSERT INTO `goods_access_records` VALUES (562, 313311614411472897, 1000017, 1000014, '2020-08-05 22:08:53');
INSERT INTO `goods_access_records` VALUES (563, 313871434172596226, 1000017, 1000019, '2020-08-05 22:09:11');
INSERT INTO `goods_access_records` VALUES (564, 313871434172596226, 1000017, 1000017, '2020-08-05 22:09:45');
INSERT INTO `goods_access_records` VALUES (565, 313871434172596226, 1000017, 1000017, '2020-08-05 22:10:48');
INSERT INTO `goods_access_records` VALUES (566, 313311614411472897, 1000017, 1000014, '2020-08-05 22:11:05');
INSERT INTO `goods_access_records` VALUES (567, 313871434172596226, 1000017, 1000001, '2020-08-05 22:11:45');
INSERT INTO `goods_access_records` VALUES (568, 313871434172596226, 1000017, 1000035, '2020-08-05 22:14:59');
INSERT INTO `goods_access_records` VALUES (569, 313844337676910593, 1000017, 1000035, '2020-08-05 22:17:40');
INSERT INTO `goods_access_records` VALUES (570, 313844337676910593, 1000017, 1000042, '2020-08-05 22:18:14');
INSERT INTO `goods_access_records` VALUES (571, 313844337676910593, 1000017, 1000035, '2020-08-05 22:18:34');
INSERT INTO `goods_access_records` VALUES (572, 313854588908208130, 1000017, 1000042, '2020-08-05 22:18:39');
INSERT INTO `goods_access_records` VALUES (573, 313844337676910593, 1000017, 1000039, '2020-08-05 22:19:35');
INSERT INTO `goods_access_records` VALUES (574, 313844337676910593, 1000017, 1000035, '2020-08-05 22:20:46');
INSERT INTO `goods_access_records` VALUES (575, 313844337676910593, 1000017, 1000047, '2020-08-05 22:21:29');
INSERT INTO `goods_access_records` VALUES (576, 313844337676910593, 1000017, 1000039, '2020-08-05 22:21:35');
INSERT INTO `goods_access_records` VALUES (577, 313844337676910593, 1000017, 1000047, '2020-08-05 22:22:06');
INSERT INTO `goods_access_records` VALUES (578, 313871434172596226, 1000017, 1000017, '2020-08-05 22:22:16');
INSERT INTO `goods_access_records` VALUES (579, 313871434172596226, 1000017, 1000017, '2020-08-05 22:23:38');
INSERT INTO `goods_access_records` VALUES (580, 313871434172596226, 1000017, 1000017, '2020-08-05 22:24:02');
INSERT INTO `goods_access_records` VALUES (581, 313755454318575618, 1000013, 1000013, '2020-08-05 22:24:15');
INSERT INTO `goods_access_records` VALUES (582, 313844337676910593, 1000017, 1000047, '2020-08-05 22:25:20');
INSERT INTO `goods_access_records` VALUES (583, 313871434172596226, 1000017, 1000047, '2020-08-05 22:25:49');
INSERT INTO `goods_access_records` VALUES (584, 313871434172596226, 1000017, 1000017, '2020-08-05 22:25:55');
INSERT INTO `goods_access_records` VALUES (585, 313844337676910593, 1000017, 1000047, '2020-08-05 22:25:58');
INSERT INTO `goods_access_records` VALUES (586, 313844337676910593, 1000017, 1000042, '2020-08-05 22:26:37');
INSERT INTO `goods_access_records` VALUES (587, 313871434172596226, 1000017, 1000048, '2020-08-05 22:26:51');
INSERT INTO `goods_access_records` VALUES (588, 313844337676910593, 1000017, 1000047, '2020-08-05 22:26:54');
INSERT INTO `goods_access_records` VALUES (589, 313312981200928769, 1000017, 1000047, '2020-08-05 22:27:00');
INSERT INTO `goods_access_records` VALUES (590, 313565493434777601, 1000017, 1000048, '2020-08-05 22:27:07');
INSERT INTO `goods_access_records` VALUES (591, 313871434172596226, 1000017, 1000043, '2020-08-05 22:28:29');
INSERT INTO `goods_access_records` VALUES (592, 313871434172596226, 1000017, 1000043, '2020-08-05 22:28:42');
INSERT INTO `goods_access_records` VALUES (593, 313844337676910593, 1000017, 1000047, '2020-08-05 22:31:32');
INSERT INTO `goods_access_records` VALUES (594, 313871434172596226, 1000017, 1000043, '2020-08-05 22:32:35');
INSERT INTO `goods_access_records` VALUES (595, 313864793062637570, 1000035, 1000035, '2020-08-05 22:34:06');
INSERT INTO `goods_access_records` VALUES (596, 313844337676910593, 1000017, 1000035, '2020-08-05 22:42:25');
INSERT INTO `goods_access_records` VALUES (597, 313871434172596226, 1000017, 1000049, '2020-08-05 22:46:32');
INSERT INTO `goods_access_records` VALUES (598, 313871434172596226, 1000017, 1000050, '2020-08-05 22:49:44');
INSERT INTO `goods_access_records` VALUES (599, 313565493434777601, 1000017, 1000050, '2020-08-05 22:50:09');
INSERT INTO `goods_access_records` VALUES (600, 313844337676910593, 1000017, 1000035, '2020-08-05 22:50:19');
INSERT INTO `goods_access_records` VALUES (601, 313844337676910593, 1000017, 1000035, '2020-08-05 22:50:47');
INSERT INTO `goods_access_records` VALUES (602, 313871434172596226, 1000017, 1000044, '2020-08-05 22:57:00');
INSERT INTO `goods_access_records` VALUES (603, 313871434172596226, 1000017, 1000051, '2020-08-05 23:00:04');
INSERT INTO `goods_access_records` VALUES (604, 313871434172596226, 1000017, 1000052, '2020-08-05 23:00:18');
INSERT INTO `goods_access_records` VALUES (605, 313871434172596226, 1000017, 1000053, '2020-08-05 23:05:00');
INSERT INTO `goods_access_records` VALUES (606, 313871434172596226, 1000017, 1000027, '2020-08-05 23:17:18');
INSERT INTO `goods_access_records` VALUES (607, 313311614411472897, 1000017, 1000054, '2020-08-05 23:53:17');
INSERT INTO `goods_access_records` VALUES (608, 313755454318575618, 1000013, 1000013, '2020-08-06 07:11:02');
INSERT INTO `goods_access_records` VALUES (609, 313311614411472897, 1000017, 1000040, '2020-08-06 08:13:43');
INSERT INTO `goods_access_records` VALUES (610, 313871434172596226, 1000017, 1000027, '2020-08-06 08:27:42');
INSERT INTO `goods_access_records` VALUES (611, 313871434172596226, 1000017, 1000027, '2020-08-06 08:27:47');
INSERT INTO `goods_access_records` VALUES (612, 313311614411472897, 1000017, 1000056, '2020-08-06 08:30:49');
INSERT INTO `goods_access_records` VALUES (613, 313311614411472897, 1000017, 1000056, '2020-08-06 08:36:30');
INSERT INTO `goods_access_records` VALUES (614, 313311614411472897, 1000017, 1000017, '2020-08-06 08:39:40');
INSERT INTO `goods_access_records` VALUES (615, 313311614411472897, 1000017, 1000017, '2020-08-06 08:40:25');
INSERT INTO `goods_access_records` VALUES (616, 313311614411472897, 1000017, 1000017, '2020-08-06 08:54:53');
INSERT INTO `goods_access_records` VALUES (617, 313311614411472897, 1000017, 1000056, '2020-08-06 08:55:39');
INSERT INTO `goods_access_records` VALUES (619, 313593227649220610, 1000017, 1000001, '2020-08-06 09:01:33');
INSERT INTO `goods_access_records` VALUES (621, 313755454318575618, 1000013, 1000013, '2020-08-06 09:08:10');
INSERT INTO `goods_access_records` VALUES (622, 313311614411472897, 1000017, 1000017, '2020-08-06 09:09:50');
INSERT INTO `goods_access_records` VALUES (623, 313311614411472897, 1000017, 1000013, '2020-08-06 09:10:05');
INSERT INTO `goods_access_records` VALUES (624, 313311614411472897, 1000017, 1000013, '2020-08-06 09:11:01');
INSERT INTO `goods_access_records` VALUES (625, 313311614411472897, 1000017, 1000013, '2020-08-06 09:11:34');
INSERT INTO `goods_access_records` VALUES (626, 313844337676910593, 1000017, 1000013, '2020-08-06 09:11:41');
INSERT INTO `goods_access_records` VALUES (627, 313311614411472897, 1000017, 1000028, '2020-08-06 09:13:35');
INSERT INTO `goods_access_records` VALUES (628, 313311614411472897, 1000017, 1000013, '2020-08-06 09:13:53');
INSERT INTO `goods_access_records` VALUES (629, 313311614411472897, 1000017, 1000028, '2020-08-06 09:15:30');
INSERT INTO `goods_access_records` VALUES (630, 313311614411472897, 1000017, 1000000, '2020-08-06 09:16:28');
INSERT INTO `goods_access_records` VALUES (632, 313311614411472897, 1000017, 1000000, '2020-08-06 09:18:20');
INSERT INTO `goods_access_records` VALUES (633, 313593227649220610, 1000017, 1000000, '2020-08-06 09:18:40');
INSERT INTO `goods_access_records` VALUES (634, 313593227649220610, 1000017, 1000000, '2020-08-06 09:19:01');
INSERT INTO `goods_access_records` VALUES (635, 313311614411472897, 1000017, 1000056, '2020-08-06 09:19:13');
INSERT INTO `goods_access_records` VALUES (636, 313593227649220610, 1000017, 1000000, '2020-08-06 09:19:21');
INSERT INTO `goods_access_records` VALUES (638, 313311614411472897, 1000017, 1000000, '2020-08-06 09:22:04');
INSERT INTO `goods_access_records` VALUES (639, 313871434172596226, 1000017, 1000000, '2020-08-06 09:22:48');
INSERT INTO `goods_access_records` VALUES (640, 313755454318575618, 1000013, 1000013, '2020-08-06 09:24:25');
INSERT INTO `goods_access_records` VALUES (641, 313755454318575618, 1000013, 1000013, '2020-08-06 09:25:54');
INSERT INTO `goods_access_records` VALUES (645, 313311614411472897, 1000017, 1000056, '2020-08-06 09:33:49');
INSERT INTO `goods_access_records` VALUES (646, 313311614411472897, 1000017, 1000056, '2020-08-06 09:34:48');
INSERT INTO `goods_access_records` VALUES (647, 313311614411472897, 1000017, 1000056, '2020-08-06 09:34:58');
INSERT INTO `goods_access_records` VALUES (648, 313755454318575618, 1000013, 1000013, '2020-08-06 09:35:58');
INSERT INTO `goods_access_records` VALUES (649, 313755454318575618, 1000013, 1000013, '2020-08-06 09:36:23');
INSERT INTO `goods_access_records` VALUES (650, 313755454318575618, 1000013, 1000013, '2020-08-06 09:37:17');
INSERT INTO `goods_access_records` VALUES (653, 313983896783945730, 1000035, 1000035, '2020-08-06 09:49:49');
INSERT INTO `goods_access_records` VALUES (654, 313983896783945730, 1000035, 1000035, '2020-08-06 09:49:54');
INSERT INTO `goods_access_records` VALUES (655, 313983896783945730, 1000035, 1000035, '2020-08-06 09:51:00');
INSERT INTO `goods_access_records` VALUES (656, 313983896783945730, 1000035, 1000035, '2020-08-06 09:54:04');
INSERT INTO `goods_access_records` VALUES (657, 313983896783945730, 1000035, 1000035, '2020-08-06 09:54:33');
INSERT INTO `goods_access_records` VALUES (660, 313983896783945730, 1000035, 1000035, '2020-08-06 09:57:29');
INSERT INTO `goods_access_records` VALUES (661, 313983896783945730, 1000035, 1000035, '2020-08-06 09:58:10');
INSERT INTO `goods_access_records` VALUES (662, 313983896783945730, 1000035, 1000035, '2020-08-06 10:04:47');
INSERT INTO `goods_access_records` VALUES (713, 313755454318575618, 1000013, 1000013, '2020-08-06 10:28:16');
INSERT INTO `goods_access_records` VALUES (714, 313755454318575618, 1000013, 1000013, '2020-08-06 11:09:12');
INSERT INTO `goods_access_records` VALUES (721, 313311614411472897, 1000017, 1000056, '2020-08-06 11:37:30');
INSERT INTO `goods_access_records` VALUES (724, 313311614411472897, 1000017, 1000017, '2020-08-06 11:49:17');
INSERT INTO `goods_access_records` VALUES (725, 313311614411472897, 1000017, 1000017, '2020-08-06 11:50:26');
INSERT INTO `goods_access_records` VALUES (726, 313311614411472897, 1000017, 1000017, '2020-08-06 11:50:34');
INSERT INTO `goods_access_records` VALUES (727, 313844337676910593, 1000017, 1000017, '2020-08-06 11:50:58');
INSERT INTO `goods_access_records` VALUES (728, 313844337676910593, 1000017, 1000017, '2020-08-06 11:52:51');
INSERT INTO `goods_access_records` VALUES (729, 313844337676910593, 1000017, 1000017, '2020-08-06 11:53:04');
INSERT INTO `goods_access_records` VALUES (731, 313844337676910593, 1000017, 1000017, '2020-08-06 11:55:33');
INSERT INTO `goods_access_records` VALUES (732, 313844337676910593, 1000017, 1000017, '2020-08-06 11:56:00');
INSERT INTO `goods_access_records` VALUES (734, 313844337676910593, 1000017, 1000017, '2020-08-06 11:56:13');
INSERT INTO `goods_access_records` VALUES (735, 313844337676910593, 1000017, 1000027, '2020-08-06 11:56:36');
INSERT INTO `goods_access_records` VALUES (736, 313844337676910593, 1000017, 1000035, '2020-08-06 11:56:39');
INSERT INTO `goods_access_records` VALUES (738, 313311614411472897, 1000017, 1000062, '2020-08-06 11:57:00');
INSERT INTO `goods_access_records` VALUES (739, 313844337676910593, 1000017, 1000035, '2020-08-06 11:57:05');
INSERT INTO `goods_access_records` VALUES (740, 313565493434777601, 1000017, 1000062, '2020-08-06 11:57:10');
INSERT INTO `goods_access_records` VALUES (744, 313844337676910593, 1000017, 1000001, '2020-08-06 12:00:13');
INSERT INTO `goods_access_records` VALUES (745, 313844337676910593, 1000017, 1000046, '2020-08-06 12:05:48');
INSERT INTO `goods_access_records` VALUES (747, 313844337676910593, 1000017, 1000017, '2020-08-06 12:19:12');
INSERT INTO `goods_access_records` VALUES (748, 313755454318575618, 1000013, 1000013, '2020-08-06 12:19:49');
INSERT INTO `goods_access_records` VALUES (749, 313755454318575618, 1000013, 1000013, '2020-08-06 12:20:58');
INSERT INTO `goods_access_records` VALUES (751, 313844337676910593, 1000017, 1000017, '2020-08-06 12:26:18');
INSERT INTO `goods_access_records` VALUES (752, 313844337676910593, 1000017, 1000017, '2020-08-06 12:26:27');
INSERT INTO `goods_access_records` VALUES (753, 313844337676910593, 1000017, 1000057, '2020-08-06 12:31:10');
INSERT INTO `goods_access_records` VALUES (754, 313312981200928769, 1000017, 1000064, '2020-08-06 12:34:37');
INSERT INTO `goods_access_records` VALUES (755, 313999684966285313, 1000013, 1000013, '2020-08-06 12:35:28');
INSERT INTO `goods_access_records` VALUES (756, 313999684966285313, 1000013, 1000013, '2020-08-06 12:37:04');
INSERT INTO `goods_access_records` VALUES (757, 313999684966285313, 1000013, 1000013, '2020-08-06 12:37:12');
INSERT INTO `goods_access_records` VALUES (758, 313999684966285313, 1000013, 1000013, '2020-08-06 12:37:35');
INSERT INTO `goods_access_records` VALUES (759, 313999684966285313, 1000013, 1000013, '2020-08-06 12:37:45');
INSERT INTO `goods_access_records` VALUES (760, 313999684966285313, 1000013, 1000013, '2020-08-06 12:37:52');
INSERT INTO `goods_access_records` VALUES (761, 313999684966285313, 1000013, 1000013, '2020-08-06 12:38:18');
INSERT INTO `goods_access_records` VALUES (762, 313999684966285313, 1000013, 1000013, '2020-08-06 12:38:26');
INSERT INTO `goods_access_records` VALUES (763, 313999684966285313, 1000013, 1000013, '2020-08-06 12:43:05');
INSERT INTO `goods_access_records` VALUES (764, 313999684966285313, 1000013, 1000065, '2020-08-06 12:43:22');
INSERT INTO `goods_access_records` VALUES (766, 313999684966285313, 1000013, 1000066, '2020-08-06 13:04:32');
INSERT INTO `goods_access_records` VALUES (767, 313999684966285313, 1000013, 1000066, '2020-08-06 13:05:36');
INSERT INTO `goods_access_records` VALUES (774, 313755454318575618, 1000013, 1000069, '2020-08-06 13:24:43');
INSERT INTO `goods_access_records` VALUES (776, 314010741554282497, 1000013, 1000013, '2020-08-06 14:16:35');
INSERT INTO `goods_access_records` VALUES (784, 314010741554282497, 1000013, 1000013, '2020-08-06 14:20:07');
INSERT INTO `goods_access_records` VALUES (785, 314010741554282497, 1000013, 1000069, '2020-08-06 14:21:07');
INSERT INTO `goods_access_records` VALUES (786, 314010741554282497, 1000013, 1000013, '2020-08-06 14:24:54');
INSERT INTO `goods_access_records` VALUES (787, 314010741554282497, 1000013, 1000065, '2020-08-06 14:25:36');
INSERT INTO `goods_access_records` VALUES (788, 314010741554282497, 1000013, 1000069, '2020-08-06 14:28:51');
INSERT INTO `goods_access_records` VALUES (789, 314010741554282497, 1000013, 1000069, '2020-08-06 14:30:23');
INSERT INTO `goods_access_records` VALUES (790, 313999684966285313, 1000013, 1000070, '2020-08-06 14:37:16');
INSERT INTO `goods_access_records` VALUES (791, 314010741554282497, 1000013, 1000070, '2020-08-06 14:37:39');
INSERT INTO `goods_access_records` VALUES (792, 314012992620462082, 1000013, 1000013, '2020-08-06 14:39:56');
INSERT INTO `goods_access_records` VALUES (793, 314012992620462082, 1000013, 1000065, '2020-08-06 14:40:18');
INSERT INTO `goods_access_records` VALUES (794, 314012992620462082, 1000013, 1000070, '2020-08-06 14:40:29');
INSERT INTO `goods_access_records` VALUES (795, 314012992620462082, 1000013, 1000065, '2020-08-06 14:40:35');
INSERT INTO `goods_access_records` VALUES (796, 314012992620462082, 1000013, 1000066, '2020-08-06 14:56:44');
INSERT INTO `goods_access_records` VALUES (797, 313999684966285313, 1000013, 1000013, '2020-08-06 15:09:02');
INSERT INTO `goods_access_records` VALUES (798, 313844337676910593, 1000017, 1000028, '2020-08-06 15:28:49');
INSERT INTO `goods_access_records` VALUES (799, 313844337676910593, 1000017, 1000028, '2020-08-06 15:29:55');
INSERT INTO `goods_access_records` VALUES (800, 313844337676910593, 1000017, 1000028, '2020-08-06 15:30:49');
INSERT INTO `goods_access_records` VALUES (801, 313844337676910593, 1000017, 1000028, '2020-08-06 15:31:57');
INSERT INTO `goods_access_records` VALUES (802, 313844337676910593, 1000017, 1000028, '2020-08-06 15:35:23');
INSERT INTO `goods_access_records` VALUES (803, 313844337676910593, 1000017, 1000028, '2020-08-06 15:35:38');
INSERT INTO `goods_access_records` VALUES (804, 313844337676910593, 1000017, 1000028, '2020-08-06 15:37:07');
INSERT INTO `goods_access_records` VALUES (805, 313311614411472897, 1000017, 1000056, '2020-08-06 15:37:15');
INSERT INTO `goods_access_records` VALUES (806, 313311614411472897, 1000017, 1000056, '2020-08-06 15:38:29');
INSERT INTO `goods_access_records` VALUES (807, 313311614411472897, 1000017, 1000056, '2020-08-06 15:40:07');
INSERT INTO `goods_access_records` VALUES (808, 313844337676910593, 1000017, 1000056, '2020-08-06 15:40:52');
INSERT INTO `goods_access_records` VALUES (809, 313311614411472897, 1000017, 1000056, '2020-08-06 15:40:58');
INSERT INTO `goods_access_records` VALUES (812, 313844337676910593, 1000017, 1000028, '2020-08-06 16:22:56');
INSERT INTO `goods_access_records` VALUES (813, 313311614411472897, 1000017, 1000056, '2020-08-06 16:56:03');
INSERT INTO `goods_access_records` VALUES (814, 313854588908208130, 1000017, 1000056, '2020-08-06 16:59:38');
INSERT INTO `goods_access_records` VALUES (815, 313311614411472897, 1000017, 1000056, '2020-08-06 16:59:57');
INSERT INTO `goods_access_records` VALUES (816, 313844337676910593, 1000017, 1000017, '2020-08-06 17:05:09');
INSERT INTO `goods_access_records` VALUES (817, 313311614411472897, 1000017, 1000017, '2020-08-06 17:05:11');
INSERT INTO `goods_access_records` VALUES (818, 313311614411472897, 1000017, 1000071, '2020-08-06 17:05:34');
INSERT INTO `goods_access_records` VALUES (819, 313311614411472897, 1000017, 1000071, '2020-08-06 17:06:42');
INSERT INTO `goods_access_records` VALUES (820, 313312981200928769, 1000017, 1000001, '2020-08-06 17:08:34');
INSERT INTO `goods_access_records` VALUES (821, 313311614411472897, 1000017, 1000071, '2020-08-06 17:08:49');
INSERT INTO `goods_access_records` VALUES (822, 313854588908208130, 1000017, 1000071, '2020-08-06 17:09:36');
INSERT INTO `goods_access_records` VALUES (823, 313311614411472897, 1000017, 1000071, '2020-08-06 17:19:03');
INSERT INTO `goods_access_records` VALUES (825, 313593227649220610, 1000017, 1000008, '2020-08-06 17:22:14');
INSERT INTO `goods_access_records` VALUES (827, 313593227649220610, 1000017, 1000008, '2020-08-06 17:24:27');
INSERT INTO `goods_access_records` VALUES (828, 313593227649220610, 1000017, 1000008, '2020-08-06 17:24:44');
INSERT INTO `goods_access_records` VALUES (829, 313844337676910593, 1000017, 1000017, '2020-08-06 17:26:26');
INSERT INTO `goods_access_records` VALUES (830, 313593227649220610, 1000017, 1000001, '2020-08-06 17:26:53');
INSERT INTO `goods_access_records` VALUES (831, 313593227649220610, 1000017, 1000008, '2020-08-06 17:27:27');
INSERT INTO `goods_access_records` VALUES (832, 313593227649220610, 1000017, 1000008, '2020-08-06 17:27:56');
INSERT INTO `goods_access_records` VALUES (833, 313844337676910593, 1000017, 1000071, '2020-08-06 17:28:44');
INSERT INTO `goods_access_records` VALUES (834, 313593227649220610, 1000017, 1000008, '2020-08-06 17:29:03');
INSERT INTO `goods_access_records` VALUES (835, 313593227649220610, 1000017, 1000008, '2020-08-06 17:29:35');
INSERT INTO `goods_access_records` VALUES (836, 313311614411472897, 1000017, 1000017, '2020-08-06 17:29:53');
INSERT INTO `goods_access_records` VALUES (837, 313844337676910593, 1000017, 1000071, '2020-08-06 17:29:56');
INSERT INTO `goods_access_records` VALUES (839, 313311614411472897, 1000017, 1000071, '2020-08-06 17:44:41');
INSERT INTO `goods_access_records` VALUES (840, 313311614411472897, 1000017, 1000071, '2020-08-06 17:45:43');
INSERT INTO `goods_access_records` VALUES (843, 313844337676910593, 1000017, 1000040, '2020-08-06 17:49:14');
INSERT INTO `goods_access_records` VALUES (844, 313311614411472897, 1000017, 1000040, '2020-08-06 17:50:52');
INSERT INTO `goods_access_records` VALUES (845, 313311614411472897, 1000017, 1000028, '2020-08-06 17:50:52');
INSERT INTO `goods_access_records` VALUES (847, 313593227649220610, 1000017, 1000001, '2020-08-06 17:53:27');
INSERT INTO `goods_access_records` VALUES (848, 314012992620462082, 1000013, 1000013, '2020-08-06 17:58:58');
INSERT INTO `goods_access_records` VALUES (849, 313844337676910593, 1000017, 1000028, '2020-08-06 18:00:39');
INSERT INTO `goods_access_records` VALUES (850, 313844337676910593, 1000017, 1000028, '2020-08-06 18:01:17');
INSERT INTO `goods_access_records` VALUES (852, 313593227649220610, 1000017, 1000008, '2020-08-06 18:02:07');
INSERT INTO `goods_access_records` VALUES (853, 313565493434777601, 1000017, 1000008, '2020-08-06 18:02:36');
INSERT INTO `goods_access_records` VALUES (854, 313844337676910593, 1000017, 1000028, '2020-08-06 18:04:06');
INSERT INTO `goods_access_records` VALUES (858, 313593227649220610, 1000017, 1000008, '2020-08-06 18:09:23');
INSERT INTO `goods_access_records` VALUES (866, 313593227649220610, 1000017, 1000008, '2020-08-06 18:12:06');
INSERT INTO `goods_access_records` VALUES (867, 313593227649220610, 1000017, 1000008, '2020-08-06 18:14:33');
INSERT INTO `goods_access_records` VALUES (868, 313844337676910593, 1000017, 1000013, '2020-08-06 18:19:22');
INSERT INTO `goods_access_records` VALUES (869, 313844337676910593, 1000017, 1000040, '2020-08-06 18:41:04');
INSERT INTO `goods_access_records` VALUES (870, 313854588908208130, 1000017, 1000040, '2020-08-06 18:41:19');
INSERT INTO `goods_access_records` VALUES (871, 313311614411472897, 1000017, 1000040, '2020-08-06 18:41:25');
INSERT INTO `goods_access_records` VALUES (872, 313311614411472897, 1000017, 1000040, '2020-08-06 18:41:28');
INSERT INTO `goods_access_records` VALUES (873, 313844337676910593, 1000017, 1000040, '2020-08-06 18:41:48');
INSERT INTO `goods_access_records` VALUES (874, 313844337676910593, 1000017, 1000040, '2020-08-06 18:42:28');
INSERT INTO `goods_access_records` VALUES (875, 313565493434777601, 1000017, 1000040, '2020-08-06 18:42:32');
INSERT INTO `goods_access_records` VALUES (880, 313844337676910593, 1000017, 1000064, '2020-08-06 19:08:45');
INSERT INTO `goods_access_records` VALUES (881, 313593227649220610, 1000017, 1000064, '2020-08-06 19:09:02');
INSERT INTO `goods_access_records` VALUES (882, 313854588908208130, 1000017, 1000064, '2020-08-06 19:09:28');
INSERT INTO `goods_access_records` VALUES (883, 313983896783945730, 1000035, 1000035, '2020-08-06 19:40:28');
INSERT INTO `goods_access_records` VALUES (884, 314012992620462082, 1000013, 1000013, '2020-08-06 19:44:57');
INSERT INTO `goods_access_records` VALUES (886, 314010741554282497, 1000013, 1000035, '2020-08-06 19:53:48');
INSERT INTO `goods_access_records` VALUES (887, 313999430606913538, 1000013, 1000035, '2020-08-06 19:54:54');
INSERT INTO `goods_access_records` VALUES (894, 313983896783945730, 1000035, 1000035, '2020-08-06 21:27:36');
INSERT INTO `goods_access_records` VALUES (895, 313983896783945730, 1000035, 1000035, '2020-08-06 21:27:48');
INSERT INTO `goods_access_records` VALUES (896, 313983896783945730, 1000035, 1000035, '2020-08-06 21:27:59');
INSERT INTO `goods_access_records` VALUES (897, 313983896783945730, 1000035, 1000035, '2020-08-06 21:28:10');
INSERT INTO `goods_access_records` VALUES (905, 313983896783945730, 1000035, 1000035, '2020-08-06 21:34:24');
INSERT INTO `goods_access_records` VALUES (906, 313983896783945730, 1000035, 1000035, '2020-08-06 21:34:30');
INSERT INTO `goods_access_records` VALUES (907, 313983896783945730, 1000035, 1000035, '2020-08-06 22:45:22');
INSERT INTO `goods_access_records` VALUES (913, 313311614411472897, 1000017, 1000017, '2020-08-07 10:30:01');
INSERT INTO `goods_access_records` VALUES (914, 313311614411472897, 1000017, 1000017, '2020-08-07 10:30:23');
INSERT INTO `goods_access_records` VALUES (915, 313311614411472897, 1000017, 1000035, '2020-08-07 10:30:41');
INSERT INTO `goods_access_records` VALUES (916, 313311614411472897, 1000017, 1000017, '2020-08-07 10:30:54');
INSERT INTO `goods_access_records` VALUES (917, 313311614411472897, 1000017, 1000017, '2020-08-07 10:31:07');
INSERT INTO `goods_access_records` VALUES (918, 313311614411472897, 1000017, 1000017, '2020-08-07 10:31:27');
INSERT INTO `goods_access_records` VALUES (919, 313311614411472897, 1000017, 1000017, '2020-08-07 10:36:15');
INSERT INTO `goods_access_records` VALUES (920, 313311614411472897, 1000017, 1000017, '2020-08-07 10:53:26');
INSERT INTO `goods_access_records` VALUES (921, 313844337676910593, 1000017, 1000076, '2020-08-07 11:28:25');
INSERT INTO `goods_access_records` VALUES (922, 313593227649220610, 1000017, 1000076, '2020-08-07 11:28:31');
INSERT INTO `goods_access_records` VALUES (923, 313844337676910593, 1000017, 1000076, '2020-08-07 11:28:35');
INSERT INTO `goods_access_records` VALUES (924, 313844337676910593, 1000017, 1000074, '2020-08-07 11:43:59');
INSERT INTO `goods_access_records` VALUES (925, 313844337676910593, 1000017, 1000077, '2020-08-07 11:44:57');
INSERT INTO `goods_access_records` VALUES (926, 313311614411472897, 1000017, 1000077, '2020-08-07 11:45:02');
INSERT INTO `goods_access_records` VALUES (927, 313565493434777601, 1000017, 1000078, '2020-08-07 12:05:28');
INSERT INTO `goods_access_records` VALUES (928, 313311614411472897, 1000017, 1000027, '2020-08-07 12:08:39');
INSERT INTO `goods_access_records` VALUES (929, 314012992620462082, 1000013, 1000013, '2020-08-07 12:41:11');
INSERT INTO `goods_access_records` VALUES (930, 313844337676910593, 1000017, 1000028, '2020-08-07 15:17:24');
INSERT INTO `goods_access_records` VALUES (931, 314012992620462082, 1000013, 1000013, '2020-08-07 15:17:51');
INSERT INTO `goods_access_records` VALUES (932, 313844337676910593, 1000017, 1000028, '2020-08-07 15:18:17');
INSERT INTO `goods_access_records` VALUES (933, 313593227649220610, 1000017, 1000028, '2020-08-07 15:19:04');
INSERT INTO `goods_access_records` VALUES (934, 313844337676910593, 1000017, 1000017, '2020-08-07 15:19:44');
INSERT INTO `goods_access_records` VALUES (936, 313565493434777601, 1000017, 1000028, '2020-08-07 15:32:58');
INSERT INTO `goods_access_records` VALUES (937, 313312981200928769, 1000017, 1000035, '2020-08-07 15:33:28');
INSERT INTO `goods_access_records` VALUES (942, 313311614411472897, 1000017, 1000017, '2020-08-07 17:19:54');
INSERT INTO `goods_access_records` VALUES (943, 314173560056709121, 1000082, 1000083, '2020-08-07 17:35:17');
INSERT INTO `goods_access_records` VALUES (944, 313844337676910593, 1000017, 1000064, '2020-08-07 18:06:49');
INSERT INTO `goods_access_records` VALUES (945, 313844337676910593, 1000017, 1000064, '2020-08-07 18:07:13');
INSERT INTO `goods_access_records` VALUES (946, 314173560056709121, 1000082, 1000082, '2020-08-07 18:39:36');
INSERT INTO `goods_access_records` VALUES (947, 314173560056709121, 1000082, 1000082, '2020-08-07 19:30:55');
INSERT INTO `goods_access_records` VALUES (948, 314173560056709121, 1000082, 1000082, '2020-08-07 19:33:21');
INSERT INTO `goods_access_records` VALUES (949, 313312545697955841, 1000018, 1000018, '2020-08-07 20:10:04');
INSERT INTO `goods_access_records` VALUES (950, 313312545697955841, 1000018, 1000018, '2020-08-07 20:10:07');
INSERT INTO `goods_access_records` VALUES (951, 314197914115112962, 1000084, 1000084, '2020-08-07 21:15:53');
INSERT INTO `goods_access_records` VALUES (952, 314197914115112962, 1000084, 1000084, '2020-08-07 21:15:57');
INSERT INTO `goods_access_records` VALUES (953, 314197914115112962, 1000084, 1000084, '2020-08-07 21:16:05');
INSERT INTO `goods_access_records` VALUES (954, 314197914115112962, 1000084, 1000084, '2020-08-07 21:16:54');
INSERT INTO `goods_access_records` VALUES (955, 314198174128406530, 1000084, 1000084, '2020-08-07 21:19:29');
INSERT INTO `goods_access_records` VALUES (956, 314198174128406530, 1000084, 1000085, '2020-08-07 21:23:10');
INSERT INTO `goods_access_records` VALUES (957, 314198174128406530, 1000084, 1000084, '2020-08-07 21:23:54');
INSERT INTO `goods_access_records` VALUES (958, 313854588908208130, 1000017, 1000012, '2020-08-07 23:05:19');
INSERT INTO `goods_access_records` VALUES (959, 313854588908208130, 1000017, 1000012, '2020-08-07 23:05:38');
INSERT INTO `goods_access_records` VALUES (960, 313313473142456322, 1000017, 1000084, '2020-08-08 00:42:32');
INSERT INTO `goods_access_records` VALUES (961, 313313473142456322, 1000017, 1000084, '2020-08-08 00:42:36');
INSERT INTO `goods_access_records` VALUES (962, 313854588908208130, 1000017, 1000084, '2020-08-08 00:42:42');
INSERT INTO `goods_access_records` VALUES (963, 314012992620462082, 1000013, 1000017, '2020-08-08 07:47:14');
INSERT INTO `goods_access_records` VALUES (964, 313311614411472897, 1000017, 1000013, '2020-08-08 07:53:52');
INSERT INTO `goods_access_records` VALUES (965, 313844337676910593, 1000017, 1000035, '2020-08-08 07:56:23');
INSERT INTO `goods_access_records` VALUES (966, 313844337676910593, 1000017, 1000014, '2020-08-08 07:56:40');
INSERT INTO `goods_access_records` VALUES (967, 313844337676910593, 1000017, 1000014, '2020-08-08 07:56:47');
INSERT INTO `goods_access_records` VALUES (968, 313844337676910593, 1000017, 1000014, '2020-08-08 07:56:56');
INSERT INTO `goods_access_records` VALUES (969, 313844337676910593, 1000017, 1000014, '2020-08-08 07:57:02');
INSERT INTO `goods_access_records` VALUES (970, 313311614411472897, 1000017, 1000014, '2020-08-08 07:59:12');
INSERT INTO `goods_access_records` VALUES (971, 313854588908208130, 1000017, 1000014, '2020-08-08 07:59:26');
INSERT INTO `goods_access_records` VALUES (972, 313593227649220610, 1000017, 1000014, '2020-08-08 07:59:47');
INSERT INTO `goods_access_records` VALUES (973, 313844337676910593, 1000017, 1000035, '2020-08-08 08:01:00');
INSERT INTO `goods_access_records` VALUES (974, 313844337676910593, 1000017, 1000035, '2020-08-08 08:01:46');
INSERT INTO `goods_access_records` VALUES (975, 313854588908208130, 1000017, 1000035, '2020-08-08 08:05:36');
INSERT INTO `goods_access_records` VALUES (976, 314263802805747713, 1000035, 1000035, '2020-08-08 08:10:32');
INSERT INTO `goods_access_records` VALUES (977, 314263802805747713, 1000035, 1000035, '2020-08-08 08:11:10');
INSERT INTO `goods_access_records` VALUES (978, 314263802805747713, 1000035, 1000035, '2020-08-08 08:11:24');
INSERT INTO `goods_access_records` VALUES (979, 313854588908208130, 1000017, 1000035, '2020-08-08 08:11:42');
INSERT INTO `goods_access_records` VALUES (980, 314263802805747713, 1000035, 1000035, '2020-08-08 09:02:50');
INSERT INTO `goods_access_records` VALUES (981, 314269349722456065, 1000035, 1000035, '2020-08-08 09:09:05');
INSERT INTO `goods_access_records` VALUES (982, 314269349722456065, 1000035, 1000035, '2020-08-08 09:09:46');
INSERT INTO `goods_access_records` VALUES (983, 314269349722456065, 1000035, 1000035, '2020-08-08 09:10:17');
INSERT INTO `goods_access_records` VALUES (984, 314269292797362178, 1000035, 1000035, '2020-08-08 09:11:23');
INSERT INTO `goods_access_records` VALUES (985, 314269292797362178, 1000035, 1000035, '2020-08-08 09:12:24');
INSERT INTO `goods_access_records` VALUES (986, 314269202250727426, 1000035, 1000035, '2020-08-08 09:13:19');
INSERT INTO `goods_access_records` VALUES (987, 314269202250727426, 1000035, 1000035, '2020-08-08 09:13:55');
INSERT INTO `goods_access_records` VALUES (988, 314269202250727426, 1000035, 1000035, '2020-08-08 09:14:07');
INSERT INTO `goods_access_records` VALUES (989, 314269202250727426, 1000035, 1000014, '2020-08-08 09:14:17');
INSERT INTO `goods_access_records` VALUES (990, 314269202250727426, 1000035, 1000014, '2020-08-08 09:14:26');
INSERT INTO `goods_access_records` VALUES (991, 314269202250727426, 1000035, 1000014, '2020-08-08 09:14:35');
INSERT INTO `goods_access_records` VALUES (992, 314269292797362178, 1000035, 1000014, '2020-08-08 09:14:42');
INSERT INTO `goods_access_records` VALUES (993, 314269202250727426, 1000035, 1000035, '2020-08-08 09:14:50');
INSERT INTO `goods_access_records` VALUES (994, 314269202250727426, 1000035, 1000014, '2020-08-08 09:22:53');
INSERT INTO `goods_access_records` VALUES (995, 314198174128406530, 1000084, 1000084, '2020-08-08 10:09:18');
INSERT INTO `goods_access_records` VALUES (996, 314198174128406530, 1000084, 1000084, '2020-08-08 10:09:24');
INSERT INTO `goods_access_records` VALUES (997, 314198174128406530, 1000084, 1000084, '2020-08-08 10:09:57');
INSERT INTO `goods_access_records` VALUES (998, 314269292797362178, 1000035, 1000035, '2020-08-08 13:22:14');
INSERT INTO `goods_access_records` VALUES (999, 314269202250727426, 1000035, 1000014, '2020-08-08 14:19:57');
INSERT INTO `goods_access_records` VALUES (1000, 314269292797362178, 1000035, 1000014, '2020-08-08 14:20:01');
INSERT INTO `goods_access_records` VALUES (1001, 314269202250727426, 1000035, 1000014, '2020-08-08 14:20:02');
INSERT INTO `goods_access_records` VALUES (1002, 314269202250727426, 1000035, 1000014, '2020-08-08 14:20:42');
INSERT INTO `goods_access_records` VALUES (1003, 314269292797362178, 1000035, 1000014, '2020-08-08 14:20:54');
INSERT INTO `goods_access_records` VALUES (1004, 314269349722456065, 1000035, 1000014, '2020-08-08 14:21:02');
INSERT INTO `goods_access_records` VALUES (1005, 313854588908208130, 1000017, 1000014, '2020-08-08 14:21:24');
INSERT INTO `goods_access_records` VALUES (1006, 314010741554282497, 1000013, 1000013, '2020-08-08 17:15:07');
INSERT INTO `goods_access_records` VALUES (1007, 313844337676910593, 1000017, 1000079, '2020-08-08 19:35:29');
INSERT INTO `goods_access_records` VALUES (1008, 313311614411472897, 1000017, 1000027, '2020-08-09 13:35:08');
INSERT INTO `goods_access_records` VALUES (1009, 314012992620462082, 1000013, 1000017, '2020-08-09 21:27:54');
INSERT INTO `goods_access_records` VALUES (1010, 313311614411472897, 1000017, 1000035, '2020-08-09 21:55:05');
INSERT INTO `goods_access_records` VALUES (1011, 313311614411472897, 1000017, 1000027, '2020-08-09 22:50:09');
INSERT INTO `goods_access_records` VALUES (1012, 314198174128406530, 1000084, 1000084, '2020-08-10 08:52:56');
INSERT INTO `goods_access_records` VALUES (1013, 313871434172596226, 1000017, 1000017, '2020-08-10 15:53:00');
INSERT INTO `goods_access_records` VALUES (1014, 313871434172596226, 1000017, 1000017, '2020-08-10 15:53:13');
INSERT INTO `goods_access_records` VALUES (1015, 314600264470364161, 1000017, 1000017, '2020-08-10 15:53:17');
INSERT INTO `goods_access_records` VALUES (1016, 314600264470364161, 1000017, 1000017, '2020-08-10 15:53:50');
INSERT INTO `goods_access_records` VALUES (1017, 314600264470364161, 1000017, 1000017, '2020-08-10 16:02:21');
INSERT INTO `goods_access_records` VALUES (1018, 314600264470364161, 1000017, 1000017, '2020-08-10 16:24:08');
INSERT INTO `goods_access_records` VALUES (1019, 314600264470364161, 1000017, 1000001, '2020-08-10 16:24:50');
INSERT INTO `goods_access_records` VALUES (1020, 314600264470364161, 1000017, 1000001, '2020-08-10 16:25:23');
INSERT INTO `goods_access_records` VALUES (1021, 314198174128406530, 1000084, 1000085, '2020-08-10 16:25:32');
INSERT INTO `goods_access_records` VALUES (1022, 314600264470364161, 1000017, 1000017, '2020-08-10 16:25:36');
INSERT INTO `goods_access_records` VALUES (1023, 314600264470364161, 1000017, 1000001, '2020-08-10 16:25:47');
INSERT INTO `goods_access_records` VALUES (1024, 314600264470364161, 1000017, 1000001, '2020-08-10 16:26:50');
INSERT INTO `goods_access_records` VALUES (1025, 314600264470364161, 1000017, 1000075, '2020-08-10 16:26:52');
INSERT INTO `goods_access_records` VALUES (1026, 313311614411472897, 1000017, 1000001, '2020-08-10 16:27:00');
INSERT INTO `goods_access_records` VALUES (1027, 314600264470364161, 1000017, 1000094, '2020-08-10 16:28:48');
INSERT INTO `goods_access_records` VALUES (1028, 314600264470364161, 1000017, 1000017, '2020-08-10 16:29:02');
INSERT INTO `goods_access_records` VALUES (1029, 314600264470364161, 1000017, 1000001, '2020-08-10 16:31:28');
INSERT INTO `goods_access_records` VALUES (1030, 314600264470364161, 1000017, 1000001, '2020-08-10 16:32:37');
INSERT INTO `goods_access_records` VALUES (1031, 314600264470364161, 1000017, 1000017, '2020-08-10 16:33:15');
INSERT INTO `goods_access_records` VALUES (1032, 314600264470364161, 1000017, 1000092, '2020-08-10 16:34:36');
INSERT INTO `goods_access_records` VALUES (1033, 313871434172596226, 1000017, 1000092, '2020-08-10 16:34:42');
INSERT INTO `goods_access_records` VALUES (1034, 313312981200928769, 1000017, 1000092, '2020-08-10 16:34:49');
INSERT INTO `goods_access_records` VALUES (1035, 313844337676910593, 1000017, 1000092, '2020-08-10 16:35:00');
INSERT INTO `goods_access_records` VALUES (1036, 314600264470364161, 1000017, 1000093, '2020-08-10 16:35:18');
INSERT INTO `goods_access_records` VALUES (1037, 314600264470364161, 1000017, 1000093, '2020-08-10 16:35:38');
INSERT INTO `goods_access_records` VALUES (1038, 314600264470364161, 1000017, 1000017, '2020-08-10 16:36:53');
INSERT INTO `goods_access_records` VALUES (1039, 314600264470364161, 1000017, 1000092, '2020-08-10 16:38:02');
INSERT INTO `goods_access_records` VALUES (1040, 313854588908208130, 1000017, 1000092, '2020-08-10 16:38:34');
INSERT INTO `goods_access_records` VALUES (1041, 313871434172596226, 1000017, 1000092, '2020-08-10 16:38:42');
INSERT INTO `goods_access_records` VALUES (1042, 314600264470364161, 1000017, 1000075, '2020-08-10 16:43:07');
INSERT INTO `goods_access_records` VALUES (1043, 314600264470364161, 1000017, 1000075, '2020-08-10 16:44:32');
INSERT INTO `goods_access_records` VALUES (1044, 314600264470364161, 1000017, 1000017, '2020-08-10 16:53:28');
INSERT INTO `goods_access_records` VALUES (1045, 314600264470364161, 1000017, 1000017, '2020-08-10 16:53:44');
INSERT INTO `goods_access_records` VALUES (1046, 314600264470364161, 1000017, 1000017, '2020-08-10 16:55:54');
INSERT INTO `goods_access_records` VALUES (1047, 313871434172596226, 1000017, 1000017, '2020-08-10 16:55:58');
INSERT INTO `goods_access_records` VALUES (1048, 313871434172596226, 1000017, 1000017, '2020-08-10 16:56:09');
INSERT INTO `goods_access_records` VALUES (1049, 314600264470364161, 1000017, 1000017, '2020-08-10 17:11:08');
INSERT INTO `goods_access_records` VALUES (1050, 314600264470364161, 1000017, 1000075, '2020-08-10 17:12:22');
INSERT INTO `goods_access_records` VALUES (1051, 313312981200928769, 1000017, 1000075, '2020-08-10 17:12:41');
INSERT INTO `goods_access_records` VALUES (1052, 314600264470364161, 1000017, 1000075, '2020-08-10 17:15:31');
INSERT INTO `goods_access_records` VALUES (1053, 314600264470364161, 1000017, 1000075, '2020-08-10 17:15:47');
INSERT INTO `goods_access_records` VALUES (1054, 314600264470364161, 1000017, 1000075, '2020-08-10 17:15:55');
INSERT INTO `goods_access_records` VALUES (1055, 313565493434777601, 1000017, 1000075, '2020-08-10 17:16:09');
INSERT INTO `goods_access_records` VALUES (1056, 314600264470364161, 1000017, 1000017, '2020-08-10 17:21:49');
INSERT INTO `goods_access_records` VALUES (1057, 313312981200928769, 1000017, 1000017, '2020-08-10 17:22:08');
INSERT INTO `goods_access_records` VALUES (1058, 314600264470364161, 1000017, 1000075, '2020-08-10 17:22:29');
INSERT INTO `goods_access_records` VALUES (1059, 314600264470364161, 1000017, 1000075, '2020-08-10 17:22:44');
INSERT INTO `goods_access_records` VALUES (1060, 313312981200928769, 1000017, 1000017, '2020-08-10 17:25:09');
INSERT INTO `goods_access_records` VALUES (1061, 313312981200928769, 1000017, 1000017, '2020-08-10 17:25:47');
INSERT INTO `goods_access_records` VALUES (1062, 314600264470364161, 1000017, 1000075, '2020-08-10 17:25:47');
INSERT INTO `goods_access_records` VALUES (1063, 313854588908208130, 1000017, 1000075, '2020-08-10 17:26:07');
INSERT INTO `goods_access_records` VALUES (1064, 314600264470364161, 1000017, 1000054, '2020-08-10 17:55:12');
INSERT INTO `goods_access_records` VALUES (1065, 313871434172596226, 1000017, 1000054, '2020-08-10 17:55:31');
INSERT INTO `goods_access_records` VALUES (1066, 314269349722456065, 1000035, 1000008, '2020-08-10 18:29:33');
INSERT INTO `goods_access_records` VALUES (1067, 314269202250727426, 1000035, 1000008, '2020-08-10 18:29:38');
INSERT INTO `goods_access_records` VALUES (1068, 314269292797362178, 1000035, 1000008, '2020-08-10 18:29:40');
INSERT INTO `goods_access_records` VALUES (1069, 314600264470364161, 1000017, 1000094, '2020-08-10 18:52:21');
INSERT INTO `goods_access_records` VALUES (1070, 313312981200928769, 1000017, 1000017, '2020-08-10 18:58:30');
INSERT INTO `goods_access_records` VALUES (1071, 313593227649220610, 1000017, 1000017, '2020-08-10 18:58:43');
INSERT INTO `goods_access_records` VALUES (1072, 313593227649220610, 1000017, 1000017, '2020-08-10 18:59:39');
INSERT INTO `goods_access_records` VALUES (1073, 314269349722456065, 1000035, 1000035, '2020-08-10 19:03:34');
INSERT INTO `goods_access_records` VALUES (1074, 314600264470364161, 1000017, 1000035, '2020-08-10 19:06:39');
INSERT INTO `goods_access_records` VALUES (1075, 313871434172596226, 1000017, 1000035, '2020-08-10 19:24:22');
INSERT INTO `goods_access_records` VALUES (1076, 313871434172596226, 1000017, 1000095, '2020-08-10 19:26:50');
INSERT INTO `goods_access_records` VALUES (1077, 313871434172596226, 1000017, 1000095, '2020-08-10 19:27:07');
INSERT INTO `goods_access_records` VALUES (1078, 313871434172596226, 1000017, 1000095, '2020-08-10 19:27:14');
INSERT INTO `goods_access_records` VALUES (1079, 314600264470364161, 1000017, 1000054, '2020-08-10 19:28:17');
INSERT INTO `goods_access_records` VALUES (1080, 313871434172596226, 1000017, 1000054, '2020-08-10 19:28:25');
INSERT INTO `goods_access_records` VALUES (1081, 313311614411472897, 1000017, 1000054, '2020-08-10 19:28:28');
INSERT INTO `goods_access_records` VALUES (1082, 313871434172596226, 1000017, 1000054, '2020-08-10 19:28:40');
INSERT INTO `goods_access_records` VALUES (1083, 313871434172596226, 1000017, 1000054, '2020-08-10 19:28:44');
INSERT INTO `goods_access_records` VALUES (1084, 313312981200928769, 1000017, 1000035, '2020-08-10 20:35:17');
INSERT INTO `goods_access_records` VALUES (1085, 314269202250727426, 1000035, 1000035, '2020-08-10 20:37:03');
INSERT INTO `goods_access_records` VALUES (1086, 313565493434777601, 1000017, 1000098, '2020-08-10 20:37:21');
INSERT INTO `goods_access_records` VALUES (1087, 313312981200928769, 1000017, 1000098, '2020-08-10 20:37:34');
INSERT INTO `goods_access_records` VALUES (1088, 314600264470364161, 1000017, 1000017, '2020-08-10 20:46:25');
INSERT INTO `goods_access_records` VALUES (1089, 313844337676910593, 1000017, 1000017, '2020-08-10 20:46:34');
INSERT INTO `goods_access_records` VALUES (1090, 314600264470364161, 1000017, 1000017, '2020-08-10 20:50:11');
INSERT INTO `goods_access_records` VALUES (1091, 313999684966285313, 1000013, 1000065, '2020-08-10 21:15:46');
INSERT INTO `goods_access_records` VALUES (1092, 313999684966285313, 1000013, 1000065, '2020-08-10 21:15:56');
INSERT INTO `goods_access_records` VALUES (1093, 313999684966285313, 1000013, 1000065, '2020-08-10 21:17:19');
INSERT INTO `goods_access_records` VALUES (1094, 314012992620462082, 1000013, 1000065, '2020-08-10 21:38:28');
INSERT INTO `goods_access_records` VALUES (1095, 314012992620462082, 1000013, 1000085, '2020-08-10 21:38:50');
INSERT INTO `goods_access_records` VALUES (1096, 314010741554282497, 1000013, 1000099, '2020-08-10 21:47:43');
INSERT INTO `goods_access_records` VALUES (1097, 313999684966285313, 1000013, 1000099, '2020-08-10 21:48:13');
INSERT INTO `goods_access_records` VALUES (1098, 314010741554282497, 1000013, 1000099, '2020-08-10 21:54:50');
INSERT INTO `goods_access_records` VALUES (1099, 314010741554282497, 1000013, 1000099, '2020-08-10 21:56:15');
INSERT INTO `goods_access_records` VALUES (1100, 314637217479786498, 1000099, 1000099, '2020-08-10 22:00:01');
INSERT INTO `goods_access_records` VALUES (1101, 314637217479786498, 1000099, 1000099, '2020-08-10 22:00:30');
INSERT INTO `goods_access_records` VALUES (1102, 314637217479786498, 1000099, 1000099, '2020-08-10 22:00:39');
INSERT INTO `goods_access_records` VALUES (1103, 314637217479786498, 1000099, 1000099, '2020-08-10 22:01:07');
INSERT INTO `goods_access_records` VALUES (1104, 314637217479786498, 1000099, 1000099, '2020-08-10 22:01:43');
INSERT INTO `goods_access_records` VALUES (1105, 314637508379934722, 1000065, 1000065, '2020-08-10 22:02:51');
INSERT INTO `goods_access_records` VALUES (1106, 314637508379934722, 1000065, 1000065, '2020-08-10 22:02:58');
INSERT INTO `goods_access_records` VALUES (1107, 314637508379934722, 1000065, 1000065, '2020-08-10 22:03:03');
INSERT INTO `goods_access_records` VALUES (1108, 314637508379934722, 1000065, 1000013, '2020-08-10 22:03:33');
INSERT INTO `goods_access_records` VALUES (1109, 314637508379934722, 1000065, 1000065, '2020-08-10 22:03:35');
INSERT INTO `goods_access_records` VALUES (1110, 314637217479786498, 1000099, 1000013, '2020-08-10 22:05:11');
INSERT INTO `goods_access_records` VALUES (1111, 314637905060429825, 1000065, 1000065, '2020-08-10 22:06:51');
INSERT INTO `goods_access_records` VALUES (1112, 314637508379934722, 1000065, 1000065, '2020-08-10 22:07:01');
INSERT INTO `goods_access_records` VALUES (1113, 314637217479786498, 1000099, 1000099, '2020-08-10 22:09:00');
INSERT INTO `goods_access_records` VALUES (1114, 314637217479786498, 1000099, 1000013, '2020-08-10 22:09:17');
INSERT INTO `goods_access_records` VALUES (1115, 314637217479786498, 1000099, 1000099, '2020-08-10 22:09:34');
INSERT INTO `goods_access_records` VALUES (1116, 314637905060429825, 1000065, 1000065, '2020-08-10 22:09:35');
INSERT INTO `goods_access_records` VALUES (1117, 314637508379934722, 1000065, 1000065, '2020-08-10 22:09:42');
INSERT INTO `goods_access_records` VALUES (1118, 314637217479786498, 1000099, 1000099, '2020-08-10 22:09:54');
INSERT INTO `goods_access_records` VALUES (1119, 314638122577035266, 1000099, 1000099, '2020-08-10 22:09:57');
INSERT INTO `goods_access_records` VALUES (1120, 314637217479786498, 1000099, 1000008, '2020-08-10 22:10:17');
INSERT INTO `goods_access_records` VALUES (1121, 314637217479786498, 1000099, 1000035, '2020-08-10 22:10:40');
INSERT INTO `goods_access_records` VALUES (1122, 314638122577035266, 1000099, 1000035, '2020-08-10 22:10:59');
INSERT INTO `goods_access_records` VALUES (1123, 314637217479786498, 1000099, 1000001, '2020-08-10 22:11:07');
INSERT INTO `goods_access_records` VALUES (1124, 314638384653926401, 1000099, 1000099, '2020-08-10 22:11:35');
INSERT INTO `goods_access_records` VALUES (1125, 314637217479786498, 1000099, 1000001, '2020-08-10 22:11:49');
INSERT INTO `goods_access_records` VALUES (1126, 314637217479786498, 1000099, 1000013, '2020-08-10 22:12:37');
INSERT INTO `goods_access_records` VALUES (1127, 314638384653926401, 1000099, 1000013, '2020-08-10 22:13:00');
INSERT INTO `goods_access_records` VALUES (1128, 314637217479786498, 1000099, 1000017, '2020-08-10 22:18:04');
INSERT INTO `goods_access_records` VALUES (1129, 314638122577035266, 1000099, 1000013, '2020-08-10 22:20:24');
INSERT INTO `goods_access_records` VALUES (1130, 314638384653926401, 1000099, 1000013, '2020-08-10 22:20:27');
INSERT INTO `goods_access_records` VALUES (1131, 314637929504833537, 1000099, 1000013, '2020-08-10 22:20:31');
INSERT INTO `goods_access_records` VALUES (1132, 314600264470364161, 1000017, 1000054, '2020-08-10 22:20:34');
INSERT INTO `goods_access_records` VALUES (1133, 314638384653926401, 1000099, 1000099, '2020-08-10 22:24:38');
INSERT INTO `goods_access_records` VALUES (1134, 314600264470364161, 1000017, 1000054, '2020-08-10 22:25:30');
INSERT INTO `goods_access_records` VALUES (1135, 314637217479786498, 1000099, 1000001, '2020-08-10 22:25:47');
INSERT INTO `goods_access_records` VALUES (1136, 314638122577035266, 1000099, 1000099, '2020-08-10 22:26:21');
INSERT INTO `goods_access_records` VALUES (1137, 314637217479786498, 1000099, 1000001, '2020-08-10 22:26:22');
INSERT INTO `goods_access_records` VALUES (1138, 313999684966285313, 1000013, 1000013, '2020-08-10 22:27:16');
INSERT INTO `goods_access_records` VALUES (1139, 314640016657612801, 1000099, 1000099, '2020-08-10 22:27:48');
INSERT INTO `goods_access_records` VALUES (1140, 313999684966285313, 1000013, 1000099, '2020-08-10 22:28:18');
INSERT INTO `goods_access_records` VALUES (1141, 314638122577035266, 1000099, 1000099, '2020-08-10 22:29:14');
INSERT INTO `goods_access_records` VALUES (1142, 314640016657612801, 1000099, 1000099, '2020-08-10 22:29:17');
INSERT INTO `goods_access_records` VALUES (1143, 314640016657612801, 1000099, 1000099, '2020-08-10 22:30:07');
INSERT INTO `goods_access_records` VALUES (1144, 314637905060429825, 1000065, 1000013, '2020-08-10 22:30:45');
INSERT INTO `goods_access_records` VALUES (1145, 314640016657612801, 1000099, 1000099, '2020-08-10 22:30:49');
INSERT INTO `goods_access_records` VALUES (1146, 314640465548804098, 1000099, 1000099, '2020-08-10 22:32:16');
INSERT INTO `goods_access_records` VALUES (1147, 314640474423951361, 1000099, 1000099, '2020-08-10 22:32:22');
INSERT INTO `goods_access_records` VALUES (1148, 314640016657612801, 1000099, 1000099, '2020-08-10 22:32:30');
INSERT INTO `goods_access_records` VALUES (1149, 314640474423951361, 1000099, 1000099, '2020-08-10 22:32:34');
INSERT INTO `goods_access_records` VALUES (1150, 314637905060429825, 1000065, 1000065, '2020-08-10 22:32:44');
INSERT INTO `goods_access_records` VALUES (1151, 314640016657612801, 1000099, 1000101, '2020-08-10 22:32:46');
INSERT INTO `goods_access_records` VALUES (1152, 314637508379934722, 1000065, 1000065, '2020-08-10 22:32:49');
INSERT INTO `goods_access_records` VALUES (1153, 314637905060429825, 1000065, 1000001, '2020-08-10 22:32:50');
INSERT INTO `goods_access_records` VALUES (1154, 314637905060429825, 1000065, 1000017, '2020-08-10 22:33:04');
INSERT INTO `goods_access_records` VALUES (1155, 314637217479786498, 1000099, 1000017, '2020-08-10 22:33:20');
INSERT INTO `goods_access_records` VALUES (1156, 314637905060429825, 1000065, 1000035, '2020-08-10 22:33:48');
INSERT INTO `goods_access_records` VALUES (1157, 314638122577035266, 1000099, 1000103, '2020-08-10 22:47:28');
INSERT INTO `goods_access_records` VALUES (1158, 314640016657612801, 1000099, 1000103, '2020-08-10 22:48:57');
INSERT INTO `goods_access_records` VALUES (1159, 314638384653926401, 1000099, 1000099, '2020-08-10 23:00:33');
INSERT INTO `goods_access_records` VALUES (1160, 314643413255323650, 1000013, 1000013, '2020-08-10 23:01:34');
INSERT INTO `goods_access_records` VALUES (1161, 314643413255323650, 1000013, 1000103, '2020-08-10 23:01:45');
INSERT INTO `goods_access_records` VALUES (1162, 314643413255323650, 1000013, 1000013, '2020-08-10 23:02:03');
INSERT INTO `goods_access_records` VALUES (1163, 314643413255323650, 1000013, 1000013, '2020-08-10 23:02:17');
INSERT INTO `goods_access_records` VALUES (1164, 314643710799249409, 1000099, 1000099, '2020-08-10 23:04:39');
INSERT INTO `goods_access_records` VALUES (1165, 314643710799249409, 1000099, 1000099, '2020-08-10 23:04:47');
INSERT INTO `goods_access_records` VALUES (1166, 314643751584661506, 1000099, 1000099, '2020-08-10 23:04:53');
INSERT INTO `goods_access_records` VALUES (1167, 314643413255323650, 1000013, 1000103, '2020-08-10 23:07:00');
INSERT INTO `goods_access_records` VALUES (1168, 314012992620462082, 1000013, 1000103, '2020-08-10 23:07:13');
INSERT INTO `goods_access_records` VALUES (1169, 314643413255323650, 1000013, 1000103, '2020-08-10 23:07:21');
INSERT INTO `goods_access_records` VALUES (1170, 314010741554282497, 1000013, 1000103, '2020-08-10 23:07:26');
INSERT INTO `goods_access_records` VALUES (1171, 313999526673252353, 1000013, 1000103, '2020-08-10 23:07:33');
INSERT INTO `goods_access_records` VALUES (1172, 314643413255323650, 1000013, 1000099, '2020-08-10 23:14:57');
INSERT INTO `goods_access_records` VALUES (1173, 314638122577035266, 1000099, 1000099, '2020-08-10 23:17:29');
INSERT INTO `goods_access_records` VALUES (1174, 314640016657612801, 1000099, 1000099, '2020-08-10 23:17:36');
INSERT INTO `goods_access_records` VALUES (1175, 314640016657612801, 1000099, 1000099, '2020-08-10 23:21:11');
INSERT INTO `goods_access_records` VALUES (1176, 314640016657612801, 1000099, 1000103, '2020-08-10 23:22:00');
INSERT INTO `goods_access_records` VALUES (1177, 314640016657612801, 1000099, 1000099, '2020-08-10 23:22:07');
INSERT INTO `goods_access_records` VALUES (1178, 314640016657612801, 1000099, 1000099, '2020-08-10 23:22:38');
INSERT INTO `goods_access_records` VALUES (1179, 314637905060429825, 1000065, 1000001, '2020-08-10 23:35:10');
INSERT INTO `goods_access_records` VALUES (1180, 314637905060429825, 1000065, 1000001, '2020-08-10 23:35:21');
INSERT INTO `goods_access_records` VALUES (1181, 314644409939394562, 1000099, 1000001, '2020-08-10 23:35:57');
INSERT INTO `goods_access_records` VALUES (1182, 314638122577035266, 1000099, 1000001, '2020-08-10 23:36:40');
INSERT INTO `goods_access_records` VALUES (1183, 314637217479786498, 1000099, 1000016, '2020-08-10 23:45:13');
INSERT INTO `goods_access_records` VALUES (1184, 314644409939394562, 1000099, 1000016, '2020-08-10 23:45:32');
INSERT INTO `goods_access_records` VALUES (1185, 314644715687378945, 1000099, 1000016, '2020-08-10 23:45:39');
INSERT INTO `goods_access_records` VALUES (1186, 314644409939394562, 1000099, 1000016, '2020-08-10 23:45:44');
INSERT INTO `goods_access_records` VALUES (1187, 314637905060429825, 1000065, 1000016, '2020-08-10 23:46:49');
INSERT INTO `goods_access_records` VALUES (1188, 314644715687378945, 1000099, 1000016, '2020-08-10 23:48:44');
INSERT INTO `goods_access_records` VALUES (1189, 314643413255323650, 1000013, 1000013, '2020-08-11 01:26:45');
INSERT INTO `goods_access_records` VALUES (1190, 314637217479786498, 1000099, 1000001, '2020-08-11 01:31:34');
INSERT INTO `goods_access_records` VALUES (1191, 314644715687378945, 1000099, 1000001, '2020-08-11 01:31:46');
INSERT INTO `goods_access_records` VALUES (1192, 314644409939394562, 1000099, 1000001, '2020-08-11 01:31:52');
INSERT INTO `goods_access_records` VALUES (1193, 314643710799249409, 1000099, 1000001, '2020-08-11 01:31:56');
INSERT INTO `goods_access_records` VALUES (1194, 314660606193958913, 1000022, 1000022, '2020-08-11 01:53:23');
INSERT INTO `goods_access_records` VALUES (1195, 314661028560371714, 1000022, 1000022, '2020-08-11 01:56:33');
INSERT INTO `goods_access_records` VALUES (1196, 314661028560371714, 1000022, 1000022, '2020-08-11 01:57:05');
INSERT INTO `goods_access_records` VALUES (1197, 314661028560371714, 1000022, 1000022, '2020-08-11 01:57:20');
INSERT INTO `goods_access_records` VALUES (1198, 314660191427624961, 1000022, 1000022, '2020-08-11 01:57:23');
INSERT INTO `goods_access_records` VALUES (1199, 314660191427624961, 1000022, 1000022, '2020-08-11 02:04:42');
INSERT INTO `goods_access_records` VALUES (1200, 314660191427624961, 1000022, 1000075, '2020-08-11 02:13:33');
INSERT INTO `goods_access_records` VALUES (1201, 314660606193958913, 1000022, 1000075, '2020-08-11 02:13:44');
INSERT INTO `goods_access_records` VALUES (1202, 314660191427624961, 1000022, 1000075, '2020-08-11 02:13:52');
INSERT INTO `goods_access_records` VALUES (1203, 314600264470364161, 1000017, 1000075, '2020-08-11 02:15:18');
INSERT INTO `goods_access_records` VALUES (1204, 313844337676910593, 1000017, 1000075, '2020-08-11 02:15:26');
INSERT INTO `goods_access_records` VALUES (1205, 313593227649220610, 1000017, 1000075, '2020-08-11 02:15:39');
INSERT INTO `goods_access_records` VALUES (1206, 313312981200928769, 1000017, 1000075, '2020-08-11 02:16:00');
INSERT INTO `goods_access_records` VALUES (1207, 314600264470364161, 1000017, 1000075, '2020-08-11 02:16:11');
INSERT INTO `goods_access_records` VALUES (1208, 313565493434777601, 1000017, 1000075, '2020-08-11 02:16:23');
INSERT INTO `goods_access_records` VALUES (1209, 314660606193958913, 1000022, 1000075, '2020-08-11 02:16:51');
INSERT INTO `goods_access_records` VALUES (1210, 314600264470364161, 1000017, 1000075, '2020-08-11 02:18:00');
INSERT INTO `goods_access_records` VALUES (1211, 313312981200928769, 1000017, 1000075, '2020-08-11 02:18:07');
INSERT INTO `goods_access_records` VALUES (1212, 313312981200928769, 1000017, 1000075, '2020-08-11 02:18:49');
INSERT INTO `goods_access_records` VALUES (1213, 313844337676910593, 1000017, 1000075, '2020-08-11 02:18:54');
INSERT INTO `goods_access_records` VALUES (1214, 313871434172596226, 1000017, 1000075, '2020-08-11 02:19:08');
INSERT INTO `goods_access_records` VALUES (1215, 314660606193958913, 1000022, 1000022, '2020-08-11 02:27:56');
INSERT INTO `goods_access_records` VALUES (1216, 314600264470364161, 1000017, 1000100, '2020-08-11 07:09:13');
INSERT INTO `goods_access_records` VALUES (1217, 314660191427624961, 1000022, 1000075, '2020-08-11 08:48:20');
INSERT INTO `goods_access_records` VALUES (1218, 314660606193958913, 1000022, 1000075, '2020-08-11 08:48:29');
INSERT INTO `goods_access_records` VALUES (1219, 314660191427624961, 1000022, 1000075, '2020-08-11 08:48:42');
INSERT INTO `goods_access_records` VALUES (1220, 314660606193958913, 1000022, 1000075, '2020-08-11 08:48:52');
INSERT INTO `goods_access_records` VALUES (1221, 314660606193958913, 1000022, 1000075, '2020-08-11 08:49:40');
INSERT INTO `goods_access_records` VALUES (1222, 314637905060429825, 1000065, 1000035, '2020-08-11 09:43:26');
INSERT INTO `goods_access_records` VALUES (1223, 313871434172596226, 1000017, 1000106, '2020-08-11 09:59:38');
INSERT INTO `goods_access_records` VALUES (1224, 313871434172596226, 1000017, 1000106, '2020-08-11 10:00:12');
INSERT INTO `goods_access_records` VALUES (1225, 314710433518845954, 1000106, 1000106, '2020-08-11 10:07:24');
INSERT INTO `goods_access_records` VALUES (1226, 314710433518845954, 1000106, 1000106, '2020-08-11 10:08:12');
INSERT INTO `goods_access_records` VALUES (1227, 314710433518845954, 1000106, 1000106, '2020-08-11 10:08:59');
INSERT INTO `goods_access_records` VALUES (1228, 314710433518845954, 1000106, 1000106, '2020-08-11 10:09:19');
INSERT INTO `goods_access_records` VALUES (1229, 314710433518845954, 1000106, 1000106, '2020-08-11 10:09:49');
INSERT INTO `goods_access_records` VALUES (1230, 314710433518845954, 1000106, 1000106, '2020-08-11 10:10:51');
INSERT INTO `goods_access_records` VALUES (1231, 314710433518845954, 1000106, 1000106, '2020-08-11 10:11:23');
INSERT INTO `goods_access_records` VALUES (1232, 314710433518845954, 1000106, 1000106, '2020-08-11 10:11:38');
INSERT INTO `goods_access_records` VALUES (1233, 314710433518845954, 1000106, 1000107, '2020-08-11 10:13:59');
INSERT INTO `goods_access_records` VALUES (1234, 314710433518845954, 1000106, 1000108, '2020-08-11 10:14:26');
INSERT INTO `goods_access_records` VALUES (1235, 314710433518845954, 1000106, 1000107, '2020-08-11 10:16:24');
INSERT INTO `goods_access_records` VALUES (1236, 314710433518845954, 1000106, 1000109, '2020-08-11 10:17:55');
INSERT INTO `goods_access_records` VALUES (1237, 314710433518845954, 1000106, 1000108, '2020-08-11 10:18:52');
INSERT INTO `goods_access_records` VALUES (1238, 314710433518845954, 1000106, 1000108, '2020-08-11 10:20:30');
INSERT INTO `goods_access_records` VALUES (1239, 314710433518845954, 1000106, 1000108, '2020-08-11 10:20:39');
INSERT INTO `goods_access_records` VALUES (1240, 314710433518845954, 1000106, 1000105, '2020-08-11 10:27:59');
INSERT INTO `goods_access_records` VALUES (1241, 314710433518845954, 1000106, 1000110, '2020-08-11 10:32:57');
INSERT INTO `goods_access_records` VALUES (1242, 314269292797362178, 1000035, 1000035, '2020-08-11 10:34:37');
INSERT INTO `goods_access_records` VALUES (1243, 314710433518845954, 1000106, 1000108, '2020-08-11 10:40:52');
INSERT INTO `goods_access_records` VALUES (1244, 314710433518845954, 1000106, 1000106, '2020-08-11 10:41:02');
INSERT INTO `goods_access_records` VALUES (1245, 314198174128406530, 1000084, 1000084, '2020-08-11 10:45:55');
INSERT INTO `goods_access_records` VALUES (1246, 314643413255323650, 1000013, 1000017, '2020-08-11 10:50:41');
INSERT INTO `goods_access_records` VALUES (1247, 314643413255323650, 1000013, 1000017, '2020-08-11 10:50:47');
INSERT INTO `goods_access_records` VALUES (1248, 313854588908208130, 1000017, 1000035, '2020-08-11 10:51:51');
INSERT INTO `goods_access_records` VALUES (1249, 314012992620462082, 1000013, 1000069, '2020-08-11 11:04:47');
INSERT INTO `goods_access_records` VALUES (1250, 314010741554282497, 1000013, 1000069, '2020-08-11 11:05:26');
INSERT INTO `goods_access_records` VALUES (1251, 313999684966285313, 1000013, 1000069, '2020-08-11 11:05:38');
INSERT INTO `goods_access_records` VALUES (1252, 313999684966285313, 1000013, 1000069, '2020-08-11 11:05:46');
INSERT INTO `goods_access_records` VALUES (1253, 314012992620462082, 1000013, 1000069, '2020-08-11 11:06:16');
INSERT INTO `goods_access_records` VALUES (1254, 314012992620462082, 1000013, 1000069, '2020-08-11 11:06:22');
INSERT INTO `goods_access_records` VALUES (1255, 314012992620462082, 1000013, 1000069, '2020-08-11 11:06:59');
INSERT INTO `goods_access_records` VALUES (1256, 314012992620462082, 1000013, 1000069, '2020-08-11 11:07:15');
INSERT INTO `goods_access_records` VALUES (1257, 314010741554282497, 1000013, 1000069, '2020-08-11 11:12:19');
INSERT INTO `goods_access_records` VALUES (1258, 314600264470364161, 1000017, 1000035, '2020-08-11 11:15:43');
INSERT INTO `goods_access_records` VALUES (1259, 314644149657665538, 1000099, 1000035, '2020-08-11 11:34:04');
INSERT INTO `goods_access_records` VALUES (1260, 314638122577035266, 1000099, 1000035, '2020-08-11 11:36:46');
INSERT INTO `goods_access_records` VALUES (1261, 314640465548804098, 1000099, 1000035, '2020-08-11 11:36:58');
INSERT INTO `goods_access_records` VALUES (1262, 313871434172596226, 1000017, 1000035, '2020-08-11 11:40:51');
INSERT INTO `goods_access_records` VALUES (1263, 314710433518845954, 1000106, 1000105, '2020-08-11 11:48:30');
INSERT INTO `goods_access_records` VALUES (1264, 314710433518845954, 1000106, 1000106, '2020-08-11 11:49:27');
INSERT INTO `goods_access_records` VALUES (1265, 313871434172596226, 1000017, 1000105, '2020-08-11 11:50:40');
INSERT INTO `goods_access_records` VALUES (1266, 314710433518845954, 1000106, 1000113, '2020-08-11 12:04:11');
INSERT INTO `goods_access_records` VALUES (1267, 314710433518845954, 1000106, 1000113, '2020-08-11 12:07:15');
INSERT INTO `goods_access_records` VALUES (1268, 314710433518845954, 1000106, 1000113, '2020-08-11 12:08:19');
INSERT INTO `goods_access_records` VALUES (1269, 314710433518845954, 1000106, 1000113, '2020-08-11 12:09:22');
INSERT INTO `goods_access_records` VALUES (1270, 314710433518845954, 1000106, 1000113, '2020-08-11 12:09:25');
INSERT INTO `goods_access_records` VALUES (1271, 314637929504833537, 1000099, 1000035, '2020-08-11 12:26:39');
INSERT INTO `goods_access_records` VALUES (1272, 314710433518845954, 1000106, 1000105, '2020-08-11 12:26:42');
INSERT INTO `goods_access_records` VALUES (1273, 314640016657612801, 1000099, 1000035, '2020-08-11 12:26:51');
INSERT INTO `goods_access_records` VALUES (1274, 314643413255323650, 1000013, 1000013, '2020-08-11 12:31:10');
INSERT INTO `goods_access_records` VALUES (1275, 314640016657612801, 1000099, 1000115, '2020-08-11 14:08:12');
INSERT INTO `goods_access_records` VALUES (1276, 314600264470364161, 1000017, 1000044, '2020-08-11 14:58:33');
INSERT INTO `goods_access_records` VALUES (1277, 313593227649220610, 1000017, 1000017, '2020-08-11 15:13:31');
INSERT INTO `goods_access_records` VALUES (1278, 313593227649220610, 1000017, 1000017, '2020-08-11 15:13:43');
INSERT INTO `goods_access_records` VALUES (1279, 313593227649220610, 1000017, 1000013, '2020-08-11 15:14:10');
INSERT INTO `goods_access_records` VALUES (1280, 314012992620462082, 1000013, 1000013, '2020-08-11 15:15:11');
INSERT INTO `goods_access_records` VALUES (1281, 314012992620462082, 1000013, 1000013, '2020-08-11 15:15:47');
INSERT INTO `goods_access_records` VALUES (1282, 314012992620462082, 1000013, 1000013, '2020-08-11 15:16:14');
INSERT INTO `goods_access_records` VALUES (1283, 314012992620462082, 1000013, 1000013, '2020-08-11 15:16:16');
INSERT INTO `goods_access_records` VALUES (1284, 314600264470364161, 1000017, 1000013, '2020-08-11 17:28:42');
INSERT INTO `goods_access_records` VALUES (1285, 314600264470364161, 1000017, 1000017, '2020-08-11 17:55:52');
INSERT INTO `goods_access_records` VALUES (1286, 314600264470364161, 1000017, 1000048, '2020-08-11 17:56:15');
INSERT INTO `goods_access_records` VALUES (1287, 314600264470364161, 1000017, 1000071, '2020-08-11 17:56:23');
INSERT INTO `goods_access_records` VALUES (1288, 314600264470364161, 1000017, 1000027, '2020-08-11 17:56:44');
INSERT INTO `goods_access_records` VALUES (1289, 313565493434777601, 1000017, 1000048, '2020-08-11 17:56:44');
INSERT INTO `goods_access_records` VALUES (1290, 314600264470364161, 1000017, 1000017, '2020-08-11 17:58:19');
INSERT INTO `goods_access_records` VALUES (1291, 314600264470364161, 1000017, 1000017, '2020-08-11 17:58:33');
INSERT INTO `goods_access_records` VALUES (1292, 314600264470364161, 1000017, 1000054, '2020-08-11 17:58:51');
INSERT INTO `goods_access_records` VALUES (1293, 314600264470364161, 1000017, 1000116, '2020-08-11 18:00:40');
INSERT INTO `goods_access_records` VALUES (1294, 313844337676910593, 1000017, 1000116, '2020-08-11 18:01:04');
INSERT INTO `goods_access_records` VALUES (1295, 314600264470364161, 1000017, 1000075, '2020-08-11 18:02:38');
INSERT INTO `goods_access_records` VALUES (1296, 313844337676910593, 1000017, 1000013, '2020-08-11 18:06:27');
INSERT INTO `goods_access_records` VALUES (1297, 314012992620462082, 1000013, 1000013, '2020-08-11 18:09:13');
INSERT INTO `goods_access_records` VALUES (1298, 314012992620462082, 1000013, 1000006, '2020-08-11 18:09:25');
INSERT INTO `goods_access_records` VALUES (1299, 314012992620462082, 1000013, 1000001, '2020-08-11 18:12:16');
INSERT INTO `goods_access_records` VALUES (1300, 314012992620462082, 1000013, 1000001, '2020-08-11 18:12:34');
INSERT INTO `goods_access_records` VALUES (1301, 314643413255323650, 1000013, 1000001, '2020-08-11 18:12:45');
INSERT INTO `goods_access_records` VALUES (1302, 314012992620462082, 1000013, 1000008, '2020-08-11 18:19:57');
INSERT INTO `goods_access_records` VALUES (1303, 313999617320550402, 1000013, 1000008, '2020-08-11 18:20:04');
INSERT INTO `goods_access_records` VALUES (1304, 313999684966285313, 1000013, 1000008, '2020-08-11 18:20:05');
INSERT INTO `goods_access_records` VALUES (1305, 313999526673252353, 1000013, 1000008, '2020-08-11 18:20:07');
INSERT INTO `goods_access_records` VALUES (1306, 313999430606913538, 1000013, 1000008, '2020-08-11 18:20:10');
INSERT INTO `goods_access_records` VALUES (1307, 314600264470364161, 1000017, 1000008, '2020-08-11 18:20:34');
INSERT INTO `goods_access_records` VALUES (1308, 313844337676910593, 1000017, 1000008, '2020-08-11 18:20:36');
INSERT INTO `goods_access_records` VALUES (1309, 314710433518845954, 1000106, 1000106, '2020-08-11 18:24:08');
INSERT INTO `goods_access_records` VALUES (1310, 314710433518845954, 1000106, 1000017, '2020-08-11 18:25:10');
INSERT INTO `goods_access_records` VALUES (1311, 314710433518845954, 1000106, 1000017, '2020-08-11 18:25:37');
INSERT INTO `goods_access_records` VALUES (1312, 314760538842202113, 1000017, 1000017, '2020-08-11 18:25:43');
INSERT INTO `goods_access_records` VALUES (1313, 313871434172596226, 1000017, 1000017, '2020-08-11 18:25:52');
INSERT INTO `goods_access_records` VALUES (1314, 314760538842202113, 1000017, 1000106, '2020-08-11 18:26:03');
INSERT INTO `goods_access_records` VALUES (1315, 313871434172596226, 1000017, 1000106, '2020-08-11 18:26:18');
INSERT INTO `goods_access_records` VALUES (1316, 313871434172596226, 1000017, 1000106, '2020-08-11 18:26:27');
INSERT INTO `goods_access_records` VALUES (1317, 314760538842202113, 1000017, 1000017, '2020-08-11 18:28:31');
INSERT INTO `goods_access_records` VALUES (1318, 314760538842202113, 1000017, 1000017, '2020-08-11 18:28:35');
INSERT INTO `goods_access_records` VALUES (1319, 314760538842202113, 1000017, 1000017, '2020-08-11 18:29:15');
INSERT INTO `goods_access_records` VALUES (1320, 314760538842202113, 1000017, 1000017, '2020-08-11 18:29:47');
INSERT INTO `goods_access_records` VALUES (1321, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:20');
INSERT INTO `goods_access_records` VALUES (1322, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:23');
INSERT INTO `goods_access_records` VALUES (1323, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:25');
INSERT INTO `goods_access_records` VALUES (1324, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:27');
INSERT INTO `goods_access_records` VALUES (1325, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:30');
INSERT INTO `goods_access_records` VALUES (1326, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:35');
INSERT INTO `goods_access_records` VALUES (1327, 314198174128406530, 1000084, 1000006, '2020-08-11 18:36:44');
INSERT INTO `goods_access_records` VALUES (1328, 314600264470364161, 1000017, 1000008, '2020-08-11 18:39:36');
INSERT INTO `goods_access_records` VALUES (1329, 314198174128406530, 1000084, 1000006, '2020-08-11 18:41:57');
INSERT INTO `goods_access_records` VALUES (1330, 314012992620462082, 1000013, 1000006, '2020-08-11 18:42:27');
INSERT INTO `goods_access_records` VALUES (1331, 314269292797362178, 1000035, 1000035, '2020-08-11 18:45:01');
INSERT INTO `goods_access_records` VALUES (1332, 314762681712115714, 1000035, 1000035, '2020-08-11 18:46:21');
INSERT INTO `goods_access_records` VALUES (1333, 314762681712115714, 1000035, 1000035, '2020-08-11 18:46:51');
INSERT INTO `goods_access_records` VALUES (1334, 314762681712115714, 1000035, 1000014, '2020-08-11 18:49:12');
INSERT INTO `goods_access_records` VALUES (1335, 314762681712115714, 1000035, 1000035, '2020-08-11 18:50:30');
INSERT INTO `goods_access_records` VALUES (1336, 314198174128406530, 1000084, 1000084, '2020-08-11 18:54:06');
INSERT INTO `goods_access_records` VALUES (1337, 314198174128406530, 1000084, 1000084, '2020-08-11 18:54:17');
INSERT INTO `goods_access_records` VALUES (1338, 313844337676910593, 1000017, 1000035, '2020-08-11 18:54:41');
INSERT INTO `goods_access_records` VALUES (1339, 314760538842202113, 1000017, 1000035, '2020-08-11 18:54:56');
INSERT INTO `goods_access_records` VALUES (1340, 313312981200928769, 1000017, 1000035, '2020-08-11 18:55:17');
INSERT INTO `goods_access_records` VALUES (1341, 313871434172596226, 1000017, 1000035, '2020-08-11 18:55:22');
INSERT INTO `goods_access_records` VALUES (1342, 313593227649220610, 1000017, 1000035, '2020-08-11 18:55:27');
INSERT INTO `goods_access_records` VALUES (1343, 314643959034937345, 1000099, 1000035, '2020-08-11 18:55:54');
INSERT INTO `goods_access_records` VALUES (1344, 314644149657665538, 1000099, 1000035, '2020-08-11 18:55:59');
INSERT INTO `goods_access_records` VALUES (1345, 314643710799249409, 1000099, 1000035, '2020-08-11 18:56:01');
INSERT INTO `goods_access_records` VALUES (1346, 314737497114411010, 1000099, 1000035, '2020-08-11 18:56:37');
INSERT INTO `goods_access_records` VALUES (1347, 314737635660660737, 1000099, 1000035, '2020-08-11 18:56:39');
INSERT INTO `goods_access_records` VALUES (1348, 314644715687378945, 1000099, 1000035, '2020-08-11 18:56:41');
INSERT INTO `goods_access_records` VALUES (1349, 314644329727524865, 1000099, 1000035, '2020-08-11 18:56:44');
INSERT INTO `goods_access_records` VALUES (1350, 314640465548804098, 1000099, 1000035, '2020-08-11 18:56:50');
INSERT INTO `goods_access_records` VALUES (1351, 314640016657612801, 1000099, 1000035, '2020-08-11 18:56:53');
INSERT INTO `goods_access_records` VALUES (1352, 314637217479786498, 1000099, 1000035, '2020-08-11 18:56:56');
INSERT INTO `goods_access_records` VALUES (1353, 314637929504833537, 1000099, 1000035, '2020-08-11 18:57:05');
INSERT INTO `goods_access_records` VALUES (1354, 314637929504833537, 1000099, 1000035, '2020-08-11 18:57:12');
INSERT INTO `goods_access_records` VALUES (1355, 314638122577035266, 1000099, 1000035, '2020-08-11 18:57:20');
INSERT INTO `goods_access_records` VALUES (1356, 314637217479786498, 1000099, 1000035, '2020-08-11 18:57:24');
INSERT INTO `goods_access_records` VALUES (1357, 314640016657612801, 1000099, 1000035, '2020-08-11 18:57:27');
INSERT INTO `goods_access_records` VALUES (1358, 314643710799249409, 1000099, 1000035, '2020-08-11 18:57:28');
INSERT INTO `goods_access_records` VALUES (1359, 314643710799249409, 1000099, 1000035, '2020-08-11 18:57:51');
INSERT INTO `goods_access_records` VALUES (1360, 314644149657665538, 1000099, 1000035, '2020-08-11 18:57:53');
INSERT INTO `goods_access_records` VALUES (1361, 314637217479786498, 1000099, 1000035, '2020-08-11 18:58:01');
INSERT INTO `goods_access_records` VALUES (1362, 314643413255323650, 1000013, 1000001, '2020-08-11 18:58:17');
INSERT INTO `goods_access_records` VALUES (1363, 314737635660660737, 1000099, 1000001, '2020-08-11 19:00:57');
INSERT INTO `goods_access_records` VALUES (1364, 314644149657665538, 1000099, 1000001, '2020-08-11 19:03:23');
INSERT INTO `goods_access_records` VALUES (1365, 314198174128406530, 1000084, 1000085, '2020-08-11 19:06:19');
INSERT INTO `goods_access_records` VALUES (1366, 314198174128406530, 1000084, 1000085, '2020-08-11 19:06:46');
INSERT INTO `goods_access_records` VALUES (1367, 314762681712115714, 1000035, 1000035, '2020-08-11 19:07:52');
INSERT INTO `goods_access_records` VALUES (1368, 314762681712115714, 1000035, 1000035, '2020-08-11 19:10:49');
INSERT INTO `goods_access_records` VALUES (1369, 314762681712115714, 1000035, 1000008, '2020-08-11 19:11:05');
INSERT INTO `goods_access_records` VALUES (1370, 314762681712115714, 1000035, 1000017, '2020-08-11 19:11:24');
INSERT INTO `goods_access_records` VALUES (1371, 314762681712115714, 1000035, 1000001, '2020-08-11 19:12:58');
INSERT INTO `goods_access_records` VALUES (1372, 314600264470364161, 1000017, 1000035, '2020-08-11 19:13:25');
INSERT INTO `goods_access_records` VALUES (1373, 314710433518845954, 1000106, 1000113, '2020-08-11 19:19:15');
INSERT INTO `goods_access_records` VALUES (1374, 314762681712115714, 1000035, 1000035, '2020-08-11 19:20:33');
INSERT INTO `goods_access_records` VALUES (1375, 314762681712115714, 1000035, 1000035, '2020-08-11 19:26:18');
INSERT INTO `goods_access_records` VALUES (1376, 314762681712115714, 1000035, 1000035, '2020-08-11 19:26:42');
INSERT INTO `goods_access_records` VALUES (1377, 314198174128406530, 1000084, 1000084, '2020-08-11 19:27:05');
INSERT INTO `goods_access_records` VALUES (1378, 314762681712115714, 1000035, 1000035, '2020-08-11 19:27:09');
INSERT INTO `goods_access_records` VALUES (1379, 314198174128406530, 1000084, 1000084, '2020-08-11 19:27:50');
INSERT INTO `goods_access_records` VALUES (1380, 314762681712115714, 1000035, 1000035, '2020-08-11 19:29:36');
INSERT INTO `goods_access_records` VALUES (1381, 314762681712115714, 1000035, 1000008, '2020-08-11 19:29:55');
INSERT INTO `goods_access_records` VALUES (1382, 314762681712115714, 1000035, 1000001, '2020-08-11 19:29:56');
INSERT INTO `goods_access_records` VALUES (1383, 314762681712115714, 1000035, 1000008, '2020-08-11 19:30:06');
INSERT INTO `goods_access_records` VALUES (1384, 314762681712115714, 1000035, 1000001, '2020-08-11 19:30:17');
INSERT INTO `goods_access_records` VALUES (1385, 314762681712115714, 1000035, 1000008, '2020-08-11 19:38:10');
INSERT INTO `goods_access_records` VALUES (1386, 314762681712115714, 1000035, 1000006, '2020-08-11 19:40:33');
INSERT INTO `goods_access_records` VALUES (1387, 314198174128406530, 1000084, 1000085, '2020-08-11 20:00:12');
INSERT INTO `goods_access_records` VALUES (1388, 314762681712115714, 1000035, 1000035, '2020-08-11 20:02:53');
INSERT INTO `goods_access_records` VALUES (1389, 313844337676910593, 1000017, 1000035, '2020-08-11 20:11:21');
INSERT INTO `goods_access_records` VALUES (1390, 314762681712115714, 1000035, 1000042, '2020-08-11 20:16:45');
INSERT INTO `goods_access_records` VALUES (1391, 314198174128406530, 1000084, 1000120, '2020-08-11 21:03:18');
INSERT INTO `goods_access_records` VALUES (1392, 314762681712115714, 1000035, 1000035, '2020-08-12 12:17:09');
INSERT INTO `goods_access_records` VALUES (1393, 314198174128406530, 1000084, 1000085, '2020-08-12 13:16:58');
INSERT INTO `goods_access_records` VALUES (1394, 314640465548804098, 1000099, 1000099, '2020-08-12 13:38:56');
INSERT INTO `goods_access_records` VALUES (1395, 314644715687378945, 1000099, 1000133, '2020-08-12 13:53:05');
INSERT INTO `goods_access_records` VALUES (1396, 314644149657665538, 1000099, 1000133, '2020-08-12 13:53:26');
INSERT INTO `goods_access_records` VALUES (1397, 314644329727524865, 1000099, 1000133, '2020-08-12 13:53:33');
INSERT INTO `goods_access_records` VALUES (1398, 314644715687378945, 1000099, 1000134, '2020-08-12 13:55:58');
INSERT INTO `goods_access_records` VALUES (1399, 314644149657665538, 1000099, 1000134, '2020-08-12 13:56:33');
INSERT INTO `goods_access_records` VALUES (1400, 314643959034937345, 1000099, 1000134, '2020-08-12 13:57:15');
INSERT INTO `goods_access_records` VALUES (1401, 314643710799249409, 1000099, 1000134, '2020-08-12 13:57:20');
INSERT INTO `goods_access_records` VALUES (1402, 314643959034937345, 1000099, 1000136, '2020-08-12 14:16:20');
INSERT INTO `goods_access_records` VALUES (1403, 314644149657665538, 1000099, 1000136, '2020-08-12 14:16:26');
INSERT INTO `goods_access_records` VALUES (1404, 314737635660660737, 1000099, 1000136, '2020-08-12 14:16:39');
INSERT INTO `goods_access_records` VALUES (1405, 314661028560371714, 1000022, 1000022, '2020-08-12 15:56:08');
INSERT INTO `goods_access_records` VALUES (1406, 314661028560371714, 1000022, 1000022, '2020-08-12 15:56:25');
INSERT INTO `goods_access_records` VALUES (1407, 314760538842202113, 1000017, 1000017, '2020-08-12 16:09:44');
INSERT INTO `goods_access_records` VALUES (1408, 314762681712115714, 1000035, 1000035, '2020-08-12 16:19:37');
INSERT INTO `goods_access_records` VALUES (1409, 314600264470364161, 1000017, 1000017, '2020-08-12 16:28:24');
INSERT INTO `goods_access_records` VALUES (1410, 314762681712115714, 1000035, 1000008, '2020-08-12 16:48:32');
INSERT INTO `goods_access_records` VALUES (1411, 313844337676910593, 1000017, 1000017, '2020-08-12 16:54:41');
INSERT INTO `goods_access_records` VALUES (1412, 314762681712115714, 1000035, 1000035, '2020-08-12 18:48:12');
INSERT INTO `goods_access_records` VALUES (1413, 314762681712115714, 1000035, 1000035, '2020-08-12 18:48:17');
INSERT INTO `goods_access_records` VALUES (1414, 314762681712115714, 1000035, 1000035, '2020-08-12 18:48:25');
INSERT INTO `goods_access_records` VALUES (1415, 314762681712115714, 1000035, 1000035, '2020-08-12 18:48:28');
INSERT INTO `goods_access_records` VALUES (1416, 314762681712115714, 1000035, 1000035, '2020-08-12 18:48:32');
INSERT INTO `goods_access_records` VALUES (1417, 314644506743930881, 1000099, 1000035, '2020-08-12 19:17:16');
INSERT INTO `goods_access_records` VALUES (1418, 313871434172596226, 1000017, 1000001, '2020-08-12 19:23:09');
INSERT INTO `goods_access_records` VALUES (1419, 314644409939394562, 1000099, 1000001, '2020-08-12 19:23:35');
INSERT INTO `goods_access_records` VALUES (1420, 314640465548804098, 1000099, 1000001, '2020-08-12 19:23:40');
INSERT INTO `goods_access_records` VALUES (1421, 314737635660660737, 1000099, 1000001, '2020-08-12 19:23:49');
INSERT INTO `goods_access_records` VALUES (1422, 314600264470364161, 1000017, 1000017, '2020-08-13 11:22:56');
INSERT INTO `goods_access_records` VALUES (1423, 314600264470364161, 1000017, 1000017, '2020-08-14 09:25:42');
INSERT INTO `goods_access_records` VALUES (1424, 314012992620462082, 1000013, 1000013, '2020-08-14 10:58:35');
INSERT INTO `goods_access_records` VALUES (1425, 314012992620462082, 1000013, 1000013, '2020-08-14 14:29:50');
INSERT INTO `goods_access_records` VALUES (1426, 314012992620462082, 1000013, 1000013, '2020-08-14 17:29:00');
INSERT INTO `goods_access_records` VALUES (1427, 315201545010413570, 1000035, 1000035, '2020-08-14 19:26:22');
INSERT INTO `goods_access_records` VALUES (1428, 315201545010413570, 1000035, 1000035, '2020-08-14 19:26:36');
INSERT INTO `goods_access_records` VALUES (1429, 314710433518845954, 1000106, 1000113, '2020-08-15 14:24:39');
INSERT INTO `goods_access_records` VALUES (1430, 314012992620462082, 1000013, 1000006, '2020-08-17 10:51:38');
INSERT INTO `goods_access_records` VALUES (1431, 314012992620462082, 1000013, 1000013, '2020-08-17 18:34:54');
INSERT INTO `goods_access_records` VALUES (1432, 313999617320550402, 1000013, 1000013, '2020-08-17 18:40:54');
INSERT INTO `goods_access_records` VALUES (1433, 314012992620462082, 1000013, 1000013, '2020-08-18 10:13:11');
INSERT INTO `goods_access_records` VALUES (1434, 314012992620462082, 1000013, 1000013, '2020-08-18 10:13:52');
INSERT INTO `goods_access_records` VALUES (1435, 313999526673252353, 1000013, 1000013, '2020-08-18 10:14:54');
INSERT INTO `goods_access_records` VALUES (1436, 313999617320550402, 1000013, 1000013, '2020-08-18 10:16:52');
INSERT INTO `goods_access_records` VALUES (1437, 314198174128406530, 1000084, 1000084, '2020-08-18 10:18:05');
INSERT INTO `goods_access_records` VALUES (1438, 313999617320550402, 1000013, 1000013, '2020-08-18 10:22:11');
INSERT INTO `goods_access_records` VALUES (1439, 314198174128406530, 1000084, 1000084, '2020-08-18 10:23:00');
INSERT INTO `goods_access_records` VALUES (1440, 314198174128406530, 1000084, 1000084, '2020-08-18 10:23:34');
INSERT INTO `goods_access_records` VALUES (1441, 313999617320550402, 1000013, 1000013, '2020-08-18 10:23:37');
INSERT INTO `goods_access_records` VALUES (1442, 313999617320550402, 1000013, 1000013, '2020-08-18 10:23:56');
INSERT INTO `goods_access_records` VALUES (1443, 313999617320550402, 1000013, 1000013, '2020-08-18 10:32:37');
INSERT INTO `goods_access_records` VALUES (1444, 314198174128406530, 1000084, 1000084, '2020-08-18 10:35:13');
INSERT INTO `goods_access_records` VALUES (1445, 314012992620462082, 1000013, 1000013, '2020-08-18 10:38:07');
INSERT INTO `goods_access_records` VALUES (1446, 314012992620462082, 1000013, 1000013, '2020-08-18 10:39:24');
INSERT INTO `goods_access_records` VALUES (1447, 314012992620462082, 1000013, 1000013, '2020-08-18 10:39:30');
INSERT INTO `goods_access_records` VALUES (1448, 313999430606913538, 1000013, 1000013, '2020-08-18 10:42:51');
INSERT INTO `goods_access_records` VALUES (1449, 314012992620462082, 1000013, 1000013, '2020-08-18 10:44:22');
INSERT INTO `goods_access_records` VALUES (1450, 314012992620462082, 1000013, 1000013, '2020-08-18 10:46:56');
INSERT INTO `goods_access_records` VALUES (1451, 314012992620462082, 1000013, 1000013, '2020-08-18 10:48:17');
INSERT INTO `goods_access_records` VALUES (1452, 314012992620462082, 1000013, 1000013, '2020-08-18 10:50:29');
INSERT INTO `goods_access_records` VALUES (1453, 314643413255323650, 1000013, 1000006, '2020-08-18 10:55:37');
INSERT INTO `goods_access_records` VALUES (1454, 314643413255323650, 1000013, 1000006, '2020-08-18 10:56:13');
INSERT INTO `goods_access_records` VALUES (1455, 313999684966285313, 1000013, 1000006, '2020-08-18 11:01:23');
INSERT INTO `goods_access_records` VALUES (1456, 313755454318575618, 1000013, 1000006, '2020-08-18 11:01:37');
INSERT INTO `goods_access_records` VALUES (1457, 313755454318575618, 1000013, 1000006, '2020-08-18 11:01:41');
INSERT INTO `goods_access_records` VALUES (1458, 314012992620462082, 1000013, 1000006, '2020-08-18 11:02:32');
INSERT INTO `goods_access_records` VALUES (1459, 314643413255323650, 1000013, 1000006, '2020-08-18 11:02:46');
INSERT INTO `goods_access_records` VALUES (1460, 314643413255323650, 1000013, 1000006, '2020-08-18 11:03:49');
INSERT INTO `goods_access_records` VALUES (1461, 313999430606913538, 1000013, 1000013, '2020-08-18 11:20:57');
INSERT INTO `goods_access_records` VALUES (1462, 314012992620462082, 1000013, 1000013, '2020-08-18 11:58:48');
INSERT INTO `goods_access_records` VALUES (1463, 313755454318575618, 1000013, 1000013, '2020-08-18 11:59:11');
INSERT INTO `goods_access_records` VALUES (1464, 313999526673252353, 1000013, 1000146, '2020-08-18 12:00:35');
INSERT INTO `goods_access_records` VALUES (1465, 314643413255323650, 1000013, 1000146, '2020-08-18 12:00:54');
INSERT INTO `goods_access_records` VALUES (1466, 314643413255323650, 1000013, 1000145, '2020-08-18 12:02:23');
INSERT INTO `goods_access_records` VALUES (1467, 313999430606913538, 1000013, 1000145, '2020-08-18 12:02:29');
INSERT INTO `goods_access_records` VALUES (1468, 314643710799249409, 1000099, 1000035, '2020-08-18 14:37:26');
INSERT INTO `goods_access_records` VALUES (1469, 314643413255323650, 1000013, 1000013, '2020-08-18 17:04:34');
INSERT INTO `goods_access_records` VALUES (1470, 314012992620462082, 1000013, 1000013, '2020-08-18 17:05:35');
INSERT INTO `goods_access_records` VALUES (1471, 315769377737670657, 1000017, 1000017, '2020-08-18 17:28:07');
INSERT INTO `goods_access_records` VALUES (1472, 315769377737670657, 1000017, 1000027, '2020-08-18 17:31:10');
INSERT INTO `goods_access_records` VALUES (1473, 315769377737670657, 1000017, 1000017, '2020-08-18 17:34:31');
INSERT INTO `goods_access_records` VALUES (1474, 314760538842202113, 1000017, 1000075, '2020-08-18 17:36:47');
INSERT INTO `goods_access_records` VALUES (1475, 314760538842202113, 1000017, 1000017, '2020-08-18 17:36:48');
INSERT INTO `goods_access_records` VALUES (1476, 314760538842202113, 1000017, 1000075, '2020-08-18 17:36:56');
INSERT INTO `goods_access_records` VALUES (1477, 314760538842202113, 1000017, 1000035, '2020-08-18 17:37:30');
INSERT INTO `goods_access_records` VALUES (1478, 314760538842202113, 1000017, 1000095, '2020-08-18 17:38:32');
INSERT INTO `goods_access_records` VALUES (1479, 315769377737670657, 1000017, 1000147, '2020-08-18 17:48:41');
INSERT INTO `goods_access_records` VALUES (1480, 315769377737670657, 1000017, 1000147, '2020-08-18 17:48:53');
INSERT INTO `goods_access_records` VALUES (1481, 313312981200928769, 1000017, 1000148, '2020-08-18 17:53:40');
INSERT INTO `goods_access_records` VALUES (1482, 314710433518845954, 1000106, 1000017, '2020-08-18 17:59:36');
INSERT INTO `goods_access_records` VALUES (1483, 313311614411472897, 1000017, 1000148, '2020-08-18 18:00:39');
INSERT INTO `goods_access_records` VALUES (1484, 314710433518845954, 1000106, 1000017, '2020-08-18 18:01:11');
INSERT INTO `goods_access_records` VALUES (1485, 314760538842202113, 1000017, 1000017, '2020-08-18 18:03:15');
INSERT INTO `goods_access_records` VALUES (1486, 315769377737670657, 1000017, 1000001, '2020-08-18 18:03:53');
INSERT INTO `goods_access_records` VALUES (1487, 314600264470364161, 1000017, 1000001, '2020-08-18 18:04:18');
INSERT INTO `goods_access_records` VALUES (1488, 313311614411472897, 1000017, 1000149, '2020-08-18 18:07:03');
INSERT INTO `goods_access_records` VALUES (1489, 313311614411472897, 1000017, 1000149, '2020-08-18 18:07:49');
INSERT INTO `goods_access_records` VALUES (1490, 313311614411472897, 1000017, 1000017, '2020-08-18 18:08:08');
INSERT INTO `goods_access_records` VALUES (1491, 315769377737670657, 1000017, 1000000, '2020-08-18 18:09:30');
INSERT INTO `goods_access_records` VALUES (1492, 314760538842202113, 1000017, 1000000, '2020-08-18 18:09:44');
INSERT INTO `goods_access_records` VALUES (1493, 313311614411472897, 1000017, 1000017, '2020-08-18 18:11:02');
INSERT INTO `goods_access_records` VALUES (1494, 313311614411472897, 1000017, 1000048, '2020-08-18 18:14:40');
INSERT INTO `goods_access_records` VALUES (1495, 313565493434777601, 1000017, 1000048, '2020-08-18 18:15:19');
INSERT INTO `goods_access_records` VALUES (1496, 313311614411472897, 1000017, 1000064, '2020-08-18 18:16:14');
INSERT INTO `goods_access_records` VALUES (1497, 315769377737670657, 1000017, 1000016, '2020-08-18 18:16:48');
INSERT INTO `goods_access_records` VALUES (1498, 314760538842202113, 1000017, 1000016, '2020-08-18 18:16:58');
INSERT INTO `goods_access_records` VALUES (1499, 314710433518845954, 1000106, 1000017, '2020-08-18 18:23:22');
INSERT INTO `goods_access_records` VALUES (1500, 314710433518845954, 1000106, 1000106, '2020-08-18 18:23:39');
INSERT INTO `goods_access_records` VALUES (1501, 313844337676910593, 1000017, 1000044, '2020-08-18 18:23:41');
INSERT INTO `goods_access_records` VALUES (1502, 315769377737670657, 1000017, 1000017, '2020-08-18 18:33:24');
INSERT INTO `goods_access_records` VALUES (1503, 315776510302617601, 1000017, 1000017, '2020-08-18 18:38:29');
INSERT INTO `goods_access_records` VALUES (1504, 315776510302617601, 1000017, 1000017, '2020-08-18 18:39:32');
INSERT INTO `goods_access_records` VALUES (1505, 315776510302617601, 1000017, 1000017, '2020-08-18 18:39:47');
INSERT INTO `goods_access_records` VALUES (1506, 314710433518845954, 1000106, 1000106, '2020-08-18 18:43:04');
INSERT INTO `goods_access_records` VALUES (1507, 314710433518845954, 1000106, 1000106, '2020-08-18 18:43:58');
INSERT INTO `goods_access_records` VALUES (1508, 315776510302617601, 1000017, 1000064, '2020-08-18 18:58:54');
INSERT INTO `goods_access_records` VALUES (1509, 315776510302617601, 1000017, 1000064, '2020-08-18 19:03:24');
INSERT INTO `goods_access_records` VALUES (1510, 315776510302617601, 1000017, 1000054, '2020-08-18 19:06:27');
INSERT INTO `goods_access_records` VALUES (1511, 315769377737670657, 1000017, 1000054, '2020-08-18 19:06:47');
INSERT INTO `goods_access_records` VALUES (1512, 314760538842202113, 1000017, 1000054, '2020-08-18 19:06:57');
INSERT INTO `goods_access_records` VALUES (1513, 313311614411472897, 1000017, 1000054, '2020-08-18 19:07:04');
INSERT INTO `goods_access_records` VALUES (1514, 313311614411472897, 1000017, 1000012, '2020-08-18 19:12:55');
INSERT INTO `goods_access_records` VALUES (1515, 313565493434777601, 1000017, 1000012, '2020-08-18 19:13:02');
INSERT INTO `goods_access_records` VALUES (1516, 315776510302617601, 1000017, 1000044, '2020-08-18 19:15:42');
INSERT INTO `goods_access_records` VALUES (1517, 315776510302617601, 1000017, 1000064, '2020-08-18 19:16:46');
INSERT INTO `goods_access_records` VALUES (1518, 315769377737670657, 1000017, 1000064, '2020-08-18 19:17:04');
INSERT INTO `goods_access_records` VALUES (1519, 314760538842202113, 1000017, 1000054, '2020-08-18 19:23:41');
INSERT INTO `goods_access_records` VALUES (1520, 314198174128406530, 1000084, 1000122, '2020-08-18 21:06:19');
INSERT INTO `goods_access_records` VALUES (1521, 314710433518845954, 1000106, 1000106, '2020-08-18 21:10:52');
INSERT INTO `goods_access_records` VALUES (1522, 315857431294902274, 1000095, 1000095, '2020-08-19 08:01:42');
INSERT INTO `goods_access_records` VALUES (1523, 315857912096358401, 1000095, 1000095, '2020-08-19 08:06:29');
INSERT INTO `goods_access_records` VALUES (1524, 315857431294902274, 1000095, 1000095, '2020-08-19 10:32:15');
INSERT INTO `goods_access_records` VALUES (1525, 315857081238290433, 1000095, 1000095, '2020-08-19 10:32:21');
INSERT INTO `goods_access_records` VALUES (1526, 314198174128406530, 1000084, 1000025, '2020-08-19 10:40:10');
INSERT INTO `goods_access_records` VALUES (1527, 314198174128406530, 1000084, 1000025, '2020-08-19 10:40:33');
INSERT INTO `goods_access_records` VALUES (1528, 315776510302617601, 1000017, 1000008, '2020-08-19 10:42:03');
INSERT INTO `goods_access_records` VALUES (1529, 314198174128406530, 1000084, 1000085, '2020-08-19 23:48:28');
INSERT INTO `goods_access_records` VALUES (1530, 315776510302617601, 1000017, 1000154, '2020-08-20 12:06:48');
INSERT INTO `goods_access_records` VALUES (1531, 315857431294902274, 1000095, 1000095, '2020-08-20 13:04:57');
INSERT INTO `goods_access_records` VALUES (1532, 315776510302617601, 1000017, 1000000, '2020-08-20 16:05:28');
INSERT INTO `goods_access_records` VALUES (1533, 315776510302617601, 1000017, 1000000, '2020-08-20 16:06:05');
INSERT INTO `goods_access_records` VALUES (1534, 316013063998275586, 1000013, 1000013, '2020-08-20 17:34:27');
INSERT INTO `goods_access_records` VALUES (1535, 316079898638680065, 1000017, 1000017, '2020-08-20 20:51:43');
INSERT INTO `goods_access_records` VALUES (1536, 316079898638680065, 1000017, 1000017, '2020-08-20 20:51:54');
INSERT INTO `goods_access_records` VALUES (1537, 316079898638680065, 1000017, 1000017, '2020-08-20 20:58:11');
INSERT INTO `goods_access_records` VALUES (1538, 313844337676910593, 1000017, 1000017, '2020-08-20 21:12:07');
INSERT INTO `goods_access_records` VALUES (1539, 316079898638680065, 1000017, 1000017, '2020-08-20 21:13:02');
INSERT INTO `goods_access_records` VALUES (1540, 316079898638680065, 1000017, 1000017, '2020-08-20 21:13:08');
INSERT INTO `goods_access_records` VALUES (1541, 316079898638680065, 1000017, 1000017, '2020-08-20 21:13:20');
INSERT INTO `goods_access_records` VALUES (1542, 313844337676910593, 1000017, 1000022, '2020-08-20 21:14:32');
INSERT INTO `goods_access_records` VALUES (1543, 316079898638680065, 1000017, 1000017, '2020-08-20 21:14:45');
INSERT INTO `goods_access_records` VALUES (1544, 316079898638680065, 1000017, 1000017, '2020-08-20 21:14:59');
INSERT INTO `goods_access_records` VALUES (1545, 316079898638680065, 1000017, 1000013, '2020-08-20 21:15:51');
INSERT INTO `goods_access_records` VALUES (1546, 315776510302617601, 1000017, 1000095, '2020-08-20 21:15:51');
INSERT INTO `goods_access_records` VALUES (1547, 316079898638680065, 1000017, 1000148, '2020-08-20 21:17:58');
INSERT INTO `goods_access_records` VALUES (1548, 316079898638680065, 1000017, 1000035, '2020-08-20 21:18:11');
INSERT INTO `goods_access_records` VALUES (1549, 313844337676910593, 1000017, 1000035, '2020-08-20 21:18:50');
INSERT INTO `goods_access_records` VALUES (1550, 314760538842202113, 1000017, 1000035, '2020-08-20 21:18:57');
INSERT INTO `goods_access_records` VALUES (1551, 316079898638680065, 1000017, 1000148, '2020-08-20 21:19:07');
INSERT INTO `goods_access_records` VALUES (1552, 316079898638680065, 1000017, 1000017, '2020-08-20 21:30:05');
INSERT INTO `goods_access_records` VALUES (1553, 316079898638680065, 1000017, 1000017, '2020-08-20 21:30:12');
INSERT INTO `goods_access_records` VALUES (1554, 316079898638680065, 1000017, 1000057, '2020-08-20 21:47:39');
INSERT INTO `goods_access_records` VALUES (1555, 316079898638680065, 1000017, 1000118, '2020-08-20 22:04:58');
INSERT INTO `goods_access_records` VALUES (1556, 315776510302617601, 1000017, 1000116, '2020-08-20 22:08:52');
INSERT INTO `goods_access_records` VALUES (1557, 316079898638680065, 1000017, 1000116, '2020-08-20 22:08:59');
INSERT INTO `goods_access_records` VALUES (1558, 316079898638680065, 1000017, 1000057, '2020-08-20 22:16:03');
INSERT INTO `goods_access_records` VALUES (1559, 315776510302617601, 1000017, 1000017, '2020-08-20 22:17:56');
INSERT INTO `goods_access_records` VALUES (1560, 315776510302617601, 1000017, 1000017, '2020-08-20 22:18:15');
INSERT INTO `goods_access_records` VALUES (1561, 316079898638680065, 1000017, 1000057, '2020-08-20 22:18:40');
INSERT INTO `goods_access_records` VALUES (1562, 313844337676910593, 1000017, 1000157, '2020-08-20 22:19:01');
INSERT INTO `goods_access_records` VALUES (1563, 314760538842202113, 1000017, 1000154, '2020-08-20 22:20:05');
INSERT INTO `goods_access_records` VALUES (1564, 313311614411472897, 1000017, 1000154, '2020-08-20 22:20:32');
INSERT INTO `goods_access_records` VALUES (1565, 313844337676910593, 1000017, 1000157, '2020-08-20 22:20:45');
INSERT INTO `goods_access_records` VALUES (1566, 314760538842202113, 1000017, 1000154, '2020-08-20 22:20:51');
INSERT INTO `goods_access_records` VALUES (1567, 315769377737670657, 1000017, 1000035, '2020-08-20 22:20:55');
INSERT INTO `goods_access_records` VALUES (1568, 313311614411472897, 1000017, 1000154, '2020-08-20 22:22:19');
INSERT INTO `goods_access_records` VALUES (1569, 316079898638680065, 1000017, 1000057, '2020-08-20 22:23:52');
INSERT INTO `goods_access_records` VALUES (1570, 313565493434777601, 1000017, 1000158, '2020-08-20 22:25:27');
INSERT INTO `goods_access_records` VALUES (1571, 316091230540791810, 1000148, 1000148, '2020-08-20 22:44:17');
INSERT INTO `goods_access_records` VALUES (1572, 316091230540791810, 1000148, 1000148, '2020-08-20 22:45:18');
INSERT INTO `goods_access_records` VALUES (1573, 313311614411472897, 1000017, 1000017, '2020-08-20 22:48:36');
INSERT INTO `goods_access_records` VALUES (1574, 313311614411472897, 1000017, 1000017, '2020-08-20 22:48:48');
INSERT INTO `goods_access_records` VALUES (1575, 313565493434777601, 1000017, 1000017, '2020-08-20 22:48:52');
INSERT INTO `goods_access_records` VALUES (1576, 316079898638680065, 1000017, 1000017, '2020-08-20 22:49:14');
INSERT INTO `goods_access_records` VALUES (1577, 313593227649220610, 1000017, 1000158, '2020-08-20 22:51:18');
INSERT INTO `goods_access_records` VALUES (1578, 313311614411472897, 1000017, 1000158, '2020-08-20 22:51:43');
INSERT INTO `goods_access_records` VALUES (1579, 313311614411472897, 1000017, 1000158, '2020-08-20 22:51:55');
INSERT INTO `goods_access_records` VALUES (1580, 316091230540791810, 1000148, 1000148, '2020-08-20 23:05:23');
INSERT INTO `goods_access_records` VALUES (1581, 316091230540791810, 1000148, 1000148, '2020-08-20 23:06:14');
INSERT INTO `goods_access_records` VALUES (1582, 316091230540791810, 1000148, 1000148, '2020-08-20 23:07:57');
INSERT INTO `goods_access_records` VALUES (1583, 316091230540791810, 1000148, 1000148, '2020-08-20 23:08:21');
INSERT INTO `goods_access_records` VALUES (1584, 316091230540791810, 1000148, 1000148, '2020-08-20 23:08:48');
INSERT INTO `goods_access_records` VALUES (1585, 313854588908208130, 1000017, 1000016, '2020-08-20 23:11:40');
INSERT INTO `goods_access_records` VALUES (1586, 316091230540791810, 1000148, 1000148, '2020-08-20 23:13:08');
INSERT INTO `goods_access_records` VALUES (1587, 316091230540791810, 1000148, 1000148, '2020-08-20 23:13:28');
INSERT INTO `goods_access_records` VALUES (1588, 313854588908208130, 1000017, 1000091, '2020-08-20 23:20:44');
INSERT INTO `goods_access_records` VALUES (1589, 313854588908208130, 1000017, 1000091, '2020-08-20 23:20:56');
INSERT INTO `goods_access_records` VALUES (1590, 316091230540791810, 1000148, 1000148, '2020-08-20 23:30:12');
INSERT INTO `goods_access_records` VALUES (1591, 316096318936186881, 1000148, 1000148, '2020-08-20 23:34:51');
INSERT INTO `goods_access_records` VALUES (1592, 316096900468047873, 1000148, 1000148, '2020-08-20 23:40:40');
INSERT INTO `goods_access_records` VALUES (1593, 316096900468047873, 1000148, 1000148, '2020-08-20 23:42:29');
INSERT INTO `goods_access_records` VALUES (1594, 316096900468047873, 1000148, 1000148, '2020-08-20 23:42:48');
INSERT INTO `goods_access_records` VALUES (1595, 316096753868734466, 1000148, 1000148, '2020-08-20 23:42:53');
INSERT INTO `goods_access_records` VALUES (1596, 316096753868734466, 1000148, 1000148, '2020-08-20 23:43:23');
INSERT INTO `goods_access_records` VALUES (1597, 316096663858970625, 1000148, 1000148, '2020-08-20 23:43:31');
INSERT INTO `goods_access_records` VALUES (1598, 316096663858970625, 1000148, 1000148, '2020-08-20 23:43:44');
INSERT INTO `goods_access_records` VALUES (1599, 316096318936186881, 1000148, 1000148, '2020-08-20 23:43:49');
INSERT INTO `goods_access_records` VALUES (1600, 316096318936186881, 1000148, 1000148, '2020-08-20 23:44:09');
INSERT INTO `goods_access_records` VALUES (1601, 316095841775386625, 1000148, 1000148, '2020-08-20 23:44:15');
INSERT INTO `goods_access_records` VALUES (1602, 316095841775386625, 1000148, 1000148, '2020-08-20 23:44:26');
INSERT INTO `goods_access_records` VALUES (1603, 316091230540791810, 1000148, 1000148, '2020-08-20 23:44:29');
INSERT INTO `goods_access_records` VALUES (1604, 316079898638680065, 1000017, 1000054, '2020-08-20 23:46:07');
INSERT INTO `goods_access_records` VALUES (1605, 316091230540791810, 1000148, 1000148, '2020-08-20 23:48:58');
INSERT INTO `goods_access_records` VALUES (1606, 316097083222261762, 1000148, 1000148, '2020-08-20 23:49:01');
INSERT INTO `goods_access_records` VALUES (1607, 316098037627748354, 1000148, 1000148, '2020-08-20 23:54:56');
INSERT INTO `goods_access_records` VALUES (1608, 316099162355531777, 1000148, 1000159, '2020-08-21 06:24:06');
INSERT INTO `goods_access_records` VALUES (1609, 313844337676910593, 1000017, 1000160, '2020-08-21 08:20:50');
INSERT INTO `goods_access_records` VALUES (1610, 313854588908208130, 1000017, 1000160, '2020-08-21 08:21:15');
INSERT INTO `goods_access_records` VALUES (1611, 314760538842202113, 1000017, 1000054, '2020-08-21 11:34:15');
INSERT INTO `goods_access_records` VALUES (1612, 314760538842202113, 1000017, 1000054, '2020-08-21 11:34:48');
INSERT INTO `goods_access_records` VALUES (1613, 314760538842202113, 1000017, 1000054, '2020-08-21 13:55:36');
INSERT INTO `goods_access_records` VALUES (1614, 314710433518845954, 1000106, 1000017, '2020-08-21 14:18:35');
INSERT INTO `goods_access_records` VALUES (1615, 314710433518845954, 1000106, 1000106, '2020-08-21 20:54:45');
INSERT INTO `goods_access_records` VALUES (1616, 313844337676910593, 1000017, 1000017, '2020-08-22 20:10:14');
INSERT INTO `goods_access_records` VALUES (1617, 314760538842202113, 1000017, 1000035, '2020-08-22 22:00:00');
INSERT INTO `goods_access_records` VALUES (1618, 314760538842202113, 1000017, 1000054, '2020-08-23 09:11:21');
INSERT INTO `goods_access_records` VALUES (1619, 313311614411472897, 1000017, 1000017, '2020-08-23 12:39:17');
INSERT INTO `goods_access_records` VALUES (1620, 314198174128406530, 1000084, 1000085, '2020-08-24 23:58:37');
INSERT INTO `goods_access_records` VALUES (1621, 315769377737670657, 1000017, 1000024, '2020-08-24 23:59:34');
INSERT INTO `goods_access_records` VALUES (1622, 314198174128406530, 1000084, 1000084, '2020-08-25 00:00:40');
INSERT INTO `goods_access_records` VALUES (1623, 314198174128406530, 1000084, 1000084, '2020-08-25 00:03:41');
INSERT INTO `goods_access_records` VALUES (1624, 315769377737670657, 1000017, 1000166, '2020-08-25 12:14:24');
INSERT INTO `goods_access_records` VALUES (1625, 313565493434777601, 1000017, 1000166, '2020-08-25 12:14:42');
INSERT INTO `goods_access_records` VALUES (1626, 313854588908208130, 1000017, 1000166, '2020-08-25 12:14:57');
INSERT INTO `goods_access_records` VALUES (1627, 314198174128406530, 1000084, 1000068, '2020-08-26 11:52:13');
INSERT INTO `goods_access_records` VALUES (1628, 315769377737670657, 1000017, 1000024, '2020-08-27 00:05:51');
INSERT INTO `goods_access_records` VALUES (1629, 315769377737670657, 1000017, 1000024, '2020-08-28 10:52:31');
INSERT INTO `goods_access_records` VALUES (1630, 313315386265174018, 1000017, 1000017, '2020-08-28 11:01:54');
INSERT INTO `goods_access_records` VALUES (1631, 313315386265174018, 1000017, 1000024, '2020-08-28 11:02:07');
INSERT INTO `goods_access_records` VALUES (1632, 313315386265174018, 1000017, 1000017, '2020-08-28 11:02:42');
INSERT INTO `goods_access_records` VALUES (1633, 315769377737670657, 1000017, 1000017, '2020-08-28 12:05:25');
INSERT INTO `goods_access_records` VALUES (1634, 313312545697955841, 1000018, 1000018, '2020-08-31 16:04:57');
INSERT INTO `goods_access_records` VALUES (1635, 315769377737670657, 1000017, 1000019, '2020-08-31 16:08:59');
INSERT INTO `goods_access_records` VALUES (1636, 313312545697955841, 1000018, 1000018, '2020-08-31 21:14:14');
INSERT INTO `goods_access_records` VALUES (1637, 317679076930224130, 1000172, 1000172, '2020-08-31 21:38:23');
INSERT INTO `goods_access_records` VALUES (1638, 317679076930224130, 1000172, 1000172, '2020-08-31 21:38:40');
INSERT INTO `goods_access_records` VALUES (1639, 317679076930224130, 1000172, 1000172, '2020-08-31 21:39:36');
INSERT INTO `goods_access_records` VALUES (1640, 317679076930224130, 1000172, 1000172, '2020-08-31 21:39:59');
INSERT INTO `goods_access_records` VALUES (1641, 317679076930224130, 1000172, 1000172, '2020-08-31 21:40:55');
INSERT INTO `goods_access_records` VALUES (1642, 317679076930224130, 1000172, 1000172, '2020-08-31 21:41:36');
INSERT INTO `goods_access_records` VALUES (1643, 317679076930224130, 1000172, 1000172, '2020-08-31 21:42:55');
INSERT INTO `goods_access_records` VALUES (1644, 317679076930224130, 1000172, 1000172, '2020-08-31 21:43:11');
INSERT INTO `goods_access_records` VALUES (1645, 317679076930224130, 1000172, 1000172, '2020-08-31 21:44:31');
INSERT INTO `goods_access_records` VALUES (1646, 317679076930224130, 1000172, 1000172, '2020-08-31 22:01:52');

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` int(11) NOT NULL COMMENT '分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES (1, 1, '数码');
INSERT INTO `goods_category` VALUES (2, 2, '护肤');
INSERT INTO `goods_category` VALUES (3, 3, '轻奢');
INSERT INTO `goods_category` VALUES (4, 4, '服装');
INSERT INTO `goods_category` VALUES (5, 5, '美妆');
INSERT INTO `goods_category` VALUES (6, 6, '水果');
INSERT INTO `goods_category` VALUES (7, 7, '蔬果');
INSERT INTO `goods_category` VALUES (8, 8, '其他');

-- ----------------------------
-- Table structure for goods_message
-- ----------------------------
DROP TABLE IF EXISTS `goods_message`;
CREATE TABLE `goods_message`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品id',
  `userid` int(11) NULL DEFAULT NULL COMMENT '留言用户',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '留言内容',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '留言时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品留言' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_message
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '买家用户编号',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '卖家用户编号(或称店铺编号)',
  `order_status` int(11) NOT NULL COMMENT '订单状态0待确认1待发货2已发货3已完成',
  `preferential_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NOT NULL COMMENT '订单利润',
  `goods_name_arr` json NULL COMMENT '订单商品列表',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '买家备注',
  `ispay` int(11) NOT NULL COMMENT '是否已支付',
  `pay_price` decimal(20, 2) NOT NULL COMMENT '收取金额',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '此订单状态1正常0禁用-1删除',
  `pay_time` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `ship_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `complete_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `confirm_time` datetime(0) NULL DEFAULT NULL COMMENT '确认时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `shop_id`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '10000061596189166', 1000006, 1000004, 0, NULL, 189.00, 139.00, '[\"敷尔佳水杨酸蛋壳膜 敷尔佳水杨酸蛋壳膜\"]', '给我最贵的', 0, 0.00, -1, '2020-07-31 17:52:46', '2020-07-31 17:52:46', '2020-07-31 17:52:46', '2020-07-31 17:52:46', '2020-07-31 17:52:46', NULL, NULL);
INSERT INTO `orders` VALUES (3, '10000061596189536', 1000006, 1000004, 0, NULL, 189.00, 139.00, '[\"敷尔佳水杨酸蛋壳膜 敷尔佳水杨酸蛋壳膜\"]', '', 0, 0.00, -1, '2020-07-31 17:58:56', '2020-07-31 17:58:56', '2020-07-31 17:58:56', '2020-07-31 17:58:56', '2020-07-31 17:58:56', NULL, NULL);
INSERT INTO `orders` VALUES (4, '10000061596189672', 1000006, 1000004, 0, NULL, 189.00, 139.00, '[\"敷尔佳水杨酸蛋壳膜 敷尔佳水杨酸蛋壳膜\"]', '', 0, 0.00, -1, '2020-07-31 18:01:13', '2020-07-31 18:01:13', '2020-07-31 18:01:13', '2020-07-31 18:01:13', '2020-07-31 18:01:13', NULL, NULL);
INSERT INTO `orders` VALUES (5, '10000061596189690', 1000006, 1000004, 0, NULL, 3024.00, 2224.00, '[\"敷尔佳水杨酸蛋壳膜 敷尔佳水杨酸蛋壳膜\"]', '', 0, 0.00, -1, '2020-07-31 18:01:30', '2020-07-31 18:01:30', '2020-07-31 18:01:30', '2020-07-31 18:01:30', '2020-07-31 18:01:30', NULL, NULL);
INSERT INTO `orders` VALUES (12, '10000191596279833', 1000019, 1000017, 1, NULL, 39.90, 9.90, '[\"火龙果 红色\"]', '', 0, 0.00, -1, '2020-08-01 19:03:53', '2020-08-01 19:03:53', '2020-08-01 19:03:53', '2020-08-01 19:03:53', '2020-08-01 19:03:53', NULL, '2020-08-01 21:04:45');
INSERT INTO `orders` VALUES (35, '10000011596452663', 1000001, 1000004, 2, NULL, 185.00, 83.00, '[\"敷尔佳 灯泡膜 三盒\"]', '', 0, 0.00, -1, '2020-08-03 19:04:23', '2020-08-03 19:08:40', '2020-08-03 19:04:23', '2020-08-03 19:04:23', '2020-08-03 19:08:40', NULL, '2020-08-03 19:06:16');
INSERT INTO `orders` VALUES (36, '10000011596453491', 1000001, 1000004, 1, NULL, 195.00, 93.00, '[\"敷尔佳 灯泡膜 三盒\"]', '', 0, 0.00, -1, '2020-08-03 19:18:12', '2020-08-03 19:18:12', '2020-08-03 19:18:12', '2020-08-03 19:18:12', '2020-08-03 19:18:12', NULL, '2020-08-03 19:18:18');
INSERT INTO `orders` VALUES (37, '10000011596453810', 1000001, 1000004, 1, NULL, 195.00, 93.00, '[\"敷尔佳 灯泡膜 三盒\"]', '', 0, 0.00, -1, '2020-08-03 19:23:30', '2020-08-03 19:23:30', '2020-08-03 19:23:30', '2020-08-03 19:23:30', '2020-08-03 19:23:30', NULL, '2020-08-03 19:23:47');
INSERT INTO `orders` VALUES (41, '10000171596513560', 1000017, 1000017, 0, NULL, 29.90, 9.90, '[\"宝贝南瓜 绿皮黄心\"]', '', 0, 0.00, -1, '2020-08-04 11:59:21', '2020-08-04 11:59:21', '2020-08-04 11:59:21', '2020-08-04 11:59:21', '2020-08-04 11:59:21', NULL, NULL);
INSERT INTO `orders` VALUES (43, '10000131596542446', 1000013, 1000013, 1, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-04 20:00:46', '2020-08-04 20:00:46', '2020-08-04 20:00:46', '2020-08-04 20:00:46', '2020-08-04 20:00:46', NULL, '2020-08-04 20:02:01');
INSERT INTO `orders` VALUES (44, '10000191596595967', 1000019, 1000018, 1, NULL, 20.00, 8.00, '[\"哈哈\"]', '', 0, 0.00, 1, '2020-08-05 10:52:47', '2020-08-05 10:52:47', '2020-08-05 10:52:47', '2020-08-05 10:52:47', '2020-08-05 10:52:47', NULL, '2020-08-05 10:53:16');
INSERT INTO `orders` VALUES (45, '10000131596596608', 1000013, 1000013, 1, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 11:03:29', '2020-08-05 11:03:29', '2020-08-05 11:03:29', '2020-08-05 11:03:29', '2020-08-05 11:03:29', NULL, '2020-08-05 11:03:34');
INSERT INTO `orders` VALUES (46, '10000351596607608', 1000035, 1000035, 3, NULL, 200.00, 190.00, '[\"一座山\"]', '', 0, 0.00, -1, '2020-08-05 14:06:49', '2020-08-05 18:00:39', '2020-08-05 14:06:49', '2020-08-05 14:06:49', '2020-08-05 18:00:39', NULL, '2020-08-05 14:06:58');
INSERT INTO `orders` VALUES (47, '10000131596611864', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 15:17:45', '2020-08-05 15:17:45', '2020-08-05 15:17:45', '2020-08-05 15:17:45', '2020-08-05 15:17:45', NULL, NULL);
INSERT INTO `orders` VALUES (48, '10000131596615798', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 16:23:18', '2020-08-05 16:23:18', '2020-08-05 16:23:18', '2020-08-05 16:23:18', '2020-08-05 16:23:18', NULL, NULL);
INSERT INTO `orders` VALUES (53, '10000351596621719', 1000035, 1000035, 0, NULL, 200.00, 190.00, '[\"一座山\"]', '', 0, 0.00, -1, '2020-08-05 18:01:59', '2020-08-05 18:01:59', '2020-08-05 18:01:59', '2020-08-05 18:01:59', '2020-08-05 18:01:59', NULL, NULL);
INSERT INTO `orders` VALUES (54, '10000351596623124', 1000035, 1000035, 2, NULL, 200.00, 190.00, '[\"一座山\"]', '', 0, 0.00, -1, '2020-08-05 18:25:25', '2020-08-05 20:17:32', '2020-08-05 18:25:25', '2020-08-05 18:25:25', '2020-08-05 20:17:32', NULL, '2020-08-05 18:25:29');
INSERT INTO `orders` VALUES (55, '10000131596623315', 1000013, 1000013, 2, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 18:28:35', '2020-08-11 18:17:25', '2020-08-05 18:28:35', '2020-08-05 18:28:35', '2020-08-11 18:17:25', NULL, '2020-08-05 18:31:55');
INSERT INTO `orders` VALUES (56, '10000131596623769', 1000013, 1000013, 2, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 18:36:09', '2020-08-05 18:36:35', '2020-08-05 18:36:09', '2020-08-05 18:36:09', '2020-08-05 18:36:35', NULL, '2020-08-05 18:36:24');
INSERT INTO `orders` VALUES (57, '10000351596629189', 1000035, 1000035, 2, NULL, 200.00, 190.00, '[\"一座山\"]', '', 0, 0.00, -1, '2020-08-05 20:06:30', '2020-08-05 20:19:29', '2020-08-05 20:06:30', '2020-08-05 20:06:30', '2020-08-05 20:19:29', NULL, '2020-08-05 20:19:22');
INSERT INTO `orders` VALUES (58, '10000351596629958', 1000035, 1000035, 2, NULL, 200.00, 190.00, '[\"一座山\"]', '', 0, 0.00, -1, '2020-08-05 20:19:19', '2020-08-05 20:22:34', '2020-08-05 20:19:19', '2020-08-05 20:19:19', '2020-08-05 20:22:34', NULL, '2020-08-05 20:21:31');
INSERT INTO `orders` VALUES (60, '10000191596636556', 1000019, 1000017, 3, NULL, 29.90, 9.90, '[\"黄桃 黄色\"]', '', 0, 0.00, 1, '2020-08-05 22:09:17', '2020-08-10 12:35:44', '2020-08-19 11:40:34', '2020-08-05 22:09:17', '2020-08-19 11:40:34', NULL, '2020-08-05 22:12:13');
INSERT INTO `orders` VALUES (61, '10000141596636596', 1000014, 1000017, 3, NULL, 29.90, 9.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, 1, '2020-08-05 22:09:57', '2020-08-06 18:29:51', '2020-08-05 22:09:57', '2020-08-05 22:09:57', '2020-08-06 18:29:51', NULL, '2020-08-05 22:12:11');
INSERT INTO `orders` VALUES (62, '10000131596637460', 1000013, 1000013, 2, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-05 22:24:21', '2020-08-06 16:15:52', '2020-08-05 22:24:21', '2020-08-05 22:24:21', '2020-08-06 16:15:52', NULL, '2020-08-05 22:24:31');
INSERT INTO `orders` VALUES (63, '10000131596669066', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 07:11:06', '2020-08-06 07:11:06', '2020-08-06 07:11:06', '2020-08-06 07:11:06', '2020-08-06 07:11:06', NULL, NULL);
INSERT INTO `orders` VALUES (64, '10000401596673074', 1000040, 1000017, 3, NULL, 59.80, 19.80, '[\"金丝蜜枣 超甜\"]', '龙哥恭喜发财！', 0, 0.00, 1, '2020-08-06 08:17:54', '2020-08-06 18:34:36', '2020-08-10 16:03:58', '2020-08-06 08:17:54', '2020-08-10 16:03:58', NULL, '2020-08-06 08:37:22');
INSERT INTO `orders` VALUES (65, '10000011596675710', 1000001, 1000004, 0, NULL, 350.00, 68.00, '[\"sraN‬‬腮红\"]', '', 0, 0.00, -1, '2020-08-06 09:01:50', '2020-08-06 09:01:50', '2020-08-06 09:01:50', '2020-08-06 09:01:50', '2020-08-06 09:01:50', NULL, NULL);
INSERT INTO `orders` VALUES (66, '10000131596676093', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:08:14', '2020-08-06 09:08:14', '2020-08-06 09:08:14', '2020-08-06 09:08:14', '2020-08-06 09:08:14', NULL, NULL);
INSERT INTO `orders` VALUES (67, '10000281596676496', 1000028, 1000017, 0, NULL, 29.90, 9.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, -1, '2020-08-06 09:14:57', '2020-08-06 09:14:57', '2020-08-06 09:14:57', '2020-08-06 09:14:57', '2020-08-06 09:14:57', NULL, NULL);
INSERT INTO `orders` VALUES (68, '10000001596676602', 1000000, 1000017, 0, NULL, 29.90, 9.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, -1, '2020-08-06 09:16:43', '2020-08-06 09:16:43', '2020-08-06 09:16:43', '2020-08-06 09:16:43', '2020-08-06 09:16:43', NULL, NULL);
INSERT INTO `orders` VALUES (69, '10000011596676644', 1000001, 1000004, 0, NULL, 340.00, 38.00, '[\"CBP隔离 新款37ml\"]', '', 0, 0.00, -1, '2020-08-06 09:17:25', '2020-08-06 09:17:25', '2020-08-06 09:17:25', '2020-08-06 09:17:25', '2020-08-06 09:17:25', NULL, NULL);
INSERT INTO `orders` VALUES (70, '10000001596676711', 1000000, 1000017, 0, NULL, 29.90, 9.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, -1, '2020-08-06 09:18:32', '2020-08-06 09:18:32', '2020-08-06 09:18:32', '2020-08-06 09:18:32', '2020-08-06 09:18:32', NULL, NULL);
INSERT INTO `orders` VALUES (71, '10000001596676732', 1000000, 1000017, 0, NULL, 29.90, 9.90, '[\"宝贝南瓜 绿皮黄心\"]', '', 0, 0.00, -1, '2020-08-06 09:18:52', '2020-08-06 09:18:52', '2020-08-06 09:18:52', '2020-08-06 09:18:52', '2020-08-06 09:18:52', NULL, NULL);
INSERT INTO `orders` VALUES (72, '10000001596676750', 1000000, 1000017, 0, NULL, 29.90, 9.90, '[\"宝贝南瓜 绿皮黄心\"]', '', 0, 0.00, -1, '2020-08-06 09:19:11', '2020-08-06 09:19:11', '2020-08-06 09:19:11', '2020-08-06 09:19:11', '2020-08-06 09:19:11', NULL, NULL);
INSERT INTO `orders` VALUES (73, '10000001596676814', 1000000, 1000017, 0, NULL, 29.90, 9.90, '[\"宝贝南瓜 绿皮黄心\"]', '', 0, 0.00, -1, '2020-08-06 09:20:14', '2020-08-06 09:20:14', '2020-08-06 09:20:14', '2020-08-06 09:20:14', '2020-08-06 09:20:14', NULL, NULL);
INSERT INTO `orders` VALUES (74, '10000131596677068', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:24:29', '2020-08-06 09:24:29', '2020-08-06 09:24:29', '2020-08-06 09:24:29', '2020-08-06 09:24:29', NULL, NULL);
INSERT INTO `orders` VALUES (75, '10000131596677158', 1000013, 1000013, 2, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:25:58', '2020-08-06 09:26:24', '2020-08-06 09:25:58', '2020-08-06 09:25:58', '2020-08-06 09:26:24', NULL, '2020-08-06 09:26:03');
INSERT INTO `orders` VALUES (76, '10000131596677767', 1000013, 1000013, 0, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:36:08', '2020-08-06 09:36:08', '2020-08-06 09:36:08', '2020-08-06 09:36:08', '2020-08-06 09:36:08', NULL, NULL);
INSERT INTO `orders` VALUES (77, '10000131596677785', 1000013, 1000013, 2, NULL, 23.00, 23.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:36:26', '2020-08-11 18:16:54', '2020-08-06 09:36:26', '2020-08-06 09:36:26', '2020-08-11 18:16:54', NULL, '2020-08-06 18:16:01');
INSERT INTO `orders` VALUES (78, '10000131596677841', 1000013, 1000013, 2, NULL, 22.00, 22.00, '[\"我\"]', '', 0, 0.00, 1, '2020-08-06 09:37:22', '2020-08-06 11:09:23', '2020-08-06 09:37:22', '2020-08-06 09:37:22', '2020-08-06 11:09:23', NULL, '2020-08-06 11:09:18');
INSERT INTO `orders` VALUES (82, '10000351596678599', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:49:59', '2020-08-06 09:49:59', '2020-08-06 09:49:59', '2020-08-06 09:49:59', '2020-08-06 09:49:59', NULL, NULL);
INSERT INTO `orders` VALUES (83, '10000351596678664', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:51:05', '2020-08-06 09:51:05', '2020-08-06 09:51:05', '2020-08-06 09:51:05', '2020-08-06 09:51:05', NULL, NULL);
INSERT INTO `orders` VALUES (84, '10000351596678846', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:54:07', '2020-08-06 09:54:07', '2020-08-06 09:54:07', '2020-08-06 09:54:07', '2020-08-06 09:54:07', NULL, NULL);
INSERT INTO `orders` VALUES (85, '10000351596678876', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:54:37', '2020-08-06 09:54:37', '2020-08-06 09:54:37', '2020-08-06 09:54:37', '2020-08-06 09:54:37', NULL, NULL);
INSERT INTO `orders` VALUES (86, '10000351596679052', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:57:32', '2020-08-06 09:57:32', '2020-08-06 09:57:32', '2020-08-06 09:57:32', '2020-08-06 09:57:32', NULL, NULL);
INSERT INTO `orders` VALUES (87, '10000351596679094', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 09:58:14', '2020-08-06 09:58:14', '2020-08-06 09:58:14', '2020-08-06 09:58:14', '2020-08-06 09:58:14', NULL, NULL);
INSERT INTO `orders` VALUES (88, '10000351596679490', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '', 0, 0.00, -1, '2020-08-06 10:04:51', '2020-08-06 10:04:51', '2020-08-06 10:04:51', '2020-08-06 10:04:51', '2020-08-06 10:04:51', NULL, NULL);
INSERT INTO `orders` VALUES (90, '10000691596695434', 1000069, 1000013, 2, NULL, 2.99, 2.99, '[\"花老板\"]', '', 0, 0.00, 1, '2020-08-06 14:30:34', '2020-08-06 14:35:46', '2020-08-06 14:30:34', '2020-08-06 14:30:34', '2020-08-06 14:35:46', NULL, '2020-08-06 14:33:37');
INSERT INTO `orders` VALUES (91, '10000701596696099', 1000070, 1000013, 3, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-06 14:41:39', '2020-08-06 14:46:14', '2020-08-06 14:41:39', '2020-08-06 14:41:39', '2020-08-06 14:46:14', NULL, '2020-08-06 14:45:50');
INSERT INTO `orders` VALUES (92, '10000281596698936', 1000028, 1000017, 1, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:28:57', '2020-08-06 15:28:57', '2020-08-06 15:28:57', '2020-08-06 15:28:57', '2020-08-06 15:28:57', NULL, '2020-08-06 15:29:33');
INSERT INTO `orders` VALUES (93, '10000281596699011', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:30:12', '2020-08-06 15:30:12', '2020-08-06 15:30:12', '2020-08-06 15:30:12', '2020-08-06 15:30:12', NULL, NULL);
INSERT INTO `orders` VALUES (94, '10000281596699044', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:30:44', '2020-08-06 15:30:44', '2020-08-06 15:30:44', '2020-08-06 15:30:44', '2020-08-06 15:30:44', NULL, NULL);
INSERT INTO `orders` VALUES (95, '10000281596699053', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:30:53', '2020-08-06 15:30:53', '2020-08-06 15:30:53', '2020-08-06 15:30:53', '2020-08-06 15:30:53', NULL, NULL);
INSERT INTO `orders` VALUES (96, '10000281596699122', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:32:02', '2020-08-06 15:32:02', '2020-08-06 15:32:02', '2020-08-06 15:32:02', '2020-08-06 15:32:02', NULL, NULL);
INSERT INTO `orders` VALUES (97, '10000281596699325', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:35:26', '2020-08-06 15:35:26', '2020-08-06 15:35:26', '2020-08-06 15:35:26', '2020-08-06 15:35:26', NULL, NULL);
INSERT INTO `orders` VALUES (98, '10000281596699432', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 15:37:12', '2020-08-06 15:37:12', '2020-08-06 15:37:12', '2020-08-06 15:37:12', '2020-08-06 15:37:12', NULL, NULL);
INSERT INTO `orders` VALUES (99, '10000061596701197', 1000006, 1000004, 0, 0.00, 336.00, 31.00, '[\"CBP隔离 新款37ml\"]', '', 0, 0.00, -1, '2020-08-06 16:06:38', '2020-08-06 16:06:38', '2020-08-06 16:06:38', '2020-08-06 16:06:38', '2020-08-06 16:06:38', NULL, NULL);
INSERT INTO `orders` VALUES (100, '10000011596704924', 1000001, 1000017, 0, NULL, 29.90, 9.90, '[\"凯特芒 特大\"]', '', 0, 0.00, -1, '2020-08-06 17:08:44', '2020-08-06 17:08:44', '2020-08-06 17:08:44', '2020-08-06 17:08:44', '2020-08-06 17:08:44', NULL, NULL);
INSERT INTO `orders` VALUES (105, '10000711596707009', 1000071, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 17:43:30', '2020-08-06 17:43:30', '2020-08-06 17:43:30', '2020-08-06 17:43:30', '2020-08-06 17:43:30', NULL, NULL);
INSERT INTO `orders` VALUES (106, '10000711596707088', 1000071, 1000017, 3, NULL, 29.90, 4.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, 1, '2020-08-06 17:44:49', '2020-08-07 15:14:15', '2020-08-11 15:36:06', '2020-08-06 17:44:49', '2020-08-11 15:36:06', NULL, '2020-08-06 17:45:27');
INSERT INTO `orders` VALUES (107, '10000011596707162', 1000001, 1000004, 0, NULL, 195.00, 30.00, '[\"敷尔佳 灯泡膜 三盒\"]', '', 0, 0.00, -1, '2020-08-06 17:46:02', '2020-08-06 17:46:02', '2020-08-06 17:46:02', '2020-08-06 17:46:02', '2020-08-06 17:46:02', NULL, NULL);
INSERT INTO `orders` VALUES (108, '10000011596707255', 1000001, 1000004, 0, NULL, 180.00, 35.00, '[\"sraN‬‬腮红\"]', '', 0, 0.00, -1, '2020-08-06 17:47:35', '2020-08-06 17:47:35', '2020-08-06 17:47:35', '2020-08-06 17:47:35', '2020-08-06 17:47:35', NULL, NULL);
INSERT INTO `orders` VALUES (109, '10000131596707941', 1000013, 1000013, 2, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-06 17:59:02', '2020-08-11 18:16:23', '2020-08-06 17:59:02', '2020-08-06 17:59:02', '2020-08-11 18:16:23', NULL, '2020-08-06 18:13:43');
INSERT INTO `orders` VALUES (110, '10000131596707942', 1000013, 1000013, 3, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-06 17:59:03', '2020-08-07 15:37:40', '2020-08-06 17:59:03', '2020-08-06 17:59:03', '2020-08-07 15:37:40', NULL, '2020-08-06 17:59:17');
INSERT INTO `orders` VALUES (111, '10000281596708043', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 18:00:44', '2020-08-06 18:00:44', '2020-08-06 18:00:44', '2020-08-06 18:00:44', '2020-08-06 18:00:44', NULL, NULL);
INSERT INTO `orders` VALUES (112, '10000281596708086', 1000028, 1000017, 2, NULL, 29.90, 4.90, '[\"金丝蜜枣 超甜\"]', '', 0, 0.00, -1, '2020-08-06 18:01:26', '2020-08-06 18:02:31', '2020-08-06 18:01:26', '2020-08-06 18:01:26', '2020-08-06 18:02:31', NULL, '2020-08-06 18:01:41');
INSERT INTO `orders` VALUES (113, '10000281596708250', 1000028, 1000017, 1, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-06 18:04:11', '2020-08-06 18:04:11', '2020-08-06 18:04:11', '2020-08-06 18:04:11', '2020-08-06 18:04:11', NULL, '2020-08-06 18:04:22');
INSERT INTO `orders` VALUES (114, '10000081596711429', 1000008, 1000004, 1, 0.00, 194.00, 30.00, '[\"敷尔佳 灯泡膜 三盒\"]', '', 0, 0.00, -1, '2020-08-06 18:57:10', '2020-08-06 18:57:10', '2020-08-06 18:57:10', '2020-08-06 18:57:10', '2020-08-06 18:57:10', NULL, '2020-08-06 19:57:16');
INSERT INTO `orders` VALUES (115, '10000131596714299', 1000013, 1000013, 3, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-06 19:45:00', '2020-08-06 19:45:52', '2020-08-06 19:45:00', '2020-08-06 19:45:00', '2020-08-06 19:45:52', NULL, '2020-08-06 19:45:34');
INSERT INTO `orders` VALUES (116, '10000351596714917', 1000035, 1000004, 2, NULL, 1880.00, 215.00, '[\"Dior墨镜\"]', '', 0, 0.00, -1, '2020-08-06 19:55:18', '2020-08-06 20:10:33', '2020-08-06 19:55:18', '2020-08-06 19:55:18', '2020-08-06 20:10:33', NULL, '2020-08-06 19:57:13');
INSERT INTO `orders` VALUES (117, '10000351596720880', 1000035, 1000035, 0, NULL, 100.00, 80.00, '[\"2\"]', '很', 0, 0.00, -1, '2020-08-06 21:34:40', '2020-08-06 21:34:40', '2020-08-06 21:34:40', '2020-08-06 21:34:40', '2020-08-06 21:34:40', NULL, NULL);
INSERT INTO `orders` VALUES (119, '10000131596775276', 1000013, 1000013, 0, NULL, 1.50, 1.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-07 12:41:17', '2020-08-07 12:41:17', '2020-08-07 12:41:17', '2020-08-07 12:41:17', '2020-08-07 12:41:17', NULL, NULL);
INSERT INTO `orders` VALUES (120, '10000281596784649', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-07 15:17:29', '2020-08-07 15:17:29', '2020-08-07 15:17:29', '2020-08-07 15:17:29', '2020-08-07 15:17:29', NULL, NULL);
INSERT INTO `orders` VALUES (121, '10000131596784673', 1000013, 1000013, 3, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-07 15:17:54', '2020-08-07 16:57:27', '2020-08-07 16:57:44', '2020-08-07 15:17:54', '2020-08-07 16:57:44', NULL, '2020-08-07 16:56:46');
INSERT INTO `orders` VALUES (122, '10000281596784702', 1000028, 1000017, 0, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-07 15:18:22', '2020-08-07 15:18:22', '2020-08-07 15:18:22', '2020-08-07 15:18:22', '2020-08-07 15:18:22', NULL, NULL);
INSERT INTO `orders` VALUES (123, '10000281596784750', 1000028, 1000017, 0, NULL, 29.90, 9.90, '[\"宝贝南瓜 绿皮黄心\"]', '', 0, 0.00, -1, '2020-08-07 15:19:10', '2020-08-07 15:19:10', '2020-08-07 15:19:10', '2020-08-07 15:19:10', '2020-08-07 15:19:10', NULL, NULL);
INSERT INTO `orders` VALUES (124, '10000281596785583', 1000028, 1000017, 3, NULL, 19.90, 4.90, '[\"六鳌蜜薯 红皮黄心\"]', '', 0, 0.00, -1, '2020-08-07 15:33:04', '2020-08-07 15:33:56', '2020-08-08 07:46:05', '2020-08-07 15:33:04', '2020-08-08 07:46:05', NULL, '2020-08-07 15:33:41');
INSERT INTO `orders` VALUES (130, '10000171596844039', 1000017, 1000013, 3, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-08 07:47:19', '2020-08-08 07:50:21', '2020-08-08 07:47:19', '2020-08-08 07:47:19', '2020-08-08 07:50:21', NULL, '2020-08-08 07:50:07');
INSERT INTO `orders` VALUES (131, '10000141596867606', 1000014, 1000035, 1, NULL, 310.00, 60.00, '[\"CPB长管隔离\"]', '', 0, 0.00, 1, '2020-08-08 14:20:07', '2020-08-08 14:20:07', '2020-08-08 14:20:07', '2020-08-08 14:20:07', '2020-08-08 14:20:07', NULL, '2020-08-08 22:09:35');
INSERT INTO `orders` VALUES (132, '10000141596867657', 1000014, 1000035, 1, NULL, 300.00, 50.00, '[\"兰蔻小黑瓶 50ml\"]', '', 0, 0.00, 1, '2020-08-08 14:20:58', '2020-08-08 14:20:58', '2020-08-08 14:20:58', '2020-08-08 14:20:58', '2020-08-08 14:20:58', NULL, '2020-08-08 22:09:31');
INSERT INTO `orders` VALUES (133, '10000141596867664', 1000014, 1000035, 1, NULL, 400.00, 100.00, '[\"小棕瓶 第6代\"]', '', 0, 0.00, 1, '2020-08-08 14:21:05', '2020-08-08 14:21:05', '2020-08-08 14:21:05', '2020-08-08 14:21:05', '2020-08-08 14:21:05', NULL, '2020-08-08 22:09:33');
INSERT INTO `orders` VALUES (134, '10000751597050899', 1000075, 1000017, 0, NULL, 29.90, 9.90, '[\"凯特芒 特大\"]', '', 0, 0.00, -1, '2020-08-10 17:15:00', '2020-08-10 17:15:00', '2020-08-10 17:15:00', '2020-08-10 17:15:00', '2020-08-10 17:15:00', NULL, NULL);
INSERT INTO `orders` VALUES (135, '10000751597051376', 1000075, 1000017, 3, NULL, 29.90, 7.40, '[\"青皮核桃 3斤装\"]', '', 0, 0.00, 1, '2020-08-10 17:22:57', '2020-08-11 15:34:45', '2020-08-19 11:40:27', '2020-08-10 17:22:57', '2020-08-19 11:40:27', NULL, '2020-08-11 08:28:55');
INSERT INTO `orders` VALUES (136, '10000991597068770', 1000099, 1000099, 0, NULL, 1.00, 1.00, '[\"斜挎包 红色\"]', '', 0, 0.00, -1, '2020-08-10 22:12:51', '2020-08-10 22:12:51', '2020-08-10 22:12:51', '2020-08-10 22:12:51', '2020-08-10 22:12:51', NULL, NULL);
INSERT INTO `orders` VALUES (137, '10000131597068825', 1000013, 1000099, 2, NULL, 1.00, 1.00, '[\"斜挎包 红色\"]', '姐，我测试买一个给你看看', 0, 0.00, 1, '2020-08-10 22:13:46', '2020-08-10 22:17:40', '2020-08-10 22:13:46', '2020-08-10 22:13:46', '2020-08-10 22:17:40', NULL, '2020-08-10 22:17:01');
INSERT INTO `orders` VALUES (138, '10000131597069256', 1000013, 1000099, 2, NULL, 80.00, 80.00, '[\"针织个性鞋 37码 38码\"]', '测试公众号通知下单', 0, 0.00, 1, '2020-08-10 22:20:57', '2020-08-10 22:24:24', '2020-08-10 22:20:57', '2020-08-10 22:20:57', '2020-08-10 22:24:24', NULL, '2020-08-10 22:24:13');
INSERT INTO `orders` VALUES (139, '10000131597080410', 1000013, 1000013, 3, NULL, 6.00, 6.00, '[\"萍乡麻辣\"]', '', 0, 0.00, 1, '2020-08-11 01:26:50', '2020-08-11 01:27:26', '2020-08-11 01:26:50', '2020-08-11 01:26:50', '2020-08-11 01:27:26', NULL, '2020-08-11 01:27:16');
INSERT INTO `orders` VALUES (140, '10000751597083446', 1000075, 1000022, 1, NULL, 999.00, 199.00, '[\"Mk相机包 红色\"]', '', 0, 0.00, 1, '2020-08-11 02:17:26', '2020-08-11 02:17:26', '2020-08-11 02:17:26', '2020-08-11 02:17:26', '2020-08-11 02:17:26', NULL, '2020-08-11 02:27:13');
INSERT INTO `orders` VALUES (141, '10000751597083512', 1000075, 1000017, 0, NULL, 29.90, 9.90, '[\"凯特芒 特大\"]', '陆敏玲试试', 0, 0.00, -1, '2020-08-11 02:18:32', '2020-08-11 02:18:32', '2020-08-11 02:18:32', '2020-08-11 02:18:32', '2020-08-11 02:18:32', NULL, NULL);
INSERT INTO `orders` VALUES (142, '10000751597106994', 1000075, 1000022, 0, NULL, 1004.00, 199.00, '[\"Mk相机包 红色\"]', '', 0, 0.00, 1, '2020-08-11 08:49:55', '2020-08-11 08:49:55', '2020-08-11 08:49:55', '2020-08-11 08:49:55', '2020-08-11 08:49:55', NULL, NULL);
INSERT INTO `orders` VALUES (143, '10001071597112277', 1000107, 1000106, 1, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-11 10:17:57', '2020-08-11 10:17:57', '2020-08-11 10:17:57', '2020-08-11 10:17:57', '2020-08-11 10:17:57', NULL, '2020-08-11 10:39:17');
INSERT INTO `orders` VALUES (144, '10000171597114252', 1000017, 1000013, 0, NULL, 7.00, 7.00, '[\"萍乡麻辣\"]', '', 0, 0.00, -1, '2020-08-11 10:50:52', '2020-08-11 10:50:52', '2020-08-11 10:50:52', '2020-08-11 10:50:52', '2020-08-11 10:50:52', NULL, NULL);
INSERT INTO `orders` VALUES (145, '10001131597118933', 1000113, 1000106, 0, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, -1, '2020-08-11 12:08:54', '2020-08-11 12:08:54', '2020-08-11 12:08:54', '2020-08-11 12:08:54', '2020-08-11 12:08:54', NULL, NULL);
INSERT INTO `orders` VALUES (146, '10001131597118984', 1000113, 1000106, 1, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-11 12:09:45', '2020-08-11 12:09:45', '2020-08-11 12:09:45', '2020-08-11 12:09:45', '2020-08-11 12:09:45', NULL, '2020-08-12 00:31:24');
INSERT INTO `orders` VALUES (147, '10000131597138125', 1000013, 1000017, 2, NULL, 29.90, 7.40, '[\"青皮核桃 3斤装\"]', '', 0, 0.00, -1, '2020-08-11 17:28:46', '2020-08-11 17:31:59', '2020-08-11 17:28:46', '2020-08-11 17:28:46', '2020-08-11 17:31:59', NULL, '2020-08-11 17:30:32');
INSERT INTO `orders` VALUES (148, '10000131597140391', 1000013, 1000017, 2, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, -1, '2020-08-11 18:06:31', '2020-08-11 18:07:53', '2020-08-11 18:06:31', '2020-08-11 18:06:31', '2020-08-11 18:07:53', NULL, '2020-08-11 18:06:59');
INSERT INTO `orders` VALUES (149, '10000061597140570', 1000006, 1000013, 2, NULL, 0.50, 0.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-11 18:09:30', '2020-08-11 18:12:21', '2020-08-11 18:09:30', '2020-08-11 18:09:30', '2020-08-11 18:12:21', NULL, '2020-08-11 18:11:27');
INSERT INTO `orders` VALUES (150, '10000061597142551', 1000006, 1000013, 0, NULL, 1.50, 1.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-11 18:42:31', '2020-08-11 18:42:31', '2020-08-11 18:42:31', '2020-08-11 18:42:31', '2020-08-11 18:42:31', NULL, NULL);
INSERT INTO `orders` VALUES (151, '10000141597142955', 1000014, 1000035, 0, NULL, 198.00, 198.00, '[\"雅诗兰黛洗面奶 125ml\"]', '', 0, 0.00, 1, '2020-08-11 18:49:16', '2020-08-11 18:49:16', '2020-08-11 18:49:16', '2020-08-11 18:49:16', '2020-08-11 18:49:16', NULL, NULL);
INSERT INTO `orders` VALUES (152, '10000081597144271', 1000008, 1000035, 0, NULL, 198.00, 198.00, '[\"雅诗兰黛洗面奶 125ml\"]', '', 0, 0.00, 1, '2020-08-11 19:11:11', '2020-08-11 19:11:11', '2020-08-11 19:11:11', '2020-08-11 19:11:11', '2020-08-11 19:11:11', NULL, NULL);
INSERT INTO `orders` VALUES (153, '10000351597144411', 1000035, 1000017, 0, NULL, 29.90, 7.40, '[\"青皮核桃 3斤装\"]', '', 0, 0.00, -1, '2020-08-11 19:13:31', '2020-08-11 19:13:31', '2020-08-11 19:13:31', '2020-08-11 19:13:31', '2020-08-11 19:13:31', NULL, NULL);
INSERT INTO `orders` VALUES (154, '10000131597373918', 1000013, 1000013, 0, NULL, 1.50, 1.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-14 10:58:39', '2020-08-14 10:58:39', '2020-08-14 10:58:39', '2020-08-14 10:58:39', '2020-08-14 10:58:39', NULL, NULL);
INSERT INTO `orders` VALUES (155, '10000131597386596', 1000013, 1000013, 1, NULL, 1.50, 1.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-14 14:29:56', '2020-08-14 14:29:56', '2020-08-14 14:29:56', '2020-08-14 14:29:56', '2020-08-14 14:29:56', NULL, '2020-08-14 14:31:02');
INSERT INTO `orders` VALUES (156, '10000131597397343', 1000013, 1000013, 0, NULL, 1.50, 1.50, '[\"大头\"]', '', 0, 0.00, 1, '2020-08-14 17:29:03', '2020-08-14 17:29:03', '2020-08-14 17:29:03', '2020-08-14 17:29:03', '2020-08-14 17:29:03', NULL, NULL);
INSERT INTO `orders` VALUES (157, '10000131597741477', 1000013, 1000013, 1, NULL, 7.00, 7.00, '[\"萍乡麻辣\"]', '', 0, 0.00, 1, '2020-08-18 17:04:38', '2020-08-18 17:04:38', '2020-08-18 17:04:38', '2020-08-18 17:04:38', '2020-08-18 17:04:38', NULL, '2020-08-18 17:05:40');
INSERT INTO `orders` VALUES (158, '10000951597743580', 1000095, 1000017, 0, NULL, 40.00, 5.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, -1, '2020-08-18 17:39:41', '2020-08-18 17:39:41', '2020-08-18 17:39:41', '2020-08-18 17:39:41', '2020-08-18 17:39:41', NULL, NULL);
INSERT INTO `orders` VALUES (159, '10000951597743586', 1000095, 1000017, 3, NULL, 40.00, 5.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-18 17:39:47', '2020-08-20 21:01:17', '2020-08-22 20:06:11', '2020-08-18 17:39:47', '2020-08-22 20:06:11', NULL, '2020-08-18 18:04:17');
INSERT INTO `orders` VALUES (160, '10001481597744483', 1000148, 1000017, 0, NULL, 29.90, 9.90, '[\"凯特芒 特大\"]', '', 0, 0.00, -1, '2020-08-18 17:54:43', '2020-08-18 17:54:43', '2020-08-18 17:54:43', '2020-08-18 17:54:43', '2020-08-18 17:54:43', NULL, NULL);
INSERT INTO `orders` VALUES (161, '10001481597744851', 1000148, 1000017, 3, NULL, 29.90, 4.90, '[\"金丝蜜枣 2斤装\"]', '', 0, 0.00, 1, '2020-08-18 18:00:51', '2020-08-20 21:10:51', '2020-08-22 20:11:08', '2020-08-18 18:00:51', '2020-08-22 20:11:08', NULL, '2020-08-18 18:07:25');
INSERT INTO `orders` VALUES (162, '10000171597744978', 1000017, 1000106, 3, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-18 18:02:59', '2020-08-20 14:43:11', '2020-08-22 21:51:13', '2020-08-18 18:02:59', '2020-08-22 21:51:13', NULL, '2020-08-18 18:05:39');
INSERT INTO `orders` VALUES (163, '10000161597745898', 1000016, 1000017, 3, NULL, 40.00, 5.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-18 18:18:18', '2020-08-20 21:00:46', '2020-08-22 20:10:45', '2020-08-18 18:18:18', '2020-08-22 20:10:45', NULL, '2020-08-18 18:25:12');
INSERT INTO `orders` VALUES (164, '10000171597746299', 1000017, 1000106, 3, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-18 18:25:00', '2020-08-20 14:41:22', '2020-08-22 21:49:30', '2020-08-18 18:25:00', '2020-08-22 21:49:30', NULL, '2020-08-18 18:27:20');
INSERT INTO `orders` VALUES (165, '10000641597748685', 1000064, 1000017, 3, NULL, 29.90, 8.90, '[\"石榴 5斤12个\"]', '', 0, 0.00, 1, '2020-08-18 19:04:45', '2020-08-28 11:25:10', '2020-09-01 12:21:23', '2020-08-18 19:04:45', '2020-09-01 12:21:23', NULL, '2020-08-18 19:05:05');
INSERT INTO `orders` VALUES (166, '10001221597756055', 1000122, 1000084, 0, NULL, 1880.00, 220.00, '[\"Dior墨镜\"]', '', 0, 0.00, -1, '2020-08-18 21:07:36', '2020-08-18 21:07:36', '2020-08-18 21:07:36', '2020-08-18 21:07:36', '2020-08-18 21:07:36', NULL, NULL);
INSERT INTO `orders` VALUES (167, '10000221597929355', 1000022, 1000017, 3, NULL, 39.90, 4.90, '[\"红心猕猴桃 红心4.8斤装\"]', '', 0, 0.00, 1, '2020-08-20 21:15:55', '2020-08-20 21:18:10', '2020-08-22 20:10:31', '2020-08-20 21:15:55', '2020-08-22 20:10:31', NULL, '2020-08-20 21:17:59');
INSERT INTO `orders` VALUES (168, '10001481597929615', 1000148, 1000017, 1, NULL, 29.00, 7.00, '[\"云南蜜橘 5斤装\"]', '', 0, 0.00, -1, '2020-08-20 21:20:15', '2020-08-20 21:20:15', '2020-08-20 21:20:15', '2020-08-20 21:20:15', '2020-08-20 21:20:15', NULL, '2020-08-20 21:21:37');
INSERT INTO `orders` VALUES (169, '10000571597933138', 1000057, 1000017, 3, NULL, 29.00, 6.50, '[\"云南蜜橘 5斤装\"]', '', 0, 0.00, 1, '2020-08-20 22:18:59', '2020-08-22 21:52:20', '2020-08-28 11:18:39', '2020-08-20 22:18:59', '2020-08-28 11:18:39', NULL, '2020-08-20 22:39:24');
INSERT INTO `orders` VALUES (170, '10001541597933355', 1000154, 1000017, 3, NULL, 29.90, 4.90, '[\"金丝蜜枣 2斤装\"]', '', 0, 0.00, 1, '2020-08-20 22:22:36', '2020-08-21 11:09:02', '2020-08-28 11:18:35', '2020-08-20 22:22:36', '2020-08-28 11:18:35', NULL, '2020-08-20 22:39:27');
INSERT INTO `orders` VALUES (171, '10001581597933666', 1000158, 1000017, 1, NULL, 19.90, 4.90, '[\"六鳌蜜薯 红皮黄心\"]', '', 0, 0.00, -1, '2020-08-20 22:27:47', '2020-08-20 22:27:47', '2020-08-20 22:27:47', '2020-08-20 22:27:47', '2020-08-20 22:27:47', NULL, '2020-08-20 22:39:29');
INSERT INTO `orders` VALUES (172, '10000541597989435', 1000054, 1000017, 3, NULL, 40.00, 5.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-21 13:57:15', '2020-08-22 21:51:24', '2020-08-21 13:57:15', '2020-08-21 13:57:15', '2020-08-22 21:51:24', NULL, '2020-08-21 14:18:12');
INSERT INTO `orders` VALUES (173, '10000171597990776', 1000017, 1000106, 2, NULL, 48.00, 13.00, '[\"黄桃 5斤装\"]', '', 0, 0.00, 1, '2020-08-21 14:19:36', '2020-08-22 21:49:09', '2020-08-21 14:19:36', '2020-08-21 14:19:36', '2020-08-22 21:49:09', NULL, '2020-08-21 20:54:58');
INSERT INTO `orders` VALUES (174, '10000241598583192', 1000024, 1000017, 1, NULL, 79.00, 9.00, '[\"山竹 31个大个\"]', '', 0, 0.00, -1, '2020-08-28 10:53:13', '2020-08-28 10:53:13', '2020-08-28 10:53:13', '2020-08-28 10:53:13', '2020-08-28 10:53:13', NULL, '2020-08-28 10:54:15');
INSERT INTO `orders` VALUES (175, '10000241598583732', 1000024, 1000017, 2, NULL, 29.90, 9.90, '[\"香蕉 绿色\"]', '', 0, 0.00, 1, '2020-08-28 11:02:12', '2020-08-30 20:52:59', '2020-08-28 11:02:12', '2020-08-28 11:02:12', '2020-08-30 20:52:59', NULL, '2020-08-28 11:03:00');
INSERT INTO `orders` VALUES (176, '10000191598861345', 1000019, 1000017, 0, 0.00, 79.00, 9.00, '[\"山竹 31个大个\"]', '你好', 0, 0.00, -1, '2020-08-31 16:09:06', '2020-08-31 16:09:06', '2020-08-31 16:09:06', '2020-08-31 16:09:06', '2020-08-31 16:09:06', NULL, NULL);

-- ----------------------------
-- Table structure for orders_bill_flow
-- ----------------------------
DROP TABLE IF EXISTS `orders_bill_flow`;
CREATE TABLE `orders_bill_flow`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `before` decimal(20, 2) NULL DEFAULT NULL COMMENT '之前金额',
  `last` decimal(20, 2) NULL DEFAULT NULL COMMENT '之后金额',
  `change_value` decimal(20, 2) NULL DEFAULT NULL COMMENT '变化金额',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单账单流水记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_bill_flow
-- ----------------------------

-- ----------------------------
-- Table structure for orders_goods
-- ----------------------------
DROP TABLE IF EXISTS `orders_goods`;
CREATE TABLE `orders_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `currency_type` int(11) NOT NULL DEFAULT 0 COMMENT '进价货币类型（0人民币1港币2澳门币3美元4英镑5欧元6韩元7日元）',
  `input_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '进价',
  `single_price` decimal(20, 2) NOT NULL COMMENT '销售单价',
  `total_input_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '进价总价',
  `total_price` decimal(20, 2) NOT NULL COMMENT '销售总价（单价*数量）',
  `specifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品规格（比如大小和颜色等）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片地址',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单对应商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_goods
-- ----------------------------
INSERT INTO `orders_goods` VALUES (1, '10000061596189166', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 17:52:46', '2020-07-31 17:52:46', NULL);
INSERT INTO `orders_goods` VALUES (2, '10000071596189295', 1, 0, 200.00, 229.00, 200.00, 229.00, '菲洛嘉十全大补', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 17:54:55', '2020-07-31 17:54:55', NULL);
INSERT INTO `orders_goods` VALUES (3, '10000061596189536', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 17:58:56', '2020-07-31 17:58:56', NULL);
INSERT INTO `orders_goods` VALUES (4, '10000061596189672', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 18:01:12', '2020-07-31 18:01:12', NULL);
INSERT INTO `orders_goods` VALUES (5, '10000061596189690', 16, 0, 50.00, 189.00, 800.00, 3024.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 18:01:30', '2020-07-31 18:01:30', NULL);
INSERT INTO `orders_goods` VALUES (7, '10000071596189865', 1, 0, 200.00, 230.00, 200.00, 230.00, '菲洛嘉十全大补', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 18:38:10', '2020-07-31 18:38:10', NULL);
INSERT INTO `orders_goods` VALUES (8, '10000051596201833', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-07-31 21:23:53', '2020-07-31 21:23:53', NULL);
INSERT INTO `orders_goods` VALUES (9, '10000001596265776', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-01 15:09:36', '2020-08-01 15:09:36', NULL);
INSERT INTO `orders_goods` VALUES (10, '10000071596268795', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-01 15:59:55', '2020-08-01 15:59:55', NULL);
INSERT INTO `orders_goods` VALUES (11, '10000051596269131', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-01 16:05:31', '2020-08-01 16:05:31', NULL);
INSERT INTO `orders_goods` VALUES (12, '10000151596275393', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-01 17:49:53', '2020-08-01 17:49:53', NULL);
INSERT INTO `orders_goods` VALUES (13, '10000191596279833', 1, 0, 30.00, 39.90, 30.00, 39.90, '红色', '火龙果', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202081192/r6NDZBYYS3.png', '2020-08-01 19:03:53', '2020-08-01 19:03:53', NULL);
INSERT INTO `orders_goods` VALUES (14, '10000011596428708', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 12:25:08', '2020-08-03 12:25:08', NULL);
INSERT INTO `orders_goods` VALUES (15, '10000011596428846', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 12:27:26', '2020-08-03 12:27:26', NULL);
INSERT INTO `orders_goods` VALUES (16, '10000011596446619', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 17:23:39', '2020-08-03 17:23:39', NULL);
INSERT INTO `orders_goods` VALUES (17, '10000081596447736', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 17:42:16', '2020-08-03 17:42:16', NULL);
INSERT INTO `orders_goods` VALUES (18, '10000041596448099', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 17:48:19', '2020-08-03 17:48:19', NULL);
INSERT INTO `orders_goods` VALUES (19, '10000041596448258', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 17:50:58', '2020-08-03 17:50:58', NULL);
INSERT INTO `orders_goods` VALUES (20, '10000041596448681', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 17:58:01', '2020-08-03 17:58:01', NULL);
INSERT INTO `orders_goods` VALUES (21, '10000041596448971', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 18:02:51', '2020-08-03 18:02:51', NULL);
INSERT INTO `orders_goods` VALUES (22, '10000041596449186', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:06:26', '2020-08-03 18:06:26', NULL);
INSERT INTO `orders_goods` VALUES (23, '10000041596449282', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:08:02', '2020-08-03 18:08:02', NULL);
INSERT INTO `orders_goods` VALUES (24, '10000041596449357', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:09:17', '2020-08-03 18:09:17', NULL);
INSERT INTO `orders_goods` VALUES (25, '10000041596449670', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:14:30', '2020-08-03 18:14:30', NULL);
INSERT INTO `orders_goods` VALUES (26, '10000041596449787', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:16:27', '2020-08-03 18:16:27', NULL);
INSERT INTO `orders_goods` VALUES (27, '10000041596449941', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:19:01', '2020-08-03 18:19:01', NULL);
INSERT INTO `orders_goods` VALUES (28, '10000041596450876', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:34:36', '2020-08-03 18:34:36', NULL);
INSERT INTO `orders_goods` VALUES (29, '10000041596451005', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:36:45', '2020-08-03 18:36:45', NULL);
INSERT INTO `orders_goods` VALUES (30, '10000041596451574', 1, 0, 888.00, 999.00, 888.00, 999.00, '', '悦薇水乳', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/202081168/xzAr8xaPF2.png', '2020-08-03 18:46:14', '2020-08-03 18:46:14', NULL);
INSERT INTO `orders_goods` VALUES (31, '10000041596451675', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:47:55', '2020-08-03 18:47:55', NULL);
INSERT INTO `orders_goods` VALUES (32, '10000041596451785', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:49:45', '2020-08-03 18:49:45', NULL);
INSERT INTO `orders_goods` VALUES (33, '10000041596451890', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:51:30', '2020-08-03 18:51:30', NULL);
INSERT INTO `orders_goods` VALUES (34, '10000041596451928', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-03 18:52:08', '2020-08-03 18:52:08', NULL);
INSERT INTO `orders_goods` VALUES (35, '10000041596452275', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 18:57:55', '2020-08-03 18:57:55', NULL);
INSERT INTO `orders_goods` VALUES (36, '10000011596452663', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 19:04:23', '2020-08-03 19:04:23', NULL);
INSERT INTO `orders_goods` VALUES (37, '10000011596453491', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 19:18:11', '2020-08-03 19:18:11', NULL);
INSERT INTO `orders_goods` VALUES (38, '10000011596453810', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-03 19:23:30', '2020-08-03 19:23:30', NULL);
INSERT INTO `orders_goods` VALUES (39, '10000261596506807', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-04 10:06:47', '2020-08-04 10:06:47', NULL);
INSERT INTO `orders_goods` VALUES (40, '10000261596506832', 1, 0, 50.00, 189.00, 50.00, 189.00, '敷尔佳水杨酸蛋壳膜', '敷尔佳水杨酸蛋壳膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311750/7hNWBbXNAG.png', '2020-08-04 10:07:12', '2020-08-04 10:07:12', NULL);
INSERT INTO `orders_goods` VALUES (41, '10000261596506848', 1, 0, 100.00, 185.00, 100.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020731189/rsScHanAaB.png', '2020-08-04 10:07:28', '2020-08-04 10:07:28', NULL);
INSERT INTO `orders_goods` VALUES (42, '10000171596513560', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿皮黄心', '宝贝南瓜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/fAhp5fAyzP.png', '2020-08-04 11:59:20', '2020-08-04 11:59:20', NULL);
INSERT INTO `orders_goods` VALUES (43, '10000071596542131', 1, 0, 1660.00, 1880.00, 1660.00, 1880.00, '', 'Dior墨镜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/2020841723/TnwZDcjmeh.png', '2020-08-04 19:55:32', '2020-08-04 19:55:32', NULL);
INSERT INTO `orders_goods` VALUES (44, '10000131596542446', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-04 20:00:46', '2020-08-04 20:00:46', NULL);
INSERT INTO `orders_goods` VALUES (45, '10000191596595967', 1, 0, 12.00, 20.00, 12.00, 20.00, '', '哈哈', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000018/2020832025/KXhM3kjNzb.png', '2020-08-05 10:52:47', '2020-08-05 10:52:47', NULL);
INSERT INTO `orders_goods` VALUES (46, '10000131596596608', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 11:03:28', '2020-08-05 11:03:28', NULL);
INSERT INTO `orders_goods` VALUES (47, '10000351596607608', 1, 0, 10.00, 200.00, 10.00, 200.00, '', '一座山', 'https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png', '2020-08-05 14:06:48', '2020-08-05 14:06:48', NULL);
INSERT INTO `orders_goods` VALUES (48, '10000131596611864', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 15:17:44', '2020-08-05 15:17:44', NULL);
INSERT INTO `orders_goods` VALUES (49, '10000131596615798', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 16:23:18', '2020-08-05 16:23:18', NULL);
INSERT INTO `orders_goods` VALUES (50, '10000041596615859', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/ZeePQ4JPj6.png', '2020-08-05 16:24:19', '2020-08-05 16:24:19', NULL);
INSERT INTO `orders_goods` VALUES (51, '10000041596615915', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/ZeePQ4JPj6.png', '2020-08-05 16:25:15', '2020-08-05 16:25:15', NULL);
INSERT INTO `orders_goods` VALUES (52, '10000041596616813', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/ZeePQ4JPj6.png', '2020-08-05 16:40:13', '2020-08-05 16:40:13', NULL);
INSERT INTO `orders_goods` VALUES (53, '10000041596616950', 1, 0, 1660.00, 1880.00, 1660.00, 1880.00, '', 'Dior墨镜', 'https://cwimg.szxjcheng.com/1000004/202085114/h3FtA3NGke.png', '2020-08-05 16:42:30', '2020-08-05 16:42:30', NULL);
INSERT INTO `orders_goods` VALUES (54, '10000351596621719', 1, 0, 10.00, 200.00, 10.00, 200.00, '', '一座山', 'https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png', '2020-08-05 18:01:59', '2020-08-05 18:01:59', NULL);
INSERT INTO `orders_goods` VALUES (55, '10000351596623124', 1, 0, 10.00, 200.00, 10.00, 200.00, '', '一座山', 'https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png', '2020-08-05 18:25:24', '2020-08-05 18:25:24', NULL);
INSERT INTO `orders_goods` VALUES (56, '10000131596623315', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 18:28:35', '2020-08-05 18:28:35', NULL);
INSERT INTO `orders_goods` VALUES (57, '10000131596623769', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 18:36:09', '2020-08-05 18:36:09', NULL);
INSERT INTO `orders_goods` VALUES (58, '10000351596629189', 1, 0, 10.00, 200.00, 10.00, 200.00, '', '一座山', 'https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png', '2020-08-05 20:06:29', '2020-08-05 20:06:29', NULL);
INSERT INTO `orders_goods` VALUES (59, '10000351596629958', 1, 0, 10.00, 200.00, 10.00, 200.00, '', '一座山', 'https://cwimg.szxjcheng.com/1000035/202085146/t2yFGfCfpZ.png', '2020-08-05 20:19:18', '2020-08-05 20:19:18', NULL);
INSERT INTO `orders_goods` VALUES (60, '10000041596636425', 1, 0, 1660.00, 1880.00, 1660.00, 1880.00, '', 'Dior墨镜', 'https://cwimg.szxjcheng.com/1000004/202085114/h3FtA3NGke.png', '2020-08-05 22:07:05', '2020-08-05 22:07:05', NULL);
INSERT INTO `orders_goods` VALUES (61, '10000191596636556', 1, 0, 20.00, 29.90, 20.00, 29.90, '黄色', '黄桃', 'https://cwimg.szxjcheng.com/1000017/2020851512/PETsKewiJk.png', '2020-08-05 22:09:16', '2020-08-05 22:09:16', NULL);
INSERT INTO `orders_goods` VALUES (62, '10000141596636596', 1, 0, 20.00, 29.90, 20.00, 29.90, '超甜', '金丝蜜枣', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811831/wNJeEBrMEk.png', '2020-08-05 22:09:56', '2020-08-05 22:09:56', NULL);
INSERT INTO `orders_goods` VALUES (63, '10000131596637460', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-05 22:24:20', '2020-08-05 22:24:20', NULL);
INSERT INTO `orders_goods` VALUES (64, '10000131596669066', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 07:11:06', '2020-08-06 07:11:06', NULL);
INSERT INTO `orders_goods` VALUES (65, '10000401596673074', 2, 0, 20.00, 29.90, 40.00, 59.80, '超甜', '金丝蜜枣', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811831/wNJeEBrMEk.png', '2020-08-06 08:17:54', '2020-08-06 08:17:54', NULL);
INSERT INTO `orders_goods` VALUES (66, '10000011596675710', 2, 0, 140.00, 170.00, 280.00, 340.00, '', 'sraN‬‬腮红', 'https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png', '2020-08-06 09:01:50', '2020-08-06 09:01:50', NULL);
INSERT INTO `orders_goods` VALUES (67, '10000131596676093', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:08:14', '2020-08-06 09:08:14', NULL);
INSERT INTO `orders_goods` VALUES (68, '10000281596676496', 1, 0, 20.00, 29.90, 20.00, 29.90, '超甜', '金丝蜜枣', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811831/wNJeEBrMEk.png', '2020-08-06 09:14:56', '2020-08-06 09:14:56', NULL);
INSERT INTO `orders_goods` VALUES (69, '10000001596676602', 1, 0, 20.00, 29.90, 20.00, 29.90, '超甜', '金丝蜜枣', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811831/wNJeEBrMEk.png', '2020-08-06 09:16:42', '2020-08-06 09:16:42', NULL);
INSERT INTO `orders_goods` VALUES (70, '10000011596676644', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 09:17:24', '2020-08-06 09:17:24', NULL);
INSERT INTO `orders_goods` VALUES (71, '10000001596676711', 1, 0, 20.00, 29.90, 20.00, 29.90, '超甜', '金丝蜜枣', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811831/wNJeEBrMEk.png', '2020-08-06 09:18:31', '2020-08-06 09:18:31', NULL);
INSERT INTO `orders_goods` VALUES (72, '10000001596676732', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿皮黄心', '宝贝南瓜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/fAhp5fAyzP.png', '2020-08-06 09:18:52', '2020-08-06 09:18:52', NULL);
INSERT INTO `orders_goods` VALUES (73, '10000001596676750', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿皮黄心', '宝贝南瓜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/fAhp5fAyzP.png', '2020-08-06 09:19:10', '2020-08-06 09:19:10', NULL);
INSERT INTO `orders_goods` VALUES (74, '10000001596676814', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿皮黄心', '宝贝南瓜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/fAhp5fAyzP.png', '2020-08-06 09:20:14', '2020-08-06 09:20:14', NULL);
INSERT INTO `orders_goods` VALUES (75, '10000131596677068', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:24:28', '2020-08-06 09:24:28', NULL);
INSERT INTO `orders_goods` VALUES (76, '10000131596677158', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:25:58', '2020-08-06 09:25:58', NULL);
INSERT INTO `orders_goods` VALUES (77, '10000131596677767', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:36:07', '2020-08-06 09:36:07', NULL);
INSERT INTO `orders_goods` VALUES (78, '10000131596677785', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:36:25', '2020-08-06 09:36:25', NULL);
INSERT INTO `orders_goods` VALUES (79, '10000131596677841', 1, 0, 0.00, 22.00, 0.00, 22.00, '', '我', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000013/202084200/nE4Tfpw733.png', '2020-08-06 09:37:21', '2020-08-06 09:37:21', NULL);
INSERT INTO `orders_goods` VALUES (80, '10000261596678141', 1, 0, 140.00, 170.00, 140.00, 170.00, '', 'sraN‬‬腮红', 'https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png', '2020-08-06 09:42:21', '2020-08-06 09:42:21', NULL);
INSERT INTO `orders_goods` VALUES (81, '10000261596678158', 1, 0, 140.00, 170.00, 140.00, 170.00, '', 'sraN‬‬腮红', 'https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png', '2020-08-06 09:42:38', '2020-08-06 09:42:38', NULL);
INSERT INTO `orders_goods` VALUES (82, '10000261596678169', 1, 0, 140.00, 170.00, 140.00, 170.00, '', 'sraN‬‬腮红', 'https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png', '2020-08-06 09:42:49', '2020-08-06 09:42:49', NULL);
INSERT INTO `orders_goods` VALUES (83, '10000351596678599', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:49:59', '2020-08-06 09:49:59', NULL);
INSERT INTO `orders_goods` VALUES (84, '10000351596678664', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:51:04', '2020-08-06 09:51:04', NULL);
INSERT INTO `orders_goods` VALUES (85, '10000351596678846', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:54:06', '2020-08-06 09:54:06', NULL);
INSERT INTO `orders_goods` VALUES (86, '10000351596678876', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:54:36', '2020-08-06 09:54:36', NULL);
INSERT INTO `orders_goods` VALUES (87, '10000351596679052', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:57:32', '2020-08-06 09:57:32', NULL);
INSERT INTO `orders_goods` VALUES (88, '10000351596679094', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 09:58:14', '2020-08-06 09:58:14', NULL);
INSERT INTO `orders_goods` VALUES (89, '10000351596679490', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 10:04:50', '2020-08-06 10:04:50', NULL);
INSERT INTO `orders_goods` VALUES (90, '10000041596680109', 11, 0, 300.00, 330.00, 3300.00, 3630.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 10:15:10', '2020-08-06 10:15:10', NULL);
INSERT INTO `orders_goods` VALUES (91, '10000691596695434', 1, 0, 0.00, 1.99, 0.00, 1.99, '', '花老板', 'https://cwimg.szxjcheng.com/1000013/2020861416/rywr4GHCBx.png', '2020-08-06 14:30:34', '2020-08-06 14:30:34', NULL);
INSERT INTO `orders_goods` VALUES (92, '10000701596696099', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-06 14:41:39', '2020-08-06 14:41:39', NULL);
INSERT INTO `orders_goods` VALUES (93, '10000281596698936', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:28:56', '2020-08-06 15:28:56', NULL);
INSERT INTO `orders_goods` VALUES (94, '10000281596699011', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:30:11', '2020-08-06 15:30:11', NULL);
INSERT INTO `orders_goods` VALUES (95, '10000281596699044', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:30:44', '2020-08-06 15:30:44', NULL);
INSERT INTO `orders_goods` VALUES (96, '10000281596699053', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:30:53', '2020-08-06 15:30:53', NULL);
INSERT INTO `orders_goods` VALUES (97, '10000281596699122', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:32:02', '2020-08-06 15:32:02', NULL);
INSERT INTO `orders_goods` VALUES (98, '10000281596699325', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:35:25', '2020-08-06 15:35:25', NULL);
INSERT INTO `orders_goods` VALUES (99, '10000281596699432', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 15:37:12', '2020-08-06 15:37:12', NULL);
INSERT INTO `orders_goods` VALUES (101, '10000011596704924', 1, 0, 20.00, 29.90, 20.00, 29.90, '特大', '凯特芒', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811844/XKbMzJH3yi.png', '2020-08-06 17:08:44', '2020-08-06 17:08:44', NULL);
INSERT INTO `orders_goods` VALUES (103, '10000261596705999', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 17:26:39', '2020-08-06 17:26:39', NULL);
INSERT INTO `orders_goods` VALUES (104, '10000041596706302', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 17:31:42', '2020-08-06 17:31:42', NULL);
INSERT INTO `orders_goods` VALUES (105, '10000041596706316', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 17:31:56', '2020-08-06 17:31:56', NULL);
INSERT INTO `orders_goods` VALUES (106, '10000711596707009', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 17:43:29', '2020-08-06 17:43:29', NULL);
INSERT INTO `orders_goods` VALUES (107, '10000711596707088', 1, 0, 25.00, 29.90, 25.00, 29.90, '超甜', '金丝蜜枣', 'https://cwimg.szxjcheng.com/1000017/2020861150/WMdTz74pDy.png', '2020-08-06 17:44:49', '2020-08-06 17:44:49', NULL);
INSERT INTO `orders_goods` VALUES (108, '10000011596707162', 1, 0, 160.00, 185.00, 160.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://cwimg.szxjcheng.com/1000004/202085116/4SKRJT4GAb.png', '2020-08-06 17:46:02', '2020-08-06 17:46:02', NULL);
INSERT INTO `orders_goods` VALUES (109, '10000011596707255', 1, 0, 140.00, 170.00, 140.00, 170.00, '', 'sraN‬‬腮红', 'https://cwimg.szxjcheng.com/1000004/202085118/YSJZN63b5Z.png', '2020-08-06 17:47:35', '2020-08-06 17:47:35', NULL);
INSERT INTO `orders_goods` VALUES (110, '10000131596707941', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-06 17:59:02', '2020-08-06 17:59:02', NULL);
INSERT INTO `orders_goods` VALUES (111, '10000131596707942', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-06 17:59:03', '2020-08-06 17:59:03', NULL);
INSERT INTO `orders_goods` VALUES (112, '10000281596708043', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 18:00:43', '2020-08-06 18:00:43', NULL);
INSERT INTO `orders_goods` VALUES (113, '10000281596708086', 1, 0, 25.00, 29.90, 25.00, 29.90, '超甜', '金丝蜜枣', 'https://cwimg.szxjcheng.com/1000017/2020861150/WMdTz74pDy.png', '2020-08-06 18:01:26', '2020-08-06 18:01:26', NULL);
INSERT INTO `orders_goods` VALUES (114, '10000281596708250', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-06 18:04:11', '2020-08-06 18:04:11', NULL);
INSERT INTO `orders_goods` VALUES (116, '10000081596711429', 1, 0, 160.00, 185.00, 160.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://cwimg.szxjcheng.com/1000004/202085116/4SKRJT4GAb.png', '2020-08-06 18:57:55', '2020-08-06 18:57:55', NULL);
INSERT INTO `orders_goods` VALUES (117, '10000261596705610', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 18:59:53', '2020-08-06 18:59:53', NULL);
INSERT INTO `orders_goods` VALUES (118, '10000061596701197', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-06 19:00:19', '2020-08-06 19:00:19', NULL);
INSERT INTO `orders_goods` VALUES (119, '10000131596714299', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-06 19:44:59', '2020-08-06 19:44:59', NULL);
INSERT INTO `orders_goods` VALUES (120, '10000351596714917', 1, 0, 1660.00, 1880.00, 1660.00, 1880.00, '', 'Dior墨镜', 'https://cwimg.szxjcheng.com/1000004/202085114/h3FtA3NGke.png', '2020-08-06 19:55:17', '2020-08-06 19:55:17', NULL);
INSERT INTO `orders_goods` VALUES (121, '10000351596720880', 1, 0, 20.00, 100.00, 20.00, 100.00, '', '2', 'https://cwimg.szxjcheng.com/1000035/202086949/4EprE8dasM.png', '2020-08-06 21:34:40', '2020-08-06 21:34:40', NULL);
INSERT INTO `orders_goods` VALUES (122, '10000261596749737', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-07 05:35:37', '2020-08-07 05:35:37', NULL);
INSERT INTO `orders_goods` VALUES (123, '10000131596775276', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-07 12:41:16', '2020-08-07 12:41:16', NULL);
INSERT INTO `orders_goods` VALUES (124, '10000281596784649', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-07 15:17:29', '2020-08-07 15:17:29', NULL);
INSERT INTO `orders_goods` VALUES (125, '10000131596784673', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-07 15:17:53', '2020-08-07 15:17:53', NULL);
INSERT INTO `orders_goods` VALUES (126, '10000281596784702', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-07 15:18:22', '2020-08-07 15:18:22', NULL);
INSERT INTO `orders_goods` VALUES (127, '10000281596784750', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿皮黄心', '宝贝南瓜', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202083178/fAhp5fAyzP.png', '2020-08-07 15:19:10', '2020-08-07 15:19:10', NULL);
INSERT INTO `orders_goods` VALUES (128, '10000281596785583', 1, 0, 15.00, 19.90, 15.00, 19.90, '红皮黄心', '六鳌蜜薯', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/FCpiyJDFkZ.png', '2020-08-07 15:33:03', '2020-08-07 15:33:03', NULL);
INSERT INTO `orders_goods` VALUES (129, '10000041596786260', 1, 0, 160.00, 185.00, 160.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://cwimg.szxjcheng.com/1000004/202085116/4SKRJT4GAb.png', '2020-08-07 15:44:20', '2020-08-07 15:44:20', NULL);
INSERT INTO `orders_goods` VALUES (130, '10000041596786262', 1, 0, 160.00, 185.00, 160.00, 185.00, '三盒', '敷尔佳 灯泡膜', 'https://cwimg.szxjcheng.com/1000004/202085116/4SKRJT4GAb.png', '2020-08-07 15:44:22', '2020-08-07 15:44:22', NULL);
INSERT INTO `orders_goods` VALUES (131, '10000041596786683', 1, 0, 300.00, 330.00, 300.00, 330.00, '新款37ml', 'CBP隔离', 'https://cwimg.szxjcheng.com/1000004/2020851053/K8T26rHaBJ.png', '2020-08-07 15:51:23', '2020-08-07 15:51:23', NULL);
INSERT INTO `orders_goods` VALUES (132, '10000261596788448', 1, 0, 600.00, 789.00, 600.00, 789.00, '', '雪花秀明星套', 'https://cwimg.szxjcheng.com/1000004/202085114/RcQaQEKyaw.png', '2020-08-07 16:20:48', '2020-08-07 16:20:48', NULL);
INSERT INTO `orders_goods` VALUES (133, '10000171596844039', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-08 07:47:19', '2020-08-08 07:47:19', NULL);
INSERT INTO `orders_goods` VALUES (134, '10000141596867606', 1, 0, 250.00, 310.00, 250.00, 310.00, '', 'CPB长管隔离', 'https://cwimg.szxjcheng.com/1000035/20208894/PrwHc5izW3.png', '2020-08-08 14:20:06', '2020-08-08 14:20:06', NULL);
INSERT INTO `orders_goods` VALUES (135, '10000141596867657', 1, 0, 250.00, 300.00, 250.00, 300.00, '50ml', '兰蔻小黑瓶', 'https://cwimg.szxjcheng.com/1000035/20208894/dfz4w8N6Md.png', '2020-08-08 14:20:57', '2020-08-08 14:20:57', NULL);
INSERT INTO `orders_goods` VALUES (136, '10000141596867664', 1, 0, 300.00, 400.00, 300.00, 400.00, '第6代', '小棕瓶', 'https://cwimg.szxjcheng.com/1000035/20208895/sHzNEkiMsm.png', '2020-08-08 14:21:04', '2020-08-08 14:21:04', NULL);
INSERT INTO `orders_goods` VALUES (137, '10000751597050899', 1, 0, 20.00, 29.90, 20.00, 29.90, '特大', '凯特芒', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020811844/XKbMzJH3yi.png', '2020-08-10 17:14:59', '2020-08-10 17:14:59', NULL);
INSERT INTO `orders_goods` VALUES (138, '10000751597051376', 1, 0, 22.50, 29.90, 22.50, 29.90, '3斤装', '青皮核桃', 'https://cwimg.szxjcheng.com/1000017/20208101552/QFHQezEwCB.png', '2020-08-10 17:22:56', '2020-08-10 17:22:56', NULL);
INSERT INTO `orders_goods` VALUES (139, '10000991597068770', 1, 0, 0.00, 1.00, 0.00, 1.00, '红色', '斜挎包', 'https://cwimg.szxjcheng.com/1000099/20208102211/FBPmmjsSjP.png', '2020-08-10 22:12:50', '2020-08-10 22:12:50', NULL);
INSERT INTO `orders_goods` VALUES (140, '10000131597068825', 1, 0, 0.00, 1.00, 0.00, 1.00, '红色', '斜挎包', 'https://cwimg.szxjcheng.com/1000099/20208102211/FBPmmjsSjP.png', '2020-08-10 22:13:45', '2020-08-10 22:13:45', NULL);
INSERT INTO `orders_goods` VALUES (141, '10000131597069256', 1, 0, 0.00, 80.00, 0.00, 80.00, '37码 38码', '针织个性鞋', 'https://cwimg.szxjcheng.com/1000099/2020810226/TdQQe8HKb3.png', '2020-08-10 22:20:56', '2020-08-10 22:20:56', NULL);
INSERT INTO `orders_goods` VALUES (142, '10000131597080410', 1, 0, 0.00, 6.00, 0.00, 6.00, '', '萍乡麻辣', 'https://cwimg.szxjcheng.com/1000013/2020810231/Cjf4MHFsk5.png', '2020-08-11 01:26:50', '2020-08-11 01:26:50', NULL);
INSERT INTO `orders_goods` VALUES (143, '10000751597083446', 1, 0, 800.00, 999.00, 800.00, 999.00, '红色', 'Mk相机包', 'https://cwimg.szxjcheng.com/1000022/2020811152/BnHsm88cSa.png', '2020-08-11 02:17:26', '2020-08-11 02:17:26', NULL);
INSERT INTO `orders_goods` VALUES (144, '10000751597083512', 1, 0, 20.00, 29.90, 20.00, 29.90, '特大', '凯特芒', 'https://cwimg.szxjcheng.com/1000017/20208101725/t52mTxCt8x.png', '2020-08-11 02:18:32', '2020-08-11 02:18:32', NULL);
INSERT INTO `orders_goods` VALUES (145, '10000751597106994', 1, 0, 800.00, 999.00, 800.00, 999.00, '红色', 'Mk相机包', 'https://cwimg.szxjcheng.com/1000022/2020811152/BnHsm88cSa.png', '2020-08-11 08:49:54', '2020-08-11 08:49:54', NULL);
INSERT INTO `orders_goods` VALUES (146, '10001071597112277', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-11 10:17:57', '2020-08-11 10:17:57', NULL);
INSERT INTO `orders_goods` VALUES (147, '10000171597114252', 1, 0, 0.00, 6.00, 0.00, 6.00, '', '萍乡麻辣', 'https://cwimg.szxjcheng.com/1000013/2020810231/Cjf4MHFsk5.png', '2020-08-11 10:50:52', '2020-08-11 10:50:52', NULL);
INSERT INTO `orders_goods` VALUES (148, '10001131597118933', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-11 12:08:53', '2020-08-11 12:08:53', NULL);
INSERT INTO `orders_goods` VALUES (149, '10001131597118984', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-11 12:09:44', '2020-08-11 12:09:44', NULL);
INSERT INTO `orders_goods` VALUES (150, '10000131597138125', 1, 0, 22.50, 29.90, 22.50, 29.90, '3斤装', '青皮核桃', 'https://cwimg.szxjcheng.com/1000017/20208101552/QFHQezEwCB.png', '2020-08-11 17:28:45', '2020-08-11 17:28:45', NULL);
INSERT INTO `orders_goods` VALUES (151, '10000131597140391', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-11 18:06:31', '2020-08-11 18:06:31', NULL);
INSERT INTO `orders_goods` VALUES (152, '10000061597140570', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-11 18:09:30', '2020-08-11 18:09:30', NULL);
INSERT INTO `orders_goods` VALUES (153, '10000061597142551', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-11 18:42:31', '2020-08-11 18:42:31', NULL);
INSERT INTO `orders_goods` VALUES (154, '10000141597142955', 1, 0, 0.00, 198.00, 0.00, 198.00, '125ml', '雅诗兰黛洗面奶', 'https://cwimg.szxjcheng.com/1000035/20208111846/DCjjJ3WCrZ.png', '2020-08-11 18:49:15', '2020-08-11 18:49:15', NULL);
INSERT INTO `orders_goods` VALUES (155, '10000081597144271', 1, 0, 0.00, 198.00, 0.00, 198.00, '125ml', '雅诗兰黛洗面奶', 'https://cwimg.szxjcheng.com/1000035/20208111846/DCjjJ3WCrZ.png', '2020-08-11 19:11:11', '2020-08-11 19:11:11', NULL);
INSERT INTO `orders_goods` VALUES (156, '10000351597144411', 1, 0, 22.50, 29.90, 22.50, 29.90, '3斤装', '青皮核桃', 'https://cwimg.szxjcheng.com/1000017/20208101552/QFHQezEwCB.png', '2020-08-11 19:13:31', '2020-08-11 19:13:31', NULL);
INSERT INTO `orders_goods` VALUES (157, '10000131597373918', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-14 10:58:38', '2020-08-14 10:58:38', NULL);
INSERT INTO `orders_goods` VALUES (158, '10000131597386596', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-14 14:29:56', '2020-08-14 14:29:56', NULL);
INSERT INTO `orders_goods` VALUES (159, '10000131597397343', 1, 0, 0.00, 0.50, 0.00, 0.50, '', '大头', 'https://cwimg.szxjcheng.com/1000013/2020861438/hnwTbHbjTY.png', '2020-08-14 17:29:03', '2020-08-14 17:29:03', NULL);
INSERT INTO `orders_goods` VALUES (160, '10000131597741477', 1, 0, 0.00, 6.00, 0.00, 6.00, '', '萍乡麻辣', 'https://cwimg.szxjcheng.com/1000013/2020810231/Cjf4MHFsk5.png', '2020-08-18 17:04:37', '2020-08-18 17:04:37', NULL);
INSERT INTO `orders_goods` VALUES (161, '10000951597743580', 1, 0, 35.00, 40.00, 35.00, 40.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000017/20208111825/KZwpStTZzn.png', '2020-08-18 17:39:40', '2020-08-18 17:39:40', NULL);
INSERT INTO `orders_goods` VALUES (162, '10000951597743586', 1, 0, 35.00, 40.00, 35.00, 40.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000017/20208111825/KZwpStTZzn.png', '2020-08-18 17:39:46', '2020-08-18 17:39:46', NULL);
INSERT INTO `orders_goods` VALUES (163, '10001481597744483', 1, 0, 20.00, 29.90, 20.00, 29.90, '特大', '凯特芒', 'https://cwimg.szxjcheng.com/1000017/20208101725/t52mTxCt8x.png', '2020-08-18 17:54:43', '2020-08-18 17:54:43', NULL);
INSERT INTO `orders_goods` VALUES (164, '10001481597744851', 1, 0, 25.00, 29.90, 25.00, 29.90, '2斤装', '金丝蜜枣', 'https://cwimg.szxjcheng.com/1000017/2020861150/WMdTz74pDy.png', '2020-08-18 18:00:51', '2020-08-18 18:00:51', NULL);
INSERT INTO `orders_goods` VALUES (165, '10000171597744978', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-18 18:02:58', '2020-08-18 18:02:58', NULL);
INSERT INTO `orders_goods` VALUES (166, '10000161597745898', 1, 0, 35.00, 40.00, 35.00, 40.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000017/20208111825/KZwpStTZzn.png', '2020-08-18 18:18:18', '2020-08-18 18:18:18', NULL);
INSERT INTO `orders_goods` VALUES (167, '10000171597746299', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-18 18:24:59', '2020-08-18 18:24:59', NULL);
INSERT INTO `orders_goods` VALUES (168, '10000641597748685', 1, 0, 21.00, 29.90, 21.00, 29.90, '5斤12个', '石榴', 'https://cwimg.szxjcheng.com/1000017/20208181837/wAdhHkiJ2m.png', '2020-08-18 19:04:45', '2020-08-18 19:04:45', NULL);
INSERT INTO `orders_goods` VALUES (169, '10001221597756055', 1, 0, 1660.00, 1880.00, 1660.00, 1880.00, '', 'Dior墨镜', 'https://cwimg.szxjcheng.com/1000084/2020872118/C8Y5ZDNPCW.png', '2020-08-18 21:07:35', '2020-08-18 21:07:35', NULL);
INSERT INTO `orders_goods` VALUES (170, '10000221597929355', 1, 0, 35.00, 39.90, 35.00, 39.90, '红心4.8斤装', '红心猕猴桃', 'https://cwimg.szxjcheng.com/1000017/2020851043/R2jrFbwwYG.png', '2020-08-20 21:15:55', '2020-08-20 21:15:55', NULL);
INSERT INTO `orders_goods` VALUES (171, '10001481597929615', 1, 0, 22.00, 29.00, 22.00, 29.00, '5斤装', '云南蜜橘', 'https://cwimg.szxjcheng.com/1000017/20208202051/HHANpmmPfZ.png', '2020-08-20 21:20:15', '2020-08-20 21:20:15', NULL);
INSERT INTO `orders_goods` VALUES (172, '10000571597933138', 1, 0, 22.50, 29.00, 22.50, 29.00, '5斤装', '云南蜜橘', 'https://cwimg.szxjcheng.com/1000017/20208202051/HHANpmmPfZ.png', '2020-08-20 22:18:58', '2020-08-20 22:18:58', NULL);
INSERT INTO `orders_goods` VALUES (173, '10001541597933355', 1, 0, 25.00, 29.90, 25.00, 29.90, '2斤装', '金丝蜜枣', 'https://cwimg.szxjcheng.com/1000017/2020861150/WMdTz74pDy.png', '2020-08-20 22:22:35', '2020-08-20 22:22:35', NULL);
INSERT INTO `orders_goods` VALUES (174, '10001581597933666', 1, 0, 15.00, 19.90, 15.00, 19.90, '红皮黄心', '六鳌蜜薯', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/2020831233/FCpiyJDFkZ.png', '2020-08-20 22:27:46', '2020-08-20 22:27:46', NULL);
INSERT INTO `orders_goods` VALUES (175, '10000541597989435', 1, 0, 35.00, 40.00, 35.00, 40.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000017/20208111825/KZwpStTZzn.png', '2020-08-21 13:57:15', '2020-08-21 13:57:15', NULL);
INSERT INTO `orders_goods` VALUES (176, '10000171597990776', 1, 0, 35.00, 48.00, 35.00, 48.00, '5斤装', '黄桃', 'https://cwimg.szxjcheng.com/1000106/2020811106/YCwKtxBzc7.png', '2020-08-21 14:19:36', '2020-08-21 14:19:36', NULL);
INSERT INTO `orders_goods` VALUES (177, '10000241598583192', 1, 0, 70.00, 79.00, 70.00, 79.00, '31个大个', '山竹', 'https://cwimg.szxjcheng.com/1000017/20208181726/RfAYQaXHfb.png', '2020-08-28 10:53:12', '2020-08-28 10:53:12', NULL);
INSERT INTO `orders_goods` VALUES (178, '10000241598583732', 1, 0, 20.00, 29.90, 20.00, 29.90, '绿色', '香蕉', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000017/202081198/ZHDrYwYEdH.png', '2020-08-28 11:02:12', '2020-08-28 11:02:12', NULL);
INSERT INTO `orders_goods` VALUES (180, '10000191598861345', 1, 0, 70.00, 79.00, 70.00, 79.00, '31个大个', '山竹', 'https://cwimg.szxjcheng.com/1000017/20208181726/RfAYQaXHfb.png', '2020-08-31 16:10:46', '2020-08-31 16:10:46', NULL);

-- ----------------------------
-- Table structure for orders_logistics
-- ----------------------------
DROP TABLE IF EXISTS `orders_logistics`;
CREATE TABLE `orders_logistics`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `status` int(11) NOT NULL COMMENT '0发送中1收货中2完成-1异常',
  `cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费成本',
  `offer` decimal(10, 2) NOT NULL COMMENT '运费报价',
  `receiver_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '收货人',
  `receiver_iphone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '收货联系方式',
  `receiver_province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '市',
  `receiver_district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '区/县',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '详细地址',
  `sender_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货人',
  `sender_iphone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货联系方式',
  `sender_province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货省',
  `sender_city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货市',
  `sender_district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货区/县',
  `sender_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '寄货详细地址',
  `logistics_company` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流公司',
  `logistics_com` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流公司编码（如：顺丰编码(SF)）',
  `logistics_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流编号',
  `third_party_id` int(11) NULL DEFAULT NULL COMMENT '物流第三方平台编号',
  `logistics_records` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '快递物流记录',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单物流信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_logistics
-- ----------------------------
INSERT INTO `orders_logistics` VALUES (1, '10000061596189166', 1, NULL, 0.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-07-31 17:52:46', '2020-07-31 17:52:46', NULL);
INSERT INTO `orders_logistics` VALUES (2, '10000071596189295', 1, NULL, 0.00, '小陈', '18912341234', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-07-31 17:54:56', '2020-07-31 17:54:56', NULL);
INSERT INTO `orders_logistics` VALUES (3, '10000061596189536', 1, NULL, 0.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-07-31 17:58:56', '2020-07-31 17:58:56', NULL);
INSERT INTO `orders_logistics` VALUES (4, '10000061596189672', 1, NULL, 0.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-07-31 18:01:13', '2020-07-31 18:01:13', NULL);
INSERT INTO `orders_logistics` VALUES (5, '10000061596189690', 1, NULL, 0.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-07-31 18:01:30', '2020-07-31 18:01:30', NULL);
INSERT INTO `orders_logistics` VALUES (6, '10000071596189865', 1, 0.00, 10.00, '小陈', '18912341234', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-07-31 18:04:26', '2020-07-31 18:38:23', NULL);
INSERT INTO `orders_logistics` VALUES (7, '10000051596201833', 1, 2.00, 10.00, '好了', '15846795623', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-07-31 21:23:53', '2020-07-31 21:23:53', NULL);
INSERT INTO `orders_logistics` VALUES (8, '10000001596265776', 1, 2.00, 10.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-01 15:09:37', '2020-08-01 15:09:37', NULL);
INSERT INTO `orders_logistics` VALUES (9, '10000071596268795', 1, 2.00, 10.00, '小陈', '18912341234', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-01 15:59:56', '2020-08-01 15:59:56', NULL);
INSERT INTO `orders_logistics` VALUES (10, '10000051596269131', 1, 2.00, 10.00, '好了', '15846795623', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-01 16:05:31', '2020-08-01 16:05:31', NULL);
INSERT INTO `orders_logistics` VALUES (11, '10000151596275393', 1, 2.00, 10.00, '王', '15001977677', '广东省', '深圳市', '宝安区', '永丰社区六区84号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-01 17:49:53', '2020-08-01 17:49:53', NULL);
INSERT INTO `orders_logistics` VALUES (12, '10000191596279833', 1, 0.00, 0.00, '王', '15001977677', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-01 19:03:53', '2020-08-01 19:03:53', NULL);
INSERT INTO `orders_logistics` VALUES (13, '10000011596428708', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 12:25:09', '2020-08-03 12:25:09', NULL);
INSERT INTO `orders_logistics` VALUES (14, '10000011596428846', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 12:27:26', '2020-08-03 12:27:26', NULL);
INSERT INTO `orders_logistics` VALUES (15, '10000011596446619', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 17:23:39', '2020-08-03 17:23:39', NULL);
INSERT INTO `orders_logistics` VALUES (16, '10000081596447736', 1, 2.00, 10.00, 'ee', '15865435435', '广东省', '韶关市', '乐昌市', 'rwqrwwqedwqew', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 17:42:17', '2020-08-03 17:42:17', NULL);
INSERT INTO `orders_logistics` VALUES (17, '10000041596448099', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 17:48:19', '2020-08-03 17:48:19', NULL);
INSERT INTO `orders_logistics` VALUES (18, '10000041596448258', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 17:50:58', '2020-08-03 17:50:58', NULL);
INSERT INTO `orders_logistics` VALUES (19, '10000041596448681', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 17:58:01', '2020-08-03 17:58:01', NULL);
INSERT INTO `orders_logistics` VALUES (20, '10000041596448971', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:02:51', '2020-08-03 18:02:51', NULL);
INSERT INTO `orders_logistics` VALUES (21, '10000041596449186', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:06:26', '2020-08-03 18:06:26', NULL);
INSERT INTO `orders_logistics` VALUES (22, '10000041596449282', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:08:03', '2020-08-03 18:08:03', NULL);
INSERT INTO `orders_logistics` VALUES (23, '10000041596449357', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:09:18', '2020-08-03 18:09:18', NULL);
INSERT INTO `orders_logistics` VALUES (24, '10000041596449670', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:14:31', '2020-08-03 18:14:31', NULL);
INSERT INTO `orders_logistics` VALUES (25, '10000041596449787', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:16:27', '2020-08-03 18:16:27', NULL);
INSERT INTO `orders_logistics` VALUES (26, '10000041596449941', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:19:02', '2020-08-03 18:19:02', NULL);
INSERT INTO `orders_logistics` VALUES (27, '10000041596450876', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:34:36', '2020-08-03 18:34:36', NULL);
INSERT INTO `orders_logistics` VALUES (28, '10000041596451005', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:36:45', '2020-08-03 18:36:45', NULL);
INSERT INTO `orders_logistics` VALUES (29, '10000041596451574', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:46:14', '2020-08-03 18:46:14', NULL);
INSERT INTO `orders_logistics` VALUES (30, '10000041596451675', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:47:56', '2020-08-03 18:47:56', NULL);
INSERT INTO `orders_logistics` VALUES (31, '10000041596451785', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:49:45', '2020-08-03 18:49:45', NULL);
INSERT INTO `orders_logistics` VALUES (32, '10000041596451890', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:51:31', '2020-08-03 18:51:31', NULL);
INSERT INTO `orders_logistics` VALUES (33, '10000041596451928', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:52:09', '2020-08-03 18:52:09', NULL);
INSERT INTO `orders_logistics` VALUES (34, '10000041596452275', 1, 2.00, 10.00, '发广告', '18755582355', '北京市', '北京市', '东城区', '复古风的图', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 18:57:55', '2020-08-03 18:57:55', NULL);
INSERT INTO `orders_logistics` VALUES (35, '10000011596452663', 1, 0.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-03 19:04:23', '2020-08-03 19:08:40', NULL);
INSERT INTO `orders_logistics` VALUES (36, '10000011596453491', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 19:18:12', '2020-08-03 19:18:12', NULL);
INSERT INTO `orders_logistics` VALUES (37, '10000011596453810', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-03 19:23:30', '2020-08-03 19:23:30', NULL);
INSERT INTO `orders_logistics` VALUES (38, '10000261596506807', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-04 10:06:48', '2020-08-04 10:06:48', NULL);
INSERT INTO `orders_logistics` VALUES (39, '10000261596506832', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-04 10:07:12', '2020-08-04 10:07:12', NULL);
INSERT INTO `orders_logistics` VALUES (40, '10000261596506848', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-04 10:07:29', '2020-08-04 10:07:29', NULL);
INSERT INTO `orders_logistics` VALUES (41, '10000171596513560', 1, 0.00, 0.00, '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-04 11:59:21', '2020-08-04 11:59:21', NULL);
INSERT INTO `orders_logistics` VALUES (42, '10000071596542131', 1, 2.00, 10.00, '小陈', '18912341234', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-04 19:55:32', '2020-08-04 19:55:32', NULL);
INSERT INTO `orders_logistics` VALUES (43, '10000131596542446', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-04 20:00:46', '2020-08-04 20:00:46', NULL);
INSERT INTO `orders_logistics` VALUES (44, '10000191596595967', 1, NULL, 0.00, '王', '15001977677', '广东省', '深圳市', '宝安区', '海城路186-8号', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-05 10:52:47', '2020-08-05 10:52:47', NULL);
INSERT INTO `orders_logistics` VALUES (45, '10000131596596608', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-05 11:03:29', '2020-08-05 11:03:29', NULL);
INSERT INTO `orders_logistics` VALUES (46, '10000351596607608', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '百世快递', 'HTKY', '202008051800369', NULL, NULL, '2020-08-05 14:06:49', '2020-08-05 18:00:39', NULL);
INSERT INTO `orders_logistics` VALUES (47, '10000131596611864', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-05 15:17:45', '2020-08-05 15:17:45', NULL);
INSERT INTO `orders_logistics` VALUES (48, '10000131596615798', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-05 16:23:18', '2020-08-05 16:23:18', NULL);
INSERT INTO `orders_logistics` VALUES (49, '10000041596615859', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街hhh', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-05 16:24:19', '2020-08-05 16:24:19', NULL);
INSERT INTO `orders_logistics` VALUES (50, '10000041596615915', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-05 16:25:15', '2020-08-05 16:25:15', NULL);
INSERT INTO `orders_logistics` VALUES (51, '10000041596616813', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-05 16:40:14', '2020-08-05 16:40:14', NULL);
INSERT INTO `orders_logistics` VALUES (52, '10000041596616950', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-05 16:42:30', '2020-08-05 16:42:30', NULL);
INSERT INTO `orders_logistics` VALUES (53, '10000351596621719', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-05 18:01:59', '2020-08-05 18:01:59', NULL);
INSERT INTO `orders_logistics` VALUES (54, '10000351596623124', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '百世快递', 'HTKY', '2222', NULL, NULL, '2020-08-05 18:25:25', '2020-08-05 20:17:32', NULL);
INSERT INTO `orders_logistics` VALUES (55, '10000131596623315', 1, 0.00, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '中通快递', 'ZTO', '123456789', 2, '[{\"context\":\"已下单【该信息由快递100提供】\",\"ftime\":\"2020-07-22 14:41:35\",\"time\":\"2020-07-22 14:41:35\"}]', '2020-08-05 18:28:35', '2020-08-11 18:17:45', NULL);
INSERT INTO `orders_logistics` VALUES (56, '10000131596623769', 1, 0.00, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-05 18:36:09', '2020-08-05 18:36:35', NULL);
INSERT INTO `orders_logistics` VALUES (57, '10000351596629189', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '百世快递', 'HTKY', '44', NULL, NULL, '2020-08-05 20:06:30', '2020-08-05 20:19:29', NULL);
INSERT INTO `orders_logistics` VALUES (58, '10000351596629958', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', '百世快递', 'HTKY', '444', NULL, NULL, '2020-08-05 20:19:19', '2020-08-05 20:22:34', NULL);
INSERT INTO `orders_logistics` VALUES (59, '10000041596636425', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-05 22:07:06', '2020-08-05 22:07:06', NULL);
INSERT INTO `orders_logistics` VALUES (60, '10000191596636556', 2, 0.00, 0.00, '王', '15001977677', '广东省', '深圳市', '宝安区', '海城路186-8号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '73135848004261', 2, '[{\"context\":\"【长沙岳麓区】（0731-89560475） 的 弘仓（0731-89560475） 已揽收\",\"ftime\":\"2020-08-10 16:54:30\",\"time\":\"2020-08-10 16:54:30\"},{\"context\":\"快件已经到达 【长沙中转部】\",\"ftime\":\"2020-08-13 16:32:28\",\"time\":\"2020-08-13 16:32:28\"},{\"context\":\"快件离开 【长沙中转部】 已发往 【深圳中心】\",\"ftime\":\"2020-08-13 18:24:07\",\"time\":\"2020-08-13 18:24:07\"},{\"context\":\"快件已经到达 【深圳中心】\",\"ftime\":\"2020-08-14 09:46:34\",\"time\":\"2020-08-14 09:46:34\"},{\"context\":\"快件离开 【深圳中心】 已发往 【深圳银田】\",\"ftime\":\"2020-08-14 10:39:59\",\"time\":\"2020-08-14 10:39:59\"},{\"context\":\"快件已经到达 【深圳银田】\",\"ftime\":\"2020-08-14 15:06:55\",\"time\":\"2020-08-14 15:06:55\"},{\"context\":\"【深圳银田】 的麻布林荣宝（16626626091） 正在第2次派件, 请保持电话畅通,并耐心等待（95720为中通快递员外呼专属号码，请放心接听）\",\"ftime\":\"2020-08-15 09:13:39\",\"time\":\"2020-08-15 09:13:39\"},{\"context\":\"您的快递已暂存至【快递超市的永丰中通快递便民点】, 等候您及时领取，如有问题请电联:（16626626091）, 投诉电话:（13715382203）, 感谢您使用中通快递, 期待再次为您服务!\",\"ftime\":\"2020-08-15 12:00:02\",\"time\":\"2020-08-15 12:00:02\"},{\"context\":\"您的快递已签收, 签收人在【快递超市的永丰中通快递便民点】(西乡街道永丰社区4区81号（校服店）中通快递)领取。如有疑问请电联:（16626626091）, 投诉电话:（13715382203）, 您的快递已经妥投。风里来雨里去, 只为客官您满意。上有老下有小, 赏个好评好不好？【请在评价快递员处帮忙点亮五颗星星哦~】\",\"ftime\":\"2020-08-15 20:37:48\",\"time\":\"2020-08-15 20:37:48\"}]', '2020-08-05 22:09:17', '2020-08-19 11:40:34', NULL);
INSERT INTO `orders_logistics` VALUES (61, '10000141596636596', 1, 0.00, 0.00, '陈南山', '18565619395', '广东省', '深圳市', '宝安区', '轻铁西花园1巷1号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2076464526453', 2, '[{\"context\":\"【云南省昆明市新亚洲】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-06 17:31:46\",\"time\":\"2020-08-06 17:31:46\"},{\"context\":\"【云南省昆明市新亚洲公司】 已收件 取件人: 王越 (13758188025)\",\"ftime\":\"2020-08-06 17:43:23\",\"time\":\"2020-08-06 17:43:23\"}]', '2020-08-05 22:09:57', '2020-08-07 17:42:46', NULL);
INSERT INTO `orders_logistics` VALUES (62, '10000131596637460', 1, 0.00, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-05 22:24:21', '2020-08-06 16:15:52', NULL);
INSERT INTO `orders_logistics` VALUES (63, '10000131596669066', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-06 07:11:06', '2020-08-06 07:11:06', NULL);
INSERT INTO `orders_logistics` VALUES (64, '10000401596673074', 2, 0.00, 0.00, '李海舟', '18565710771', '北京市', '北京市', '东城区', '南竹竿胡同2号银河SOHO-B座', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2076460429331', 2, '[{\"context\":\"【云南省昆明市新亚洲】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-06 17:26:47\",\"time\":\"2020-08-06 17:26:47\"},{\"context\":\"【云南省昆明市新亚洲公司】 已收件 取件人: 王越 (13758188025)\",\"ftime\":\"2020-08-06 17:28:10\",\"time\":\"2020-08-06 17:28:10\"},{\"context\":\"【昆明转运中心公司】 已收入\",\"ftime\":\"2020-08-07 21:58:28\",\"time\":\"2020-08-07 21:58:28\"},{\"context\":\"【昆明转运中心】 已发出 下一站 【北京转运中心公司】\",\"ftime\":\"2020-08-07 22:22:03\",\"time\":\"2020-08-07 22:22:03\"},{\"context\":\"【北京转运中心公司】 已收入\",\"ftime\":\"2020-08-10 03:19:42\",\"time\":\"2020-08-10 03:19:42\"},{\"context\":\"【北京转运中心】 已发出 下一站 【北京市东城区金宝街公司】\",\"ftime\":\"2020-08-10 03:46:46\",\"time\":\"2020-08-10 03:46:46\"},{\"context\":\"【北京市东城区金宝街公司】 已收入\",\"ftime\":\"2020-08-10 06:37:43\",\"time\":\"2020-08-10 06:37:43\"},{\"context\":\"【北京市东城区金宝街公司】 派件中 派件人: 彭凯 电话 18521850602 。 圆通快递小哥每天已测体温，请放心收寄快递 如有疑问，请联系：010-53176831\",\"ftime\":\"2020-08-10 07:04:46\",\"time\":\"2020-08-10 07:04:46\"},{\"context\":\"客户签收人: 李海舟 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：18521850602，投诉电话：010-53176831。疫情期间圆通每天对网点多次消毒，快递小哥每天测量体温，佩戴口罩\",\"ftime\":\"2020-08-10 13:54:15\",\"time\":\"2020-08-10 13:54:15\"}]', '2020-08-06 08:17:54', '2020-08-10 16:03:58', NULL);
INSERT INTO `orders_logistics` VALUES (65, '10000011596675710', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 09:01:50', '2020-08-06 09:01:50', NULL);
INSERT INTO `orders_logistics` VALUES (66, '10000131596676093', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-06 09:08:14', '2020-08-06 09:08:14', NULL);
INSERT INTO `orders_logistics` VALUES (67, '10000281596676496', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:14:57', '2020-08-06 09:14:57', NULL);
INSERT INTO `orders_logistics` VALUES (68, '10000001596676602', 1, 0.00, 0.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:16:43', '2020-08-06 09:16:43', NULL);
INSERT INTO `orders_logistics` VALUES (69, '10000011596676644', 1, 2.00, 10.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 09:17:25', '2020-08-06 09:17:25', NULL);
INSERT INTO `orders_logistics` VALUES (70, '10000001596676711', 1, 0.00, 0.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:18:32', '2020-08-06 09:18:32', NULL);
INSERT INTO `orders_logistics` VALUES (71, '10000001596676732', 1, 0.00, 0.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:18:52', '2020-08-06 09:18:52', NULL);
INSERT INTO `orders_logistics` VALUES (72, '10000001596676750', 1, 0.00, 0.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:19:11', '2020-08-06 09:19:11', NULL);
INSERT INTO `orders_logistics` VALUES (73, '10000001596676814', 1, 0.00, 0.00, 'more', '13246711966', '北京市', '北京市', '东城区', '3 2', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 09:20:14', '2020-08-06 09:20:14', NULL);
INSERT INTO `orders_logistics` VALUES (74, '10000131596677068', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-06 09:24:29', '2020-08-06 09:24:29', NULL);
INSERT INTO `orders_logistics` VALUES (75, '10000131596677158', 1, 0.00, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-06 09:25:58', '2020-08-06 09:26:24', NULL);
INSERT INTO `orders_logistics` VALUES (76, '10000131596677767', 1, NULL, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-06 09:36:08', '2020-08-06 09:36:08', NULL);
INSERT INTO `orders_logistics` VALUES (77, '10000131596677785', 1, 0.00, 1.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '顺丰速运', 'SF', '123456789', NULL, NULL, '2020-08-06 09:36:26', '2020-08-11 18:16:54', NULL);
INSERT INTO `orders_logistics` VALUES (78, '10000131596677841', 1, 0.00, 0.00, '李', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-06 09:37:22', '2020-08-06 11:09:23', NULL);
INSERT INTO `orders_logistics` VALUES (79, '10000261596678141', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 09:42:22', '2020-08-06 09:42:22', NULL);
INSERT INTO `orders_logistics` VALUES (80, '10000261596678158', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 09:42:38', '2020-08-06 09:42:38', NULL);
INSERT INTO `orders_logistics` VALUES (81, '10000261596678169', 1, 2.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 09:42:50', '2020-08-06 09:42:50', NULL);
INSERT INTO `orders_logistics` VALUES (82, '10000351596678599', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:49:59', '2020-08-06 09:49:59', NULL);
INSERT INTO `orders_logistics` VALUES (83, '10000351596678664', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:51:05', '2020-08-06 09:51:05', NULL);
INSERT INTO `orders_logistics` VALUES (84, '10000351596678846', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:54:07', '2020-08-06 09:54:07', NULL);
INSERT INTO `orders_logistics` VALUES (85, '10000351596678876', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:54:37', '2020-08-06 09:54:37', NULL);
INSERT INTO `orders_logistics` VALUES (86, '10000351596679052', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:57:32', '2020-08-06 09:57:32', NULL);
INSERT INTO `orders_logistics` VALUES (87, '10000351596679094', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 09:58:14', '2020-08-06 09:58:14', NULL);
INSERT INTO `orders_logistics` VALUES (88, '10000351596679490', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 10:04:51', '2020-08-06 10:04:51', NULL);
INSERT INTO `orders_logistics` VALUES (89, '10000041596680109', 1, 2.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 10:15:10', '2020-08-06 10:15:10', NULL);
INSERT INTO `orders_logistics` VALUES (90, '10000691596695434', 1, 0.00, 1.00, '收货人: ', '15170707821', '\n所在地区: 广东省', '深圳市', '宝安区', '宝安区\n详细地址: 安华35区塘坊花园一巷21号D6栋。2楼', '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '顺丰速运', 'SF', '123456789', NULL, NULL, '2020-08-06 14:30:34', '2020-08-06 14:35:46', NULL);
INSERT INTO `orders_logistics` VALUES (91, '10000701596696099', 1, 0.00, 1.00, '李', '18720083102', '江西省', '萍乡市', '莲花县', '泉水村', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-06 14:41:39', '2020-08-06 14:46:14', NULL);
INSERT INTO `orders_logistics` VALUES (92, '10000281596698936', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:28:57', '2020-08-06 15:28:57', NULL);
INSERT INTO `orders_logistics` VALUES (93, '10000281596699011', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:30:12', '2020-08-06 15:30:12', NULL);
INSERT INTO `orders_logistics` VALUES (94, '10000281596699044', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:30:44', '2020-08-06 15:30:44', NULL);
INSERT INTO `orders_logistics` VALUES (95, '10000281596699053', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:30:53', '2020-08-06 15:30:53', NULL);
INSERT INTO `orders_logistics` VALUES (96, '10000281596699122', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:32:02', '2020-08-06 15:32:02', NULL);
INSERT INTO `orders_logistics` VALUES (97, '10000281596699325', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:35:26', '2020-08-06 15:35:26', NULL);
INSERT INTO `orders_logistics` VALUES (98, '10000281596699432', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 15:37:12', '2020-08-06 15:37:12', NULL);
INSERT INTO `orders_logistics` VALUES (99, '10000061596701197', 1, 5.00, 6.00, '易葱', '13212713350', '海南省', '海口市', '秀英区', '德玛hello', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 16:06:38', '2020-08-06 16:06:38', NULL);
INSERT INTO `orders_logistics` VALUES (100, '10000011596704924', 1, 0.00, 0.00, '吴彦祖', '15873231388', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 17:08:44', '2020-08-06 17:08:44', NULL);
INSERT INTO `orders_logistics` VALUES (101, '10000261596705610', 1, 5.00, 5.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:20:10', '2020-08-06 17:20:10', NULL);
INSERT INTO `orders_logistics` VALUES (102, '10000261596705999', 1, 5.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:26:39', '2020-08-06 17:26:39', NULL);
INSERT INTO `orders_logistics` VALUES (103, '10000041596706302', 1, 5.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:31:42', '2020-08-06 17:31:42', NULL);
INSERT INTO `orders_logistics` VALUES (104, '10000041596706316', 1, 5.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街山东', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:31:56', '2020-08-06 17:31:56', NULL);
INSERT INTO `orders_logistics` VALUES (105, '10000711596707009', 1, 0.00, 0.00, 'yan', '18038003905', '北京市', '北京市', '海淀区', '王庄路27号汉庭优佳酒店', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 17:43:30', '2020-08-06 17:43:30', NULL);
INSERT INTO `orders_logistics` VALUES (106, '10000711596707088', 2, 0.00, 0.00, 'yan', '18038003905', '北京市', '北京市', '海淀区', '王庄路27号汉庭优佳酒店', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2076606627886', 2, '[{\"context\":\"【云南省昆明市新亚洲公司】 已收件 取件人: 王佳倩 (18815291887)\",\"ftime\":\"2020-08-07 14:33:57\",\"time\":\"2020-08-07 14:33:57\"},{\"context\":\"【云南省昆明市新亚洲】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-07 14:34:07\",\"time\":\"2020-08-07 14:34:07\"},{\"context\":\"【昆明转运中心公司】 已收入\",\"ftime\":\"2020-08-08 01:50:25\",\"time\":\"2020-08-08 01:50:25\"},{\"context\":\"【昆明转运中心】 已发出 下一站 【北京转运中心公司】\",\"ftime\":\"2020-08-08 02:12:22\",\"time\":\"2020-08-08 02:12:22\"},{\"context\":\"【北京转运中心公司】 已收入\",\"ftime\":\"2020-08-10 02:49:28\",\"time\":\"2020-08-10 02:49:28\"},{\"context\":\"【北京转运中心】 已发出 下一站 【华北昌平城配中心公司】\",\"ftime\":\"2020-08-10 03:10:44\",\"time\":\"2020-08-10 03:10:44\"},{\"context\":\"【华北昌平城配中心公司】 已收入\",\"ftime\":\"2020-08-10 05:30:00\",\"time\":\"2020-08-10 05:30:00\"},{\"context\":\"【华北昌平城配中心】 已发出 下一站 【北京市海淀区学清路公司】\",\"ftime\":\"2020-08-10 05:59:48\",\"time\":\"2020-08-10 05:59:48\"},{\"context\":\"【北京市海淀区学清路公司】 已收入\",\"ftime\":\"2020-08-10 14:18:45\",\"time\":\"2020-08-10 14:18:45\"},{\"context\":\"【北京市海淀区学清路公司】 派件中 派件人: 郝亚超 电话 15733930363 。 圆通快递小哥每天已测体温，请放心收寄快递 如有疑问，请联系：010-53730802\",\"ftime\":\"2020-08-10 14:20:27\",\"time\":\"2020-08-10 14:20:27\"},{\"context\":\"客户签收人: 门卫 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：15733930363，投诉电话：010-53730802。疫情期间圆通每天对网点多次消毒，快递小哥每天测量体温，佩戴口罩\",\"ftime\":\"2020-08-10 17:58:19\",\"time\":\"2020-08-10 17:58:19\"}]', '2020-08-06 17:44:49', '2020-08-11 15:36:06', NULL);
INSERT INTO `orders_logistics` VALUES (107, '10000011596707162', 1, 5.00, 10.00, '吴笛', '15873231388', '广东省', '深圳市', '宝安区', '西乡街道宝源二路海滨新村2栋307', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:46:02', '2020-08-06 17:46:02', NULL);
INSERT INTO `orders_logistics` VALUES (108, '10000011596707255', 1, 5.00, 10.00, '王子', '18486666898', '广东省', '深圳市', '宝安区', '泰逸大厦702', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 17:47:35', '2020-08-06 17:47:35', NULL);
INSERT INTO `orders_logistics` VALUES (109, '10000131596707941', 1, 0.00, 1.00, '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '中通快递', 'ZTO', '1234567890', NULL, NULL, '2020-08-06 17:59:02', '2020-08-11 18:16:23', NULL);
INSERT INTO `orders_logistics` VALUES (110, '10000131596707942', 1, 0.00, 1.00, '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '中通快递', 'ZTO', '73135415313151', 2, '[{\"context\":\"【广西市场部】（0771-4669355） 的 直客-骆宇轩鲜果（0771-4669238） 已揽收\",\"ftime\":\"2020-08-01 18:45:01\",\"time\":\"2020-08-01 18:45:01\"},{\"context\":\"快件离开 【广西市场部】 已发往 【南宁中转】\",\"ftime\":\"2020-08-01 18:48:13\",\"time\":\"2020-08-01 18:48:13\"},{\"context\":\"快件已经到达 【南宁中转】\",\"ftime\":\"2020-08-02 00:18:13\",\"time\":\"2020-08-02 00:18:13\"},{\"context\":\"快件离开 【南宁中转】 已发往 【深圳中心】\",\"ftime\":\"2020-08-02 00:21:29\",\"time\":\"2020-08-02 00:21:29\"},{\"context\":\"快件已经到达 【深圳中心】\",\"ftime\":\"2020-08-02 12:51:24\",\"time\":\"2020-08-02 12:51:24\"},{\"context\":\"快件离开 【深圳中心】 已发往 【深圳银田】\",\"ftime\":\"2020-08-02 12:52:32\",\"time\":\"2020-08-02 12:52:32\"},{\"context\":\"快件已经到达 【深圳银田】\",\"ftime\":\"2020-08-02 15:02:25\",\"time\":\"2020-08-02 15:02:25\"},{\"context\":\"【深圳银田】 的麻布吴岳峰（13824380347） 正在第1次派件, 请保持电话畅通,并耐心等待（95720为中通快递员外呼专属号码，请放心接听）\",\"ftime\":\"2020-08-02 16:20:39\",\"time\":\"2020-08-02 16:20:39\"},{\"context\":\"快件已在 【深圳银田】 签收, 签收人: 管理处, 如有疑问请电联:（13824380347）, 投诉电话:（0755-61230928）, 您的快递已经妥投。风里来雨里去, 只为客官您满意。上有老下有小, 赏个好评好不好？【请在评价快递员处帮忙点亮五颗星星哦~】\",\"ftime\":\"2020-08-02 17:48:39\",\"time\":\"2020-08-02 17:48:39\"}]', '2020-08-06 17:59:03', '2020-08-07 16:25:02', NULL);
INSERT INTO `orders_logistics` VALUES (111, '10000281596708043', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 18:00:44', '2020-08-06 18:00:44', NULL);
INSERT INTO `orders_logistics` VALUES (112, '10000281596708086', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '国际航空', NULL, NULL, '2020-08-06 18:01:27', '2020-08-06 18:02:31', NULL);
INSERT INTO `orders_logistics` VALUES (113, '10000281596708250', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-06 18:04:11', '2020-08-06 18:04:11', NULL);
INSERT INTO `orders_logistics` VALUES (114, '10000081596711429', 1, 4.00, 9.00, 'ee', '15865435435', '广东省', '韶关市', '乐昌市', '我', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-06 18:57:10', '2020-08-06 18:57:10', NULL);
INSERT INTO `orders_logistics` VALUES (115, '10000131596714299', 1, 0.00, 1.00, '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-06 19:45:00', '2020-08-06 19:45:52', NULL);
INSERT INTO `orders_logistics` VALUES (116, '10000351596714917', 1, 0.00, 10.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-06 19:55:18', '2020-08-06 20:10:33', NULL);
INSERT INTO `orders_logistics` VALUES (117, '10000351596720880', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-06 21:34:40', '2020-08-06 21:34:40', NULL);
INSERT INTO `orders_logistics` VALUES (118, '10000261596749737', 1, 5.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 05:35:38', '2020-08-07 05:35:38', NULL);
INSERT INTO `orders_logistics` VALUES (119, '10000131596775276', 1, 0.00, 1.00, '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 12:41:17', '2020-08-07 12:41:17', NULL);
INSERT INTO `orders_logistics` VALUES (120, '10000281596784649', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-07 15:17:29', '2020-08-07 15:17:29', NULL);
INSERT INTO `orders_logistics` VALUES (121, '10000131596784673', 2, 0.00, 1.00, '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '李永华', '13246711966', '北京市', '北京市', '东城区', '阿6', '中通快递', 'ZTO', '73135415313151', 2, '[{\"context\":\"【广西市场部】（0771-4669355） 的 直客-骆宇轩鲜果（0771-4669238） 已揽收\",\"ftime\":\"2020-08-01 18:45:01\",\"time\":\"2020-08-01 18:45:01\"},{\"context\":\"快件离开 【广西市场部】 已发往 【南宁中转】\",\"ftime\":\"2020-08-01 18:48:13\",\"time\":\"2020-08-01 18:48:13\"},{\"context\":\"快件已经到达 【南宁中转】\",\"ftime\":\"2020-08-02 00:18:13\",\"time\":\"2020-08-02 00:18:13\"},{\"context\":\"快件离开 【南宁中转】 已发往 【深圳中心】\",\"ftime\":\"2020-08-02 00:21:29\",\"time\":\"2020-08-02 00:21:29\"},{\"context\":\"快件已经到达 【深圳中心】\",\"ftime\":\"2020-08-02 12:51:24\",\"time\":\"2020-08-02 12:51:24\"},{\"context\":\"快件离开 【深圳中心】 已发往 【深圳银田】\",\"ftime\":\"2020-08-02 12:52:32\",\"time\":\"2020-08-02 12:52:32\"},{\"context\":\"快件已经到达 【深圳银田】\",\"ftime\":\"2020-08-02 15:02:25\",\"time\":\"2020-08-02 15:02:25\"},{\"context\":\"【深圳银田】 的麻布吴岳峰（13824380347） 正在第1次派件, 请保持电话畅通,并耐心等待（95720为中通快递员外呼专属号码，请放心接听）\",\"ftime\":\"2020-08-02 16:20:39\",\"time\":\"2020-08-02 16:20:39\"},{\"context\":\"快件已在 【深圳银田】 签收, 签收人: 管理处, 如有疑问请电联:（13824380347）, 投诉电话:（0755-61230928）, 您的快递已经妥投。风里来雨里去, 只为客官您满意。上有老下有小, 赏个好评好不好？【请在评价快递员处帮忙点亮五颗星星哦~】\",\"ftime\":\"2020-08-02 17:48:39\",\"time\":\"2020-08-02 17:48:39\"}]', '2020-08-07 15:17:54', '2020-08-07 16:57:44', NULL);
INSERT INTO `orders_logistics` VALUES (122, '10000281596784702', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-07 15:18:22', '2020-08-07 15:18:22', NULL);
INSERT INTO `orders_logistics` VALUES (123, '10000281596784750', 1, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-07 15:19:10', '2020-08-07 15:19:10', NULL);
INSERT INTO `orders_logistics` VALUES (124, '10000281596785583', 2, 0.00, 0.00, '自己', '13686871951', '北京市', '北京市', '东城区', '曲终人未散', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '73135415313151', 2, '[{\"context\":\"【广西市场部】（0771-4669355） 的 直客-骆宇轩鲜果（0771-4669238） 已揽收\",\"ftime\":\"2020-08-01 18:45:01\",\"time\":\"2020-08-01 18:45:01\"},{\"context\":\"快件离开 【广西市场部】 已发往 【南宁中转】\",\"ftime\":\"2020-08-01 18:48:13\",\"time\":\"2020-08-01 18:48:13\"},{\"context\":\"快件已经到达 【南宁中转】\",\"ftime\":\"2020-08-02 00:18:13\",\"time\":\"2020-08-02 00:18:13\"},{\"context\":\"快件离开 【南宁中转】 已发往 【深圳中心】\",\"ftime\":\"2020-08-02 00:21:29\",\"time\":\"2020-08-02 00:21:29\"},{\"context\":\"快件已经到达 【深圳中心】\",\"ftime\":\"2020-08-02 12:51:24\",\"time\":\"2020-08-02 12:51:24\"},{\"context\":\"快件离开 【深圳中心】 已发往 【深圳银田】\",\"ftime\":\"2020-08-02 12:52:32\",\"time\":\"2020-08-02 12:52:32\"},{\"context\":\"快件已经到达 【深圳银田】\",\"ftime\":\"2020-08-02 15:02:25\",\"time\":\"2020-08-02 15:02:25\"},{\"context\":\"【深圳银田】 的麻布吴岳峰（13824380347） 正在第1次派件, 请保持电话畅通,并耐心等待（95720为中通快递员外呼专属号码，请放心接听）\",\"ftime\":\"2020-08-02 16:20:39\",\"time\":\"2020-08-02 16:20:39\"},{\"context\":\"快件已在 【深圳银田】 签收, 签收人: 管理处, 如有疑问请电联:（13824380347）, 投诉电话:（0755-61230928）, 您的快递已经妥投。风里来雨里去, 只为客官您满意。上有老下有小, 赏个好评好不好？【请在评价快递员处帮忙点亮五颗星星哦~】\",\"ftime\":\"2020-08-02 17:48:39\",\"time\":\"2020-08-02 17:48:39\"}]', '2020-08-07 15:33:04', '2020-08-08 07:46:05', NULL);
INSERT INTO `orders_logistics` VALUES (125, '10000041596786260', 1, 5.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 15:44:20', '2020-08-07 15:44:20', NULL);
INSERT INTO `orders_logistics` VALUES (126, '10000041596786262', 1, 5.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 15:44:22', '2020-08-07 15:44:22', NULL);
INSERT INTO `orders_logistics` VALUES (127, '10000041596786683', 1, 5.00, 10.00, '张三丰', '18755582355', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 15:51:23', '2020-08-07 15:51:23', NULL);
INSERT INTO `orders_logistics` VALUES (128, '10000261596788448', 1, 5.00, 10.00, '张三丰', '15010001000', '北京市', '北京市', '东城区', '东大街', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-07 16:20:48', '2020-08-07 16:20:48', NULL);
INSERT INTO `orders_logistics` VALUES (129, '10000171596844039', 1, 0.00, 1.00, '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-08 07:47:19', '2020-08-08 07:50:21', NULL);
INSERT INTO `orders_logistics` VALUES (130, '10000141596867606', 1, 0.00, 0.00, '陈南山', '18565619395', '广东省', '深圳市', '宝安区', '轻铁西花园1巷1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-08 14:20:07', '2020-08-08 14:20:07', NULL);
INSERT INTO `orders_logistics` VALUES (131, '10000141596867657', 1, 0.00, 0.00, '诚物', '18812349999', '广东省', '深圳市', '宝安区', '财富港大厦', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-08 14:20:58', '2020-08-08 14:20:58', NULL);
INSERT INTO `orders_logistics` VALUES (132, '10000141596867664', 1, 0.00, 0.00, '诚物', '18812349999', '广东省', '深圳市', '宝安区', '财富港大厦', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-08 14:21:05', '2020-08-08 14:21:05', NULL);
INSERT INTO `orders_logistics` VALUES (133, '10000751597050899', 1, 0.00, 0.00, '蔡瑞昌', '13145951692', '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-10 17:15:00', '2020-08-10 17:15:00', NULL);
INSERT INTO `orders_logistics` VALUES (134, '10000751597051376', 2, 0.00, 0.00, '蔡瑞昌', '13145951692', '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2077573201663', 2, '[{\"context\":\"【陕西省西安中心直营市场部公司】 已收件 取件人: 成俊鹏 (18729902279)\",\"ftime\":\"2020-08-11 21:03:49\",\"time\":\"2020-08-11 21:03:49\"},{\"context\":\"【西安转运中心公司】 已收入\",\"ftime\":\"2020-08-13 01:06:59\",\"time\":\"2020-08-13 01:06:59\"},{\"context\":\"【西安转运中心公司】 已打包\",\"ftime\":\"2020-08-13 01:21:35\",\"time\":\"2020-08-13 01:21:35\"},{\"context\":\"【西安转运中心】 已发出 下一站 【深圳转运中心公司】\",\"ftime\":\"2020-08-13 01:35:27\",\"time\":\"2020-08-13 01:35:27\"},{\"context\":\"【深圳转运中心公司】 已收入\",\"ftime\":\"2020-08-14 09:35:30\",\"time\":\"2020-08-14 09:35:30\"},{\"context\":\"【深圳转运中心】 已发出 下一站 【广东省深圳市盐田分公司公司】\",\"ftime\":\"2020-08-14 09:59:47\",\"time\":\"2020-08-14 09:59:47\"},{\"context\":\"【广东省深圳市盐田分公司公司】 已收入\",\"ftime\":\"2020-08-14 12:57:08\",\"time\":\"2020-08-14 12:57:08\"},{\"context\":\"【广东省深圳市盐田分公司公司】 派件中 派件人: 彭华 电话 13590359167 如有疑问，请联系：0755-25359499\",\"ftime\":\"2020-08-14 15:09:53\",\"time\":\"2020-08-14 15:09:53\"},{\"context\":\"快件已存放至鹏广达山海四季城花园C栋速递易【自提柜】，请及时取件。有问题请联系派件员13590359167\",\"ftime\":\"2020-08-14 17:19:12\",\"time\":\"2020-08-14 17:19:12\"},{\"context\":\"客户签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：13590359167，投诉电话：0755-25359499\",\"ftime\":\"2020-08-15 19:29:16\",\"time\":\"2020-08-15 19:29:16\"}]', '2020-08-10 17:22:57', '2020-08-19 11:40:27', NULL);
INSERT INTO `orders_logistics` VALUES (135, '10000991597068770', 1, NULL, 0.00, '李雅萍', '13925756106', '广东省', '东莞市', '南城街道', '海雅百货二楼', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-10 22:12:51', '2020-08-10 22:12:51', NULL);
INSERT INTO `orders_logistics` VALUES (136, '10000131597068825', 1, 0.00, 0.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-10 22:13:46', '2020-08-10 22:17:40', NULL);
INSERT INTO `orders_logistics` VALUES (137, '10000131597069256', 1, 0.00, 0.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', '', '无', NULL, NULL, '2020-08-10 22:20:57', '2020-08-10 22:24:24', NULL);
INSERT INTO `orders_logistics` VALUES (138, '10000131597080410', 1, 0.00, 1.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '自行配送', 'SF', '无', NULL, NULL, '2020-08-11 01:26:50', '2020-08-11 01:27:26', NULL);
INSERT INTO `orders_logistics` VALUES (139, '10000751597083446', 1, NULL, 0.00, '蔡瑞昌', '13145951692', '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-11 02:17:26', '2020-08-11 02:17:26', NULL);
INSERT INTO `orders_logistics` VALUES (140, '10000751597083512', 1, 0.00, 0.00, '蔡瑞昌', '13145951692', '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-11 02:18:32', '2020-08-11 02:18:32', NULL);
INSERT INTO `orders_logistics` VALUES (141, '10000751597106994', 1, 5.00, 5.00, '蔡瑞昌', '13145951692', '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', NULL, NULL, NULL, NULL, NULL, NULL, '圆通速递', 'YTO', NULL, NULL, NULL, '2020-08-11 08:49:55', '2020-08-11 08:49:55', NULL);
INSERT INTO `orders_logistics` VALUES (142, '10001071597112277', 1, NULL, 0.00, '孙灿', '13543316937', '广东省', '深圳市', '龙岗区', '龙岗大道东方盛世花园C1-703', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-11 10:17:57', '2020-08-11 10:17:57', NULL);
INSERT INTO `orders_logistics` VALUES (143, '10000171597114252', 1, 0.00, 1.00, '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-11 10:50:52', '2020-08-11 10:50:52', NULL);
INSERT INTO `orders_logistics` VALUES (144, '10001131597118933', 1, NULL, 0.00, '戴励', '15820773736', '广东省', '深圳市', '福田区', '景田北六街景田天健花园5栋301', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-11 12:08:54', '2020-08-11 12:08:54', NULL);
INSERT INTO `orders_logistics` VALUES (145, '10001131597118984', 1, NULL, 0.00, '戴励', '15820773736', '广东省', '深圳市', '福田区', '景田北六街景田天健花园5栋301', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-11 12:09:45', '2020-08-11 12:09:45', NULL);
INSERT INTO `orders_logistics` VALUES (146, '10000131597138125', 1, 0.00, 0.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '73135848004261', 2, '[{\"context\":\"【长沙岳麓区】（0731-89560475） 的 弘仓（0731-89560475） 已揽收\",\"ftime\":\"2020-08-10 16:54:30\",\"time\":\"2020-08-10 16:54:30\"}]', '2020-08-11 17:28:46', '2020-08-11 17:32:15', NULL);
INSERT INTO `orders_logistics` VALUES (147, '10000131597140391', 1, 0.00, 0.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '73135848004261', 2, '[{\"context\":\"【长沙岳麓区】（0731-89560475） 的 弘仓（0731-89560475） 已揽收\",\"ftime\":\"2020-08-10 16:54:30\",\"time\":\"2020-08-10 16:54:30\"}]', '2020-08-11 18:06:31', '2020-08-11 18:08:00', NULL);
INSERT INTO `orders_logistics` VALUES (148, '10000061597140570', 1, 0.00, 1.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', '中通快递', 'ZTO', '123456789', 2, '[{\"context\":\"已下单【该信息由快递100提供】\",\"ftime\":\"2020-08-12 12:32:31\",\"time\":\"2020-08-12 12:32:31\"}]', '2020-08-11 18:09:30', '2020-08-20 19:29:58', NULL);
INSERT INTO `orders_logistics` VALUES (149, '10000061597142551', 1, 0.00, 1.00, '易葱', '13212713350', '海南省', '三沙市', '西沙群岛', '诺克幼儿园', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-11 18:42:31', '2020-08-11 18:42:31', NULL);
INSERT INTO `orders_logistics` VALUES (150, '10000141597142955', 1, 0.00, 0.00, '陈南山', '18565619395', '广东省', '深圳市', '宝安区', '轻铁西花园1巷1号', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-11 18:49:16', '2020-08-11 18:49:16', NULL);
INSERT INTO `orders_logistics` VALUES (151, '10000081597144271', 1, 0.00, 0.00, '荀先生', '15338753605', '广东省', '深圳市', '宝安区', '海城路泰逸大厦702', NULL, NULL, NULL, NULL, NULL, NULL, '百世快递', 'HTKY', NULL, NULL, NULL, '2020-08-11 19:11:11', '2020-08-11 19:11:11', NULL);
INSERT INTO `orders_logistics` VALUES (152, '10000351597144411', 1, 0.00, 0.00, '牛牛', '18912341234', '广东省', '深圳市', '宝安区', '劳动路41-1号', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-11 19:13:31', '2020-08-11 19:13:31', NULL);
INSERT INTO `orders_logistics` VALUES (153, '10000131597373918', 1, 0.00, 1.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-14 10:58:39', '2020-08-14 10:58:39', NULL);
INSERT INTO `orders_logistics` VALUES (154, '10000131597386596', 1, 0.00, 1.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-14 14:29:56', '2020-08-14 14:29:56', NULL);
INSERT INTO `orders_logistics` VALUES (155, '10000131597397343', 1, 0.00, 1.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-14 17:29:03', '2020-08-14 17:29:03', NULL);
INSERT INTO `orders_logistics` VALUES (156, '10000131597741477', 1, 0.00, 1.00, '李永华', '13246711966', '广东省', '深圳市', '宝安区', '径贝新村112-4号', NULL, NULL, NULL, NULL, NULL, NULL, '顺丰速运', 'SF', NULL, NULL, NULL, '2020-08-18 17:04:38', '2020-08-18 17:04:38', NULL);
INSERT INTO `orders_logistics` VALUES (157, '10000951597743580', 1, 0.00, 0.00, '许洪霞', '13430388157', '广东省', '深圳市', '宝安区', '海城路235号泰逸大厦7楼702室', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-18 17:39:41', '2020-08-18 17:39:41', NULL);
INSERT INTO `orders_logistics` VALUES (158, '10000951597743586', 2, 0.00, 0.00, '许洪霞', '13430388157', '广东省', '深圳市', '宝安区', '海城路235号泰逸大厦7楼702室', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '韵达速递', 'YD', '4307783863141', 2, '[{\"context\":\"[陕西澄城县公司]【渭南市】陕西澄城县公司 已揽收\",\"ftime\":\"2020-08-20 14:48:22\",\"time\":\"2020-08-20 14:48:22\"},{\"context\":\"[陕西西安分拨中心]【西安市】已到达 陕西西安分拨中心\",\"ftime\":\"2020-08-20 19:40:40\",\"time\":\"2020-08-20 19:40:40\"},{\"context\":\"[陕西西安分拨中心]【西安市】已离开 陕西西安分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-08-20 19:42:00\",\"time\":\"2020-08-20 19:42:00\"},{\"context\":\"[广东深圳公司]【深圳市】已到达 广东深圳公司\",\"ftime\":\"2020-08-22 02:39:46\",\"time\":\"2020-08-22 02:39:46\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区西乡分拨分部\",\"ftime\":\"2020-08-22 02:55:20\",\"time\":\"2020-08-22 02:55:20\"},{\"context\":\"[广东深圳公司宝安区西乡分拨分部]【深圳市】已离开 广东深圳公司宝安区西乡分拨分部；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-08-22 06:26:10\",\"time\":\"2020-08-22 06:26:10\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 王令18977206201 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-08-22 09:54:52\",\"time\":\"2020-08-22 09:54:52\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：泰逸大厦1楼保安处旁，如有疑问请电联快递员：王令【18977206201】。\",\"ftime\":\"2020-08-22 12:09:17\",\"time\":\"2020-08-22 12:09:17\"}]', '2020-08-18 17:39:47', '2020-08-22 20:06:11', NULL);
INSERT INTO `orders_logistics` VALUES (159, '10001481597744483', 1, 0.00, 0.00, '张洁', '13682648914', '广东省', '深圳市', '宝安区', '西乡街道海城路泰逸大厦7楼F7-002', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-18 17:54:43', '2020-08-18 17:54:43', NULL);
INSERT INTO `orders_logistics` VALUES (160, '10001481597744851', 2, 0.00, 0.00, '张洁', '13682648914', '广东省', '深圳市', '宝安区', '西乡街道海城路泰逸大厦7楼F7-002', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2079220208000', 2, '[{\"context\":\"【云南省昆明市新迎公司】 已收件 取件人: 李平 (18521156579)\",\"ftime\":\"2020-08-19 18:23:11\",\"time\":\"2020-08-19 18:23:11\"},{\"context\":\"【云南省昆明市新迎】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-19 18:23:21\",\"time\":\"2020-08-19 18:23:21\"},{\"context\":\"【云南省市场部】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-19 18:25:07\",\"time\":\"2020-08-19 18:25:07\"},{\"context\":\"【昆明转运中心公司】 已收入\",\"ftime\":\"2020-08-20 13:10:51\",\"time\":\"2020-08-20 13:10:51\"},{\"context\":\"【昆明转运中心】 已发出 下一站 【深圳转运中心公司】\",\"ftime\":\"2020-08-20 13:37:52\",\"time\":\"2020-08-20 13:37:52\"},{\"context\":\"【深圳转运中心公司】 已收入\",\"ftime\":\"2020-08-22 07:16:12\",\"time\":\"2020-08-22 07:16:12\"},{\"context\":\"【深圳转运中心】 已发出 下一站 【广东省深圳市宝安区新城公司】\",\"ftime\":\"2020-08-22 07:39:50\",\"time\":\"2020-08-22 07:39:50\"},{\"context\":\"【广东省深圳市宝安区新城公司】 已收入\",\"ftime\":\"2020-08-22 13:16:50\",\"time\":\"2020-08-22 13:16:50\"},{\"context\":\"【广东省深圳市宝安区新城公司】 派件中 派件人: 李龙 电话 13728571436 如有疑问，请联系：0755-29376921\",\"ftime\":\"2020-08-22 14:19:46\",\"time\":\"2020-08-22 14:19:46\"},{\"context\":\"客户签收人: 前台 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：13728571436，投诉电话：0755-29376921\",\"ftime\":\"2020-08-22 16:53:43\",\"time\":\"2020-08-22 16:53:43\"}]', '2020-08-18 18:00:51', '2020-08-22 20:11:08', NULL);
INSERT INTO `orders_logistics` VALUES (161, '10000171597744978', 2, 0.00, 0.00, '红霞', '13430388157', '广东省', '深圳市', '宝安区', '海城路235号泰逸大厦7楼702', '袁凯强', '18706821922', '陕西省', '渭南市', '澄城县', '尧头镇浴子河村一组', '韵达速递', 'YD', '4307783863141', 2, '[{\"context\":\"[陕西澄城县公司]【渭南市】陕西澄城县公司 已揽收\",\"ftime\":\"2020-08-20 14:48:22\",\"time\":\"2020-08-20 14:48:22\"},{\"context\":\"[陕西西安分拨中心]【西安市】已到达 陕西西安分拨中心\",\"ftime\":\"2020-08-20 19:40:40\",\"time\":\"2020-08-20 19:40:40\"},{\"context\":\"[陕西西安分拨中心]【西安市】已离开 陕西西安分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-08-20 19:42:00\",\"time\":\"2020-08-20 19:42:00\"},{\"context\":\"[广东深圳公司]【深圳市】已到达 广东深圳公司\",\"ftime\":\"2020-08-22 02:39:46\",\"time\":\"2020-08-22 02:39:46\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区西乡分拨分部\",\"ftime\":\"2020-08-22 02:55:20\",\"time\":\"2020-08-22 02:55:20\"},{\"context\":\"[广东深圳公司宝安区西乡分拨分部]【深圳市】已离开 广东深圳公司宝安区西乡分拨分部；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-08-22 06:26:10\",\"time\":\"2020-08-22 06:26:10\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 王令18977206201 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-08-22 09:54:52\",\"time\":\"2020-08-22 09:54:52\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：泰逸大厦1楼保安处旁，如有疑问请电联快递员：王令【18977206201】。\",\"ftime\":\"2020-08-22 12:09:17\",\"time\":\"2020-08-22 12:09:17\"}]', '2020-08-18 18:02:59', '2020-08-22 21:51:13', NULL);
INSERT INTO `orders_logistics` VALUES (162, '10000161597745898', 2, 0.00, 0.00, '崔', '15099900112', '广东省', '深圳市', '宝安区', '海城路泰逸大厦F7002', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '韵达速递', 'YD', '4307783820437', 2, '[{\"context\":\"[陕西澄城县公司]【渭南市】陕西澄城县公司 已揽收\",\"ftime\":\"2020-08-20 14:47:59\",\"time\":\"2020-08-20 14:47:59\"},{\"context\":\"[陕西西安分拨中心]【西安市】已到达 陕西西安分拨中心\",\"ftime\":\"2020-08-20 20:04:08\",\"time\":\"2020-08-20 20:04:08\"},{\"context\":\"[陕西西安分拨中心]【西安市】已离开 陕西西安分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-08-20 20:35:45\",\"time\":\"2020-08-20 20:35:45\"},{\"context\":\"[广东深圳公司]【深圳市】已到达 广东深圳公司\",\"ftime\":\"2020-08-22 02:21:25\",\"time\":\"2020-08-22 02:21:25\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区西乡分拨分部\",\"ftime\":\"2020-08-22 03:12:44\",\"time\":\"2020-08-22 03:12:44\"},{\"context\":\"[广东深圳公司宝安区西乡分拨分部]【深圳市】已离开 广东深圳公司宝安区西乡分拨分部；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-08-22 06:37:28\",\"time\":\"2020-08-22 06:37:28\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 王令18977206201 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-08-22 09:44:44\",\"time\":\"2020-08-22 09:44:44\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：泰逸大厦1楼保安处旁，如有疑问请电联快递员：王令【18977206201】。\",\"ftime\":\"2020-08-22 12:09:19\",\"time\":\"2020-08-22 12:09:19\"}]', '2020-08-18 18:18:18', '2020-08-22 20:10:45', NULL);
INSERT INTO `orders_logistics` VALUES (163, '10000171597746299', 2, 0.00, 0.00, '崔生生', '15099900112', '广东省', '深圳市', '宝安区', '海城路泰逸大厦F7002', '袁凯强', '18706821922', '陕西省', '渭南市', '澄城县', '尧头镇浴子河村一组', '韵达速递', 'YD', '4307783820437', 2, '[{\"context\":\"[陕西澄城县公司]【渭南市】陕西澄城县公司 已揽收\",\"ftime\":\"2020-08-20 14:47:59\",\"time\":\"2020-08-20 14:47:59\"},{\"context\":\"[陕西西安分拨中心]【西安市】已到达 陕西西安分拨中心\",\"ftime\":\"2020-08-20 20:04:08\",\"time\":\"2020-08-20 20:04:08\"},{\"context\":\"[陕西西安分拨中心]【西安市】已离开 陕西西安分拨中心；发往 广东深圳公司\",\"ftime\":\"2020-08-20 20:35:45\",\"time\":\"2020-08-20 20:35:45\"},{\"context\":\"[广东深圳公司]【深圳市】已到达 广东深圳公司\",\"ftime\":\"2020-08-22 02:21:25\",\"time\":\"2020-08-22 02:21:25\"},{\"context\":\"[广东深圳公司]【深圳市】已离开 广东深圳公司；发往 广东深圳公司宝安区西乡分拨分部\",\"ftime\":\"2020-08-22 03:12:44\",\"time\":\"2020-08-22 03:12:44\"},{\"context\":\"[广东深圳公司宝安区西乡分拨分部]【深圳市】已离开 广东深圳公司宝安区西乡分拨分部；发往 广东深圳公司宝安区渔业社区分部\",\"ftime\":\"2020-08-22 06:37:28\",\"time\":\"2020-08-22 06:37:28\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】广东深圳公司宝安区渔业社区分部 快递员 王令18977206201 正在为您派件【95114/95121/9501395546为韵达快递员外呼专属号码，请放心接听】\",\"ftime\":\"2020-08-22 09:44:44\",\"time\":\"2020-08-22 09:44:44\"},{\"context\":\"[广东深圳公司宝安区渔业社区分部]【深圳市】您的快件已签收,签收人：泰逸大厦1楼保安处旁，如有疑问请电联快递员：王令【18977206201】。\",\"ftime\":\"2020-08-22 12:09:19\",\"time\":\"2020-08-22 12:09:19\"}]', '2020-08-18 18:25:00', '2020-08-22 21:49:30', NULL);
INSERT INTO `orders_logistics` VALUES (164, '10000641597748685', 2, 0.00, 0.00, '邢娇', '18682443968', '广东省', '深圳市', '南山区', '松坪村西区5栋6d', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '百世快递', 'HTKY', '550005131969832', 2, '[{\"context\":\"红河哈尼族彝族自治州|【蒙自兴隆】，【许凌志/15752535821】已揽收\",\"ftime\":\"2020-08-26 16:58:44\",\"time\":\"2020-08-26 16:58:44\"},{\"context\":\"红河哈尼族彝族自治州|到【蒙自集散仓】\",\"ftime\":\"2020-08-26 17:47:14\",\"time\":\"2020-08-26 17:47:14\"},{\"context\":\"红河哈尼族彝族自治州|【蒙自集散仓】，正发往【昆明转运中心】\",\"ftime\":\"2020-08-26 17:47:41\",\"time\":\"2020-08-26 17:47:41\"},{\"context\":\"昆明市|到【昆明转运中心】\",\"ftime\":\"2020-08-27 02:18:26\",\"time\":\"2020-08-27 02:18:26\"},{\"context\":\"昆明市|【昆明转运中心】，正发往【深圳转运中心】\",\"ftime\":\"2020-08-27 02:20:29\",\"time\":\"2020-08-27 02:20:29\"},{\"context\":\"深圳市|到【深圳转运中心】\",\"ftime\":\"2020-08-28 13:26:49\",\"time\":\"2020-08-28 13:26:49\"},{\"context\":\"深圳市|【深圳转运中心】，正发往【深圳南山A站】\",\"ftime\":\"2020-08-28 13:34:05\",\"time\":\"2020-08-28 13:34:05\"},{\"context\":\"深圳市|到【深圳南山A站】\",\"ftime\":\"2020-08-29 07:03:11\",\"time\":\"2020-08-29 07:03:11\"},{\"context\":\"深圳市|【陈俊材/18026921911】正在派件，【深圳南山A站/网点电话18306666375】\",\"ftime\":\"2020-08-29 07:37:38\",\"time\":\"2020-08-29 07:37:38\"},{\"context\":\"深圳市|派件送达【递管家驿站】松坪村三期西区5栋京东快递柜，请前往松坪街5号松坪村三期西区5栋领取您的包裹，联系电话：18026921911\",\"ftime\":\"2020-08-29 08:16:08\",\"time\":\"2020-08-29 08:16:08\"},{\"context\":\"深圳市|客户已取件，提货点：【递管家驿站】 松坪村三期西区5栋京东快递柜（18026921911 松坪街5号松坪村三期西区5栋）\",\"ftime\":\"2020-08-30 09:49:03\",\"time\":\"2020-08-30 09:49:03\"}]', '2020-08-18 19:04:45', '2020-09-01 12:21:23', NULL);
INSERT INTO `orders_logistics` VALUES (165, '10001221597756055', 1, NULL, 0.00, 'jz', '13555555555', '北京市', '北京市', '东城区', 'tttt', NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '2020-08-18 21:07:36', '2020-08-18 21:07:36', NULL);
INSERT INTO `orders_logistics` VALUES (166, '10000221597929355', 2, 0.00, 0.00, '陆晓敏', '13145906814', '广东省', '深圳市', '盐田区', '北山道山海四季城花园B26D', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2079231956755', 2, '[{\"context\":\"【四川省直营市场部公司】 已收件 取件人: 蒲江猕猴桃仓 (19980439369)\",\"ftime\":\"2020-08-20 10:13:54\",\"time\":\"2020-08-20 10:13:54\"},{\"context\":\"【四川省直营市场部】 已发出 下一站 【成都转运中心公司】\",\"ftime\":\"2020-08-20 12:00:47\",\"time\":\"2020-08-20 12:00:47\"},{\"context\":\"【成都转运中心公司】 已收入\",\"ftime\":\"2020-08-21 03:16:19\",\"time\":\"2020-08-21 03:16:19\"},{\"context\":\"【成都转运中心】 已发出 下一站 【深圳转运中心公司】\",\"ftime\":\"2020-08-21 03:40:50\",\"time\":\"2020-08-21 03:40:50\"},{\"context\":\"【深圳转运中心公司】 已收入\",\"ftime\":\"2020-08-22 01:19:47\",\"time\":\"2020-08-22 01:19:47\"},{\"context\":\"【深圳转运中心】 已发出 下一站 【广东省深圳市盐田分公司公司】\",\"ftime\":\"2020-08-22 01:47:10\",\"time\":\"2020-08-22 01:47:10\"},{\"context\":\"【广东省深圳市盐田分公司公司】 已收入\",\"ftime\":\"2020-08-22 05:37:49\",\"time\":\"2020-08-22 05:37:49\"},{\"context\":\"【广东省深圳市盐田分公司公司】 派件中 派件人: 彭华 电话 13590359167 如有疑问，请联系：0755-25359499\",\"ftime\":\"2020-08-22 09:30:14\",\"time\":\"2020-08-22 09:30:14\"},{\"context\":\"快件已由D座架空层丰巢柜丰巢柜代收，取件码已发送，请及时取件。\",\"ftime\":\"2020-08-22 18:16:37\",\"time\":\"2020-08-22 18:16:37\"}]', '2020-08-20 21:15:55', '2020-08-22 20:10:31', NULL);
INSERT INTO `orders_logistics` VALUES (167, '10001481597929615', 1, 0.00, 0.00, '张洁', '13682648914', '广东省', '深圳市', '宝安区', '新安街道宝雅花园B栋一单元601', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-20 21:20:15', '2020-08-20 21:20:15', NULL);
INSERT INTO `orders_logistics` VALUES (168, '10000571597933138', 2, 0.00, 0.00, '苏丽', '18824307739', '广东省', '深圳市', '宝安区', '西乡上三村一排五号302', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2079930573057', 2, '[{\"context\":\"【云南省昆明市新亚洲公司】 已收件 取件人: 林峰 (15158100673)\",\"ftime\":\"2020-08-22 20:11:33\",\"time\":\"2020-08-22 20:11:33\"},{\"context\":\"【云南省昆明市新亚洲】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-22 20:36:37\",\"time\":\"2020-08-22 20:36:37\"},{\"context\":\"【昆明转运中心公司】 已收入\",\"ftime\":\"2020-08-23 04:53:40\",\"time\":\"2020-08-23 04:53:40\"},{\"context\":\"【昆明转运中心】 已发出 下一站 【深圳转运中心公司】\",\"ftime\":\"2020-08-23 05:16:47\",\"time\":\"2020-08-23 05:16:47\"},{\"context\":\"【深圳转运中心公司】 已收入\",\"ftime\":\"2020-08-24 04:09:01\",\"time\":\"2020-08-24 04:09:01\"},{\"context\":\"【深圳转运中心】 已发出 下一站 【广东省深圳市宝安区碧海湾公司】\",\"ftime\":\"2020-08-24 04:36:07\",\"time\":\"2020-08-24 04:36:07\"},{\"context\":\"【广东省深圳市宝安区碧海湾公司】 已收入\",\"ftime\":\"2020-08-24 06:56:13\",\"time\":\"2020-08-24 06:56:13\"},{\"context\":\"【广东省深圳市宝安区碧海湾公司】 派件中 派件人: 余建江 电话 13929307338 如有疑问，请联系：0755-27220201\",\"ftime\":\"2020-08-24 14:35:31\",\"time\":\"2020-08-24 14:35:31\"},{\"context\":\"快件已暂存至深圳盐田新三村上三排12店菜鸟驿站，如有疑问请联系18098910564\",\"ftime\":\"2020-08-24 15:03:08\",\"time\":\"2020-08-24 15:03:08\"},{\"context\":\"客户签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：13929307338，投诉电话：0755-27220201\",\"ftime\":\"2020-08-24 18:33:42\",\"time\":\"2020-08-24 18:33:42\"}]', '2020-08-20 22:18:59', '2020-08-28 11:18:39', NULL);
INSERT INTO `orders_logistics` VALUES (169, '10001541597933355', 2, 0.00, 0.00, '代天益', '13530897455', '广东省', '深圳市', '宝安区', '西乡街道西乡步行街河西路112号楼上', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '圆通速递', 'YTO', 'YT2079675311468', 2, '[{\"context\":\"【云南省市场部公司】 已收件 取件人: 黄波 (17308714268)\",\"ftime\":\"2020-08-21 17:11:39\",\"time\":\"2020-08-21 17:11:39\"},{\"context\":\"【云南省市场部】 已发出 下一站 【昆明转运中心公司】\",\"ftime\":\"2020-08-21 17:25:56\",\"time\":\"2020-08-21 17:25:56\"},{\"context\":\"【昆明转运中心公司】 已收入\",\"ftime\":\"2020-08-22 04:50:42\",\"time\":\"2020-08-22 04:50:42\"},{\"context\":\"【昆明转运中心】 已发出 下一站 【深圳转运中心公司】\",\"ftime\":\"2020-08-22 05:19:33\",\"time\":\"2020-08-22 05:19:33\"},{\"context\":\"【深圳转运中心公司】 已收入\",\"ftime\":\"2020-08-23 04:04:31\",\"time\":\"2020-08-23 04:04:31\"},{\"context\":\"【深圳转运中心】 已发出 下一站 【广东省深圳市宝安区新城公司】\",\"ftime\":\"2020-08-23 04:27:00\",\"time\":\"2020-08-23 04:27:00\"},{\"context\":\"【广东省深圳市宝安区新城公司】 已收入\",\"ftime\":\"2020-08-23 06:58:34\",\"time\":\"2020-08-23 06:58:34\"},{\"context\":\"【广东省深圳市宝安区新城公司】 派件中 派件人: 黄威振 电话 13509670951 如有疑问，请联系：0755-29376921\",\"ftime\":\"2020-08-23 08:15:18\",\"time\":\"2020-08-23 08:15:18\"},{\"context\":\"快件已暂存至深圳西乡真理街131号店菜鸟驿站，如有疑问请联系15713600967\",\"ftime\":\"2020-08-23 09:52:43\",\"time\":\"2020-08-23 09:52:43\"},{\"context\":\"客户签收人: 已签收，签收人凭取货码签收。 已签收 感谢使用圆通速递，期待再次为您服务 如有疑问请联系：13509670951，投诉电话：0755-29376921\",\"ftime\":\"2020-08-23 10:37:05\",\"time\":\"2020-08-23 10:37:05\"}]', '2020-08-20 22:22:36', '2020-08-28 11:18:35', NULL);
INSERT INTO `orders_logistics` VALUES (170, '10001581597933666', 1, 0.00, 0.00, '张先生', '13410960102', '广东省', '东莞市', '松山湖管委会', '玉兰路观园101栋2501', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-20 22:27:47', '2020-08-20 22:27:47', NULL);
INSERT INTO `orders_logistics` VALUES (171, '10000541597989435', 1, 0.00, 0.00, '小英', '13689580681', '广东省', '深圳市', '宝安区', '华侨新村西堤三巷39号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '韵达速递', 'YD', '73136509792136', NULL, NULL, '2020-08-21 13:57:15', '2020-08-22 21:51:24', NULL);
INSERT INTO `orders_logistics` VALUES (172, '10000171597990776', 1, 0.00, 0.00, '小英', '13689580681', '广东省', '深圳市', '宝安区', '华侨新村西堤三巷39号', '袁凯强', '18706821922', '陕西省', '渭南市', '澄城县', '尧头镇浴子河村一组', '中通快递', 'ZTO', '73136509792136', 2, '[{\"context\":\"【渭南澄城】（0913-6731502） 的 尧头王莉13629132872（13629132872） 已揽收\",\"ftime\":\"2020-08-22 13:27:17\",\"time\":\"2020-08-22 13:27:17\"},{\"context\":\"快件离开 【渭南澄城】 已发往 【西安中转】\",\"ftime\":\"2020-08-22 13:40:45\",\"time\":\"2020-08-22 13:40:45\"},{\"context\":\"快件已经到达 【西安中转】\",\"ftime\":\"2020-08-22 20:32:21\",\"time\":\"2020-08-22 20:32:21\"},{\"context\":\"快件离开 【西安中转】 已发往 【深圳中心】\",\"ftime\":\"2020-08-22 20:33:56\",\"time\":\"2020-08-22 20:33:56\"}]', '2020-08-21 14:19:36', '2020-08-22 21:49:23', NULL);
INSERT INTO `orders_logistics` VALUES (173, '10000241598583192', 1, 0.00, 0.00, '姜楠', '18617188606', '广东省', '深圳市', '宝安区', '码头路53号', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-28 10:53:13', '2020-08-28 10:53:13', NULL);
INSERT INTO `orders_logistics` VALUES (174, '10000241598583732', 1, 0.00, 0.00, '姜楠', '18617188606', '广东省', '深圳市', '宝安区', '码头路53号', '廖江龙', '18822861951', '广东省', '深圳市', '宝安区', '海城路186-1号', '中通快递', 'ZTO', '73211115408575', 2, '[{\"context\":\"【昆明西山区】（0871-68289265、0871-63333725） 的 冷链（4000281700） 已揽收\",\"ftime\":\"2020-08-29 12:23:46\",\"time\":\"2020-08-29 12:23:46\"},{\"context\":\"快件离开 【昆明西山区】 已发往 【昆明中转】\",\"ftime\":\"2020-08-29 12:26:12\",\"time\":\"2020-08-29 12:26:12\"},{\"context\":\"快件已经到达 【昆明中转】\",\"ftime\":\"2020-08-31 02:30:41\",\"time\":\"2020-08-31 02:30:41\"},{\"context\":\"快件离开 【昆明中转】 已发往 【广州中心】\",\"ftime\":\"2020-08-31 02:32:03\",\"time\":\"2020-08-31 02:32:03\"},{\"context\":\"快件已经到达 【广州中心】\",\"ftime\":\"2020-09-01 02:45:06\",\"time\":\"2020-09-01 02:45:06\"},{\"context\":\"快件离开 【广州中心】 已发往 【深圳中心】\",\"ftime\":\"2020-09-01 02:47:41\",\"time\":\"2020-09-01 02:47:41\"},{\"context\":\"快件已经到达 【深圳中心】\",\"ftime\":\"2020-09-01 08:07:24\",\"time\":\"2020-09-01 08:07:24\"},{\"context\":\"快件离开 【深圳中心】 已发往 【深圳银田】\",\"ftime\":\"2020-09-01 08:43:08\",\"time\":\"2020-09-01 08:43:08\"}]', '2020-08-28 11:02:12', '2020-09-01 12:21:16', NULL);
INSERT INTO `orders_logistics` VALUES (175, '10000191598861345', 1, 0.00, 0.00, '王凤宇', '15001977677', '广东省', '深圳市', '宝安区', '永丰社区6区83号401', NULL, NULL, NULL, NULL, NULL, NULL, '中通快递', 'ZTO', NULL, NULL, NULL, '2020-08-31 16:09:06', '2020-08-31 16:09:06', NULL);

-- ----------------------------
-- Table structure for orders_printing
-- ----------------------------
DROP TABLE IF EXISTS `orders_printing`;
CREATE TABLE `orders_printing`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺编号',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `printing_count` int(10) UNSIGNED NOT NULL COMMENT '打印次数',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_printing
-- ----------------------------
INSERT INTO `orders_printing` VALUES (5, 1000017, '10000281596785583', 1, '2020-08-07 17:45:03', '2020-08-07 17:45:03');
INSERT INTO `orders_printing` VALUES (6, 1000017, '10000141596636596', 1, '2020-08-07 17:45:47', '2020-08-07 17:45:47');

-- ----------------------------
-- Table structure for shop_access_records
-- ----------------------------
DROP TABLE IF EXISTS `shop_access_records`;
CREATE TABLE `shop_access_records`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '访问用户',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '访问商铺',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3681 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商店访问流水' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_access_records
-- ----------------------------
INSERT INTO `shop_access_records` VALUES (124, 1000017, 1000017, '2020-08-01 18:19:56');
INSERT INTO `shop_access_records` VALUES (125, 1000017, 1000017, '2020-08-01 18:22:03');
INSERT INTO `shop_access_records` VALUES (126, 1000017, 1000017, '2020-08-01 18:25:44');
INSERT INTO `shop_access_records` VALUES (131, 1000018, 1000018, '2020-08-01 18:39:44');
INSERT INTO `shop_access_records` VALUES (132, 1000019, 1000018, '2020-08-01 18:42:09');
INSERT INTO `shop_access_records` VALUES (133, 1000018, 1000018, '2020-08-01 18:43:09');
INSERT INTO `shop_access_records` VALUES (134, 1000018, 1000017, '2020-08-01 18:57:03');
INSERT INTO `shop_access_records` VALUES (135, 1000019, 1000017, '2020-08-01 18:57:33');
INSERT INTO `shop_access_records` VALUES (137, 1000001, 1000017, '2020-08-01 18:58:20');
INSERT INTO `shop_access_records` VALUES (139, 1000019, 1000017, '2020-08-01 18:58:52');
INSERT INTO `shop_access_records` VALUES (141, 1000018, 1000018, '2020-08-01 19:00:06');
INSERT INTO `shop_access_records` VALUES (142, 1000017, 1000017, '2020-08-01 19:00:13');
INSERT INTO `shop_access_records` VALUES (143, 1000001, 1000017, '2020-08-01 19:01:13');
INSERT INTO `shop_access_records` VALUES (144, 1000019, 1000017, '2020-08-01 19:03:04');
INSERT INTO `shop_access_records` VALUES (145, 1000020, 1000020, '2020-08-01 19:03:51');
INSERT INTO `shop_access_records` VALUES (146, 1000008, 1000017, '2020-08-01 19:10:34');
INSERT INTO `shop_access_records` VALUES (147, 1000008, 1000017, '2020-08-01 19:11:35');
INSERT INTO `shop_access_records` VALUES (148, 1000017, 1000017, '2020-08-01 19:17:43');
INSERT INTO `shop_access_records` VALUES (149, 1000017, 1000017, '2020-08-01 19:18:09');
INSERT INTO `shop_access_records` VALUES (152, 1000018, 1000018, '2020-08-01 19:49:30');
INSERT INTO `shop_access_records` VALUES (153, 1000022, 1000022, '2020-08-01 19:54:44');
INSERT INTO `shop_access_records` VALUES (154, 1000017, 1000017, '2020-08-01 21:04:31');
INSERT INTO `shop_access_records` VALUES (155, 1000006, 1000017, '2020-08-01 21:47:41');
INSERT INTO `shop_access_records` VALUES (156, 1000006, 1000017, '2020-08-01 21:48:24');
INSERT INTO `shop_access_records` VALUES (157, 1000000, 1000017, '2020-08-02 06:19:43');
INSERT INTO `shop_access_records` VALUES (158, 1000000, 1000017, '2020-08-02 06:21:06');
INSERT INTO `shop_access_records` VALUES (159, 1000017, 1000017, '2020-08-02 09:39:24');
INSERT INTO `shop_access_records` VALUES (160, 1000017, 1000017, '2020-08-02 20:59:57');
INSERT INTO `shop_access_records` VALUES (161, 1000024, 1000017, '2020-08-02 21:10:06');
INSERT INTO `shop_access_records` VALUES (168, 1000000, 1000017, '2020-08-03 10:48:35');
INSERT INTO `shop_access_records` VALUES (171, 1000017, 1000017, '2020-08-03 11:16:17');
INSERT INTO `shop_access_records` VALUES (172, 1000001, 1000017, '2020-08-03 11:17:07');
INSERT INTO `shop_access_records` VALUES (173, 1000001, 1000017, '2020-08-03 11:18:43');
INSERT INTO `shop_access_records` VALUES (176, 1000008, 1000017, '2020-08-03 11:19:12');
INSERT INTO `shop_access_records` VALUES (181, 1000008, 1000017, '2020-08-03 11:23:54');
INSERT INTO `shop_access_records` VALUES (182, 1000008, 1000017, '2020-08-03 11:24:02');
INSERT INTO `shop_access_records` VALUES (184, 1000008, 1000017, '2020-08-03 11:24:27');
INSERT INTO `shop_access_records` VALUES (186, 1000017, 1000017, '2020-08-03 11:27:34');
INSERT INTO `shop_access_records` VALUES (188, 1000001, 1000017, '2020-08-03 11:28:38');
INSERT INTO `shop_access_records` VALUES (190, 1000008, 1000017, '2020-08-03 11:29:47');
INSERT INTO `shop_access_records` VALUES (192, 1000008, 1000017, '2020-08-03 11:30:18');
INSERT INTO `shop_access_records` VALUES (194, 1000008, 1000017, '2020-08-03 11:30:33');
INSERT INTO `shop_access_records` VALUES (196, 1000008, 1000017, '2020-08-03 11:30:47');
INSERT INTO `shop_access_records` VALUES (198, 1000008, 1000017, '2020-08-03 11:30:58');
INSERT INTO `shop_access_records` VALUES (200, 1000008, 1000017, '2020-08-03 11:31:10');
INSERT INTO `shop_access_records` VALUES (202, 1000008, 1000017, '2020-08-03 11:31:21');
INSERT INTO `shop_access_records` VALUES (205, 1000008, 1000017, '2020-08-03 11:32:01');
INSERT INTO `shop_access_records` VALUES (207, 1000008, 1000017, '2020-08-03 11:32:17');
INSERT INTO `shop_access_records` VALUES (209, 1000008, 1000017, '2020-08-03 11:32:30');
INSERT INTO `shop_access_records` VALUES (211, 1000008, 1000017, '2020-08-03 11:32:43');
INSERT INTO `shop_access_records` VALUES (213, 1000008, 1000017, '2020-08-03 11:33:02');
INSERT INTO `shop_access_records` VALUES (215, 1000008, 1000017, '2020-08-03 11:33:43');
INSERT INTO `shop_access_records` VALUES (217, 1000008, 1000017, '2020-08-03 11:33:56');
INSERT INTO `shop_access_records` VALUES (219, 1000008, 1000017, '2020-08-03 11:34:11');
INSERT INTO `shop_access_records` VALUES (222, 1000008, 1000017, '2020-08-03 11:34:36');
INSERT INTO `shop_access_records` VALUES (224, 1000017, 1000017, '2020-08-03 11:36:34');
INSERT INTO `shop_access_records` VALUES (229, 1000001, 1000017, '2020-08-03 11:39:37');
INSERT INTO `shop_access_records` VALUES (231, 1000008, 1000017, '2020-08-03 11:41:02');
INSERT INTO `shop_access_records` VALUES (234, 1000001, 1000017, '2020-08-03 11:43:04');
INSERT INTO `shop_access_records` VALUES (237, 1000008, 1000017, '2020-08-03 11:44:45');
INSERT INTO `shop_access_records` VALUES (239, 1000008, 1000017, '2020-08-03 11:45:07');
INSERT INTO `shop_access_records` VALUES (241, 1000008, 1000017, '2020-08-03 11:45:19');
INSERT INTO `shop_access_records` VALUES (243, 1000012, 1000017, '2020-08-03 11:48:09');
INSERT INTO `shop_access_records` VALUES (247, 1000017, 1000017, '2020-08-03 12:00:42');
INSERT INTO `shop_access_records` VALUES (248, 1000027, 1000017, '2020-08-03 12:01:13');
INSERT INTO `shop_access_records` VALUES (251, 1000006, 1000017, '2020-08-03 12:02:33');
INSERT INTO `shop_access_records` VALUES (259, 1000006, 1000017, '2020-08-03 12:28:34');
INSERT INTO `shop_access_records` VALUES (270, 1000017, 1000017, '2020-08-03 16:44:53');
INSERT INTO `shop_access_records` VALUES (271, 1000028, 1000017, '2020-08-03 16:45:48');
INSERT INTO `shop_access_records` VALUES (274, 1000017, 0, '2020-08-03 17:10:48');
INSERT INTO `shop_access_records` VALUES (277, 1000013, 0, '2020-08-03 17:13:00');
INSERT INTO `shop_access_records` VALUES (279, 1000008, 0, '2020-08-03 17:18:43');
INSERT INTO `shop_access_records` VALUES (291, 1000017, 1000017, '2020-08-03 17:26:51');
INSERT INTO `shop_access_records` VALUES (312, 1000028, 1000017, '2020-08-03 20:12:12');
INSERT INTO `shop_access_records` VALUES (313, 1000017, 1000017, '2020-08-03 20:14:37');
INSERT INTO `shop_access_records` VALUES (314, 1000028, 1000017, '2020-08-03 20:15:14');
INSERT INTO `shop_access_records` VALUES (315, 1000018, 1000018, '2020-08-03 20:24:24');
INSERT INTO `shop_access_records` VALUES (316, 1000029, 1000029, '2020-08-03 20:24:59');
INSERT INTO `shop_access_records` VALUES (317, 1000028, 1000017, '2020-08-03 20:27:16');
INSERT INTO `shop_access_records` VALUES (318, 1000019, 1000017, '2020-08-03 20:30:03');
INSERT INTO `shop_access_records` VALUES (319, 1000019, 1000017, '2020-08-03 20:30:07');
INSERT INTO `shop_access_records` VALUES (321, 1000008, 1000017, '2020-08-03 20:33:33');
INSERT INTO `shop_access_records` VALUES (323, 1000029, 1000018, '2020-08-03 20:54:49');
INSERT INTO `shop_access_records` VALUES (324, 1000029, 1000029, '2020-08-03 20:56:59');
INSERT INTO `shop_access_records` VALUES (325, 1000029, 1000029, '2020-08-03 20:57:30');
INSERT INTO `shop_access_records` VALUES (327, 1000018, 1000018, '2020-08-03 21:35:37');
INSERT INTO `shop_access_records` VALUES (328, 1000030, 1000030, '2020-08-03 21:36:31');
INSERT INTO `shop_access_records` VALUES (329, 1000030, 1000030, '2020-08-03 21:39:21');
INSERT INTO `shop_access_records` VALUES (330, 1000030, 1000030, '2020-08-03 21:40:37');
INSERT INTO `shop_access_records` VALUES (331, 1000030, 1000030, '2020-08-03 21:42:29');
INSERT INTO `shop_access_records` VALUES (336, 1000017, 1000017, '2020-08-03 21:52:43');
INSERT INTO `shop_access_records` VALUES (340, 1000016, 1000017, '2020-08-03 22:07:03');
INSERT INTO `shop_access_records` VALUES (359, 1000017, 1000017, '2020-08-04 11:10:27');
INSERT INTO `shop_access_records` VALUES (365, 1000017, 1000017, '2020-08-04 12:17:28');
INSERT INTO `shop_access_records` VALUES (375, 1000017, 1000017, '2020-08-04 15:36:05');
INSERT INTO `shop_access_records` VALUES (389, 1000008, 1000017, '2020-08-04 16:01:23');
INSERT INTO `shop_access_records` VALUES (473, 1000017, 1000017, '2020-08-04 18:13:32');
INSERT INTO `shop_access_records` VALUES (474, 1000013, 1000013, '2020-08-04 18:16:58');
INSERT INTO `shop_access_records` VALUES (514, 1000001, 1000017, '2020-08-04 19:55:24');
INSERT INTO `shop_access_records` VALUES (525, 1000013, 1000013, '2020-08-04 20:00:00');
INSERT INTO `shop_access_records` VALUES (554, 1000017, 1000017, '2020-08-04 22:03:33');
INSERT INTO `shop_access_records` VALUES (559, 1000017, 1000017, '2020-08-05 07:36:10');
INSERT INTO `shop_access_records` VALUES (560, 1000017, 1000017, '2020-08-05 07:36:18');
INSERT INTO `shop_access_records` VALUES (561, 1000017, 1000017, '2020-08-05 07:38:06');
INSERT INTO `shop_access_records` VALUES (608, 1000018, 1000018, '2020-08-05 10:14:52');
INSERT INTO `shop_access_records` VALUES (624, 1000033, 1000033, '2020-08-05 10:28:09');
INSERT INTO `shop_access_records` VALUES (626, 1000033, 1000018, '2020-08-05 10:29:19');
INSERT INTO `shop_access_records` VALUES (627, 1000033, 1000018, '2020-08-05 10:29:53');
INSERT INTO `shop_access_records` VALUES (628, 1000033, 1000018, '2020-08-05 10:29:57');
INSERT INTO `shop_access_records` VALUES (633, 1000017, 1000017, '2020-08-05 10:31:55');
INSERT INTO `shop_access_records` VALUES (635, 1000033, 1000018, '2020-08-05 10:32:38');
INSERT INTO `shop_access_records` VALUES (636, 1000033, 1000033, '2020-08-05 10:32:58');
INSERT INTO `shop_access_records` VALUES (638, 1000017, 1000017, '2020-08-05 10:33:30');
INSERT INTO `shop_access_records` VALUES (639, 1000008, 1000017, '2020-08-05 10:34:19');
INSERT INTO `shop_access_records` VALUES (652, 1000017, 1000017, '2020-08-05 10:41:56');
INSERT INTO `shop_access_records` VALUES (656, 1000033, 1000033, '2020-08-05 10:45:12');
INSERT INTO `shop_access_records` VALUES (659, 1000008, 1000017, '2020-08-05 10:46:57');
INSERT INTO `shop_access_records` VALUES (661, 1000017, 1000017, '2020-08-05 10:49:20');
INSERT INTO `shop_access_records` VALUES (662, 1000034, 1000034, '2020-08-05 10:49:30');
INSERT INTO `shop_access_records` VALUES (664, 1000019, 1000018, '2020-08-05 10:52:36');
INSERT INTO `shop_access_records` VALUES (673, 1000013, 1000013, '2020-08-05 11:03:23');
INSERT INTO `shop_access_records` VALUES (674, 1000013, 1000013, '2020-08-05 11:04:51');
INSERT INTO `shop_access_records` VALUES (680, 1000017, 1000017, '2020-08-05 11:11:22');
INSERT INTO `shop_access_records` VALUES (681, 1000017, 1000017, '2020-08-05 11:14:27');
INSERT INTO `shop_access_records` VALUES (692, 1000017, 1000017, '2020-08-05 11:41:26');
INSERT INTO `shop_access_records` VALUES (693, 1000017, 1000017, '2020-08-05 11:42:06');
INSERT INTO `shop_access_records` VALUES (696, 1000013, 1000013, '2020-08-05 11:43:35');
INSERT INTO `shop_access_records` VALUES (698, 1000017, 1000017, '2020-08-05 11:44:26');
INSERT INTO `shop_access_records` VALUES (699, 1000017, 1000017, '2020-08-05 11:44:26');
INSERT INTO `shop_access_records` VALUES (700, 1000017, 1000017, '2020-08-05 11:44:38');
INSERT INTO `shop_access_records` VALUES (702, 1000013, 1000013, '2020-08-05 11:45:17');
INSERT INTO `shop_access_records` VALUES (706, 1000001, 1000017, '2020-08-05 11:46:41');
INSERT INTO `shop_access_records` VALUES (707, 1000013, 1000013, '2020-08-05 11:47:06');
INSERT INTO `shop_access_records` VALUES (710, 1000017, 1000017, '2020-08-05 11:47:35');
INSERT INTO `shop_access_records` VALUES (713, 1000013, 1000013, '2020-08-05 11:48:15');
INSERT INTO `shop_access_records` VALUES (716, 1000013, 1000013, '2020-08-05 11:49:31');
INSERT INTO `shop_access_records` VALUES (717, 1000013, 1000013, '2020-08-05 11:51:49');
INSERT INTO `shop_access_records` VALUES (718, 1000013, 1000013, '2020-08-05 11:52:29');
INSERT INTO `shop_access_records` VALUES (719, 1000017, 1000017, '2020-08-05 11:52:54');
INSERT INTO `shop_access_records` VALUES (720, 1000035, 1000035, '2020-08-05 11:53:43');
INSERT INTO `shop_access_records` VALUES (721, 1000035, 1000035, '2020-08-05 11:54:17');
INSERT INTO `shop_access_records` VALUES (722, 1000017, 1000017, '2020-08-05 11:54:23');
INSERT INTO `shop_access_records` VALUES (723, 1000035, 1000035, '2020-08-05 11:54:46');
INSERT INTO `shop_access_records` VALUES (725, 1000035, 1000035, '2020-08-05 11:55:14');
INSERT INTO `shop_access_records` VALUES (727, 1000035, 1000035, '2020-08-05 11:57:58');
INSERT INTO `shop_access_records` VALUES (728, 1000017, 1000017, '2020-08-05 11:57:59');
INSERT INTO `shop_access_records` VALUES (729, 1000013, 1000013, '2020-08-05 11:58:22');
INSERT INTO `shop_access_records` VALUES (730, 1000017, 1000017, '2020-08-05 11:58:36');
INSERT INTO `shop_access_records` VALUES (731, 1000017, 1000017, '2020-08-05 11:59:06');
INSERT INTO `shop_access_records` VALUES (732, 1000017, 1000017, '2020-08-05 11:59:26');
INSERT INTO `shop_access_records` VALUES (733, 1000017, 1000017, '2020-08-05 11:59:26');
INSERT INTO `shop_access_records` VALUES (734, 1000013, 1000013, '2020-08-05 12:01:12');
INSERT INTO `shop_access_records` VALUES (736, 1000035, 1000035, '2020-08-05 12:02:16');
INSERT INTO `shop_access_records` VALUES (737, 1000017, 1000017, '2020-08-05 12:02:40');
INSERT INTO `shop_access_records` VALUES (738, 1000017, 1000017, '2020-08-05 12:03:26');
INSERT INTO `shop_access_records` VALUES (739, 1000035, 1000035, '2020-08-05 12:03:41');
INSERT INTO `shop_access_records` VALUES (740, 1000017, 1000017, '2020-08-05 12:03:51');
INSERT INTO `shop_access_records` VALUES (741, 1000035, 1000035, '2020-08-05 12:04:13');
INSERT INTO `shop_access_records` VALUES (742, 1000035, 1000035, '2020-08-05 12:04:46');
INSERT INTO `shop_access_records` VALUES (743, 1000017, 1000017, '2020-08-05 12:04:58');
INSERT INTO `shop_access_records` VALUES (745, 1000035, 1000035, '2020-08-05 12:05:34');
INSERT INTO `shop_access_records` VALUES (747, 1000017, 1000017, '2020-08-05 12:05:48');
INSERT INTO `shop_access_records` VALUES (751, 1000035, 1000035, '2020-08-05 12:22:53');
INSERT INTO `shop_access_records` VALUES (753, 1000017, 1000017, '2020-08-05 12:23:19');
INSERT INTO `shop_access_records` VALUES (756, 1000013, 1000013, '2020-08-05 12:27:56');
INSERT INTO `shop_access_records` VALUES (764, 1000013, 1000013, '2020-08-05 12:41:45');
INSERT INTO `shop_access_records` VALUES (765, 1000013, 1000013, '2020-08-05 12:42:10');
INSERT INTO `shop_access_records` VALUES (766, 1000013, 1000013, '2020-08-05 12:55:39');
INSERT INTO `shop_access_records` VALUES (767, 1000013, 1000013, '2020-08-05 13:15:57');
INSERT INTO `shop_access_records` VALUES (768, 1000000, 1000013, '2020-08-05 13:16:24');
INSERT INTO `shop_access_records` VALUES (769, 1000013, 1000013, '2020-08-05 13:16:26');
INSERT INTO `shop_access_records` VALUES (770, 1000013, 1000013, '2020-08-05 13:16:53');
INSERT INTO `shop_access_records` VALUES (772, 1000035, 1000035, '2020-08-05 13:16:58');
INSERT INTO `shop_access_records` VALUES (774, 1000035, 1000035, '2020-08-05 13:17:27');
INSERT INTO `shop_access_records` VALUES (775, 1000017, 1000017, '2020-08-05 13:17:29');
INSERT INTO `shop_access_records` VALUES (776, 1000017, 1000013, '2020-08-05 13:17:36');
INSERT INTO `shop_access_records` VALUES (777, 1000017, 1000017, '2020-08-05 13:17:46');
INSERT INTO `shop_access_records` VALUES (778, 1000035, 1000035, '2020-08-05 13:18:46');
INSERT INTO `shop_access_records` VALUES (779, 1000013, 1000013, '2020-08-05 13:23:06');
INSERT INTO `shop_access_records` VALUES (780, 1000035, 1000035, '2020-08-05 13:25:03');
INSERT INTO `shop_access_records` VALUES (781, 1000013, 1000013, '2020-08-05 14:05:20');
INSERT INTO `shop_access_records` VALUES (782, 1000035, 1000035, '2020-08-05 14:07:05');
INSERT INTO `shop_access_records` VALUES (783, 1000035, 1000035, '2020-08-05 14:08:47');
INSERT INTO `shop_access_records` VALUES (784, 1000013, 1000013, '2020-08-05 14:09:03');
INSERT INTO `shop_access_records` VALUES (785, 1000035, 1000035, '2020-08-05 14:09:48');
INSERT INTO `shop_access_records` VALUES (786, 1000013, 1000013, '2020-08-05 14:10:13');
INSERT INTO `shop_access_records` VALUES (788, 1000035, 1000035, '2020-08-05 14:11:38');
INSERT INTO `shop_access_records` VALUES (789, 1000035, 1000035, '2020-08-05 14:12:31');
INSERT INTO `shop_access_records` VALUES (794, 1000035, 1000035, '2020-08-05 14:23:59');
INSERT INTO `shop_access_records` VALUES (795, 1000035, 1000035, '2020-08-05 14:25:20');
INSERT INTO `shop_access_records` VALUES (796, 1000035, 1000035, '2020-08-05 14:28:02');
INSERT INTO `shop_access_records` VALUES (797, 1000035, 1000035, '2020-08-05 14:29:44');
INSERT INTO `shop_access_records` VALUES (821, 1000017, 1000017, '2020-08-05 15:11:33');
INSERT INTO `shop_access_records` VALUES (823, 1000013, 1000013, '2020-08-05 15:17:40');
INSERT INTO `shop_access_records` VALUES (837, 1000013, 1000013, '2020-08-05 16:00:48');
INSERT INTO `shop_access_records` VALUES (838, 1000017, 1000017, '2020-08-05 16:12:20');
INSERT INTO `shop_access_records` VALUES (850, 1000035, 1000013, '2020-08-05 16:45:51');
INSERT INTO `shop_access_records` VALUES (852, 1000035, 1000035, '2020-08-05 16:49:37');
INSERT INTO `shop_access_records` VALUES (854, 1000035, 1000035, '2020-08-05 16:50:09');
INSERT INTO `shop_access_records` VALUES (861, 1000035, 1000035, '2020-08-05 16:52:30');
INSERT INTO `shop_access_records` VALUES (872, 1000013, 1000013, '2020-08-05 17:04:09');
INSERT INTO `shop_access_records` VALUES (882, 1000013, 1000013, '2020-08-05 17:08:57');
INSERT INTO `shop_access_records` VALUES (883, 1000017, 1000017, '2020-08-05 17:09:19');
INSERT INTO `shop_access_records` VALUES (884, 1000013, 1000013, '2020-08-05 17:09:21');
INSERT INTO `shop_access_records` VALUES (886, 1000017, 1000017, '2020-08-05 17:09:28');
INSERT INTO `shop_access_records` VALUES (888, 1000017, 1000013, '2020-08-05 17:09:35');
INSERT INTO `shop_access_records` VALUES (893, 1000017, 1000017, '2020-08-05 17:11:10');
INSERT INTO `shop_access_records` VALUES (895, 1000013, 1000013, '2020-08-05 17:12:38');
INSERT INTO `shop_access_records` VALUES (896, 1000013, 1000013, '2020-08-05 17:12:47');
INSERT INTO `shop_access_records` VALUES (903, 1000013, 1000013, '2020-08-05 17:15:25');
INSERT INTO `shop_access_records` VALUES (904, 1000035, 1000035, '2020-08-05 17:15:30');
INSERT INTO `shop_access_records` VALUES (905, 1000035, 1000035, '2020-08-05 17:16:02');
INSERT INTO `shop_access_records` VALUES (906, 1000035, 1000035, '2020-08-05 17:16:11');
INSERT INTO `shop_access_records` VALUES (908, 1000035, 1000035, '2020-08-05 17:16:35');
INSERT INTO `shop_access_records` VALUES (927, 1000035, 1000035, '2020-08-05 17:33:45');
INSERT INTO `shop_access_records` VALUES (931, 1000017, 1000017, '2020-08-05 17:39:45');
INSERT INTO `shop_access_records` VALUES (932, 1000017, 1000017, '2020-08-05 17:40:01');
INSERT INTO `shop_access_records` VALUES (934, 1000017, 1000017, '2020-08-05 17:42:02');
INSERT INTO `shop_access_records` VALUES (940, 1000035, 1000035, '2020-08-05 17:44:18');
INSERT INTO `shop_access_records` VALUES (941, 1000036, 1000017, '2020-08-05 17:45:14');
INSERT INTO `shop_access_records` VALUES (948, 1000017, 1000017, '2020-08-05 17:50:03');
INSERT INTO `shop_access_records` VALUES (950, 1000017, 1000017, '2020-08-05 17:51:34');
INSERT INTO `shop_access_records` VALUES (956, 1000035, 1000035, '2020-08-05 17:55:19');
INSERT INTO `shop_access_records` VALUES (957, 1000035, 1000035, '2020-08-05 17:55:29');
INSERT INTO `shop_access_records` VALUES (962, 1000035, 1000035, '2020-08-05 18:00:09');
INSERT INTO `shop_access_records` VALUES (964, 1000017, 1000017, '2020-08-05 18:00:21');
INSERT INTO `shop_access_records` VALUES (965, 1000017, 1000017, '2020-08-05 18:00:26');
INSERT INTO `shop_access_records` VALUES (966, 1000035, 1000035, '2020-08-05 18:01:36');
INSERT INTO `shop_access_records` VALUES (969, 1000035, 1000035, '2020-08-05 18:03:47');
INSERT INTO `shop_access_records` VALUES (970, 1000035, 1000035, '2020-08-05 18:04:53');
INSERT INTO `shop_access_records` VALUES (973, 1000035, 1000035, '2020-08-05 18:09:41');
INSERT INTO `shop_access_records` VALUES (975, 1000035, 1000035, '2020-08-05 18:10:12');
INSERT INTO `shop_access_records` VALUES (976, 1000035, 1000035, '2020-08-05 18:10:43');
INSERT INTO `shop_access_records` VALUES (977, 1000035, 1000035, '2020-08-05 18:10:53');
INSERT INTO `shop_access_records` VALUES (982, 1000035, 1000035, '2020-08-05 18:25:19');
INSERT INTO `shop_access_records` VALUES (983, 1000013, 1000013, '2020-08-05 18:25:35');
INSERT INTO `shop_access_records` VALUES (984, 1000035, 1000035, '2020-08-05 18:26:12');
INSERT INTO `shop_access_records` VALUES (985, 1000035, 1000035, '2020-08-05 18:27:17');
INSERT INTO `shop_access_records` VALUES (986, 1000035, 1000035, '2020-08-05 18:28:40');
INSERT INTO `shop_access_records` VALUES (989, 1000013, 1000013, '2020-08-05 18:30:22');
INSERT INTO `shop_access_records` VALUES (990, 1000013, 1000013, '2020-08-05 18:30:35');
INSERT INTO `shop_access_records` VALUES (991, 1000035, 1000035, '2020-08-05 18:30:37');
INSERT INTO `shop_access_records` VALUES (992, 1000035, 1000035, '2020-08-05 18:30:51');
INSERT INTO `shop_access_records` VALUES (994, 1000035, 1000035, '2020-08-05 18:31:32');
INSERT INTO `shop_access_records` VALUES (996, 1000035, 1000035, '2020-08-05 18:32:10');
INSERT INTO `shop_access_records` VALUES (997, 1000035, 1000035, '2020-08-05 18:32:28');
INSERT INTO `shop_access_records` VALUES (999, 1000035, 1000035, '2020-08-05 18:32:59');
INSERT INTO `shop_access_records` VALUES (1002, 1000035, 1000035, '2020-08-05 18:33:38');
INSERT INTO `shop_access_records` VALUES (1005, 1000035, 1000035, '2020-08-05 18:34:34');
INSERT INTO `shop_access_records` VALUES (1006, 1000035, 1000035, '2020-08-05 18:34:39');
INSERT INTO `shop_access_records` VALUES (1008, 1000035, 1000035, '2020-08-05 18:34:57');
INSERT INTO `shop_access_records` VALUES (1019, 1000035, 1000035, '2020-08-05 18:45:30');
INSERT INTO `shop_access_records` VALUES (1020, 1000035, 1000035, '2020-08-05 18:45:46');
INSERT INTO `shop_access_records` VALUES (1022, 1000035, 1000035, '2020-08-05 18:46:56');
INSERT INTO `shop_access_records` VALUES (1024, 1000035, 1000035, '2020-08-05 18:47:32');
INSERT INTO `shop_access_records` VALUES (1025, 1000035, 1000035, '2020-08-05 18:48:10');
INSERT INTO `shop_access_records` VALUES (1027, 1000035, 1000035, '2020-08-05 18:49:13');
INSERT INTO `shop_access_records` VALUES (1028, 1000013, 1000013, '2020-08-05 18:50:00');
INSERT INTO `shop_access_records` VALUES (1032, 1000035, 1000035, '2020-08-05 18:55:27');
INSERT INTO `shop_access_records` VALUES (1035, 1000035, 1000035, '2020-08-05 18:59:34');
INSERT INTO `shop_access_records` VALUES (1036, 1000035, 1000035, '2020-08-05 18:59:43');
INSERT INTO `shop_access_records` VALUES (1038, 1000035, 1000035, '2020-08-05 19:01:32');
INSERT INTO `shop_access_records` VALUES (1051, 1000035, 1000035, '2020-08-05 19:30:39');
INSERT INTO `shop_access_records` VALUES (1054, 1000035, 1000035, '2020-08-05 19:32:31');
INSERT INTO `shop_access_records` VALUES (1056, 1000035, 1000035, '2020-08-05 19:34:35');
INSERT INTO `shop_access_records` VALUES (1057, 1000035, 1000035, '2020-08-05 19:38:09');
INSERT INTO `shop_access_records` VALUES (1059, 1000035, 1000035, '2020-08-05 19:39:14');
INSERT INTO `shop_access_records` VALUES (1061, 1000035, 1000035, '2020-08-05 19:40:11');
INSERT INTO `shop_access_records` VALUES (1067, 1000035, 1000035, '2020-08-05 19:46:05');
INSERT INTO `shop_access_records` VALUES (1069, 1000035, 1000035, '2020-08-05 19:46:49');
INSERT INTO `shop_access_records` VALUES (1071, 1000035, 1000035, '2020-08-05 19:48:34');
INSERT INTO `shop_access_records` VALUES (1072, 1000035, 1000035, '2020-08-05 19:49:20');
INSERT INTO `shop_access_records` VALUES (1078, 1000035, 1000035, '2020-08-05 20:02:13');
INSERT INTO `shop_access_records` VALUES (1080, 1000035, 1000035, '2020-08-05 20:03:21');
INSERT INTO `shop_access_records` VALUES (1081, 1000035, 1000035, '2020-08-05 20:04:10');
INSERT INTO `shop_access_records` VALUES (1083, 1000035, 1000035, '2020-08-05 20:05:38');
INSERT INTO `shop_access_records` VALUES (1084, 1000035, 1000035, '2020-08-05 20:05:42');
INSERT INTO `shop_access_records` VALUES (1085, 1000035, 1000035, '2020-08-05 20:05:56');
INSERT INTO `shop_access_records` VALUES (1086, 1000035, 1000035, '2020-08-05 20:07:03');
INSERT INTO `shop_access_records` VALUES (1088, 1000035, 1000035, '2020-08-05 20:09:29');
INSERT INTO `shop_access_records` VALUES (1089, 1000035, 1000035, '2020-08-05 20:10:55');
INSERT INTO `shop_access_records` VALUES (1094, 1000035, 1000035, '2020-08-05 20:14:44');
INSERT INTO `shop_access_records` VALUES (1096, 1000035, 1000035, '2020-08-05 20:17:21');
INSERT INTO `shop_access_records` VALUES (1097, 1000035, 1000035, '2020-08-05 20:19:13');
INSERT INTO `shop_access_records` VALUES (1098, 1000035, 1000035, '2020-08-05 20:21:14');
INSERT INTO `shop_access_records` VALUES (1099, 1000035, 1000035, '2020-08-05 20:22:22');
INSERT INTO `shop_access_records` VALUES (1100, 1000035, 1000035, '2020-08-05 20:23:27');
INSERT INTO `shop_access_records` VALUES (1101, 1000035, 1000035, '2020-08-05 20:24:18');
INSERT INTO `shop_access_records` VALUES (1102, 1000035, 1000035, '2020-08-05 20:26:51');
INSERT INTO `shop_access_records` VALUES (1103, 1000035, 1000035, '2020-08-05 20:29:36');
INSERT INTO `shop_access_records` VALUES (1104, 1000035, 1000035, '2020-08-05 20:31:10');
INSERT INTO `shop_access_records` VALUES (1105, 1000035, 1000035, '2020-08-05 20:31:44');
INSERT INTO `shop_access_records` VALUES (1106, 1000035, 1000035, '2020-08-05 20:33:10');
INSERT INTO `shop_access_records` VALUES (1107, 1000013, 1000013, '2020-08-05 20:34:23');
INSERT INTO `shop_access_records` VALUES (1108, 1000017, 1000017, '2020-08-05 20:34:43');
INSERT INTO `shop_access_records` VALUES (1109, 1000035, 1000035, '2020-08-05 20:43:20');
INSERT INTO `shop_access_records` VALUES (1111, 1000035, 1000035, '2020-08-05 21:05:34');
INSERT INTO `shop_access_records` VALUES (1112, 1000001, 1000035, '2020-08-05 21:07:11');
INSERT INTO `shop_access_records` VALUES (1113, 1000035, 1000035, '2020-08-05 21:07:14');
INSERT INTO `shop_access_records` VALUES (1115, 1000017, 1000035, '2020-08-05 21:07:30');
INSERT INTO `shop_access_records` VALUES (1116, 1000001, 1000035, '2020-08-05 21:07:41');
INSERT INTO `shop_access_records` VALUES (1117, 1000018, 1000035, '2020-08-05 21:07:42');
INSERT INTO `shop_access_records` VALUES (1119, 1000035, 1000035, '2020-08-05 21:12:42');
INSERT INTO `shop_access_records` VALUES (1120, 1000039, 1000035, '2020-08-05 21:21:43');
INSERT INTO `shop_access_records` VALUES (1121, 1000017, 1000017, '2020-08-05 21:23:52');
INSERT INTO `shop_access_records` VALUES (1122, 1000013, 1000035, '2020-08-05 21:25:34');
INSERT INTO `shop_access_records` VALUES (1123, 1000013, 1000013, '2020-08-05 21:26:10');
INSERT INTO `shop_access_records` VALUES (1124, 1000035, 1000035, '2020-08-05 21:26:15');
INSERT INTO `shop_access_records` VALUES (1125, 1000040, 1000017, '2020-08-05 21:29:58');
INSERT INTO `shop_access_records` VALUES (1126, 1000040, 1000017, '2020-08-05 21:30:09');
INSERT INTO `shop_access_records` VALUES (1127, 1000017, 1000017, '2020-08-05 21:42:15');
INSERT INTO `shop_access_records` VALUES (1128, 1000035, 1000017, '2020-08-05 21:42:58');
INSERT INTO `shop_access_records` VALUES (1129, 1000035, 1000035, '2020-08-05 21:43:20');
INSERT INTO `shop_access_records` VALUES (1130, 1000035, 1000017, '2020-08-05 21:43:30');
INSERT INTO `shop_access_records` VALUES (1131, 1000035, 1000017, '2020-08-05 21:45:17');
INSERT INTO `shop_access_records` VALUES (1133, 1000035, 1000035, '2020-08-05 21:49:48');
INSERT INTO `shop_access_records` VALUES (1134, 1000035, 1000017, '2020-08-05 21:50:23');
INSERT INTO `shop_access_records` VALUES (1135, 1000018, 1000035, '2020-08-05 21:52:54');
INSERT INTO `shop_access_records` VALUES (1136, 1000017, 1000017, '2020-08-05 21:59:00');
INSERT INTO `shop_access_records` VALUES (1137, 1000017, 1000017, '2020-08-05 21:59:49');
INSERT INTO `shop_access_records` VALUES (1138, 1000042, 1000035, '2020-08-05 22:00:09');
INSERT INTO `shop_access_records` VALUES (1140, 1000043, 1000017, '2020-08-05 22:00:58');
INSERT INTO `shop_access_records` VALUES (1141, 1000035, 1000017, '2020-08-05 22:01:04');
INSERT INTO `shop_access_records` VALUES (1142, 1000001, 1000017, '2020-08-05 22:01:45');
INSERT INTO `shop_access_records` VALUES (1147, 1000018, 1000017, '2020-08-05 22:05:54');
INSERT INTO `shop_access_records` VALUES (1148, 1000014, 1000035, '2020-08-05 22:06:22');
INSERT INTO `shop_access_records` VALUES (1150, 1000014, 1000035, '2020-08-05 22:06:47');
INSERT INTO `shop_access_records` VALUES (1151, 1000014, 1000035, '2020-08-05 22:07:04');
INSERT INTO `shop_access_records` VALUES (1152, 1000017, 1000017, '2020-08-05 22:07:15');
INSERT INTO `shop_access_records` VALUES (1155, 1000044, 1000017, '2020-08-05 22:08:28');
INSERT INTO `shop_access_records` VALUES (1156, 1000014, 1000017, '2020-08-05 22:08:53');
INSERT INTO `shop_access_records` VALUES (1157, 1000046, 1000017, '2020-08-05 22:09:06');
INSERT INTO `shop_access_records` VALUES (1158, 1000019, 1000017, '2020-08-05 22:09:09');
INSERT INTO `shop_access_records` VALUES (1159, 1000017, 1000017, '2020-08-05 22:09:41');
INSERT INTO `shop_access_records` VALUES (1160, 1000014, 1000035, '2020-08-05 22:10:22');
INSERT INTO `shop_access_records` VALUES (1161, 1000045, 1000017, '2020-08-05 22:10:31');
INSERT INTO `shop_access_records` VALUES (1162, 1000017, 1000017, '2020-08-05 22:10:48');
INSERT INTO `shop_access_records` VALUES (1163, 1000014, 1000017, '2020-08-05 22:11:05');
INSERT INTO `shop_access_records` VALUES (1164, 1000001, 1000017, '2020-08-05 22:11:44');
INSERT INTO `shop_access_records` VALUES (1165, 1000017, 1000017, '2020-08-05 22:12:06');
INSERT INTO `shop_access_records` VALUES (1166, 1000035, 1000017, '2020-08-05 22:14:58');
INSERT INTO `shop_access_records` VALUES (1167, 1000017, 1000017, '2020-08-05 22:15:50');
INSERT INTO `shop_access_records` VALUES (1168, 1000042, 1000017, '2020-08-05 22:18:13');
INSERT INTO `shop_access_records` VALUES (1169, 1000035, 1000017, '2020-08-05 22:18:33');
INSERT INTO `shop_access_records` VALUES (1170, 1000014, 1000035, '2020-08-05 22:19:30');
INSERT INTO `shop_access_records` VALUES (1171, 1000039, 1000017, '2020-08-05 22:19:34');
INSERT INTO `shop_access_records` VALUES (1172, 1000014, 1000017, '2020-08-05 22:19:44');
INSERT INTO `shop_access_records` VALUES (1173, 1000035, 1000017, '2020-08-05 22:20:45');
INSERT INTO `shop_access_records` VALUES (1174, 1000047, 1000017, '2020-08-05 22:20:52');
INSERT INTO `shop_access_records` VALUES (1175, 1000035, 1000035, '2020-08-05 22:21:03');
INSERT INTO `shop_access_records` VALUES (1176, 1000047, 1000017, '2020-08-05 22:21:28');
INSERT INTO `shop_access_records` VALUES (1177, 1000039, 1000017, '2020-08-05 22:21:34');
INSERT INTO `shop_access_records` VALUES (1178, 1000047, 1000017, '2020-08-05 22:22:05');
INSERT INTO `shop_access_records` VALUES (1179, 1000017, 1000017, '2020-08-05 22:22:12');
INSERT INTO `shop_access_records` VALUES (1180, 1000013, 1000013, '2020-08-05 22:24:13');
INSERT INTO `shop_access_records` VALUES (1181, 1000047, 1000017, '2020-08-05 22:25:19');
INSERT INTO `shop_access_records` VALUES (1182, 1000017, 1000017, '2020-08-05 22:25:55');
INSERT INTO `shop_access_records` VALUES (1183, 1000042, 1000017, '2020-08-05 22:26:36');
INSERT INTO `shop_access_records` VALUES (1184, 1000048, 1000017, '2020-08-05 22:26:46');
INSERT INTO `shop_access_records` VALUES (1185, 1000047, 1000017, '2020-08-05 22:26:53');
INSERT INTO `shop_access_records` VALUES (1186, 1000039, 1000035, '2020-08-05 22:28:17');
INSERT INTO `shop_access_records` VALUES (1187, 1000043, 1000017, '2020-08-05 22:28:27');
INSERT INTO `shop_access_records` VALUES (1188, 1000043, 1000017, '2020-08-05 22:28:41');
INSERT INTO `shop_access_records` VALUES (1189, 1000047, 1000017, '2020-08-05 22:31:31');
INSERT INTO `shop_access_records` VALUES (1190, 1000043, 1000017, '2020-08-05 22:32:35');
INSERT INTO `shop_access_records` VALUES (1191, 1000049, 1000017, '2020-08-05 22:33:27');
INSERT INTO `shop_access_records` VALUES (1192, 1000035, 1000035, '2020-08-05 22:35:01');
INSERT INTO `shop_access_records` VALUES (1193, 1000035, 1000035, '2020-08-05 22:37:37');
INSERT INTO `shop_access_records` VALUES (1194, 1000035, 1000017, '2020-08-05 22:42:24');
INSERT INTO `shop_access_records` VALUES (1195, 1000017, 1000017, '2020-08-05 22:43:05');
INSERT INTO `shop_access_records` VALUES (1197, 1000049, 1000017, '2020-08-05 22:46:31');
INSERT INTO `shop_access_records` VALUES (1198, 1000050, 1000017, '2020-08-05 22:49:36');
INSERT INTO `shop_access_records` VALUES (1199, 1000035, 1000017, '2020-08-05 22:50:18');
INSERT INTO `shop_access_records` VALUES (1200, 1000035, 1000017, '2020-08-05 22:50:47');
INSERT INTO `shop_access_records` VALUES (1201, 1000035, 1000035, '2020-08-05 22:50:50');
INSERT INTO `shop_access_records` VALUES (1202, 1000014, 1000035, '2020-08-05 22:52:28');
INSERT INTO `shop_access_records` VALUES (1203, 1000014, 1000017, '2020-08-05 22:53:01');
INSERT INTO `shop_access_records` VALUES (1204, 1000017, 1000017, '2020-08-05 22:53:50');
INSERT INTO `shop_access_records` VALUES (1205, 1000044, 1000017, '2020-08-05 22:56:59');
INSERT INTO `shop_access_records` VALUES (1206, 1000051, 1000017, '2020-08-05 22:59:54');
INSERT INTO `shop_access_records` VALUES (1207, 1000052, 1000017, '2020-08-05 23:00:02');
INSERT INTO `shop_access_records` VALUES (1208, 1000033, 1000033, '2020-08-05 23:00:04');
INSERT INTO `shop_access_records` VALUES (1209, 1000051, 1000017, '2020-08-05 23:01:36');
INSERT INTO `shop_access_records` VALUES (1210, 1000053, 1000017, '2020-08-05 23:04:12');
INSERT INTO `shop_access_records` VALUES (1211, 1000017, 1000017, '2020-08-05 23:04:15');
INSERT INTO `shop_access_records` VALUES (1212, 1000053, 1000017, '2020-08-05 23:04:59');
INSERT INTO `shop_access_records` VALUES (1213, 1000027, 1000017, '2020-08-05 23:17:18');
INSERT INTO `shop_access_records` VALUES (1214, 1000017, 1000017, '2020-08-05 23:27:25');
INSERT INTO `shop_access_records` VALUES (1215, 1000054, 1000017, '2020-08-05 23:53:07');
INSERT INTO `shop_access_records` VALUES (1216, 1000055, 1000017, '2020-08-06 06:30:35');
INSERT INTO `shop_access_records` VALUES (1217, 1000013, 1000013, '2020-08-06 07:10:58');
INSERT INTO `shop_access_records` VALUES (1218, 1000017, 1000017, '2020-08-06 07:52:26');
INSERT INTO `shop_access_records` VALUES (1219, 1000040, 1000017, '2020-08-06 08:13:23');
INSERT INTO `shop_access_records` VALUES (1221, 1000027, 1000017, '2020-08-06 08:27:42');
INSERT INTO `shop_access_records` VALUES (1222, 1000027, 1000017, '2020-08-06 08:27:46');
INSERT INTO `shop_access_records` VALUES (1225, 1000017, 1000017, '2020-08-06 08:37:07');
INSERT INTO `shop_access_records` VALUES (1226, 1000017, 1000017, '2020-08-06 08:40:22');
INSERT INTO `shop_access_records` VALUES (1229, 1000001, 1000017, '2020-08-06 09:01:31');
INSERT INTO `shop_access_records` VALUES (1231, 1000013, 1000013, '2020-08-06 09:08:06');
INSERT INTO `shop_access_records` VALUES (1232, 1000013, 1000017, '2020-08-06 09:10:04');
INSERT INTO `shop_access_records` VALUES (1233, 1000035, 1000035, '2020-08-06 09:10:14');
INSERT INTO `shop_access_records` VALUES (1234, 1000035, 1000017, '2020-08-06 09:10:23');
INSERT INTO `shop_access_records` VALUES (1235, 1000013, 1000017, '2020-08-06 09:11:00');
INSERT INTO `shop_access_records` VALUES (1237, 1000013, 1000017, '2020-08-06 09:11:34');
INSERT INTO `shop_access_records` VALUES (1238, 1000013, 1000013, '2020-08-06 09:12:09');
INSERT INTO `shop_access_records` VALUES (1239, 1000028, 1000017, '2020-08-06 09:12:13');
INSERT INTO `shop_access_records` VALUES (1240, 1000028, 1000017, '2020-08-06 09:13:26');
INSERT INTO `shop_access_records` VALUES (1241, 1000013, 1000013, '2020-08-06 09:13:40');
INSERT INTO `shop_access_records` VALUES (1242, 1000013, 1000017, '2020-08-06 09:13:53');
INSERT INTO `shop_access_records` VALUES (1243, 1000000, 1000017, '2020-08-06 09:16:28');
INSERT INTO `shop_access_records` VALUES (1244, 1000000, 1000017, '2020-08-06 09:18:19');
INSERT INTO `shop_access_records` VALUES (1248, 1000000, 1000013, '2020-08-06 09:21:06');
INSERT INTO `shop_access_records` VALUES (1249, 1000000, 1000017, '2020-08-06 09:22:03');
INSERT INTO `shop_access_records` VALUES (1250, 1000013, 1000013, '2020-08-06 09:24:18');
INSERT INTO `shop_access_records` VALUES (1251, 1000013, 1000013, '2020-08-06 09:25:51');
INSERT INTO `shop_access_records` VALUES (1252, 1000013, 1000013, '2020-08-06 09:26:18');
INSERT INTO `shop_access_records` VALUES (1254, 1000013, 1000013, '2020-08-06 09:37:04');
INSERT INTO `shop_access_records` VALUES (1255, 1000035, 1000035, '2020-08-06 09:37:20');
INSERT INTO `shop_access_records` VALUES (1259, 1000035, 1000035, '2020-08-06 09:49:27');
INSERT INTO `shop_access_records` VALUES (1260, 1000035, 1000035, '2020-08-06 09:50:57');
INSERT INTO `shop_access_records` VALUES (1261, 1000035, 1000035, '2020-08-06 09:53:04');
INSERT INTO `shop_access_records` VALUES (1262, 1000035, 1000035, '2020-08-06 09:53:42');
INSERT INTO `shop_access_records` VALUES (1263, 1000035, 1000035, '2020-08-06 09:54:01');
INSERT INTO `shop_access_records` VALUES (1264, 1000035, 1000035, '2020-08-06 09:54:29');
INSERT INTO `shop_access_records` VALUES (1266, 1000035, 1000035, '2020-08-06 09:57:24');
INSERT INTO `shop_access_records` VALUES (1267, 1000035, 1000035, '2020-08-06 09:58:08');
INSERT INTO `shop_access_records` VALUES (1268, 1000035, 1000035, '2020-08-06 09:58:43');
INSERT INTO `shop_access_records` VALUES (1269, 1000035, 1000035, '2020-08-06 10:02:37');
INSERT INTO `shop_access_records` VALUES (1270, 1000035, 1000035, '2020-08-06 10:03:10');
INSERT INTO `shop_access_records` VALUES (1271, 1000035, 1000035, '2020-08-06 10:04:45');
INSERT INTO `shop_access_records` VALUES (1272, 1000035, 1000035, '2020-08-06 10:05:13');
INSERT INTO `shop_access_records` VALUES (1273, 1000035, 1000035, '2020-08-06 10:06:37');
INSERT INTO `shop_access_records` VALUES (1315, 1000057, 1000017, '2020-08-06 10:24:00');
INSERT INTO `shop_access_records` VALUES (1324, 1000058, 1000017, '2020-08-06 10:41:31');
INSERT INTO `shop_access_records` VALUES (1332, 1000035, 1000035, '2020-08-06 11:01:12');
INSERT INTO `shop_access_records` VALUES (1333, 1000017, 1000017, '2020-08-06 11:06:40');
INSERT INTO `shop_access_records` VALUES (1334, 1000059, 1000017, '2020-08-06 11:14:43');
INSERT INTO `shop_access_records` VALUES (1335, 1000059, 1000017, '2020-08-06 11:15:37');
INSERT INTO `shop_access_records` VALUES (1336, 1000059, 1000017, '2020-08-06 11:16:28');
INSERT INTO `shop_access_records` VALUES (1337, 1000059, 1000017, '2020-08-06 11:18:55');
INSERT INTO `shop_access_records` VALUES (1340, 1000060, 1000060, '2020-08-06 11:23:25');
INSERT INTO `shop_access_records` VALUES (1347, 1000061, 1000017, '2020-08-06 11:36:07');
INSERT INTO `shop_access_records` VALUES (1349, 1000061, 1000017, '2020-08-06 11:36:45');
INSERT INTO `shop_access_records` VALUES (1353, 1000017, 1000017, '2020-08-06 11:44:32');
INSERT INTO `shop_access_records` VALUES (1354, 1000017, 1000017, '2020-08-06 11:46:43');
INSERT INTO `shop_access_records` VALUES (1356, 1000013, 1000013, '2020-08-06 11:48:57');
INSERT INTO `shop_access_records` VALUES (1359, 1000027, 1000017, '2020-08-06 11:56:36');
INSERT INTO `shop_access_records` VALUES (1360, 1000035, 1000017, '2020-08-06 11:56:39');
INSERT INTO `shop_access_records` VALUES (1361, 1000062, 1000017, '2020-08-06 11:56:52');
INSERT INTO `shop_access_records` VALUES (1367, 1000063, 1000063, '2020-08-06 11:59:40');
INSERT INTO `shop_access_records` VALUES (1368, 1000001, 1000017, '2020-08-06 12:00:12');
INSERT INTO `shop_access_records` VALUES (1369, 1000019, 1000017, '2020-08-06 12:01:42');
INSERT INTO `shop_access_records` VALUES (1371, 1000046, 1000017, '2020-08-06 12:05:47');
INSERT INTO `shop_access_records` VALUES (1372, 1000017, 1000017, '2020-08-06 12:14:13');
INSERT INTO `shop_access_records` VALUES (1374, 1000013, 1000013, '2020-08-06 12:16:09');
INSERT INTO `shop_access_records` VALUES (1376, 1000017, 1000017, '2020-08-06 12:19:11');
INSERT INTO `shop_access_records` VALUES (1379, 1000013, 1000013, '2020-08-06 12:19:40');
INSERT INTO `shop_access_records` VALUES (1382, 1000017, 1000017, '2020-08-06 12:26:17');
INSERT INTO `shop_access_records` VALUES (1384, 1000017, 1000017, '2020-08-06 12:26:26');
INSERT INTO `shop_access_records` VALUES (1385, 1000013, 1000013, '2020-08-06 12:28:11');
INSERT INTO `shop_access_records` VALUES (1386, 1000013, 1000013, '2020-08-06 12:29:25');
INSERT INTO `shop_access_records` VALUES (1388, 1000013, 1000013, '2020-08-06 12:29:44');
INSERT INTO `shop_access_records` VALUES (1389, 1000017, 1000017, '2020-08-06 12:30:00');
INSERT INTO `shop_access_records` VALUES (1391, 1000013, 1000013, '2020-08-06 12:30:05');
INSERT INTO `shop_access_records` VALUES (1393, 1000057, 1000017, '2020-08-06 12:31:09');
INSERT INTO `shop_access_records` VALUES (1396, 1000064, 1000017, '2020-08-06 12:33:51');
INSERT INTO `shop_access_records` VALUES (1397, 1000013, 1000013, '2020-08-06 12:34:07');
INSERT INTO `shop_access_records` VALUES (1398, 1000013, 1000013, '2020-08-06 12:37:04');
INSERT INTO `shop_access_records` VALUES (1400, 1000013, 1000013, '2020-08-06 12:37:45');
INSERT INTO `shop_access_records` VALUES (1401, 1000013, 1000013, '2020-08-06 12:38:25');
INSERT INTO `shop_access_records` VALUES (1402, 1000065, 1000013, '2020-08-06 12:42:49');
INSERT INTO `shop_access_records` VALUES (1403, 1000013, 1000013, '2020-08-06 12:43:04');
INSERT INTO `shop_access_records` VALUES (1404, 1000065, 1000013, '2020-08-06 12:43:21');
INSERT INTO `shop_access_records` VALUES (1407, 1000066, 1000013, '2020-08-06 13:04:22');
INSERT INTO `shop_access_records` VALUES (1409, 1000066, 1000013, '2020-08-06 13:05:36');
INSERT INTO `shop_access_records` VALUES (1411, 1000017, 1000017, '2020-08-06 13:10:23');
INSERT INTO `shop_access_records` VALUES (1413, 1000069, 1000013, '2020-08-06 13:24:36');
INSERT INTO `shop_access_records` VALUES (1422, 1000035, 1000035, '2020-08-06 14:19:33');
INSERT INTO `shop_access_records` VALUES (1424, 1000069, 1000013, '2020-08-06 14:21:06');
INSERT INTO `shop_access_records` VALUES (1428, 1000013, 1000013, '2020-08-06 14:24:54');
INSERT INTO `shop_access_records` VALUES (1430, 1000065, 1000013, '2020-08-06 14:25:36');
INSERT INTO `shop_access_records` VALUES (1433, 1000069, 1000013, '2020-08-06 14:28:51');
INSERT INTO `shop_access_records` VALUES (1435, 1000069, 1000013, '2020-08-06 14:30:23');
INSERT INTO `shop_access_records` VALUES (1437, 1000013, 1000013, '2020-08-06 14:32:13');
INSERT INTO `shop_access_records` VALUES (1441, 1000013, 1000013, '2020-08-06 14:33:32');
INSERT INTO `shop_access_records` VALUES (1442, 1000069, 1000013, '2020-08-06 14:34:24');
INSERT INTO `shop_access_records` VALUES (1443, 1000070, 1000013, '2020-08-06 14:36:55');
INSERT INTO `shop_access_records` VALUES (1444, 1000065, 1000013, '2020-08-06 14:40:18');
INSERT INTO `shop_access_records` VALUES (1445, 1000070, 1000013, '2020-08-06 14:40:28');
INSERT INTO `shop_access_records` VALUES (1446, 1000065, 1000013, '2020-08-06 14:40:35');
INSERT INTO `shop_access_records` VALUES (1447, 1000013, 1000013, '2020-08-06 14:45:45');
INSERT INTO `shop_access_records` VALUES (1453, 1000013, 1000013, '2020-08-06 14:52:36');
INSERT INTO `shop_access_records` VALUES (1454, 1000066, 1000013, '2020-08-06 14:56:43');
INSERT INTO `shop_access_records` VALUES (1455, 1000013, 1000013, '2020-08-06 15:00:55');
INSERT INTO `shop_access_records` VALUES (1465, 1000028, 1000017, '2020-08-06 15:28:46');
INSERT INTO `shop_access_records` VALUES (1466, 1000017, 1000017, '2020-08-06 15:29:18');
INSERT INTO `shop_access_records` VALUES (1467, 1000028, 1000017, '2020-08-06 15:29:47');
INSERT INTO `shop_access_records` VALUES (1470, 1000028, 1000017, '2020-08-06 15:36:05');
INSERT INTO `shop_access_records` VALUES (1471, 1000028, 1000017, '2020-08-06 15:37:05');
INSERT INTO `shop_access_records` VALUES (1487, 1000028, 1000017, '2020-08-06 15:55:55');
INSERT INTO `shop_access_records` VALUES (1489, 1000028, 1000017, '2020-08-06 15:56:24');
INSERT INTO `shop_access_records` VALUES (1493, 1000028, 1000017, '2020-08-06 15:58:56');
INSERT INTO `shop_access_records` VALUES (1496, 1000028, 1000017, '2020-08-06 16:00:04');
INSERT INTO `shop_access_records` VALUES (1500, 1000017, 1000017, '2020-08-06 16:06:16');
INSERT INTO `shop_access_records` VALUES (1502, 1000028, 1000017, '2020-08-06 16:08:10');
INSERT INTO `shop_access_records` VALUES (1507, 1000017, 1000017, '2020-08-06 16:15:40');
INSERT INTO `shop_access_records` VALUES (1511, 1000035, 1000035, '2020-08-06 16:23:47');
INSERT INTO `shop_access_records` VALUES (1515, 1000017, 1000017, '2020-08-06 16:28:03');
INSERT INTO `shop_access_records` VALUES (1520, 1000035, 1000035, '2020-08-06 16:38:40');
INSERT INTO `shop_access_records` VALUES (1521, 1000035, 1000035, '2020-08-06 16:41:16');
INSERT INTO `shop_access_records` VALUES (1522, 1000035, 1000035, '2020-08-06 16:42:19');
INSERT INTO `shop_access_records` VALUES (1523, 1000035, 1000035, '2020-08-06 16:42:51');
INSERT INTO `shop_access_records` VALUES (1524, 1000035, 1000035, '2020-08-06 16:43:11');
INSERT INTO `shop_access_records` VALUES (1529, 1000035, 1000035, '2020-08-06 16:46:46');
INSERT INTO `shop_access_records` VALUES (1532, 1000035, 1000035, '2020-08-06 16:49:30');
INSERT INTO `shop_access_records` VALUES (1535, 1000056, 1000017, '2020-08-06 16:55:59');
INSERT INTO `shop_access_records` VALUES (1538, 1000071, 1000017, '2020-08-06 17:05:29');
INSERT INTO `shop_access_records` VALUES (1539, 1000071, 1000017, '2020-08-06 17:06:39');
INSERT INTO `shop_access_records` VALUES (1540, 1000071, 1000017, '2020-08-06 17:07:47');
INSERT INTO `shop_access_records` VALUES (1541, 1000001, 1000017, '2020-08-06 17:08:26');
INSERT INTO `shop_access_records` VALUES (1549, 1000071, 1000017, '2020-08-06 17:18:58');
INSERT INTO `shop_access_records` VALUES (1550, 1000017, 1000017, '2020-08-06 17:19:50');
INSERT INTO `shop_access_records` VALUES (1553, 1000008, 1000017, '2020-08-06 17:22:12');
INSERT INTO `shop_access_records` VALUES (1556, 1000008, 1000017, '2020-08-06 17:24:41');
INSERT INTO `shop_access_records` VALUES (1557, 1000017, 1000017, '2020-08-06 17:26:25');
INSERT INTO `shop_access_records` VALUES (1559, 1000001, 1000017, '2020-08-06 17:26:48');
INSERT INTO `shop_access_records` VALUES (1562, 1000008, 1000017, '2020-08-06 17:27:25');
INSERT INTO `shop_access_records` VALUES (1564, 1000008, 1000017, '2020-08-06 17:27:54');
INSERT INTO `shop_access_records` VALUES (1565, 1000040, 1000017, '2020-08-06 17:28:06');
INSERT INTO `shop_access_records` VALUES (1566, 1000071, 1000017, '2020-08-06 17:28:20');
INSERT INTO `shop_access_records` VALUES (1568, 1000008, 1000017, '2020-08-06 17:29:01');
INSERT INTO `shop_access_records` VALUES (1570, 1000008, 1000017, '2020-08-06 17:29:31');
INSERT INTO `shop_access_records` VALUES (1571, 1000017, 1000017, '2020-08-06 17:29:47');
INSERT INTO `shop_access_records` VALUES (1572, 1000071, 1000017, '2020-08-06 17:29:54');
INSERT INTO `shop_access_records` VALUES (1574, 1000040, 1000017, '2020-08-06 17:45:40');
INSERT INTO `shop_access_records` VALUES (1577, 1000013, 1000013, '2020-08-06 17:46:36');
INSERT INTO `shop_access_records` VALUES (1579, 1000040, 1000017, '2020-08-06 17:49:05');
INSERT INTO `shop_access_records` VALUES (1584, 1000001, 1000017, '2020-08-06 17:53:23');
INSERT INTO `shop_access_records` VALUES (1589, 1000013, 1000013, '2020-08-06 17:58:56');
INSERT INTO `shop_access_records` VALUES (1591, 1000028, 1000017, '2020-08-06 18:02:00');
INSERT INTO `shop_access_records` VALUES (1592, 1000008, 1000017, '2020-08-06 18:02:05');
INSERT INTO `shop_access_records` VALUES (1600, 1000008, 1000017, '2020-08-06 18:09:22');
INSERT INTO `shop_access_records` VALUES (1604, 1000008, 1000017, '2020-08-06 18:12:05');
INSERT INTO `shop_access_records` VALUES (1606, 1000008, 1000017, '2020-08-06 18:14:32');
INSERT INTO `shop_access_records` VALUES (1607, 1000013, 1000013, '2020-08-06 18:15:04');
INSERT INTO `shop_access_records` VALUES (1608, 1000017, 1000017, '2020-08-06 18:15:09');
INSERT INTO `shop_access_records` VALUES (1609, 1000013, 1000013, '2020-08-06 18:15:17');
INSERT INTO `shop_access_records` VALUES (1610, 1000017, 1000017, '2020-08-06 18:15:30');
INSERT INTO `shop_access_records` VALUES (1614, 1000013, 1000013, '2020-08-06 18:18:57');
INSERT INTO `shop_access_records` VALUES (1615, 1000035, 1000035, '2020-08-06 18:18:59');
INSERT INTO `shop_access_records` VALUES (1617, 1000013, 1000017, '2020-08-06 18:19:20');
INSERT INTO `shop_access_records` VALUES (1624, 1000013, 1000013, '2020-08-06 18:23:44');
INSERT INTO `shop_access_records` VALUES (1627, 1000014, 1000035, '2020-08-06 18:31:34');
INSERT INTO `shop_access_records` VALUES (1630, 1000040, 1000017, '2020-08-06 18:34:52');
INSERT INTO `shop_access_records` VALUES (1632, 1000040, 1000017, '2020-08-06 18:40:54');
INSERT INTO `shop_access_records` VALUES (1642, 1000064, 1000017, '2020-08-06 19:08:42');
INSERT INTO `shop_access_records` VALUES (1653, 1000035, 1000035, '2020-08-06 19:39:59');
INSERT INTO `shop_access_records` VALUES (1658, 1000013, 1000013, '2020-08-06 19:44:34');
INSERT INTO `shop_access_records` VALUES (1660, 1000013, 1000013, '2020-08-06 19:45:30');
INSERT INTO `shop_access_records` VALUES (1665, 1000035, 1000035, '2020-08-06 19:49:19');
INSERT INTO `shop_access_records` VALUES (1667, 1000035, 1000035, '2020-08-06 19:53:23');
INSERT INTO `shop_access_records` VALUES (1668, 1000035, 1000013, '2020-08-06 19:53:39');
INSERT INTO `shop_access_records` VALUES (1671, 1000035, 1000035, '2020-08-06 19:59:30');
INSERT INTO `shop_access_records` VALUES (1678, 1000035, 1000035, '2020-08-06 20:07:00');
INSERT INTO `shop_access_records` VALUES (1681, 1000035, 1000035, '2020-08-06 20:13:51');
INSERT INTO `shop_access_records` VALUES (1686, 1000035, 1000035, '2020-08-06 20:20:01');
INSERT INTO `shop_access_records` VALUES (1687, 1000035, 1000035, '2020-08-06 20:20:37');
INSERT INTO `shop_access_records` VALUES (1689, 1000035, 1000035, '2020-08-06 20:21:26');
INSERT INTO `shop_access_records` VALUES (1690, 1000035, 1000035, '2020-08-06 20:21:47');
INSERT INTO `shop_access_records` VALUES (1691, 1000035, 1000035, '2020-08-06 20:22:45');
INSERT INTO `shop_access_records` VALUES (1692, 1000035, 1000035, '2020-08-06 20:25:19');
INSERT INTO `shop_access_records` VALUES (1693, 1000017, 1000017, '2020-08-06 20:25:30');
INSERT INTO `shop_access_records` VALUES (1694, 1000035, 1000017, '2020-08-06 20:26:19');
INSERT INTO `shop_access_records` VALUES (1695, 1000017, 1000017, '2020-08-06 20:45:08');
INSERT INTO `shop_access_records` VALUES (1696, 1000035, 1000035, '2020-08-06 21:27:33');
INSERT INTO `shop_access_records` VALUES (1699, 1000035, 1000035, '2020-08-06 21:33:50');
INSERT INTO `shop_access_records` VALUES (1702, 1000035, 1000035, '2020-08-06 22:40:08');
INSERT INTO `shop_access_records` VALUES (1703, 1000014, 1000035, '2020-08-06 22:40:35');
INSERT INTO `shop_access_records` VALUES (1704, 1000014, 1000017, '2020-08-06 22:41:40');
INSERT INTO `shop_access_records` VALUES (1705, 1000017, 1000017, '2020-08-06 22:44:17');
INSERT INTO `shop_access_records` VALUES (1706, 1000040, 1000017, '2020-08-06 23:30:02');
INSERT INTO `shop_access_records` VALUES (1710, 1000035, 1000035, '2020-08-07 07:37:49');
INSERT INTO `shop_access_records` VALUES (1717, 1000017, 1000017, '2020-08-07 09:24:47');
INSERT INTO `shop_access_records` VALUES (1720, 1000017, 1000017, '2020-08-07 09:25:24');
INSERT INTO `shop_access_records` VALUES (1721, 1000013, 1000013, '2020-08-07 09:29:49');
INSERT INTO `shop_access_records` VALUES (1726, 1000014, 1000035, '2020-08-07 10:20:56');
INSERT INTO `shop_access_records` VALUES (1727, 1000017, 1000017, '2020-08-07 10:29:59');
INSERT INTO `shop_access_records` VALUES (1728, 1000035, 1000017, '2020-08-07 10:30:41');
INSERT INTO `shop_access_records` VALUES (1729, 1000017, 1000017, '2020-08-07 10:31:26');
INSERT INTO `shop_access_records` VALUES (1730, 1000017, 1000017, '2020-08-07 10:36:15');
INSERT INTO `shop_access_records` VALUES (1731, 1000017, 1000017, '2020-08-07 10:53:25');
INSERT INTO `shop_access_records` VALUES (1735, 1000074, 1000017, '2020-08-07 11:24:59');
INSERT INTO `shop_access_records` VALUES (1736, 1000075, 1000017, '2020-08-07 11:26:27');
INSERT INTO `shop_access_records` VALUES (1737, 1000076, 1000017, '2020-08-07 11:28:12');
INSERT INTO `shop_access_records` VALUES (1738, 1000074, 1000017, '2020-08-07 11:28:40');
INSERT INTO `shop_access_records` VALUES (1741, 1000074, 1000017, '2020-08-07 11:43:36');
INSERT INTO `shop_access_records` VALUES (1742, 1000077, 1000017, '2020-08-07 11:44:28');
INSERT INTO `shop_access_records` VALUES (1743, 1000077, 1000017, '2020-08-07 11:44:41');
INSERT INTO `shop_access_records` VALUES (1747, 1000078, 1000017, '2020-08-07 12:05:16');
INSERT INTO `shop_access_records` VALUES (1748, 1000027, 1000017, '2020-08-07 12:08:38');
INSERT INTO `shop_access_records` VALUES (1749, 1000079, 1000017, '2020-08-07 12:08:54');
INSERT INTO `shop_access_records` VALUES (1750, 1000079, 1000017, '2020-08-07 12:09:27');
INSERT INTO `shop_access_records` VALUES (1751, 1000079, 1000017, '2020-08-07 12:09:45');
INSERT INTO `shop_access_records` VALUES (1759, 1000013, 1000013, '2020-08-07 12:27:29');
INSERT INTO `shop_access_records` VALUES (1760, 1000013, 1000013, '2020-08-07 12:40:04');
INSERT INTO `shop_access_records` VALUES (1761, 1000017, 1000017, '2020-08-07 13:22:41');
INSERT INTO `shop_access_records` VALUES (1762, 1000075, 1000017, '2020-08-07 13:54:15');
INSERT INTO `shop_access_records` VALUES (1763, 1000075, 1000017, '2020-08-07 13:54:42');
INSERT INTO `shop_access_records` VALUES (1765, 1000017, 1000017, '2020-08-07 14:38:47');
INSERT INTO `shop_access_records` VALUES (1766, 1000013, 1000013, '2020-08-07 14:38:55');
INSERT INTO `shop_access_records` VALUES (1768, 1000017, 1000017, '2020-08-07 15:12:05');
INSERT INTO `shop_access_records` VALUES (1769, 1000017, 1000017, '2020-08-07 15:17:01');
INSERT INTO `shop_access_records` VALUES (1770, 1000028, 1000017, '2020-08-07 15:17:19');
INSERT INTO `shop_access_records` VALUES (1771, 1000013, 1000013, '2020-08-07 15:17:50');
INSERT INTO `shop_access_records` VALUES (1772, 1000017, 1000017, '2020-08-07 15:19:43');
INSERT INTO `shop_access_records` VALUES (1773, 1000013, 1000013, '2020-08-07 15:20:34');
INSERT INTO `shop_access_records` VALUES (1774, 1000017, 1000017, '2020-08-07 15:29:10');
INSERT INTO `shop_access_records` VALUES (1775, 1000035, 1000035, '2020-08-07 15:31:57');
INSERT INTO `shop_access_records` VALUES (1777, 1000035, 1000017, '2020-08-07 15:32:58');
INSERT INTO `shop_access_records` VALUES (1778, 1000035, 1000035, '2020-08-07 15:33:39');
INSERT INTO `shop_access_records` VALUES (1780, 1000013, 1000013, '2020-08-07 15:36:07');
INSERT INTO `shop_access_records` VALUES (1782, 1000035, 1000035, '2020-08-07 15:40:11');
INSERT INTO `shop_access_records` VALUES (1785, 1000035, 1000035, '2020-08-07 16:04:04');
INSERT INTO `shop_access_records` VALUES (1790, 1000017, 1000017, '2020-08-07 16:11:19');
INSERT INTO `shop_access_records` VALUES (1796, 1000013, 1000013, '2020-08-07 16:22:41');
INSERT INTO `shop_access_records` VALUES (1797, 1000035, 1000035, '2020-08-07 16:24:18');
INSERT INTO `shop_access_records` VALUES (1800, 1000013, 1000013, '2020-08-07 16:24:46');
INSERT INTO `shop_access_records` VALUES (1802, 1000018, 1000018, '2020-08-07 16:49:54');
INSERT INTO `shop_access_records` VALUES (1803, 1000017, 1000017, '2020-08-07 16:49:58');
INSERT INTO `shop_access_records` VALUES (1804, 1000017, 1000017, '2020-08-07 16:52:46');
INSERT INTO `shop_access_records` VALUES (1806, 1000013, 1000013, '2020-08-07 16:56:40');
INSERT INTO `shop_access_records` VALUES (1807, 1000035, 1000035, '2020-08-07 17:03:16');
INSERT INTO `shop_access_records` VALUES (1809, 1000025, 1000082, '2020-08-07 17:05:16');
INSERT INTO `shop_access_records` VALUES (1812, 1000025, 1000082, '2020-08-07 17:10:21');
INSERT INTO `shop_access_records` VALUES (1816, 1000035, 1000035, '2020-08-07 17:17:22');
INSERT INTO `shop_access_records` VALUES (1817, 1000013, 1000013, '2020-08-07 17:17:32');
INSERT INTO `shop_access_records` VALUES (1818, 1000013, 1000017, '2020-08-07 17:17:37');
INSERT INTO `shop_access_records` VALUES (1819, 1000008, 1000082, '2020-08-07 17:17:49');
INSERT INTO `shop_access_records` VALUES (1820, 1000008, 1000017, '2020-08-07 17:17:53');
INSERT INTO `shop_access_records` VALUES (1821, 1000013, 1000013, '2020-08-07 17:18:17');
INSERT INTO `shop_access_records` VALUES (1822, 1000013, 1000017, '2020-08-07 17:18:23');
INSERT INTO `shop_access_records` VALUES (1823, 1000017, 1000017, '2020-08-07 17:18:37');
INSERT INTO `shop_access_records` VALUES (1824, 1000017, 1000017, '2020-08-07 17:19:53');
INSERT INTO `shop_access_records` VALUES (1825, 1000017, 1000017, '2020-08-07 17:25:58');
INSERT INTO `shop_access_records` VALUES (1826, 1000008, 1000082, '2020-08-07 17:27:10');
INSERT INTO `shop_access_records` VALUES (1827, 1000008, 1000017, '2020-08-07 17:27:13');
INSERT INTO `shop_access_records` VALUES (1828, 1000019, 1000017, '2020-08-07 17:27:50');
INSERT INTO `shop_access_records` VALUES (1829, 1000013, 1000013, '2020-08-07 17:29:50');
INSERT INTO `shop_access_records` VALUES (1830, 1000013, 1000013, '2020-08-07 17:30:18');
INSERT INTO `shop_access_records` VALUES (1831, 1000017, 1000017, '2020-08-07 17:42:41');
INSERT INTO `shop_access_records` VALUES (1832, 1000064, 1000017, '2020-08-07 18:06:48');
INSERT INTO `shop_access_records` VALUES (1835, 1000008, 1000082, '2020-08-07 18:38:56');
INSERT INTO `shop_access_records` VALUES (1836, 1000025, 1000082, '2020-08-07 18:39:24');
INSERT INTO `shop_access_records` VALUES (1837, 1000025, 1000082, '2020-08-07 18:40:37');
INSERT INTO `shop_access_records` VALUES (1838, 1000025, 1000082, '2020-08-07 18:40:51');
INSERT INTO `shop_access_records` VALUES (1840, 1000035, 1000035, '2020-08-07 19:08:12');
INSERT INTO `shop_access_records` VALUES (1841, 1000013, 1000013, '2020-08-07 19:30:43');
INSERT INTO `shop_access_records` VALUES (1848, 1000017, 1000017, '2020-08-07 19:35:59');
INSERT INTO `shop_access_records` VALUES (1849, 1000035, 1000035, '2020-08-07 19:39:56');
INSERT INTO `shop_access_records` VALUES (1850, 1000085, 1000084, '2020-08-07 19:50:30');
INSERT INTO `shop_access_records` VALUES (1851, 1000084, 1000084, '2020-08-07 19:50:53');
INSERT INTO `shop_access_records` VALUES (1852, 1000085, 1000084, '2020-08-07 19:53:17');
INSERT INTO `shop_access_records` VALUES (1853, 1000084, 1000084, '2020-08-07 19:53:32');
INSERT INTO `shop_access_records` VALUES (1854, 1000017, 1000017, '2020-08-07 19:59:51');
INSERT INTO `shop_access_records` VALUES (1855, 1000013, 1000013, '2020-08-07 20:00:02');
INSERT INTO `shop_access_records` VALUES (1856, 1000084, 1000084, '2020-08-07 20:00:05');
INSERT INTO `shop_access_records` VALUES (1857, 1000008, 1000084, '2020-08-07 20:00:17');
INSERT INTO `shop_access_records` VALUES (1858, 1000008, 1000084, '2020-08-07 20:00:40');
INSERT INTO `shop_access_records` VALUES (1859, 1000008, 1000084, '2020-08-07 20:01:13');
INSERT INTO `shop_access_records` VALUES (1860, 1000008, 1000084, '2020-08-07 20:01:24');
INSERT INTO `shop_access_records` VALUES (1861, 1000085, 1000084, '2020-08-07 20:01:25');
INSERT INTO `shop_access_records` VALUES (1862, 1000084, 1000084, '2020-08-07 20:01:32');
INSERT INTO `shop_access_records` VALUES (1863, 1000085, 1000084, '2020-08-07 20:01:40');
INSERT INTO `shop_access_records` VALUES (1864, 1000001, 1000084, '2020-08-07 20:03:09');
INSERT INTO `shop_access_records` VALUES (1865, 1000001, 1000084, '2020-08-07 20:04:16');
INSERT INTO `shop_access_records` VALUES (1866, 1000035, 1000035, '2020-08-07 20:04:24');
INSERT INTO `shop_access_records` VALUES (1867, 1000008, 1000084, '2020-08-07 20:04:58');
INSERT INTO `shop_access_records` VALUES (1868, 1000035, 1000035, '2020-08-07 20:05:04');
INSERT INTO `shop_access_records` VALUES (1869, 1000084, 1000084, '2020-08-07 20:05:18');
INSERT INTO `shop_access_records` VALUES (1870, 1000035, 1000035, '2020-08-07 20:05:36');
INSERT INTO `shop_access_records` VALUES (1871, 1000084, 1000084, '2020-08-07 20:05:54');
INSERT INTO `shop_access_records` VALUES (1872, 1000008, 1000084, '2020-08-07 20:06:10');
INSERT INTO `shop_access_records` VALUES (1873, 1000025, 1000084, '2020-08-07 20:07:48');
INSERT INTO `shop_access_records` VALUES (1874, 1000017, 1000017, '2020-08-07 20:08:00');
INSERT INTO `shop_access_records` VALUES (1875, 1000017, 1000017, '2020-08-07 20:08:19');
INSERT INTO `shop_access_records` VALUES (1876, 1000035, 1000035, '2020-08-07 20:08:20');
INSERT INTO `shop_access_records` VALUES (1877, 1000017, 1000017, '2020-08-07 20:08:27');
INSERT INTO `shop_access_records` VALUES (1878, 1000017, 1000017, '2020-08-07 20:08:50');
INSERT INTO `shop_access_records` VALUES (1879, 1000018, 1000018, '2020-08-07 20:09:05');
INSERT INTO `shop_access_records` VALUES (1880, 1000017, 1000017, '2020-08-07 20:09:20');
INSERT INTO `shop_access_records` VALUES (1881, 1000084, 1000084, '2020-08-07 20:09:26');
INSERT INTO `shop_access_records` VALUES (1882, 1000084, 1000084, '2020-08-07 20:09:31');
INSERT INTO `shop_access_records` VALUES (1883, 1000084, 1000084, '2020-08-07 20:09:40');
INSERT INTO `shop_access_records` VALUES (1884, 1000035, 1000035, '2020-08-07 20:10:39');
INSERT INTO `shop_access_records` VALUES (1885, 1000035, 1000035, '2020-08-07 20:11:23');
INSERT INTO `shop_access_records` VALUES (1886, 1000001, 1000084, '2020-08-07 20:12:47');
INSERT INTO `shop_access_records` VALUES (1887, 1000035, 1000035, '2020-08-07 20:14:18');
INSERT INTO `shop_access_records` VALUES (1888, 1000035, 1000035, '2020-08-07 20:14:24');
INSERT INTO `shop_access_records` VALUES (1889, 1000035, 1000035, '2020-08-07 20:14:40');
INSERT INTO `shop_access_records` VALUES (1890, 1000035, 1000035, '2020-08-07 20:14:55');
INSERT INTO `shop_access_records` VALUES (1891, 1000035, 1000035, '2020-08-07 20:15:29');
INSERT INTO `shop_access_records` VALUES (1892, 1000085, 1000084, '2020-08-07 20:16:02');
INSERT INTO `shop_access_records` VALUES (1893, 1000084, 1000084, '2020-08-07 20:16:15');
INSERT INTO `shop_access_records` VALUES (1894, 1000013, 1000013, '2020-08-07 20:17:13');
INSERT INTO `shop_access_records` VALUES (1895, 1000017, 1000017, '2020-08-07 20:17:28');
INSERT INTO `shop_access_records` VALUES (1896, 1000025, 1000084, '2020-08-07 20:17:40');
INSERT INTO `shop_access_records` VALUES (1897, 1000084, 1000084, '2020-08-07 20:17:42');
INSERT INTO `shop_access_records` VALUES (1898, 1000008, 1000084, '2020-08-07 20:17:56');
INSERT INTO `shop_access_records` VALUES (1899, 1000084, 1000084, '2020-08-07 20:18:09');
INSERT INTO `shop_access_records` VALUES (1900, 1000008, 1000084, '2020-08-07 20:19:28');
INSERT INTO `shop_access_records` VALUES (1901, 1000017, 1000017, '2020-08-07 20:19:46');
INSERT INTO `shop_access_records` VALUES (1902, 1000008, 1000084, '2020-08-07 20:21:02');
INSERT INTO `shop_access_records` VALUES (1903, 1000017, 1000017, '2020-08-07 20:21:10');
INSERT INTO `shop_access_records` VALUES (1904, 1000084, 1000084, '2020-08-07 20:21:44');
INSERT INTO `shop_access_records` VALUES (1905, 1000084, 1000084, '2020-08-07 20:23:22');
INSERT INTO `shop_access_records` VALUES (1906, 1000085, 1000084, '2020-08-07 20:23:37');
INSERT INTO `shop_access_records` VALUES (1907, 1000017, 1000017, '2020-08-07 20:24:07');
INSERT INTO `shop_access_records` VALUES (1908, 1000084, 1000084, '2020-08-07 20:24:40');
INSERT INTO `shop_access_records` VALUES (1909, 1000084, 1000084, '2020-08-07 20:25:54');
INSERT INTO `shop_access_records` VALUES (1910, 1000084, 1000084, '2020-08-07 20:26:52');
INSERT INTO `shop_access_records` VALUES (1911, 1000084, 1000084, '2020-08-07 20:28:07');
INSERT INTO `shop_access_records` VALUES (1912, 1000001, 1000084, '2020-08-07 20:29:35');
INSERT INTO `shop_access_records` VALUES (1913, 1000084, 1000084, '2020-08-07 20:29:37');
INSERT INTO `shop_access_records` VALUES (1914, 1000025, 1000084, '2020-08-07 20:29:46');
INSERT INTO `shop_access_records` VALUES (1915, 1000017, 1000017, '2020-08-07 20:29:58');
INSERT INTO `shop_access_records` VALUES (1916, 1000001, 1000035, '2020-08-07 20:30:04');
INSERT INTO `shop_access_records` VALUES (1917, 1000001, 1000017, '2020-08-07 20:30:14');
INSERT INTO `shop_access_records` VALUES (1918, 1000084, 1000084, '2020-08-07 20:30:47');
INSERT INTO `shop_access_records` VALUES (1919, 1000035, 1000035, '2020-08-07 20:30:59');
INSERT INTO `shop_access_records` VALUES (1920, 1000084, 1000084, '2020-08-07 20:31:23');
INSERT INTO `shop_access_records` VALUES (1921, 1000084, 1000084, '2020-08-07 20:32:14');
INSERT INTO `shop_access_records` VALUES (1922, 1000085, 1000084, '2020-08-07 20:35:17');
INSERT INTO `shop_access_records` VALUES (1923, 1000084, 1000084, '2020-08-07 20:35:51');
INSERT INTO `shop_access_records` VALUES (1924, 1000084, 1000084, '2020-08-07 20:36:32');
INSERT INTO `shop_access_records` VALUES (1925, 1000085, 1000084, '2020-08-07 20:59:42');
INSERT INTO `shop_access_records` VALUES (1926, 1000013, 1000013, '2020-08-07 21:04:12');
INSERT INTO `shop_access_records` VALUES (1927, 1000084, 1000084, '2020-08-07 21:04:56');
INSERT INTO `shop_access_records` VALUES (1928, 1000084, 1000084, '2020-08-07 21:13:44');
INSERT INTO `shop_access_records` VALUES (1929, 1000084, 1000084, '2020-08-07 21:14:52');
INSERT INTO `shop_access_records` VALUES (1930, 1000084, 1000084, '2020-08-07 21:16:41');
INSERT INTO `shop_access_records` VALUES (1931, 1000084, 1000084, '2020-08-07 21:16:58');
INSERT INTO `shop_access_records` VALUES (1932, 1000085, 1000084, '2020-08-07 21:17:46');
INSERT INTO `shop_access_records` VALUES (1933, 1000084, 1000084, '2020-08-07 21:19:21');
INSERT INTO `shop_access_records` VALUES (1934, 1000085, 1000084, '2020-08-07 21:20:02');
INSERT INTO `shop_access_records` VALUES (1935, 1000084, 1000084, '2020-08-07 21:20:16');
INSERT INTO `shop_access_records` VALUES (1936, 1000084, 1000084, '2020-08-07 21:23:29');
INSERT INTO `shop_access_records` VALUES (1937, 1000035, 1000035, '2020-08-07 21:27:08');
INSERT INTO `shop_access_records` VALUES (1938, 1000035, 1000017, '2020-08-07 21:27:21');
INSERT INTO `shop_access_records` VALUES (1939, 1000035, 1000017, '2020-08-07 21:28:10');
INSERT INTO `shop_access_records` VALUES (1940, 1000035, 1000035, '2020-08-07 21:29:14');
INSERT INTO `shop_access_records` VALUES (1941, 1000084, 1000084, '2020-08-07 22:23:39');
INSERT INTO `shop_access_records` VALUES (1942, 1000012, 1000084, '2020-08-07 22:28:44');
INSERT INTO `shop_access_records` VALUES (1943, 1000085, 1000084, '2020-08-07 22:29:52');
INSERT INTO `shop_access_records` VALUES (1944, 1000035, 1000035, '2020-08-07 22:50:33');
INSERT INTO `shop_access_records` VALUES (1945, 1000084, 1000084, '2020-08-07 22:50:50');
INSERT INTO `shop_access_records` VALUES (1946, 1000085, 1000084, '2020-08-07 22:51:07');
INSERT INTO `shop_access_records` VALUES (1947, 1000085, 1000084, '2020-08-07 22:51:16');
INSERT INTO `shop_access_records` VALUES (1948, 1000085, 1000084, '2020-08-07 22:55:10');
INSERT INTO `shop_access_records` VALUES (1949, 1000012, 1000084, '2020-08-07 23:05:01');
INSERT INTO `shop_access_records` VALUES (1950, 1000012, 1000017, '2020-08-07 23:05:16');
INSERT INTO `shop_access_records` VALUES (1951, 1000085, 1000084, '2020-08-07 23:06:10');
INSERT INTO `shop_access_records` VALUES (1952, 1000084, 1000084, '2020-08-07 23:36:53');
INSERT INTO `shop_access_records` VALUES (1953, 1000084, 1000084, '2020-08-08 00:42:19');
INSERT INTO `shop_access_records` VALUES (1954, 1000085, 1000084, '2020-08-08 06:22:31');
INSERT INTO `shop_access_records` VALUES (1955, 1000084, 1000084, '2020-08-08 07:27:24');
INSERT INTO `shop_access_records` VALUES (1956, 1000084, 1000017, '2020-08-08 07:28:24');
INSERT INTO `shop_access_records` VALUES (1957, 1000085, 1000084, '2020-08-08 07:28:51');
INSERT INTO `shop_access_records` VALUES (1958, 1000084, 1000084, '2020-08-08 07:29:18');
INSERT INTO `shop_access_records` VALUES (1959, 1000013, 1000013, '2020-08-08 07:31:50');
INSERT INTO `shop_access_records` VALUES (1960, 1000017, 1000017, '2020-08-08 07:45:48');
INSERT INTO `shop_access_records` VALUES (1961, 1000017, 1000035, '2020-08-08 07:47:03');
INSERT INTO `shop_access_records` VALUES (1962, 1000017, 1000017, '2020-08-08 07:47:06');
INSERT INTO `shop_access_records` VALUES (1963, 1000017, 1000013, '2020-08-08 07:47:10');
INSERT INTO `shop_access_records` VALUES (1964, 1000013, 1000013, '2020-08-08 07:50:02');
INSERT INTO `shop_access_records` VALUES (1965, 1000035, 1000035, '2020-08-08 07:52:15');
INSERT INTO `shop_access_records` VALUES (1966, 1000035, 1000013, '2020-08-08 07:52:37');
INSERT INTO `shop_access_records` VALUES (1967, 1000013, 1000013, '2020-08-08 07:52:42');
INSERT INTO `shop_access_records` VALUES (1968, 1000035, 1000035, '2020-08-08 07:52:54');
INSERT INTO `shop_access_records` VALUES (1969, 1000035, 1000017, '2020-08-08 07:53:06');
INSERT INTO `shop_access_records` VALUES (1970, 1000013, 1000035, '2020-08-08 07:53:29');
INSERT INTO `shop_access_records` VALUES (1971, 1000013, 1000013, '2020-08-08 07:53:35');
INSERT INTO `shop_access_records` VALUES (1972, 1000013, 1000017, '2020-08-08 07:53:40');
INSERT INTO `shop_access_records` VALUES (1973, 1000014, 1000017, '2020-08-08 07:56:40');
INSERT INTO `shop_access_records` VALUES (1974, 1000014, 1000017, '2020-08-08 07:56:55');
INSERT INTO `shop_access_records` VALUES (1975, 1000014, 1000017, '2020-08-08 07:57:02');
INSERT INTO `shop_access_records` VALUES (1976, 1000014, 1000035, '2020-08-08 08:00:00');
INSERT INTO `shop_access_records` VALUES (1977, 1000035, 1000017, '2020-08-08 08:00:59');
INSERT INTO `shop_access_records` VALUES (1978, 1000035, 1000035, '2020-08-08 08:05:59');
INSERT INTO `shop_access_records` VALUES (1979, 1000040, 1000017, '2020-08-08 08:32:47');
INSERT INTO `shop_access_records` VALUES (1980, 1000035, 1000035, '2020-08-08 09:02:23');
INSERT INTO `shop_access_records` VALUES (1981, 1000035, 1000035, '2020-08-08 09:08:33');
INSERT INTO `shop_access_records` VALUES (1982, 1000014, 1000035, '2020-08-08 09:14:17');
INSERT INTO `shop_access_records` VALUES (1983, 1000014, 1000035, '2020-08-08 09:14:26');
INSERT INTO `shop_access_records` VALUES (1984, 1000035, 1000035, '2020-08-08 09:14:50');
INSERT INTO `shop_access_records` VALUES (1985, 1000014, 1000035, '2020-08-08 09:22:52');
INSERT INTO `shop_access_records` VALUES (1986, 1000085, 1000084, '2020-08-08 10:08:01');
INSERT INTO `shop_access_records` VALUES (1987, 1000084, 1000084, '2020-08-08 10:08:24');
INSERT INTO `shop_access_records` VALUES (1988, 1000035, 1000035, '2020-08-08 12:47:37');
INSERT INTO `shop_access_records` VALUES (1989, 1000035, 1000035, '2020-08-08 12:48:41');
INSERT INTO `shop_access_records` VALUES (1990, 1000035, 1000017, '2020-08-08 12:48:54');
INSERT INTO `shop_access_records` VALUES (1991, 1000035, 1000035, '2020-08-08 13:22:07');
INSERT INTO `shop_access_records` VALUES (1992, 1000035, 1000035, '2020-08-08 13:22:45');
INSERT INTO `shop_access_records` VALUES (1993, 1000014, 1000035, '2020-08-08 14:19:57');
INSERT INTO `shop_access_records` VALUES (1994, 1000014, 1000035, '2020-08-08 14:20:42');
INSERT INTO `shop_access_records` VALUES (1995, 1000014, 1000017, '2020-08-08 14:21:15');
INSERT INTO `shop_access_records` VALUES (1996, 1000014, 1000035, '2020-08-08 14:21:36');
INSERT INTO `shop_access_records` VALUES (1997, 1000014, 1000035, '2020-08-08 14:21:43');
INSERT INTO `shop_access_records` VALUES (1998, 1000014, 1000017, '2020-08-08 14:21:50');
INSERT INTO `shop_access_records` VALUES (1999, 1000014, 1000035, '2020-08-08 14:21:57');
INSERT INTO `shop_access_records` VALUES (2000, 1000008, 1000084, '2020-08-08 14:39:55');
INSERT INTO `shop_access_records` VALUES (2001, 1000013, 1000013, '2020-08-08 17:14:47');
INSERT INTO `shop_access_records` VALUES (2002, 1000017, 1000017, '2020-08-08 18:16:04');
INSERT INTO `shop_access_records` VALUES (2003, 1000079, 1000017, '2020-08-08 19:35:24');
INSERT INTO `shop_access_records` VALUES (2004, 1000035, 1000035, '2020-08-08 21:56:41');
INSERT INTO `shop_access_records` VALUES (2005, 1000035, 1000017, '2020-08-08 22:10:11');
INSERT INTO `shop_access_records` VALUES (2006, 1000085, 1000084, '2020-08-09 11:13:19');
INSERT INTO `shop_access_records` VALUES (2007, 1000017, 1000017, '2020-08-09 11:31:28');
INSERT INTO `shop_access_records` VALUES (2008, 1000027, 1000017, '2020-08-09 13:35:07');
INSERT INTO `shop_access_records` VALUES (2009, 1000035, 1000035, '2020-08-09 13:59:24');
INSERT INTO `shop_access_records` VALUES (2010, 1000017, 1000017, '2020-08-09 16:47:33');
INSERT INTO `shop_access_records` VALUES (2011, 1000028, 1000017, '2020-08-09 21:27:13');
INSERT INTO `shop_access_records` VALUES (2012, 1000017, 1000017, '2020-08-09 21:27:39');
INSERT INTO `shop_access_records` VALUES (2013, 1000028, 1000028, '2020-08-09 21:28:36');
INSERT INTO `shop_access_records` VALUES (2014, 1000028, 1000017, '2020-08-09 21:28:43');
INSERT INTO `shop_access_records` VALUES (2015, 1000028, 1000028, '2020-08-09 21:28:50');
INSERT INTO `shop_access_records` VALUES (2016, 1000035, 1000035, '2020-08-09 21:54:58');
INSERT INTO `shop_access_records` VALUES (2017, 1000035, 1000017, '2020-08-09 21:55:03');
INSERT INTO `shop_access_records` VALUES (2018, 1000017, 1000017, '2020-08-09 21:55:57');
INSERT INTO `shop_access_records` VALUES (2019, 1000027, 1000017, '2020-08-09 22:50:08');
INSERT INTO `shop_access_records` VALUES (2020, 1000060, 1000060, '2020-08-10 07:28:08');
INSERT INTO `shop_access_records` VALUES (2021, 1000085, 1000084, '2020-08-10 07:49:24');
INSERT INTO `shop_access_records` VALUES (2022, 1000084, 1000084, '2020-08-10 08:52:54');
INSERT INTO `shop_access_records` VALUES (2023, 1000013, 1000013, '2020-08-10 09:03:58');
INSERT INTO `shop_access_records` VALUES (2024, 1000018, 1000018, '2020-08-10 10:05:37');
INSERT INTO `shop_access_records` VALUES (2025, 1000017, 1000017, '2020-08-10 12:34:48');
INSERT INTO `shop_access_records` VALUES (2026, 1000090, 1000084, '2020-08-10 13:11:56');
INSERT INTO `shop_access_records` VALUES (2027, 1000018, 1000018, '2020-08-10 13:12:02');
INSERT INTO `shop_access_records` VALUES (2028, 1000090, 1000090, '2020-08-10 13:13:55');
INSERT INTO `shop_access_records` VALUES (2029, 1000035, 1000035, '2020-08-10 14:17:09');
INSERT INTO `shop_access_records` VALUES (2030, 1000035, 1000035, '2020-08-10 14:29:24');
INSERT INTO `shop_access_records` VALUES (2031, 1000035, 1000035, '2020-08-10 14:30:07');
INSERT INTO `shop_access_records` VALUES (2032, 1000035, 1000035, '2020-08-10 14:35:52');
INSERT INTO `shop_access_records` VALUES (2033, 1000035, 1000035, '2020-08-10 14:36:07');
INSERT INTO `shop_access_records` VALUES (2034, 1000035, 1000035, '2020-08-10 14:41:48');
INSERT INTO `shop_access_records` VALUES (2035, 1000035, 1000035, '2020-08-10 14:41:58');
INSERT INTO `shop_access_records` VALUES (2036, 1000035, 1000035, '2020-08-10 14:43:30');
INSERT INTO `shop_access_records` VALUES (2037, 1000035, 1000035, '2020-08-10 14:44:10');
INSERT INTO `shop_access_records` VALUES (2038, 1000035, 1000035, '2020-08-10 14:44:32');
INSERT INTO `shop_access_records` VALUES (2039, 1000035, 1000035, '2020-08-10 14:45:10');
INSERT INTO `shop_access_records` VALUES (2040, 1000035, 1000035, '2020-08-10 14:45:38');
INSERT INTO `shop_access_records` VALUES (2041, 1000035, 1000035, '2020-08-10 14:46:08');
INSERT INTO `shop_access_records` VALUES (2042, 1000035, 1000035, '2020-08-10 14:46:37');
INSERT INTO `shop_access_records` VALUES (2043, 1000035, 1000035, '2020-08-10 14:46:50');
INSERT INTO `shop_access_records` VALUES (2044, 1000035, 1000035, '2020-08-10 14:53:42');
INSERT INTO `shop_access_records` VALUES (2045, 1000035, 1000035, '2020-08-10 14:53:56');
INSERT INTO `shop_access_records` VALUES (2046, 1000035, 1000035, '2020-08-10 14:54:07');
INSERT INTO `shop_access_records` VALUES (2047, 1000035, 1000035, '2020-08-10 14:55:38');
INSERT INTO `shop_access_records` VALUES (2048, 1000035, 1000035, '2020-08-10 14:56:32');
INSERT INTO `shop_access_records` VALUES (2049, 1000035, 1000035, '2020-08-10 14:57:15');
INSERT INTO `shop_access_records` VALUES (2050, 1000035, 1000035, '2020-08-10 14:57:59');
INSERT INTO `shop_access_records` VALUES (2051, 1000035, 1000035, '2020-08-10 14:58:36');
INSERT INTO `shop_access_records` VALUES (2052, 1000035, 1000035, '2020-08-10 14:59:00');
INSERT INTO `shop_access_records` VALUES (2053, 1000035, 1000035, '2020-08-10 14:59:27');
INSERT INTO `shop_access_records` VALUES (2054, 1000035, 1000035, '2020-08-10 15:00:35');
INSERT INTO `shop_access_records` VALUES (2055, 1000035, 1000035, '2020-08-10 15:01:06');
INSERT INTO `shop_access_records` VALUES (2056, 1000035, 1000035, '2020-08-10 15:01:16');
INSERT INTO `shop_access_records` VALUES (2057, 1000035, 1000035, '2020-08-10 15:01:35');
INSERT INTO `shop_access_records` VALUES (2058, 1000035, 1000035, '2020-08-10 15:02:53');
INSERT INTO `shop_access_records` VALUES (2059, 1000035, 1000035, '2020-08-10 15:05:05');
INSERT INTO `shop_access_records` VALUES (2060, 1000035, 1000035, '2020-08-10 15:06:48');
INSERT INTO `shop_access_records` VALUES (2061, 1000035, 1000035, '2020-08-10 15:09:28');
INSERT INTO `shop_access_records` VALUES (2062, 1000035, 1000035, '2020-08-10 15:17:04');
INSERT INTO `shop_access_records` VALUES (2063, 1000035, 1000035, '2020-08-10 15:18:38');
INSERT INTO `shop_access_records` VALUES (2064, 1000035, 1000035, '2020-08-10 15:18:48');
INSERT INTO `shop_access_records` VALUES (2065, 1000035, 1000035, '2020-08-10 15:22:00');
INSERT INTO `shop_access_records` VALUES (2066, 1000017, 1000017, '2020-08-10 15:24:25');
INSERT INTO `shop_access_records` VALUES (2067, 1000001, 1000084, '2020-08-10 15:24:33');
INSERT INTO `shop_access_records` VALUES (2068, 1000001, 1000035, '2020-08-10 15:24:50');
INSERT INTO `shop_access_records` VALUES (2069, 1000001, 1000017, '2020-08-10 15:25:38');
INSERT INTO `shop_access_records` VALUES (2070, 1000001, 1000084, '2020-08-10 15:33:23');
INSERT INTO `shop_access_records` VALUES (2071, 1000017, 1000017, '2020-08-10 15:35:02');
INSERT INTO `shop_access_records` VALUES (2072, 1000017, 1000017, '2020-08-10 15:36:04');
INSERT INTO `shop_access_records` VALUES (2073, 1000017, 1000017, '2020-08-10 15:37:16');
INSERT INTO `shop_access_records` VALUES (2074, 1000035, 1000035, '2020-08-10 15:39:38');
INSERT INTO `shop_access_records` VALUES (2075, 1000017, 1000017, '2020-08-10 15:49:58');
INSERT INTO `shop_access_records` VALUES (2076, 1000017, 1000017, '2020-08-10 16:02:19');
INSERT INTO `shop_access_records` VALUES (2077, 1000017, 1000017, '2020-08-10 16:09:02');
INSERT INTO `shop_access_records` VALUES (2078, 1000017, 1000017, '2020-08-10 16:24:07');
INSERT INTO `shop_access_records` VALUES (2079, 1000001, 1000017, '2020-08-10 16:24:49');
INSERT INTO `shop_access_records` VALUES (2080, 1000091, 1000017, '2020-08-10 16:24:54');
INSERT INTO `shop_access_records` VALUES (2081, 1000085, 1000084, '2020-08-10 16:25:09');
INSERT INTO `shop_access_records` VALUES (2082, 1000091, 1000017, '2020-08-10 16:25:20');
INSERT INTO `shop_access_records` VALUES (2083, 1000085, 1000084, '2020-08-10 16:25:25');
INSERT INTO `shop_access_records` VALUES (2084, 1000017, 1000017, '2020-08-10 16:25:36');
INSERT INTO `shop_access_records` VALUES (2085, 1000001, 1000017, '2020-08-10 16:25:46');
INSERT INTO `shop_access_records` VALUES (2086, 1000001, 1000017, '2020-08-10 16:26:50');
INSERT INTO `shop_access_records` VALUES (2087, 1000075, 1000017, '2020-08-10 16:26:52');
INSERT INTO `shop_access_records` VALUES (2088, 1000092, 1000017, '2020-08-10 16:27:44');
INSERT INTO `shop_access_records` VALUES (2089, 1000093, 1000017, '2020-08-10 16:27:54');
INSERT INTO `shop_access_records` VALUES (2090, 1000094, 1000017, '2020-08-10 16:28:30');
INSERT INTO `shop_access_records` VALUES (2091, 1000017, 1000017, '2020-08-10 16:29:00');
INSERT INTO `shop_access_records` VALUES (2092, 1000095, 1000017, '2020-08-10 16:29:38');
INSERT INTO `shop_access_records` VALUES (2093, 1000001, 1000017, '2020-08-10 16:31:27');
INSERT INTO `shop_access_records` VALUES (2094, 1000001, 1000035, '2020-08-10 16:32:02');
INSERT INTO `shop_access_records` VALUES (2095, 1000001, 1000017, '2020-08-10 16:32:11');
INSERT INTO `shop_access_records` VALUES (2096, 1000001, 1000017, '2020-08-10 16:32:36');
INSERT INTO `shop_access_records` VALUES (2097, 1000017, 1000017, '2020-08-10 16:33:15');
INSERT INTO `shop_access_records` VALUES (2098, 1000096, 1000017, '2020-08-10 16:33:30');
INSERT INTO `shop_access_records` VALUES (2099, 1000093, 1000017, '2020-08-10 16:35:17');
INSERT INTO `shop_access_records` VALUES (2100, 1000017, 1000017, '2020-08-10 16:36:53');
INSERT INTO `shop_access_records` VALUES (2101, 1000092, 1000017, '2020-08-10 16:38:02');
INSERT INTO `shop_access_records` VALUES (2102, 1000075, 1000017, '2020-08-10 16:43:07');
INSERT INTO `shop_access_records` VALUES (2103, 1000075, 1000017, '2020-08-10 16:44:31');
INSERT INTO `shop_access_records` VALUES (2104, 1000017, 1000017, '2020-08-10 16:53:27');
INSERT INTO `shop_access_records` VALUES (2105, 1000017, 1000017, '2020-08-10 16:55:54');
INSERT INTO `shop_access_records` VALUES (2106, 1000000, 1000084, '2020-08-10 17:08:05');
INSERT INTO `shop_access_records` VALUES (2107, 1000001, 1000017, '2020-08-10 17:09:54');
INSERT INTO `shop_access_records` VALUES (2108, 1000001, 1000017, '2020-08-10 17:10:00');
INSERT INTO `shop_access_records` VALUES (2109, 1000017, 1000017, '2020-08-10 17:11:02');
INSERT INTO `shop_access_records` VALUES (2110, 1000075, 1000017, '2020-08-10 17:12:21');
INSERT INTO `shop_access_records` VALUES (2111, 1000075, 1000017, '2020-08-10 17:15:31');
INSERT INTO `shop_access_records` VALUES (2112, 1000075, 1000017, '2020-08-10 17:15:47');
INSERT INTO `shop_access_records` VALUES (2113, 1000075, 1000017, '2020-08-10 17:15:55');
INSERT INTO `shop_access_records` VALUES (2114, 1000017, 1000017, '2020-08-10 17:20:10');
INSERT INTO `shop_access_records` VALUES (2115, 1000017, 1000017, '2020-08-10 17:21:40');
INSERT INTO `shop_access_records` VALUES (2116, 1000075, 1000017, '2020-08-10 17:22:29');
INSERT INTO `shop_access_records` VALUES (2117, 1000075, 1000017, '2020-08-10 17:25:47');
INSERT INTO `shop_access_records` VALUES (2118, 1000035, 1000035, '2020-08-10 17:32:47');
INSERT INTO `shop_access_records` VALUES (2119, 1000017, 1000017, '2020-08-10 17:33:41');
INSERT INTO `shop_access_records` VALUES (2120, 1000008, 1000084, '2020-08-10 17:42:35');
INSERT INTO `shop_access_records` VALUES (2121, 1000008, 1000084, '2020-08-10 17:44:01');
INSERT INTO `shop_access_records` VALUES (2122, 1000008, 1000084, '2020-08-10 17:44:36');
INSERT INTO `shop_access_records` VALUES (2123, 1000008, 1000084, '2020-08-10 17:45:20');
INSERT INTO `shop_access_records` VALUES (2124, 1000008, 1000084, '2020-08-10 17:46:21');
INSERT INTO `shop_access_records` VALUES (2125, 1000008, 1000084, '2020-08-10 17:46:40');
INSERT INTO `shop_access_records` VALUES (2126, 1000008, 1000084, '2020-08-10 17:46:47');
INSERT INTO `shop_access_records` VALUES (2127, 1000017, 1000017, '2020-08-10 17:50:46');
INSERT INTO `shop_access_records` VALUES (2128, 1000001, 1000017, '2020-08-10 17:51:28');
INSERT INTO `shop_access_records` VALUES (2129, 1000017, 1000017, '2020-08-10 17:52:24');
INSERT INTO `shop_access_records` VALUES (2130, 1000054, 1000017, '2020-08-10 17:55:12');
INSERT INTO `shop_access_records` VALUES (2131, 1000008, 1000084, '2020-08-10 17:56:27');
INSERT INTO `shop_access_records` VALUES (2132, 1000017, 1000017, '2020-08-10 17:58:59');
INSERT INTO `shop_access_records` VALUES (2133, 1000008, 1000084, '2020-08-10 18:03:31');
INSERT INTO `shop_access_records` VALUES (2134, 1000008, 1000084, '2020-08-10 18:06:43');
INSERT INTO `shop_access_records` VALUES (2135, 1000000, 1000084, '2020-08-10 18:08:39');
INSERT INTO `shop_access_records` VALUES (2136, 1000017, 1000017, '2020-08-10 18:08:49');
INSERT INTO `shop_access_records` VALUES (2137, 1000017, 1000017, '2020-08-10 18:10:22');
INSERT INTO `shop_access_records` VALUES (2138, 1000017, 1000017, '2020-08-10 18:11:48');
INSERT INTO `shop_access_records` VALUES (2139, 1000017, 1000017, '2020-08-10 18:12:24');
INSERT INTO `shop_access_records` VALUES (2140, 1000017, 1000017, '2020-08-10 18:13:39');
INSERT INTO `shop_access_records` VALUES (2141, 1000001, 1000017, '2020-08-10 18:14:32');
INSERT INTO `shop_access_records` VALUES (2142, 1000008, 1000084, '2020-08-10 18:14:36');
INSERT INTO `shop_access_records` VALUES (2143, 1000001, 1000017, '2020-08-10 18:14:39');
INSERT INTO `shop_access_records` VALUES (2144, 1000017, 1000017, '2020-08-10 18:14:53');
INSERT INTO `shop_access_records` VALUES (2145, 1000008, 1000084, '2020-08-10 18:17:35');
INSERT INTO `shop_access_records` VALUES (2146, 1000008, 1000084, '2020-08-10 18:18:47');
INSERT INTO `shop_access_records` VALUES (2147, 1000008, 1000084, '2020-08-10 18:20:24');
INSERT INTO `shop_access_records` VALUES (2148, 1000008, 1000084, '2020-08-10 18:20:36');
INSERT INTO `shop_access_records` VALUES (2149, 1000008, 1000084, '2020-08-10 18:23:01');
INSERT INTO `shop_access_records` VALUES (2150, 1000017, 1000017, '2020-08-10 18:24:46');
INSERT INTO `shop_access_records` VALUES (2151, 1000017, 1000017, '2020-08-10 18:24:52');
INSERT INTO `shop_access_records` VALUES (2152, 1000001, 1000017, '2020-08-10 18:27:04');
INSERT INTO `shop_access_records` VALUES (2153, 1000017, 1000017, '2020-08-10 18:27:07');
INSERT INTO `shop_access_records` VALUES (2154, 1000084, 1000084, '2020-08-10 18:27:16');
INSERT INTO `shop_access_records` VALUES (2155, 1000084, 1000084, '2020-08-10 18:27:48');
INSERT INTO `shop_access_records` VALUES (2156, 1000001, 1000084, '2020-08-10 18:28:04');
INSERT INTO `shop_access_records` VALUES (2157, 1000001, 1000017, '2020-08-10 18:28:10');
INSERT INTO `shop_access_records` VALUES (2158, 1000035, 1000035, '2020-08-10 18:29:05');
INSERT INTO `shop_access_records` VALUES (2159, 1000008, 1000035, '2020-08-10 18:29:18');
INSERT INTO `shop_access_records` VALUES (2160, 1000094, 1000017, '2020-08-10 18:52:20');
INSERT INTO `shop_access_records` VALUES (2161, 1000035, 1000035, '2020-08-10 18:56:32');
INSERT INTO `shop_access_records` VALUES (2162, 1000035, 1000035, '2020-08-10 18:58:05');
INSERT INTO `shop_access_records` VALUES (2163, 1000017, 1000017, '2020-08-10 18:58:05');
INSERT INTO `shop_access_records` VALUES (2164, 1000008, 1000035, '2020-08-10 18:58:40');
INSERT INTO `shop_access_records` VALUES (2165, 1000008, 1000035, '2020-08-10 18:59:34');
INSERT INTO `shop_access_records` VALUES (2166, 1000084, 1000084, '2020-08-10 18:59:36');
INSERT INTO `shop_access_records` VALUES (2167, 1000008, 1000035, '2020-08-10 18:59:44');
INSERT INTO `shop_access_records` VALUES (2168, 1000035, 1000035, '2020-08-10 19:02:22');
INSERT INTO `shop_access_records` VALUES (2169, 1000085, 1000084, '2020-08-10 19:04:12');
INSERT INTO `shop_access_records` VALUES (2170, 1000084, 1000084, '2020-08-10 19:04:58');
INSERT INTO `shop_access_records` VALUES (2171, 1000014, 1000035, '2020-08-10 19:06:18');
INSERT INTO `shop_access_records` VALUES (2172, 1000035, 1000017, '2020-08-10 19:06:39');
INSERT INTO `shop_access_records` VALUES (2173, 1000014, 1000035, '2020-08-10 19:06:41');
INSERT INTO `shop_access_records` VALUES (2174, 1000014, 1000035, '2020-08-10 19:07:33');
INSERT INTO `shop_access_records` VALUES (2175, 1000014, 1000035, '2020-08-10 19:08:00');
INSERT INTO `shop_access_records` VALUES (2176, 1000035, 1000017, '2020-08-10 19:13:55');
INSERT INTO `shop_access_records` VALUES (2177, 1000095, 1000017, '2020-08-10 19:26:19');
INSERT INTO `shop_access_records` VALUES (2178, 1000054, 1000017, '2020-08-10 19:28:16');
INSERT INTO `shop_access_records` VALUES (2179, 1000008, 1000035, '2020-08-10 19:28:51');
INSERT INTO `shop_access_records` VALUES (2180, 1000035, 1000035, '2020-08-10 19:29:04');
INSERT INTO `shop_access_records` VALUES (2181, 1000008, 1000035, '2020-08-10 19:29:09');
INSERT INTO `shop_access_records` VALUES (2182, 1000014, 1000035, '2020-08-10 19:29:24');
INSERT INTO `shop_access_records` VALUES (2183, 1000014, 1000035, '2020-08-10 19:29:29');
INSERT INTO `shop_access_records` VALUES (2184, 1000095, 1000095, '2020-08-10 19:29:39');
INSERT INTO `shop_access_records` VALUES (2185, 1000008, 1000035, '2020-08-10 19:29:53');
INSERT INTO `shop_access_records` VALUES (2186, 1000035, 1000035, '2020-08-10 19:31:33');
INSERT INTO `shop_access_records` VALUES (2187, 1000035, 1000035, '2020-08-10 19:32:17');
INSERT INTO `shop_access_records` VALUES (2188, 1000035, 1000035, '2020-08-10 19:33:08');
INSERT INTO `shop_access_records` VALUES (2189, 1000035, 1000035, '2020-08-10 19:36:56');
INSERT INTO `shop_access_records` VALUES (2190, 1000035, 1000035, '2020-08-10 19:37:14');
INSERT INTO `shop_access_records` VALUES (2191, 1000001, 1000084, '2020-08-10 19:39:42');
INSERT INTO `shop_access_records` VALUES (2192, 1000001, 1000084, '2020-08-10 19:39:53');
INSERT INTO `shop_access_records` VALUES (2193, 1000035, 1000035, '2020-08-10 19:39:54');
INSERT INTO `shop_access_records` VALUES (2194, 1000035, 1000035, '2020-08-10 19:40:36');
INSERT INTO `shop_access_records` VALUES (2195, 1000035, 1000035, '2020-08-10 19:40:51');
INSERT INTO `shop_access_records` VALUES (2196, 1000035, 1000035, '2020-08-10 19:41:37');
INSERT INTO `shop_access_records` VALUES (2197, 1000035, 1000035, '2020-08-10 19:44:16');
INSERT INTO `shop_access_records` VALUES (2198, 1000035, 1000035, '2020-08-10 19:44:22');
INSERT INTO `shop_access_records` VALUES (2199, 1000035, 1000035, '2020-08-10 19:45:13');
INSERT INTO `shop_access_records` VALUES (2200, 1000035, 1000035, '2020-08-10 19:45:45');
INSERT INTO `shop_access_records` VALUES (2201, 1000035, 1000035, '2020-08-10 19:47:09');
INSERT INTO `shop_access_records` VALUES (2202, 1000035, 1000035, '2020-08-10 19:47:23');
INSERT INTO `shop_access_records` VALUES (2203, 1000035, 1000035, '2020-08-10 19:54:41');
INSERT INTO `shop_access_records` VALUES (2204, 1000035, 1000017, '2020-08-10 19:58:34');
INSERT INTO `shop_access_records` VALUES (2205, 1000035, 1000017, '2020-08-10 20:09:05');
INSERT INTO `shop_access_records` VALUES (2206, 1000035, 1000035, '2020-08-10 20:09:12');
INSERT INTO `shop_access_records` VALUES (2207, 1000035, 1000035, '2020-08-10 20:32:35');
INSERT INTO `shop_access_records` VALUES (2208, 1000035, 1000035, '2020-08-10 20:34:23');
INSERT INTO `shop_access_records` VALUES (2209, 1000035, 1000017, '2020-08-10 20:34:31');
INSERT INTO `shop_access_records` VALUES (2210, 1000098, 1000017, '2020-08-10 20:36:56');
INSERT INTO `shop_access_records` VALUES (2211, 1000035, 1000017, '2020-08-10 20:36:57');
INSERT INTO `shop_access_records` VALUES (2212, 1000035, 1000035, '2020-08-10 20:36:59');
INSERT INTO `shop_access_records` VALUES (2213, 1000035, 1000035, '2020-08-10 20:37:05');
INSERT INTO `shop_access_records` VALUES (2214, 1000035, 1000035, '2020-08-10 20:38:11');
INSERT INTO `shop_access_records` VALUES (2215, 1000035, 1000035, '2020-08-10 20:38:39');
INSERT INTO `shop_access_records` VALUES (2216, 1000035, 1000035, '2020-08-10 20:38:45');
INSERT INTO `shop_access_records` VALUES (2217, 1000014, 1000035, '2020-08-10 20:43:25');
INSERT INTO `shop_access_records` VALUES (2218, 1000017, 1000017, '2020-08-10 20:46:19');
INSERT INTO `shop_access_records` VALUES (2219, 1000017, 1000017, '2020-08-10 20:50:11');
INSERT INTO `shop_access_records` VALUES (2220, 1000013, 1000013, '2020-08-10 20:59:19');
INSERT INTO `shop_access_records` VALUES (2221, 1000065, 1000013, '2020-08-10 21:15:45');
INSERT INTO `shop_access_records` VALUES (2222, 1000065, 1000013, '2020-08-10 21:15:55');
INSERT INTO `shop_access_records` VALUES (2223, 1000085, 1000084, '2020-08-10 21:16:12');
INSERT INTO `shop_access_records` VALUES (2224, 1000065, 1000013, '2020-08-10 21:17:18');
INSERT INTO `shop_access_records` VALUES (2225, 1000099, 1000013, '2020-08-10 21:29:49');
INSERT INTO `shop_access_records` VALUES (2226, 1000065, 1000013, '2020-08-10 21:37:04');
INSERT INTO `shop_access_records` VALUES (2227, 1000065, 1000013, '2020-08-10 21:37:21');
INSERT INTO `shop_access_records` VALUES (2228, 1000065, 1000013, '2020-08-10 21:38:04');
INSERT INTO `shop_access_records` VALUES (2229, 1000065, 1000013, '2020-08-10 21:38:27');
INSERT INTO `shop_access_records` VALUES (2230, 1000085, 1000084, '2020-08-10 21:38:38');
INSERT INTO `shop_access_records` VALUES (2231, 1000065, 1000013, '2020-08-10 21:39:11');
INSERT INTO `shop_access_records` VALUES (2232, 1000065, 1000013, '2020-08-10 21:40:11');
INSERT INTO `shop_access_records` VALUES (2233, 1000065, 1000013, '2020-08-10 21:40:18');
INSERT INTO `shop_access_records` VALUES (2234, 1000013, 1000013, '2020-08-10 21:44:04');
INSERT INTO `shop_access_records` VALUES (2235, 1000065, 1000013, '2020-08-10 21:44:27');
INSERT INTO `shop_access_records` VALUES (2236, 1000099, 1000013, '2020-08-10 21:45:42');
INSERT INTO `shop_access_records` VALUES (2237, 1000099, 1000013, '2020-08-10 21:47:42');
INSERT INTO `shop_access_records` VALUES (2238, 1000001, 1000084, '2020-08-10 21:50:25');
INSERT INTO `shop_access_records` VALUES (2239, 1000001, 1000084, '2020-08-10 21:51:10');
INSERT INTO `shop_access_records` VALUES (2240, 1000099, 1000013, '2020-08-10 21:52:51');
INSERT INTO `shop_access_records` VALUES (2241, 1000036, 1000017, '2020-08-10 21:52:56');
INSERT INTO `shop_access_records` VALUES (2242, 1000099, 1000013, '2020-08-10 21:53:17');
INSERT INTO `shop_access_records` VALUES (2243, 1000099, 1000013, '2020-08-10 21:54:49');
INSERT INTO `shop_access_records` VALUES (2244, 1000099, 1000013, '2020-08-10 21:56:14');
INSERT INTO `shop_access_records` VALUES (2245, 1000099, 1000099, '2020-08-10 21:56:28');
INSERT INTO `shop_access_records` VALUES (2246, 1000065, 1000065, '2020-08-10 21:57:52');
INSERT INTO `shop_access_records` VALUES (2247, 1000099, 1000099, '2020-08-10 21:57:56');
INSERT INTO `shop_access_records` VALUES (2248, 1000095, 1000095, '2020-08-10 21:59:13');
INSERT INTO `shop_access_records` VALUES (2249, 1000099, 1000013, '2020-08-10 22:03:11');
INSERT INTO `shop_access_records` VALUES (2250, 1000013, 1000065, '2020-08-10 22:03:30');
INSERT INTO `shop_access_records` VALUES (2251, 1000065, 1000065, '2020-08-10 22:03:32');
INSERT INTO `shop_access_records` VALUES (2252, 1000099, 1000099, '2020-08-10 22:03:45');
INSERT INTO `shop_access_records` VALUES (2253, 1000013, 1000099, '2020-08-10 22:05:07');
INSERT INTO `shop_access_records` VALUES (2254, 1000013, 1000099, '2020-08-10 22:09:16');
INSERT INTO `shop_access_records` VALUES (2255, 1000065, 1000065, '2020-08-10 22:09:24');
INSERT INTO `shop_access_records` VALUES (2256, 1000099, 1000099, '2020-08-10 22:09:33');
INSERT INTO `shop_access_records` VALUES (2257, 1000065, 1000065, '2020-08-10 22:09:35');
INSERT INTO `shop_access_records` VALUES (2258, 1000099, 1000099, '2020-08-10 22:09:54');
INSERT INTO `shop_access_records` VALUES (2259, 1000008, 1000099, '2020-08-10 22:10:17');
INSERT INTO `shop_access_records` VALUES (2260, 1000035, 1000099, '2020-08-10 22:10:39');
INSERT INTO `shop_access_records` VALUES (2261, 1000001, 1000099, '2020-08-10 22:11:07');
INSERT INTO `shop_access_records` VALUES (2262, 1000001, 1000099, '2020-08-10 22:11:48');
INSERT INTO `shop_access_records` VALUES (2263, 1000013, 1000099, '2020-08-10 22:12:36');
INSERT INTO `shop_access_records` VALUES (2264, 1000013, 1000013, '2020-08-10 22:16:42');
INSERT INTO `shop_access_records` VALUES (2265, 1000017, 1000099, '2020-08-10 22:18:04');
INSERT INTO `shop_access_records` VALUES (2266, 1000013, 1000099, '2020-08-10 22:20:23');
INSERT INTO `shop_access_records` VALUES (2267, 1000054, 1000017, '2020-08-10 22:20:33');
INSERT INTO `shop_access_records` VALUES (2268, 1000013, 1000013, '2020-08-10 22:23:16');
INSERT INTO `shop_access_records` VALUES (2269, 1000013, 1000065, '2020-08-10 22:23:20');
INSERT INTO `shop_access_records` VALUES (2270, 1000013, 1000065, '2020-08-10 22:23:44');
INSERT INTO `shop_access_records` VALUES (2271, 1000013, 1000013, '2020-08-10 22:23:54');
INSERT INTO `shop_access_records` VALUES (2272, 1000013, 1000035, '2020-08-10 22:24:08');
INSERT INTO `shop_access_records` VALUES (2273, 1000054, 1000017, '2020-08-10 22:25:30');
INSERT INTO `shop_access_records` VALUES (2274, 1000001, 1000099, '2020-08-10 22:25:46');
INSERT INTO `shop_access_records` VALUES (2275, 1000001, 1000099, '2020-08-10 22:25:53');
INSERT INTO `shop_access_records` VALUES (2276, 1000099, 1000099, '2020-08-10 22:26:20');
INSERT INTO `shop_access_records` VALUES (2277, 1000001, 1000099, '2020-08-10 22:26:22');
INSERT INTO `shop_access_records` VALUES (2278, 1000013, 1000013, '2020-08-10 22:27:03');
INSERT INTO `shop_access_records` VALUES (2279, 1000017, 1000017, '2020-08-10 22:27:19');
INSERT INTO `shop_access_records` VALUES (2280, 1000099, 1000013, '2020-08-10 22:28:18');
INSERT INTO `shop_access_records` VALUES (2281, 1000101, 1000013, '2020-08-10 22:28:36');
INSERT INTO `shop_access_records` VALUES (2282, 1000099, 1000099, '2020-08-10 22:29:13');
INSERT INTO `shop_access_records` VALUES (2283, 1000099, 1000099, '2020-08-10 22:30:07');
INSERT INTO `shop_access_records` VALUES (2284, 1000013, 1000065, '2020-08-10 22:30:43');
INSERT INTO `shop_access_records` VALUES (2285, 1000099, 1000099, '2020-08-10 22:30:48');
INSERT INTO `shop_access_records` VALUES (2286, 1000013, 1000013, '2020-08-10 22:31:00');
INSERT INTO `shop_access_records` VALUES (2287, 1000099, 1000099, '2020-08-10 22:32:30');
INSERT INTO `shop_access_records` VALUES (2288, 1000101, 1000099, '2020-08-10 22:32:46');
INSERT INTO `shop_access_records` VALUES (2289, 1000001, 1000065, '2020-08-10 22:32:50');
INSERT INTO `shop_access_records` VALUES (2290, 1000017, 1000065, '2020-08-10 22:33:04');
INSERT INTO `shop_access_records` VALUES (2291, 1000001, 1000099, '2020-08-10 22:33:13');
INSERT INTO `shop_access_records` VALUES (2292, 1000017, 1000099, '2020-08-10 22:33:19');
INSERT INTO `shop_access_records` VALUES (2293, 1000035, 1000065, '2020-08-10 22:33:47');
INSERT INTO `shop_access_records` VALUES (2294, 1000103, 1000099, '2020-08-10 22:45:57');
INSERT INTO `shop_access_records` VALUES (2295, 1000103, 1000099, '2020-08-10 22:47:27');
INSERT INTO `shop_access_records` VALUES (2296, 1000103, 1000099, '2020-08-10 22:48:56');
INSERT INTO `shop_access_records` VALUES (2297, 1000103, 1000013, '2020-08-10 23:01:45');
INSERT INTO `shop_access_records` VALUES (2298, 1000013, 1000013, '2020-08-10 23:02:02');
INSERT INTO `shop_access_records` VALUES (2299, 1000103, 1000013, '2020-08-10 23:06:59');
INSERT INTO `shop_access_records` VALUES (2300, 1000099, 1000013, '2020-08-10 23:14:56');
INSERT INTO `shop_access_records` VALUES (2301, 1000099, 1000099, '2020-08-10 23:17:28');
INSERT INTO `shop_access_records` VALUES (2302, 1000103, 1000099, '2020-08-10 23:21:59');
INSERT INTO `shop_access_records` VALUES (2303, 1000099, 1000099, '2020-08-10 23:22:06');
INSERT INTO `shop_access_records` VALUES (2304, 1000099, 1000099, '2020-08-10 23:22:37');
INSERT INTO `shop_access_records` VALUES (2305, 1000001, 1000065, '2020-08-10 23:35:09');
INSERT INTO `shop_access_records` VALUES (2306, 1000001, 1000099, '2020-08-10 23:35:46');
INSERT INTO `shop_access_records` VALUES (2307, 1000001, 1000035, '2020-08-10 23:36:13');
INSERT INTO `shop_access_records` VALUES (2308, 1000001, 1000035, '2020-08-10 23:36:24');
INSERT INTO `shop_access_records` VALUES (2309, 1000001, 1000099, '2020-08-10 23:36:29');
INSERT INTO `shop_access_records` VALUES (2310, 1000001, 1000099, '2020-08-10 23:36:35');
INSERT INTO `shop_access_records` VALUES (2311, 1000016, 1000099, '2020-08-10 23:45:13');
INSERT INTO `shop_access_records` VALUES (2312, 1000016, 1000065, '2020-08-10 23:46:49');
INSERT INTO `shop_access_records` VALUES (2313, 1000016, 1000099, '2020-08-10 23:47:03');
INSERT INTO `shop_access_records` VALUES (2314, 1000013, 1000013, '2020-08-11 01:26:42');
INSERT INTO `shop_access_records` VALUES (2315, 1000001, 1000099, '2020-08-11 01:31:06');
INSERT INTO `shop_access_records` VALUES (2316, 1000001, 1000099, '2020-08-11 01:31:34');
INSERT INTO `shop_access_records` VALUES (2317, 1000022, 1000022, '2020-08-11 01:38:08');
INSERT INTO `shop_access_records` VALUES (2318, 1000022, 1000022, '2020-08-11 01:46:19');
INSERT INTO `shop_access_records` VALUES (2319, 1000075, 1000017, '2020-08-11 02:12:28');
INSERT INTO `shop_access_records` VALUES (2320, 1000075, 1000022, '2020-08-11 02:13:33');
INSERT INTO `shop_access_records` VALUES (2321, 1000075, 1000017, '2020-08-11 02:13:58');
INSERT INTO `shop_access_records` VALUES (2322, 1000075, 1000022, '2020-08-11 02:14:15');
INSERT INTO `shop_access_records` VALUES (2323, 1000075, 1000017, '2020-08-11 02:15:18');
INSERT INTO `shop_access_records` VALUES (2324, 1000075, 1000022, '2020-08-11 02:16:49');
INSERT INTO `shop_access_records` VALUES (2325, 1000075, 1000017, '2020-08-11 02:17:59');
INSERT INTO `shop_access_records` VALUES (2326, 1000017, 1000017, '2020-08-11 03:03:06');
INSERT INTO `shop_access_records` VALUES (2327, 1000100, 1000017, '2020-08-11 07:08:53');
INSERT INTO `shop_access_records` VALUES (2328, 1000100, 1000017, '2020-08-11 07:09:13');
INSERT INTO `shop_access_records` VALUES (2329, 1000017, 1000017, '2020-08-11 08:28:41');
INSERT INTO `shop_access_records` VALUES (2330, 1000075, 1000022, '2020-08-11 08:48:20');
INSERT INTO `shop_access_records` VALUES (2331, 1000075, 1000017, '2020-08-11 08:50:15');
INSERT INTO `shop_access_records` VALUES (2332, 1000075, 1000022, '2020-08-11 08:50:28');
INSERT INTO `shop_access_records` VALUES (2333, 1000035, 1000035, '2020-08-11 09:35:09');
INSERT INTO `shop_access_records` VALUES (2334, 1000035, 1000099, '2020-08-11 09:37:18');
INSERT INTO `shop_access_records` VALUES (2335, 1000035, 1000035, '2020-08-11 09:38:06');
INSERT INTO `shop_access_records` VALUES (2336, 1000035, 1000035, '2020-08-11 09:41:09');
INSERT INTO `shop_access_records` VALUES (2337, 1000084, 1000084, '2020-08-11 09:41:31');
INSERT INTO `shop_access_records` VALUES (2338, 1000035, 1000035, '2020-08-11 09:41:55');
INSERT INTO `shop_access_records` VALUES (2339, 1000035, 1000065, '2020-08-11 09:43:21');
INSERT INTO `shop_access_records` VALUES (2340, 1000035, 1000035, '2020-08-11 09:43:43');
INSERT INTO `shop_access_records` VALUES (2341, 1000035, 1000035, '2020-08-11 09:49:13');
INSERT INTO `shop_access_records` VALUES (2342, 1000025, 1000084, '2020-08-11 09:54:32');
INSERT INTO `shop_access_records` VALUES (2343, 1000025, 1000084, '2020-08-11 09:54:40');
INSERT INTO `shop_access_records` VALUES (2344, 1000084, 1000084, '2020-08-11 09:56:19');
INSERT INTO `shop_access_records` VALUES (2345, 1000084, 1000084, '2020-08-11 09:56:35');
INSERT INTO `shop_access_records` VALUES (2346, 1000017, 1000017, '2020-08-11 09:58:15');
INSERT INTO `shop_access_records` VALUES (2347, 1000106, 1000017, '2020-08-11 09:59:31');
INSERT INTO `shop_access_records` VALUES (2348, 1000084, 1000084, '2020-08-11 09:59:35');
INSERT INTO `shop_access_records` VALUES (2349, 1000106, 1000017, '2020-08-11 09:59:50');
INSERT INTO `shop_access_records` VALUES (2350, 1000106, 1000106, '2020-08-11 10:02:11');
INSERT INTO `shop_access_records` VALUES (2351, 1000035, 1000035, '2020-08-11 10:03:20');
INSERT INTO `shop_access_records` VALUES (2352, 1000035, 1000035, '2020-08-11 10:05:45');
INSERT INTO `shop_access_records` VALUES (2353, 1000035, 1000035, '2020-08-11 10:06:43');
INSERT INTO `shop_access_records` VALUES (2354, 1000035, 1000035, '2020-08-11 10:07:23');
INSERT INTO `shop_access_records` VALUES (2355, 1000035, 1000035, '2020-08-11 10:07:40');
INSERT INTO `shop_access_records` VALUES (2356, 1000106, 1000106, '2020-08-11 10:08:09');
INSERT INTO `shop_access_records` VALUES (2357, 1000105, 1000106, '2020-08-11 10:08:09');
INSERT INTO `shop_access_records` VALUES (2358, 1000035, 1000035, '2020-08-11 10:08:31');
INSERT INTO `shop_access_records` VALUES (2359, 1000106, 1000106, '2020-08-11 10:08:52');
INSERT INTO `shop_access_records` VALUES (2360, 1000035, 1000035, '2020-08-11 10:09:24');
INSERT INTO `shop_access_records` VALUES (2361, 1000106, 1000106, '2020-08-11 10:09:43');
INSERT INTO `shop_access_records` VALUES (2362, 1000035, 1000035, '2020-08-11 10:09:44');
INSERT INTO `shop_access_records` VALUES (2363, 1000106, 1000106, '2020-08-11 10:10:32');
INSERT INTO `shop_access_records` VALUES (2364, 1000107, 1000106, '2020-08-11 10:10:48');
INSERT INTO `shop_access_records` VALUES (2365, 1000035, 1000035, '2020-08-11 10:11:12');
INSERT INTO `shop_access_records` VALUES (2366, 1000035, 1000035, '2020-08-11 10:11:59');
INSERT INTO `shop_access_records` VALUES (2367, 1000084, 1000084, '2020-08-11 10:12:34');
INSERT INTO `shop_access_records` VALUES (2368, 1000106, 1000106, '2020-08-11 10:12:40');
INSERT INTO `shop_access_records` VALUES (2369, 1000035, 1000035, '2020-08-11 10:12:53');
INSERT INTO `shop_access_records` VALUES (2370, 1000035, 1000035, '2020-08-11 10:13:00');
INSERT INTO `shop_access_records` VALUES (2371, 1000035, 1000035, '2020-08-11 10:13:13');
INSERT INTO `shop_access_records` VALUES (2372, 1000035, 1000035, '2020-08-11 10:13:22');
INSERT INTO `shop_access_records` VALUES (2373, 1000103, 1000099, '2020-08-11 10:13:23');
INSERT INTO `shop_access_records` VALUES (2374, 1000108, 1000106, '2020-08-11 10:13:44');
INSERT INTO `shop_access_records` VALUES (2375, 1000035, 1000035, '2020-08-11 10:13:48');
INSERT INTO `shop_access_records` VALUES (2376, 1000107, 1000106, '2020-08-11 10:13:57');
INSERT INTO `shop_access_records` VALUES (2377, 1000106, 1000106, '2020-08-11 10:13:58');
INSERT INTO `shop_access_records` VALUES (2378, 1000035, 1000035, '2020-08-11 10:14:01');
INSERT INTO `shop_access_records` VALUES (2379, 1000035, 1000035, '2020-08-11 10:14:11');
INSERT INTO `shop_access_records` VALUES (2380, 1000035, 1000035, '2020-08-11 10:14:30');
INSERT INTO `shop_access_records` VALUES (2381, 1000035, 1000035, '2020-08-11 10:14:35');
INSERT INTO `shop_access_records` VALUES (2382, 1000035, 1000035, '2020-08-11 10:15:08');
INSERT INTO `shop_access_records` VALUES (2383, 1000035, 1000035, '2020-08-11 10:15:34');
INSERT INTO `shop_access_records` VALUES (2384, 1000035, 1000035, '2020-08-11 10:15:50');
INSERT INTO `shop_access_records` VALUES (2385, 1000107, 1000106, '2020-08-11 10:16:21');
INSERT INTO `shop_access_records` VALUES (2386, 1000035, 1000035, '2020-08-11 10:16:33');
INSERT INTO `shop_access_records` VALUES (2387, 1000035, 1000035, '2020-08-11 10:17:04');
INSERT INTO `shop_access_records` VALUES (2388, 1000035, 1000035, '2020-08-11 10:17:12');
INSERT INTO `shop_access_records` VALUES (2389, 1000035, 1000035, '2020-08-11 10:17:45');
INSERT INTO `shop_access_records` VALUES (2390, 1000109, 1000106, '2020-08-11 10:17:49');
INSERT INTO `shop_access_records` VALUES (2391, 1000035, 1000035, '2020-08-11 10:18:39');
INSERT INTO `shop_access_records` VALUES (2392, 1000035, 1000035, '2020-08-11 10:18:48');
INSERT INTO `shop_access_records` VALUES (2393, 1000108, 1000106, '2020-08-11 10:18:50');
INSERT INTO `shop_access_records` VALUES (2394, 1000035, 1000035, '2020-08-11 10:19:08');
INSERT INTO `shop_access_records` VALUES (2395, 1000035, 1000035, '2020-08-11 10:19:37');
INSERT INTO `shop_access_records` VALUES (2396, 1000035, 1000035, '2020-08-11 10:19:46');
INSERT INTO `shop_access_records` VALUES (2397, 1000035, 1000035, '2020-08-11 10:20:04');
INSERT INTO `shop_access_records` VALUES (2398, 1000035, 1000065, '2020-08-11 10:20:09');
INSERT INTO `shop_access_records` VALUES (2399, 1000035, 1000035, '2020-08-11 10:20:20');
INSERT INTO `shop_access_records` VALUES (2400, 1000035, 1000017, '2020-08-11 10:20:25');
INSERT INTO `shop_access_records` VALUES (2401, 1000035, 1000035, '2020-08-11 10:21:15');
INSERT INTO `shop_access_records` VALUES (2402, 1000035, 1000035, '2020-08-11 10:21:32');
INSERT INTO `shop_access_records` VALUES (2403, 1000035, 1000017, '2020-08-11 10:21:40');
INSERT INTO `shop_access_records` VALUES (2404, 1000035, 1000035, '2020-08-11 10:21:58');
INSERT INTO `shop_access_records` VALUES (2405, 1000035, 1000017, '2020-08-11 10:22:04');
INSERT INTO `shop_access_records` VALUES (2406, 1000035, 1000035, '2020-08-11 10:22:07');
INSERT INTO `shop_access_records` VALUES (2407, 1000035, 1000035, '2020-08-11 10:22:22');
INSERT INTO `shop_access_records` VALUES (2408, 1000035, 1000035, '2020-08-11 10:22:34');
INSERT INTO `shop_access_records` VALUES (2409, 1000035, 1000035, '2020-08-11 10:25:47');
INSERT INTO `shop_access_records` VALUES (2410, 1000035, 1000035, '2020-08-11 10:27:14');
INSERT INTO `shop_access_records` VALUES (2411, 1000035, 1000035, '2020-08-11 10:27:30');
INSERT INTO `shop_access_records` VALUES (2412, 1000035, 1000035, '2020-08-11 10:27:47');
INSERT INTO `shop_access_records` VALUES (2413, 1000105, 1000106, '2020-08-11 10:27:49');
INSERT INTO `shop_access_records` VALUES (2414, 1000035, 1000035, '2020-08-11 10:28:01');
INSERT INTO `shop_access_records` VALUES (2415, 1000035, 1000035, '2020-08-11 10:28:07');
INSERT INTO `shop_access_records` VALUES (2416, 1000035, 1000017, '2020-08-11 10:28:12');
INSERT INTO `shop_access_records` VALUES (2417, 1000035, 1000035, '2020-08-11 10:30:38');
INSERT INTO `shop_access_records` VALUES (2418, 1000035, 1000035, '2020-08-11 10:30:47');
INSERT INTO `shop_access_records` VALUES (2419, 1000035, 1000035, '2020-08-11 10:31:32');
INSERT INTO `shop_access_records` VALUES (2420, 1000035, 1000017, '2020-08-11 10:31:37');
INSERT INTO `shop_access_records` VALUES (2421, 1000035, 1000035, '2020-08-11 10:32:06');
INSERT INTO `shop_access_records` VALUES (2422, 1000035, 1000017, '2020-08-11 10:32:10');
INSERT INTO `shop_access_records` VALUES (2423, 1000035, 1000035, '2020-08-11 10:32:14');
INSERT INTO `shop_access_records` VALUES (2424, 1000107, 1000106, '2020-08-11 10:32:36');
INSERT INTO `shop_access_records` VALUES (2425, 1000035, 1000035, '2020-08-11 10:32:46');
INSERT INTO `shop_access_records` VALUES (2426, 1000110, 1000106, '2020-08-11 10:32:51');
INSERT INTO `shop_access_records` VALUES (2427, 1000035, 1000035, '2020-08-11 10:37:16');
INSERT INTO `shop_access_records` VALUES (2428, 1000106, 1000106, '2020-08-11 10:37:51');
INSERT INTO `shop_access_records` VALUES (2429, 1000035, 1000035, '2020-08-11 10:38:03');
INSERT INTO `shop_access_records` VALUES (2430, 1000106, 1000106, '2020-08-11 10:38:44');
INSERT INTO `shop_access_records` VALUES (2431, 1000106, 1000106, '2020-08-11 10:40:19');
INSERT INTO `shop_access_records` VALUES (2432, 1000035, 1000035, '2020-08-11 10:40:39');
INSERT INTO `shop_access_records` VALUES (2433, 1000108, 1000106, '2020-08-11 10:40:43');
INSERT INTO `shop_access_records` VALUES (2434, 1000106, 1000106, '2020-08-11 10:40:59');
INSERT INTO `shop_access_records` VALUES (2435, 1000035, 1000035, '2020-08-11 10:41:16');
INSERT INTO `shop_access_records` VALUES (2436, 1000035, 1000035, '2020-08-11 10:41:35');
INSERT INTO `shop_access_records` VALUES (2437, 1000035, 1000017, '2020-08-11 10:42:11');
INSERT INTO `shop_access_records` VALUES (2438, 1000035, 1000035, '2020-08-11 10:44:58');
INSERT INTO `shop_access_records` VALUES (2439, 1000035, 1000035, '2020-08-11 10:45:10');
INSERT INTO `shop_access_records` VALUES (2440, 1000084, 1000084, '2020-08-11 10:45:14');
INSERT INTO `shop_access_records` VALUES (2441, 1000107, 1000106, '2020-08-11 10:45:23');
INSERT INTO `shop_access_records` VALUES (2442, 1000035, 1000035, '2020-08-11 10:45:26');
INSERT INTO `shop_access_records` VALUES (2443, 1000084, 1000084, '2020-08-11 10:45:53');
INSERT INTO `shop_access_records` VALUES (2444, 1000001, 1000017, '2020-08-11 10:46:00');
INSERT INTO `shop_access_records` VALUES (2445, 1000107, 1000106, '2020-08-11 10:46:10');
INSERT INTO `shop_access_records` VALUES (2446, 1000107, 1000106, '2020-08-11 10:47:07');
INSERT INTO `shop_access_records` VALUES (2447, 1000035, 1000017, '2020-08-11 10:47:33');
INSERT INTO `shop_access_records` VALUES (2448, 1000035, 1000017, '2020-08-11 10:47:50');
INSERT INTO `shop_access_records` VALUES (2449, 1000013, 1000013, '2020-08-11 10:47:55');
INSERT INTO `shop_access_records` VALUES (2450, 1000035, 1000035, '2020-08-11 10:48:11');
INSERT INTO `shop_access_records` VALUES (2451, 1000035, 1000065, '2020-08-11 10:48:47');
INSERT INTO `shop_access_records` VALUES (2452, 1000035, 1000035, '2020-08-11 10:49:02');
INSERT INTO `shop_access_records` VALUES (2453, 1000107, 1000106, '2020-08-11 10:49:37');
INSERT INTO `shop_access_records` VALUES (2454, 1000035, 1000017, '2020-08-11 10:49:53');
INSERT INTO `shop_access_records` VALUES (2455, 1000017, 1000013, '2020-08-11 10:50:16');
INSERT INTO `shop_access_records` VALUES (2456, 1000035, 1000035, '2020-08-11 10:50:35');
INSERT INTO `shop_access_records` VALUES (2457, 1000017, 1000017, '2020-08-11 10:50:40');
INSERT INTO `shop_access_records` VALUES (2458, 1000017, 1000013, '2020-08-11 10:50:45');
INSERT INTO `shop_access_records` VALUES (2459, 1000035, 1000035, '2020-08-11 10:52:34');
INSERT INTO `shop_access_records` VALUES (2460, 1000035, 1000017, '2020-08-11 10:59:15');
INSERT INTO `shop_access_records` VALUES (2461, 1000035, 1000035, '2020-08-11 11:00:56');
INSERT INTO `shop_access_records` VALUES (2462, 1000017, 1000017, '2020-08-11 11:02:10');
INSERT INTO `shop_access_records` VALUES (2463, 1000069, 1000013, '2020-08-11 11:04:47');
INSERT INTO `shop_access_records` VALUES (2464, 1000069, 1000013, '2020-08-11 11:05:25');
INSERT INTO `shop_access_records` VALUES (2465, 1000069, 1000013, '2020-08-11 11:05:38');
INSERT INTO `shop_access_records` VALUES (2466, 1000035, 1000035, '2020-08-11 11:05:44');
INSERT INTO `shop_access_records` VALUES (2467, 1000069, 1000013, '2020-08-11 11:05:46');
INSERT INTO `shop_access_records` VALUES (2468, 1000069, 1000013, '2020-08-11 11:06:16');
INSERT INTO `shop_access_records` VALUES (2469, 1000069, 1000013, '2020-08-11 11:06:21');
INSERT INTO `shop_access_records` VALUES (2470, 1000085, 1000084, '2020-08-11 11:06:37');
INSERT INTO `shop_access_records` VALUES (2471, 1000069, 1000013, '2020-08-11 11:06:59');
INSERT INTO `shop_access_records` VALUES (2472, 1000069, 1000013, '2020-08-11 11:07:15');
INSERT INTO `shop_access_records` VALUES (2473, 1000035, 1000035, '2020-08-11 11:09:41');
INSERT INTO `shop_access_records` VALUES (2474, 1000035, 1000035, '2020-08-11 11:09:51');
INSERT INTO `shop_access_records` VALUES (2475, 1000035, 1000035, '2020-08-11 11:10:26');
INSERT INTO `shop_access_records` VALUES (2476, 1000035, 1000035, '2020-08-11 11:10:55');
INSERT INTO `shop_access_records` VALUES (2477, 1000035, 1000035, '2020-08-11 11:11:17');
INSERT INTO `shop_access_records` VALUES (2478, 1000035, 1000035, '2020-08-11 11:11:25');
INSERT INTO `shop_access_records` VALUES (2479, 1000035, 1000035, '2020-08-11 11:12:07');
INSERT INTO `shop_access_records` VALUES (2480, 1000069, 1000013, '2020-08-11 11:12:18');
INSERT INTO `shop_access_records` VALUES (2481, 1000035, 1000035, '2020-08-11 11:12:22');
INSERT INTO `shop_access_records` VALUES (2482, 1000069, 1000069, '2020-08-11 11:12:50');
INSERT INTO `shop_access_records` VALUES (2483, 1000035, 1000035, '2020-08-11 11:13:21');
INSERT INTO `shop_access_records` VALUES (2484, 1000035, 1000035, '2020-08-11 11:13:24');
INSERT INTO `shop_access_records` VALUES (2485, 1000035, 1000017, '2020-08-11 11:14:17');
INSERT INTO `shop_access_records` VALUES (2486, 1000035, 1000017, '2020-08-11 11:15:39');
INSERT INTO `shop_access_records` VALUES (2487, 1000035, 1000035, '2020-08-11 11:17:51');
INSERT INTO `shop_access_records` VALUES (2488, 1000111, 1000084, '2020-08-11 11:19:18');
INSERT INTO `shop_access_records` VALUES (2489, 1000035, 1000035, '2020-08-11 11:21:11');
INSERT INTO `shop_access_records` VALUES (2490, 1000035, 1000017, '2020-08-11 11:21:15');
INSERT INTO `shop_access_records` VALUES (2491, 1000035, 1000035, '2020-08-11 11:21:35');
INSERT INTO `shop_access_records` VALUES (2492, 1000035, 1000017, '2020-08-11 11:21:38');
INSERT INTO `shop_access_records` VALUES (2493, 1000035, 1000035, '2020-08-11 11:22:10');
INSERT INTO `shop_access_records` VALUES (2494, 1000035, 1000017, '2020-08-11 11:22:15');
INSERT INTO `shop_access_records` VALUES (2495, 1000035, 1000035, '2020-08-11 11:22:33');
INSERT INTO `shop_access_records` VALUES (2496, 1000035, 1000017, '2020-08-11 11:22:37');
INSERT INTO `shop_access_records` VALUES (2497, 1000035, 1000035, '2020-08-11 11:23:08');
INSERT INTO `shop_access_records` VALUES (2498, 1000035, 1000017, '2020-08-11 11:23:12');
INSERT INTO `shop_access_records` VALUES (2499, 1000035, 1000035, '2020-08-11 11:26:36');
INSERT INTO `shop_access_records` VALUES (2500, 1000035, 1000035, '2020-08-11 11:26:45');
INSERT INTO `shop_access_records` VALUES (2501, 1000035, 1000017, '2020-08-11 11:26:50');
INSERT INTO `shop_access_records` VALUES (2502, 1000035, 1000035, '2020-08-11 11:28:54');
INSERT INTO `shop_access_records` VALUES (2503, 1000035, 1000017, '2020-08-11 11:29:01');
INSERT INTO `shop_access_records` VALUES (2504, 1000035, 1000035, '2020-08-11 11:30:20');
INSERT INTO `shop_access_records` VALUES (2505, 1000035, 1000017, '2020-08-11 11:30:35');
INSERT INTO `shop_access_records` VALUES (2506, 1000035, 1000035, '2020-08-11 11:30:42');
INSERT INTO `shop_access_records` VALUES (2507, 1000035, 1000035, '2020-08-11 11:31:49');
INSERT INTO `shop_access_records` VALUES (2508, 1000035, 1000017, '2020-08-11 11:31:55');
INSERT INTO `shop_access_records` VALUES (2509, 1000035, 1000035, '2020-08-11 11:32:38');
INSERT INTO `shop_access_records` VALUES (2510, 1000035, 1000035, '2020-08-11 11:32:57');
INSERT INTO `shop_access_records` VALUES (2511, 1000035, 1000017, '2020-08-11 11:33:05');
INSERT INTO `shop_access_records` VALUES (2512, 1000035, 1000035, '2020-08-11 11:33:14');
INSERT INTO `shop_access_records` VALUES (2513, 1000035, 1000035, '2020-08-11 11:33:41');
INSERT INTO `shop_access_records` VALUES (2514, 1000035, 1000099, '2020-08-11 11:34:00');
INSERT INTO `shop_access_records` VALUES (2515, 1000035, 1000035, '2020-08-11 11:34:29');
INSERT INTO `shop_access_records` VALUES (2516, 1000035, 1000099, '2020-08-11 11:34:34');
INSERT INTO `shop_access_records` VALUES (2517, 1000035, 1000035, '2020-08-11 11:36:28');
INSERT INTO `shop_access_records` VALUES (2518, 1000035, 1000099, '2020-08-11 11:36:35');
INSERT INTO `shop_access_records` VALUES (2519, 1000035, 1000035, '2020-08-11 11:37:19');
INSERT INTO `shop_access_records` VALUES (2520, 1000035, 1000035, '2020-08-11 11:38:37');
INSERT INTO `shop_access_records` VALUES (2521, 1000035, 1000017, '2020-08-11 11:38:43');
INSERT INTO `shop_access_records` VALUES (2522, 1000035, 1000035, '2020-08-11 11:39:03');
INSERT INTO `shop_access_records` VALUES (2523, 1000035, 1000017, '2020-08-11 11:39:10');
INSERT INTO `shop_access_records` VALUES (2524, 1000035, 1000035, '2020-08-11 11:39:15');
INSERT INTO `shop_access_records` VALUES (2525, 1000035, 1000017, '2020-08-11 11:39:26');
INSERT INTO `shop_access_records` VALUES (2526, 1000035, 1000035, '2020-08-11 11:40:00');
INSERT INTO `shop_access_records` VALUES (2527, 1000035, 1000017, '2020-08-11 11:40:05');
INSERT INTO `shop_access_records` VALUES (2528, 1000035, 1000035, '2020-08-11 11:40:33');
INSERT INTO `shop_access_records` VALUES (2529, 1000035, 1000017, '2020-08-11 11:40:40');
INSERT INTO `shop_access_records` VALUES (2530, 1000035, 1000035, '2020-08-11 11:41:03');
INSERT INTO `shop_access_records` VALUES (2531, 1000035, 1000017, '2020-08-11 11:43:30');
INSERT INTO `shop_access_records` VALUES (2532, 1000017, 1000017, '2020-08-11 11:44:27');
INSERT INTO `shop_access_records` VALUES (2533, 1000060, 1000060, '2020-08-11 11:45:42');
INSERT INTO `shop_access_records` VALUES (2534, 1000035, 1000035, '2020-08-11 11:46:08');
INSERT INTO `shop_access_records` VALUES (2535, 1000035, 1000017, '2020-08-11 11:46:16');
INSERT INTO `shop_access_records` VALUES (2536, 1000085, 1000084, '2020-08-11 11:46:40');
INSERT INTO `shop_access_records` VALUES (2537, 1000060, 1000060, '2020-08-11 11:46:58');
INSERT INTO `shop_access_records` VALUES (2538, 1000105, 1000106, '2020-08-11 11:48:26');
INSERT INTO `shop_access_records` VALUES (2539, 1000035, 1000035, '2020-08-11 11:48:29');
INSERT INTO `shop_access_records` VALUES (2540, 1000105, 1000106, '2020-08-11 11:48:54');
INSERT INTO `shop_access_records` VALUES (2541, 1000106, 1000106, '2020-08-11 11:49:24');
INSERT INTO `shop_access_records` VALUES (2542, 1000105, 1000106, '2020-08-11 11:49:51');
INSERT INTO `shop_access_records` VALUES (2543, 1000105, 1000017, '2020-08-11 11:50:02');
INSERT INTO `shop_access_records` VALUES (2544, 1000035, 1000035, '2020-08-11 11:51:58');
INSERT INTO `shop_access_records` VALUES (2545, 1000112, 1000060, '2020-08-11 11:52:12');
INSERT INTO `shop_access_records` VALUES (2546, 1000035, 1000035, '2020-08-11 11:52:22');
INSERT INTO `shop_access_records` VALUES (2547, 1000112, 1000060, '2020-08-11 11:52:25');
INSERT INTO `shop_access_records` VALUES (2548, 1000035, 1000035, '2020-08-11 11:52:38');
INSERT INTO `shop_access_records` VALUES (2549, 1000035, 1000035, '2020-08-11 11:53:10');
INSERT INTO `shop_access_records` VALUES (2550, 1000112, 1000060, '2020-08-11 11:53:27');
INSERT INTO `shop_access_records` VALUES (2551, 1000035, 1000035, '2020-08-11 11:53:57');
INSERT INTO `shop_access_records` VALUES (2552, 1000035, 1000035, '2020-08-11 11:54:59');
INSERT INTO `shop_access_records` VALUES (2553, 1000035, 1000035, '2020-08-11 11:55:18');
INSERT INTO `shop_access_records` VALUES (2554, 1000017, 1000017, '2020-08-11 11:55:29');
INSERT INTO `shop_access_records` VALUES (2555, 1000035, 1000035, '2020-08-11 11:56:08');
INSERT INTO `shop_access_records` VALUES (2556, 1000035, 1000035, '2020-08-11 11:56:22');
INSERT INTO `shop_access_records` VALUES (2557, 1000035, 1000035, '2020-08-11 11:57:25');
INSERT INTO `shop_access_records` VALUES (2558, 1000113, 1000106, '2020-08-11 12:04:09');
INSERT INTO `shop_access_records` VALUES (2559, 1000113, 1000106, '2020-08-11 12:07:07');
INSERT INTO `shop_access_records` VALUES (2560, 1000113, 1000106, '2020-08-11 12:09:18');
INSERT INTO `shop_access_records` VALUES (2561, 1000113, 1000106, '2020-08-11 12:10:09');
INSERT INTO `shop_access_records` VALUES (2562, 1000113, 1000106, '2020-08-11 12:11:05');
INSERT INTO `shop_access_records` VALUES (2563, 1000035, 1000035, '2020-08-11 12:18:17');
INSERT INTO `shop_access_records` VALUES (2564, 1000035, 1000035, '2020-08-11 12:19:41');
INSERT INTO `shop_access_records` VALUES (2565, 1000035, 1000017, '2020-08-11 12:21:52');
INSERT INTO `shop_access_records` VALUES (2566, 1000017, 1000017, '2020-08-11 12:23:21');
INSERT INTO `shop_access_records` VALUES (2567, 1000035, 1000035, '2020-08-11 12:24:24');
INSERT INTO `shop_access_records` VALUES (2568, 1000035, 1000035, '2020-08-11 12:24:46');
INSERT INTO `shop_access_records` VALUES (2569, 1000035, 1000035, '2020-08-11 12:25:26');
INSERT INTO `shop_access_records` VALUES (2570, 1000035, 1000017, '2020-08-11 12:25:36');
INSERT INTO `shop_access_records` VALUES (2571, 1000035, 1000035, '2020-08-11 12:25:55');
INSERT INTO `shop_access_records` VALUES (2572, 1000017, 1000017, '2020-08-11 12:26:08');
INSERT INTO `shop_access_records` VALUES (2573, 1000035, 1000065, '2020-08-11 12:26:20');
INSERT INTO `shop_access_records` VALUES (2574, 1000035, 1000099, '2020-08-11 12:26:33');
INSERT INTO `shop_access_records` VALUES (2575, 1000105, 1000106, '2020-08-11 12:26:40');
INSERT INTO `shop_access_records` VALUES (2576, 1000035, 1000035, '2020-08-11 12:27:08');
INSERT INTO `shop_access_records` VALUES (2577, 1000035, 1000017, '2020-08-11 12:28:21');
INSERT INTO `shop_access_records` VALUES (2578, 1000001, 1000017, '2020-08-11 12:29:05');
INSERT INTO `shop_access_records` VALUES (2579, 1000035, 1000035, '2020-08-11 12:30:05');
INSERT INTO `shop_access_records` VALUES (2580, 1000008, 1000084, '2020-08-11 12:30:06');
INSERT INTO `shop_access_records` VALUES (2581, 1000008, 1000084, '2020-08-11 12:30:15');
INSERT INTO `shop_access_records` VALUES (2582, 1000013, 1000013, '2020-08-11 12:31:05');
INSERT INTO `shop_access_records` VALUES (2583, 1000008, 1000035, '2020-08-11 12:31:07');
INSERT INTO `shop_access_records` VALUES (2584, 1000008, 1000035, '2020-08-11 12:31:59');
INSERT INTO `shop_access_records` VALUES (2585, 1000008, 1000035, '2020-08-11 12:32:06');
INSERT INTO `shop_access_records` VALUES (2586, 1000106, 1000106, '2020-08-11 12:41:57');
INSERT INTO `shop_access_records` VALUES (2587, 1000113, 1000106, '2020-08-11 13:16:06');
INSERT INTO `shop_access_records` VALUES (2588, 1000115, 1000099, '2020-08-11 14:08:04');
INSERT INTO `shop_access_records` VALUES (2589, 1000008, 1000013, '2020-08-11 14:09:40');
INSERT INTO `shop_access_records` VALUES (2590, 1000008, 1000013, '2020-08-11 14:09:59');
INSERT INTO `shop_access_records` VALUES (2591, 1000013, 1000035, '2020-08-11 14:14:50');
INSERT INTO `shop_access_records` VALUES (2592, 1000013, 1000013, '2020-08-11 14:15:21');
INSERT INTO `shop_access_records` VALUES (2593, 1000035, 1000035, '2020-08-11 14:15:53');
INSERT INTO `shop_access_records` VALUES (2594, 1000035, 1000017, '2020-08-11 14:16:03');
INSERT INTO `shop_access_records` VALUES (2595, 1000035, 1000035, '2020-08-11 14:23:28');
INSERT INTO `shop_access_records` VALUES (2596, 1000035, 1000017, '2020-08-11 14:23:38');
INSERT INTO `shop_access_records` VALUES (2597, 1000035, 1000035, '2020-08-11 14:28:47');
INSERT INTO `shop_access_records` VALUES (2598, 1000035, 1000017, '2020-08-11 14:29:04');
INSERT INTO `shop_access_records` VALUES (2599, 1000099, 1000099, '2020-08-11 14:34:23');
INSERT INTO `shop_access_records` VALUES (2600, 1000060, 1000060, '2020-08-11 14:57:17');
INSERT INTO `shop_access_records` VALUES (2601, 1000044, 1000017, '2020-08-11 14:58:33');
INSERT INTO `shop_access_records` VALUES (2602, 1000060, 1000060, '2020-08-11 14:59:00');
INSERT INTO `shop_access_records` VALUES (2603, 1000060, 1000060, '2020-08-11 14:59:08');
INSERT INTO `shop_access_records` VALUES (2604, 1000017, 1000017, '2020-08-11 15:13:27');
INSERT INTO `shop_access_records` VALUES (2605, 1000013, 1000017, '2020-08-11 15:14:08');
INSERT INTO `shop_access_records` VALUES (2606, 1000013, 1000013, '2020-08-11 15:15:06');
INSERT INTO `shop_access_records` VALUES (2607, 1000017, 1000017, '2020-08-11 15:34:22');
INSERT INTO `shop_access_records` VALUES (2608, 1000019, 1000018, '2020-08-11 16:22:08');
INSERT INTO `shop_access_records` VALUES (2609, 1000017, 1000017, '2020-08-11 16:23:19');
INSERT INTO `shop_access_records` VALUES (2610, 1000017, 1000017, '2020-08-11 16:34:28');
INSERT INTO `shop_access_records` VALUES (2611, 1000018, 1000018, '2020-08-11 16:34:29');
INSERT INTO `shop_access_records` VALUES (2612, 1000017, 1000017, '2020-08-11 16:49:21');
INSERT INTO `shop_access_records` VALUES (2613, 1000017, 1000017, '2020-08-11 17:27:16');
INSERT INTO `shop_access_records` VALUES (2614, 1000013, 1000013, '2020-08-11 17:28:35');
INSERT INTO `shop_access_records` VALUES (2615, 1000013, 1000017, '2020-08-11 17:28:40');
INSERT INTO `shop_access_records` VALUES (2616, 1000017, 1000017, '2020-08-11 17:31:46');
INSERT INTO `shop_access_records` VALUES (2617, 1000017, 1000017, '2020-08-11 17:55:44');
INSERT INTO `shop_access_records` VALUES (2618, 1000048, 1000017, '2020-08-11 17:56:15');
INSERT INTO `shop_access_records` VALUES (2619, 1000071, 1000017, '2020-08-11 17:56:22');
INSERT INTO `shop_access_records` VALUES (2620, 1000027, 1000017, '2020-08-11 17:56:42');
INSERT INTO `shop_access_records` VALUES (2621, 1000035, 1000035, '2020-08-11 17:56:48');
INSERT INTO `shop_access_records` VALUES (2622, 1000035, 1000035, '2020-08-11 17:57:14');
INSERT INTO `shop_access_records` VALUES (2623, 1000017, 1000017, '2020-08-11 17:58:18');
INSERT INTO `shop_access_records` VALUES (2624, 1000017, 1000017, '2020-08-11 17:58:33');
INSERT INTO `shop_access_records` VALUES (2625, 1000054, 1000017, '2020-08-11 17:58:51');
INSERT INTO `shop_access_records` VALUES (2626, 1000116, 1000017, '2020-08-11 18:00:25');
INSERT INTO `shop_access_records` VALUES (2627, 1000035, 1000035, '2020-08-11 18:02:21');
INSERT INTO `shop_access_records` VALUES (2628, 1000075, 1000017, '2020-08-11 18:02:37');
INSERT INTO `shop_access_records` VALUES (2629, 1000035, 1000035, '2020-08-11 18:03:05');
INSERT INTO `shop_access_records` VALUES (2630, 1000013, 1000013, '2020-08-11 18:03:33');
INSERT INTO `shop_access_records` VALUES (2631, 1000013, 1000013, '2020-08-11 18:05:17');
INSERT INTO `shop_access_records` VALUES (2632, 1000017, 1000017, '2020-08-11 18:06:18');
INSERT INTO `shop_access_records` VALUES (2633, 1000035, 1000035, '2020-08-11 18:09:00');
INSERT INTO `shop_access_records` VALUES (2634, 1000013, 1000013, '2020-08-11 18:09:08');
INSERT INTO `shop_access_records` VALUES (2635, 1000035, 1000035, '2020-08-11 18:09:16');
INSERT INTO `shop_access_records` VALUES (2636, 1000006, 1000013, '2020-08-11 18:09:25');
INSERT INTO `shop_access_records` VALUES (2637, 1000035, 1000017, '2020-08-11 18:09:41');
INSERT INTO `shop_access_records` VALUES (2638, 1000013, 1000013, '2020-08-11 18:09:51');
INSERT INTO `shop_access_records` VALUES (2639, 1000013, 1000013, '2020-08-11 18:10:09');
INSERT INTO `shop_access_records` VALUES (2640, 1000013, 1000013, '2020-08-11 18:10:31');
INSERT INTO `shop_access_records` VALUES (2641, 1000035, 1000035, '2020-08-11 18:11:34');
INSERT INTO `shop_access_records` VALUES (2642, 1000084, 1000084, '2020-08-11 18:11:45');
INSERT INTO `shop_access_records` VALUES (2643, 1000035, 1000017, '2020-08-11 18:11:55');
INSERT INTO `shop_access_records` VALUES (2644, 1000084, 1000084, '2020-08-11 18:11:57');
INSERT INTO `shop_access_records` VALUES (2645, 1000001, 1000013, '2020-08-11 18:12:15');
INSERT INTO `shop_access_records` VALUES (2646, 1000006, 1000084, '2020-08-11 18:12:18');
INSERT INTO `shop_access_records` VALUES (2647, 1000035, 1000065, '2020-08-11 18:12:32');
INSERT INTO `shop_access_records` VALUES (2648, 1000035, 1000035, '2020-08-11 18:12:40');
INSERT INTO `shop_access_records` VALUES (2649, 1000035, 1000099, '2020-08-11 18:12:49');
INSERT INTO `shop_access_records` VALUES (2650, 1000035, 1000017, '2020-08-11 18:13:01');
INSERT INTO `shop_access_records` VALUES (2651, 1000035, 1000035, '2020-08-11 18:13:39');
INSERT INTO `shop_access_records` VALUES (2652, 1000035, 1000017, '2020-08-11 18:13:48');
INSERT INTO `shop_access_records` VALUES (2653, 1000035, 1000035, '2020-08-11 18:15:37');
INSERT INTO `shop_access_records` VALUES (2654, 1000035, 1000017, '2020-08-11 18:15:43');
INSERT INTO `shop_access_records` VALUES (2655, 1000035, 1000035, '2020-08-11 18:16:07');
INSERT INTO `shop_access_records` VALUES (2656, 1000035, 1000017, '2020-08-11 18:16:14');
INSERT INTO `shop_access_records` VALUES (2657, 1000035, 1000035, '2020-08-11 18:16:35');
INSERT INTO `shop_access_records` VALUES (2658, 1000035, 1000017, '2020-08-11 18:16:40');
INSERT INTO `shop_access_records` VALUES (2659, 1000035, 1000035, '2020-08-11 18:17:10');
INSERT INTO `shop_access_records` VALUES (2660, 1000035, 1000035, '2020-08-11 18:17:22');
INSERT INTO `shop_access_records` VALUES (2661, 1000006, 1000084, '2020-08-11 18:17:50');
INSERT INTO `shop_access_records` VALUES (2662, 1000008, 1000084, '2020-08-11 18:18:55');
INSERT INTO `shop_access_records` VALUES (2663, 1000008, 1000013, '2020-08-11 18:18:59');
INSERT INTO `shop_access_records` VALUES (2664, 1000017, 1000017, '2020-08-11 18:19:14');
INSERT INTO `shop_access_records` VALUES (2665, 1000017, 1000017, '2020-08-11 18:19:16');
INSERT INTO `shop_access_records` VALUES (2666, 1000017, 1000017, '2020-08-11 18:19:17');
INSERT INTO `shop_access_records` VALUES (2667, 1000017, 1000017, '2020-08-11 18:19:18');
INSERT INTO `shop_access_records` VALUES (2668, 1000017, 1000017, '2020-08-11 18:19:18');
INSERT INTO `shop_access_records` VALUES (2669, 1000017, 1000017, '2020-08-11 18:19:19');
INSERT INTO `shop_access_records` VALUES (2670, 1000017, 1000017, '2020-08-11 18:19:20');
INSERT INTO `shop_access_records` VALUES (2671, 1000008, 1000035, '2020-08-11 18:19:27');
INSERT INTO `shop_access_records` VALUES (2672, 1000008, 1000013, '2020-08-11 18:19:31');
INSERT INTO `shop_access_records` VALUES (2673, 1000035, 1000035, '2020-08-11 18:19:35');
INSERT INTO `shop_access_records` VALUES (2674, 1000017, 1000017, '2020-08-11 18:19:42');
INSERT INTO `shop_access_records` VALUES (2675, 1000035, 1000065, '2020-08-11 18:19:51');
INSERT INTO `shop_access_records` VALUES (2676, 1000013, 1000013, '2020-08-11 18:20:04');
INSERT INTO `shop_access_records` VALUES (2677, 1000035, 1000017, '2020-08-11 18:20:04');
INSERT INTO `shop_access_records` VALUES (2678, 1000008, 1000017, '2020-08-11 18:20:20');
INSERT INTO `shop_access_records` VALUES (2679, 1000035, 1000017, '2020-08-11 18:20:28');
INSERT INTO `shop_access_records` VALUES (2680, 1000035, 1000035, '2020-08-11 18:20:48');
INSERT INTO `shop_access_records` VALUES (2681, 1000008, 1000017, '2020-08-11 18:20:50');
INSERT INTO `shop_access_records` VALUES (2682, 1000008, 1000017, '2020-08-11 18:21:32');
INSERT INTO `shop_access_records` VALUES (2683, 1000035, 1000035, '2020-08-11 18:21:52');
INSERT INTO `shop_access_records` VALUES (2684, 1000008, 1000008, '2020-08-11 18:22:04');
INSERT INTO `shop_access_records` VALUES (2685, 1000013, 1000013, '2020-08-11 18:22:08');
INSERT INTO `shop_access_records` VALUES (2686, 1000013, 1000013, '2020-08-11 18:22:42');
INSERT INTO `shop_access_records` VALUES (2687, 1000017, 1000017, '2020-08-11 18:23:01');
INSERT INTO `shop_access_records` VALUES (2688, 1000035, 1000035, '2020-08-11 18:23:07');
INSERT INTO `shop_access_records` VALUES (2689, 1000085, 1000084, '2020-08-11 18:23:17');
INSERT INTO `shop_access_records` VALUES (2690, 1000084, 1000084, '2020-08-11 18:23:30');
INSERT INTO `shop_access_records` VALUES (2691, 1000006, 1000013, '2020-08-11 18:23:51');
INSERT INTO `shop_access_records` VALUES (2692, 1000106, 1000106, '2020-08-11 18:24:07');
INSERT INTO `shop_access_records` VALUES (2693, 1000054, 1000017, '2020-08-11 18:24:07');
INSERT INTO `shop_access_records` VALUES (2694, 1000006, 1000084, '2020-08-11 18:24:57');
INSERT INTO `shop_access_records` VALUES (2695, 1000008, 1000008, '2020-08-11 18:25:07');
INSERT INTO `shop_access_records` VALUES (2696, 1000017, 1000106, '2020-08-11 18:25:09');
INSERT INTO `shop_access_records` VALUES (2697, 1000017, 1000106, '2020-08-11 18:25:36');
INSERT INTO `shop_access_records` VALUES (2698, 1000017, 1000017, '2020-08-11 18:25:40');
INSERT INTO `shop_access_records` VALUES (2699, 1000106, 1000017, '2020-08-11 18:26:02');
INSERT INTO `shop_access_records` VALUES (2700, 1000106, 1000017, '2020-08-11 18:26:17');
INSERT INTO `shop_access_records` VALUES (2701, 1000106, 1000017, '2020-08-11 18:26:27');
INSERT INTO `shop_access_records` VALUES (2702, 1000013, 1000013, '2020-08-11 18:27:36');
INSERT INTO `shop_access_records` VALUES (2703, 1000017, 1000017, '2020-08-11 18:28:30');
INSERT INTO `shop_access_records` VALUES (2704, 1000013, 1000013, '2020-08-11 18:28:58');
INSERT INTO `shop_access_records` VALUES (2705, 1000006, 1000084, '2020-08-11 18:34:03');
INSERT INTO `shop_access_records` VALUES (2706, 1000035, 1000035, '2020-08-11 18:35:57');
INSERT INTO `shop_access_records` VALUES (2707, 1000035, 1000035, '2020-08-11 18:36:04');
INSERT INTO `shop_access_records` VALUES (2708, 1000006, 1000084, '2020-08-11 18:36:15');
INSERT INTO `shop_access_records` VALUES (2709, 1000006, 1000084, '2020-08-11 18:37:05');
INSERT INTO `shop_access_records` VALUES (2710, 1000008, 1000008, '2020-08-11 18:37:14');
INSERT INTO `shop_access_records` VALUES (2711, 1000006, 1000084, '2020-08-11 18:37:15');
INSERT INTO `shop_access_records` VALUES (2712, 1000035, 1000035, '2020-08-11 18:37:16');
INSERT INTO `shop_access_records` VALUES (2713, 1000035, 1000017, '2020-08-11 18:38:00');
INSERT INTO `shop_access_records` VALUES (2714, 1000008, 1000017, '2020-08-11 18:38:33');
INSERT INTO `shop_access_records` VALUES (2715, 1000017, 1000017, '2020-08-11 18:39:20');
INSERT INTO `shop_access_records` VALUES (2716, 1000006, 1000084, '2020-08-11 18:41:53');
INSERT INTO `shop_access_records` VALUES (2717, 1000006, 1000013, '2020-08-11 18:42:26');
INSERT INTO `shop_access_records` VALUES (2718, 1000013, 1000013, '2020-08-11 18:42:39');
INSERT INTO `shop_access_records` VALUES (2719, 1000017, 1000017, '2020-08-11 18:42:48');
INSERT INTO `shop_access_records` VALUES (2720, 1000008, 1000008, '2020-08-11 18:43:57');
INSERT INTO `shop_access_records` VALUES (2721, 1000035, 1000035, '2020-08-11 18:44:59');
INSERT INTO `shop_access_records` VALUES (2722, 1000035, 1000035, '2020-08-11 18:47:45');
INSERT INTO `shop_access_records` VALUES (2723, 1000014, 1000035, '2020-08-11 18:48:30');
INSERT INTO `shop_access_records` VALUES (2724, 1000014, 1000035, '2020-08-11 18:48:36');
INSERT INTO `shop_access_records` VALUES (2725, 1000014, 1000035, '2020-08-11 18:49:01');
INSERT INTO `shop_access_records` VALUES (2726, 1000014, 1000035, '2020-08-11 18:49:11');
INSERT INTO `shop_access_records` VALUES (2727, 1000035, 1000035, '2020-08-11 18:50:25');
INSERT INTO `shop_access_records` VALUES (2728, 1000085, 1000084, '2020-08-11 18:51:11');
INSERT INTO `shop_access_records` VALUES (2729, 1000084, 1000084, '2020-08-11 18:51:31');
INSERT INTO `shop_access_records` VALUES (2730, 1000035, 1000035, '2020-08-11 18:52:38');
INSERT INTO `shop_access_records` VALUES (2731, 1000035, 1000017, '2020-08-11 18:52:55');
INSERT INTO `shop_access_records` VALUES (2732, 1000001, 1000017, '2020-08-11 18:53:20');
INSERT INTO `shop_access_records` VALUES (2733, 1000001, 1000017, '2020-08-11 18:53:43');
INSERT INTO `shop_access_records` VALUES (2734, 1000001, 1000099, '2020-08-11 18:53:46');
INSERT INTO `shop_access_records` VALUES (2735, 1000008, 1000017, '2020-08-11 18:53:51');
INSERT INTO `shop_access_records` VALUES (2736, 1000008, 1000013, '2020-08-11 18:53:55');
INSERT INTO `shop_access_records` VALUES (2737, 1000084, 1000084, '2020-08-11 18:53:58');
INSERT INTO `shop_access_records` VALUES (2738, 1000008, 1000035, '2020-08-11 18:53:59');
INSERT INTO `shop_access_records` VALUES (2739, 1000035, 1000099, '2020-08-11 18:55:33');
INSERT INTO `shop_access_records` VALUES (2740, 1000035, 1000065, '2020-08-11 18:56:32');
INSERT INTO `shop_access_records` VALUES (2741, 1000035, 1000099, '2020-08-11 18:56:36');
INSERT INTO `shop_access_records` VALUES (2742, 1000008, 1000013, '2020-08-11 18:58:03');
INSERT INTO `shop_access_records` VALUES (2743, 1000008, 1000008, '2020-08-11 18:58:12');
INSERT INTO `shop_access_records` VALUES (2744, 1000001, 1000013, '2020-08-11 18:58:14');
INSERT INTO `shop_access_records` VALUES (2745, 1000008, 1000008, '2020-08-11 18:58:27');
INSERT INTO `shop_access_records` VALUES (2746, 1000008, 1000008, '2020-08-11 18:58:33');
INSERT INTO `shop_access_records` VALUES (2747, 1000017, 1000017, '2020-08-11 18:59:14');
INSERT INTO `shop_access_records` VALUES (2748, 1000008, 1000008, '2020-08-11 18:59:17');
INSERT INTO `shop_access_records` VALUES (2749, 1000017, 1000017, '2020-08-11 18:59:26');
INSERT INTO `shop_access_records` VALUES (2750, 1000008, 1000008, '2020-08-11 18:59:50');
INSERT INTO `shop_access_records` VALUES (2751, 1000001, 1000017, '2020-08-11 18:59:51');
INSERT INTO `shop_access_records` VALUES (2752, 1000017, 1000017, '2020-08-11 18:59:55');
INSERT INTO `shop_access_records` VALUES (2753, 1000008, 1000008, '2020-08-11 19:00:21');
INSERT INTO `shop_access_records` VALUES (2754, 1000008, 1000008, '2020-08-11 19:00:46');
INSERT INTO `shop_access_records` VALUES (2755, 1000001, 1000099, '2020-08-11 19:00:55');
INSERT INTO `shop_access_records` VALUES (2756, 1000035, 1000035, '2020-08-11 19:01:59');
INSERT INTO `shop_access_records` VALUES (2757, 1000017, 1000017, '2020-08-11 19:02:10');
INSERT INTO `shop_access_records` VALUES (2758, 1000017, 1000017, '2020-08-11 19:02:20');
INSERT INTO `shop_access_records` VALUES (2759, 1000017, 1000017, '2020-08-11 19:02:45');
INSERT INTO `shop_access_records` VALUES (2760, 1000001, 1000017, '2020-08-11 19:03:15');
INSERT INTO `shop_access_records` VALUES (2761, 1000001, 1000099, '2020-08-11 19:03:20');
INSERT INTO `shop_access_records` VALUES (2762, 1000001, 1000017, '2020-08-11 19:03:36');
INSERT INTO `shop_access_records` VALUES (2763, 1000017, 1000017, '2020-08-11 19:03:37');
INSERT INTO `shop_access_records` VALUES (2764, 1000017, 1000017, '2020-08-11 19:04:03');
INSERT INTO `shop_access_records` VALUES (2765, 1000017, 1000017, '2020-08-11 19:04:14');
INSERT INTO `shop_access_records` VALUES (2766, 1000017, 1000017, '2020-08-11 19:05:41');
INSERT INTO `shop_access_records` VALUES (2767, 1000085, 1000084, '2020-08-11 19:06:06');
INSERT INTO `shop_access_records` VALUES (2768, 1000008, 1000008, '2020-08-11 19:07:42');
INSERT INTO `shop_access_records` VALUES (2769, 1000017, 1000017, '2020-08-11 19:07:59');
INSERT INTO `shop_access_records` VALUES (2770, 1000025, 1000084, '2020-08-11 19:08:41');
INSERT INTO `shop_access_records` VALUES (2771, 1000035, 1000035, '2020-08-11 19:08:50');
INSERT INTO `shop_access_records` VALUES (2772, 1000008, 1000008, '2020-08-11 19:09:09');
INSERT INTO `shop_access_records` VALUES (2773, 1000014, 1000017, '2020-08-11 19:10:01');
INSERT INTO `shop_access_records` VALUES (2774, 1000035, 1000017, '2020-08-11 19:10:05');
INSERT INTO `shop_access_records` VALUES (2775, 1000017, 1000017, '2020-08-11 19:10:10');
INSERT INTO `shop_access_records` VALUES (2776, 1000014, 1000035, '2020-08-11 19:10:19');
INSERT INTO `shop_access_records` VALUES (2777, 1000014, 1000035, '2020-08-11 19:10:26');
INSERT INTO `shop_access_records` VALUES (2778, 1000017, 1000017, '2020-08-11 19:10:40');
INSERT INTO `shop_access_records` VALUES (2779, 1000035, 1000035, '2020-08-11 19:10:48');
INSERT INTO `shop_access_records` VALUES (2780, 1000117, 1000017, '2020-08-11 19:10:59');
INSERT INTO `shop_access_records` VALUES (2781, 1000008, 1000035, '2020-08-11 19:11:04');
INSERT INTO `shop_access_records` VALUES (2782, 1000017, 1000035, '2020-08-11 19:11:18');
INSERT INTO `shop_access_records` VALUES (2783, 1000001, 1000035, '2020-08-11 19:11:19');
INSERT INTO `shop_access_records` VALUES (2784, 1000035, 1000035, '2020-08-11 19:11:23');
INSERT INTO `shop_access_records` VALUES (2785, 1000035, 1000035, '2020-08-11 19:11:45');
INSERT INTO `shop_access_records` VALUES (2786, 1000094, 1000017, '2020-08-11 19:11:48');
INSERT INTO `shop_access_records` VALUES (2787, 1000008, 1000035, '2020-08-11 19:12:04');
INSERT INTO `shop_access_records` VALUES (2788, 1000035, 1000035, '2020-08-11 19:12:14');
INSERT INTO `shop_access_records` VALUES (2789, 1000008, 1000035, '2020-08-11 19:12:30');
INSERT INTO `shop_access_records` VALUES (2790, 1000008, 1000008, '2020-08-11 19:12:31');
INSERT INTO `shop_access_records` VALUES (2791, 1000008, 1000035, '2020-08-11 19:12:43');
INSERT INTO `shop_access_records` VALUES (2792, 1000008, 1000008, '2020-08-11 19:12:45');
INSERT INTO `shop_access_records` VALUES (2793, 1000035, 1000035, '2020-08-11 19:12:56');
INSERT INTO `shop_access_records` VALUES (2794, 1000008, 1000008, '2020-08-11 19:12:58');
INSERT INTO `shop_access_records` VALUES (2795, 1000035, 1000017, '2020-08-11 19:13:24');
INSERT INTO `shop_access_records` VALUES (2796, 1000017, 1000017, '2020-08-11 19:13:37');
INSERT INTO `shop_access_records` VALUES (2797, 1000017, 1000017, '2020-08-11 19:13:43');
INSERT INTO `shop_access_records` VALUES (2798, 1000017, 1000017, '2020-08-11 19:13:56');
INSERT INTO `shop_access_records` VALUES (2799, 1000017, 1000017, '2020-08-11 19:14:13');
INSERT INTO `shop_access_records` VALUES (2800, 1000017, 1000017, '2020-08-11 19:15:19');
INSERT INTO `shop_access_records` VALUES (2801, 1000052, 1000017, '2020-08-11 19:16:59');
INSERT INTO `shop_access_records` VALUES (2802, 1000001, 1000035, '2020-08-11 19:18:27');
INSERT INTO `shop_access_records` VALUES (2803, 1000035, 1000035, '2020-08-11 19:18:37');
INSERT INTO `shop_access_records` VALUES (2804, 1000035, 1000035, '2020-08-11 19:18:44');
INSERT INTO `shop_access_records` VALUES (2805, 1000025, 1000084, '2020-08-11 19:19:10');
INSERT INTO `shop_access_records` VALUES (2806, 1000113, 1000106, '2020-08-11 19:19:12');
INSERT INTO `shop_access_records` VALUES (2807, 1000008, 1000008, '2020-08-11 19:20:27');
INSERT INTO `shop_access_records` VALUES (2808, 1000035, 1000035, '2020-08-11 19:20:31');
INSERT INTO `shop_access_records` VALUES (2809, 1000035, 1000035, '2020-08-11 19:22:46');
INSERT INTO `shop_access_records` VALUES (2810, 1000035, 1000035, '2020-08-11 19:23:01');
INSERT INTO `shop_access_records` VALUES (2811, 1000008, 1000008, '2020-08-11 19:23:10');
INSERT INTO `shop_access_records` VALUES (2812, 1000035, 1000035, '2020-08-11 19:26:16');
INSERT INTO `shop_access_records` VALUES (2813, 1000035, 1000035, '2020-08-11 19:26:41');
INSERT INTO `shop_access_records` VALUES (2814, 1000084, 1000084, '2020-08-11 19:27:02');
INSERT INTO `shop_access_records` VALUES (2815, 1000035, 1000035, '2020-08-11 19:27:08');
INSERT INTO `shop_access_records` VALUES (2816, 1000035, 1000035, '2020-08-11 19:27:20');
INSERT INTO `shop_access_records` VALUES (2817, 1000035, 1000035, '2020-08-11 19:29:34');
INSERT INTO `shop_access_records` VALUES (2818, 1000008, 1000035, '2020-08-11 19:29:55');
INSERT INTO `shop_access_records` VALUES (2819, 1000001, 1000035, '2020-08-11 19:29:56');
INSERT INTO `shop_access_records` VALUES (2820, 1000008, 1000035, '2020-08-11 19:30:06');
INSERT INTO `shop_access_records` VALUES (2821, 1000008, 1000035, '2020-08-11 19:30:13');
INSERT INTO `shop_access_records` VALUES (2822, 1000001, 1000035, '2020-08-11 19:30:16');
INSERT INTO `shop_access_records` VALUES (2823, 1000008, 1000008, '2020-08-11 19:30:36');
INSERT INTO `shop_access_records` VALUES (2824, 1000008, 1000008, '2020-08-11 19:31:07');
INSERT INTO `shop_access_records` VALUES (2825, 1000035, 1000035, '2020-08-11 19:31:10');
INSERT INTO `shop_access_records` VALUES (2826, 1000008, 1000008, '2020-08-11 19:34:39');
INSERT INTO `shop_access_records` VALUES (2827, 1000008, 1000008, '2020-08-11 19:35:16');
INSERT INTO `shop_access_records` VALUES (2828, 1000084, 1000084, '2020-08-11 19:37:16');
INSERT INTO `shop_access_records` VALUES (2829, 1000084, 1000084, '2020-08-11 19:40:23');
INSERT INTO `shop_access_records` VALUES (2830, 1000006, 1000035, '2020-08-11 19:40:33');
INSERT INTO `shop_access_records` VALUES (2831, 1000093, 1000017, '2020-08-11 19:44:10');
INSERT INTO `shop_access_records` VALUES (2832, 1000093, 1000017, '2020-08-11 19:44:34');
INSERT INTO `shop_access_records` VALUES (2833, 1000035, 1000035, '2020-08-11 19:58:10');
INSERT INTO `shop_access_records` VALUES (2834, 1000085, 1000084, '2020-08-11 20:00:02');
INSERT INTO `shop_access_records` VALUES (2835, 1000014, 1000035, '2020-08-11 20:03:24');
INSERT INTO `shop_access_records` VALUES (2836, 1000014, 1000035, '2020-08-11 20:03:33');
INSERT INTO `shop_access_records` VALUES (2837, 1000014, 1000035, '2020-08-11 20:03:39');
INSERT INTO `shop_access_records` VALUES (2838, 1000014, 1000017, '2020-08-11 20:03:54');
INSERT INTO `shop_access_records` VALUES (2839, 1000014, 1000035, '2020-08-11 20:04:12');
INSERT INTO `shop_access_records` VALUES (2840, 1000035, 1000035, '2020-08-11 20:07:59');
INSERT INTO `shop_access_records` VALUES (2841, 1000035, 1000035, '2020-08-11 20:10:14');
INSERT INTO `shop_access_records` VALUES (2842, 1000035, 1000035, '2020-08-11 20:10:18');
INSERT INTO `shop_access_records` VALUES (2843, 1000035, 1000017, '2020-08-11 20:11:01');
INSERT INTO `shop_access_records` VALUES (2844, 1000042, 1000035, '2020-08-11 20:16:33');
INSERT INTO `shop_access_records` VALUES (2845, 1000006, 1000035, '2020-08-11 20:17:06');
INSERT INTO `shop_access_records` VALUES (2846, 1000119, 1000084, '2020-08-11 20:58:22');
INSERT INTO `shop_access_records` VALUES (2847, 1000107, 1000106, '2020-08-11 21:00:18');
INSERT INTO `shop_access_records` VALUES (2848, 1000035, 1000035, '2020-08-11 21:00:22');
INSERT INTO `shop_access_records` VALUES (2849, 1000085, 1000084, '2020-08-11 21:00:37');
INSERT INTO `shop_access_records` VALUES (2850, 1000084, 1000084, '2020-08-11 21:00:46');
INSERT INTO `shop_access_records` VALUES (2851, 1000120, 1000084, '2020-08-11 21:03:13');
INSERT INTO `shop_access_records` VALUES (2852, 1000121, 1000084, '2020-08-11 21:03:53');
INSERT INTO `shop_access_records` VALUES (2853, 1000014, 1000035, '2020-08-11 21:11:06');
INSERT INTO `shop_access_records` VALUES (2854, 1000014, 1000035, '2020-08-11 21:11:19');
INSERT INTO `shop_access_records` VALUES (2855, 1000122, 1000084, '2020-08-11 21:44:47');
INSERT INTO `shop_access_records` VALUES (2856, 1000017, 1000017, '2020-08-11 22:27:52');
INSERT INTO `shop_access_records` VALUES (2857, 1000022, 1000022, '2020-08-11 23:32:32');
INSERT INTO `shop_access_records` VALUES (2858, 1000022, 1000022, '2020-08-12 00:10:00');
INSERT INTO `shop_access_records` VALUES (2859, 1000106, 1000106, '2020-08-12 00:31:08');
INSERT INTO `shop_access_records` VALUES (2860, 1000075, 1000017, '2020-08-12 01:13:39');
INSERT INTO `shop_access_records` VALUES (2861, 1000107, 1000106, '2020-08-12 07:20:01');
INSERT INTO `shop_access_records` VALUES (2862, 1000123, 1000084, '2020-08-12 08:59:30');
INSERT INTO `shop_access_records` VALUES (2863, 1000035, 1000035, '2020-08-12 09:02:48');
INSERT INTO `shop_access_records` VALUES (2864, 1000119, 1000084, '2020-08-12 09:06:38');
INSERT INTO `shop_access_records` VALUES (2865, 1000121, 1000084, '2020-08-12 09:07:52');
INSERT INTO `shop_access_records` VALUES (2866, 1000014, 1000035, '2020-08-12 09:09:10');
INSERT INTO `shop_access_records` VALUES (2867, 1000008, 1000008, '2020-08-12 09:16:21');
INSERT INTO `shop_access_records` VALUES (2868, 1000035, 1000035, '2020-08-12 09:35:16');
INSERT INTO `shop_access_records` VALUES (2869, 1000008, 1000008, '2020-08-12 09:42:15');
INSERT INTO `shop_access_records` VALUES (2870, 1000008, 1000008, '2020-08-12 09:42:25');
INSERT INTO `shop_access_records` VALUES (2871, 1000085, 1000084, '2020-08-12 09:42:59');
INSERT INTO `shop_access_records` VALUES (2872, 1000084, 1000084, '2020-08-12 09:47:39');
INSERT INTO `shop_access_records` VALUES (2873, 1000085, 1000084, '2020-08-12 09:47:49');
INSERT INTO `shop_access_records` VALUES (2874, 1000124, 1000060, '2020-08-12 09:48:32');
INSERT INTO `shop_access_records` VALUES (2875, 1000124, 1000060, '2020-08-12 09:48:40');
INSERT INTO `shop_access_records` VALUES (2876, 1000085, 1000084, '2020-08-12 09:48:49');
INSERT INTO `shop_access_records` VALUES (2877, 1000085, 1000084, '2020-08-12 09:59:57');
INSERT INTO `shop_access_records` VALUES (2878, 1000085, 1000084, '2020-08-12 10:00:45');
INSERT INTO `shop_access_records` VALUES (2879, 1000085, 1000084, '2020-08-12 10:01:07');
INSERT INTO `shop_access_records` VALUES (2880, 1000085, 1000084, '2020-08-12 10:01:34');
INSERT INTO `shop_access_records` VALUES (2881, 1000035, 1000035, '2020-08-12 10:02:27');
INSERT INTO `shop_access_records` VALUES (2882, 1000035, 1000035, '2020-08-12 10:03:04');
INSERT INTO `shop_access_records` VALUES (2883, 1000035, 1000035, '2020-08-12 10:04:20');
INSERT INTO `shop_access_records` VALUES (2884, 1000035, 1000035, '2020-08-12 10:04:54');
INSERT INTO `shop_access_records` VALUES (2885, 1000008, 1000008, '2020-08-12 10:05:15');
INSERT INTO `shop_access_records` VALUES (2886, 1000008, 1000008, '2020-08-12 10:10:22');
INSERT INTO `shop_access_records` VALUES (2887, 1000008, 1000008, '2020-08-12 10:10:25');
INSERT INTO `shop_access_records` VALUES (2888, 1000085, 1000084, '2020-08-12 10:29:02');
INSERT INTO `shop_access_records` VALUES (2889, 1000035, 1000035, '2020-08-12 10:33:53');
INSERT INTO `shop_access_records` VALUES (2890, 1000008, 1000008, '2020-08-12 10:44:20');
INSERT INTO `shop_access_records` VALUES (2891, 1000084, 1000084, '2020-08-12 10:44:49');
INSERT INTO `shop_access_records` VALUES (2892, 1000125, 1000017, '2020-08-12 11:19:48');
INSERT INTO `shop_access_records` VALUES (2893, 1000124, 1000060, '2020-08-12 11:21:23');
INSERT INTO `shop_access_records` VALUES (2894, 1000025, 1000084, '2020-08-12 12:06:48');
INSERT INTO `shop_access_records` VALUES (2895, 1000008, 1000008, '2020-08-12 12:07:03');
INSERT INTO `shop_access_records` VALUES (2896, 1000008, 1000008, '2020-08-12 12:14:49');
INSERT INTO `shop_access_records` VALUES (2897, 1000025, 1000084, '2020-08-12 12:14:56');
INSERT INTO `shop_access_records` VALUES (2898, 1000085, 1000084, '2020-08-12 13:16:55');
INSERT INTO `shop_access_records` VALUES (2899, 1000126, 1000060, '2020-08-12 13:17:27');
INSERT INTO `shop_access_records` VALUES (2900, 1000099, 1000099, '2020-08-12 13:38:44');
INSERT INTO `shop_access_records` VALUES (2901, 1000127, 1000099, '2020-08-12 13:39:51');
INSERT INTO `shop_access_records` VALUES (2902, 1000128, 1000099, '2020-08-12 13:40:11');
INSERT INTO `shop_access_records` VALUES (2903, 1000099, 1000099, '2020-08-12 13:40:33');
INSERT INTO `shop_access_records` VALUES (2904, 1000129, 1000099, '2020-08-12 13:41:03');
INSERT INTO `shop_access_records` VALUES (2905, 1000085, 1000084, '2020-08-12 13:41:21');
INSERT INTO `shop_access_records` VALUES (2906, 1000131, 1000099, '2020-08-12 13:43:51');
INSERT INTO `shop_access_records` VALUES (2907, 1000132, 1000099, '2020-08-12 13:44:21');
INSERT INTO `shop_access_records` VALUES (2908, 1000133, 1000099, '2020-08-12 13:52:58');
INSERT INTO `shop_access_records` VALUES (2909, 1000085, 1000084, '2020-08-12 13:55:19');
INSERT INTO `shop_access_records` VALUES (2910, 1000134, 1000099, '2020-08-12 13:55:45');
INSERT INTO `shop_access_records` VALUES (2911, 1000134, 1000099, '2020-08-12 13:57:09');
INSERT INTO `shop_access_records` VALUES (2912, 1000136, 1000099, '2020-08-12 14:15:51');
INSERT INTO `shop_access_records` VALUES (2913, 1000035, 1000035, '2020-08-12 14:24:56');
INSERT INTO `shop_access_records` VALUES (2914, 1000035, 1000035, '2020-08-12 14:26:31');
INSERT INTO `shop_access_records` VALUES (2915, 1000008, 1000008, '2020-08-12 14:41:09');
INSERT INTO `shop_access_records` VALUES (2916, 1000008, 1000017, '2020-08-12 14:41:15');
INSERT INTO `shop_access_records` VALUES (2917, 1000133, 1000099, '2020-08-12 15:04:08');
INSERT INTO `shop_access_records` VALUES (2918, 1000035, 1000035, '2020-08-12 15:11:54');
INSERT INTO `shop_access_records` VALUES (2919, 1000035, 1000035, '2020-08-12 15:15:31');
INSERT INTO `shop_access_records` VALUES (2920, 1000035, 1000035, '2020-08-12 15:20:06');
INSERT INTO `shop_access_records` VALUES (2921, 1000035, 1000035, '2020-08-12 15:21:05');
INSERT INTO `shop_access_records` VALUES (2922, 1000035, 1000035, '2020-08-12 15:30:05');
INSERT INTO `shop_access_records` VALUES (2923, 1000035, 1000035, '2020-08-12 15:31:17');
INSERT INTO `shop_access_records` VALUES (2924, 1000035, 1000035, '2020-08-12 15:32:39');
INSERT INTO `shop_access_records` VALUES (2925, 1000017, 1000017, '2020-08-12 15:33:13');
INSERT INTO `shop_access_records` VALUES (2926, 1000035, 1000035, '2020-08-12 15:39:13');
INSERT INTO `shop_access_records` VALUES (2927, 1000035, 1000035, '2020-08-12 15:40:17');
INSERT INTO `shop_access_records` VALUES (2928, 1000138, 1000099, '2020-08-12 15:40:38');
INSERT INTO `shop_access_records` VALUES (2929, 1000035, 1000035, '2020-08-12 15:45:39');
INSERT INTO `shop_access_records` VALUES (2930, 1000035, 1000035, '2020-08-12 15:47:47');
INSERT INTO `shop_access_records` VALUES (2931, 1000035, 1000035, '2020-08-12 15:49:47');
INSERT INTO `shop_access_records` VALUES (2932, 1000035, 1000035, '2020-08-12 15:50:29');
INSERT INTO `shop_access_records` VALUES (2933, 1000035, 1000035, '2020-08-12 15:50:47');
INSERT INTO `shop_access_records` VALUES (2934, 1000035, 1000035, '2020-08-12 15:51:28');
INSERT INTO `shop_access_records` VALUES (2935, 1000017, 1000017, '2020-08-12 15:54:05');
INSERT INTO `shop_access_records` VALUES (2936, 1000022, 1000022, '2020-08-12 15:54:11');
INSERT INTO `shop_access_records` VALUES (2937, 1000035, 1000035, '2020-08-12 15:55:05');
INSERT INTO `shop_access_records` VALUES (2938, 1000035, 1000035, '2020-08-12 15:55:30');
INSERT INTO `shop_access_records` VALUES (2939, 1000035, 1000035, '2020-08-12 15:55:48');
INSERT INTO `shop_access_records` VALUES (2940, 1000035, 1000035, '2020-08-12 15:56:52');
INSERT INTO `shop_access_records` VALUES (2941, 1000035, 1000035, '2020-08-12 15:57:52');
INSERT INTO `shop_access_records` VALUES (2942, 1000008, 1000013, '2020-08-12 15:58:37');
INSERT INTO `shop_access_records` VALUES (2943, 1000035, 1000035, '2020-08-12 15:58:57');
INSERT INTO `shop_access_records` VALUES (2944, 1000035, 1000035, '2020-08-12 15:59:37');
INSERT INTO `shop_access_records` VALUES (2945, 1000016, 1000084, '2020-08-12 15:59:53');
INSERT INTO `shop_access_records` VALUES (2946, 1000035, 1000035, '2020-08-12 16:00:45');
INSERT INTO `shop_access_records` VALUES (2947, 1000035, 1000035, '2020-08-12 16:01:06');
INSERT INTO `shop_access_records` VALUES (2948, 1000035, 1000035, '2020-08-12 16:01:52');
INSERT INTO `shop_access_records` VALUES (2949, 1000035, 1000035, '2020-08-12 16:02:12');
INSERT INTO `shop_access_records` VALUES (2950, 1000035, 1000035, '2020-08-12 16:03:12');
INSERT INTO `shop_access_records` VALUES (2951, 1000035, 1000035, '2020-08-12 16:04:24');
INSERT INTO `shop_access_records` VALUES (2952, 1000017, 1000017, '2020-08-12 16:06:53');
INSERT INTO `shop_access_records` VALUES (2953, 1000035, 1000035, '2020-08-12 16:09:25');
INSERT INTO `shop_access_records` VALUES (2954, 1000017, 1000017, '2020-08-12 16:09:26');
INSERT INTO `shop_access_records` VALUES (2955, 1000035, 1000035, '2020-08-12 16:10:34');
INSERT INTO `shop_access_records` VALUES (2956, 1000035, 1000035, '2020-08-12 16:10:54');
INSERT INTO `shop_access_records` VALUES (2957, 1000035, 1000035, '2020-08-12 16:15:22');
INSERT INTO `shop_access_records` VALUES (2958, 1000035, 1000035, '2020-08-12 16:16:06');
INSERT INTO `shop_access_records` VALUES (2959, 1000035, 1000035, '2020-08-12 16:17:10');
INSERT INTO `shop_access_records` VALUES (2960, 1000035, 1000035, '2020-08-12 16:17:34');
INSERT INTO `shop_access_records` VALUES (2961, 1000035, 1000035, '2020-08-12 16:18:40');
INSERT INTO `shop_access_records` VALUES (2962, 1000035, 1000035, '2020-08-12 16:19:34');
INSERT INTO `shop_access_records` VALUES (2963, 1000035, 1000035, '2020-08-12 16:19:55');
INSERT INTO `shop_access_records` VALUES (2964, 1000035, 1000035, '2020-08-12 16:22:14');
INSERT INTO `shop_access_records` VALUES (2965, 1000035, 1000035, '2020-08-12 16:23:01');
INSERT INTO `shop_access_records` VALUES (2966, 1000035, 1000035, '2020-08-12 16:23:29');
INSERT INTO `shop_access_records` VALUES (2967, 1000035, 1000035, '2020-08-12 16:23:52');
INSERT INTO `shop_access_records` VALUES (2968, 1000035, 1000035, '2020-08-12 16:24:03');
INSERT INTO `shop_access_records` VALUES (2969, 1000035, 1000035, '2020-08-12 16:24:36');
INSERT INTO `shop_access_records` VALUES (2970, 1000035, 1000035, '2020-08-12 16:24:49');
INSERT INTO `shop_access_records` VALUES (2971, 1000035, 1000035, '2020-08-12 16:25:05');
INSERT INTO `shop_access_records` VALUES (2972, 1000035, 1000035, '2020-08-12 16:25:30');
INSERT INTO `shop_access_records` VALUES (2973, 1000035, 1000035, '2020-08-12 16:26:03');
INSERT INTO `shop_access_records` VALUES (2974, 1000035, 1000035, '2020-08-12 16:26:58');
INSERT INTO `shop_access_records` VALUES (2975, 1000017, 1000106, '2020-08-12 16:29:17');
INSERT INTO `shop_access_records` VALUES (2976, 1000017, 1000099, '2020-08-12 16:29:29');
INSERT INTO `shop_access_records` VALUES (2977, 1000017, 1000017, '2020-08-12 16:29:38');
INSERT INTO `shop_access_records` VALUES (2978, 1000017, 1000013, '2020-08-12 16:29:44');
INSERT INTO `shop_access_records` VALUES (2979, 1000017, 1000017, '2020-08-12 16:29:50');
INSERT INTO `shop_access_records` VALUES (2980, 1000035, 1000035, '2020-08-12 16:30:00');
INSERT INTO `shop_access_records` VALUES (2981, 1000016, 1000084, '2020-08-12 16:32:50');
INSERT INTO `shop_access_records` VALUES (2982, 1000016, 1000016, '2020-08-12 16:33:24');
INSERT INTO `shop_access_records` VALUES (2983, 1000035, 1000035, '2020-08-12 16:33:55');
INSERT INTO `shop_access_records` VALUES (2984, 1000035, 1000035, '2020-08-12 16:37:46');
INSERT INTO `shop_access_records` VALUES (2985, 1000035, 1000035, '2020-08-12 16:38:19');
INSERT INTO `shop_access_records` VALUES (2986, 1000035, 1000035, '2020-08-12 16:39:17');
INSERT INTO `shop_access_records` VALUES (2987, 1000008, 1000008, '2020-08-12 16:48:18');
INSERT INTO `shop_access_records` VALUES (2988, 1000017, 1000017, '2020-08-12 16:54:05');
INSERT INTO `shop_access_records` VALUES (2989, 1000035, 1000035, '2020-08-12 17:19:30');
INSERT INTO `shop_access_records` VALUES (2990, 1000017, 1000017, '2020-08-12 17:32:13');
INSERT INTO `shop_access_records` VALUES (2991, 1000107, 1000106, '2020-08-12 17:34:17');
INSERT INTO `shop_access_records` VALUES (2992, 1000035, 1000035, '2020-08-12 17:37:02');
INSERT INTO `shop_access_records` VALUES (2993, 1000035, 1000035, '2020-08-12 17:37:07');
INSERT INTO `shop_access_records` VALUES (2994, 1000035, 1000035, '2020-08-12 17:37:34');
INSERT INTO `shop_access_records` VALUES (2995, 1000035, 1000035, '2020-08-12 17:38:24');
INSERT INTO `shop_access_records` VALUES (2996, 1000035, 1000035, '2020-08-12 17:38:30');
INSERT INTO `shop_access_records` VALUES (2997, 1000035, 1000035, '2020-08-12 17:43:40');
INSERT INTO `shop_access_records` VALUES (2998, 1000035, 1000035, '2020-08-12 17:44:10');
INSERT INTO `shop_access_records` VALUES (2999, 1000035, 1000035, '2020-08-12 17:44:44');
INSERT INTO `shop_access_records` VALUES (3000, 1000035, 1000035, '2020-08-12 17:45:10');
INSERT INTO `shop_access_records` VALUES (3001, 1000035, 1000035, '2020-08-12 17:51:42');
INSERT INTO `shop_access_records` VALUES (3002, 1000035, 1000035, '2020-08-12 17:59:43');
INSERT INTO `shop_access_records` VALUES (3003, 1000035, 1000035, '2020-08-12 17:59:46');
INSERT INTO `shop_access_records` VALUES (3004, 1000035, 1000035, '2020-08-12 18:00:12');
INSERT INTO `shop_access_records` VALUES (3005, 1000035, 1000035, '2020-08-12 18:00:18');
INSERT INTO `shop_access_records` VALUES (3006, 1000035, 1000035, '2020-08-12 18:01:45');
INSERT INTO `shop_access_records` VALUES (3007, 1000035, 1000035, '2020-08-12 18:02:11');
INSERT INTO `shop_access_records` VALUES (3008, 1000035, 1000035, '2020-08-12 18:02:41');
INSERT INTO `shop_access_records` VALUES (3009, 1000035, 1000035, '2020-08-12 18:03:43');
INSERT INTO `shop_access_records` VALUES (3010, 1000017, 1000017, '2020-08-12 18:15:17');
INSERT INTO `shop_access_records` VALUES (3011, 1000035, 1000035, '2020-08-12 18:17:30');
INSERT INTO `shop_access_records` VALUES (3012, 1000035, 1000035, '2020-08-12 18:17:34');
INSERT INTO `shop_access_records` VALUES (3013, 1000035, 1000035, '2020-08-12 18:26:33');
INSERT INTO `shop_access_records` VALUES (3014, 1000035, 1000035, '2020-08-12 18:26:38');
INSERT INTO `shop_access_records` VALUES (3015, 1000035, 1000035, '2020-08-12 18:32:00');
INSERT INTO `shop_access_records` VALUES (3016, 1000035, 1000035, '2020-08-12 18:32:24');
INSERT INTO `shop_access_records` VALUES (3017, 1000035, 1000035, '2020-08-12 18:32:47');
INSERT INTO `shop_access_records` VALUES (3018, 1000035, 1000035, '2020-08-12 18:33:16');
INSERT INTO `shop_access_records` VALUES (3019, 1000035, 1000035, '2020-08-12 18:39:22');
INSERT INTO `shop_access_records` VALUES (3020, 1000035, 1000035, '2020-08-12 18:39:44');
INSERT INTO `shop_access_records` VALUES (3021, 1000035, 1000035, '2020-08-12 18:40:06');
INSERT INTO `shop_access_records` VALUES (3022, 1000035, 1000035, '2020-08-12 18:40:33');
INSERT INTO `shop_access_records` VALUES (3023, 1000035, 1000035, '2020-08-12 18:41:05');
INSERT INTO `shop_access_records` VALUES (3024, 1000035, 1000035, '2020-08-12 18:46:41');
INSERT INTO `shop_access_records` VALUES (3025, 1000035, 1000035, '2020-08-12 18:48:10');
INSERT INTO `shop_access_records` VALUES (3026, 1000035, 1000035, '2020-08-12 19:07:31');
INSERT INTO `shop_access_records` VALUES (3027, 1000035, 1000099, '2020-08-12 19:17:08');
INSERT INTO `shop_access_records` VALUES (3028, 1000035, 1000017, '2020-08-12 19:18:24');
INSERT INTO `shop_access_records` VALUES (3029, 1000001, 1000084, '2020-08-12 19:19:51');
INSERT INTO `shop_access_records` VALUES (3030, 1000001, 1000017, '2020-08-12 19:20:00');
INSERT INTO `shop_access_records` VALUES (3031, 1000001, 1000065, '2020-08-12 19:23:24');
INSERT INTO `shop_access_records` VALUES (3032, 1000001, 1000099, '2020-08-12 19:23:32');
INSERT INTO `shop_access_records` VALUES (3033, 1000035, 1000065, '2020-08-12 19:25:53');
INSERT INTO `shop_access_records` VALUES (3034, 1000017, 1000017, '2020-08-12 23:01:43');
INSERT INTO `shop_access_records` VALUES (3035, 1000013, 1000013, '2020-08-12 23:50:07');
INSERT INTO `shop_access_records` VALUES (3036, 1000035, 1000035, '2020-08-13 09:49:56');
INSERT INTO `shop_access_records` VALUES (3037, 1000001, 1000084, '2020-08-13 10:45:06');
INSERT INTO `shop_access_records` VALUES (3038, 1000085, 1000084, '2020-08-13 11:01:43');
INSERT INTO `shop_access_records` VALUES (3039, 1000084, 1000084, '2020-08-13 11:02:06');
INSERT INTO `shop_access_records` VALUES (3040, 1000035, 1000035, '2020-08-13 11:14:07');
INSERT INTO `shop_access_records` VALUES (3041, 1000017, 1000017, '2020-08-13 11:15:44');
INSERT INTO `shop_access_records` VALUES (3042, 1000017, 1000017, '2020-08-13 11:18:49');
INSERT INTO `shop_access_records` VALUES (3043, 1000001, 1000084, '2020-08-13 11:19:21');
INSERT INTO `shop_access_records` VALUES (3044, 1000113, 1000106, '2020-08-13 11:21:47');
INSERT INTO `shop_access_records` VALUES (3045, 1000017, 1000017, '2020-08-13 11:22:55');
INSERT INTO `shop_access_records` VALUES (3046, 1000017, 1000017, '2020-08-13 11:31:44');
INSERT INTO `shop_access_records` VALUES (3047, 1000035, 1000035, '2020-08-13 11:34:42');
INSERT INTO `shop_access_records` VALUES (3048, 1000017, 1000017, '2020-08-13 11:36:50');
INSERT INTO `shop_access_records` VALUES (3049, 1000017, 1000017, '2020-08-13 11:42:47');
INSERT INTO `shop_access_records` VALUES (3050, 1000035, 1000035, '2020-08-13 11:44:41');
INSERT INTO `shop_access_records` VALUES (3051, 1000035, 1000035, '2020-08-13 12:05:22');
INSERT INTO `shop_access_records` VALUES (3052, 1000001, 1000084, '2020-08-13 12:08:14');
INSERT INTO `shop_access_records` VALUES (3053, 1000001, 1000017, '2020-08-13 12:08:20');
INSERT INTO `shop_access_records` VALUES (3054, 1000035, 1000035, '2020-08-13 15:04:11');
INSERT INTO `shop_access_records` VALUES (3055, 1000017, 1000017, '2020-08-13 15:57:33');
INSERT INTO `shop_access_records` VALUES (3056, 1000017, 1000017, '2020-08-13 16:25:12');
INSERT INTO `shop_access_records` VALUES (3057, 1000140, 1000084, '2020-08-13 16:25:26');
INSERT INTO `shop_access_records` VALUES (3058, 1000035, 1000035, '2020-08-13 18:19:52');
INSERT INTO `shop_access_records` VALUES (3059, 1000035, 1000035, '2020-08-13 18:20:22');
INSERT INTO `shop_access_records` VALUES (3060, 1000107, 1000106, '2020-08-13 19:13:00');
INSERT INTO `shop_access_records` VALUES (3061, 1000035, 1000035, '2020-08-13 19:13:34');
INSERT INTO `shop_access_records` VALUES (3062, 1000017, 1000017, '2020-08-13 19:20:42');
INSERT INTO `shop_access_records` VALUES (3063, 1000054, 1000017, '2020-08-13 21:10:29');
INSERT INTO `shop_access_records` VALUES (3064, 1000017, 1000017, '2020-08-13 21:21:33');
INSERT INTO `shop_access_records` VALUES (3065, 1000100, 1000017, '2020-08-13 21:23:01');
INSERT INTO `shop_access_records` VALUES (3066, 1000100, 1000100, '2020-08-13 21:23:16');
INSERT INTO `shop_access_records` VALUES (3067, 1000100, 1000017, '2020-08-13 21:24:32');
INSERT INTO `shop_access_records` VALUES (3068, 1000054, 1000017, '2020-08-13 21:25:19');
INSERT INTO `shop_access_records` VALUES (3069, 1000017, 1000017, '2020-08-13 22:16:37');
INSERT INTO `shop_access_records` VALUES (3070, 1000017, 1000106, '2020-08-13 22:16:57');
INSERT INTO `shop_access_records` VALUES (3071, 1000017, 1000017, '2020-08-13 22:20:21');
INSERT INTO `shop_access_records` VALUES (3072, 1000017, 1000017, '2020-08-14 09:20:30');
INSERT INTO `shop_access_records` VALUES (3073, 1000017, 1000017, '2020-08-14 09:25:40');
INSERT INTO `shop_access_records` VALUES (3074, 1000035, 1000035, '2020-08-14 09:28:27');
INSERT INTO `shop_access_records` VALUES (3075, 1000013, 1000013, '2020-08-14 09:30:48');
INSERT INTO `shop_access_records` VALUES (3076, 1000035, 1000035, '2020-08-14 09:31:00');
INSERT INTO `shop_access_records` VALUES (3077, 1000035, 1000035, '2020-08-14 09:31:24');
INSERT INTO `shop_access_records` VALUES (3078, 1000013, 1000013, '2020-08-14 10:58:23');
INSERT INTO `shop_access_records` VALUES (3079, 1000013, 1000013, '2020-08-14 14:28:11');
INSERT INTO `shop_access_records` VALUES (3080, 1000013, 1000013, '2020-08-14 14:28:18');
INSERT INTO `shop_access_records` VALUES (3081, 1000013, 1000013, '2020-08-14 14:28:28');
INSERT INTO `shop_access_records` VALUES (3082, 1000013, 1000013, '2020-08-14 14:28:35');
INSERT INTO `shop_access_records` VALUES (3083, 1000013, 1000013, '2020-08-14 14:29:29');
INSERT INTO `shop_access_records` VALUES (3084, 1000013, 1000013, '2020-08-14 14:30:03');
INSERT INTO `shop_access_records` VALUES (3085, 1000013, 1000013, '2020-08-14 14:30:10');
INSERT INTO `shop_access_records` VALUES (3086, 1000013, 1000013, '2020-08-14 14:30:19');
INSERT INTO `shop_access_records` VALUES (3087, 1000013, 1000013, '2020-08-14 14:30:39');
INSERT INTO `shop_access_records` VALUES (3088, 1000013, 1000013, '2020-08-14 14:31:09');
INSERT INTO `shop_access_records` VALUES (3089, 1000107, 1000106, '2020-08-14 15:34:14');
INSERT INTO `shop_access_records` VALUES (3090, 1000035, 1000035, '2020-08-14 16:55:29');
INSERT INTO `shop_access_records` VALUES (3091, 1000035, 1000035, '2020-08-14 16:56:10');
INSERT INTO `shop_access_records` VALUES (3092, 1000035, 1000035, '2020-08-14 16:57:11');
INSERT INTO `shop_access_records` VALUES (3093, 1000035, 1000035, '2020-08-14 17:16:40');
INSERT INTO `shop_access_records` VALUES (3094, 1000035, 1000035, '2020-08-14 17:19:08');
INSERT INTO `shop_access_records` VALUES (3095, 1000035, 1000035, '2020-08-14 17:20:28');
INSERT INTO `shop_access_records` VALUES (3096, 1000025, 1000084, '2020-08-14 17:21:21');
INSERT INTO `shop_access_records` VALUES (3097, 1000035, 1000035, '2020-08-14 17:21:53');
INSERT INTO `shop_access_records` VALUES (3098, 1000035, 1000035, '2020-08-14 17:22:47');
INSERT INTO `shop_access_records` VALUES (3099, 1000035, 1000035, '2020-08-14 17:23:47');
INSERT INTO `shop_access_records` VALUES (3100, 1000035, 1000035, '2020-08-14 17:24:22');
INSERT INTO `shop_access_records` VALUES (3101, 1000013, 1000013, '2020-08-14 17:24:44');
INSERT INTO `shop_access_records` VALUES (3102, 1000035, 1000035, '2020-08-14 17:25:47');
INSERT INTO `shop_access_records` VALUES (3103, 1000035, 1000035, '2020-08-14 17:27:11');
INSERT INTO `shop_access_records` VALUES (3104, 1000035, 1000035, '2020-08-14 17:27:46');
INSERT INTO `shop_access_records` VALUES (3105, 1000035, 1000035, '2020-08-14 17:28:05');
INSERT INTO `shop_access_records` VALUES (3106, 1000013, 1000013, '2020-08-14 17:29:10');
INSERT INTO `shop_access_records` VALUES (3107, 1000035, 1000035, '2020-08-14 17:29:33');
INSERT INTO `shop_access_records` VALUES (3108, 1000035, 1000035, '2020-08-14 17:30:30');
INSERT INTO `shop_access_records` VALUES (3109, 1000035, 1000035, '2020-08-14 17:30:51');
INSERT INTO `shop_access_records` VALUES (3110, 1000035, 1000035, '2020-08-14 17:31:41');
INSERT INTO `shop_access_records` VALUES (3111, 1000035, 1000035, '2020-08-14 17:32:10');
INSERT INTO `shop_access_records` VALUES (3112, 1000035, 1000035, '2020-08-14 17:32:44');
INSERT INTO `shop_access_records` VALUES (3113, 1000035, 1000035, '2020-08-14 17:33:45');
INSERT INTO `shop_access_records` VALUES (3114, 1000035, 1000035, '2020-08-14 17:34:27');
INSERT INTO `shop_access_records` VALUES (3115, 1000035, 1000035, '2020-08-14 17:34:46');
INSERT INTO `shop_access_records` VALUES (3116, 1000035, 1000035, '2020-08-14 17:34:55');
INSERT INTO `shop_access_records` VALUES (3117, 1000035, 1000035, '2020-08-14 17:39:03');
INSERT INTO `shop_access_records` VALUES (3118, 1000035, 1000035, '2020-08-14 17:40:34');
INSERT INTO `shop_access_records` VALUES (3119, 1000035, 1000035, '2020-08-14 17:41:14');
INSERT INTO `shop_access_records` VALUES (3120, 1000035, 1000035, '2020-08-14 17:42:16');
INSERT INTO `shop_access_records` VALUES (3121, 1000035, 1000035, '2020-08-14 17:42:57');
INSERT INTO `shop_access_records` VALUES (3122, 1000035, 1000035, '2020-08-14 17:43:38');
INSERT INTO `shop_access_records` VALUES (3123, 1000035, 1000035, '2020-08-14 17:49:45');
INSERT INTO `shop_access_records` VALUES (3124, 1000035, 1000035, '2020-08-14 17:50:03');
INSERT INTO `shop_access_records` VALUES (3125, 1000035, 1000035, '2020-08-14 17:55:18');
INSERT INTO `shop_access_records` VALUES (3126, 1000035, 1000035, '2020-08-14 17:57:40');
INSERT INTO `shop_access_records` VALUES (3127, 1000035, 1000035, '2020-08-14 18:00:03');
INSERT INTO `shop_access_records` VALUES (3128, 1000035, 1000035, '2020-08-14 18:00:22');
INSERT INTO `shop_access_records` VALUES (3129, 1000035, 1000035, '2020-08-14 18:00:41');
INSERT INTO `shop_access_records` VALUES (3130, 1000035, 1000035, '2020-08-14 18:01:23');
INSERT INTO `shop_access_records` VALUES (3131, 1000035, 1000035, '2020-08-14 18:04:17');
INSERT INTO `shop_access_records` VALUES (3132, 1000035, 1000035, '2020-08-14 18:04:40');
INSERT INTO `shop_access_records` VALUES (3133, 1000035, 1000035, '2020-08-14 18:05:03');
INSERT INTO `shop_access_records` VALUES (3134, 1000035, 1000035, '2020-08-14 18:06:02');
INSERT INTO `shop_access_records` VALUES (3135, 1000035, 1000035, '2020-08-14 18:06:22');
INSERT INTO `shop_access_records` VALUES (3136, 1000035, 1000035, '2020-08-14 18:06:25');
INSERT INTO `shop_access_records` VALUES (3137, 1000035, 1000035, '2020-08-14 18:07:05');
INSERT INTO `shop_access_records` VALUES (3138, 1000035, 1000035, '2020-08-14 18:07:40');
INSERT INTO `shop_access_records` VALUES (3139, 1000035, 1000035, '2020-08-14 18:08:01');
INSERT INTO `shop_access_records` VALUES (3140, 1000035, 1000035, '2020-08-14 18:08:46');
INSERT INTO `shop_access_records` VALUES (3141, 1000035, 1000035, '2020-08-14 18:09:37');
INSERT INTO `shop_access_records` VALUES (3142, 1000035, 1000035, '2020-08-14 18:10:02');
INSERT INTO `shop_access_records` VALUES (3143, 1000035, 1000035, '2020-08-14 18:11:10');
INSERT INTO `shop_access_records` VALUES (3144, 1000035, 1000035, '2020-08-14 18:12:14');
INSERT INTO `shop_access_records` VALUES (3145, 1000035, 1000035, '2020-08-14 18:12:38');
INSERT INTO `shop_access_records` VALUES (3146, 1000035, 1000035, '2020-08-14 18:14:44');
INSERT INTO `shop_access_records` VALUES (3147, 1000035, 1000035, '2020-08-14 18:15:02');
INSERT INTO `shop_access_records` VALUES (3148, 1000035, 1000035, '2020-08-14 18:15:47');
INSERT INTO `shop_access_records` VALUES (3149, 1000035, 1000035, '2020-08-14 18:16:03');
INSERT INTO `shop_access_records` VALUES (3150, 1000035, 1000035, '2020-08-14 18:18:40');
INSERT INTO `shop_access_records` VALUES (3151, 1000035, 1000035, '2020-08-14 18:19:05');
INSERT INTO `shop_access_records` VALUES (3152, 1000035, 1000035, '2020-08-14 18:20:59');
INSERT INTO `shop_access_records` VALUES (3153, 1000035, 1000035, '2020-08-14 18:21:30');
INSERT INTO `shop_access_records` VALUES (3154, 1000035, 1000035, '2020-08-14 18:22:25');
INSERT INTO `shop_access_records` VALUES (3155, 1000035, 1000035, '2020-08-14 18:23:03');
INSERT INTO `shop_access_records` VALUES (3156, 1000035, 1000035, '2020-08-14 18:23:15');
INSERT INTO `shop_access_records` VALUES (3157, 1000035, 1000035, '2020-08-14 18:23:40');
INSERT INTO `shop_access_records` VALUES (3158, 1000035, 1000035, '2020-08-14 18:24:17');
INSERT INTO `shop_access_records` VALUES (3159, 1000035, 1000035, '2020-08-14 18:36:26');
INSERT INTO `shop_access_records` VALUES (3160, 1000035, 1000035, '2020-08-14 18:36:51');
INSERT INTO `shop_access_records` VALUES (3161, 1000035, 1000035, '2020-08-14 18:37:41');
INSERT INTO `shop_access_records` VALUES (3162, 1000035, 1000035, '2020-08-14 19:16:05');
INSERT INTO `shop_access_records` VALUES (3163, 1000019, 1000018, '2020-08-14 19:19:25');
INSERT INTO `shop_access_records` VALUES (3164, 1000017, 1000017, '2020-08-14 19:24:57');
INSERT INTO `shop_access_records` VALUES (3165, 1000035, 1000035, '2020-08-14 19:30:47');
INSERT INTO `shop_access_records` VALUES (3166, 1000035, 1000035, '2020-08-14 19:34:01');
INSERT INTO `shop_access_records` VALUES (3167, 1000035, 1000035, '2020-08-14 19:35:23');
INSERT INTO `shop_access_records` VALUES (3168, 1000035, 1000035, '2020-08-14 19:35:43');
INSERT INTO `shop_access_records` VALUES (3169, 1000035, 1000035, '2020-08-14 19:36:09');
INSERT INTO `shop_access_records` VALUES (3170, 1000035, 1000035, '2020-08-14 19:36:27');
INSERT INTO `shop_access_records` VALUES (3171, 1000035, 1000035, '2020-08-14 19:37:44');
INSERT INTO `shop_access_records` VALUES (3172, 1000035, 1000035, '2020-08-14 19:38:28');
INSERT INTO `shop_access_records` VALUES (3173, 1000035, 1000035, '2020-08-14 19:39:31');
INSERT INTO `shop_access_records` VALUES (3174, 1000035, 1000035, '2020-08-14 19:40:17');
INSERT INTO `shop_access_records` VALUES (3175, 1000035, 1000035, '2020-08-14 19:42:00');
INSERT INTO `shop_access_records` VALUES (3176, 1000035, 1000035, '2020-08-14 19:42:36');
INSERT INTO `shop_access_records` VALUES (3177, 1000035, 1000035, '2020-08-14 19:43:13');
INSERT INTO `shop_access_records` VALUES (3178, 1000035, 1000035, '2020-08-14 19:44:21');
INSERT INTO `shop_access_records` VALUES (3179, 1000035, 1000035, '2020-08-14 19:44:38');
INSERT INTO `shop_access_records` VALUES (3180, 1000035, 1000035, '2020-08-14 19:44:49');
INSERT INTO `shop_access_records` VALUES (3181, 1000035, 1000035, '2020-08-14 19:45:28');
INSERT INTO `shop_access_records` VALUES (3182, 1000035, 1000035, '2020-08-14 19:49:58');
INSERT INTO `shop_access_records` VALUES (3183, 1000035, 1000035, '2020-08-14 19:51:28');
INSERT INTO `shop_access_records` VALUES (3184, 1000107, 1000106, '2020-08-15 08:46:54');
INSERT INTO `shop_access_records` VALUES (3185, 1000107, 1000106, '2020-08-15 08:47:56');
INSERT INTO `shop_access_records` VALUES (3186, 1000107, 1000106, '2020-08-15 08:58:30');
INSERT INTO `shop_access_records` VALUES (3187, 1000113, 1000106, '2020-08-15 14:24:36');
INSERT INTO `shop_access_records` VALUES (3188, 1000065, 1000065, '2020-08-16 17:29:05');
INSERT INTO `shop_access_records` VALUES (3189, 1000095, 1000095, '2020-08-16 20:16:21');
INSERT INTO `shop_access_records` VALUES (3190, 1000035, 1000035, '2020-08-17 09:14:19');
INSERT INTO `shop_access_records` VALUES (3191, 1000035, 1000035, '2020-08-17 09:48:45');
INSERT INTO `shop_access_records` VALUES (3192, 1000035, 1000035, '2020-08-17 09:49:52');
INSERT INTO `shop_access_records` VALUES (3193, 1000035, 1000035, '2020-08-17 09:50:05');
INSERT INTO `shop_access_records` VALUES (3194, 1000035, 1000035, '2020-08-17 09:50:58');
INSERT INTO `shop_access_records` VALUES (3195, 1000035, 1000035, '2020-08-17 09:51:15');
INSERT INTO `shop_access_records` VALUES (3196, 1000035, 1000035, '2020-08-17 09:54:13');
INSERT INTO `shop_access_records` VALUES (3197, 1000035, 1000035, '2020-08-17 09:54:16');
INSERT INTO `shop_access_records` VALUES (3198, 1000035, 1000035, '2020-08-17 09:55:14');
INSERT INTO `shop_access_records` VALUES (3199, 1000035, 1000035, '2020-08-17 09:55:27');
INSERT INTO `shop_access_records` VALUES (3200, 1000035, 1000035, '2020-08-17 09:57:03');
INSERT INTO `shop_access_records` VALUES (3201, 1000035, 1000035, '2020-08-17 09:59:16');
INSERT INTO `shop_access_records` VALUES (3202, 1000035, 1000035, '2020-08-17 09:59:41');
INSERT INTO `shop_access_records` VALUES (3203, 1000035, 1000035, '2020-08-17 10:00:29');
INSERT INTO `shop_access_records` VALUES (3204, 1000035, 1000035, '2020-08-17 10:01:07');
INSERT INTO `shop_access_records` VALUES (3205, 1000035, 1000035, '2020-08-17 10:01:42');
INSERT INTO `shop_access_records` VALUES (3206, 1000035, 1000035, '2020-08-17 10:02:20');
INSERT INTO `shop_access_records` VALUES (3207, 1000035, 1000035, '2020-08-17 10:02:26');
INSERT INTO `shop_access_records` VALUES (3208, 1000035, 1000035, '2020-08-17 10:03:10');
INSERT INTO `shop_access_records` VALUES (3209, 1000035, 1000035, '2020-08-17 10:03:53');
INSERT INTO `shop_access_records` VALUES (3210, 1000035, 1000035, '2020-08-17 10:04:15');
INSERT INTO `shop_access_records` VALUES (3211, 1000035, 1000035, '2020-08-17 10:04:48');
INSERT INTO `shop_access_records` VALUES (3212, 1000035, 1000035, '2020-08-17 10:05:47');
INSERT INTO `shop_access_records` VALUES (3213, 1000035, 1000035, '2020-08-17 10:07:36');
INSERT INTO `shop_access_records` VALUES (3214, 1000035, 1000035, '2020-08-17 10:07:56');
INSERT INTO `shop_access_records` VALUES (3215, 1000035, 1000035, '2020-08-17 10:08:17');
INSERT INTO `shop_access_records` VALUES (3216, 1000035, 1000035, '2020-08-17 10:09:20');
INSERT INTO `shop_access_records` VALUES (3217, 1000035, 1000035, '2020-08-17 10:09:24');
INSERT INTO `shop_access_records` VALUES (3218, 1000035, 1000035, '2020-08-17 10:11:13');
INSERT INTO `shop_access_records` VALUES (3219, 1000035, 1000035, '2020-08-17 10:12:28');
INSERT INTO `shop_access_records` VALUES (3220, 1000035, 1000035, '2020-08-17 10:13:15');
INSERT INTO `shop_access_records` VALUES (3221, 1000035, 1000035, '2020-08-17 10:13:57');
INSERT INTO `shop_access_records` VALUES (3222, 1000035, 1000035, '2020-08-17 10:14:27');
INSERT INTO `shop_access_records` VALUES (3223, 1000035, 1000035, '2020-08-17 10:15:59');
INSERT INTO `shop_access_records` VALUES (3224, 1000035, 1000035, '2020-08-17 10:16:55');
INSERT INTO `shop_access_records` VALUES (3225, 1000035, 1000035, '2020-08-17 10:17:00');
INSERT INTO `shop_access_records` VALUES (3226, 1000035, 1000035, '2020-08-17 10:17:11');
INSERT INTO `shop_access_records` VALUES (3227, 1000035, 1000035, '2020-08-17 10:18:32');
INSERT INTO `shop_access_records` VALUES (3228, 1000035, 1000035, '2020-08-17 10:23:22');
INSERT INTO `shop_access_records` VALUES (3229, 1000035, 1000035, '2020-08-17 10:23:58');
INSERT INTO `shop_access_records` VALUES (3230, 1000035, 1000035, '2020-08-17 10:25:23');
INSERT INTO `shop_access_records` VALUES (3231, 1000035, 1000035, '2020-08-17 10:26:21');
INSERT INTO `shop_access_records` VALUES (3232, 1000035, 1000035, '2020-08-17 10:27:16');
INSERT INTO `shop_access_records` VALUES (3233, 1000035, 1000035, '2020-08-17 10:30:05');
INSERT INTO `shop_access_records` VALUES (3234, 1000035, 1000035, '2020-08-17 10:30:09');
INSERT INTO `shop_access_records` VALUES (3235, 1000035, 1000035, '2020-08-17 10:32:13');
INSERT INTO `shop_access_records` VALUES (3236, 1000035, 1000035, '2020-08-17 10:32:32');
INSERT INTO `shop_access_records` VALUES (3237, 1000035, 1000035, '2020-08-17 10:33:48');
INSERT INTO `shop_access_records` VALUES (3238, 1000035, 1000035, '2020-08-17 10:34:49');
INSERT INTO `shop_access_records` VALUES (3239, 1000035, 1000035, '2020-08-17 10:35:48');
INSERT INTO `shop_access_records` VALUES (3240, 1000035, 1000035, '2020-08-17 10:38:12');
INSERT INTO `shop_access_records` VALUES (3241, 1000035, 1000035, '2020-08-17 10:40:51');
INSERT INTO `shop_access_records` VALUES (3242, 1000035, 1000035, '2020-08-17 10:42:38');
INSERT INTO `shop_access_records` VALUES (3243, 1000035, 1000035, '2020-08-17 10:42:53');
INSERT INTO `shop_access_records` VALUES (3244, 1000035, 1000035, '2020-08-17 10:44:28');
INSERT INTO `shop_access_records` VALUES (3245, 1000035, 1000035, '2020-08-17 10:45:10');
INSERT INTO `shop_access_records` VALUES (3246, 1000035, 1000035, '2020-08-17 10:46:32');
INSERT INTO `shop_access_records` VALUES (3247, 1000035, 1000035, '2020-08-17 10:46:54');
INSERT INTO `shop_access_records` VALUES (3248, 1000035, 1000035, '2020-08-17 10:48:06');
INSERT INTO `shop_access_records` VALUES (3249, 1000025, 1000084, '2020-08-17 10:48:31');
INSERT INTO `shop_access_records` VALUES (3250, 1000006, 1000013, '2020-08-17 10:48:45');
INSERT INTO `shop_access_records` VALUES (3251, 1000085, 1000084, '2020-08-17 10:49:53');
INSERT INTO `shop_access_records` VALUES (3252, 1000035, 1000035, '2020-08-17 10:50:18');
INSERT INTO `shop_access_records` VALUES (3253, 1000035, 1000035, '2020-08-17 10:50:57');
INSERT INTO `shop_access_records` VALUES (3254, 1000006, 1000013, '2020-08-17 10:51:31');
INSERT INTO `shop_access_records` VALUES (3255, 1000035, 1000035, '2020-08-17 10:51:59');
INSERT INTO `shop_access_records` VALUES (3256, 1000035, 1000035, '2020-08-17 10:52:29');
INSERT INTO `shop_access_records` VALUES (3257, 1000035, 1000035, '2020-08-17 10:54:27');
INSERT INTO `shop_access_records` VALUES (3258, 1000006, 1000013, '2020-08-17 10:58:43');
INSERT INTO `shop_access_records` VALUES (3259, 1000084, 1000084, '2020-08-17 10:59:13');
INSERT INTO `shop_access_records` VALUES (3260, 1000013, 1000013, '2020-08-17 12:08:12');
INSERT INTO `shop_access_records` VALUES (3261, 1000008, 1000008, '2020-08-17 16:43:46');
INSERT INTO `shop_access_records` VALUES (3262, 1000035, 1000035, '2020-08-17 18:29:15');
INSERT INTO `shop_access_records` VALUES (3263, 1000013, 1000013, '2020-08-17 18:34:29');
INSERT INTO `shop_access_records` VALUES (3264, 1000013, 1000013, '2020-08-17 18:34:48');
INSERT INTO `shop_access_records` VALUES (3265, 1000085, 1000084, '2020-08-17 19:19:18');
INSERT INTO `shop_access_records` VALUES (3266, 1000017, 1000017, '2020-08-18 05:26:02');
INSERT INTO `shop_access_records` VALUES (3267, 1000035, 1000035, '2020-08-18 09:18:52');
INSERT INTO `shop_access_records` VALUES (3268, 1000013, 1000013, '2020-08-18 10:13:05');
INSERT INTO `shop_access_records` VALUES (3269, 1000017, 1000017, '2020-08-18 10:16:15');
INSERT INTO `shop_access_records` VALUES (3270, 1000013, 1000013, '2020-08-18 10:17:06');
INSERT INTO `shop_access_records` VALUES (3271, 1000084, 1000084, '2020-08-18 10:18:04');
INSERT INTO `shop_access_records` VALUES (3272, 1000084, 1000084, '2020-08-18 10:22:58');
INSERT INTO `shop_access_records` VALUES (3273, 1000084, 1000084, '2020-08-18 10:23:34');
INSERT INTO `shop_access_records` VALUES (3274, 1000084, 1000084, '2020-08-18 10:35:12');
INSERT INTO `shop_access_records` VALUES (3275, 1000035, 1000035, '2020-08-18 10:42:38');
INSERT INTO `shop_access_records` VALUES (3276, 1000013, 1000013, '2020-08-18 10:44:20');
INSERT INTO `shop_access_records` VALUES (3277, 1000013, 1000013, '2020-08-18 10:46:50');
INSERT INTO `shop_access_records` VALUES (3278, 1000013, 1000013, '2020-08-18 10:48:14');
INSERT INTO `shop_access_records` VALUES (3279, 1000013, 1000013, '2020-08-18 10:50:27');
INSERT INTO `shop_access_records` VALUES (3280, 1000006, 1000013, '2020-08-18 10:53:16');
INSERT INTO `shop_access_records` VALUES (3281, 1000006, 1000013, '2020-08-18 10:53:25');
INSERT INTO `shop_access_records` VALUES (3282, 1000013, 1000013, '2020-08-18 10:53:55');
INSERT INTO `shop_access_records` VALUES (3283, 1000006, 1000013, '2020-08-18 10:53:56');
INSERT INTO `shop_access_records` VALUES (3284, 1000013, 1000013, '2020-08-18 10:54:25');
INSERT INTO `shop_access_records` VALUES (3285, 1000013, 1000013, '2020-08-18 10:55:06');
INSERT INTO `shop_access_records` VALUES (3286, 1000006, 1000013, '2020-08-18 10:55:34');
INSERT INTO `shop_access_records` VALUES (3287, 1000006, 1000013, '2020-08-18 10:55:50');
INSERT INTO `shop_access_records` VALUES (3288, 1000006, 1000013, '2020-08-18 10:56:24');
INSERT INTO `shop_access_records` VALUES (3289, 1000013, 1000013, '2020-08-18 10:57:02');
INSERT INTO `shop_access_records` VALUES (3290, 1000006, 1000013, '2020-08-18 11:01:21');
INSERT INTO `shop_access_records` VALUES (3291, 1000006, 1000013, '2020-08-18 11:02:02');
INSERT INTO `shop_access_records` VALUES (3292, 1000006, 1000013, '2020-08-18 11:02:29');
INSERT INTO `shop_access_records` VALUES (3293, 1000017, 1000017, '2020-08-18 11:06:08');
INSERT INTO `shop_access_records` VALUES (3294, 1000013, 1000013, '2020-08-18 11:20:53');
INSERT INTO `shop_access_records` VALUES (3295, 1000013, 1000013, '2020-08-18 11:44:00');
INSERT INTO `shop_access_records` VALUES (3296, 1000013, 1000013, '2020-08-18 11:44:53');
INSERT INTO `shop_access_records` VALUES (3297, 1000013, 1000013, '2020-08-18 11:45:46');
INSERT INTO `shop_access_records` VALUES (3298, 1000145, 1000013, '2020-08-18 11:52:57');
INSERT INTO `shop_access_records` VALUES (3299, 1000145, 1000013, '2020-08-18 11:53:17');
INSERT INTO `shop_access_records` VALUES (3300, 1000013, 1000013, '2020-08-18 11:58:05');
INSERT INTO `shop_access_records` VALUES (3301, 1000013, 1000013, '2020-08-18 11:58:46');
INSERT INTO `shop_access_records` VALUES (3302, 1000146, 1000013, '2020-08-18 12:00:23');
INSERT INTO `shop_access_records` VALUES (3303, 1000145, 1000013, '2020-08-18 12:02:18');
INSERT INTO `shop_access_records` VALUES (3304, 1000146, 1000013, '2020-08-18 12:02:42');
INSERT INTO `shop_access_records` VALUES (3305, 1000035, 1000017, '2020-08-18 14:36:50');
INSERT INTO `shop_access_records` VALUES (3306, 1000035, 1000099, '2020-08-18 14:37:20');
INSERT INTO `shop_access_records` VALUES (3307, 1000013, 1000013, '2020-08-18 15:36:38');
INSERT INTO `shop_access_records` VALUES (3308, 1000013, 1000013, '2020-08-18 15:42:29');
INSERT INTO `shop_access_records` VALUES (3309, 1000013, 1000013, '2020-08-18 15:44:47');
INSERT INTO `shop_access_records` VALUES (3310, 1000084, 1000084, '2020-08-18 16:27:45');
INSERT INTO `shop_access_records` VALUES (3311, 1000084, 1000084, '2020-08-18 16:30:30');
INSERT INTO `shop_access_records` VALUES (3312, 1000084, 1000084, '2020-08-18 16:31:39');
INSERT INTO `shop_access_records` VALUES (3313, 1000084, 1000084, '2020-08-18 16:34:05');
INSERT INTO `shop_access_records` VALUES (3314, 1000084, 1000084, '2020-08-18 16:35:08');
INSERT INTO `shop_access_records` VALUES (3315, 1000084, 1000084, '2020-08-18 16:37:02');
INSERT INTO `shop_access_records` VALUES (3316, 1000084, 1000084, '2020-08-18 16:37:47');
INSERT INTO `shop_access_records` VALUES (3317, 1000084, 1000084, '2020-08-18 16:41:53');
INSERT INTO `shop_access_records` VALUES (3318, 1000006, 1000013, '2020-08-18 16:43:47');
INSERT INTO `shop_access_records` VALUES (3319, 1000013, 1000013, '2020-08-18 17:04:31');
INSERT INTO `shop_access_records` VALUES (3320, 1000013, 1000013, '2020-08-18 17:05:33');
INSERT INTO `shop_access_records` VALUES (3321, 1000017, 1000017, '2020-08-18 17:21:54');
INSERT INTO `shop_access_records` VALUES (3322, 1000017, 1000017, '2020-08-18 17:22:15');
INSERT INTO `shop_access_records` VALUES (3323, 1000001, 1000017, '2020-08-18 17:28:47');
INSERT INTO `shop_access_records` VALUES (3324, 1000075, 1000017, '2020-08-18 17:29:01');
INSERT INTO `shop_access_records` VALUES (3325, 1000027, 1000017, '2020-08-18 17:31:07');
INSERT INTO `shop_access_records` VALUES (3326, 1000017, 1000017, '2020-08-18 17:34:29');
INSERT INTO `shop_access_records` VALUES (3327, 1000084, 1000084, '2020-08-18 17:34:33');
INSERT INTO `shop_access_records` VALUES (3328, 1000035, 1000017, '2020-08-18 17:34:58');
INSERT INTO `shop_access_records` VALUES (3329, 1000027, 1000017, '2020-08-18 17:35:08');
INSERT INTO `shop_access_records` VALUES (3330, 1000095, 1000017, '2020-08-18 17:35:26');
INSERT INTO `shop_access_records` VALUES (3331, 1000017, 1000017, '2020-08-18 17:35:40');
INSERT INTO `shop_access_records` VALUES (3332, 1000075, 1000017, '2020-08-18 17:36:45');
INSERT INTO `shop_access_records` VALUES (3333, 1000035, 1000017, '2020-08-18 17:37:20');
INSERT INTO `shop_access_records` VALUES (3334, 1000035, 1000017, '2020-08-18 17:37:27');
INSERT INTO `shop_access_records` VALUES (3335, 1000006, 1000013, '2020-08-18 17:37:29');
INSERT INTO `shop_access_records` VALUES (3336, 1000006, 1000013, '2020-08-18 17:37:38');
INSERT INTO `shop_access_records` VALUES (3337, 1000095, 1000017, '2020-08-18 17:38:27');
INSERT INTO `shop_access_records` VALUES (3338, 1000147, 1000017, '2020-08-18 17:42:06');
INSERT INTO `shop_access_records` VALUES (3339, 1000035, 1000017, '2020-08-18 17:44:55');
INSERT INTO `shop_access_records` VALUES (3340, 1000094, 1000017, '2020-08-18 17:46:25');
INSERT INTO `shop_access_records` VALUES (3341, 1000148, 1000017, '2020-08-18 17:52:38');
INSERT INTO `shop_access_records` VALUES (3342, 1000148, 1000017, '2020-08-18 17:57:21');
INSERT INTO `shop_access_records` VALUES (3343, 1000148, 1000017, '2020-08-18 17:59:33');
INSERT INTO `shop_access_records` VALUES (3344, 1000017, 1000106, '2020-08-18 17:59:34');
INSERT INTO `shop_access_records` VALUES (3345, 1000017, 1000106, '2020-08-18 18:01:09');
INSERT INTO `shop_access_records` VALUES (3346, 1000017, 1000017, '2020-08-18 18:01:25');
INSERT INTO `shop_access_records` VALUES (3347, 1000017, 1000017, '2020-08-18 18:03:13');
INSERT INTO `shop_access_records` VALUES (3348, 1000001, 1000017, '2020-08-18 18:03:42');
INSERT INTO `shop_access_records` VALUES (3349, 1000106, 1000106, '2020-08-18 18:03:48');
INSERT INTO `shop_access_records` VALUES (3350, 1000095, 1000095, '2020-08-18 18:04:53');
INSERT INTO `shop_access_records` VALUES (3351, 1000001, 1000065, '2020-08-18 18:04:55');
INSERT INTO `shop_access_records` VALUES (3352, 1000092, 1000017, '2020-08-18 18:05:12');
INSERT INTO `shop_access_records` VALUES (3353, 1000149, 1000017, '2020-08-18 18:06:53');
INSERT INTO `shop_access_records` VALUES (3354, 1000149, 1000017, '2020-08-18 18:08:39');
INSERT INTO `shop_access_records` VALUES (3355, 1000148, 1000017, '2020-08-18 18:08:41');
INSERT INTO `shop_access_records` VALUES (3356, 1000000, 1000084, '2020-08-18 18:08:50');
INSERT INTO `shop_access_records` VALUES (3357, 1000000, 1000017, '2020-08-18 18:09:02');
INSERT INTO `shop_access_records` VALUES (3358, 1000008, 1000008, '2020-08-18 18:09:15');
INSERT INTO `shop_access_records` VALUES (3359, 1000035, 1000017, '2020-08-18 18:09:23');
INSERT INTO `shop_access_records` VALUES (3360, 1000035, 1000035, '2020-08-18 18:09:30');
INSERT INTO `shop_access_records` VALUES (3361, 1000008, 1000008, '2020-08-18 18:11:24');
INSERT INTO `shop_access_records` VALUES (3362, 1000095, 1000095, '2020-08-18 18:13:24');
INSERT INTO `shop_access_records` VALUES (3363, 1000048, 1000017, '2020-08-18 18:14:15');
INSERT INTO `shop_access_records` VALUES (3364, 1000095, 1000095, '2020-08-18 18:15:35');
INSERT INTO `shop_access_records` VALUES (3365, 1000064, 1000017, '2020-08-18 18:16:02');
INSERT INTO `shop_access_records` VALUES (3366, 1000016, 1000017, '2020-08-18 18:16:17');
INSERT INTO `shop_access_records` VALUES (3367, 1000017, 1000017, '2020-08-18 18:18:01');
INSERT INTO `shop_access_records` VALUES (3368, 1000098, 1000017, '2020-08-18 18:22:27');
INSERT INTO `shop_access_records` VALUES (3369, 1000017, 1000106, '2020-08-18 18:23:20');
INSERT INTO `shop_access_records` VALUES (3370, 1000044, 1000017, '2020-08-18 18:23:33');
INSERT INTO `shop_access_records` VALUES (3371, 1000017, 1000017, '2020-08-18 18:23:36');
INSERT INTO `shop_access_records` VALUES (3372, 1000017, 1000017, '2020-08-18 18:25:06');
INSERT INTO `shop_access_records` VALUES (3373, 1000013, 1000013, '2020-08-18 18:27:56');
INSERT INTO `shop_access_records` VALUES (3374, 1000017, 1000017, '2020-08-18 18:30:34');
INSERT INTO `shop_access_records` VALUES (3375, 1000085, 1000084, '2020-08-18 18:34:02');
INSERT INTO `shop_access_records` VALUES (3376, 1000017, 1000017, '2020-08-18 18:39:30');
INSERT INTO `shop_access_records` VALUES (3377, 1000017, 1000017, '2020-08-18 18:39:57');
INSERT INTO `shop_access_records` VALUES (3378, 1000017, 1000017, '2020-08-18 18:40:05');
INSERT INTO `shop_access_records` VALUES (3379, 1000106, 1000106, '2020-08-18 18:43:01');
INSERT INTO `shop_access_records` VALUES (3380, 1000148, 1000017, '2020-08-18 18:48:06');
INSERT INTO `shop_access_records` VALUES (3381, 1000148, 1000148, '2020-08-18 18:48:19');
INSERT INTO `shop_access_records` VALUES (3382, 1000085, 1000084, '2020-08-18 18:49:11');
INSERT INTO `shop_access_records` VALUES (3383, 1000035, 1000035, '2020-08-18 18:49:27');
INSERT INTO `shop_access_records` VALUES (3384, 1000085, 1000084, '2020-08-18 18:49:59');
INSERT INTO `shop_access_records` VALUES (3385, 1000064, 1000017, '2020-08-18 18:58:49');
INSERT INTO `shop_access_records` VALUES (3386, 1000035, 1000017, '2020-08-18 19:01:31');
INSERT INTO `shop_access_records` VALUES (3387, 1000017, 1000017, '2020-08-18 19:02:50');
INSERT INTO `shop_access_records` VALUES (3388, 1000064, 1000017, '2020-08-18 19:03:21');
INSERT INTO `shop_access_records` VALUES (3389, 1000017, 1000017, '2020-08-18 19:04:41');
INSERT INTO `shop_access_records` VALUES (3390, 1000017, 1000017, '2020-08-18 19:04:52');
INSERT INTO `shop_access_records` VALUES (3391, 1000017, 1000017, '2020-08-18 19:04:57');
INSERT INTO `shop_access_records` VALUES (3392, 1000054, 1000017, '2020-08-18 19:06:24');
INSERT INTO `shop_access_records` VALUES (3393, 1000012, 1000017, '2020-08-18 19:12:27');
INSERT INTO `shop_access_records` VALUES (3394, 1000044, 1000017, '2020-08-18 19:15:37');
INSERT INTO `shop_access_records` VALUES (3395, 1000064, 1000017, '2020-08-18 19:16:40');
INSERT INTO `shop_access_records` VALUES (3396, 1000054, 1000017, '2020-08-18 19:23:39');
INSERT INTO `shop_access_records` VALUES (3397, 1000057, 1000017, '2020-08-18 19:54:47');
INSERT INTO `shop_access_records` VALUES (3398, 1000150, 1000017, '2020-08-18 20:17:27');
INSERT INTO `shop_access_records` VALUES (3399, 1000122, 1000084, '2020-08-18 21:05:21');
INSERT INTO `shop_access_records` VALUES (3400, 1000060, 1000060, '2020-08-18 21:08:45');
INSERT INTO `shop_access_records` VALUES (3401, 1000151, 1000060, '2020-08-18 21:09:20');
INSERT INTO `shop_access_records` VALUES (3402, 1000106, 1000106, '2020-08-18 21:10:50');
INSERT INTO `shop_access_records` VALUES (3403, 1000060, 1000060, '2020-08-18 21:44:47');
INSERT INTO `shop_access_records` VALUES (3404, 1000152, 1000017, '2020-08-18 23:53:41');
INSERT INTO `shop_access_records` VALUES (3405, 1000095, 1000095, '2020-08-19 07:56:30');
INSERT INTO `shop_access_records` VALUES (3406, 1000017, 1000017, '2020-08-19 10:03:10');
INSERT INTO `shop_access_records` VALUES (3407, 1000008, 1000008, '2020-08-19 10:10:09');
INSERT INTO `shop_access_records` VALUES (3408, 1000084, 1000084, '2020-08-19 10:11:02');
INSERT INTO `shop_access_records` VALUES (3409, 1000095, 1000095, '2020-08-19 10:32:15');
INSERT INTO `shop_access_records` VALUES (3410, 1000095, 1000095, '2020-08-19 10:33:41');
INSERT INTO `shop_access_records` VALUES (3411, 1000025, 1000084, '2020-08-19 10:39:45');
INSERT INTO `shop_access_records` VALUES (3412, 1000008, 1000008, '2020-08-19 10:41:51');
INSERT INTO `shop_access_records` VALUES (3413, 1000008, 1000017, '2020-08-19 10:41:55');
INSERT INTO `shop_access_records` VALUES (3414, 1000035, 1000035, '2020-08-19 10:46:53');
INSERT INTO `shop_access_records` VALUES (3415, 1000035, 1000035, '2020-08-19 11:18:00');
INSERT INTO `shop_access_records` VALUES (3416, 1000017, 1000017, '2020-08-19 11:37:13');
INSERT INTO `shop_access_records` VALUES (3417, 1000095, 1000095, '2020-08-19 12:05:06');
INSERT INTO `shop_access_records` VALUES (3418, 1000017, 1000017, '2020-08-19 12:22:27');
INSERT INTO `shop_access_records` VALUES (3419, 1000060, 1000060, '2020-08-19 13:09:59');
INSERT INTO `shop_access_records` VALUES (3420, 1000060, 1000060, '2020-08-19 13:32:35');
INSERT INTO `shop_access_records` VALUES (3421, 1000060, 1000060, '2020-08-19 13:33:49');
INSERT INTO `shop_access_records` VALUES (3422, 1000153, 1000084, '2020-08-19 13:34:32');
INSERT INTO `shop_access_records` VALUES (3423, 1000035, 1000035, '2020-08-19 17:12:56');
INSERT INTO `shop_access_records` VALUES (3424, 1000017, 1000017, '2020-08-19 17:13:26');
INSERT INTO `shop_access_records` VALUES (3425, 1000017, 1000017, '2020-08-19 17:42:20');
INSERT INTO `shop_access_records` VALUES (3426, 1000013, 1000013, '2020-08-19 17:54:29');
INSERT INTO `shop_access_records` VALUES (3427, 1000017, 1000017, '2020-08-19 18:03:24');
INSERT INTO `shop_access_records` VALUES (3428, 1000017, 1000017, '2020-08-19 20:07:02');
INSERT INTO `shop_access_records` VALUES (3429, 1000006, 1000013, '2020-08-19 23:45:02');
INSERT INTO `shop_access_records` VALUES (3430, 1000006, 1000013, '2020-08-19 23:45:10');
INSERT INTO `shop_access_records` VALUES (3431, 1000006, 1000013, '2020-08-19 23:45:14');
INSERT INTO `shop_access_records` VALUES (3432, 1000006, 1000013, '2020-08-19 23:45:17');
INSERT INTO `shop_access_records` VALUES (3433, 1000085, 1000084, '2020-08-19 23:48:19');
INSERT INTO `shop_access_records` VALUES (3434, 1000013, 1000013, '2020-08-20 09:39:32');
INSERT INTO `shop_access_records` VALUES (3435, 1000035, 1000035, '2020-08-20 09:42:24');
INSERT INTO `shop_access_records` VALUES (3436, 1000035, 1000035, '2020-08-20 10:37:42');
INSERT INTO `shop_access_records` VALUES (3437, 1000154, 1000084, '2020-08-20 11:58:02');
INSERT INTO `shop_access_records` VALUES (3438, 1000008, 1000008, '2020-08-20 12:02:41');
INSERT INTO `shop_access_records` VALUES (3439, 1000035, 1000035, '2020-08-20 12:04:07');
INSERT INTO `shop_access_records` VALUES (3440, 1000013, 1000013, '2020-08-20 12:05:24');
INSERT INTO `shop_access_records` VALUES (3441, 1000013, 1000017, '2020-08-20 12:05:31');
INSERT INTO `shop_access_records` VALUES (3442, 1000154, 1000017, '2020-08-20 12:06:02');
INSERT INTO `shop_access_records` VALUES (3443, 1000095, 1000095, '2020-08-20 13:04:56');
INSERT INTO `shop_access_records` VALUES (3444, 1000017, 1000017, '2020-08-20 14:08:52');
INSERT INTO `shop_access_records` VALUES (3445, 1000106, 1000106, '2020-08-20 14:11:59');
INSERT INTO `shop_access_records` VALUES (3446, 1000017, 1000017, '2020-08-20 14:43:05');
INSERT INTO `shop_access_records` VALUES (3447, 1000035, 1000035, '2020-08-20 15:08:23');
INSERT INTO `shop_access_records` VALUES (3448, 1000035, 1000035, '2020-08-20 15:10:03');
INSERT INTO `shop_access_records` VALUES (3449, 1000035, 1000035, '2020-08-20 15:10:22');
INSERT INTO `shop_access_records` VALUES (3450, 1000035, 1000035, '2020-08-20 15:13:07');
INSERT INTO `shop_access_records` VALUES (3451, 1000035, 1000035, '2020-08-20 15:15:17');
INSERT INTO `shop_access_records` VALUES (3452, 1000035, 1000035, '2020-08-20 15:15:59');
INSERT INTO `shop_access_records` VALUES (3453, 1000035, 1000035, '2020-08-20 15:27:05');
INSERT INTO `shop_access_records` VALUES (3454, 1000035, 1000035, '2020-08-20 15:27:39');
INSERT INTO `shop_access_records` VALUES (3455, 1000035, 1000035, '2020-08-20 15:28:51');
INSERT INTO `shop_access_records` VALUES (3456, 1000035, 1000035, '2020-08-20 15:28:56');
INSERT INTO `shop_access_records` VALUES (3457, 1000035, 1000035, '2020-08-20 15:29:46');
INSERT INTO `shop_access_records` VALUES (3458, 1000035, 1000035, '2020-08-20 15:30:56');
INSERT INTO `shop_access_records` VALUES (3459, 1000035, 1000035, '2020-08-20 15:32:00');
INSERT INTO `shop_access_records` VALUES (3460, 1000035, 1000035, '2020-08-20 15:33:01');
INSERT INTO `shop_access_records` VALUES (3461, 1000035, 1000035, '2020-08-20 15:34:04');
INSERT INTO `shop_access_records` VALUES (3462, 1000035, 1000035, '2020-08-20 15:35:40');
INSERT INTO `shop_access_records` VALUES (3463, 1000035, 1000035, '2020-08-20 15:36:07');
INSERT INTO `shop_access_records` VALUES (3464, 1000035, 1000035, '2020-08-20 15:36:34');
INSERT INTO `shop_access_records` VALUES (3465, 1000035, 1000035, '2020-08-20 15:41:04');
INSERT INTO `shop_access_records` VALUES (3466, 1000035, 1000035, '2020-08-20 15:41:36');
INSERT INTO `shop_access_records` VALUES (3467, 1000035, 1000035, '2020-08-20 15:45:13');
INSERT INTO `shop_access_records` VALUES (3468, 1000035, 1000035, '2020-08-20 15:48:26');
INSERT INTO `shop_access_records` VALUES (3469, 1000035, 1000035, '2020-08-20 15:58:56');
INSERT INTO `shop_access_records` VALUES (3470, 1000000, 1000017, '2020-08-20 16:05:26');
INSERT INTO `shop_access_records` VALUES (3471, 1000000, 1000017, '2020-08-20 16:06:03');
INSERT INTO `shop_access_records` VALUES (3472, 1000035, 1000035, '2020-08-20 16:22:30');
INSERT INTO `shop_access_records` VALUES (3473, 1000035, 1000035, '2020-08-20 16:28:50');
INSERT INTO `shop_access_records` VALUES (3474, 1000013, 1000013, '2020-08-20 17:34:24');
INSERT INTO `shop_access_records` VALUES (3475, 1000013, 1000013, '2020-08-20 19:29:49');
INSERT INTO `shop_access_records` VALUES (3476, 1000017, 1000017, '2020-08-20 20:49:28');
INSERT INTO `shop_access_records` VALUES (3477, 1000095, 1000095, '2020-08-20 21:06:43');
INSERT INTO `shop_access_records` VALUES (3478, 1000022, 1000017, '2020-08-20 21:14:28');
INSERT INTO `shop_access_records` VALUES (3479, 1000017, 1000017, '2020-08-20 21:14:38');
INSERT INTO `shop_access_records` VALUES (3480, 1000017, 1000017, '2020-08-20 21:14:42');
INSERT INTO `shop_access_records` VALUES (3481, 1000017, 1000017, '2020-08-20 21:14:52');
INSERT INTO `shop_access_records` VALUES (3482, 1000035, 1000017, '2020-08-20 21:15:07');
INSERT INTO `shop_access_records` VALUES (3483, 1000013, 1000017, '2020-08-20 21:15:20');
INSERT INTO `shop_access_records` VALUES (3484, 1000095, 1000017, '2020-08-20 21:15:51');
INSERT INTO `shop_access_records` VALUES (3485, 1000001, 1000017, '2020-08-20 21:17:25');
INSERT INTO `shop_access_records` VALUES (3486, 1000006, 1000017, '2020-08-20 21:17:29');
INSERT INTO `shop_access_records` VALUES (3487, 1000006, 1000017, '2020-08-20 21:17:33');
INSERT INTO `shop_access_records` VALUES (3488, 1000148, 1000017, '2020-08-20 21:17:53');
INSERT INTO `shop_access_records` VALUES (3489, 1000001, 1000017, '2020-08-20 21:17:54');
INSERT INTO `shop_access_records` VALUES (3490, 1000148, 1000017, '2020-08-20 21:19:05');
INSERT INTO `shop_access_records` VALUES (3491, 1000152, 1000017, '2020-08-20 21:24:17');
INSERT INTO `shop_access_records` VALUES (3492, 1000057, 1000017, '2020-08-20 21:47:29');
INSERT INTO `shop_access_records` VALUES (3493, 1000118, 1000017, '2020-08-20 22:04:42');
INSERT INTO `shop_access_records` VALUES (3494, 1000116, 1000017, '2020-08-20 22:08:51');
INSERT INTO `shop_access_records` VALUES (3495, 1000057, 1000017, '2020-08-20 22:15:58');
INSERT INTO `shop_access_records` VALUES (3496, 1000154, 1000017, '2020-08-20 22:16:37');
INSERT INTO `shop_access_records` VALUES (3497, 1000154, 1000017, '2020-08-20 22:17:17');
INSERT INTO `shop_access_records` VALUES (3498, 1000157, 1000017, '2020-08-20 22:17:27');
INSERT INTO `shop_access_records` VALUES (3499, 1000017, 1000017, '2020-08-20 22:17:53');
INSERT INTO `shop_access_records` VALUES (3500, 1000092, 1000017, '2020-08-20 22:17:58');
INSERT INTO `shop_access_records` VALUES (3501, 1000157, 1000017, '2020-08-20 22:18:00');
INSERT INTO `shop_access_records` VALUES (3502, 1000154, 1000017, '2020-08-20 22:18:31');
INSERT INTO `shop_access_records` VALUES (3503, 1000057, 1000017, '2020-08-20 22:18:37');
INSERT INTO `shop_access_records` VALUES (3504, 1000157, 1000017, '2020-08-20 22:19:01');
INSERT INTO `shop_access_records` VALUES (3505, 1000017, 1000017, '2020-08-20 22:19:26');
INSERT INTO `shop_access_records` VALUES (3506, 1000154, 1000017, '2020-08-20 22:19:51');
INSERT INTO `shop_access_records` VALUES (3507, 1000035, 1000017, '2020-08-20 22:20:44');
INSERT INTO `shop_access_records` VALUES (3508, 1000157, 1000017, '2020-08-20 22:20:45');
INSERT INTO `shop_access_records` VALUES (3509, 1000154, 1000017, '2020-08-20 22:21:09');
INSERT INTO `shop_access_records` VALUES (3510, 1000057, 1000017, '2020-08-20 22:22:36');
INSERT INTO `shop_access_records` VALUES (3511, 1000157, 1000017, '2020-08-20 22:23:37');
INSERT INTO `shop_access_records` VALUES (3512, 1000154, 1000017, '2020-08-20 22:23:39');
INSERT INTO `shop_access_records` VALUES (3513, 1000057, 1000017, '2020-08-20 22:23:43');
INSERT INTO `shop_access_records` VALUES (3514, 1000157, 1000017, '2020-08-20 22:23:44');
INSERT INTO `shop_access_records` VALUES (3515, 1000157, 1000017, '2020-08-20 22:23:48');
INSERT INTO `shop_access_records` VALUES (3516, 1000157, 1000017, '2020-08-20 22:24:13');
INSERT INTO `shop_access_records` VALUES (3517, 1000157, 1000017, '2020-08-20 22:24:17');
INSERT INTO `shop_access_records` VALUES (3518, 1000157, 1000017, '2020-08-20 22:24:20');
INSERT INTO `shop_access_records` VALUES (3519, 1000157, 1000017, '2020-08-20 22:24:29');
INSERT INTO `shop_access_records` VALUES (3520, 1000158, 1000017, '2020-08-20 22:24:34');
INSERT INTO `shop_access_records` VALUES (3521, 1000148, 1000017, '2020-08-20 22:26:24');
INSERT INTO `shop_access_records` VALUES (3522, 1000157, 1000017, '2020-08-20 22:26:59');
INSERT INTO `shop_access_records` VALUES (3523, 1000157, 1000017, '2020-08-20 22:27:02');
INSERT INTO `shop_access_records` VALUES (3524, 1000157, 1000017, '2020-08-20 22:27:05');
INSERT INTO `shop_access_records` VALUES (3525, 1000157, 1000017, '2020-08-20 22:27:08');
INSERT INTO `shop_access_records` VALUES (3526, 1000057, 1000017, '2020-08-20 22:28:11');
INSERT INTO `shop_access_records` VALUES (3527, 1000157, 1000017, '2020-08-20 22:28:51');
INSERT INTO `shop_access_records` VALUES (3528, 1000154, 1000017, '2020-08-20 22:29:43');
INSERT INTO `shop_access_records` VALUES (3529, 1000148, 1000148, '2020-08-20 22:29:59');
INSERT INTO `shop_access_records` VALUES (3530, 1000157, 1000017, '2020-08-20 22:32:45');
INSERT INTO `shop_access_records` VALUES (3531, 1000157, 1000017, '2020-08-20 22:32:48');
INSERT INTO `shop_access_records` VALUES (3532, 1000157, 1000017, '2020-08-20 22:32:51');
INSERT INTO `shop_access_records` VALUES (3533, 1000157, 1000017, '2020-08-20 22:32:54');
INSERT INTO `shop_access_records` VALUES (3534, 1000157, 1000017, '2020-08-20 22:33:00');
INSERT INTO `shop_access_records` VALUES (3535, 1000158, 1000017, '2020-08-20 22:35:34');
INSERT INTO `shop_access_records` VALUES (3536, 1000157, 1000017, '2020-08-20 22:36:07');
INSERT INTO `shop_access_records` VALUES (3537, 1000148, 1000148, '2020-08-20 22:37:10');
INSERT INTO `shop_access_records` VALUES (3538, 1000057, 1000017, '2020-08-20 22:39:42');
INSERT INTO `shop_access_records` VALUES (3539, 1000035, 1000017, '2020-08-20 22:40:29');
INSERT INTO `shop_access_records` VALUES (3540, 1000158, 1000017, '2020-08-20 22:51:06');
INSERT INTO `shop_access_records` VALUES (3541, 1000016, 1000017, '2020-08-20 23:08:12');
INSERT INTO `shop_access_records` VALUES (3542, 1000016, 1000016, '2020-08-20 23:08:21');
INSERT INTO `shop_access_records` VALUES (3543, 1000016, 1000017, '2020-08-20 23:08:39');
INSERT INTO `shop_access_records` VALUES (3544, 1000148, 1000148, '2020-08-20 23:09:38');
INSERT INTO `shop_access_records` VALUES (3545, 1000016, 1000017, '2020-08-20 23:11:26');
INSERT INTO `shop_access_records` VALUES (3546, 1000148, 1000148, '2020-08-20 23:12:45');
INSERT INTO `shop_access_records` VALUES (3547, 1000091, 1000017, '2020-08-20 23:20:05');
INSERT INTO `shop_access_records` VALUES (3548, 1000148, 1000148, '2020-08-20 23:26:08');
INSERT INTO `shop_access_records` VALUES (3549, 1000148, 1000148, '2020-08-20 23:28:17');
INSERT INTO `shop_access_records` VALUES (3550, 1000001, 1000017, '2020-08-20 23:31:57');
INSERT INTO `shop_access_records` VALUES (3551, 1000148, 1000148, '2020-08-20 23:32:41');
INSERT INTO `shop_access_records` VALUES (3552, 1000148, 1000148, '2020-08-20 23:36:15');
INSERT INTO `shop_access_records` VALUES (3553, 1000054, 1000017, '2020-08-20 23:45:53');
INSERT INTO `shop_access_records` VALUES (3554, 1000148, 1000148, '2020-08-20 23:54:42');
INSERT INTO `shop_access_records` VALUES (3555, 1000148, 1000148, '2020-08-20 23:57:39');
INSERT INTO `shop_access_records` VALUES (3556, 1000159, 1000148, '2020-08-21 06:23:34');
INSERT INTO `shop_access_records` VALUES (3557, 1000160, 1000017, '2020-08-21 08:20:11');
INSERT INTO `shop_access_records` VALUES (3558, 1000160, 1000017, '2020-08-21 08:52:10');
INSERT INTO `shop_access_records` VALUES (3559, 1000154, 1000017, '2020-08-21 09:05:26');
INSERT INTO `shop_access_records` VALUES (3560, 1000017, 1000017, '2020-08-21 09:21:28');
INSERT INTO `shop_access_records` VALUES (3561, 1000017, 1000017, '2020-08-21 11:03:55');
INSERT INTO `shop_access_records` VALUES (3562, 1000154, 1000017, '2020-08-21 11:09:46');
INSERT INTO `shop_access_records` VALUES (3563, 1000054, 1000017, '2020-08-21 11:34:03');
INSERT INTO `shop_access_records` VALUES (3564, 1000054, 1000017, '2020-08-21 13:55:31');
INSERT INTO `shop_access_records` VALUES (3565, 1000017, 1000017, '2020-08-21 14:18:07');
INSERT INTO `shop_access_records` VALUES (3566, 1000017, 1000106, '2020-08-21 14:18:34');
INSERT INTO `shop_access_records` VALUES (3567, 1000017, 1000017, '2020-08-21 14:19:52');
INSERT INTO `shop_access_records` VALUES (3568, 1000054, 1000017, '2020-08-21 14:20:28');
INSERT INTO `shop_access_records` VALUES (3569, 1000106, 1000106, '2020-08-21 14:22:46');
INSERT INTO `shop_access_records` VALUES (3570, 1000095, 1000095, '2020-08-21 14:46:23');
INSERT INTO `shop_access_records` VALUES (3571, 1000085, 1000084, '2020-08-21 14:47:12');
INSERT INTO `shop_access_records` VALUES (3572, 1000013, 1000013, '2020-08-21 15:15:34');
INSERT INTO `shop_access_records` VALUES (3573, 1000017, 1000017, '2020-08-21 17:11:45');
INSERT INTO `shop_access_records` VALUES (3574, 1000161, 1000148, '2020-08-21 18:16:02');
INSERT INTO `shop_access_records` VALUES (3575, 1000161, 1000148, '2020-08-21 18:16:17');
INSERT INTO `shop_access_records` VALUES (3576, 1000035, 1000035, '2020-08-21 18:38:34');
INSERT INTO `shop_access_records` VALUES (3577, 1000017, 1000017, '2020-08-21 18:57:43');
INSERT INTO `shop_access_records` VALUES (3578, 1000054, 1000017, '2020-08-21 19:36:44');
INSERT INTO `shop_access_records` VALUES (3579, 1000017, 1000017, '2020-08-21 20:50:45');
INSERT INTO `shop_access_records` VALUES (3580, 1000106, 1000106, '2020-08-21 20:54:42');
INSERT INTO `shop_access_records` VALUES (3581, 1000017, 1000017, '2020-08-21 21:28:43');
INSERT INTO `shop_access_records` VALUES (3582, 1000017, 1000017, '2020-08-22 10:13:54');
INSERT INTO `shop_access_records` VALUES (3583, 1000054, 1000017, '2020-08-22 13:58:32');
INSERT INTO `shop_access_records` VALUES (3584, 1000154, 1000017, '2020-08-22 15:41:30');
INSERT INTO `shop_access_records` VALUES (3585, 1000095, 1000095, '2020-08-22 20:06:06');
INSERT INTO `shop_access_records` VALUES (3586, 1000017, 1000017, '2020-08-22 20:10:13');
INSERT INTO `shop_access_records` VALUES (3587, 1000106, 1000106, '2020-08-22 20:12:35');
INSERT INTO `shop_access_records` VALUES (3588, 1000106, 1000106, '2020-08-22 20:48:07');
INSERT INTO `shop_access_records` VALUES (3589, 1000017, 1000017, '2020-08-22 21:42:13');
INSERT INTO `shop_access_records` VALUES (3590, 1000016, 1000016, '2020-08-22 21:55:04');
INSERT INTO `shop_access_records` VALUES (3591, 1000035, 1000035, '2020-08-22 21:59:46');
INSERT INTO `shop_access_records` VALUES (3592, 1000035, 1000017, '2020-08-22 21:59:57');
INSERT INTO `shop_access_records` VALUES (3593, 1000148, 1000148, '2020-08-22 22:19:05');
INSERT INTO `shop_access_records` VALUES (3594, 1000148, 1000148, '2020-08-22 22:19:30');
INSERT INTO `shop_access_records` VALUES (3595, 1000054, 1000017, '2020-08-23 09:11:04');
INSERT INTO `shop_access_records` VALUES (3596, 1000018, 1000018, '2020-08-23 09:38:18');
INSERT INTO `shop_access_records` VALUES (3597, 1000017, 1000017, '2020-08-23 12:39:03');
INSERT INTO `shop_access_records` VALUES (3598, 1000017, 1000017, '2020-08-23 16:18:10');
INSERT INTO `shop_access_records` VALUES (3599, 1000154, 1000017, '2020-08-24 10:23:01');
INSERT INTO `shop_access_records` VALUES (3600, 1000163, 1000017, '2020-08-24 10:25:11');
INSERT INTO `shop_access_records` VALUES (3601, 1000164, 1000017, '2020-08-24 10:28:09');
INSERT INTO `shop_access_records` VALUES (3602, 1000163, 1000017, '2020-08-24 10:28:35');
INSERT INTO `shop_access_records` VALUES (3603, 1000017, 1000017, '2020-08-24 10:47:27');
INSERT INTO `shop_access_records` VALUES (3604, 1000154, 1000017, '2020-08-24 11:07:20');
INSERT INTO `shop_access_records` VALUES (3605, 1000054, 1000017, '2020-08-24 11:55:09');
INSERT INTO `shop_access_records` VALUES (3606, 1000165, 1000084, '2020-08-24 14:50:36');
INSERT INTO `shop_access_records` VALUES (3607, 1000024, 1000017, '2020-08-24 23:57:59');
INSERT INTO `shop_access_records` VALUES (3608, 1000085, 1000084, '2020-08-24 23:58:26');
INSERT INTO `shop_access_records` VALUES (3609, 1000024, 1000017, '2020-08-24 23:59:22');
INSERT INTO `shop_access_records` VALUES (3610, 1000084, 1000084, '2020-08-24 23:59:40');
INSERT INTO `shop_access_records` VALUES (3611, 1000084, 1000084, '2020-08-25 00:00:16');
INSERT INTO `shop_access_records` VALUES (3612, 1000024, 1000017, '2020-08-25 00:00:31');
INSERT INTO `shop_access_records` VALUES (3613, 1000084, 1000084, '2020-08-25 00:03:38');
INSERT INTO `shop_access_records` VALUES (3614, 1000017, 1000017, '2020-08-25 12:13:40');
INSERT INTO `shop_access_records` VALUES (3615, 1000166, 1000017, '2020-08-25 12:14:15');
INSERT INTO `shop_access_records` VALUES (3616, 1000017, 1000017, '2020-08-25 12:14:17');
INSERT INTO `shop_access_records` VALUES (3617, 1000166, 1000166, '2020-08-25 12:15:17');
INSERT INTO `shop_access_records` VALUES (3618, 1000166, 1000166, '2020-08-25 12:16:53');
INSERT INTO `shop_access_records` VALUES (3619, 1000166, 1000017, '2020-08-25 12:17:15');
INSERT INTO `shop_access_records` VALUES (3620, 1000166, 1000017, '2020-08-25 15:37:32');
INSERT INTO `shop_access_records` VALUES (3621, 1000001, 1000017, '2020-08-25 16:39:02');
INSERT INTO `shop_access_records` VALUES (3622, 1000035, 1000035, '2020-08-25 18:14:56');
INSERT INTO `shop_access_records` VALUES (3623, 1000012, 1000017, '2020-08-25 21:09:26');
INSERT INTO `shop_access_records` VALUES (3624, 1000017, 1000017, '2020-08-26 09:16:07');
INSERT INTO `shop_access_records` VALUES (3625, 1000068, 1000084, '2020-08-26 11:51:58');
INSERT INTO `shop_access_records` VALUES (3626, 1000001, 1000017, '2020-08-26 17:35:02');
INSERT INTO `shop_access_records` VALUES (3627, 1000084, 1000084, '2020-08-26 17:35:24');
INSERT INTO `shop_access_records` VALUES (3628, 1000084, 1000084, '2020-08-26 17:42:38');
INSERT INTO `shop_access_records` VALUES (3629, 1000008, 1000008, '2020-08-26 18:43:39');
INSERT INTO `shop_access_records` VALUES (3630, 1000017, 1000017, '2020-08-26 21:32:50');
INSERT INTO `shop_access_records` VALUES (3631, 1000017, 1000017, '2020-08-26 22:42:14');
INSERT INTO `shop_access_records` VALUES (3632, 1000024, 1000017, '2020-08-27 00:01:55');
INSERT INTO `shop_access_records` VALUES (3633, 1000024, 1000017, '2020-08-27 00:02:17');
INSERT INTO `shop_access_records` VALUES (3634, 1000168, 1000017, '2020-08-27 00:02:17');
INSERT INTO `shop_access_records` VALUES (3635, 1000024, 1000017, '2020-08-27 00:03:29');
INSERT INTO `shop_access_records` VALUES (3636, 1000024, 1000017, '2020-08-27 00:05:25');
INSERT INTO `shop_access_records` VALUES (3637, 1000024, 1000017, '2020-08-27 00:07:06');
INSERT INTO `shop_access_records` VALUES (3638, 1000017, 1000017, '2020-08-28 00:35:27');
INSERT INTO `shop_access_records` VALUES (3639, 1000024, 1000017, '2020-08-28 10:52:27');
INSERT INTO `shop_access_records` VALUES (3640, 1000017, 1000017, '2020-08-28 10:53:54');
INSERT INTO `shop_access_records` VALUES (3641, 1000017, 1000017, '2020-08-28 10:58:41');
INSERT INTO `shop_access_records` VALUES (3642, 1000017, 1000017, '2020-08-28 11:01:20');
INSERT INTO `shop_access_records` VALUES (3643, 1000017, 1000017, '2020-08-28 11:14:52');
INSERT INTO `shop_access_records` VALUES (3644, 1000064, 1000017, '2020-08-28 11:25:44');
INSERT INTO `shop_access_records` VALUES (3645, 1000064, 1000017, '2020-08-28 11:31:09');
INSERT INTO `shop_access_records` VALUES (3646, 1000017, 1000017, '2020-08-28 11:32:56');
INSERT INTO `shop_access_records` VALUES (3647, 1000017, 1000017, '2020-08-28 12:05:20');
INSERT INTO `shop_access_records` VALUES (3648, 1000095, 1000095, '2020-08-28 16:48:11');
INSERT INTO `shop_access_records` VALUES (3649, 1000095, 1000017, '2020-08-28 16:48:39');
INSERT INTO `shop_access_records` VALUES (3650, 1000170, 1000084, '2020-08-28 23:03:41');
INSERT INTO `shop_access_records` VALUES (3651, 1000064, 1000017, '2020-08-30 09:58:44');
INSERT INTO `shop_access_records` VALUES (3652, 1000064, 1000017, '2020-08-30 10:01:34');
INSERT INTO `shop_access_records` VALUES (3653, 1000064, 1000017, '2020-08-30 10:02:17');
INSERT INTO `shop_access_records` VALUES (3654, 1000017, 1000017, '2020-08-30 20:52:48');
INSERT INTO `shop_access_records` VALUES (3655, 1000024, 1000017, '2020-08-30 21:22:46');
INSERT INTO `shop_access_records` VALUES (3656, 1000001, 1000017, '2020-08-31 10:43:44');
INSERT INTO `shop_access_records` VALUES (3657, 1000017, 1000017, '2020-08-31 15:59:15');
INSERT INTO `shop_access_records` VALUES (3658, 1000018, 1000018, '2020-08-31 16:03:55');
INSERT INTO `shop_access_records` VALUES (3659, 1000017, 1000017, '2020-08-31 16:06:28');
INSERT INTO `shop_access_records` VALUES (3660, 1000019, 1000018, '2020-08-31 16:08:51');
INSERT INTO `shop_access_records` VALUES (3661, 1000019, 1000017, '2020-08-31 16:08:57');
INSERT INTO `shop_access_records` VALUES (3662, 1000013, 1000013, '2020-08-31 17:46:56');
INSERT INTO `shop_access_records` VALUES (3663, 1000017, 1000017, '2020-08-31 20:38:02');
INSERT INTO `shop_access_records` VALUES (3664, 1000018, 1000018, '2020-08-31 21:08:16');
INSERT INTO `shop_access_records` VALUES (3665, 1000018, 1000018, '2020-08-31 21:08:46');
INSERT INTO `shop_access_records` VALUES (3666, 1000172, 1000172, '2020-08-31 21:09:39');
INSERT INTO `shop_access_records` VALUES (3667, 1000172, 1000172, '2020-08-31 21:10:40');
INSERT INTO `shop_access_records` VALUES (3668, 1000172, 1000172, '2020-08-31 21:16:18');
INSERT INTO `shop_access_records` VALUES (3669, 1000172, 1000172, '2020-08-31 21:19:58');
INSERT INTO `shop_access_records` VALUES (3670, 1000172, 1000172, '2020-08-31 21:35:09');
INSERT INTO `shop_access_records` VALUES (3671, 1000172, 1000172, '2020-08-31 21:39:34');
INSERT INTO `shop_access_records` VALUES (3672, 1000172, 1000172, '2020-08-31 21:39:47');
INSERT INTO `shop_access_records` VALUES (3673, 1000172, 1000172, '2020-08-31 21:59:30');
INSERT INTO `shop_access_records` VALUES (3674, 1000172, 1000172, '2020-08-31 22:01:02');
INSERT INTO `shop_access_records` VALUES (3675, 1000018, 1000018, '2020-08-31 23:41:27');
INSERT INTO `shop_access_records` VALUES (3676, 1000085, 1000084, '2020-08-31 23:41:58');
INSERT INTO `shop_access_records` VALUES (3677, 1000085, 1000084, '2020-08-31 23:42:21');
INSERT INTO `shop_access_records` VALUES (3678, 1000013, 1000013, '2020-09-01 10:11:31');
INSERT INTO `shop_access_records` VALUES (3679, 1000017, 1000017, '2020-09-01 12:21:10');
INSERT INTO `shop_access_records` VALUES (3680, 1000001, 1000017, '2020-09-01 16:34:18');

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
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_category
-- ----------------------------
INSERT INTO `shop_category` VALUES (16, 6, 1000017, '水果', 1, '2020-08-18 09:48:11');
INSERT INTO `shop_category` VALUES (17, 7, 1000017, '蔬果', 2, '2020-08-18 09:48:45');
INSERT INTO `shop_category` VALUES (18, 8, 1000017, '其他', 3, '2020-08-18 09:49:28');
INSERT INTO `shop_category` VALUES (19, 2, 1000018, '护肤', 1, '2020-08-18 09:50:00');
INSERT INTO `shop_category` VALUES (20, 5, 1000022, '美妆', 1, '2020-08-18 09:50:18');
INSERT INTO `shop_category` VALUES (21, 2, 1000022, '护肤', 2, '2020-08-18 09:50:44');
INSERT INTO `shop_category` VALUES (22, 4, 1000022, '服装', 3, '2020-08-18 09:51:00');
INSERT INTO `shop_category` VALUES (23, 5, 1000029, '美妆', 1, '2020-08-18 09:51:49');
INSERT INTO `shop_category` VALUES (24, 2, 1000029, '护肤', 2, '2020-08-18 09:52:02');
INSERT INTO `shop_category` VALUES (25, 1, 1000013, '数码', 1, '2020-08-18 09:52:27');
INSERT INTO `shop_category` VALUES (26, 4, 1000013, '服装', 2, '2020-08-18 09:52:44');
INSERT INTO `shop_category` VALUES (27, 8, 1000013, '其他', 3, '2020-08-18 09:53:01');
INSERT INTO `shop_category` VALUES (28, 5, 1000035, '美妆', 1, '2020-08-18 09:53:20');
INSERT INTO `shop_category` VALUES (29, 3, 1000084, '轻奢', 1, '2020-08-18 09:53:52');
INSERT INTO `shop_category` VALUES (30, 4, 1000099, '服装', 1, '2020-08-18 09:54:26');
INSERT INTO `shop_category` VALUES (31, 2, 1000065, '护肤', 1, '2020-08-18 09:54:47');
INSERT INTO `shop_category` VALUES (32, 6, 1000106, '水果', 1, '2020-08-18 09:55:07');
INSERT INTO `shop_category` VALUES (33, 8, 1000008, '其他', 1, '2020-08-18 09:55:33');
INSERT INTO `shop_category` VALUES (34, 6, 1000008, '水果', 2, '2020-08-18 09:55:47');
INSERT INTO `shop_category` VALUES (35, 7, 1000008, '蔬果', 3, '2020-08-18 09:56:07');
INSERT INTO `shop_category` VALUES (36, 8, 1000095, '其他', 1, '2020-08-19 07:56:39');
INSERT INTO `shop_category` VALUES (37, 8, 1000148, '其他', 1, '2020-08-20 22:37:42');
INSERT INTO `shop_category` VALUES (38, 5, 1000172, '美妆', 1, '2020-08-31 21:36:47');

-- ----------------------------
-- Table structure for shop_code_records
-- ----------------------------
DROP TABLE IF EXISTS `shop_code_records`;
CREATE TABLE `shop_code_records`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺ID(使用此店铺码开通的商店id)',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `bind_shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '生成店铺码的店铺ID',
  `gen_type` int(10) UNSIGNED NOT NULL COMMENT '生成方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '店铺码' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_code_records
-- ----------------------------
INSERT INTO `shop_code_records` VALUES (1, 1000004, '2020-07-31 17:41:04', 0, 0);
INSERT INTO `shop_code_records` VALUES (2, 1000017, '2020-08-01 18:19:55', 0, 0);
INSERT INTO `shop_code_records` VALUES (3, 1000018, '2020-08-01 18:39:44', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (4, 1000020, '2020-08-01 19:03:50', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (5, 1000022, '2020-08-01 19:54:44', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (6, 1000029, '2020-08-03 20:24:58', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (7, 1000030, '2020-08-03 21:36:31', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (8, 1000013, '2020-08-04 18:16:58', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (9, 1000033, '2020-08-05 10:28:09', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (10, 1000034, '2020-08-05 10:49:30', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (11, 1000035, '2020-08-05 11:53:43', 0, 0);
INSERT INTO `shop_code_records` VALUES (12, 1000060, '2020-08-06 11:23:25', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (13, 1000063, '2020-08-06 11:59:39', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (14, 1000082, '2020-08-07 17:03:42', 1000035, 0);
INSERT INTO `shop_code_records` VALUES (15, 1000028, '2020-08-09 21:28:32', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (16, 1000090, '2020-08-10 13:13:55', 1000018, 0);
INSERT INTO `shop_code_records` VALUES (17, 1000095, '2020-08-10 19:29:35', 1000035, 0);
INSERT INTO `shop_code_records` VALUES (18, 1000099, '2020-08-10 21:56:25', 1000013, 0);
INSERT INTO `shop_code_records` VALUES (19, 1000065, '2020-08-10 21:57:50', 1000013, 0);
INSERT INTO `shop_code_records` VALUES (20, 1000106, '2020-08-11 10:02:08', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (21, 1000069, '2020-08-11 11:12:47', 1000013, 0);
INSERT INTO `shop_code_records` VALUES (22, 1000008, '2020-08-11 18:22:03', 1000035, 0);
INSERT INTO `shop_code_records` VALUES (23, 1000016, '2020-08-12 16:33:24', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (24, 1000100, '2020-08-13 21:23:14', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (25, 1000148, '2020-08-18 18:48:16', 1000035, 0);
INSERT INTO `shop_code_records` VALUES (26, 1000166, '2020-08-25 12:15:17', 1000017, 0);
INSERT INTO `shop_code_records` VALUES (27, 1000172, '2020-08-31 21:09:38', 1000018, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_express
-- ----------------------------
INSERT INTO `shop_express` VALUES (1, 1000004, 'SF', '顺丰速运', 1, '123', '456', 10.00, 5.00, 1, '2020-07-31 18:39:12', '2020-07-31 18:39:12', '韩国', NULL);
INSERT INTO `shop_express` VALUES (2, 1000017, 'ZTO', '中通快递', 3, '', '', 0.00, 0.00, 1, '2020-08-01 18:56:07', '2020-08-01 18:56:07', '', NULL);
INSERT INTO `shop_express` VALUES (3, 1000035, 'HTKY', '百世快递', 2, '', '', 0.00, 0.00, 1, '2020-08-05 11:59:44', '2020-08-05 11:59:44', '', NULL);
INSERT INTO `shop_express` VALUES (4, 1000017, 'SF', '顺丰速运', 1, '', '', 0.00, 0.00, 0, '2020-08-05 12:06:12', '2020-08-05 12:06:12', '', NULL);
INSERT INTO `shop_express` VALUES (7, 1000013, 'SF', '顺丰速运', 1, '', '', 1.00, 0.00, 1, '2020-08-06 12:33:13', '2020-08-06 12:33:13', '', NULL);
INSERT INTO `shop_express` VALUES (8, 1000017, 'YTO', '圆通速递', 5, '', '', 0.00, 0.00, 0, '2020-08-06 18:28:58', '2020-08-06 18:28:58', '', NULL);
INSERT INTO `shop_express` VALUES (9, 1000013, 'ZTO', '中通快递', 3, '', '', 0.00, 0.00, 0, '2020-08-07 15:37:02', '2020-08-07 15:37:02', '', NULL);
INSERT INTO `shop_express` VALUES (10, 1000022, 'YTO', '圆通速递', 5, 'lingling.9237@yahoo.com.cn', 'luminling9237', 5.00, 5.00, 1, '2020-08-11 02:26:08', '2020-08-11 02:26:08', '深圳市盐田区沙头角', NULL);
INSERT INTO `shop_express` VALUES (11, 1000008, 'SF', '顺丰速运', 1, 'Shbwjvd', 'Hshsubebd', 20.00, 10.00, 1, '2020-08-11 18:38:08', '2020-08-11 18:38:08', 'Shvx', NULL);
INSERT INTO `shop_express` VALUES (12, 1000106, 'YD', '韵达速递', 6, '', '', 0.00, 0.00, 1, '2020-08-18 18:30:54', '2020-08-18 18:30:54', '', NULL);
INSERT INTO `shop_express` VALUES (13, 1000017, 'YD', '韵达速递', 6, '', '', 0.00, 0.00, 0, '2020-08-20 21:00:27', '2020-08-20 21:00:27', '', NULL);
INSERT INTO `shop_express` VALUES (15, 1000106, 'ZTO', '中通快递', 3, '', '', 0.00, 0.00, 0, '2020-08-22 21:48:54', '2020-08-22 21:48:54', '', NULL);
INSERT INTO `shop_express` VALUES (16, 1000017, 'HTKY', '百世快递', 2, '', '', 0.00, 0.00, 0, '2020-08-28 11:26:32', '2020-08-28 11:26:32', '', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代购粉丝表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_fans
-- ----------------------------
INSERT INTO `shop_fans` VALUES (15, 1000018, '2020-08-01 18:41:09', '2020-08-01 18:41:09', NULL, 1000019, 1, 1, 20, '2020-08-05 10:52:47');
INSERT INTO `shop_fans` VALUES (16, 1000017, '2020-08-01 18:57:03', '2020-08-01 18:57:03', NULL, 1000018, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (17, 1000017, '2020-08-01 18:57:33', '2020-08-01 18:57:33', NULL, 1000019, 0, 2, 70, '2020-08-05 22:09:17');
INSERT INTO `shop_fans` VALUES (19, 1000017, '2020-08-01 18:58:20', '2020-08-01 18:58:20', NULL, 1000001, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (22, 1000017, '2020-08-01 21:37:03', '2020-08-01 21:37:03', NULL, 1000023, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (23, 1000017, '2020-08-01 21:47:41', '2020-08-01 21:47:41', NULL, 1000006, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (24, 1000017, '2020-08-02 06:19:43', '2020-08-02 06:19:43', NULL, 1000000, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (25, 1000017, '2020-08-02 21:10:00', '2020-08-02 21:10:00', NULL, 1000024, 1, 2, 109, '2020-08-28 11:02:12');
INSERT INTO `shop_fans` VALUES (27, 1000017, '2020-08-03 11:48:09', '2020-08-03 11:48:09', NULL, 1000012, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (28, 1000017, '2020-08-03 12:01:08', '2020-08-03 12:01:08', NULL, 1000027, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (29, 1000017, '2020-08-03 16:45:44', '2020-08-03 16:45:44', NULL, 1000028, 1, 4, 130, '2020-08-07 15:33:04');
INSERT INTO `shop_fans` VALUES (30, 1000018, '2020-08-03 20:35:46', '2020-08-03 20:35:46', NULL, 1000029, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (32, 1000017, '2020-08-03 22:06:56', '2020-08-03 22:06:56', NULL, 1000016, 0, 1, 40, '2020-08-18 18:18:18');
INSERT INTO `shop_fans` VALUES (36, 1000018, '2020-08-05 10:29:19', '2020-08-05 10:29:19', NULL, 1000033, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (41, 1000013, '2020-08-05 13:16:24', '2020-08-05 13:16:24', NULL, 1000000, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (42, 1000013, '2020-08-05 13:17:36', '2020-08-05 13:17:36', NULL, 1000017, 0, 1, 2, '2020-08-08 07:47:19');
INSERT INTO `shop_fans` VALUES (45, 1000017, '2020-08-05 17:43:42', '2020-08-05 17:43:42', NULL, 1000036, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (47, 1000035, '2020-08-05 21:07:30', '2020-08-05 21:07:30', NULL, 1000017, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (48, 1000035, '2020-08-05 21:07:42', '2020-08-05 21:07:42', NULL, 1000018, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (49, 1000035, '2020-08-05 21:21:41', '2020-08-05 21:21:41', NULL, 1000039, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (50, 1000035, '2020-08-05 21:25:34', '2020-08-05 21:25:34', NULL, 1000013, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (51, 1000017, '2020-08-05 21:29:53', '2020-08-05 21:29:53', NULL, 1000040, 1, 1, 60, '2020-08-06 08:17:54');
INSERT INTO `shop_fans` VALUES (53, 1000035, '2020-08-05 22:00:00', '2020-08-05 22:00:00', NULL, 1000042, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (54, 1000017, '2020-08-05 22:00:42', '2020-08-05 22:00:42', NULL, 1000043, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (55, 1000017, '2020-08-05 22:01:13', '2020-08-05 22:01:13', NULL, 1000044, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (56, 1000017, '2020-08-05 22:01:57', '2020-08-05 22:01:57', NULL, 1000045, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (57, 1000035, '2020-08-05 22:06:22', '2020-08-05 22:06:22', NULL, 1000014, 1, 3, 1010, '2020-08-08 14:20:07');
INSERT INTO `shop_fans` VALUES (58, 1000017, '2020-08-05 22:06:50', '2020-08-05 22:06:50', NULL, 1000046, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (59, 1000017, '2020-08-05 22:08:53', '2020-08-05 22:08:53', NULL, 1000014, 0, 1, 30, '2020-08-05 22:09:57');
INSERT INTO `shop_fans` VALUES (60, 1000017, '2020-08-05 22:18:13', '2020-08-05 22:18:13', NULL, 1000042, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (61, 1000017, '2020-08-05 22:19:34', '2020-08-05 22:19:34', NULL, 1000039, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (62, 1000017, '2020-08-05 22:20:45', '2020-08-05 22:20:45', NULL, 1000047, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (63, 1000017, '2020-08-05 22:26:41', '2020-08-05 22:26:41', NULL, 1000048, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (64, 1000017, '2020-08-05 22:33:05', '2020-08-05 22:33:05', NULL, 1000049, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (65, 1000017, '2020-08-05 22:49:32', '2020-08-05 22:49:32', NULL, 1000050, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (66, 1000017, '2020-08-05 22:59:47', '2020-08-05 22:59:47', NULL, 1000051, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (67, 1000017, '2020-08-05 22:59:58', '2020-08-05 22:59:58', NULL, 1000052, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (68, 1000017, '2020-08-05 23:04:08', '2020-08-05 23:04:08', NULL, 1000053, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (69, 1000017, '2020-08-05 23:53:03', '2020-08-05 23:53:03', NULL, 1000054, 1, 1, 40, '2020-08-21 13:57:15');
INSERT INTO `shop_fans` VALUES (70, 1000017, '2020-08-06 06:30:32', '2020-08-06 06:30:32', NULL, 1000055, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (72, 1000017, '2020-08-06 09:10:04', '2020-08-06 09:10:04', NULL, 1000013, 0, 2, 70, '2020-08-11 18:06:31');
INSERT INTO `shop_fans` VALUES (73, 1000017, '2020-08-06 10:23:56', '2020-08-06 10:23:56', NULL, 1000057, 1, 1, 29, '2020-08-20 22:18:59');
INSERT INTO `shop_fans` VALUES (74, 1000017, '2020-08-06 10:41:24', '2020-08-06 10:41:24', NULL, 1000058, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (75, 1000017, '2020-08-06 11:13:55', '2020-08-06 11:13:55', NULL, 1000059, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (77, 1000017, '2020-08-06 11:36:07', '2020-08-06 11:36:07', NULL, 1000061, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (78, 1000017, '2020-08-06 11:56:47', '2020-08-06 11:56:47', NULL, 1000062, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (81, 1000017, '2020-08-06 12:33:46', '2020-08-06 12:33:46', NULL, 1000064, 1, 1, 30, '2020-08-18 19:04:45');
INSERT INTO `shop_fans` VALUES (82, 1000013, '2020-08-06 12:42:44', '2020-08-06 12:42:44', NULL, 1000065, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (83, 1000013, '2020-08-06 13:04:18', '2020-08-06 13:04:18', NULL, 1000066, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (84, 1000013, '2020-08-06 13:06:27', '2020-08-06 13:06:27', NULL, 1000067, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (86, 1000013, '2020-08-06 13:24:31', '2020-08-06 13:24:31', NULL, 1000069, 1, 1, 3, '2020-08-06 14:30:34');
INSERT INTO `shop_fans` VALUES (87, 1000013, '2020-08-06 14:36:50', '2020-08-06 14:36:50', NULL, 1000070, 1, 1, 2, '2020-08-06 14:41:39');
INSERT INTO `shop_fans` VALUES (88, 1000017, '2020-08-06 16:55:59', '2020-08-06 16:55:59', NULL, 1000056, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (90, 1000017, '2020-08-06 17:05:29', '2020-08-06 17:05:29', NULL, 1000071, 1, 1, 30, '2020-08-06 17:44:49');
INSERT INTO `shop_fans` VALUES (92, 1000017, '2020-08-07 11:24:55', '2020-08-07 11:24:55', NULL, 1000074, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (93, 1000017, '2020-08-07 11:26:13', '2020-08-07 11:26:13', NULL, 1000075, 1, 1, 30, '2020-08-10 17:22:57');
INSERT INTO `shop_fans` VALUES (94, 1000017, '2020-08-07 11:28:09', '2020-08-07 11:28:09', NULL, 1000076, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (95, 1000017, '2020-08-07 11:44:17', '2020-08-07 11:44:17', NULL, 1000077, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (96, 1000017, '2020-08-07 12:05:09', '2020-08-07 12:05:09', NULL, 1000078, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (97, 1000017, '2020-08-07 12:08:50', '2020-08-07 12:08:50', NULL, 1000079, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (117, 1000017, '2020-08-08 08:01:46', '2020-08-08 08:01:46', NULL, 1000035, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (118, 1000017, '2020-08-10 16:24:49', '2020-08-10 16:24:49', NULL, 1000091, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (119, 1000017, '2020-08-10 16:27:40', '2020-08-10 16:27:40', NULL, 1000092, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (120, 1000017, '2020-08-10 16:27:50', '2020-08-10 16:27:50', NULL, 1000093, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (121, 1000017, '2020-08-10 16:28:12', '2020-08-10 16:28:12', NULL, 1000094, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (122, 1000017, '2020-08-10 16:29:35', '2020-08-10 16:29:35', NULL, 1000095, 1, 1, 40, '2020-08-18 17:39:47');
INSERT INTO `shop_fans` VALUES (123, 1000017, '2020-08-10 16:33:26', '2020-08-10 16:33:26', NULL, 1000096, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (125, 1000017, '2020-08-10 18:57:56', '2020-08-10 18:57:56', NULL, 1000097, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (126, 1000017, '2020-08-10 20:36:51', '2020-08-10 20:36:51', NULL, 1000098, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (127, 1000013, '2020-08-10 21:29:44', '2020-08-10 21:29:44', NULL, 1000099, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (129, 1000065, '2020-08-10 22:03:30', '2020-08-10 22:03:30', NULL, 1000013, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (130, 1000099, '2020-08-10 22:05:07', '2020-08-10 22:05:07', NULL, 1000013, 0, 2, 81, '2020-08-10 22:20:57');
INSERT INTO `shop_fans` VALUES (132, 1000099, '2020-08-10 22:10:39', '2020-08-10 22:10:39', NULL, 1000035, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (133, 1000099, '2020-08-10 22:11:05', '2020-08-10 22:11:05', NULL, 1000001, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (134, 1000099, '2020-08-10 22:18:04', '2020-08-10 22:18:04', NULL, 1000017, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (135, 1000017, '2020-08-10 22:21:29', '2020-08-10 22:21:29', NULL, 1000100, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (136, 1000013, '2020-08-10 22:28:31', '2020-08-10 22:28:31', NULL, 1000101, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (137, 1000099, '2020-08-10 22:30:12', '2020-08-10 22:30:12', NULL, 1000102, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (138, 1000099, '2020-08-10 22:32:46', '2020-08-10 22:32:46', NULL, 1000101, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (139, 1000065, '2020-08-10 22:32:50', '2020-08-10 22:32:50', NULL, 1000001, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (140, 1000065, '2020-08-10 22:33:04', '2020-08-10 22:33:04', NULL, 1000017, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (141, 1000065, '2020-08-10 22:33:47', '2020-08-10 22:33:47', NULL, 1000035, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (142, 1000099, '2020-08-10 22:45:44', '2020-08-10 22:45:44', NULL, 1000103, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (143, 1000013, '2020-08-10 23:01:45', '2020-08-10 23:01:45', NULL, 1000103, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (144, 1000099, '2020-08-10 23:45:13', '2020-08-10 23:45:13', NULL, 1000016, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (146, 1000065, '2020-08-10 23:46:49', '2020-08-10 23:46:49', NULL, 1000016, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (147, 1000022, '2020-08-11 02:03:59', '2020-08-11 02:03:59', NULL, 1000104, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (148, 1000022, '2020-08-11 02:13:33', '2020-08-11 02:13:33', NULL, 1000075, 0, 1, 999, '2020-08-11 02:17:26');
INSERT INTO `shop_fans` VALUES (149, 1000017, '2020-08-11 09:58:56', '2020-08-11 09:58:56', NULL, 1000105, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (150, 1000017, '2020-08-11 09:59:26', '2020-08-11 09:59:26', NULL, 1000106, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (151, 1000106, '2020-08-11 10:08:09', '2020-08-11 10:08:09', NULL, 1000105, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (152, 1000106, '2020-08-11 10:10:27', '2020-08-11 10:10:27', NULL, 1000107, 1, 1, 48, '2020-08-11 10:17:57');
INSERT INTO `shop_fans` VALUES (153, 1000106, '2020-08-11 10:13:34', '2020-08-11 10:13:34', NULL, 1000108, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (154, 1000106, '2020-08-11 10:17:24', '2020-08-11 10:17:24', NULL, 1000109, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (155, 1000106, '2020-08-11 10:32:46', '2020-08-11 10:32:46', NULL, 1000110, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (156, 1000060, '2020-08-11 11:52:08', '2020-08-11 11:52:08', NULL, 1000112, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (157, 1000106, '2020-08-11 12:04:05', '2020-08-11 12:04:05', NULL, 1000113, 1, 1, 48, '2020-08-11 12:09:45');
INSERT INTO `shop_fans` VALUES (159, 1000035, '2020-08-11 12:32:06', '2020-08-11 12:32:06', NULL, 1000008, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (160, 1000099, '2020-08-11 14:07:59', '2020-08-11 14:07:59', NULL, 1000115, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (161, 1000013, '2020-08-11 14:09:39', '2020-08-11 14:09:39', NULL, 1000008, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (162, 1000017, '2020-08-11 18:00:02', '2020-08-11 18:00:02', NULL, 1000116, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (163, 1000013, '2020-08-11 18:09:25', '2020-08-11 18:09:25', NULL, 1000006, 1, 1, 2, '2020-08-11 18:09:30');
INSERT INTO `shop_fans` VALUES (164, 1000013, '2020-08-11 18:12:15', '2020-08-11 18:12:15', NULL, 1000001, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (165, 1000017, '2020-08-11 18:20:19', '2020-08-11 18:20:19', NULL, 1000008, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (166, 1000106, '2020-08-11 18:25:09', '2020-08-11 18:25:09', NULL, 1000017, 0, 3, 144, '2020-08-21 14:19:36');
INSERT INTO `shop_fans` VALUES (167, 1000017, '2020-08-11 19:10:56', '2020-08-11 19:10:56', NULL, 1000117, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (168, 1000017, '2020-08-11 19:11:27', '2020-08-11 19:11:27', NULL, 1000118, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (170, 1000035, '2020-08-11 19:30:17', '2020-08-11 19:30:17', NULL, 1000001, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (171, 1000035, '2020-08-11 19:40:33', '2020-08-11 19:40:33', NULL, 1000006, 0, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (172, 1000060, '2020-08-12 09:48:27', '2020-08-12 09:48:27', NULL, 1000124, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (173, 1000017, '2020-08-12 11:19:43', '2020-08-12 11:19:43', NULL, 1000125, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (174, 1000060, '2020-08-12 13:17:10', '2020-08-12 13:17:10', NULL, 1000126, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (175, 1000099, '2020-08-12 13:39:47', '2020-08-12 13:39:47', NULL, 1000127, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (176, 1000099, '2020-08-12 13:40:07', '2020-08-12 13:40:07', NULL, 1000128, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (177, 1000099, '2020-08-12 13:40:58', '2020-08-12 13:40:58', NULL, 1000129, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (178, 1000099, '2020-08-12 13:42:01', '2020-08-12 13:42:01', NULL, 1000130, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (179, 1000099, '2020-08-12 13:43:48', '2020-08-12 13:43:48', NULL, 1000131, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (180, 1000099, '2020-08-12 13:44:16', '2020-08-12 13:44:16', NULL, 1000132, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (181, 1000099, '2020-08-12 13:52:55', '2020-08-12 13:52:55', NULL, 1000133, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (182, 1000099, '2020-08-12 13:55:39', '2020-08-12 13:55:39', NULL, 1000134, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (183, 1000099, '2020-08-12 14:12:16', '2020-08-12 14:12:16', NULL, 1000135, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (184, 1000099, '2020-08-12 14:15:47', '2020-08-12 14:15:47', NULL, 1000136, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (185, 1000099, '2020-08-12 14:28:50', '2020-08-12 14:28:50', NULL, 1000137, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (186, 1000099, '2020-08-12 15:40:33', '2020-08-12 15:40:33', NULL, 1000138, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (187, 1000013, '2020-08-18 11:52:23', '2020-08-18 11:52:23', NULL, 1000144, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (188, 1000013, '2020-08-18 11:52:48', '2020-08-18 11:52:48', NULL, 1000145, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (189, 1000013, '2020-08-18 12:00:07', '2020-08-18 12:00:07', NULL, 1000146, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (190, 1000017, '2020-08-18 17:42:00', '2020-08-18 17:42:00', NULL, 1000147, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (191, 1000017, '2020-08-18 17:52:36', '2020-08-18 17:52:36', NULL, 1000148, 1, 2, 59, '2020-08-20 21:20:15');
INSERT INTO `shop_fans` VALUES (192, 1000017, '2020-08-18 18:06:49', '2020-08-18 18:06:49', NULL, 1000149, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (193, 1000017, '2020-08-18 20:17:22', '2020-08-18 20:17:22', NULL, 1000150, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (194, 1000060, '2020-08-18 21:09:15', '2020-08-18 21:09:15', NULL, 1000151, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (195, 1000017, '2020-08-18 23:53:35', '2020-08-18 23:53:35', NULL, 1000152, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (196, 1000017, '2020-08-20 12:06:01', '2020-08-20 12:06:01', NULL, 1000154, 1, 1, 30, '2020-08-20 22:22:36');
INSERT INTO `shop_fans` VALUES (197, 1000017, '2020-08-20 21:14:28', '2020-08-20 21:14:28', NULL, 1000022, 0, 1, 40, '2020-08-20 21:15:55');
INSERT INTO `shop_fans` VALUES (198, 1000017, '2020-08-20 21:42:38', '2020-08-20 21:42:38', NULL, 1000156, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (199, 1000017, '2020-08-20 22:17:21', '2020-08-20 22:17:21', NULL, 1000157, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (200, 1000017, '2020-08-20 22:24:20', '2020-08-20 22:24:20', NULL, 1000158, 1, 1, 20, '2020-08-20 22:27:47');
INSERT INTO `shop_fans` VALUES (201, 1000148, '2020-08-21 06:23:30', '2020-08-21 06:23:30', NULL, 1000159, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (202, 1000017, '2020-08-21 08:20:06', '2020-08-21 08:20:06', NULL, 1000160, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (203, 1000148, '2020-08-21 18:15:58', '2020-08-21 18:15:58', NULL, 1000161, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (204, 1000017, '2020-08-24 10:25:01', '2020-08-24 10:25:01', NULL, 1000163, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (205, 1000017, '2020-08-24 10:28:06', '2020-08-24 10:28:06', NULL, 1000164, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (206, 1000017, '2020-08-25 12:14:01', '2020-08-25 12:14:01', NULL, 1000166, 1, 0, 0, NULL);
INSERT INTO `shop_fans` VALUES (207, 1000017, '2020-08-27 00:02:14', '2020-08-27 00:02:14', NULL, 1000168, 1, 0, 0, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商铺' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_info
-- ----------------------------
INSERT INTO `shop_info` VALUES (2, 1000017, '2020-08-01 18:19:55', '2020-08-01 18:19:55', NULL, 1000017, '江龙线上水果店', 'https://cwimg.szxjcheng.com/1000017/202085120/fXnXDzC3FT.png', '包邮保质保新鲜保绿色无添加剂', NULL, 81, 'DreamAndHelp1951', 0, 0, '[6, 7, 8]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000017/20208111843/SCyGF6CW63.png\"], \"end_time\": \"2020-09-11 18:42:00\", \"start_time\": \"2020-08-11 18:42:00\", \"departure_point\": \"深圳\", \"destination_point\": \"西藏\"}]}', NULL);
INSERT INTO `shop_info` VALUES (3, 1000018, '2020-08-01 18:39:44', '2020-08-01 18:39:44', NULL, 1000018, '凡羽的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIqKibdaFia5LZiaHnWblNlsJxlDq0RUK4RIac3gakPupHTkCvZh6kNOOhCDibGaeXmtGms5MMm5WcYuA/132', NULL, NULL, 3, NULL, 0, 1, '[2]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000018/202087209/Nmm2saSJDN.png\"], \"end_time\": \"2020-08-01 19:04:00\", \"start_time\": \"2020-08-01 19:04:00\", \"departure_point\": \"美国\", \"destination_point\": \"日本\"}]}', NULL);
INSERT INTO `shop_info` VALUES (4, 1000020, '2020-08-01 19:03:50', '2020-08-01 19:03:50', NULL, 1000020, '蒋小姐的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIwLOgXjFK3NAkWsRhzX33yWHGsEzSebZAj7DDicDAagWDzSEu5ia7pu0BYIsHG7ZoibhwksVzgicdzIA/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (5, 1000022, '2020-08-01 19:54:44', '2020-08-01 19:54:44', NULL, 1000022, '小敏香港代', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIkQRI4Y9SolYQVhbH9Q3Hj2kN9ekX1nT9nKqZ6icZXiaicrxOqIqSJF9RqCaZibI79911xMXKv1Ww5nQ/132', '5年老代购，疫情期间直邮清关比较慢', NULL, 2, '13145906814', 0, 0, '[5, 2, 4]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000022/2020811139/h6WyChEe6P.png\"], \"end_time\": \"2020-08-15 01:38:00\", \"start_time\": \"2020-08-11 01:38:00\", \"departure_point\": \"深圳\", \"destination_point\": \"香港\"}]}', NULL);
INSERT INTO `shop_info` VALUES (6, 1000029, '2020-08-03 20:24:58', '2020-08-03 20:24:58', NULL, 1000029, '石同学的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLjabDFIyO0kmABu4XiaPtmpGffWfYy53vR9Budy5bNtreOea0rjWT6eU5zlxPo0sClCHgqZaL414Q/132', NULL, NULL, 0, NULL, 0, 1, '[5, 2]', '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (7, 1000030, '2020-08-03 21:36:31', '2020-08-03 21:36:31', NULL, 1000030, '筱梅梅梅梅梅的商店', 'https://wx.qlogo.cn/mmopen/vi_32/0STYrGw909HXDQhn96CXmbNIbNPnjr6Q1YazaJXiaib1W5NpCic4nceYyCQxqHhT3N6lCmcTTknWQ4G3HLaENYhTA/132', '', NULL, 0, '', 0, 0, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (8, 1000013, '2020-08-04 18:16:58', '2020-08-04 18:16:58', NULL, 1000013, '三国历史人物服装', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIIDUnsfAibxPVaoRwficcs3H5dicO0FU54ezZGy1roVLzZIwJ17ibic5uAlU4iaGPLsQvtXwErfB7FFsjQ/132', '三国服装', NULL, 18, 'nation3', 0, 0, '[1, 4, 8]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000013/2020861221/eHxeifRNxy.png\"], \"end_time\": \"2020-09-06 12:16:00\", \"start_time\": \"2020-08-06 12:16:00\", \"departure_point\": \"江背\", \"destination_point\": \"湖上\"}]}', NULL);
INSERT INTO `shop_info` VALUES (9, 1000033, '2020-08-05 10:28:09', '2020-08-05 10:28:09', NULL, 1000033, 'S+国际美业创始人 | 刘春燕的商店', 'https://wx.qlogo.cn/mmopen/vi_32/0aBeicBPiaqQ8akN40pJ9zKbCFKiab3F4kxFf99GOrjXRsjJfpfoKe4zgcvyN6FXXpQuNfaLqovHibXkVwsHYxGl3A/132', '', NULL, 0, '', 0, 0, NULL, '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000033/2020851033/yYwWP68TSb.png\"], \"end_time\": \"2020-08-05 10:32:00\", \"start_time\": \"2020-08-05 10:32:00\", \"departure_point\": \"啦\", \"destination_point\": \"来了\"}]}', NULL);
INSERT INTO `shop_info` VALUES (10, 1000034, '2020-08-05 10:49:30', '2020-08-05 10:49:30', NULL, 1000034, 'S+国际美业培训院长 | 雷艳的商店', 'https://wx.qlogo.cn/mmopen/vi_32/NYr8FDOHV2V32IpHvM4QqX3hbgsYKkkB1xk1f5Hia00pBNSQyiclCwoHb2pVMNW3VawexugEeVqevMWzD2GJ7CPA/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (11, 1000035, '2020-08-05 11:53:43', '2020-08-05 11:53:43', NULL, 1000035, '壮壮的美妆花园', 'https://cwimg.szxjcheng.com/1000035/2020881248/2jSzJTGyE8.png', '专职代购，美妆小店', NULL, 13, 'wx10086', 0, 0, '[5]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000035/20208121916/JmdKWMWpEX.png\"], \"end_time\": \"2020-08-12 14:25:00\", \"start_time\": \"2020-08-12 14:25:00\", \"departure_point\": \"2\", \"destination_point\": \"2\"}]}', '{\"watermark\":\"\",\"t_content\":\"诚物优选\",\"is_enable\":1}');
INSERT INTO `shop_info` VALUES (12, 1000060, '2020-08-06 11:23:25', '2020-08-06 11:23:25', NULL, 1000060, 'WANG的商店', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ertk75alPq0yAsbpRu9YUBVLDUs3t2ibdbJGiaIvOqEj99xImb3JZJWfPWQVzdn6iczQLeI5BlD4rxjA/132', NULL, NULL, 4, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (13, 1000063, '2020-08-06 11:59:39', '2020-08-06 11:59:39', NULL, 1000063, '子驹的商店', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo3ppzcib2IibS2iby1RRAJlJ0aHRWbHspLZqnYJzFusHqactc8Z9GuvU1DvJBKvI9g7IaSFic1N9nAdw/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (15, 1000084, '2020-07-31 17:41:04', '2020-07-31 17:41:04', NULL, 1000084, '诚物优选', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311754/tQEKj8KmAx.png', '诚信代物❤️', NULL, 28, 'e13360065873', 1, 0, '[3]', '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (16, 1000028, '2020-08-09 21:28:32', '2020-08-09 21:28:32', NULL, 1000028, '花花世界的商店', 'https://wx.qlogo.cn/mmopen/vi_32/9mjKN9eFKKE4BAMxvXfnxqdm21ssrmpGdoItLFOHMDDg90ibxaxl0Qn9ib8zOapxprxyFmLBqFC1BS0a5icVqJHWQ/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (17, 1000090, '2020-08-10 13:13:55', '2020-08-10 13:13:55', NULL, 1000090, 'Bling Bling的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Xf0iacPa3kxUmCjZ90YTXdkHDxMVRLVPw9SE6jxWnthT82n32vsicjc7ZcU6Dc0tL95WZKHV1DOQhbfFmqgAicx6w/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (18, 1000095, '2020-08-10 19:29:35', '2020-08-10 19:29:35', NULL, 1000095, '车车妈妈商城', 'https://cwimg.szxjcheng.com/1000095/20208181815/7XQKWhxkRm.png', '好质量\n好生活\n做一个有品位的人', NULL, 0, '', 0, 0, NULL, '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000095/2020819758/iRCkFWGbaK.png\"], \"end_time\": \"2020-08-18 18:15:00\", \"start_time\": \"2020-08-18 18:15:00\", \"departure_point\": \"潮州\", \"destination_point\": \"深圳\"}]}', NULL);
INSERT INTO `shop_info` VALUES (19, 1000099, '2020-08-10 21:56:25', '2020-08-10 21:56:25', NULL, 1000099, '👙 小雅💋的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Lq6icfbaH5ZXNRpqnMUNxuQy2vk5pGuYj2SNKbd0arDKibVhSGibxtMDHJuh74wC3tfybbXticSlXUcyZfJib8cnia6Q/132', 'TOUCH', NULL, 22, '', 0, 0, '[4]', '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (20, 1000065, '2020-08-10 21:57:50', '2020-08-10 21:57:50', NULL, 1000065, '泡芙小姐的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL2GBvNwxu4PV7QswdXrBl0ZzuoGI6Ju51xYrS6BvlTvfTSCkpoRmbYJKekDBVfoMwG2YsSYlx2vA/132', NULL, NULL, 5, NULL, 0, 1, '[2]', '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (21, 1000106, '2020-08-11 10:02:08', '2020-08-11 10:02:08', NULL, 1000106, '拾荒少年的商店', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83er4af3sRsBaN2AzmAnx5Eo4UOdvQ5400WqzzibHt5qqojtVQ1AuSkAQVy7JdOsSIU1SOtToshbvFRA/132', '', NULL, 7, '', 0, 0, '[6]', '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (22, 1000069, '2020-08-11 11:12:47', '2020-08-11 11:12:47', NULL, 1000069, 'lizy的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKtvZuqwGoTJSUvljFoVnNNDOVXk2nLTNSmOWaAhPHzCEUQckwSg5ia2L8wZQqdFYvKIxNOAauAxjQ/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (23, 1000008, '2020-08-11 18:22:03', '2020-08-11 18:22:03', NULL, 1000008, '緣的商店', 'https://cwimg.szxjcheng.com/1000008/20208111912/sRc4idWpj3.png', NULL, NULL, 0, NULL, 0, 1, '[8, 6, 7]', '{\"travel_info\": [{\"url\": [\"https://cwimg.szxjcheng.com/1000008/20208111825/xAxb3NhmJx.png\"], \"end_time\": \"2020-10-11 18:25:00\", \"start_time\": \"2020-08-11 18:25:00\", \"departure_point\": \"南京\", \"destination_point\": \"北京\"}]}', NULL);
INSERT INTO `shop_info` VALUES (24, 1000016, '2020-08-12 16:33:24', '2020-08-12 16:33:24', NULL, 1000016, 'Chris的商店', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eq1JiaI32hEusibl96Rf5BjlX2AtR37QZNqYlJUbF9CkjMQvadUPQ1ylwCZgsUAP6hibJC9FR7DibIyVQ/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (25, 1000100, '2020-08-13 21:23:14', '2020-08-13 21:23:14', NULL, 1000100, '罗罗昵的商店', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKAWr5qia3EibrfALg8hZZcsXvBhsH39bbfVF2jpn0QOCibCprttBVdvglSVPXJp7cmUC6iaYZrvmJrvw/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (26, 1000148, '2020-08-18 18:48:16', '2020-08-18 18:48:16', NULL, 1000148, '一号商铺', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKR1xfzzIkSrcdHHhNicSze1PeZibmSFzBlWbSyXB7iaiaaibZ9ZK05QvqZtWE75sBH6Zf1TWibgkTPnr4g/132', '湖南武冈特产卤味食品', NULL, 2, '13682648914', 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (27, 1000166, '2020-08-25 12:15:17', '2020-08-25 12:15:17', NULL, 1000166, '喵金子的商店', 'https://thirdwx.qlogo.cn/mmopen/vi_32/IzLaELxDutsxF9Y2kg3mftoqeczCVQDbtX1YhYZu6wtdd7uZIysE7FkrxxZBI0bYvdibRbUw5sUiccP2vzBF3aqA/132', NULL, NULL, 0, NULL, 0, 1, NULL, '{\"travel_info\": []}', NULL);
INSERT INTO `shop_info` VALUES (28, 1000172, '2020-08-31 21:09:38', '2020-08-31 21:09:38', NULL, 1000172, 'yoyo💘全球购', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTITOYbXekFrjy4kD8qh160RvwvJasEK4Ha3Roia0bg2bSwkAjYVhRuQFuKSVnP6hS2QbNibtTsGL1Yw/132', NULL, NULL, 0, 'yoyoqqg', 0, 1, NULL, '{\"travel_info\": []}', NULL);

-- ----------------------------
-- Table structure for shop_profit
-- ----------------------------
DROP TABLE IF EXISTS `shop_profit`;
CREATE TABLE `shop_profit`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '买家用户编号',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '卖家用户编号(或称店铺编号)',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NOT NULL COMMENT '订单利润',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_profit
-- ----------------------------
INSERT INTO `shop_profit` VALUES (3, '10000191596279833', 1000019, 1000017, 39.90, 9.90, '2020-08-01 21:04:45');
INSERT INTO `shop_profit` VALUES (37, '10000131596542446', 1000013, 1000013, 22.00, 22.00, '2020-08-04 20:02:01');
INSERT INTO `shop_profit` VALUES (38, '10000191596595967', 1000019, 1000018, 20.00, 8.00, '2020-08-05 10:53:16');
INSERT INTO `shop_profit` VALUES (39, '10000131596596608', 1000013, 1000013, 22.00, 22.00, '2020-08-05 11:03:34');
INSERT INTO `shop_profit` VALUES (40, '10000351596607608', 1000035, 1000035, 200.00, 190.00, '2020-08-05 14:06:58');
INSERT INTO `shop_profit` VALUES (41, '10000351596623124', 1000035, 1000035, 200.00, 190.00, '2020-08-05 18:25:29');
INSERT INTO `shop_profit` VALUES (42, '10000131596623315', 1000013, 1000013, 22.00, 22.00, '2020-08-05 18:31:55');
INSERT INTO `shop_profit` VALUES (43, '10000131596623769', 1000013, 1000013, 22.00, 22.00, '2020-08-05 18:36:24');
INSERT INTO `shop_profit` VALUES (44, '10000351596629189', 1000035, 1000035, 200.00, 190.00, '2020-08-05 20:19:22');
INSERT INTO `shop_profit` VALUES (45, '10000351596629958', 1000035, 1000035, 200.00, 190.00, '2020-08-05 20:21:31');
INSERT INTO `shop_profit` VALUES (46, '10000141596636596', 1000014, 1000017, 29.90, 9.90, '2020-08-05 22:12:11');
INSERT INTO `shop_profit` VALUES (47, '10000191596636556', 1000019, 1000017, 29.90, 9.90, '2020-08-05 22:12:13');
INSERT INTO `shop_profit` VALUES (48, '10000131596637460', 1000013, 1000013, 22.00, 22.00, '2020-08-05 22:24:31');
INSERT INTO `shop_profit` VALUES (49, '10000401596673074', 1000040, 1000017, 59.80, 19.80, '2020-08-06 08:37:22');
INSERT INTO `shop_profit` VALUES (50, '10000131596677158', 1000013, 1000013, 22.00, 22.00, '2020-08-06 09:26:03');
INSERT INTO `shop_profit` VALUES (51, '10000131596677841', 1000013, 1000013, 22.00, 22.00, '2020-08-06 11:09:18');
INSERT INTO `shop_profit` VALUES (52, '10000691596695434', 1000069, 1000013, 2.99, 2.99, '2020-08-06 14:33:37');
INSERT INTO `shop_profit` VALUES (53, '10000701596696099', 1000070, 1000013, 1.50, 1.50, '2020-08-06 14:45:50');
INSERT INTO `shop_profit` VALUES (54, '10000281596698936', 1000028, 1000017, 39.90, 4.90, '2020-08-06 15:29:33');
INSERT INTO `shop_profit` VALUES (58, '10000711596707088', 1000071, 1000017, 29.90, 4.90, '2020-08-06 17:45:27');
INSERT INTO `shop_profit` VALUES (59, '10000131596707942', 1000013, 1000013, 1.50, 1.50, '2020-08-06 17:59:17');
INSERT INTO `shop_profit` VALUES (60, '10000281596708086', 1000028, 1000017, 29.90, 4.90, '2020-08-06 18:01:41');
INSERT INTO `shop_profit` VALUES (61, '10000281596708250', 1000028, 1000017, 39.90, 4.90, '2020-08-06 18:04:22');
INSERT INTO `shop_profit` VALUES (62, '10000131596707941', 1000013, 1000013, 1.50, 1.50, '2020-08-06 18:13:43');
INSERT INTO `shop_profit` VALUES (63, '10000131596677785', 1000013, 1000013, 22.00, 22.00, '2020-08-06 18:16:01');
INSERT INTO `shop_profit` VALUES (64, '10000131596714299', 1000013, 1000013, 1.50, 1.50, '2020-08-06 19:45:34');
INSERT INTO `shop_profit` VALUES (71, '10000281596785583', 1000028, 1000017, 19.90, 4.90, '2020-08-07 15:33:41');
INSERT INTO `shop_profit` VALUES (72, '10000131596784673', 1000013, 1000013, 1.50, 1.50, '2020-08-07 16:56:46');
INSERT INTO `shop_profit` VALUES (73, '10000171596844039', 1000017, 1000013, 1.50, 1.50, '2020-08-08 07:50:07');
INSERT INTO `shop_profit` VALUES (74, '10000141596867657', 1000014, 1000035, 300.00, 50.00, '2020-08-08 22:09:31');
INSERT INTO `shop_profit` VALUES (75, '10000141596867664', 1000014, 1000035, 400.00, 100.00, '2020-08-08 22:09:33');
INSERT INTO `shop_profit` VALUES (76, '10000141596867606', 1000014, 1000035, 310.00, 60.00, '2020-08-08 22:09:35');
INSERT INTO `shop_profit` VALUES (77, '10000131597068825', 1000013, 1000099, 1.00, 1.00, '2020-08-10 22:17:01');
INSERT INTO `shop_profit` VALUES (78, '10000131597069256', 1000013, 1000099, 80.00, 80.00, '2020-08-10 22:24:13');
INSERT INTO `shop_profit` VALUES (79, '10000131597080410', 1000013, 1000013, 7.00, 7.00, '2020-08-11 01:27:16');
INSERT INTO `shop_profit` VALUES (80, '10000751597083446', 1000075, 1000022, 999.00, 199.00, '2020-08-11 02:27:13');
INSERT INTO `shop_profit` VALUES (81, '10000751597051376', 1000075, 1000017, 29.90, 7.40, '2020-08-11 08:28:55');
INSERT INTO `shop_profit` VALUES (82, '10001071597112277', 1000107, 1000106, 48.00, 13.00, '2020-08-11 10:39:17');
INSERT INTO `shop_profit` VALUES (83, '10000131597138125', 1000013, 1000017, 29.90, 7.40, '2020-08-11 17:30:32');
INSERT INTO `shop_profit` VALUES (84, '10000131597140391', 1000013, 1000017, 39.90, 4.90, '2020-08-11 18:06:59');
INSERT INTO `shop_profit` VALUES (85, '10000061597140570', 1000006, 1000013, 1.50, 1.50, '2020-08-11 18:11:27');
INSERT INTO `shop_profit` VALUES (86, '10001131597118984', 1000113, 1000106, 48.00, 13.00, '2020-08-12 00:31:24');
INSERT INTO `shop_profit` VALUES (87, '10000131597386596', 1000013, 1000013, 1.50, 1.50, '2020-08-14 14:31:02');
INSERT INTO `shop_profit` VALUES (88, '10000131597741477', 1000013, 1000013, 7.00, 7.00, '2020-08-18 17:05:40');
INSERT INTO `shop_profit` VALUES (89, '10000951597743586', 1000095, 1000017, 40.00, 5.00, '2020-08-18 18:04:17');
INSERT INTO `shop_profit` VALUES (90, '10000171597744978', 1000017, 1000106, 48.00, 13.00, '2020-08-18 18:05:39');
INSERT INTO `shop_profit` VALUES (91, '10001481597744851', 1000148, 1000017, 29.90, 4.90, '2020-08-18 18:07:25');
INSERT INTO `shop_profit` VALUES (92, '10000161597745898', 1000016, 1000017, 40.00, 5.00, '2020-08-18 18:25:12');
INSERT INTO `shop_profit` VALUES (93, '10000171597746299', 1000017, 1000106, 48.00, 13.00, '2020-08-18 18:27:20');
INSERT INTO `shop_profit` VALUES (94, '10000641597748685', 1000064, 1000017, 29.90, 8.90, '2020-08-18 19:05:05');
INSERT INTO `shop_profit` VALUES (95, '10000221597929355', 1000022, 1000017, 39.90, 4.90, '2020-08-20 21:17:59');
INSERT INTO `shop_profit` VALUES (96, '10001481597929615', 1000148, 1000017, 29.00, 7.00, '2020-08-20 21:21:37');
INSERT INTO `shop_profit` VALUES (97, '10000571597933138', 1000057, 1000017, 29.00, 6.50, '2020-08-20 22:39:24');
INSERT INTO `shop_profit` VALUES (98, '10001541597933355', 1000154, 1000017, 29.90, 4.90, '2020-08-20 22:39:27');
INSERT INTO `shop_profit` VALUES (99, '10001581597933666', 1000158, 1000017, 19.90, 4.90, '2020-08-20 22:39:29');
INSERT INTO `shop_profit` VALUES (100, '10000541597989435', 1000054, 1000017, 40.00, 5.00, '2020-08-21 14:18:12');
INSERT INTO `shop_profit` VALUES (101, '10000171597990776', 1000017, 1000106, 48.00, 13.00, '2020-08-21 20:54:58');
INSERT INTO `shop_profit` VALUES (102, '10000241598583192', 1000024, 1000017, 79.00, 9.00, '2020-08-28 10:54:15');
INSERT INTO `shop_profit` VALUES (103, '10000241598583732', 1000024, 1000017, 29.90, 9.90, '2020-08-28 11:03:00');

-- ----------------------------
-- Table structure for shop_teamuser
-- ----------------------------
DROP TABLE IF EXISTS `shop_teamuser`;
CREATE TABLE `shop_teamuser`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `status` int(11) NOT NULL COMMENT '0表示申请1表示同意2表示拒绝3表示删除',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shop`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商铺后台管理团队成员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_teamuser
-- ----------------------------

-- ----------------------------
-- Table structure for shop_vip
-- ----------------------------
DROP TABLE IF EXISTS `shop_vip`;
CREATE TABLE `shop_vip`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) UNSIGNED NOT NULL,
  `vip_level` int(10) UNSIGNED NOT NULL COMMENT 'vip等级',
  `vip_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '等级名称',
  `opening_time` datetime(0) NOT NULL COMMENT '开通时间',
  `end_time` datetime(0) NOT NULL COMMENT '到期时间',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员身份等级表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_vip
-- ----------------------------
INSERT INTO `shop_vip` VALUES (1, 1000017, 0, '', '2020-08-01 18:21:00', '2020-09-01 18:21:00', '2020-08-01 18:21:00', NULL, '2020-08-01 18:21:00');
INSERT INTO `shop_vip` VALUES (2, 1000022, 0, '', '2020-08-11 01:42:36', '2020-09-11 01:42:36', '2020-08-11 01:42:36', NULL, '2020-08-11 01:42:36');
INSERT INTO `shop_vip` VALUES (3, 1000016, 0, '', '2020-08-12 16:34:33', '2020-09-12 16:34:33', '2020-08-12 16:34:33', NULL, '2020-08-12 16:34:33');
INSERT INTO `shop_vip` VALUES (4, 1000148, 0, '', '2020-08-20 23:09:18', '2020-09-20 23:09:18', '2020-08-20 23:09:18', NULL, '2020-08-20 23:09:18');

-- ----------------------------
-- Table structure for shop_vip_explain
-- ----------------------------
DROP TABLE IF EXISTS `shop_vip_explain`;
CREATE TABLE `shop_vip_explain`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `limit_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '限制名称',
  `limit_explain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '限制说明',
  `vip_explain` int(11) NOT NULL COMMENT 'vip限制（）',
  `ordinary_explain` int(11) NOT NULL COMMENT '普通用户限制（）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_vip_explain
-- ----------------------------
INSERT INTO `shop_vip_explain` VALUES (1, '订单处理 ', '普通用户每日3单限制', -1, 10000000);
INSERT INTO `shop_vip_explain` VALUES (2, '自定义banner', '普通会员不可定义', -1, -1);
INSERT INTO `shop_vip_explain` VALUES (3, '收支明细', '普通会员不可查看', -1, -1);
INSERT INTO `shop_vip_explain` VALUES (4, '蓝牙打印', '普通会员每日3次', -1, 10000000);

-- ----------------------------
-- Table structure for shop_vip_price
-- ----------------------------
DROP TABLE IF EXISTS `shop_vip_price`;
CREATE TABLE `shop_vip_price`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称',
  `member_discount_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '商品折扣价格',
  `member_original_price` decimal(10, 2) NOT NULL COMMENT '商品原始价格',
  `member_jian_shao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品简绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_vip_price
-- ----------------------------
INSERT INTO `shop_vip_price` VALUES (1, '1个月VIP', 1.00, 20.00, '首月试用');
INSERT INTO `shop_vip_price` VALUES (2, '1个月VIP', 20.00, 20.00, '月度会员');
INSERT INTO `shop_vip_price` VALUES (3, '3个月VIP', 39.00, 60.00, '立省21元');
INSERT INTO `shop_vip_price` VALUES (4, '12个月VIP', 192.00, 240.00, '8折优惠');

-- ----------------------------
-- Table structure for shop_wallet
-- ----------------------------
DROP TABLE IF EXISTS `shop_wallet`;
CREATE TABLE `shop_wallet`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `month_orders` int(10) UNSIGNED NOT NULL COMMENT '月订单个数',
  `month_profit` decimal(20, 2) NOT NULL COMMENT '月收益',
  `month_cost` decimal(20, 2) NOT NULL COMMENT '月成本',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员财富表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_wallet
-- ----------------------------
INSERT INTO `shop_wallet` VALUES (2, 1000017, 24, 169.70, 685.50, '2020-08-01 18:19:55', '2020-08-01 18:19:55');
INSERT INTO `shop_wallet` VALUES (3, 1000018, 1, 8.00, 12.00, '2020-08-01 18:39:44', '2020-08-01 18:39:44');
INSERT INTO `shop_wallet` VALUES (4, 1000020, 0, 0.00, 0.00, '2020-08-01 19:03:50', '2020-08-01 19:03:50');
INSERT INTO `shop_wallet` VALUES (5, 1000022, 1, 199.00, 800.00, '2020-08-01 19:54:44', '2020-08-01 19:54:44');
INSERT INTO `shop_wallet` VALUES (23, 1000029, 0, 0.00, 0.00, '2020-08-03 20:24:58', '2020-08-03 20:24:58');
INSERT INTO `shop_wallet` VALUES (24, 1000030, 0, 0.00, 0.00, '2020-08-03 21:36:31', '2020-08-03 21:36:31');
INSERT INTO `shop_wallet` VALUES (26, 1000013, 19, 204.99, 0.00, '2020-08-04 18:16:58', '2020-08-04 18:16:58');
INSERT INTO `shop_wallet` VALUES (27, 1000033, 0, 0.00, 0.00, '2020-08-05 10:28:09', '2020-08-05 10:28:09');
INSERT INTO `shop_wallet` VALUES (28, 1000034, 0, 0.00, 0.00, '2020-08-05 10:49:30', '2020-08-05 10:49:30');
INSERT INTO `shop_wallet` VALUES (29, 1000035, 7, 970.00, 840.00, '2020-08-05 11:53:43', '2020-08-05 11:53:43');
INSERT INTO `shop_wallet` VALUES (30, 1000060, 0, 0.00, 0.00, '2020-08-06 11:23:25', '2020-08-06 11:23:25');
INSERT INTO `shop_wallet` VALUES (31, 1000063, 0, 0.00, 0.00, '2020-08-06 11:59:39', '2020-08-06 11:59:39');
INSERT INTO `shop_wallet` VALUES (33, 1000084, 0, 0.00, 0.00, '2020-07-31 17:41:04', '2020-07-31 17:41:04');
INSERT INTO `shop_wallet` VALUES (34, 1000028, 0, 0.00, 0.00, '2020-08-09 21:28:32', '2020-08-09 21:28:32');
INSERT INTO `shop_wallet` VALUES (35, 1000090, 0, 0.00, 0.00, '2020-08-10 13:13:55', '2020-08-10 13:13:55');
INSERT INTO `shop_wallet` VALUES (36, 1000095, 0, 0.00, 0.00, '2020-08-10 19:29:35', '2020-08-10 19:29:35');
INSERT INTO `shop_wallet` VALUES (37, 1000099, 2, 81.00, 0.00, '2020-08-10 21:56:25', '2020-08-10 21:56:25');
INSERT INTO `shop_wallet` VALUES (38, 1000065, 0, 0.00, 0.00, '2020-08-10 21:57:50', '2020-08-10 21:57:50');
INSERT INTO `shop_wallet` VALUES (39, 1000106, 5, 65.00, 175.00, '2020-08-11 10:02:08', '2020-08-11 10:02:08');
INSERT INTO `shop_wallet` VALUES (40, 1000069, 0, 0.00, 0.00, '2020-08-11 11:12:47', '2020-08-11 11:12:47');
INSERT INTO `shop_wallet` VALUES (41, 1000008, 0, 0.00, 0.00, '2020-08-11 18:22:03', '2020-08-11 18:22:03');
INSERT INTO `shop_wallet` VALUES (42, 1000016, 0, 0.00, 0.00, '2020-08-12 16:33:24', '2020-08-12 16:33:24');
INSERT INTO `shop_wallet` VALUES (43, 1000100, 0, 0.00, 0.00, '2020-08-13 21:23:14', '2020-08-13 21:23:14');
INSERT INTO `shop_wallet` VALUES (44, 1000148, 0, 0.00, 0.00, '2020-08-18 18:48:16', '2020-08-18 18:48:16');
INSERT INTO `shop_wallet` VALUES (45, 1000166, 0, 0.00, 0.00, '2020-08-25 12:15:17', '2020-08-25 12:15:17');
INSERT INTO `shop_wallet` VALUES (46, 1000172, 0, 0.00, 0.00, '2020-08-31 21:09:38', '2020-08-31 21:09:38');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `class_id` int(10) UNSIGNED NOT NULL COMMENT '字典编号',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字典说明',
  `class_value` json NOT NULL COMMENT '字典值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统参数' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 1, 'mainpage_max_url', '6');
INSERT INTO `system_config` VALUES (2, 2, 'mainpage_max_spec', '10');
INSERT INTO `system_config` VALUES (3, 3, 'mainpage_max_category', '7');
INSERT INTO `system_config` VALUES (4, 4, 'mainpage_scroll_image', '[\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image1.jpg\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image2.jpg\", \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image3.jpg\"]');
INSERT INTO `system_config` VALUES (5, 5, 'exchange_rate_list', '[{\"code\": \"CNY\", \"name\": \"人民币\"}, {\"code\": \"USD\", \"name\": \"美元\"}, {\"code\": \"JPY\", \"name\": \"日元\"}, {\"code\": \"EUR\", \"name\": \"欧元\"}, {\"code\": \"GBP\", \"name\": \"英镑\"}, {\"code\": \"KER\", \"name\": \"韩元\"}, {\"code\": \"HKD\", \"name\": \"港币\"}]');

-- ----------------------------
-- Table structure for system_express_company
-- ----------------------------
DROP TABLE IF EXISTS `system_express_company`;
CREATE TABLE `system_express_company`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `express_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递编码(快递鸟)',
  `express_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '快递公司名称',
  `exoress_code_kd100` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递编码(快递100)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统快递公司资料' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_express_company
-- ----------------------------
INSERT INTO `system_express_company` VALUES (1, 'SF', '顺丰速运', 'shunfeng');
INSERT INTO `system_express_company` VALUES (2, 'HTKY', '百世快递', 'huitongkuaidi');
INSERT INTO `system_express_company` VALUES (3, 'ZTO', '中通快递', 'zhongtong');
INSERT INTO `system_express_company` VALUES (4, 'STO', '申通快递', 'shentong');
INSERT INTO `system_express_company` VALUES (5, 'YTO', '圆通速递', 'yuantong');
INSERT INTO `system_express_company` VALUES (6, 'YD', '韵达速递', 'yunda');
INSERT INTO `system_express_company` VALUES (7, 'YZPY', '邮政快递包裹', 'youzhengguonei');
INSERT INTO `system_express_company` VALUES (8, 'EMS', 'EMS', 'ems');
INSERT INTO `system_express_company` VALUES (9, 'HHTT', '天天快递', 'tiantian');
INSERT INTO `system_express_company` VALUES (10, 'UC', '优速快递', 'youshuwuliu');
INSERT INTO `system_express_company` VALUES (11, 'DBL', '德邦快递', 'debangkuaidi');
INSERT INTO `system_express_company` VALUES (12, 'ZJS', '宅急送', 'zhaijisong');

-- ----------------------------
-- Table structure for test_db
-- ----------------------------
DROP TABLE IF EXISTS `test_db`;
CREATE TABLE `test_db`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `type_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `passwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  `gender` enum('one','two') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `birthday` datetime(0) NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT NULL,
  `detial` json NULL,
  PRIMARY KEY (`id`, `type_id`) USING BTREE,
  UNIQUE INDEX `uix_test_db_email`(`email`) USING BTREE,
  INDEX `idx_test_db_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_db
-- ----------------------------

-- ----------------------------
-- Table structure for third_party
-- ----------------------------
DROP TABLE IF EXISTS `third_party`;
CREATE TABLE `third_party`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `third_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `third_account_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `third_account_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of third_party
-- ----------------------------
INSERT INTO `third_party` VALUES (1, '快递鸟', '1653950', '64a4081f-ecbb-471f-90e8-37c42fe54796', '2020-06-30 16:48:18');
INSERT INTO `third_party` VALUES (2, '快递100', '2BEA0ED9C9D87994062A3BE3F62C4590', 'FWLHzPYR8520', '2020-06-30 16:48:43');

-- ----------------------------
-- Table structure for third_party_interface
-- ----------------------------
DROP TABLE IF EXISTS `third_party_interface`;
CREATE TABLE `third_party_interface`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `third_party_id` int(11) NOT NULL COMMENT '第三方接口平台id',
  `third_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '第三方接口名称',
  `third_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '第三方接口url链接',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '编辑时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '第三方快递接口' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of third_party_interface
-- ----------------------------
INSERT INTO `third_party_interface` VALUES (1, 1, '物流查询', 'https://api.kdniao.com/Ebusiness/EbusinessOrderHandle.aspx', '2020-06-30 16:31:05');
INSERT INTO `third_party_interface` VALUES (2, 2, '物流查询', 'https://poll.kuaidi100.com/poll/query.do', '2020-06-30 16:31:05');
INSERT INTO `third_party_interface` VALUES (3, 1, '电子面单', 'http://api.kdniao.com/api/EOrderService', '2020-06-30 16:31:05');
INSERT INTO `third_party_interface` VALUES (4, 2, '电子面单', 'http://poll.kuaidi100.com/eorderapi.do', '2020-06-30 16:31:05');
INSERT INTO `third_party_interface` VALUES (5, 2, '推送接口', 'https://cwyx.chengyouhd.com/daigou/api/v1/order/pushQueryDataKd100', '2020-07-14 16:00:41');
INSERT INTO `third_party_interface` VALUES (6, 1, '轨迹订阅', 'https://api.kdniao.com/api/dist', '2020-07-14 16:01:21');
INSERT INTO `third_party_interface` VALUES (7, 2, '轨迹订阅', 'https://poll.kuaidi100.com/poll', '2020-07-14 16:01:53');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1000173 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1000000, 1, '', 'otZjk5E4ZOgYuxrg8KsPviXtMk_g', '', '小丰', 'https://wx.qlogo.cn/mmopen/vi_32/icHqK2ibFnT75plgkDFqwysicutW69ypxcIWfpucHerRq3r9BIChvKDReuRkEqia9IHgBjxa7byBwWQwSF14ZMddcg/132', '1000000/20208060920/3k8cja0le00c4pip69eg3x03d01a8v2m.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18746191484', '86', '2020-07-31 17:07:12', '2020-07-31 17:07:12', NULL);
INSERT INTO `user` VALUES (1000001, 1, 'oC-0nuNij1PMJJmcRNaTydugUaio', 'otZjk5A5_IsTBaa2kC51ZUL-PmFE', 'oGstJwDFpUkhpUmnCo7CtwHskIXU', '吴笛💦', 'https://thirdwx.qlogo.cn/mmopen/vi_32/6MoHmqhkdyOwoGsJlELINVYbB9yNhFfp5nJibLfAFetxrFfJMmmpGTMjHMgOmPichcnQDvjj7jhBNg2FicFoTHCmQ/132', '1000001/20208052107/3k8cja0ldz0c4p33v2x2e5cl00vgycot.jpg', 1, 'Austria', 'Vienna', '', 'zh_CN', 1000017, '15873231388', '86', '2020-07-31 17:37:47', '2020-07-31 17:37:47', NULL);
INSERT INTO `user` VALUES (1000002, 1, '', 'otZjk5EKGiu2dpoux_5LokIh_nUU', '', '低调', 'https://thirdwx.qlogo.cn/mmopen/vi_32/zEzJYYyj4plxKBKYayn4mlLiaiaNNOm5fjbd2UMvTTRtTqoY70TRDc2NpWhLK4Bic2M3f47fnucknX2csGrgrPPGQ/132', '', 1, 'China', 'Gansu', 'Lanzhou', 'zh_CN', NULL, NULL, '86', '2020-07-31 17:38:34', '2020-07-31 17:38:34', NULL);
INSERT INTO `user` VALUES (1000003, 1, '', 'otZjk5LC7KYJLCcNB_Y13mOBnXyI', '', '超_越梦想', 'https://wx.qlogo.cn/mmopen/vi_32/qYIqibSGuqs1Mx6mSCSxibl4GDiaxO5Cftj4fBByBRdFG60RL4GtupGKnNGDCRQxGKeoklGiaGR561juhWGQIxjB9w/132', '', 2, 'China', 'Shandong', 'Yantai', 'zh_CN', NULL, NULL, '86', '2020-07-31 17:38:34', '2020-07-31 17:38:34', NULL);
INSERT INTO `user` VALUES (1000006, 1, 'oC-0nuIOOXo31zHB8aqqTawjshBk', 'otZjk5OCsixqaz71IUyURT5Z0lh4', '', '易葱', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJRyko4M7WjCGiaxwHo4LTRtxYZ99reqMgiblGrhTqPaUHN1spL6h4icPlMBianzSt9RE2uolvZyNvkDw/132', '1000006/20208061559/3k8cja0h6j0c4pr6vfncf9x2n0an3o1e.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000013, '13212713350', '86', '2020-07-31 17:50:56', '2020-07-31 17:50:56', NULL);
INSERT INTO `user` VALUES (1000008, 4, 'oC-0nuIU5lal-fpRt1pyTme2B9Vs', 'otZjk5JMo_dL3SnOgaXOeBtUijmU', '', '緣', 'https://thirdwx.qlogo.cn/mmopen/vi_32/pldHJtJTYWWowic3f4Oia1ebtkZa5AOqbXefVVuHLibLDGNMSibQPDnhcfvJib1xIhSXbrNDU5icWW1jSGgfpxMIIXxw/132', '1000008/20208061746/3k8cja0h6k0c4ptgm62tz3r4301dywbd.jpg', 1, 'Azerbaijan', '', '', 'zh_CN', 1000017, '15338753605', '86', '2020-07-31 17:53:13', '2020-07-31 17:53:13', NULL);
INSERT INTO `user` VALUES (1000009, 1, '', 'otZjk5GUbNVK4a_FziLG9AUZKXMg', '', '豆豆比比boy啵啵啵几你哦啵啵啵', 'https://wx.qlogo.cn/mmopen/vi_32/c46Go5PT22axt0soxGWcw9wNqlQhvDbjqR2ozelHYL5icgiaMQ7eUsK7w8AgDe4o1VjbJlLmxTQvrdqOuCZx62rg/132', '', 1, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-07-31 18:34:35', '2020-07-31 18:34:35', NULL);
INSERT INTO `user` VALUES (1000010, 1, '', 'otZjk5NlSOFOhzgm7wL-Xoa3rt84', '', '魏剑帆', 'https://wx.qlogo.cn/mmopen/vi_32/C3DHCUWr60Hq1sib13FtbQJYnKoUDHhkCCgqpb3BkQA38pQkiclgic7bCXMAM3llIE3icESSpKIYgnGPfiaT32abCaA/132', '1000010/20208051752/3k8cja0ldz0c4oyyp7h1zwnc00rod6lq.jpg', 1, 'China', 'Guangdong', 'Guangzhou', 'zh_CN', NULL, NULL, '86', '2020-07-31 22:12:24', '2020-07-31 22:12:24', NULL);
INSERT INTO `user` VALUES (1000011, 1, '', 'otZjk5BtThg3jK2iFpDHK7sp9iwc', '', '蓝色妖姬', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEISG4CExma3fp8fms3vQR56Y3F1A1tr5vxe7G2jYb1UjKibgyRTVx9NlwWBHbaTKL0FLujSHYKr3PA/132', '', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, NULL, '86', '2020-07-31 22:12:24', '2020-07-31 22:12:24', NULL);
INSERT INTO `user` VALUES (1000012, 1, '', 'otZjk5LjaSM8ts_NMePfOHKSNgr4', '', '扶摇小沙弥', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erj2mubhU0fSHKmse53grcF7eIINJTqq5HOGGk0AAonTUHyy0QQYTibTmwiaTLphajeyb8Pexd4EAqw/132', '', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '17620372006', '86', '2020-07-31 22:25:33', '2020-07-31 22:25:33', NULL);
INSERT INTO `user` VALUES (1000013, 5, 'oC-0nuODekWrNvNeG0EyQp5WPK18', 'otZjk5N_jH5MMT8nY4Vfs80trawM', 'oGstJwDKHCMh4NcB7Rod7kHTdkGY', '夕雨林径', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIIDUnsfAibxPVaoRwficcs3H5dicO0FU54ezZGy1roVLzZIwJ17ibic5uAlU4iaGPLsQvtXwErfB7FFsjQ/132', '1000013/20208051600/3k8cja0anq0c4owl4mo13vx7004cky21.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 0, '13246711966', '86', '2020-08-01 15:08:21', '2020-08-01 15:08:21', NULL);
INSERT INTO `user` VALUES (1000014, 1, '', 'otZjk5C_UV_JGeJEprfDZAG6GAPY', '', '阿梨儿', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJhTjz1nImC6DEWgpfHxtibYaoaJG7TBfxq8h5BkBcdZsqActQSdMoyoYunE8l26DPoRCibIDJyloIw/132', '1000014/20208052252/3k8cja0ldz0c4p5cdmx4dqr150glvow1.jpg', 2, 'Ireland', 'Offaly', '', 'zh_CN', 1000035, '13332916245', '86', '2020-08-01 16:05:18', '2020-08-01 16:05:18', NULL);
INSERT INTO `user` VALUES (1000016, 4, '', 'otZjk5HAJUQKlo91dpfG9t3593QQ', '', 'Chris', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eq1JiaI32hEusibl96Rf5BjlX2AtR37QZNqYlJUbF9CkjMQvadUPQ1ylwCZgsUAP6hibJC9FR7DibIyVQ/132', '1000016/20208121633/3k8cja0n0v0c4uvnwu84uxb2y0gl0j2c.jpg', 1, 'Finland', '', '', 'zh_CN', 0, '15099900112', '86', '2020-08-01 16:33:33', '2020-08-01 16:33:33', NULL);
INSERT INTO `user` VALUES (1000017, 5, 'oC-0nuOVvQlasbyY4hP7ffc6ftWU', 'otZjk5NYS-qZlGNxRJfzvVR54pzc', 'oGstJwB_Vzt4W5RYGTesHSSMJOGs', '龙啊', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erKQqC4tKaCKjT9J6dXvcmfTicHvmPIdMfDY4AADfcnMFUbPATZYtRhVVfDDdnMcRQ6ERnuhmaRA0Q/132', '1000017/20208101537/3k8cja05uu0c4t57sjgme9k2d0oq13el.jpg', 1, '', '', '', 'zh_CN', 0, '18822861951', '86', '2020-08-01 18:15:55', '2020-08-01 18:15:55', NULL);
INSERT INTO `user` VALUES (1000018, 5, '', 'otZjk5LKhUmfXWBk-ohAVM3yIr_s', '', '凡羽', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIqKibdaFia5LZiaHnWblNlsJxlDq0RUK4RIac3gakPupHTkCvZh6kNOOhCDibGaeXmtGms5MMm5WcYuA/132', '1000018/20208101005/3k8cja05uv0c4sy5wzc2sb4240o85hpo.jpg', 1, 'Ukraine', 'Kharkiv', '', 'zh_CN', 0, '15001977677', '86', '2020-08-01 18:39:12', '2020-08-01 18:39:12', NULL);
INSERT INTO `user` VALUES (1000019, 1, '', 'otZjk5Bv-NnqqGSlI7bBHBHcKwxQ', '', '范宇', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83er8TFBQIGe3mL3ric02dkEf0U9t975sj7Qh2ribaHcFa1rqprOHcZtE15S8gGSO4QOpRMmbgv0licIQw/132', '1000019/20208061201/3k8cja0h6k0c4pm4m53kut1k00qc05a1.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000018, '13360538662', '86', '2020-08-01 18:41:09', '2020-08-01 18:41:09', NULL);
INSERT INTO `user` VALUES (1000020, 4, '', 'otZjk5LzmXYDOL218sC4PyzeL6bc', '', '蒋小姐', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIwLOgXjFK3NAkWsRhzX33yWHGsEzSebZAj7DDicDAagWDzSEu5ia7pu0BYIsHG7ZoibhwksVzgicdzIA/132', '', 2, 'China', 'Fujian', 'Fuzhou', 'zh_CN', 0, '18650522022', '86', '2020-08-01 19:01:41', '2020-08-01 19:01:41', NULL);
INSERT INTO `user` VALUES (1000022, 4, '', 'otZjk5Mf7MRvszHi0jtmdYi8iru8', '', 'Elaine_可预定，不接急单', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIkQRI4Y9SolYQVhbH9Q3Hj2kN9ekX1nT9nKqZ6icZXiaicrxOqIqSJF9RqCaZibI79911xMXKv1Ww5nQ/132', '1000022/20208110144/3k8cja01l60c4ti4mww7z6h120wz9pzr.jpg', 2, 'Hong Kong', 'Yau Tsim Mong', '', 'zh_CN', 0, '13145906814', '86', '2020-08-01 19:54:33', '2020-08-01 19:54:33', NULL);
INSERT INTO `user` VALUES (1000023, 1, '', 'otZjk5B7hTDgDzizTj1GhUtii_Ms', '', '向元', 'https://wx.qlogo.cn/mmopen/vi_32/JuvFUdFKfW1YfrqVWafHS7EkYkKRR3Y72o6I0sEYnFoSCzt9aQ5yH0rYwGeICfwqTQAQjrDGciacDmzx9mYjnHQ/132', '', 0, '', '', '', 'zh_CN', 1000017, NULL, '86', '2020-08-01 21:37:02', '2020-08-01 21:37:02', NULL);
INSERT INTO `user` VALUES (1000024, 1, '', 'otZjk5Oyt9ujzidwtsv4VNl8Wnjw', '', '2020年了', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epClKibRo5Wia95LhkCklMbMJoZ1kwZDbD4NypB6xmicHf8aicxaC5t1cuZSSvSUkNv1XZw6amb9xahJQ/132', '1000024/20208051508/3k8cja0m3x0c4ovh58vpfc5u00f8keli.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18617188606', '86', '2020-08-02 21:10:00', '2020-08-02 21:10:00', NULL);
INSERT INTO `user` VALUES (1000025, 1, '', 'otZjk5DGonMQEKttn1HtlIKplqCE', '', '緣', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJcoyoiayBvWZ1nTkUovOCNF05qw7Orjjz4mqo2mU6wH2zEt8ibLhdXyBtL1bqPKMlMTUIKQticT8FQw/132', '1000025/20208061611/3k8cja0h6j0c4prg7ghwcsb2r0agmfr8.jpg', 1, 'China', 'Henan', 'Zhengzhou', 'zh_CN', NULL, '13027795620', '86', '2020-08-03 10:38:51', '2020-08-03 10:38:51', NULL);
INSERT INTO `user` VALUES (1000027, 1, '', 'otZjk5JQIV9nlu9GxL5EBBn4Pdmw', '', '阳阳~Carrie', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqM9icfMVrQhYcALsGFWQLd1SGtLL95LTLwk3aMGqCCYib51LfjUMAmHOnyEb5lADCHbNIF6QuqWY2Q/132', '', 2, 'China', 'Hunan', 'Hengyang', 'zh_CN', 1000017, '18711496020', '86', '2020-08-03 12:01:08', '2020-08-03 12:01:08', NULL);
INSERT INTO `user` VALUES (1000028, 4, 'oC-0nuM92SMc8BkyMMxJj23FX-80', 'otZjk5C4id1TUwjNlRJgNcjrgDn0', 'oGstJwAU-wPLqyKwlWUN2hTZGCjE', '花花世界', 'https://wx.qlogo.cn/mmopen/vi_32/9mjKN9eFKKE4BAMxvXfnxqdm21ssrmpGdoItLFOHMDDg90ibxaxl0Qn9ib8zOapxprxyFmLBqFC1BS0a5icVqJHWQ/132', '1000028/20208061557/3k8cja0h6j0c4pr5hw7ului2k0yc631i.jpg', 2, 'Italy', 'Milano', '', 'zh_CN', 1000017, '13686891951', '86', '2020-08-03 16:45:43', '2020-08-03 16:45:43', NULL);
INSERT INTO `user` VALUES (1000029, 4, '', 'otZjk5GZ2ZJpHTu6HlER2DunKuLE', '', '石同学', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLjabDFIyO0kmABu4XiaPtmpGffWfYy53vR9Budy5bNtreOea0rjWT6eU5zlxPo0sClCHgqZaL414Q/132', '', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 0, '18761860431', '86', '2020-08-03 20:24:27', '2020-08-03 20:24:27', NULL);
INSERT INTO `user` VALUES (1000030, 4, '', 'otZjk5Jex_E14ZSGvQaqOyJgGw9w', '', '筱梅梅梅梅梅', 'https://wx.qlogo.cn/mmopen/vi_32/0STYrGw909HXDQhn96CXmbNIbNPnjr6Q1YazaJXiaib1W5NpCic4nceYyCQxqHhT3N6lCmcTTknWQ4G3HLaENYhTA/132', '', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 0, '18218658925', '86', '2020-08-03 21:34:26', '2020-08-03 21:34:26', NULL);
INSERT INTO `user` VALUES (1000031, 1, '', 'otZjk5GzwdJfg1Pqe4YL4MDT4ND8', '', 'degree', 'https://wx.qlogo.cn/mmopen/vi_32/BGOQYsq2jq6ZSX3wJpiax3KDGusXgKnic5Jb2e7VDCwcp2rA6wZ7JHFxCdw0gnM4j95n7szHH066EibgxHWpicInww/132', '', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '18062215836', '86', '2020-08-04 17:22:31', '2020-08-04 17:22:31', NULL);
INSERT INTO `user` VALUES (1000032, 1, '', 'otZjk5BA55ILE8vXOlCNwl20YYco', '', '辛福', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEKXP1HJ1DkJgKibyEMqzDuJwpjw41bJ2bKhbT2YMEn7XGlEYH2ywsYHg9QrdBCThle2hfHwLp2VSoQ/132', '', 2, 'China', 'Anhui', 'Xuancheng', 'zh_CN', NULL, NULL, '86', '2020-08-04 19:53:51', '2020-08-04 19:53:51', NULL);
INSERT INTO `user` VALUES (1000033, 4, '', 'otZjk5Fs41tQW-VyI-zc60EsrN9w', '', 'S+国际美业创始人 | 刘春燕', 'https://wx.qlogo.cn/mmopen/vi_32/0aBeicBPiaqQ8akN40pJ9zKbCFKiab3F4kxFf99GOrjXRsjJfpfoKe4zgcvyN6FXXpQuNfaLqovHibXkVwsHYxGl3A/132', '', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '13924647089', '86', '2020-08-05 10:27:35', '2020-08-05 10:27:35', NULL);
INSERT INTO `user` VALUES (1000034, 4, '', 'otZjk5NaalqVDrH-XwzZw1SV8paE', '', 'S+国际美业培训院长 | 雷艳', 'https://wx.qlogo.cn/mmopen/vi_32/NYr8FDOHV2V32IpHvM4QqX3hbgsYKkkB1xk1f5Hia00pBNSQyiclCwoHb2pVMNW3VawexugEeVqevMWzD2GJ7CPA/132', '', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '13902967095', '86', '2020-08-05 10:48:24', '2020-08-05 10:48:24', NULL);
INSERT INTO `user` VALUES (1000035, 5, 'oC-0nuEFngHcQR-FTenc8oCHEmKE', 'otZjk5Lm5QniuGXys4YJHcF5MMZM', 'oGstJwLJzZISkPYK1SeG1CkCweM8', '空山石', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqVsVo8VTu4HQexLHmNDTPY5Igd8vPyNliaBcBWicZKBBaI3ib0VSl4ichbHQdVbn4Hx5dryiaxYjPv4Iw/132', '1000035/20208111847/3k8cja0n0u0c4u3w63ijl4x200b5dime.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '18565619395', '86', '2020-08-05 11:44:49', '2020-08-05 11:44:49', NULL);
INSERT INTO `user` VALUES (1000036, 1, '', 'otZjk5Eb6gOIyof6z-q-RFmwDyic', NULL, 'happiness', 'https://wx.qlogo.cn/mmopen/vi_32/gTZDnOBfUUzTfQycibH4dQfFrIb05woeicGpdP7VLlu8mRR7gLWqgQCVAMOwsib5jzRO0bRwrRDm4QUEIHhK916lg/132', NULL, 0, '', '', '', 'zh_CN', 1000017, '15989507146', '86', '2020-08-05 17:43:42', '2020-08-05 17:43:42', NULL);
INSERT INTO `user` VALUES (1000037, 1, '', 'otZjk5CI5UGal3Vw8lJGnrkFCrcc', NULL, '母笑阳', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaELKb5NUYGaRDO2wbN1mdjYB9ckPGmt7ESQHOKC38iaFYCSRx9ibw3O0DjnEZbF6zFXzpLn9ibuJD5sHg/132', NULL, 2, 'China', 'Hebei', 'Baoding', 'zh_CN', NULL, NULL, '86', '2020-08-05 20:34:28', '2020-08-05 20:34:28', NULL);
INSERT INTO `user` VALUES (1000038, 1, '', 'otZjk5Lf1wYJuYBcrn_ZY-AB2LIQ', NULL, '10.11', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKuJK7V6618fhC6ibQ7Og1XAT83HeyIr6aw5hYLqGvoMAibb8JWsHuD4A1CuYEicmptFgV1Sx5sPLDXg/132', '1000038/20208052034/3k8cja0le00c4p2eqnvlilyh00rhff36.jpg', 2, 'China', 'Hebei', 'Shijiazhuang', 'zh_CN', NULL, NULL, '86', '2020-08-05 20:34:28', '2020-08-05 20:34:28', NULL);
INSERT INTO `user` VALUES (1000039, 1, '', 'otZjk5LgKPCVxMiUIEjkgU9aDoXk', NULL, '达达', 'https://wx.qlogo.cn/mmopen/vi_32/lDpPEwvELPrVexZy13zwsmuyXpvvRdg5iaXQmJPSibCuLrUTsWLMiaH2vc51lRJaT22zMNdes49KlbicuAz6ct8iciaA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000035, '18123686751', '86', '2020-08-05 21:21:40', '2020-08-05 21:21:40', NULL);
INSERT INTO `user` VALUES (1000040, 1, '', 'otZjk5HyehRzPd6h6psFzgDzTF6k', NULL, ' ', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eosk2Wekqf0OnOKWI8GZKBzMia5JicS2W7pU5WENj06qwvcqvlqgicXXlG0kU0rIxr587aw0mxicsDtew/132', '1000040/20208060818/3k8cja0le00c4phdcnhfmif310gk4bcv.jpg', 1, 'China', '', '', 'zh_CN', 1000017, '18565710771', '86', '2020-08-05 21:29:53', '2020-08-05 21:29:53', NULL);
INSERT INTO `user` VALUES (1000041, 1, '', 'otZjk5IiI4hTjO79Rfsh3nPKwjX0', NULL, '牛牛仔', 'https://wx.qlogo.cn/mmopen/vi_32/fIm9Xlr2KSyLEr8nAMM2BQyCsMglhO2DkwJkffkhrjkpkd4os90ibh65NwqRkd1B7pr51Nn9W0TgQgnumKZFA4Q/132', NULL, 0, '', '', '', 'zh_CN', NULL, '18856376587', '86', '2020-08-05 21:54:15', '2020-08-05 21:54:15', NULL);
INSERT INTO `user` VALUES (1000042, 1, '', 'otZjk5E4khV8eODZFXnFlb8UC0tI', NULL, '阿奇', 'https://wx.qlogo.cn/mmopen/vi_32/fGRXkjiaUBiaUQg26IZJnLspriaph8iacB6hfrNCiaaGWN4ntLtKO5icOdX8ee4ecdkzHeuWR5FibtNBR1vibxusqwVvGA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000035, '18126275189', '86', '2020-08-05 22:00:00', '2020-08-05 22:00:00', NULL);
INSERT INTO `user` VALUES (1000043, 1, '', 'otZjk5KB0JfdN8a8P3TrHFjcMAgU', NULL, '(-:勤:-)', 'https://wx.qlogo.cn/mmopen/vi_32/3LWl0Okrb4dcPIyHar35ATpcC8zqQ63UwCH7j8HZSeIUJJCKT25Aiby0icLNZjxEibwfgLK0ScJtwj1iaO8mV66ib5g/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '17788978338', '86', '2020-08-05 22:00:42', '2020-08-05 22:00:42', NULL);
INSERT INTO `user` VALUES (1000044, 1, '', 'otZjk5MJMU_dsFTOlII7t7gNgp_s', NULL, '童小飞', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoZ6aTRclVXDcMVaGLdIlq39A9xjVCaVuiao9x75D4t9oQqGxnicVRao3sNU8ibY9jVUcbCT1W3ocNMA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18565672367', '86', '2020-08-05 22:01:13', '2020-08-05 22:01:13', NULL);
INSERT INTO `user` VALUES (1000045, 1, '', 'otZjk5EtLl1iIapkTKUEZ-6hvsv8', NULL, '老麦', 'https://wx.qlogo.cn/mmopen/vi_32/Rflbia3c3hh7IHrvLIz3tER3icib0KkA0ACyvEbsibC5MgzV9k5QgX35elrhHZz6AKDC1HEibibH4mL1AWxzesPrGSdQ/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13560493783', '86', '2020-08-05 22:01:56', '2020-08-05 22:01:56', NULL);
INSERT INTO `user` VALUES (1000046, 1, '', 'otZjk5DZ3_CIAwsS5gaEXx3ax-Yg', NULL, '犀 首', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epob6sfz1siamf2WcyicjsFHQbTqqWVPhcUMEMl5q6V2w1FdjpWib5TFHtssiaQCDQYDfl5opeUCicCGXQ/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13113613219', '86', '2020-08-05 22:06:50', '2020-08-05 22:06:50', NULL);
INSERT INTO `user` VALUES (1000047, 1, '', 'otZjk5KX4Q6VeITfVk3zefNpdirA', NULL, '木叶（立军）', 'https://wx.qlogo.cn/mmopen/vi_32/EbeanVwQqmrAU7BEg8uRcFKn9y4gU2N9SxGqqMUWtrcCuYX1FkO4Okl6r0afesiasadU4wPGKzbRz8TkFFqibmeQ/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '15118120915', '86', '2020-08-05 22:20:45', '2020-08-05 22:20:45', NULL);
INSERT INTO `user` VALUES (1000048, 1, '', 'otZjk5OX29k-pNR-UvMuclW1qgII', NULL, '韩平梅', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLY9tH2SDicHcYKkQWnx75Bic69ib6NZrMUZrTeR1kFRrPnwFko6r2O104yPMmIduRFq3icFBAwhIJF4A/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13590219085', '86', '2020-08-05 22:26:41', '2020-08-05 22:26:41', NULL);
INSERT INTO `user` VALUES (1000049, 1, '', 'otZjk5ARmOTgU2QY1ajM6zo69V4E', NULL, 'wuyu.', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJfic3yUNdDhjibibojVfAb8ezSeDbSvAfF5ZnTgspPdfNZibNYWsfbeeVOq8WHdtHQ1WiaeyoZqW2INEw/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '17704026019', '86', '2020-08-05 22:33:05', '2020-08-05 22:33:05', NULL);
INSERT INTO `user` VALUES (1000050, 1, '', 'otZjk5CiktIdy0yyOdyOvPbE-nKM', NULL, '双儿', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEILxkBTDbsiaicFDlICHy1UEuqbMxCv63wuibibstfZiags4xDSbQMP9UTicJtNrGtJ6uic2JmyA4NdFmuRw/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '15815545228', '86', '2020-08-05 22:49:32', '2020-08-05 22:49:32', NULL);
INSERT INTO `user` VALUES (1000051, 1, '', 'otZjk5LgIrZOfp56oqN6ViUkPV7M', NULL, '陈建毅', 'https://wx.qlogo.cn/mmopen/vi_32/lJu6F9jibXaQbZ3CxJGFlBOew0en1uwNKKB8pFsjG58IGIBzZFOsJQ3ToR94Wclp81JKNwUvyjEs7UxOl8yHg6A/132', '1000051/20208052301/3k8cja0le00c4p5jd58iedr1i0y4o2xp.jpg', 1, 'China', 'Guangxi', 'Guigang', 'zh_CN', 1000017, '15277185213', '86', '2020-08-05 22:59:47', '2020-08-05 22:59:47', NULL);
INSERT INTO `user` VALUES (1000052, 1, '', 'otZjk5DgpysdPhnTz5etWbZtuyXw', NULL, '我不是大V是小v呀', 'https://wx.qlogo.cn/mmopen/vi_32/6KiaaXvPRNGibkU0yzN3enhuiaKRhjoAy4hFPwuRzCGKtIJg3jibRniawl1KaGWAlqaicZoRBM99zjoialYfmMr4IafDA/132', '1000052/20208052300/3k8cja0ldz0c4p5i7o5cufu1707uv9dd.jpg', 2, 'Zambia', '', '', 'zh_CN', 1000017, '18373708035', '86', '2020-08-05 22:59:58', '2020-08-05 22:59:58', NULL);
INSERT INTO `user` VALUES (1000053, 1, '', 'otZjk5JKJtc0mdj6yokF-WmxmsdQ', NULL, '灵幽^o^子涵', 'https://wx.qlogo.cn/mmopen/vi_32/E3FGuN7oL5RoJO1r0QVThbkI5uToDEsPdNZylHH38PvtLHg87iaP9zZKnJ6VYzYNbGibsctRqbGXabfrzgUltOaQ/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '15829310799', '86', '2020-08-05 23:04:08', '2020-08-05 23:04:08', NULL);
INSERT INTO `user` VALUES (1000054, 1, '', 'otZjk5Mvs6Xr_QZrO_dK9mbX3TdQ', NULL, '指缝流年', 'https://thirdwx.qlogo.cn/mmopen/vi_32/MdmRMTV2IwsO3GlRNT6EqpAWPMUu4BplmFia6pJtLiaIWX34WNdYfQZP2XgVBcgqQZDSXugxiaJB67BQ3N6B1cvXg/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13689580681', '86', '2020-08-05 23:53:03', '2020-08-05 23:53:03', NULL);
INSERT INTO `user` VALUES (1000055, 1, '', 'otZjk5OE9Y3UYka2hcCE4V7xf42k', NULL, '黄磊', 'https://wx.qlogo.cn/mmopen/vi_32/UCV01twwgZCwtMOghGWWSxLEv6FoN9pe1u9760eicbUjCWmicWMQnpGqdXzyv12Dqicj8diaR2qLbErPB5ia41jcWMg/132', NULL, 1, 'China', 'Gansu', 'Lanzhou', 'zh_CN', 1000017, '18893177223', '86', '2020-08-06 06:30:31', '2020-08-06 06:30:31', NULL);
INSERT INTO `user` VALUES (1000057, 1, '', 'otZjk5BmxdfOxAeNWchgBabZrzu8', NULL, 'susu', 'https://thirdwx.qlogo.cn/mmopen/vi_32/xLZOUD1IwrFiaSOPz2ib7KYpmvdaT2QKZ8CJ3DWAbyTf4HlibBsqxdTTd5pHiaNdNuNJbkHosvP4EhwuXKpejsKtww/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18824307739', '86', '2020-08-06 10:23:56', '2020-08-06 10:23:56', NULL);
INSERT INTO `user` VALUES (1000058, 1, '', 'otZjk5Ce5ryOvoW1EEL-AP7VxUgw', NULL, '金大欢', 'https://wx.qlogo.cn/mmopen/vi_32/Cwpsph5kL3whY2wtL6LlsrSiceuQjAgTwEptjIZSBvFFlWAHEjzuohvibyYhby1f8bVhQNXkBKia8Y6OmPHmXPeoA/132', NULL, 2, 'China', 'Beijing', 'Haidian', 'zh_CN', 1000017, '18710829596', '86', '2020-08-06 10:41:24', '2020-08-06 10:41:24', NULL);
INSERT INTO `user` VALUES (1000060, 5, '', 'otZjk5LghYfiLOlXRAubaKJc9A9E', NULL, 'WANG', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ertk75alPq0yAsbpRu9YUBVLDUs3t2ibdbJGiaIvOqEj99xImb3JZJWfPWQVzdn6iczQLeI5BlD4rxjA/132', '1000060/20208061123/3k8cja0h6k0c4plbb8scm9l400sxi7um.jpg', 1, 'China', '', '', 'zh_CN', NULL, '17716874547', '86', '2020-08-06 11:23:15', '2020-08-06 11:23:15', NULL);
INSERT INTO `user` VALUES (1000062, 1, '', 'otZjk5OFM3u4dsklVTKh7GwIvoq0', NULL, 'VIIIOIIIII', 'https://wx.qlogo.cn/mmopen/vi_32/17Cya8bpC805JF23KLCCebBNqnfNuE8ZwW8uxVrLNHhV9Hgg3p1XVRCUVK8o3HxUr6uaDDmtmJ1iauzaFAewUgQ/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18126179970', '86', '2020-08-06 11:56:47', '2020-08-06 11:56:47', NULL);
INSERT INTO `user` VALUES (1000063, 4, '', 'otZjk5BhH4wHIvEBUs84zpJyj6cU', NULL, '子驹', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo3ppzcib2IibS2iby1RRAJlJ0aHRWbHspLZqnYJzFusHqactc8Z9GuvU1DvJBKvI9g7IaSFic1N9nAdw/132', NULL, 1, 'China', 'Shanghai', 'Pudong New District', 'zh_CN', NULL, '15821310321', '86', '2020-08-06 11:57:11', '2020-08-06 11:57:11', NULL);
INSERT INTO `user` VALUES (1000064, 1, '', 'otZjk5IxtnWhNdu9TZoP8HFiPgtc', NULL, '娇儿', 'https://thirdwx.qlogo.cn/mmopen/vi_32/XLBy4aae1ZcT4oJLUmlId5y90ibV1dmLdxP9ZgvVRCVnmscqN0wuFicXjXC67licLcqW443dHekPRK9BNWvzeY84A/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18682443968', '86', '2020-08-06 12:33:46', '2020-08-06 12:33:46', NULL);
INSERT INTO `user` VALUES (1000065, 4, '', 'otZjk5Bil_vHyAmpL45eLwNDZeuU', NULL, '泡芙小姐', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL2GBvNwxu4PV7QswdXrBl0ZzuoGI6Ju51xYrS6BvlTvfTSCkpoRmbYJKekDBVfoMwG2YsSYlx2vA/132', '1000065/20208061243/3k8cja0h6j0c4pn08l7tiy71306y829f.jpg', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000013, '18370998072', '86', '2020-08-06 12:42:44', '2020-08-06 12:42:44', NULL);
INSERT INTO `user` VALUES (1000066, 1, '', 'otZjk5MFT9hSyfUhjgQSCWxXLEPo', NULL, '刘杨', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLp1nXU5730M8gkh85BdDAd15CgDicpHtx3e3RQeQvJAND4kZlLzh88ypu6RE1b6K0XwtPNnbJTO4w/132', '1000066/20208061305/3k8cja0h6j0c4pnhry6qvkp1807k753m.jpg', 1, 'China', 'Jiangxi', 'Pingxiang', 'zh_CN', 1000013, '18270825165', '86', '2020-08-06 13:04:17', '2020-08-06 13:04:17', NULL);
INSERT INTO `user` VALUES (1000067, 1, '', 'otZjk5J9FNVbjGRQZ8Zu7UWho4hM', NULL, '.', 'https://wx.qlogo.cn/mmopen/vi_32/0eVrZvOOzJ8bYiaibrhmIbPl0r4AJwEDH21fCS1gQqFEaaaqxkyJribR074R8Jp4ntVVcohxdOVpr3CKH4tOz0qAw/132', NULL, 1, 'China', 'Jiangxi', 'Pingxiang', 'zh_CN', 1000013, NULL, '86', '2020-08-06 13:06:27', '2020-08-06 13:06:27', NULL);
INSERT INTO `user` VALUES (1000068, 1, '', 'otZjk5Fe4AwbmUaas6vv_aqDzisU', NULL, '肖定华', 'https://thirdwx.qlogo.cn/mmopen/vi_32/2eZmFquVMibd0puxibWNgu6tXpfaIprAiad29T894EuzIOiaVWShKOR764lKjgCvTqjf6kJlklussbnc2ave5XkoVg/132', '1000068/20208061324/3k8cja0h6j0c4pnw2aqjns01c00nm24y.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '18680358860', '86', '2020-08-06 13:23:58', '2020-08-06 13:23:58', NULL);
INSERT INTO `user` VALUES (1000069, 4, '', 'otZjk5DOzEA8Y7j_jMJZVh2R9kec', NULL, 'lizy', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKtvZuqwGoTJSUvljFoVnNNDOVXk2nLTNSmOWaAhPHzCEUQckwSg5ia2L8wZQqdFYvKIxNOAauAxjQ/132', NULL, 1, 'China', 'Fujian', 'Xiamen', 'zh_CN', 1000013, '15170707821', '86', '2020-08-06 13:24:31', '2020-08-06 13:24:31', NULL);
INSERT INTO `user` VALUES (1000070, 1, '', 'otZjk5AsMhA1nz_-vWPitksSdiJg', NULL, '贰零贰零', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLJGyddcfUbHadJRQrkcQt4tpgLuR4KxgzKkXaaz2ic6CP2qGAHFWuo8U8fHD6LRCM9icQ9plI8V79w/132', '1000070/20208061442/3k8cja0h6j0c4ppjh526tiw1x0g8jatf.jpg', 1, 'China', 'Jiangxi', 'Pingxiang', 'zh_CN', 1000013, '18720083102', '86', '2020-08-06 14:36:49', '2020-08-06 14:36:49', NULL);
INSERT INTO `user` VALUES (1000071, 1, '', 'otZjk5AS6XX_vUNcEa0PxcGBibK4', NULL, '黑夜一盏灯', 'https://wx.qlogo.cn/mmopen/vi_32/oyiceDI6X7FWDateRuZ2MCicjRf2C17JoFPAGH99KU2fniaq96iaB4WfBSFe9ddFGXS6qmqq3HMtia1ibttB12jDiaS7Q/132', NULL, 1, 'China', 'Shanghai', 'Shanghai', 'zh_CN', 1000017, '18038003905', '86', '2020-08-06 17:04:36', '2020-08-06 17:04:36', NULL);
INSERT INTO `user` VALUES (1000072, 1, 'oC-0nuMi_jBuZW9ih2b5kcOhNanE', 'otZjk5GbwYXcbk64yRdJh01h0i2Y', NULL, '黎志杰', 'https://wx.qlogo.cn/mmhead/3EoJ3ibXlSCcc67GLeN0WJ6mjJwH4yibbza7sGjyzPNyE/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-07 05:37:00', '2020-08-07 05:37:00', NULL);
INSERT INTO `user` VALUES (1000073, 1, '', 'otZjk5AFKmFX5SqypD1kqRlSoaq0', NULL, '毛毛', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKYKibgWoMxQ2JGYDtQXsSrZ7YT7DrrTTNwT7j2wJ9KO1WcEoWVdTVkABTnOJockkIG7Myh1V3NpibQ/132', NULL, 0, '', '', '', 'zh_CN', NULL, '13802947724', '86', '2020-08-07 05:37:13', '2020-08-07 05:37:13', NULL);
INSERT INTO `user` VALUES (1000074, 1, '', 'otZjk5H6vyfs4kSN4B6dxcLWgIa8', NULL, '无痕', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJBPBibnxNBRugEibchc9K8GjpSnewXiaeQKER8gU5DNrbNuvVRfz0rjW8fUYqrbxXabWoEAcebErbVA/132', NULL, 1, 'China', 'Guangdong', 'Zhuhai', 'zh_CN', 1000017, '18578209656', '86', '2020-08-07 11:24:55', '2020-08-07 11:24:55', NULL);
INSERT INTO `user` VALUES (1000075, 1, '', 'otZjk5Pb4EYvNaQ5faQt9RN09xT4', NULL, 'oooo!', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLsJxCEQgRkVl5tYkjQ0QtHW6f0r3vmtmRvbBB52zfJqMAvvkk8zTFApYvzPe9kOOFVh5aJNCRTrA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13145951692', '86', '2020-08-07 11:26:13', '2020-08-07 11:26:13', NULL);
INSERT INTO `user` VALUES (1000076, 1, '', 'otZjk5NxanmX-3zbxyWpmKOAOo7E', NULL, '雪山', 'https://wx.qlogo.cn/mmopen/vi_32/JUSzTKECylc4Eos65G4e8lbXLic21JCjhsIleE2lDPMq7unvngHX8mGibKsTYs6v3q2YZr2XGMaR25Fru3BVAybQ/132', NULL, 1, 'China', '', '', 'zh_CN', 1000017, '18301287833', '86', '2020-08-07 11:28:09', '2020-08-07 11:28:09', NULL);
INSERT INTO `user` VALUES (1000077, 1, '', 'otZjk5NHY8qjcAKHeLBr6mfdLvbQ', NULL, 'Anna', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIUIeibVpmDLCM7C3EwdeZUu7ficVCTKeTibUiaz0Zy9Ob1U2kNtWf0tibc0iawicUXtpN9gLzP2yDz5QqOw/132', NULL, 2, 'China', 'Zhejiang', 'Taizhou', 'zh_CN', 1000017, '17858512769', '86', '2020-08-07 11:44:17', '2020-08-07 11:44:17', NULL);
INSERT INTO `user` VALUES (1000078, 1, '', 'otZjk5EDPEvFn9TzQ-0Zrri_wKqQ', NULL, 'ZL', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epfHFv4ol3A1rA1O27QxQfxQqaGZKCYzgMWSwrGuHUqb3U8ZgR2SpWgYWMm8RcVJpkrO4d8GzYib7w/132', NULL, 1, 'China', 'Fujian', 'Xiamen', 'zh_CN', 1000017, '18606925966', '86', '2020-08-07 12:05:09', '2020-08-07 12:05:09', NULL);
INSERT INTO `user` VALUES (1000079, 1, '', 'otZjk5FajwoVUiN7xFaeFuViQ928', NULL, '廖国奇', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqBKpSfMCGjHRBAUF0XHn4amr9CvDGct4zaJiahWu1kqobTrfUK79eVEGge3aOWQVFhaJG2RTk8dbw/132', NULL, 1, 'China', 'Hunan', 'Chenzhou', 'zh_CN', 1000017, '13487866122', '86', '2020-08-07 12:08:50', '2020-08-07 12:08:50', NULL);
INSERT INTO `user` VALUES (1000080, 1, '', 'otZjk5BRKQQgzTR989NV6SsmjxLw', NULL, '钟离', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLndPicaib35sSI1svWOX1bVfkicApxIOicQfbOu7Ou1J83YmY9mxDhica4SJejfoVJMyCP4ANZN95o1sg/132', NULL, 1, 'Togo', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-07 15:35:13', '2020-08-07 15:35:13', NULL);
INSERT INTO `user` VALUES (1000081, 1, 'oC-0nuCkDiqw5KAMtm6g4yIzcCk8', 'otZjk5AitQBEUhQAyDNYRu2XEJe0', NULL, '刘任玮', 'https://wx.qlogo.cn/mmhead/s5jefahIyasLYvXKdmAk2tic5jDMeJTMxu8y3SEyFaW0/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-07 15:42:05', '2020-08-07 15:42:05', NULL);
INSERT INTO `user` VALUES (1000084, 4, 'oC-0nuM5a7vayfy2GTXTzX_LvE6M', 'otZjk5JofTWYX8r1-wS_ucD91VDE', 'oGstJwMSCPkdxhAUi2sri0gAbNUI', '小码', 'https://wx.qlogo.cn/mmopen/vi_32/CED6Q8VjibXbfstPNOoseZsXZAyiaJCh8FWP2bv0tAAZ34kN0NB487ZZmQfz1lVAZ5VqQl4AiaQRZOfBK0xWmy3MQ/132', '1000004/20207311741/3k8cja0l100c4kpl9cug7ywb00833ze2.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 0, '133****5773', '86', '2020-07-31 17:39:21', '2020-07-31 17:39:21', NULL);
INSERT INTO `user` VALUES (1000085, 1, '', 'otZjk5MwbaFPaqIPH9yhwgQljoBA', NULL, '小趣', 'https://wx.qlogo.cn/mmopen/vi_32/4QY4IPX0VQhYcR58wg3qGlmWIkEiaiaZ5nleibuwR8NzAHIpXz3VT8DCD9FxicuNWhrMYicmwq4pQ0RjXdlicxO35yIA/132', '1000026/20208040953/3k8cja0k700c4nu5ms8zndip00ozasab.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000084, '185****5774', '86', '2020-08-03 11:51:11', '2020-08-03 11:51:11', NULL);
INSERT INTO `user` VALUES (1000086, 1, '', 'otZjk5GqDJdGzLF6DrxOqaL7qZ5M', NULL, 'Shinawatra', 'https://wx.qlogo.cn/mmopen/vi_32/qYIqibSGuqs1Mx6mSCSxiblyqRS13A7s6iaAWWBJ3TcwQcUExfIRKRs9mzWRk1KgN5OqDbpug6mTibWexLDmJceOww/132', NULL, 2, 'China', 'Shanxi', 'Changzhi', 'zh_CN', NULL, NULL, '86', '2020-08-07 20:32:25', '2020-08-07 20:32:25', NULL);
INSERT INTO `user` VALUES (1000087, 1, '', 'otZjk5INM-2X4MDmWbQL67f3Dz6c', NULL, '小倩', 'https://thirdwx.qlogo.cn/mmopen/vi_32/20JUJpvD2IMzn0ShnS5uysnSicZeAwMqfibKdiabYoMibXPN0johAzXheGAO7m5pzMghRmCOGrcVOD5zWSGCSby69g/132', NULL, 1, '', 'Dusseldorf', '', 'zh_CN', NULL, NULL, '86', '2020-08-07 21:25:37', '2020-08-07 21:25:37', NULL);
INSERT INTO `user` VALUES (1000088, 1, '', 'otZjk5Mjm1l7Jw--HC6kmeHge96A', NULL, '福星高照', 'https://wx.qlogo.cn/mmopen/vi_32/UibiaRXUUjfnmszxHedevptbUDwKcAceFqE3ibNtfuzqBLNQpnyxgITWzlFTxpllBLcEnu6hu8c5nWia2ia3E9BTsIg/132', NULL, 2, 'China', 'Henan', 'Zhengzhou', 'zh_CN', NULL, NULL, '86', '2020-08-08 14:12:27', '2020-08-08 14:12:27', NULL);
INSERT INTO `user` VALUES (1000089, 1, 'oC-0nuL6TryKVy3JZgZAJXEbUsUo', 'otZjk5ID_53XpKpqbRBOzYxb3Agw', NULL, '侯左顺', 'https://wx.qlogo.cn/mmhead/kLD7zrEbrs3GTFyCAzrleUmhibCRcbUJ2MCrbcorGvmI/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-09 23:51:46', '2020-08-09 23:51:46', NULL);
INSERT INTO `user` VALUES (1000090, 4, '', 'otZjk5NA_GdbqnwtFmvaA-DTQl8I', NULL, 'Bling Bling', 'https://wx.qlogo.cn/mmopen/vi_32/Xf0iacPa3kxUmCjZ90YTXdkHDxMVRLVPw9SE6jxWnthT82n32vsicjc7ZcU6Dc0tL95WZKHV1DOQhbfFmqgAicx6w/132', '1000090/20208101314/3k8cja05uu0c4t264olw4hj260v37a4q.jpg', 2, 'China', 'Jiangsu', 'Changzhou', 'zh_CN', NULL, '13861277852', '86', '2020-08-10 13:11:47', '2020-08-10 13:11:47', NULL);
INSERT INTO `user` VALUES (1000091, 1, '', 'otZjk5KXFdse7naFaMg3KjfhaL30', NULL, '刘铸', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Cb7AFymxDBdvP9vmrLQ6nPP8y5XdAsJ6DuxXGASeibR49YPgE6OYaZfQNY68tpHeeBIxiaULOK3buZSTEqwAn2XA/132', NULL, 1, 'Ireland', 'Donegal', '', 'zh_CN', 1000017, '18129808033', '86', '2020-08-10 16:24:49', '2020-08-10 16:24:49', NULL);
INSERT INTO `user` VALUES (1000092, 1, '', 'otZjk5C0oI2hhCjNHIOjbBHAbtLw', NULL, 'A。', 'https://thirdwx.qlogo.cn/mmopen/vi_32/L8Hia5sfiafARaxicRY7HCWlXvPIWf7JdoibsAQiae1NEOfbxNsSNevGVa2kxkibDON8tzRemfeMZX9QxthjrUrVEKaw/132', NULL, 1, 'Chad', '', '', 'zh_CN', 1000017, '14778552197', '86', '2020-08-10 16:27:40', '2020-08-10 16:27:40', NULL);
INSERT INTO `user` VALUES (1000093, 1, '', 'otZjk5K3kgMx1MTyyfIxXTN2lG98', NULL, 'Byron', 'https://wx.qlogo.cn/mmopen/vi_32/e7rnicpoQenacficbGF254MMyvU2jCwnYqhsxaAgKFY0lXylATZibwZ5TZL18KVOBxEkNC5V7tEHnPGbMrPhl5y1A/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18792516935', '86', '2020-08-10 16:27:50', '2020-08-10 16:27:50', NULL);
INSERT INTO `user` VALUES (1000094, 1, '', 'otZjk5G11OmDDM8uIECfKu7VCV8A', NULL, 'Juan', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIS1UT9HtCv46tYzfHPnRbaD5nw6aicrWicjMKdEhePT9TsibvLIvEIKoQ1eAWxatVibh1Twm904spolA/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18824307795', '86', '2020-08-10 16:28:12', '2020-08-10 16:28:12', NULL);
INSERT INTO `user` VALUES (1000095, 4, '', 'otZjk5DX2z8-HE50ik17QHlDsTV4', NULL, '红霞', 'https://thirdwx.qlogo.cn/mmopen/vi_32/OHHicVJnH4SN0zRWJ2hyzAYnCC8zdibKsIibLNNWl6BmmHBGB7giaEYTrj2RWxgvCRw3J3DtQeb0rsVJZzlpqYZY5A/132', '1000095/20208101930/3k8cja01l60c4ta6nqz4n75b00v3m254.jpg', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13430388157', '86', '2020-08-10 16:29:35', '2020-08-10 16:29:35', NULL);
INSERT INTO `user` VALUES (1000096, 1, '', 'otZjk5I75U7jhToaKsfBbJPdoR-o', NULL, '陈平安小夫子', 'https://wx.qlogo.cn/mmopen/vi_32/4GTnqLh5MPR7mgMQ3DGL8kBMdyGX9GjwvTR3hPEbaCTXob7lOWL33h2TG5rOgZsfrZkS8p4eXicXWbsxyeCY55w/132', NULL, 1, 'China', 'Jiangxi', 'Jian', 'zh_CN', 1000017, '18296127309', '86', '2020-08-10 16:33:26', '2020-08-10 16:33:26', NULL);
INSERT INTO `user` VALUES (1000097, 1, '', 'otZjk5AiCYZEsaSK0V4RjxN_7OL0', NULL, '路由心生', 'https://wx.qlogo.cn/mmopen/vi_32/RQgIyQXrKSjza06nzpBiaFZ7bjORvPeWGq2R44ia4nH7WcEeJWqVT3mCGQ8gg76LPjLqoctKzsrxH4p6eqV1tMnw/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, NULL, '86', '2020-08-10 18:57:56', '2020-08-10 18:57:56', NULL);
INSERT INTO `user` VALUES (1000098, 1, '', 'otZjk5BAQnQMjb8ffVBRpYJtAz18', NULL, '文', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo6AVlY0qNnVq7VCDjaP0zy11bdgnWdVac1Xrctj9WWg1HJphzevGWZNRuLOicrHjCec3gWicC95ib7w/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18320906525', '86', '2020-08-10 20:36:51', '2020-08-10 20:36:51', NULL);
INSERT INTO `user` VALUES (1000099, 4, 'oC-0nuGbgDqHoYAoO2MLik6W8dAs', 'otZjk5CXKVGGEUsbwdqumXYmPpsU', NULL, '👙 小雅💋', 'https://wx.qlogo.cn/mmopen/vi_32/Lq6icfbaH5ZXNRpqnMUNxuQy2vk5pGuYj2SNKbd0arDKibVhSGibxtMDHJuh74wC3tfybbXticSlXUcyZfJib8cnia6Q/132', '1000099/20208102156/3k8cja01l50c4tdabo67y8pp00v1rwja.jpg', 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000013, '13925756106', '86', '2020-08-10 21:29:44', '2020-08-10 21:29:44', NULL);
INSERT INTO `user` VALUES (1000100, 4, '', 'otZjk5KpOctSa8mji6xkDZc3wPac', NULL, '罗罗昵', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKAWr5qia3EibrfALg8hZZcsXvBhsH39bbfVF2jpn0QOCibCprttBVdvglSVPXJp7cmUC6iaYZrvmJrvw/132', '1000100/20208132124/3k8cja0op00c4vwhdh9bpzwq005opqcs.jpg', 2, 'China', 'Hunan', 'Chenzhou', 'zh_CN', 1000017, '18503086420', '86', '2020-08-10 22:21:29', '2020-08-10 22:21:29', NULL);
INSERT INTO `user` VALUES (1000101, 1, '', 'otZjk5DpLGsh5lhXjZR1FPTDbHTE', NULL, 'Mr·李', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKevANu6C5xElvg6FRBtsaibzvHcCJF7NzHmicUz0smBphFQgu4cPbsaU2ibQJAV2Rn0NElFTDN0rrlg/132', NULL, 1, 'Zambia', '', '', 'zh_CN', 1000013, '18857320568', '86', '2020-08-10 22:28:31', '2020-08-10 22:28:31', NULL);
INSERT INTO `user` VALUES (1000102, 1, '', 'otZjk5PBXW2hNp7xAQ_VNCkWvxGo', NULL, '\'', 'https://wx.qlogo.cn/mmopen/vi_32/IsjtWa8bTJpzYDia1GedKR7tZSbFia7BmafHCwoP8c5hKWzAjTMbPeodytaYicpcAg3wfwO2C7ILibNGXRHZr0ChBQ/132', NULL, 0, '', '', '', 'zh_CN', 1000099, NULL, '86', '2020-08-10 22:30:12', '2020-08-10 22:30:12', NULL);
INSERT INTO `user` VALUES (1000103, 1, '', 'otZjk5Akyn7Bk0VYW_krsgvCYM6M', NULL, '李琳', 'https://wx.qlogo.cn/mmopen/vi_32/AMco8xIhvz3ia2GEomEdIEXCiaZU6G6ZkqFrrDLGeDBBkg5sbMWN9HKMVlK4pX5Fvax5qNlTrNvwYRCiayZR81RwA/132', NULL, 2, 'China', '', '', 'zh_CN', 1000099, '13911446516', '86', '2020-08-10 22:45:44', '2020-08-10 22:45:44', NULL);
INSERT INTO `user` VALUES (1000104, 1, '', 'otZjk5BqsM2OCivRob9he-zXXkQI', NULL, 'M.Y wardrobe小敏杂货店', 'https://wx.qlogo.cn/mmopen/vi_32/eu9libMmGXSm2cPA7huuPLic3AeQm54DVYCoAlZhviaPI3ttGo85KwwqUdYmBFjQBLkdsB4oP38UTPULGGIAnJsicQ/132', NULL, 0, '', '', '', 'zh_CN', 1000022, NULL, '86', '2020-08-11 02:03:59', '2020-08-11 02:03:59', NULL);
INSERT INTO `user` VALUES (1000105, 1, '', 'otZjk5MSMH-YHAr7hvLrR-Hu1jYk', NULL, '棒棒堂', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIH4XfrrhnG5EzCtqs3sYDibKMMlFs5ib18LfJb7bRUTcDANvDOO0kdJsia3r2d1zgUsibDBxGeZr8LBA/132', NULL, 0, '', '', '', 'zh_CN', 1000017, '18709276942', '86', '2020-08-11 09:58:56', '2020-08-11 09:58:56', NULL);
INSERT INTO `user` VALUES (1000106, 5, 'oC-0nuMaib1tKReksZC7MUYl3nsY', 'otZjk5L_To5RPh5mVU-nrpZtZXN4', NULL, '拾荒少年', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83er4af3sRsBaN2AzmAnx5Eo4UOdvQ5400WqzzibHt5qqojtVQ1AuSkAQVy7JdOsSIU1SOtToshbvFRA/132', '1000106/20208111006/3k8cja01l50c4tstbr4blgk1k0gtayjv.jpg', 1, 'China', 'Shaanxi', 'Xi\'an', 'zh_CN', 1000017, '18706821922', '86', '2020-08-11 09:59:26', '2020-08-11 09:59:26', NULL);
INSERT INTO `user` VALUES (1000107, 1, '', 'otZjk5LKU1_waLQVIcY0g9bDbrcM', NULL, '伊利丹', '', NULL, 0, '', '', '', 'zh_CN', 1000106, '13543316937', '86', '2020-08-11 10:10:27', '2020-08-11 10:10:27', NULL);
INSERT INTO `user` VALUES (1000108, 1, '', 'otZjk5Dt3GSeRhQnzuHVWR2hvVr0', NULL, '今非昔比‘', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLu0Wqrf1xW2URhyO3ocVnIfIiaBicBaNcwf9jzWl5p7gHZHEuXBC3YvxaAnDZe4qsrVqgJruezSkLg/132', NULL, 1, 'China', 'Shaanxi', 'Xi\'an', 'zh_CN', 1000106, '15802956885', '86', '2020-08-11 10:13:33', '2020-08-11 10:13:33', NULL);
INSERT INTO `user` VALUES (1000109, 1, '', 'otZjk5A0UOh9AVhQCQPlir2OC_oo', NULL, '袁凯丽', 'https://wx.qlogo.cn/mmopen/vi_32/pqZPiamWYIRb4IaSS1qDSbam9NeYEoonMsPc2hp6yQmNE5CdUcI06CgiccEVicCbAqkXyCgGLBVFO6qDgAuQmx5Fw/132', NULL, 2, 'China', 'Shaanxi', 'Weinan', 'zh_CN', 1000106, '18409273489', '86', '2020-08-11 10:17:24', '2020-08-11 10:17:24', NULL);
INSERT INTO `user` VALUES (1000110, 1, '', 'otZjk5K43zRG8t6cBtrNmmendNF4', NULL, 'sunny乐', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKtR38UEItAdoAWYetFuuFnicbouajOkVJtXxecj1TXbVEXXcKX49lecdWSHjlfeB8ymDdpoEibArcA/132', NULL, 2, 'China', 'Shaanxi', 'Xi\'an', 'zh_CN', 1000106, '18729520681', '86', '2020-08-11 10:32:46', '2020-08-11 10:32:46', NULL);
INSERT INTO `user` VALUES (1000111, 1, '', 'otZjk5Kzok3GthAGw8Ov0o0W62II', NULL, 'Deku.x.x.😵', 'https://wx.qlogo.cn/mmopen/vi_32/ibS9vAqIgElxVzO4SIUI3mXiazSh8VGlzoGJKeKbLrUZJl73icvzS7wxCIpOAS2B3L7Q59ysCzOrGSZJ5JHYHNGEw/132', NULL, 1, 'Greece', '', '', 'zh_CN', NULL, '16620132609', '86', '2020-08-11 11:19:13', '2020-08-11 11:19:13', NULL);
INSERT INTO `user` VALUES (1000112, 1, '', 'otZjk5K1c5N7x8NqRuxT5GF0Q3z0', NULL, 'Painter', 'https://wx.qlogo.cn/mmopen/vi_32/gzkAJlE4Ec249AlX3Etmu52g49gdLnnIDFyLcDHEVtataykL4xQ8Dbw831mXicSVmaWp1P9qswuBwcO41MwicokA/132', NULL, 1, 'China', 'Sichuan', 'Chengdu', 'zh_CN', 1000060, '18908084461', '86', '2020-08-11 11:52:07', '2020-08-11 11:52:07', NULL);
INSERT INTO `user` VALUES (1000113, 1, '', 'otZjk5JSz16GpEFAhPsWzOWwPv0g', NULL, 'LiLiyoo_', 'https://wx.qlogo.cn/mmopen/vi_32/pLGaQ0eic0gnGC3Q3DTGmZQvlms51OMFgjWkUzh79mMqzyNmE6aaWWqGV1ODDLpLKm6I34FKBYSnupj2n9LXEkg/132', NULL, 2, 'KR', 'Seoul', 'Seoul', 'zh_CN', 1000106, '15820773736', '86', '2020-08-11 12:04:04', '2020-08-11 12:04:04', NULL);
INSERT INTO `user` VALUES (1000114, 1, '', 'otZjk5KDmz2IrpTSaeevEte31mbY', NULL, '光腚的三明治', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJoBO2f6IGHrjJibslGlzNfOPn6J7c4u9d5yibpheX4LybrcGYWuH40ovbb7QyUicS9b2WKibfAeUbm5g/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-11 13:54:10', '2020-08-11 13:54:10', NULL);
INSERT INTO `user` VALUES (1000115, 1, '', 'otZjk5FjWynrDYQEZt0MtbZ77bL8', NULL, '苹果🎈', 'https://wx.qlogo.cn/mmopen/vi_32/V71wNP3XFiaOBA7mIgFZ3ibfSYdHRK0MMWib3zvUywcsm339Vm2TRtvQPY0mZ02Dgsgoohtzg55NSJh2pTaW3ibcDA/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '18819735603', '86', '2020-08-11 14:07:59', '2020-08-11 14:07:59', NULL);
INSERT INTO `user` VALUES (1000116, 1, '', 'otZjk5IGC33MSk4uDULUrcfKoQ9Q', NULL, 'liwei1dao', 'https://thirdwx.qlogo.cn/mmopen/vi_32/PVBHbMBbTAuuXDcdCEAXVtOXOEUm5S3LzPLMAiaozs6gjANgackaxwSfxv0KDbGfwyLm5xxlYLZibd3v1UnicD94w/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '17316875529', '86', '2020-08-11 18:00:01', '2020-08-11 18:00:01', NULL);
INSERT INTO `user` VALUES (1000117, 1, '', 'otZjk5DE43Vt792EiKBP4e_8yJAg', NULL, 'man', 'https://wx.qlogo.cn/mmopen/vi_32/K62eYl380JBeVa1oY26R5YsjZX4BQVjA3WNAdKarzU5f29rqgj4J5tZlrgsMZQhLLXc3WepJokDmYuBKUJ14HA/132', NULL, 2, 'China', 'Hunan', 'Hengyang', 'zh_CN', 1000017, '15874759547', '86', '2020-08-11 19:10:56', '2020-08-11 19:10:56', NULL);
INSERT INTO `user` VALUES (1000118, 1, '', 'otZjk5JWrKUaZlwpEO9pZSFXHTmo', NULL, '宝润燃气电话27698090', 'https://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLDNz9M6dIl6CJcGScwnNCabmNOa210aPHnSfAaJOHXiblzOX99lPqyKIKh4u5Xsl7icty9CTxOXvlCg/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13823375958', '86', '2020-08-11 19:11:27', '2020-08-11 19:11:27', NULL);
INSERT INTO `user` VALUES (1000119, 1, '', 'otZjk5MXQKa8yWXL-8sfePTq8zw4', NULL, '朱敦华', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJdWh3QLDzOnalxZD3B3FtyZa2gniceE3g05MIwAumeGkH1iaXdG7tqiaa21u9wUe1j8FInCoWvFuic9Q/132', NULL, 1, 'China', 'Hubei', 'Wuhan', 'zh_CN', NULL, '15827433780', '86', '2020-08-11 20:58:14', '2020-08-11 20:58:14', NULL);
INSERT INTO `user` VALUES (1000120, 1, '', 'otZjk5OKCL3t3-DUtOREH3mCcyYc', NULL, 'Icsy', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erj4E4p90dU9ZPQGRWZ7qn1luln8THPwj9wOg75HSN0UicpHKaYMYON1Y8pf83Ftm3bGj19WerVztQ/132', NULL, 1, 'China', 'Hubei', 'Wuhan', 'zh_CN', NULL, '13071290925', '86', '2020-08-11 21:03:08', '2020-08-11 21:03:08', NULL);
INSERT INTO `user` VALUES (1000121, 1, '', 'otZjk5OCRXtDJPaIon6bjAS1r-xE', NULL, '石小豆', 'https://wx.qlogo.cn/mmopen/vi_32/YE2XrwoM38vDhf8IjiaOgsxnx9J24kOiavxib9oUAGwYfWG2jM4icch1fzJibFOrcZH66SxK1f98xH1pibY5mPSwLY8g/132', NULL, 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '18676790991', '86', '2020-08-11 21:03:48', '2020-08-11 21:03:48', NULL);
INSERT INTO `user` VALUES (1000122, 1, '', 'otZjk5GVnw5-m1FLhHbUbC4IqJZA', NULL, '惊蛰', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLsR19wO33Dbiay6S9dmYptmIlYVMrrvICJxLdCmcJ6jDBGz9jcTtxybxDRcdwPo0q9jI45rKN6kZg/132', NULL, 1, 'China', 'Hubei', 'Wuhan', 'zh_CN', NULL, '13995602825', '86', '2020-08-11 21:44:37', '2020-08-11 21:44:37', NULL);
INSERT INTO `user` VALUES (1000123, 1, '', 'otZjk5AdXMmVKrkmJo7NFueI0Oew', NULL, '大雄', 'https://wx.qlogo.cn/mmopen/vi_32/Oogu4aJAP0aic9V87DV1qeEY7xttAEMdJadYXiaOk08J892Zqdm3NrNla2wTibpY3NAJZFhlibscYgzU5nVlicxR74A/132', NULL, 1, 'China', '', '', 'zh_CN', NULL, '18971074626', '86', '2020-08-12 08:59:20', '2020-08-12 08:59:20', NULL);
INSERT INTO `user` VALUES (1000124, 1, '', 'otZjk5F5L8cSI1RfK1UmpCXC9omY', NULL, 'Zz', 'https://wx.qlogo.cn/mmopen/vi_32/AibaQn2JppZZA6PIicPT7wZgU6DxSWsMicuun37mvicDqO4hYffsGHmp7KPL7OUJScG6ic7oJ6MZjpdgEVDL4k17icXw/132', NULL, 1, 'China', 'Shanghai', 'Yangpu', 'zh_CN', 1000060, '13994906668', '86', '2020-08-12 09:48:26', '2020-08-12 09:48:26', NULL);
INSERT INTO `user` VALUES (1000125, 1, '', 'otZjk5La_UN1uiCQ0HDsjDVXqdL4', NULL, '缪基丽', 'https://wx.qlogo.cn/mmopen/vi_32/9YRh0gX8z9xrdxzzWeWUiaiaXlqwTIaCcTVJOoYceljFygygd8KucdibXWkJVkgovUeIRPCT8wU8Bia9g4MmtaRZuQ/132', NULL, 2, 'Gibraltar', '', '', 'zh_CN', 1000017, '13929946690', '86', '2020-08-12 11:19:42', '2020-08-12 11:19:42', NULL);
INSERT INTO `user` VALUES (1000126, 1, '', 'otZjk5EnnOOZYaWaMA_rCrJ6uMBA', NULL, 'A-NikeConverse', 'https://wx.qlogo.cn/mmopen/vi_32/lZBS4gELmGKvTOCdXA3kEhSRcxlrmfOmJzT8j5hGWRz5Aa3CE1zB3jDQQ3ux1IZxzRTe6juHicl2yicwPnT6iaSYg/132', NULL, 1, 'China', '', '', 'zh_CN', 1000060, '17897839338', '86', '2020-08-12 13:17:10', '2020-08-12 13:17:10', NULL);
INSERT INTO `user` VALUES (1000127, 1, '', 'otZjk5Cp9ov7XS3IGWyulslkzkkA', NULL, '💕悸', 'https://wx.qlogo.cn/mmopen/vi_32/63lkDcQhUSwRDQ3onhHoOwlzWCeNM6OG81JMv4zWMOCPAydnYJEzViawX6N2F628Xjka3oXx4aKdXfUsK6mof2g/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '13925577695', '86', '2020-08-12 13:39:47', '2020-08-12 13:39:47', NULL);
INSERT INTO `user` VALUES (1000128, 1, '', 'otZjk5FpXZ5b7XbcAnfc-Ju-bFxA', NULL, '小鱼', 'https://wx.qlogo.cn/mmopen/vi_32/jib7aQN1uiclnFkBRvwhvLtWUozj1qxCvVkwUFoG4dA3AucE8jSNejVsfocFv3riaLwLqZ8LBgPAMiczs3zWzkevibw/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '13929270880', '86', '2020-08-12 13:40:07', '2020-08-12 13:40:07', NULL);
INSERT INTO `user` VALUES (1000129, 1, '', 'otZjk5GaAxlrzgsPimJUEH96e_To', NULL, 'judy', 'https://wx.qlogo.cn/mmopen/vi_32/9TJknAth9Y423PtvgY8Jv2AG2LfqpAy1tKLjEFksjqgIyzW8SybWFw4s8LA7Io1jAj1e3iaNLtGc2T5LvT2eJdQ/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '18825777956', '86', '2020-08-12 13:40:58', '2020-08-12 13:40:58', NULL);
INSERT INTO `user` VALUES (1000130, 1, '', 'otZjk5GUa29CfOh1hMYJR05KolTk', NULL, 'A吴怡霖', 'https://wx.qlogo.cn/mmopen/vi_32/FgtfJEt4cX3icwBSnichyzhVcwrJXCSC2ZSBNpnYo0k2hYAoWBe7jensDrzjqfyWuU759ialUheuLJ96VnXFW6ooA/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, NULL, '86', '2020-08-12 13:42:01', '2020-08-12 13:42:01', NULL);
INSERT INTO `user` VALUES (1000131, 1, '', 'otZjk5D_9qVNmNK0HisydAW2HJgs', NULL, '🌹nanastory', 'https://wx.qlogo.cn/mmopen/vi_32/HAlshNiaaYicibzS2b4TXmicJKqIMOHJAxKZrDxxMianEUPW6l6HWpnSvpbuILc9Woclz1Mkj83kj67RaF9yicMRv7ww/132', NULL, 2, 'China', 'Hunan', 'Chenzhou', 'zh_CN', 1000099, '13423253418', '86', '2020-08-12 13:43:48', '2020-08-12 13:43:48', NULL);
INSERT INTO `user` VALUES (1000132, 1, '', 'otZjk5O3bOtkbthMSwTZCUen4MI4', NULL, ' 西西女王', 'https://wx.qlogo.cn/mmopen/vi_32/ymBeTR0taKLFAjI0VlMmoXwr3l0zbgiasWgvO3pwpXGeqohkibQZ57z2xbQX6bWsI609nRLesVO4xS5dz9S9t29w/132', NULL, 2, 'China', 'Guangdong', 'Jiangmen', 'zh_CN', 1000099, '13534800388', '86', '2020-08-12 13:44:16', '2020-08-12 13:44:16', NULL);
INSERT INTO `user` VALUES (1000133, 1, '', 'otZjk5KY5PeMCCyX6-UJDZAN2UFg', NULL, '邓静', 'https://wx.qlogo.cn/mmopen/vi_32/bMP30ibxMl4j4qL2lsPbaDOOlrK0dSerCpbvjic0xQYT6Tia5vYBqDND5LaWkCn5rpQ9ibFtgmyDK41YkXC0lhIGCA/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '13532998623', '86', '2020-08-12 13:52:55', '2020-08-12 13:52:55', NULL);
INSERT INTO `user` VALUES (1000134, 1, '', 'otZjk5Fu1oIbiCCmgiQ6omgYu5a8', NULL, '英子', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTICnicg7IX8VU6Q2pkKahdPHyBw5hvTbTa0rACY3xMSpuSJEPU5ibdT7PbUd9dGNOQvxWexJZPiax9yw/132', NULL, 2, 'Andorra', '', '', 'zh_CN', 1000099, '18891854385', '86', '2020-08-12 13:55:39', '2020-08-12 13:55:39', NULL);
INSERT INTO `user` VALUES (1000135, 1, '', 'otZjk5FD2Vk5dUQ0vhMgCOWgXtjw', NULL, 'Axia', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKHtecwQpl6m29XFlBQdV03kpoMtE8sSQObbiaV1LvFrnp4vkG5k8lTqOo1bmkOZnRyqTsd4UME7dA/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, NULL, '86', '2020-08-12 14:12:16', '2020-08-12 14:12:16', NULL);
INSERT INTO `user` VALUES (1000136, 1, '', 'otZjk5B4ThXDHfkmA2UescMHe6-U', NULL, 'sa', 'https://wx.qlogo.cn/mmopen/vi_32/brTaDE12M5fricwicKdKdjOFFjJASHKoKibyXp3c38U0QrzHLaxBzWKxrHtPp1rdhU0vA9aMCMHBeySfJAgpDLb1w/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '13827286733', '86', '2020-08-12 14:15:47', '2020-08-12 14:15:47', NULL);
INSERT INTO `user` VALUES (1000137, 1, '', 'otZjk5Itc5EG3P6cznTVuHMXqPWI', NULL, '最佳损友', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTImcT1fcqJIqeZIwWkBvLXk9R5esvxlAgADJ9J2Bow8XjVSiaTPDNkSYic9qc8j6IINmeLEAA66icctA/132', NULL, 2, 'China', 'Guangdong', 'Jieyang', 'zh_CN', 1000099, NULL, '86', '2020-08-12 14:28:50', '2020-08-12 14:28:50', NULL);
INSERT INTO `user` VALUES (1000138, 1, '', 'otZjk5Cj8c3qkwxEAysBHwylOFGo', NULL, '拂晓彤云', 'https://wx.qlogo.cn/mmopen/vi_32/FmjAcibbIH7BrjIziadWORKc0jA8kicyYJ7eiaBCyeibG9T1qy5s70LtbwKu61IGAAd9s7iatv5AXwtno3Scf2Whq9Hg/132', NULL, 2, 'China', 'Guangdong', 'Dongguan', 'zh_CN', 1000099, '13726464910', '86', '2020-08-12 15:40:33', '2020-08-12 15:40:33', NULL);
INSERT INTO `user` VALUES (1000139, 1, 'oC-0nuDi5OdJ6UWoy0LnjYNFUuZw', 'otZjk5FBIHbifiPS9Kbo-aKMlTD0', NULL, '沈荣嘉', 'https://wx.qlogo.cn/mmhead/CLckM9yllDING3AzMIeTGYpDsCF5daM6F5NGRXVzMXY/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-12 23:38:53', '2020-08-12 23:38:53', NULL);
INSERT INTO `user` VALUES (1000140, 1, '', 'otZjk5Fm4ALSha7K5OK2eezzZTek', NULL, 'Jojo', 'https://wx.qlogo.cn/mmopen/vi_32/iaiciauuu1aHNBmQmYiaZqOAke5gIE8xoqW2vgbqLCtlLZIPibUa8mgW5mgpwfcib21YJzRWAKKWNYBGZ23JwjibJhGnw/132', NULL, 2, 'China', 'Guangdong', 'Guangzhou', 'zh_CN', NULL, '13829073559', '86', '2020-08-13 16:25:21', '2020-08-13 16:25:21', NULL);
INSERT INTO `user` VALUES (1000141, 1, 'oC-0nuBAX5TuRcUzPLMpvUtcD_0I', 'otZjk5BrWcWzyhGaQdmEVG_TKgro', NULL, '谢佳宏', 'https://wx.qlogo.cn/mmhead/icYoAQ4l8icpFkQ36picHjjoEpyppvibFz5US0Vxlgk7sicU/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-14 01:26:04', '2020-08-14 01:26:04', NULL);
INSERT INTO `user` VALUES (1000142, 1, 'oC-0nuLtDQOnvn7xD_z6nlCIPQvo', 'otZjk5IrSu2H1_Nhx1Tly5Iunp6M', NULL, '陈志文', 'https://wx.qlogo.cn/mmhead/uH7Dh9KeFShribKibREh4iayaAgUhq6NVZ4Yc9mNL32ibxE/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-17 19:19:06', '2020-08-17 19:19:06', NULL);
INSERT INTO `user` VALUES (1000143, 1, 'oC-0nuE5m8kGTYFRbXFnSa9pPvns', 'otZjk5IYsp1gb_JUEN_slqPHJaus', NULL, '陈政圣', 'https://wx.qlogo.cn/mmhead/Krc4cum7j4GUIwAdnxjZ3aFd3bgSUIJmRgMib5quTVEI/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-18 04:33:59', '2020-08-18 04:33:59', NULL);
INSERT INTO `user` VALUES (1000144, 1, 'oC-0nuPQBu4-ZK1YT2kk0VfErgm4', 'otZjk5Jq8Inaiyn7MdjhKLwUwkkw', NULL, '杨凡靖', 'https://wx.qlogo.cn/mmhead/Uu9ooRGYPib7Wq4RDRWsHYau18MVglxY26ZglEJXkia48/132', NULL, 0, '', '', '', 'zh_CN', 1000013, NULL, '86', '2020-08-18 11:52:23', '2020-08-18 11:52:23', NULL);
INSERT INTO `user` VALUES (1000145, 1, '', 'otZjk5MQb2QaeVG00eZtWNlgRHQI', NULL, '소몽하', 'https://wx.qlogo.cn/mmopen/vi_32/jo66RO6HsjicvGMN2H5TlxyMWrJzWPqHgMa4Dcmp54Pibd3wjvAicRWDckR41eU9EVegrqP2RFZLNOf0VLI66DktA/132', NULL, 1, 'Chad', '', '', 'zh_CN', 1000013, '13677383177', '86', '2020-08-18 11:52:48', '2020-08-18 11:52:48', NULL);
INSERT INTO `user` VALUES (1000146, 1, '', 'otZjk5LYwdj5wFQph5FHS9stXXHo', NULL, '生命之树', 'https://wx.qlogo.cn/mmopen/vi_32/6w1TmRYAqB06z4bGMCp22acTnlwicrfPzNz3WKcpia74XQCY343YMK9PCegzN5mINzJR1a2ItArIhUsicu3zMLXFg/132', NULL, 1, 'China', 'Guangdong', 'Guangzhou', 'zh_CN', 1000013, '17382113907', '86', '2020-08-18 12:00:07', '2020-08-18 12:00:07', NULL);
INSERT INTO `user` VALUES (1000147, 1, '', 'otZjk5P647rqjPpVM_QZGzcHmRqw', NULL, '笑忘书', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJyrsxwB10cIgswM2wibiaSzGUo84cgs4Dobg4W87UGPMoTdg7ymy5rCicMp50Ijaja7wfqkTj5G2eHw/132', NULL, 1, 'China', 'Hubei', 'Yellowstone', 'zh_CN', 1000017, '15871181832', '86', '2020-08-18 17:42:00', '2020-08-18 17:42:00', NULL);
INSERT INTO `user` VALUES (1000148, 4, '', 'otZjk5M_9AIlQTFWWgDGhP53c-sw', NULL, '1号', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKR1xfzzIkSrcdHHhNicSze1PeZibmSFzBlWbSyXB7iaiaaibZ9ZK05QvqZtWE75sBH6Zf1TWibgkTPnr4g/132', '1000148/20208202312/3k8cja0jvs0c51x5yipk6us110c8nd30.jpg', 0, '', '', '', 'zh_CN', 1000017, '13682648914', '86', '2020-08-18 17:52:35', '2020-08-18 17:52:35', NULL);
INSERT INTO `user` VALUES (1000149, 1, '', 'otZjk5K8XyFVliVMXEsvgZj-eYZw', NULL, '墨语', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTItpibAyxjro6hWcH32FqUAiaytC4uw5JMVxFTb3HhIWE98zZOcz7Q62QR6L8iavqKckrVsYpnWLCzTQ/132', NULL, 1, 'China', '', '', 'zh_CN', 1000017, '18291165020', '86', '2020-08-18 18:06:49', '2020-08-18 18:06:49', NULL);
INSERT INTO `user` VALUES (1000150, 1, '', 'otZjk5AUI517493mp8_VDx3FqTkE', NULL, '＊琳子＊', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKYZwpIRjcORJCBmJDwVbsk2aKqnagotWm5uFjyLKSTMKJ2hMhx8nxccsMFJXn30dEu4fUpRhd0GQ/132', NULL, 2, 'China', 'Guangxi', 'Guilin', 'zh_CN', 1000017, '18806640631', '86', '2020-08-18 20:17:22', '2020-08-18 20:17:22', NULL);
INSERT INTO `user` VALUES (1000151, 1, '', 'otZjk5BmPUOSAahP0nvtcZrImAEU', NULL, '吐司框框', 'https://wx.qlogo.cn/mmopen/vi_32/7G7MEmlPibp1Hjmnu3gsJX949QRXj8We3jLgOczuTbYIrq5wqiaicX0Z0zwibk6jbSicJfR5lnuHH0nib8BHwDlSflUA/132', NULL, 2, 'China', 'Sichuan', 'Mianyang', 'zh_CN', 1000060, '15681120438', '86', '2020-08-18 21:09:15', '2020-08-18 21:09:15', NULL);
INSERT INTO `user` VALUES (1000152, 1, '', 'otZjk5Ckp_d9XVFplURmcFne_2ys', NULL, '赵兴中', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIgJiaFOfX2GuWWKBUrRibwH9ZYnkYEZ2DUcNoLWw0FPkxvX9lpcicX5XsVcnibR6skH3iantiafA1n8ZPg/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13632840300', '86', '2020-08-18 23:53:35', '2020-08-18 23:53:35', NULL);
INSERT INTO `user` VALUES (1000153, 1, '', 'otZjk5LEViZJh3oJPYTTt_eTHYJI', NULL, 'sijia', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK2oz7yxmbKDPkKfcsFXqbWiaglz1rwicWyUx91icKtBOkViajicKAEM80gylQrqH1JJdInNoK6wdcx6Ug/132', NULL, 2, 'China', 'Sichuan', 'Chengdu', 'zh_CN', NULL, '15982304861', '86', '2020-08-19 13:34:26', '2020-08-19 13:34:26', NULL);
INSERT INTO `user` VALUES (1000154, 1, '', 'otZjk5H4KZ5eOC_IS9Gzojb0gi9Y', NULL, '^_^', 'https://thirdwx.qlogo.cn/mmopen/vi_32/48S5tjKJME6ibmS62IDhuPVahPZ6GqLrOzsC7IRAVq9ouQ4RCtC8nYaLaMpk2a6GGFkpXYSkFDbiaItJJEgLib2UQ/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13530897455', '86', '2020-08-20 11:57:53', '2020-08-20 11:57:53', NULL);
INSERT INTO `user` VALUES (1000155, 1, 'oC-0nuDQGupRqAn-lNm0thuIEJ6k', 'otZjk5Jkw0ye5K_K9cKg8fs3tI5Q', NULL, '俞星如', 'https://wx.qlogo.cn/mmhead/0lWaYLfib2TssAocsB9pspLYHodB0yic17lM0rEmB5ibfo/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-20 12:18:32', '2020-08-20 12:18:32', NULL);
INSERT INTO `user` VALUES (1000156, 1, '', 'otZjk5OkczF0n4sgtOMPG1vz_F0s', NULL, '想飞的橄榄树', 'https://thirdwx.qlogo.cn/mmopen/vi_32/zK4MvvqLzmovkr1OkFn98Yic9DMeWibqCaZlecIZdntC3V8gXKpuR7VNUAXyNXhAefRszaubDX0t8BCjD5zgZ6Ug/132', NULL, 0, '', '', '', 'zh_CN', 1000017, NULL, '86', '2020-08-20 21:42:38', '2020-08-20 21:42:38', NULL);
INSERT INTO `user` VALUES (1000157, 1, '', 'otZjk5Fx5J-RUCvwRx5g3Uw77V_s', NULL, '哆啦', 'https://thirdwx.qlogo.cn/mmopen/vi_32/teBGmK4b9WZoWqTsX0mETNFqVsJYVwF9xRIOmY5Qj4Kqj8xB933ibrlmycOdicvWwWicP1n2PhS39gJPHmKb24h9A/132', NULL, 2, 'China', 'Hubei', 'Wuhan', 'zh_CN', 1000017, '13554312171', '86', '2020-08-20 22:17:21', '2020-08-20 22:17:21', NULL);
INSERT INTO `user` VALUES (1000158, 1, '', 'otZjk5G70cTVagtw7Qv9HAA0tUfs', NULL, '水调歌头', 'https://thirdwx.qlogo.cn/mmopen/vi_32/gGOGcSH4AcBEke8FT0icFicUqktAdqHh5cgS1ibWficBV7p5I7icg1h4iaKicmlSl7t7ogXjQqEXjlM6eibQib6amhBLWoA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '13410960102', '86', '2020-08-20 22:24:20', '2020-08-20 22:24:20', NULL);
INSERT INTO `user` VALUES (1000159, 1, '', 'otZjk5CnrmVtc7idq9l3I9IWC5mA', NULL, 'X-Aha', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL6MwYILDF1eK3FJv4d04vb6A3H1h4aHhCmaBEg7BFV6KAcFuTKrMepHgH6dxfCQyGKibgbAVwicRtA/132', NULL, 2, 'Bhutan', '', '', 'zh_CN', 1000148, '17752671227', '86', '2020-08-21 06:23:30', '2020-08-21 06:23:30', NULL);
INSERT INTO `user` VALUES (1000160, 1, '', 'otZjk5IVvtTNAWqS8OUObmtduVE8', NULL, '👽', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKCWvBNibib8VvJibiaQrcGeib2ZIeP91yYZ1bnCB7NOKpdOTggOQok8gMLyl4UhDblmp67IicQpFL1L2OA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '17673427853', '86', '2020-08-21 08:20:06', '2020-08-21 08:20:06', NULL);
INSERT INTO `user` VALUES (1000161, 1, '', 'otZjk5Dwff6WyvAmvEKDyaGXOsas', NULL, '汀娜', 'https://thirdwx.qlogo.cn/mmopen/vi_32/sk12GuEUolxOhv09YB4qC2JDrervODUpeF3S5ZLIdA8uH9J9j5GLVeIg6icEaoQdtRwwGbPCPPZCmJ0FThRTPBQ/132', NULL, 2, 'China', 'Hunan', 'Changde', 'zh_CN', 1000148, '13827288940', '86', '2020-08-21 18:15:58', '2020-08-21 18:15:58', NULL);
INSERT INTO `user` VALUES (1000162, 1, 'oC-0nuNNi6b1i-EAn_RTp2ZS2hUs', 'otZjk5AG0OdL3MMEn8_1B48XhNU8', NULL, '张鸿信', 'https://thirdwx.qlogo.cn/mmhead/f4nmYtK3EnZeQ2uULeRal0ibk6ldly3drjFpLABUdGMk/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-22 00:00:29', '2020-08-22 00:00:29', NULL);
INSERT INTO `user` VALUES (1000163, 1, '', 'otZjk5EGiMtHhR1pSnPi59Xncc04', NULL, '虾薯饼', 'https://thirdwx.qlogo.cn/mmopen/vi_32/AtZRPN7R7KBLKfe18yEMlRVXju8fBibFrFYV9qhygk12GlwMLadtgSYiaL9u2hmEHK6vs7P9vCmsM6mVB8pf1ibEA/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000017, '18926437627', '86', '2020-08-24 10:25:01', '2020-08-24 10:25:01', NULL);
INSERT INTO `user` VALUES (1000164, 1, '', 'otZjk5NdOHM-yieLB0WytmmpYVQM', NULL, '寕靜&致逺', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIFfkvNJdia6nE8BMWWzyE801bVg2BiamwEt2fqo7mKkMbfngs9ukxCrCibwzvVr0mFu0aF63NGuDRAg/132', NULL, 1, 'China', 'Hubei', 'Yangyang', 'zh_CN', 1000017, '13868028630', '86', '2020-08-24 10:28:06', '2020-08-24 10:28:06', NULL);
INSERT INTO `user` VALUES (1000165, 1, '', 'otZjk5IiCXBx1kl0fPHGIu68Q0O4', NULL, '大愚', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJtNQWTMq4rIA2FiamnBWCzLw89TLoMeFEbWlfVlZ0o8VjPWIbJDpEsxJibsviapMaMZxO4ogk1PNrUw/132', NULL, 1, 'China', 'Heilongjiang', 'Harbin', 'zh_CN', NULL, '13100937755', '86', '2020-08-24 14:50:30', '2020-08-24 14:50:30', NULL);
INSERT INTO `user` VALUES (1000166, 4, '', 'otZjk5MjxbdL0WNfGoVYhcd-5kkI', NULL, '喵金子', 'https://thirdwx.qlogo.cn/mmopen/vi_32/IzLaELxDutsxF9Y2kg3mftoqeczCVQDbtX1YhYZu6wtdd7uZIysE7FkrxxZBI0bYvdibRbUw5sUiccP2vzBF3aqA/132', '1000166/20208251215/3k8cja0jvs0c55sbftdkp8g2e0pavufu.jpg', 2, 'CA', 'Ontario', 'Prince Edward County', 'zh_CN', 1000017, '17603065039', '86', '2020-08-25 12:14:01', '2020-08-25 12:14:01', NULL);
INSERT INTO `user` VALUES (1000167, 1, 'oC-0nuDuurm9dIauVLKR9sQ1IePY', 'otZjk5BrsRZoIRAPi-6W4IkJywtw', NULL, '冯成轩', 'https://thirdwx.qlogo.cn/mmhead/CLckM9yllDING3AzMIeTGYpDsCF5daM6F5NGRXVzMXY/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-26 06:45:09', '2020-08-26 06:45:09', NULL);
INSERT INTO `user` VALUES (1000168, 1, '', 'otZjk5AoEzdQ2-mlXam8nRYYJ2XU', NULL, '啊呦喂', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK2fvlhMTHNZVhPyvyg3SRAtVo86McxdlAHmvym2lymZ96RMcVCMljJqCz4ertffy2icZIsFFdTTLQ/132', NULL, 1, 'China', 'Shanghai', 'Minhang', 'zh_CN', 1000017, '17317837708', '86', '2020-08-27 00:02:14', '2020-08-27 00:02:14', NULL);
INSERT INTO `user` VALUES (1000169, 1, 'oC-0nuLFkyt2E3jxu7EeFcDhnMCA', 'otZjk5INA4l-8wzqydS3UHfchC7k', NULL, '王惠婷', 'https://thirdwx.qlogo.cn/mmhead/th072XaRV0dSwM0U8A561gZYCKiaY9fDI8V9DpI2Fvo0/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-27 07:47:17', '2020-08-27 07:47:17', NULL);
INSERT INTO `user` VALUES (1000170, 1, '', 'otZjk5DBgMClcGPrb3jEctMgrx44', NULL, '飞书丨王品', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Bar2cF2gHiadibkpxZdBiaVMkalib8ibYccTop3QKEj7g6oOP2Gmys5YNOPnW2d6yWQicqewmaHXiayHWniahbKR8jHf8w/132', NULL, 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '18124066116', '86', '2020-08-28 23:03:24', '2020-08-28 23:03:24', NULL);
INSERT INTO `user` VALUES (1000171, 1, 'oC-0nuN_liSQSYJsRqx2UmEAMfnw', 'otZjk5NWDSWfoMB9g2CUMM99x9nI', NULL, '张仲兰', 'https://thirdwx.qlogo.cn/mmhead/z99fpBKDvDXIYYgb3gAlPdAdOPqHUicgx0QZt9ETkVp8/132', NULL, 0, '', '', '', 'zh_CN', NULL, NULL, '86', '2020-08-30 00:45:49', '2020-08-30 00:45:49', NULL);
INSERT INTO `user` VALUES (1000172, 4, '', 'otZjk5MDW6O7iT6yJ6-Zx8Tr4Y8g', NULL, 'yoyo💘全球购～🇨🇳', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTITOYbXekFrjy4kD8qh160RvwvJasEK4Ha3Roia0bg2bSwkAjYVhRuQFuKSVnP6hS2QbNibtTsGL1Yw/132', '1000172/20208312116/3k8cja0jvr0c5b7kppv17tx380ik5b9u.jpg', 2, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', NULL, '13428691889', '86', '2020-08-31 21:08:54', '2020-08-31 21:08:54', NULL);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `address_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地址编号',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `phone_number` bigint(20) NOT NULL COMMENT '手机号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `gender` int(11) NOT NULL DEFAULT 0 COMMENT '性别,0男生1女生',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '区',
  `detailed_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '详细地址',
  `is_default` int(11) NOT NULL DEFAULT 0 COMMENT '0:不是默认地址 1:是',
  `classification` int(11) NOT NULL COMMENT '0:代购自己地址 1;名下成员员地址',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES (1, '2020-07-31 17:52:39', '2020-07-31 17:52:39', NULL, 1000006, 13212713350, '易葱', 0, '海南省', '三沙市', '西沙群岛', '诺克幼儿园', 1, 0);
INSERT INTO `user_address` VALUES (4, '2020-08-01 15:09:32', '2020-08-01 15:09:32', NULL, 1000000, 13246711966, 'more', 0, '北京市', '北京市', '东城区', '3 2', 1, 0);
INSERT INTO `user_address` VALUES (6, '2020-08-01 18:56:36', '2020-08-01 18:56:36', NULL, 1000017, 18822861951, '廖江龙', 0, '广东省', '深圳市', '宝安区', '海城路186-1号', 1, 0);
INSERT INTO `user_address` VALUES (7, '2020-08-01 19:03:46', '2020-08-01 19:03:46', NULL, 1000019, 15001977677, '王凤宇', 0, '广东省', '深圳市', '宝安区', '永丰社区6区83号401', 1, 0);
INSERT INTO `user_address` VALUES (8, '2020-08-03 12:24:33', '2020-08-03 12:24:33', NULL, 1000001, 15873231388, '吴彦祖', 0, '广东省', '深圳市', '宝安区', '海城路186-1号', 1, 0);
INSERT INTO `user_address` VALUES (13, '2020-08-04 20:00:42', '2020-08-04 20:00:42', NULL, 1000013, 13246711966, '李永华', 0, '广东省', '深圳市', '宝安区', '径贝新村112-4号', 1, 0);
INSERT INTO `user_address` VALUES (14, '2020-08-05 11:59:25', '2020-08-05 11:59:25', NULL, 1000035, 18912341234, '牛牛', 0, '广东省', '深圳市', '宝安区', '劳动路41-1号', 1, 0);
INSERT INTO `user_address` VALUES (17, '2020-08-05 22:09:42', '2020-08-05 22:09:42', NULL, 1000014, 18565619395, '陈南山', 0, '广东省', '深圳市', '宝安区', '轻铁西花园1巷1号', 1, 0);
INSERT INTO `user_address` VALUES (18, '2020-08-05 22:57:50', '2020-08-05 22:57:50', NULL, 1000044, 18565672367, '贾先生', 0, '江苏省', '苏州市', '张家港市', '长安中路343号', 0, 0);
INSERT INTO `user_address` VALUES (19, '2020-08-06 08:16:51', '2020-08-06 08:16:51', NULL, 1000040, 18565710771, '李海舟', 0, '北京市', '北京市', '东城区', '南竹竿胡同2号银河SOHO-B座', 1, 0);
INSERT INTO `user_address` VALUES (21, '2020-08-06 09:14:06', '2020-08-06 09:14:06', NULL, 1000028, 13686871951, '自己', 0, '北京市', '北京市', '东城区', '曲终人未散', 1, 0);
INSERT INTO `user_address` VALUES (22, '2020-08-06 14:29:45', '2020-08-06 14:29:45', NULL, 1000069, 15170707821, '收货人: ', 0, '\n所在地区: 广东省', '深圳市', '宝安区', '宝安区\n详细地址: 安华35区塘坊花园一巷21号D6栋。2楼', 0, 0);
INSERT INTO `user_address` VALUES (23, '2020-08-06 14:30:06', '2020-08-06 14:30:06', NULL, 1000069, 15170707821, '收货人: ', 0, '\n所在地区: 广东省', '深圳市', '宝安区', '宝安区\n详细地址: 安华35区塘坊花园一巷21号D6栋。2楼', 1, 0);
INSERT INTO `user_address` VALUES (24, '2020-08-06 14:41:27', '2020-08-06 14:41:27', NULL, 1000070, 18720083102, '李', 0, '江西省', '萍乡市', '莲花县', '泉水村', 1, 0);
INSERT INTO `user_address` VALUES (25, '2020-08-06 16:58:02', '2020-08-06 16:58:02', NULL, 1000056, 18038003905, 'yan先生', 0, '北京市海淀区', '', '', '王庄路27号城建四公司院内', 1, 0);
INSERT INTO `user_address` VALUES (26, '2020-08-06 17:06:09', '2020-08-06 17:06:09', NULL, 1000071, 18038003905, 'yan', 0, '北京市', '北京市', '海淀区', '王庄路27号汉庭优佳酒店', 1, 0);
INSERT INTO `user_address` VALUES (31, '2020-08-06 17:39:12', '2020-08-06 17:39:12', NULL, 1000001, 15873231388, '彭于晏', 0, '广东省', '深圳市', '宝安区', '海城路186-2号', 0, 0);
INSERT INTO `user_address` VALUES (32, '2020-08-06 17:45:39', '2020-08-06 17:45:39', NULL, 1000001, 15873231388, '吴笛', 0, '广东省', '深圳市', '宝安区', '西乡街道宝源二路海滨新村2栋307', 0, 0);
INSERT INTO `user_address` VALUES (34, '2020-08-06 17:47:31', '2020-08-06 17:47:31', NULL, 1000001, 18486666898, '王子', 0, '广东省', '深圳市', '宝安区', '泰逸大厦702', 0, 0);
INSERT INTO `user_address` VALUES (40, '2020-08-10 17:14:46', '2020-08-10 17:14:46', NULL, 1000075, 13145951692, '蔡瑞昌', 0, '广东省', '深圳市', '盐田区', '明珠社区北山道山海四季城B26D', 1, 0);
INSERT INTO `user_address` VALUES (41, '2020-08-10 22:12:41', '2020-08-10 22:12:41', NULL, 1000099, 13925756106, '李雅萍', 0, '广东省', '东莞市', '南城街道', '海雅百货二楼', 1, 0);
INSERT INTO `user_address` VALUES (42, '2020-08-11 10:17:43', '2020-08-11 10:17:43', NULL, 1000107, 13543316937, '孙灿', 0, '广东省', '深圳市', '龙岗区', '龙岗大道东方盛世花园C1-703', 1, 0);
INSERT INTO `user_address` VALUES (43, '2020-08-11 12:08:13', '2020-08-11 12:08:13', NULL, 1000113, 15820773736, '戴励', 0, '广东省', '深圳市', '福田区', '景田北六街景田天健花园5栋301', 1, 0);
INSERT INTO `user_address` VALUES (44, '2020-08-11 18:37:46', '2020-08-11 18:37:46', NULL, 1000008, 15338753605, '荀先生', 0, '广东省', '深圳市', '宝安区', '海城路泰逸大厦702', 1, 0);
INSERT INTO `user_address` VALUES (45, '2020-08-12 00:11:15', '2020-08-12 00:11:15', NULL, 1000022, 13145906814, '陆晓敏', 0, '广东省', '深圳市', '盐田区', '北山道山海四季城花园B26D', 1, 0);
INSERT INTO `user_address` VALUES (46, '2020-08-18 17:39:27', '2020-08-18 17:39:27', NULL, 1000095, 13430388157, '许洪霞', 0, '广东省', '深圳市', '宝安区', '海城路235号泰逸大厦7楼702室', 1, 0);
INSERT INTO `user_address` VALUES (47, '2020-08-18 17:54:34', '2020-08-18 17:54:34', NULL, 1000148, 13682648914, '张洁', 0, '广东省', '深圳市', '宝安区', '西乡街道海城路泰逸大厦7楼F7-002', 1, 0);
INSERT INTO `user_address` VALUES (48, '2020-08-18 18:02:45', '2020-08-18 18:02:45', NULL, 1000017, 13430388157, '红霞', 0, '广东省', '深圳市', '宝安区', '海城路235号泰逸大厦7楼702', 0, 0);
INSERT INTO `user_address` VALUES (49, '2020-08-18 18:17:49', '2020-08-18 18:17:49', NULL, 1000016, 15099900112, '崔', 0, '广东省', '深圳市', '宝安区', '海城路泰逸大厦F7002', 1, 0);
INSERT INTO `user_address` VALUES (50, '2020-08-18 18:23:26', '2020-08-18 18:23:26', NULL, 1000106, 18706821922, '袁凯强', 0, '陕西省', '渭南市', '澄城县', '尧头镇浴子河村一组', 1, 0);
INSERT INTO `user_address` VALUES (51, '2020-08-18 18:24:50', '2020-08-18 18:24:50', NULL, 1000017, 15099900112, '崔生生', 0, '广东省', '深圳市', '宝安区', '海城路泰逸大厦F7002', 0, 0);
INSERT INTO `user_address` VALUES (52, '2020-08-18 19:04:27', '2020-08-18 19:04:27', NULL, 1000064, 18682443968, '邢娇', 0, '广东省', '深圳市', '南山区', '松坪村西区5栋6d', 1, 0);
INSERT INTO `user_address` VALUES (53, '2020-08-18 21:07:22', '2020-08-18 21:07:22', NULL, 1000122, 13555555555, 'jz', 0, '北京市', '北京市', '东城区', 'tttt', 1, 0);
INSERT INTO `user_address` VALUES (54, '2020-08-20 21:20:06', '2020-08-20 21:20:06', NULL, 1000148, 13682648914, '张洁', 0, '广东省', '深圳市', '宝安区', '新安街道宝雅花园B栋一单元601', 0, 0);
INSERT INTO `user_address` VALUES (55, '2020-08-20 22:17:09', '2020-08-20 22:17:09', NULL, 1000057, 18824307739, '苏丽', 0, '广东省', '深圳市', '宝安区', '西乡上三村一排五号302', 1, 0);
INSERT INTO `user_address` VALUES (56, '2020-08-20 22:22:14', '2020-08-20 22:22:14', NULL, 1000154, 13530897455, '代天益', 0, '广东省', '深圳市', '宝安区', '西乡街道西乡步行街河西路112号楼上', 1, 0);
INSERT INTO `user_address` VALUES (57, '2020-08-20 22:27:38', '2020-08-20 22:27:38', NULL, 1000158, 13410960102, '张先生', 0, '广东省', '东莞市', '松山湖管委会', '玉兰路观园101栋2501', 1, 0);
INSERT INTO `user_address` VALUES (58, '2020-08-21 13:56:52', '2020-08-21 13:56:52', NULL, 1000054, 13689580681, '小英', 0, '广东省', '深圳市', '宝安区', '华侨新村西堤三巷39号', 1, 0);
INSERT INTO `user_address` VALUES (59, '2020-08-21 14:19:15', '2020-08-21 14:19:15', NULL, 1000017, 13689580681, '小英', 0, '广东省', '深圳市', '宝安区', '华侨新村西堤三巷39号', 0, 0);
INSERT INTO `user_address` VALUES (60, '2020-08-28 10:53:04', '2020-08-28 10:53:04', NULL, 1000024, 18617188606, '姜楠', 0, '广东省', '深圳市', '宝安区', '码头路53号', 1, 0);

-- ----------------------------
-- Table structure for user_login_records
-- ----------------------------
DROP TABLE IF EXISTS `user_login_records`;
CREATE TABLE `user_login_records`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '登录时间',
  `type` int(11) NOT NULL COMMENT '登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_login_records
-- ----------------------------
INSERT INTO `user_login_records` VALUES (2, 1000017, '2020-08-03 17:10:48', 0);
INSERT INTO `user_login_records` VALUES (5, 1000013, '2020-08-03 17:13:00', 0);
INSERT INTO `user_login_records` VALUES (7, 1000008, '2020-08-03 17:18:43', 0);
INSERT INTO `user_login_records` VALUES (8, 0, '2020-08-05 09:54:00', 0);
INSERT INTO `user_login_records` VALUES (9, 0, '2020-08-05 09:56:04', 0);
INSERT INTO `user_login_records` VALUES (10, 0, '2020-08-05 09:56:11', 0);
INSERT INTO `user_login_records` VALUES (11, 0, '2020-08-05 09:56:17', 0);
INSERT INTO `user_login_records` VALUES (12, 0, '2020-08-07 17:17:26', 0);
INSERT INTO `user_login_records` VALUES (13, 0, '2020-08-07 17:17:28', 0);
INSERT INTO `user_login_records` VALUES (14, 0, '2020-08-07 17:48:11', 0);
INSERT INTO `user_login_records` VALUES (15, 0, '2020-08-07 17:48:22', 0);
INSERT INTO `user_login_records` VALUES (16, 0, '2020-08-07 18:40:43', 0);
INSERT INTO `user_login_records` VALUES (17, 0, '2020-08-07 18:40:44', 0);
INSERT INTO `user_login_records` VALUES (18, 0, '2020-08-07 18:40:46', 0);
INSERT INTO `user_login_records` VALUES (19, 0, '2020-08-07 18:40:46', 0);
INSERT INTO `user_login_records` VALUES (20, 0, '2020-08-07 18:40:47', 0);
INSERT INTO `user_login_records` VALUES (21, 0, '2020-08-07 18:40:48', 0);
INSERT INTO `user_login_records` VALUES (22, 0, '2020-08-07 18:41:41', 0);
INSERT INTO `user_login_records` VALUES (23, 0, '2020-08-07 18:41:42', 0);

-- ----------------------------
-- Table structure for user_set_up
-- ----------------------------
DROP TABLE IF EXISTS `user_set_up`;
CREATE TABLE `user_set_up`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `privacy_policy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '隐私政策',
  `user_service_agreement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户服务协议',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_set_up
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员充值流水表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_recharge_records
-- ----------------------------
INSERT INTO `vip_recharge_records` VALUES (1, '', '15961883291000003', 1000003, 192.00, 4, 0, '12个月VIP', '2020-07-31 17:38:49', '2020-07-31 17:38:49');
INSERT INTO `vip_recharge_records` VALUES (2, '', '15962047591000011', 1000011, 192.00, 4, 0, '12个月VIP', '2020-07-31 22:12:39', '2020-07-31 22:12:39');
INSERT INTO `vip_recharge_records` VALUES (3, '4200000576202008017253144200', '15962772541000017', 1000017, 0.01, 1, 1, '1个月VIP', '2020-08-01 18:20:55', '2020-08-01 18:20:55');
INSERT INTO `vip_recharge_records` VALUES (4, '', '15965420451000032', 1000032, 192.00, 4, 0, '12个月VIP', '2020-08-04 19:54:06', '2020-08-04 19:54:06');
INSERT INTO `vip_recharge_records` VALUES (5, '', '15966211621000010', 1000010, 192.00, 4, 0, '12个月VIP', '2020-08-05 17:52:43', '2020-08-05 17:52:43');
INSERT INTO `vip_recharge_records` VALUES (6, '', '15966308821000038', 1000038, 192.00, 4, 0, '12个月VIP', '2020-08-05 20:34:43', '2020-08-05 20:34:43');
INSERT INTO `vip_recharge_records` VALUES (7, '', '15966340461000035', 1000035, 1.00, 1, 0, '1个月VIP', '2020-08-05 21:27:27', '2020-08-05 21:27:27');
INSERT INTO `vip_recharge_records` VALUES (9, '', '15967142071000010', 1000010, 192.00, 4, 0, '12个月VIP', '2020-08-06 19:43:28', '2020-08-06 19:43:28');
INSERT INTO `vip_recharge_records` VALUES (11, '', '15967166991000010', 1000010, 192.00, 4, 0, '12个月VIP', '2020-08-06 20:24:59', '2020-08-06 20:24:59');
INSERT INTO `vip_recharge_records` VALUES (12, '', '15968035601000038', 1000038, 192.00, 4, 0, '12个月VIP', '2020-08-07 20:32:41', '2020-08-07 20:32:41');
INSERT INTO `vip_recharge_records` VALUES (13, '', '15968067511000087', 1000087, 192.00, 4, 0, '12个月VIP', '2020-08-07 21:25:52', '2020-08-07 21:25:52');
INSERT INTO `vip_recharge_records` VALUES (14, '', '15968671621000088', 1000088, 192.00, 4, 0, '12个月VIP', '2020-08-08 14:12:43', '2020-08-08 14:12:43');
INSERT INTO `vip_recharge_records` VALUES (15, '4200000574202008117763185628', '15970813491000022', 1000022, 1.00, 1, 1, '1个月VIP', '2020-08-11 01:42:30', '2020-08-11 01:42:30');
INSERT INTO `vip_recharge_records` VALUES (16, '', '15971415011000003', 1000003, 192.00, 4, 0, '12个月VIP', '2020-08-11 18:25:02', '2020-08-11 18:25:02');
INSERT INTO `vip_recharge_records` VALUES (17, '', '15971424601000038', 1000038, 192.00, 4, 0, '12个月VIP', '2020-08-11 18:41:01', '2020-08-11 18:41:01');
INSERT INTO `vip_recharge_records` VALUES (18, '4200000573202008122044623047', '15972212671000016', 1000016, 1.00, 1, 1, '1个月VIP', '2020-08-12 16:34:27', '2020-08-12 16:34:27');
INSERT INTO `vip_recharge_records` VALUES (19, '', '15974724291000032', 1000032, 192.00, 4, 0, '12个月VIP', '2020-08-15 14:20:30', '2020-08-15 14:20:30');
INSERT INTO `vip_recharge_records` VALUES (20, '4200000683202008205560373115', '15979361521000148', 1000148, 1.00, 1, 1, '1个月VIP', '2020-08-20 23:09:13', '2020-08-20 23:09:13');
INSERT INTO `vip_recharge_records` VALUES (21, '', '15980756751000002', 1000002, 192.00, 4, 0, '12个月VIP', '2020-08-22 13:54:35', '2020-08-22 13:54:35');
INSERT INTO `vip_recharge_records` VALUES (22, '', '15986812211000087', 1000087, 192.00, 4, 0, '12个月VIP', '2020-08-29 14:07:02', '2020-08-29 14:07:02');

-- ----------------------------
-- Procedure structure for delete_userby_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_userby_id`;
delimiter ;;
CREATE PROCEDURE `delete_userby_id`(in _user_id INT)
BEGIN

delete from user where user_id = _user_id;
delete from user_login_records where user_id = _user_id;
delete from user_address where user_id = _user_id;
delete from vip_recharge_records where user_id = _user_id;
delete from shop_info where user_id = _user_id;
delete from shop_wallet where shop_id = _user_id;
delete from shop_vip where user_id = _user_id;
delete from shop_fans where user_id = _user_id;
delete from shop_access_records where user_id = _user_id;
delete from shop_profit where user_id = _user_id;
delete from orders where user_id = _user_id;
delete from goods_access_records where user_id = _user_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for set_auto_increment
-- ----------------------------
DROP PROCEDURE IF EXISTS `set_auto_increment`;
delimiter ;;
CREATE PROCEDURE `set_auto_increment`(in db VARCHAR(50))
BEGIN
	DECLARE
		end_flag INT DEFAULT 0;
	DECLARE
		tmp_table_name VARCHAR ( 256 );
	DECLARE
		album_curosr CURSOR FOR ( SELECT table_name FROM information_schema.TABLES WHERE table_schema = db AND table_type = 'BASE TABLE' );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET end_flag = 1;
	OPEN album_curosr;
	REPEAT
			FETCH album_curosr INTO tmp_table_name;
		IF
			tmp_table_name <=> "user" THEN
				
				SET @sqlStr = CONCAT( 'ALTER TABLE ', tmp_table_name, ' auto_increment=1000000;' );
			ELSE 
				SET @sqlStr = CONCAT( 'ALTER TABLE ', tmp_table_name, ' auto_increment=1;' );
			
		END IF;
		PREPARE stmt 
		FROM
			@sqlStr;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		UNTIL end_flag 
	END REPEAT;
CLOSE album_curosr;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for truncate_access_records
-- ----------------------------
DROP PROCEDURE IF EXISTS `truncate_access_records`;
delimiter ;;
CREATE PROCEDURE `truncate_access_records`()
BEGIN
truncate TABLE goods_access_records;
truncate TABLE shop_access_records;
truncate TABLE user_login_records;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for truncate_all_tables
-- ----------------------------
DROP PROCEDURE IF EXISTS `truncate_all_tables`;
delimiter ;;
CREATE PROCEDURE `truncate_all_tables`(in db VARCHAR(50))
BEGIN
	DECLARE
		tmp_table_name VARCHAR ( 256 );
	DECLARE
		end_flag INT DEFAULT 0;
	DECLARE
		album_curosr CURSOR FOR ( SELECT table_name FROM information_schema.TABLES WHERE table_schema = db AND table_type = 'BASE TABLE' );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET end_flag = 1;
	OPEN album_curosr;
	REPEAT
			FETCH album_curosr INTO tmp_table_name;
		
		SET @sqlStr = CONCAT( 'TRUNCATE ',db, ".",tmp_table_name);
		PREPARE stmt 
		FROM
			@sqlStr;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		UNTIL end_flag 
	END REPEAT;
CLOSE album_curosr;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
