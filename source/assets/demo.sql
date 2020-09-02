/*
 Navicat MySQL Data Transfer

 Source Server         : 本地连接
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 17/10/2019 16:56:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity`  (
  `activity_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activity_start_time` datetime NOT NULL,
  `organization_id` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`activity_id`) USING BTREE,
  INDEX `Ref_01`(`organization_id`) USING BTREE,
  CONSTRAINT `Ref_01` FOREIGN KEY (`organization_id`) REFERENCES `t_organization` (`organization_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_activity
-- ----------------------------
INSERT INTO `t_activity` VALUES (1, '英雄联盟高校联赛', '2019-10-17 16:47:58', 2);
INSERT INTO `t_activity` VALUES (4, '英雄联盟网吧联赛', '2019-10-17 16:48:18', 2);
INSERT INTO `t_activity` VALUES (5, '英雄联盟LPL联赛', '2019-10-17 16:49:05', 1);
INSERT INTO `t_activity` VALUES (6, '英雄联盟世界赛', '2019-10-17 16:49:21', 1);

-- ----------------------------
-- Table structure for t_organization
-- ----------------------------
DROP TABLE IF EXISTS `t_organization`;
CREATE TABLE `t_organization`  (
  `organization_id` int(20) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `organization_tell` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`organization_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_organization
-- ----------------------------
INSERT INTO `t_organization` VALUES (1, '英雄联盟官方', '13000000001');
INSERT INTO `t_organization` VALUES (2, '电子竞技协会', '13000000002');

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student`  (
  `stu_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stu_num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`stu_id`) USING BTREE,
  UNIQUE INDEX `stu_num_unique`(`stu_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES (1, '张三', '5120180001');
INSERT INTO `t_student` VALUES (2, '李四', '5120180002');
INSERT INTO `t_student` VALUES (3, '王五', '5120180003');
INSERT INTO `t_student` VALUES (4, '笑笑', '5120180004');
INSERT INTO `t_student` VALUES (5, '骚男', '5120180005');
INSERT INTO `t_student` VALUES (6, '小明', '5120180006');
INSERT INTO `t_student` VALUES (7, '小强', '5120180007');
INSERT INTO `t_student` VALUES (8, '大司马', '5120180008');
INSERT INTO `t_student` VALUES (9, '金咕咕', '5120180009');
INSERT INTO `t_student` VALUES (10, '小虎', '5120180010');

-- ----------------------------
-- Table structure for t_student_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_student_activity`;
CREATE TABLE `t_student_activity`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `join_time` datetime NOT NULL,
  `stu_id` int(20) UNSIGNED NOT NULL DEFAULT 0,
  `activity_id` int(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_join_activity`(`stu_id`, `activity_id`) USING BTREE,
  INDEX `Ref_03`(`activity_id`) USING BTREE,
  CONSTRAINT `Ref_02` FOREIGN KEY (`stu_id`) REFERENCES `t_student` (`stu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Ref_03` FOREIGN KEY (`activity_id`) REFERENCES `t_activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_student_activity
-- ----------------------------
INSERT INTO `t_student_activity` VALUES (1, '2019-10-17 16:49:39', 1, 1);
INSERT INTO `t_student_activity` VALUES (4, '2019-10-17 16:49:39', 2, 1);
INSERT INTO `t_student_activity` VALUES (7, '2019-10-17 16:49:39', 3, 1);
INSERT INTO `t_student_activity` VALUES (8, '2019-10-17 16:49:39', 1, 4);
INSERT INTO `t_student_activity` VALUES (9, '2019-10-17 16:49:39', 6, 5);
INSERT INTO `t_student_activity` VALUES (10, '2019-10-17 16:49:39', 6, 4);
INSERT INTO `t_student_activity` VALUES (11, '2019-10-17 16:49:39', 7, 1);
INSERT INTO `t_student_activity` VALUES (12, '2019-10-17 16:49:39', 8, 6);
INSERT INTO `t_student_activity` VALUES (13, '2019-10-17 16:49:39', 8, 4);
INSERT INTO `t_student_activity` VALUES (14, '2019-10-17 16:49:39', 9, 1);

SET FOREIGN_KEY_CHECKS = 1;
