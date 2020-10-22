/*
 Navicat Premium Data Transfer

 Source Server         : 正式服
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 127.0.0.1:3306
 Source Schema         : daigou_dev

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 17/09/2020 17:54:24
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色api表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of express_template_config
-- ----------------------------
INSERT INTO `express_template_config` VALUES (2, '顺丰速运 76*180', '! 0 200 200 1408 1\r\nPAGE-WIDTH 576\r\nBOX 0 0 576 664 2 \r\nLINE 0 88 576 88 1 \r\nLINE 0 216 576 216 1\r\nLINE 0 296 576 296 1\r\nLINE 0 440 528 440 1\r\nLINE 0 568 528 568 1\r\nLINE 528 296 528 664 1 \r\nLINE 48 296 48 568 1 \r\nLINE 120 568 120 664 1 \r\nCENTER\r\nBARCODE 128 2 3 80 0 100 [BackCode]\r\nSETSP 12\r\nTEXT 8 0 0 188 [BackCode] \r\nSETSP 0\r\nSETMAG 2 2\r\nTEXT 8 0 0 236 [KuaiDiAddress]\r\nSETMAG 1 1\r\nLEFT\r\nSETBOLD 1\r\nTEXT 4 0 64 320 [Rname] [Rphone]\r\nTEXT 4 0 64 363 [Raddress]\r\nTEXT 4 0 64 395 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 13 334 收\r\nTEXT 8 0 13 380 件\r\nTEXT 8 0 13 470 发\r\nTEXT 8 0 13 516 件\r\nTEXT 4 0 64 464 [Sname] [Sphone]\r\nTEXT 4 0 64 500 [Saddress]\r\nTEXT 4 0 64 528 [SaddressDetail]\r\nTEXT 8 0 541 400 派\r\nTEXT 8 0 541 464 件\r\nTEXT 8 0 541 528 联\r\nTEXT 8 0 13 580 打印日期\r\nTEXT 55 0 13 608 [Fdate]\r\nTEXT 55 0 13 624 [Ftime]\r\nTEXT 8 0 128 580 签收人/签收时间\r\nTEXT 55 0 128 608 你的签字代表您已验收此包裹，并已确认商品信息\r\nTEXT 55 0 128 624 无误,包装完好,没有划痕,破损等表面质量问题。\r\nTEXT 8 0 450 632 月  日\r\nBOX 0 696 576 968 2\r\nLINE 0 776 576 776 1\r\nLINE 0 912 528 912 1\r\nLINE 264 776 264 912 1 \r\nLINE 528 776 528 968 1\r\nBARCODE 128 1 3 36 352 712  [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 752  [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 792 收件\r\nSETBOLD 1\r\nTEXT 55 0 13 828 [Rname] [Rphone]\r\nTEXT 55 0 13 860 [Raddress]\r\nTEXT 55 0 13 888 [RaddressDetail]\r\nSETBOLD 0\r\nTEXT 8 0 277 792 发件\r\nTEXT 55 0 277 828 [Sname] [Sphone]\r\nTEXT 55 0 277 860 [Saddress]\r\nTEXT 55 0 277 888 [SaddressDetail]\r\nTEXT 8 0 541 808 客\r\nTEXT 8 0 541 862 户\r\nTEXT 8 0 541 916 联\r\nTEXT 8 0 16 928 物品：[GoodsType]\r\nBOX 424 920 512 960 1\r\nTEXT 8 0 432 928 已验视\r\nBOX 0 1000 576 1408 2\r\nLINE 0 1080 576 1080 1\r\nLINE 0 1216 528 1216 1\r\nLINE 0 1352 528 1352 1\r\nLINE 48 1080 48 1352 1\r\nLINE 528 1080 528 1408 1\r\nBARCODE 128 1 3 36 352 1016 [BackCode]\r\nSETSP 10\r\nTEXT 55 0 352 1056 [BackCode]\r\nSETSP 0\r\nTEXT 8 0 13 1114 收\r\nTEXT 8 0 13 1160 件\r\nTEXT 8 0 13 1250 发\r\nTEXT 8 0 13 1296 件\r\nTEXT 8 0 64 1108  [Rname] [Rphone]\r\nTEXT 8 0 64 1144 [Raddress]\r\nTEXT 8 0 64 1172 [RaddressDetail]\r\nTEXT 8 0 64 1244 [Sname] [Sphone]\r\nTEXT 8 0 64 1280 [Saddress]\r\nTEXT 8 0 64 1308 [SaddressDetail]\r\nTEXT 8 0 13 1368 物品：[GoodsType]\r\nTEXT 8 0 200 1368 快递费用：[Offer]\r\nBOX 424 1360 512 1400 1\r\nTEXT 8 0 432 1368 已验视\r\nTEXT 8 0 541 1164 寄\r\nTEXT 8 0 541 1234 件\r\nTEXT 8 0 541 1304 联\r\nFORM\r\nPRINT\r\n', 1);
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
  `goods_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品所属商铺id',
  `hgs_id` bigint(20) UNSIGNED NOT NULL COMMENT '仓库商品id',
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
  `es_de_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '预计发货时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `goodid`(`goods_id`) USING BTREE,
  INDEX `shopid`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 452 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_access_records
-- ----------------------------

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` int(11) NOT NULL COMMENT '分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES (17, 1, '数码');
INSERT INTO `goods_category` VALUES (18, 2, '护肤');
INSERT INTO `goods_category` VALUES (19, 3, '轻奢');
INSERT INTO `goods_category` VALUES (20, 4, '服装');
INSERT INTO `goods_category` VALUES (21, 5, '美妆');
INSERT INTO `goods_category` VALUES (22, 6, '水果');
INSERT INTO `goods_category` VALUES (23, 7, '蔬果');
INSERT INTO `goods_category` VALUES (24, 8, '其他');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品留言' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_message
-- ----------------------------

-- ----------------------------
-- Table structure for h_customer
-- ----------------------------
DROP TABLE IF EXISTS `h_customer`;
CREATE TABLE `h_customer`  (
  `customer_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺ID',
  `cr_nick` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户昵称',
  `cr_headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '头像',
  `cr_userid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '平台用户id(未绑定时 该字段为0 ）',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '我的客户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_customer
-- ----------------------------

-- ----------------------------
-- Table structure for h_customer_addr
-- ----------------------------
DROP TABLE IF EXISTS `h_customer_addr`;
CREATE TABLE `h_customer_addr`  (
  `address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地址编号',
  `customer_id` int(11) UNSIGNED NOT NULL COMMENT '客户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `phone_number` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '手机号码',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '区',
  `detailed` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '详细地址',
  `is_default` int(11) NOT NULL DEFAULT 0 COMMENT '0:不是默认地址 1:是',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_customer_addr
-- ----------------------------

-- ----------------------------
-- Table structure for h_goods
-- ----------------------------
DROP TABLE IF EXISTS `h_goods`;
CREATE TABLE `h_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `hgs_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品库id',
  `hgs_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称 不能重复 ',
  `hgs_salenum` int(10) UNSIGNED NOT NULL COMMENT '已售数量',
  `hgs_surplusnum` int(10) NOT NULL COMMENT '剩余库存',
  `hgs_source` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '货源地',
  `hgs_builddate` datetime(0) NULL DEFAULT NULL COMMENT '生产日期',
  `hgs_expday` int(10) NULL DEFAULT NULL COMMENT '保质期（天）',
  `hgs_explain` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品介绍',
  `hgs_inprice` decimal(20, 2) NOT NULL COMMENT '进价',
  `hgs_saleprice` decimal(20, 2) NOT NULL COMMENT '售价',
  `hgs_img` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品图片',
  `hgs_status` int(2) NOT NULL COMMENT '商品库状态 （-1 删除 0  在库 1 在售）',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`hgs_name`, `shop_id`) USING BTREE COMMENT '仓库内商品名唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_goods
-- ----------------------------

-- ----------------------------
-- Table structure for h_preorder
-- ----------------------------
DROP TABLE IF EXISTS `h_preorder`;
CREATE TABLE `h_preorder`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tag_id` int(11) UNSIGNED NOT NULL COMMENT '预购标签id',
  `hgs_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品库id',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺id',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户id',
  `buy_status` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '购买状态 （0 预购 1 已买)',
  `discount` decimal(20, 2) NULL DEFAULT NULL COMMENT '其他优惠 （可正负 ）',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '预购清单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_preorder
-- ----------------------------

-- ----------------------------
-- Table structure for h_stock_record
-- ----------------------------
DROP TABLE IF EXISTS `h_stock_record`;
CREATE TABLE `h_stock_record`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `hgs_id` bigint(20) UNSIGNED NOT NULL COMMENT '仓库商品id',
  `hsr_type` int(11) NOT NULL COMMENT '变化类型（-1 删除 0初始库存 1修改 2进货 3售卖）',
  `hsr_num` int(11) NOT NULL COMMENT '变化数量',
  `hsr_price` decimal(20, 2) UNSIGNED NOT NULL COMMENT '进价价格  （当为售卖类型时 保存售价）',
  `hsr_inputtype` int(11) NOT NULL COMMENT '进价类型（0取平均值 1 直接更新进价）',
  `hsr_afternum` int(11) NOT NULL COMMENT '变化后的库存',
  `hsr_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '库存变化记录详情' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_stock_record
-- ----------------------------

-- ----------------------------
-- Table structure for h_tag
-- ----------------------------
DROP TABLE IF EXISTS `h_tag`;
CREATE TABLE `h_tag`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '店铺id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标签名称',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_tag
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
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户id',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '客户名称',
  `order_status` int(11) NOT NULL COMMENT '订单状态0待确认1待发货2已发货3已完成',
  `preferential_price` decimal(20, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `price` decimal(20, 2) NOT NULL COMMENT '总金额',
  `profit` decimal(20, 2) NOT NULL COMMENT '订单利润',
  `goods_name_arr` json NULL COMMENT '订单商品列表',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '买家备注',
  `ispay` int(11) NOT NULL COMMENT '是否已支付',
  `isdeliver` int(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已全部发货 0不是 1是',
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
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单账单流水记录表' ROW_FORMAT = Dynamic;

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
  `hp_id` bigint(20) UNSIGNED NOT NULL COMMENT '预购清单表id',
  `hgs_id` bigint(20) UNSIGNED NOT NULL COMMENT '商品库id',
  `logistics_id` int(20) UNSIGNED NOT NULL COMMENT '订单物流id',
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
  `paidmoney` decimal(20, 2) NULL DEFAULT NULL COMMENT '定金',
  `pay_status` int(5) UNSIGNED NOT NULL COMMENT '付款状态 (0 未付 1已付 ）',
  `order_goods_status` int(5) UNSIGNED NOT NULL COMMENT '商品订单状态 0未买到 1已买到 2已发货 3已完成',
  `status` int(5) NOT NULL DEFAULT 0 COMMENT '状态（-1 删除 0正常）',
  `buy_time` datetime(0) NULL DEFAULT NULL COMMENT '商家买到时间或者买家下单时间',
  `pay_time` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `ship_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `complete_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单对应商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_goods
-- ----------------------------

-- ----------------------------
-- Table structure for orders_logistics
-- ----------------------------
DROP TABLE IF EXISTS `orders_logistics`;
CREATE TABLE `orders_logistics`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0发送中1收货中2完成-1异常',
  `cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费成本',
  `offer` decimal(10, 2) NOT NULL COMMENT '运费报价',
  `is_default` int(5) NOT NULL DEFAULT 0 COMMENT '默认物流 1表示默认，0表示其他',
  `uf_pay_status` int(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '邮费付款状态 （0未付 1已付）',
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
   UNIQUE INDEX `order_id`(`order_id`, `is_default`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单物流信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_logistics
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_printing
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 2965 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商店访问流水' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_access_records
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_category
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '店铺码' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_code_records
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_express
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代购粉丝表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_fans
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商铺' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_info
-- ----------------------------
INSERT INTO `shop_info` VALUES (19, 1000028, '2020-07-31 17:41:04', '2020-07-31 17:41:04', NULL, 1000028, '诚物优选', 'https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311754/tQEKj8KmAx.png', '诚信代物❤️', NULL, 17, 'e13360065873', 1, 0, '[2, 5, 4, 3]', '{\"travel_info\": [{\"url\": [\"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/1000004/20207311836/idN7RnG3th.png\"], \"end_time\": \"2020-08-27 18:03:00\", \"start_time\": \"2020-08-02 18:03:00\", \"departure_point\": \"深圳\", \"destination_point\": \"东京\"}]}', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_profit
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商铺后台管理团队成员表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员身份等级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_vip
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_vip_explain
-- ----------------------------
INSERT INTO `shop_vip_explain` VALUES (1, '订单处理 ', '普通用户每日3单限制', -1, 3);
INSERT INTO `shop_vip_explain` VALUES (2, '自定义banner', '普通会员不可定义', -1, 0);
INSERT INTO `shop_vip_explain` VALUES (3, '收支明细', '普通会员不可查看', -1, 0);
INSERT INTO `shop_vip_explain` VALUES (4, '蓝牙打印', '普通会员每日3次', -1, 3);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_vip_price
-- ----------------------------
INSERT INTO `shop_vip_price` VALUES (1, '1个月VIP', 0.01, 20.00, '首月试用');
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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员财富表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_wallet
-- ----------------------------
INSERT INTO `shop_wallet` VALUES (20, 1000028, 0, 0.00, 0.00, '2020-07-31 17:41:04', '2020-07-31 17:41:04');

-- ----------------------------
-- Table structure for system_ann
-- ----------------------------
DROP TABLE IF EXISTS `system_ann`;
CREATE TABLE `system_ann`  (
  `id` int(11) NOT NULL,
  `system_ann_version` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '版本号',
  `system_ann_target` int(10) UNSIGNED NOT NULL COMMENT '0所有 1普通用户2代购',
  `system_ann_type` int(10) UNSIGNED NOT NULL COMMENT '0拉取信息 1滚动展示 2弹框展示',
  `system_ann_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '内容',
  `system_ann_status` int(255) UNSIGNED NOT NULL COMMENT '状态 0禁用 1开启',
  `created_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_ann
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 1, 'mainpage_max_url', '6');
INSERT INTO `system_config` VALUES (2, 2, 'mainpage_max_spec', '10');
INSERT INTO `system_config` VALUES (3, 3, 'mainpage_max_category', '7');
INSERT INTO `system_config` VALUES (4, 4, 'mainpage_scroll_image', '[{\"url\": \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image1.jpg\", \"shop_url\": \"\"}, {\"url\": \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image2.jpg\", \"shop_url\": \"\"}, {\"url\": \"https://daigou-1302455079.cos.ap-guangzhou.myqcloud.com/system_config/mainpage_scroll_image3.jpg\", \"shop_url\": \"\"}]');
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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统快递公司资料' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '第三方快递接口' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1000030 AVG_ROW_LENGTH = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1000028, 4, '', 'otZjk5JofTWYX8r1-wS_ucD91VDE', NULL, '小码', 'https://wx.qlogo.cn/mmopen/vi_32/CED6Q8VjibXbfstPNOoseZsXZAyiaJCh8FWP2bv0tAAZ34kN0NB487ZZmQfz1lVAZ5VqQl4AiaQRZOfBK0xWmy3MQ/132', '1000004/20207311741/3k8cja0l100c4kpl9cug7ywb00833ze2.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 0, '133****5773', '86', '2020-07-31 17:39:21', '2020-07-31 17:39:21', NULL);
INSERT INTO `user` VALUES (1000029, 1, '', 'otZjk5MwbaFPaqIPH9yhwgQljoBA', NULL, '小趣', 'https://wx.qlogo.cn/mmopen/vi_32/4QY4IPX0VQhYcR58wg3qGlmWIkEiaiaZ5nleibuwR8NzAHIpXz3VT8DCD9FxicuNWhrMYicmwq4pQ0RjXdlicxO35yIA/132', '1000026/20208040953/3k8cja0k700c4nu5ms8zndip00ozasab.jpg', 1, 'China', 'Guangdong', 'Shenzhen', 'zh_CN', 1000028, '185****5774', '86', '2020-08-03 11:51:11', '2020-08-03 11:51:11', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_login_records
-- ----------------------------

-- ----------------------------
-- Table structure for user_set_up
-- ----------------------------
DROP TABLE IF EXISTS `user_set_up`;
CREATE TABLE `user_set_up`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `privacy_policy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '隐私政策',
  `user_service_agreement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户服务协议',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '会员充值流水表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip_recharge_records
-- ----------------------------

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
