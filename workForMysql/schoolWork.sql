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

 Date: 10/04/2024 15:50:26
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
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (0, 'yueyvlunhui', '37927bbeddfc2d162b200434e436b599', '2024-03-28 19:23:47');
INSERT INTO `admins` VALUES (1, 'admin', '@Admin123', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES (11, 33, 'awdaw', '务农', 0, -1, NULL, '上海', 'adsad', 'dasd', '1', '2024-03-08 14:15:39', '2024-03-17 13:24:21');
INSERT INTO `jobs` VALUES (12, 33, 'awdaw', '务农', 0, 1, NULL, '上海', 'adsad', 'dasdkopk', '1', '2024-03-08 14:26:28', '2024-03-17 13:24:45');
INSERT INTO `jobs` VALUES (14, 30, '软件工程师', 'ABC科技', 0, 1, '1,2,34,40,43', '上海', '健康保险、带薪休假', '寻找一名熟练的软件工程师加入我们的团队，并致力于开展前沿项目。', '0', '2024-03-08 15:49:43', '2024-04-07 08:14:49');
INSERT INTO `jobs` VALUES (15, 30, '数据科学家', 'XYZ分析', 0, 0, '12,1', '北京', '401(k)匹配、弹性工作时间', '寻找具有机器学习和统计分析经验的数据科学家。', '2', '2024-03-08 15:49:43', '2024-03-09 17:28:20');
INSERT INTO `jobs` VALUES (16, 30, '市场经理', '全球市场代理', 0, 0, '1', '南京', '健身房会员、公司活动', '我们正在招聘市场经理来监督我们的营销活动和策略。', '1', '2024-03-08 15:49:43', '2024-03-17 13:22:12');
INSERT INTO `jobs` VALUES (17, 30, '产品设计师', '创意设计工作室', 0, -1, '1', '深圳', '远程工作选项、专业发展津贴', '加入我们的团队，成为产品设计师，帮助我们创建创新和用户友好的设计。', '0', '2024-03-08 15:49:43', '2024-03-17 13:32:01');
INSERT INTO `jobs` VALUES (18, 30, '财务分析师', '投资公司', 1, 1, '5,6,35,1', '上海', '股票期权、学费补贴', '我们正在寻找一名熟练的财务分析师，为投资决策提供见解和建议。', '1', '2024-03-08 15:49:43', '2024-03-14 10:27:55');
INSERT INTO `jobs` VALUES (19, 30, '人力资源专员', '人力资源解决方案公司', 2, 0, '0', '北京', '灵活的工作时间表、员工援助计划', '加入我们的人力资源团队，支持员工招聘、入职和留任工作。', '0', '2024-03-08 15:49:43', '2024-03-08 15:52:09');
INSERT INTO `jobs` VALUES (20, 30, '销售代表', '销售力公司', 3, 1, '7,8,9,35,43', '广州', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-04-07 08:19:26');
INSERT INTO `jobs` VALUES (21, 30, '客户支持专员', '技术支持解决方案公司', 4, 1, '2,35,40', '深圳', '培训报销、在家工作选项', '我们正在招聘客户支持专员，为客户提供优质服务和协助。', '0', '2024-03-08 15:49:43', '2024-04-02 09:25:33');
INSERT INTO `jobs` VALUES (22, 30, '平面设计师', '创意代理公司', 3, 0, '3', '北京', '创作自由、团队合作', '加入我们的团队，成为平面设计师，为各种项目创建视觉上吸引人的设计。', '0', '2024-03-08 15:49:43', '2024-03-08 15:52:18');
INSERT INTO `jobs` VALUES (23, 30, '项目经理', '项目管理公司', 2, 1, '4,35,34', '上海', '绩效奖金、带薪产假', '寻找经验丰富的项目经理，监督并按时按预算交付成功的项目。', '0', '2024-03-08 15:49:43', '2024-03-16 11:08:44');
INSERT INTO `jobs` VALUES (24, 30, '软件工程师2', 'ABC科技', 0, 1, '1,34', '上海', '健康保险、带薪休假', '寻找一名熟练的软件工程师加入我们的团队，并致力于开展前沿项目。', '0', '2024-03-08 15:49:43', '2024-03-30 13:07:30');
INSERT INTO `jobs` VALUES (26, 30, '财务分析师2', '投资公司', 1, 1, '5,6,35,1,41', '上海', '股票期权、学费补贴', '我们正在寻找一名熟练的财务分析师，为投资决策提供见解和建议。', '1', '2024-03-08 15:49:43', '2024-04-07 08:40:12');
INSERT INTO `jobs` VALUES (27, 30, '销售代表2', '销售力公司', 3, 1, '7,8,9,35', '广州', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-03-14 10:05:36');
INSERT INTO `jobs` VALUES (29, 30, 'awdaw', '·12·12·12·12·12', 2, 0, NULL, '上海', 'awdawd', 'adwawdaw', '2', '2024-04-10 07:39:27', '2024-04-10 07:39:27');

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `to_id` int NOT NULL,
  `read` int NOT NULL DEFAULT 0,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (144, 35, 30, 1, '终于调试好了\n', '2024-03-13 08:14:09');
INSERT INTO `messages` VALUES (145, 35, 30, 1, '感天动地\n', '2024-03-13 08:14:25');
INSERT INTO `messages` VALUES (146, 35, 30, 1, '泪目\n、', '2024-03-13 08:14:28');
INSERT INTO `messages` VALUES (147, 30, 35, 0, '！！！\n', '2024-03-13 08:31:07');
INSERT INTO `messages` VALUES (148, 35, 30, 1, 'wh \n', '2024-03-13 08:32:09');
INSERT INTO `messages` VALUES (149, 35, 30, 1, '>>>\n', '2024-03-13 12:33:40');
INSERT INTO `messages` VALUES (150, 35, 30, 1, 'ddd\n', '2024-03-13 12:51:51');
INSERT INTO `messages` VALUES (151, 35, 30, 1, 'qqq\n', '2024-03-13 12:53:36');
INSERT INTO `messages` VALUES (152, 30, 35, 0, '啊啊\n', '2024-03-13 12:53:48');
INSERT INTO `messages` VALUES (153, 30, 35, 0, '怎么回事呢\n', '2024-03-13 12:54:21');
INSERT INTO `messages` VALUES (154, 30, 35, 0, '嗡嗡嗡\n', '2024-03-13 12:54:31');
INSERT INTO `messages` VALUES (155, 35, 30, 1, '奇奇怪怪\n', '2024-03-13 12:54:56');
INSERT INTO `messages` VALUES (156, 35, 30, 1, '嗡嗡嗡\n', '2024-03-13 12:55:02');
INSERT INTO `messages` VALUES (157, 30, 35, 0, '嗡嗡嗡\n', '2024-03-13 12:55:09');
INSERT INTO `messages` VALUES (158, 35, 30, 1, '嘟嘟嘟\n', '2024-03-13 12:55:18');
INSERT INTO `messages` VALUES (159, 30, 0, 1, '嘟嘟嘟\n', '2024-03-14 10:47:16');
INSERT INTO `messages` VALUES (160, 30, 1, 0, '嗡嗡嗡\n', '2024-03-14 11:05:02');
INSERT INTO `messages` VALUES (161, 30, 1, 0, '哎嘿\n', '2024-03-14 11:17:01');
INSERT INTO `messages` VALUES (162, 30, 35, 0, '奇奇怪怪的呢\n', '2024-03-14 11:17:12');
INSERT INTO `messages` VALUES (163, 30, 0, 1, '钱钱钱\n', '2024-03-15 14:19:32');
INSERT INTO `messages` VALUES (164, 30, 35, 0, '嗡嗡嗡\n', '2024-03-16 11:08:08');
INSERT INTO `messages` VALUES (165, 34, 30, 1, 'www\n', '2024-03-16 11:08:48');
INSERT INTO `messages` VALUES (166, 34, 0, 0, '？？？\n', '2024-03-16 11:11:55');
INSERT INTO `messages` VALUES (167, 30, 35, 0, 'aaaa\n', '2024-03-16 11:21:18');
INSERT INTO `messages` VALUES (168, 30, 35, 0, 'aaa\n', '2024-03-16 11:21:27');
INSERT INTO `messages` VALUES (169, 0, 34, 0, '芜湖\n', '2024-03-16 11:49:25');
INSERT INTO `messages` VALUES (170, 35, 0, 1, 'ww\n', '2024-03-16 12:01:21');
INSERT INTO `messages` VALUES (171, 0, 35, 0, '嗡嗡嗡\n', '2024-03-16 12:05:04');
INSERT INTO `messages` VALUES (172, 34, 0, 0, '？？？\n', '2024-03-16 12:05:42');
INSERT INTO `messages` VALUES (173, 35, 0, 1, 'www\n', '2024-03-16 12:08:07');
INSERT INTO `messages` VALUES (174, 35, 30, 1, 'ddd\n', '2024-03-16 12:11:32');
INSERT INTO `messages` VALUES (175, 0, 35, 0, '嗡嗡嗡\n', '2024-03-16 12:15:10');
INSERT INTO `messages` VALUES (176, 0, 30, 1, '???\n', '2024-03-17 12:25:56');
INSERT INTO `messages` VALUES (177, 0, 30, 1, 'dududu \n', '2024-03-17 12:25:59');
INSERT INTO `messages` VALUES (178, 30, 1, 0, '***\n', '2024-03-19 11:46:46');
INSERT INTO `messages` VALUES (179, 30, 0, 1, '**\n', '2024-03-19 11:47:06');
INSERT INTO `messages` VALUES (180, 35, 0, 1, '嗡嗡嗡\n', '2024-03-23 12:35:59');
INSERT INTO `messages` VALUES (181, 35, 0, 1, '***\n', '2024-03-23 12:36:33');
INSERT INTO `messages` VALUES (182, 35, 0, 1, '****\n', '2024-03-23 12:37:23');
INSERT INTO `messages` VALUES (183, 35, 30, 1, '**\n', '2024-03-23 12:37:28');
INSERT INTO `messages` VALUES (184, 30, 0, 1, 'lokkk\n', '2024-03-26 13:35:54');
INSERT INTO `messages` VALUES (185, 0, 30, 1, '??', '2024-03-27 05:33:37');
INSERT INTO `messages` VALUES (186, 0, 30, 1, '???\n', '2024-03-27 05:33:46');
INSERT INTO `messages` VALUES (187, 30, 0, 1, 'try\n', '2024-03-27 05:33:56');
INSERT INTO `messages` VALUES (188, 0, 35, 0, '???\n', '2024-03-27 06:16:13');
INSERT INTO `messages` VALUES (189, 0, 4, 0, '>>>\\\n', '2024-03-28 11:08:27');
INSERT INTO `messages` VALUES (190, 0, 35, 0, '在这聊天\n\n', '2024-03-28 11:34:47');
INSERT INTO `messages` VALUES (191, 0, 35, 0, '***\n', '2024-03-28 12:26:47');
INSERT INTO `messages` VALUES (192, 30, 0, 1, '嘟嘟嘟\n', '2024-03-28 13:53:57');
INSERT INTO `messages` VALUES (193, 0, 30, 1, '哇哇哇哇', '2024-03-28 13:54:38');
INSERT INTO `messages` VALUES (194, 0, 30, 1, '测试消息中\n', '2024-03-28 14:01:04');
INSERT INTO `messages` VALUES (195, 30, 0, 1, '???\n', '2024-03-29 12:20:36');
INSERT INTO `messages` VALUES (196, 30, 0, 1, '？？\n', '2024-03-29 13:15:40');
INSERT INTO `messages` VALUES (197, 0, 30, 1, 'ddd\n', '2024-03-29 14:47:41');
INSERT INTO `messages` VALUES (198, 0, 30, 1, '测试下未读消息\n', '2024-03-29 14:50:27');
INSERT INTO `messages` VALUES (199, 40, 0, 1, '？？？\n', '2024-04-02 08:07:23');
INSERT INTO `messages` VALUES (200, 40, 30, 1, '嘟嘟嘟\n', '2024-04-02 09:25:38');
INSERT INTO `messages` VALUES (201, 0, 40, 1, 'ce \n', '2024-04-02 12:46:44');
INSERT INTO `messages` VALUES (202, 0, 35, 0, '22\n', '2024-04-03 03:48:05');
INSERT INTO `messages` VALUES (203, 0, 35, 0, '测试\n', '2024-04-03 03:57:45');
INSERT INTO `messages` VALUES (204, 0, 4, 0, 'ww\n', '2024-04-03 04:00:51');
INSERT INTO `messages` VALUES (205, 30, 0, 1, '测试一下\n', '2024-04-03 04:06:23');
INSERT INTO `messages` VALUES (206, 40, 0, 1, '22\n', '2024-04-03 05:08:33');
INSERT INTO `messages` VALUES (207, 0, 35, 0, '22\n', '2024-04-03 05:09:54');
INSERT INTO `messages` VALUES (208, 0, 35, 0, '22\n', '2024-04-03 05:24:52');
INSERT INTO `messages` VALUES (209, 0, 35, 0, '222\n', '2024-04-03 06:14:33');
INSERT INTO `messages` VALUES (210, 0, 4, 0, '；\n', '2024-04-03 06:18:41');
INSERT INTO `messages` VALUES (211, 0, 4, 0, 'sss\n', '2024-04-03 06:19:43');
INSERT INTO `messages` VALUES (212, 0, 4, 0, '终于\n', '2024-04-03 06:20:00');
INSERT INTO `messages` VALUES (213, 0, 35, 0, '222\n', '2024-04-03 06:23:08');
INSERT INTO `messages` VALUES (214, 0, 35, 0, '测试成功\n', '2024-04-03 06:23:15');
INSERT INTO `messages` VALUES (215, 0, 35, 0, '反向代理\n', '2024-04-03 06:23:23');
INSERT INTO `messages` VALUES (216, 43, 30, 1, 'dudud\n', '2024-04-07 08:16:37');
INSERT INTO `messages` VALUES (217, 41, 30, 1, '嘟嘟嘟\n', '2024-04-07 08:50:33');
INSERT INTO `messages` VALUES (218, 0, 30, 1, '小测试\n', '2024-04-07 09:54:14');
INSERT INTO `messages` VALUES (219, 0, 35, 0, '22\n', '2024-04-09 09:33:01');
INSERT INTO `messages` VALUES (220, 30, 35, 0, '玩玩\n', '2024-04-10 07:40:24');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `permission` int NOT NULL,
  `apply_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `resume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`username`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (34, 'aijldijald', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '14,23', '0,30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-08 14:24:46', '2024-04-09 06:38:17');
INSERT INTO `users` VALUES (5, 'Brenda Kelley', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'kbre904@hotmail.com', '212-475-1880', NULL, NULL, NULL, NULL, NULL, NULL, '2002-05-14 21:56:49', '2024-04-09 06:38:18');
INSERT INTO `users` VALUES (4, 'Goto Yuto', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'gyu88@icloud.com', '90-7378-9804', NULL, NULL, NULL, NULL, NULL, NULL, '2021-03-01 06:39:21', '2024-04-09 06:38:18');
INSERT INTO `users` VALUES (7, 'Herbert Nguyen', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'herbertnguyen131@hotmail.com', '74-177-8517', NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 19:33:47', '2024-04-09 06:38:19');
INSERT INTO `users` VALUES (33, 'jdawawlidawj', 'nx0fN7LKRMnYvyodk/3kvg==', 1, 'index.js', NULL, NULL, '0', 'asdasd@ada.com', 'asdasd', 'dasdasda', 'asdasd', 'asdasd', 'asdas', 1, 'asdasdasdas', '2024-03-06 15:29:11', '2024-04-09 06:38:19');
INSERT INTO `users` VALUES (10, 'Julie Parker', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'parkerjulie12@outlook.com', '66-267-4328', NULL, NULL, NULL, NULL, NULL, NULL, '2005-05-24 12:14:30', '2024-04-09 06:38:19');
INSERT INTO `users` VALUES (36, 'newtest1', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-13 11:59:11', '2024-04-09 06:38:20');
INSERT INTO `users` VALUES (3, 'Okada Misaki', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'okmisaki1228@yahoo.com', '10-739-3629', NULL, NULL, NULL, NULL, NULL, NULL, '2021-09-11 10:50:36', '2024-04-09 06:38:20');
INSERT INTO `users` VALUES (6, 'Okada Mitsuki', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'mitsuki311@outlook.com', '(151) 435 7475', NULL, NULL, NULL, NULL, NULL, NULL, '2003-12-09 17:59:17', '2024-04-09 06:38:20');
INSERT INTO `users` VALUES (44, 'passwordTest', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-09 06:36:14', '2024-04-09 06:36:14');
INSERT INTO `users` VALUES (35, 'testdemo', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '23,21,20,18', '0,30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-11 11:59:13', '2024-04-09 06:38:21');
INSERT INTO `users` VALUES (1, 'Timothy Adams', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'timothy1213@mail.com', '312-894-2062', NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-01 02:04:03', '2024-04-09 06:38:21');
INSERT INTO `users` VALUES (8, 'Yamazaki Eita', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, 'yamazakieit131@outlook.com', '718-400-6535', NULL, NULL, NULL, NULL, NULL, NULL, '2021-10-03 20:56:51', '2024-04-09 06:38:22');
INSERT INTO `users` VALUES (2, 'Yu Yuning', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'yuninyu6@gmail.com', '5050 737219', '某某大学', '某某地址', '刘某某', '南京', NULL, NULL, '2010-01-12 06:21:42', '2024-04-09 06:38:22');
INSERT INTO `users` VALUES (43, 'yueyv112121', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '20,14,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:50:32', '2024-04-09 06:38:22');
INSERT INTO `users` VALUES (30, 'yueyvlunhui', 'nx0fN7LKRMnYvyodk/3kvg==', 1, 'README.md', NULL, '', '35,1,0,40,43,41', 'asdasd@ada.com', 'asdasd', 'dasdasda', 'asdasd', 'asdasd', 'asdas', NULL, NULL, '2024-02-26 11:49:01', '2024-04-09 06:38:23');
INSERT INTO `users` VALUES (40, 'yueyvtest', 'nx0fN7LKRMnYvyodk/3kvg==', 2, '模块.md', '前端开发_刘辉_南京信息工程大学.pdf', '14,21,null', '30,0', 'yueyvlunhui@outlook.com', '18061203051', NULL, '当涂县', '刘辉', '南京', 2, '测试测试', '2024-04-02 07:31:32', '2024-04-09 06:38:23');
INSERT INTO `users` VALUES (41, 'yueyvtest2', 'nx0fN7LKRMnYvyodk/3kvg==', 2, '前端开发_刘辉_南京信息工程大学.pdf', '前端开发_刘辉_南京信息工程大学.pdf', '26,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:43:19', '2024-04-09 06:38:23');
INSERT INTO `users` VALUES (42, 'yueyvtest5', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:45:37', '2024-04-09 06:38:24');
INSERT INTO `users` VALUES (0, '客服', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '35,30,4,1,3,5,7,33,40', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2008-03-03 15:02:40', '2024-04-09 06:38:24');

SET FOREIGN_KEY_CHECKS = 1;
