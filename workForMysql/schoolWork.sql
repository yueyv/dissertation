/*
 Navicat Premium Data Transfer

 Source Server         : workformysql
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : 20.213.10.238:3306
 Source Schema         : schoolWork

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 17/03/2024 21:33:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (0, 'yueyvlunhui', '37927bbeddfc2d162b200434e436b599');
INSERT INTO `admins` VALUES (1, 'admin', '@Admin123');

-- ----------------------------
-- Table structure for job_applications
-- ----------------------------
DROP TABLE IF EXISTS `job_applications`;
CREATE TABLE `job_applications`  (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `user_id` int NOT NULL,
  `resume_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cover_letter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`app_id`) USING BTREE,
  INDEX `job_id`(`job_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `job_applications_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `job_applications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_applications
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `salary_range` int NOT NULL,
  `vaild` int NOT NULL,
  `applicant_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `walfare` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `job_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES (11, 33, 'awdaw', '务农', 0, -1, NULL, '上海', 'adsad', 'dasd', '1', '2024-03-08 14:15:39', '2024-03-17 13:24:21');
INSERT INTO `jobs` VALUES (12, 33, 'awdaw', '务农', 0, 1, NULL, '上海', 'adsad', 'dasdkopk', '1', '2024-03-08 14:26:28', '2024-03-17 13:24:45');
INSERT INTO `jobs` VALUES (14, 30, '软件工程师', 'ABC科技', 0, 1, '1,2,34', '上海', '健康保险、带薪休假', '寻找一名熟练的软件工程师加入我们的团队，并致力于开展前沿项目。', '0', '2024-03-08 15:49:43', '2024-03-16 11:14:48');
INSERT INTO `jobs` VALUES (15, 30, '数据科学家', 'XYZ分析', 0, 0, '12,1', '北京', '401(k)匹配、弹性工作时间', '寻找具有机器学习和统计分析经验的数据科学家。', '2', '2024-03-08 15:49:43', '2024-03-09 17:28:20');
INSERT INTO `jobs` VALUES (16, 30, '市场经理', '全球市场代理', 0, 0, '1', '南京', '健身房会员、公司活动', '我们正在招聘市场经理来监督我们的营销活动和策略。', '1', '2024-03-08 15:49:43', '2024-03-17 13:22:12');
INSERT INTO `jobs` VALUES (17, 30, '产品设计师', '创意设计工作室', 0, -1, '1', '深圳', '远程工作选项、专业发展津贴', '加入我们的团队，成为产品设计师，帮助我们创建创新和用户友好的设计。', '0', '2024-03-08 15:49:43', '2024-03-17 13:32:01');
INSERT INTO `jobs` VALUES (18, 30, '财务分析师', '投资公司', 1, 1, '5,6,35,1', '上海', '股票期权、学费补贴', '我们正在寻找一名熟练的财务分析师，为投资决策提供见解和建议。', '1', '2024-03-08 15:49:43', '2024-03-14 10:27:55');
INSERT INTO `jobs` VALUES (19, 30, '人力资源专员', '人力资源解决方案公司', 2, 0, '0', '北京', '灵活的工作时间表、员工援助计划', '加入我们的人力资源团队，支持员工招聘、入职和留任工作。', '0', '2024-03-08 15:49:43', '2024-03-08 15:52:09');
INSERT INTO `jobs` VALUES (20, 30, '销售代表', '销售力公司', 3, 1, '7,8,9,35', '广州', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-03-14 10:05:36');
INSERT INTO `jobs` VALUES (21, 30, '客户支持专员', '技术支持解决方案公司', 4, 1, '2,35', '深圳', '培训报销、在家工作选项', '我们正在招聘客户支持专员，为客户提供优质服务和协助。', '0', '2024-03-08 15:49:43', '2024-03-14 10:05:46');
INSERT INTO `jobs` VALUES (22, 30, '平面设计师', '创意代理公司', 3, 0, '3', '北京', '创作自由、团队合作', '加入我们的团队，成为平面设计师，为各种项目创建视觉上吸引人的设计。', '0', '2024-03-08 15:49:43', '2024-03-08 15:52:18');
INSERT INTO `jobs` VALUES (23, 30, '项目经理', '项目管理公司', 2, 1, '4,35,34', '上海', '绩效奖金、带薪产假', '寻找经验丰富的项目经理，监督并按时按预算交付成功的项目。', '0', '2024-03-08 15:49:43', '2024-03-16 11:08:44');

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `to_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 178 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (144, 35, 30, '终于调试好了\n', '2024-03-13 08:14:09');
INSERT INTO `messages` VALUES (145, 35, 30, '感天动地\n', '2024-03-13 08:14:25');
INSERT INTO `messages` VALUES (146, 35, 30, '泪目\n、', '2024-03-13 08:14:28');
INSERT INTO `messages` VALUES (147, 30, 35, '！！！\n', '2024-03-13 08:31:07');
INSERT INTO `messages` VALUES (148, 35, 30, 'wh \n', '2024-03-13 08:32:09');
INSERT INTO `messages` VALUES (149, 35, 30, '>>>\n', '2024-03-13 12:33:40');
INSERT INTO `messages` VALUES (150, 35, 30, 'ddd\n', '2024-03-13 12:51:51');
INSERT INTO `messages` VALUES (151, 35, 30, 'qqq\n', '2024-03-13 12:53:36');
INSERT INTO `messages` VALUES (152, 30, 35, '啊啊\n', '2024-03-13 12:53:48');
INSERT INTO `messages` VALUES (153, 30, 35, '怎么回事呢\n', '2024-03-13 12:54:21');
INSERT INTO `messages` VALUES (154, 30, 35, '嗡嗡嗡\n', '2024-03-13 12:54:31');
INSERT INTO `messages` VALUES (155, 35, 30, '奇奇怪怪\n', '2024-03-13 12:54:56');
INSERT INTO `messages` VALUES (156, 35, 30, '嗡嗡嗡\n', '2024-03-13 12:55:02');
INSERT INTO `messages` VALUES (157, 30, 35, '嗡嗡嗡\n', '2024-03-13 12:55:09');
INSERT INTO `messages` VALUES (158, 35, 30, '嘟嘟嘟\n', '2024-03-13 12:55:18');
INSERT INTO `messages` VALUES (159, 30, 0, '嘟嘟嘟\n', '2024-03-14 10:47:16');
INSERT INTO `messages` VALUES (160, 30, 1, '嗡嗡嗡\n', '2024-03-14 11:05:02');
INSERT INTO `messages` VALUES (161, 30, 1, '哎嘿\n', '2024-03-14 11:17:01');
INSERT INTO `messages` VALUES (162, 30, 35, '奇奇怪怪的呢\n', '2024-03-14 11:17:12');
INSERT INTO `messages` VALUES (163, 30, 0, '钱钱钱\n', '2024-03-15 14:19:32');
INSERT INTO `messages` VALUES (164, 30, 35, '嗡嗡嗡\n', '2024-03-16 11:08:08');
INSERT INTO `messages` VALUES (165, 34, 30, 'www\n', '2024-03-16 11:08:48');
INSERT INTO `messages` VALUES (166, 34, 0, '？？？\n', '2024-03-16 11:11:55');
INSERT INTO `messages` VALUES (167, 30, 35, 'aaaa\n', '2024-03-16 11:21:18');
INSERT INTO `messages` VALUES (168, 30, 35, 'aaa\n', '2024-03-16 11:21:27');
INSERT INTO `messages` VALUES (169, 0, 34, '芜湖\n', '2024-03-16 11:49:25');
INSERT INTO `messages` VALUES (170, 35, 0, 'ww\n', '2024-03-16 12:01:21');
INSERT INTO `messages` VALUES (171, 0, 35, '嗡嗡嗡\n', '2024-03-16 12:05:04');
INSERT INTO `messages` VALUES (172, 34, 0, '？？？\n', '2024-03-16 12:05:42');
INSERT INTO `messages` VALUES (173, 35, 0, 'www\n', '2024-03-16 12:08:07');
INSERT INTO `messages` VALUES (174, 35, 30, 'ddd\n', '2024-03-16 12:11:32');
INSERT INTO `messages` VALUES (175, 0, 35, '嗡嗡嗡\n', '2024-03-16 12:15:10');
INSERT INTO `messages` VALUES (176, 0, 30, '???\n', '2024-03-17 12:25:56');
INSERT INTO `messages` VALUES (177, 0, 30, 'dududu \n', '2024-03-17 12:25:59');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `permission` tinyint(1) NOT NULL,
  `apply_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `job_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `chat_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `college` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `salary` int NULL DEFAULT NULL,
  `other` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `username`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (0, '客服', '0x0000', 0, NULL, NULL, ',35,30,33', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2008-03-03 15:02:40', '2024-03-17 13:08:43');
INSERT INTO `users` VALUES (1, 'Timothy Adams', 'TAhsgrHBRp', 0, NULL, NULL, NULL, 'timothy1213@mail.com', '312-894-2062', NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-01 02:04:03', '2013-03-07 12:42:11');
INSERT INTO `users` VALUES (2, 'Yu Yuning', 'SVdjz59sio', 0, NULL, NULL, '0,null', 'yuninyu6@gmail.com', '5050 737219', '某某大学', '某某地址', '刘某某', '南京', NULL, NULL, '2010-01-12 06:21:42', '2024-03-17 12:25:20');
INSERT INTO `users` VALUES (3, 'Okada Misaki', 'GRNqcezoku', 0, NULL, NULL, NULL, 'okmisaki1228@yahoo.com', '10-739-3629', NULL, NULL, NULL, NULL, NULL, NULL, '2021-09-11 10:50:36', '2023-12-11 07:37:32');
INSERT INTO `users` VALUES (4, 'Goto Yuto', 'LGryL99B2u', 0, NULL, NULL, NULL, 'gyu88@icloud.com', '90-7378-9804', NULL, NULL, NULL, NULL, NULL, NULL, '2021-03-01 06:39:21', '2020-01-07 10:36:27');
INSERT INTO `users` VALUES (5, 'Brenda Kelley', 'yzRfTEDd6B', 0, NULL, NULL, NULL, 'kbre904@hotmail.com', '212-475-1880', NULL, NULL, NULL, NULL, NULL, NULL, '2002-05-14 21:56:49', '2020-10-31 14:03:55');
INSERT INTO `users` VALUES (6, 'Okada Mitsuki', 'dYicGVlgrN', 0, NULL, NULL, NULL, 'mitsuki311@outlook.com', '(151) 435 7475', NULL, NULL, NULL, NULL, NULL, NULL, '2003-12-09 17:59:17', '2007-04-02 14:03:42');
INSERT INTO `users` VALUES (7, 'Herbert Nguyen', 'xw0iDgD7b5', 0, NULL, NULL, NULL, 'herbertnguyen131@hotmail.com', '74-177-8517', NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 19:33:47', '2012-07-19 13:19:54');
INSERT INTO `users` VALUES (8, 'Yamazaki Eita', 'cWFoRve9wE', 0, NULL, NULL, NULL, 'yamazakieit131@outlook.com', '718-400-6535', NULL, NULL, NULL, NULL, NULL, NULL, '2021-10-03 20:56:51', '2011-08-10 23:41:21');
INSERT INTO `users` VALUES (10, 'Julie Parker', 'm8wJ4HmpSZ', 0, NULL, NULL, NULL, 'parkerjulie12@outlook.com', '66-267-4328', NULL, NULL, NULL, NULL, NULL, NULL, '2005-05-24 12:14:30', '2014-12-02 04:01:57');
INSERT INTO `users` VALUES (30, 'yueyvlunhui', '08853c9870092e7e446805c075399be2', 1, 'README.md', '', '0,1,35,34', 'asdasd@ada.com', 'asdasd', 'dasdasda', 'asdasd', 'asdasd', 'asdas', NULL, NULL, '2024-02-26 11:49:01', '2024-03-17 12:25:44');
INSERT INTO `users` VALUES (33, 'jdawawlidawj', '08853c9870092e7e446805c075399be2', 1, 'index.js', NULL, '0,null', 'asdasd@ada.com', 'asdasd', 'dasdasda', 'asdasd', 'asdasd', 'asdas', 1, 'asdasdasdas', '2024-03-06 15:29:11', '2024-03-17 13:08:42');
INSERT INTO `users` VALUES (34, 'aijldijald', '08853c9870092e7e446805c075399be2', 0, NULL, '14,23', '0,30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-08 14:24:46', '2024-03-17 13:06:23');
INSERT INTO `users` VALUES (35, 'testdemo', '08853c9870092e7e446805c075399be2', 0, NULL, '23,21,20,18', '0,30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-11 11:59:13', '2024-03-17 13:06:27');
INSERT INTO `users` VALUES (36, 'newtest1', '08853c9870092e7e446805c075399be2', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-13 11:59:11', '2024-03-13 11:59:11');

SET FOREIGN_KEY_CHECKS = 1;
