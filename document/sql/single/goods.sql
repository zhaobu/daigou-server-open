/*
 Navicat Premium Data Transfer

 Source Server         : 代购测试服
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 119.23.138.52:3306
 Source Schema         : daigou

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 12/06/2020 15:40:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `goods_id` int(0) NOT NULL COMMENT '商品id',
  `shop_id` int(0) UNSIGNED NOT NULL COMMENT '商店id',
  `goods_status` int(0) NOT NULL DEFAULT 0 COMMENT '商品状态0下架1上架2售空3即将过期4已过期5删除',
  `category_id` int(0) NOT NULL DEFAULT 0 COMMENT '分类id',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名字',
  `goods_comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品说明',
  `goods_img_url` json NULL COMMENT '商品图片（oss链接，一次性加载多张图片）',
  `input_time` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `over_time` datetime(0) NULL DEFAULT NULL COMMENT '过期时间',
  `add_time` datetime(0) NULL DEFAULT NULL COMMENT '上架时间',
  `down_time` datetime(0) NULL DEFAULT NULL COMMENT '下架时间',
  `goods_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品来源',
  `price` decimal(20, 2) UNSIGNED NOT NULL COMMENT '商品价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 1, 1821198978, 1, 1, 'iPhone', '代购手机', '[\"http://s.laoyaoba.com/jwImg/news/2020/03/25/15851278347613.png"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);
INSERT INTO `goods` VALUES (2, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 2, 1821198978, 1, 1, '华为手机', '代购手机', '[\"http://5b0988e595225.cdn.sohucs.com/images/20200323/d77b46b2b757416a93e22431095b269b.jpeg\"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);
INSERT INTO `goods` VALUES (3, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 3, 1821198978, 1, 2, '香水', '代购10瓶香水,从澳门', '[\"https://fineboys-online.jp/thegear/content/theme/media/88499香水２０.jpg\"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);
INSERT INTO `goods` VALUES (4, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 4, 1821198978, 1, 3, '面膜', '代购面膜', '[\"http://5b0988e595225.cdn.sohucs.com/images/20190910/70918a381ae74e87bb1342b118b43d26.jpeg\"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);
INSERT INTO `goods` VALUES (5, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 4, 1821198978, 1, 4, '洗面奶', '代购面膜', '[\"http://img.sjgo365.com/ProductImage800/26678434.jpg\"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);
INSERT INTO `goods` VALUES (6, '2020-06-12 15:28:29', '2020-06-12 15:28:33', NULL, 4, 1821198978, 1, 4, '化妆品', '代购化妆品', '[\"http://5b0988e595225.cdn.sohucs.com/images/20190910/70918a381ae74e87bb1342b118b43d26.jpeg\"]', '2020-06-12 15:30:04', '2020-06-13 15:30:06', '2020-06-12 15:30:10', '2020-06-14 15:30:16', '大陆', 100.99);

SET FOREIGN_KEY_CHECKS = 1;
