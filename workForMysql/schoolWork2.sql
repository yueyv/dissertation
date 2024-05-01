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

 Date: 30/04/2024 17:45:42
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
  `created_at` datetime NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (0, 'yueyvlunhui', '37927bbeddfc2d162b200434e436b599', '2024-03-28 19:23:47', NULL, NULL);
INSERT INTO `admins` VALUES (1, 'admin', '@Admin123', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company`  (
  `company_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES (1, '小公司', 30, '<p style=\"text-align: center;\">公司介绍</p><p style=\"text-align: center;\"><img src=\"data:image/jpeg;base64,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\" alt=\"th.jpg\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\"> &nbsp; &nbsp;欢迎来到我们的公司！我们是一家致力于提供优质产品和服务的公司。</p><p style=\"text-align: center;\"> &nbsp; &nbsp;我们的使命是改善人们的生活，并为客户创造更大的价值。</p><p style=\"text-align: center;\"> &nbsp; &nbsp;我们的优势</p><p style=\"text-align: center;\">• &nbsp; &nbsp; &nbsp; &nbsp;专业团队：拥有一支技术娴熟、经验丰富的专业团队。</p><p style=\"text-align: center;\">• &nbsp; &nbsp; &nbsp; &nbsp;创新产品：我们不断创新，为客户提供最新的产品和解决方案。</p><p style=\"text-align: center;\">• &nbsp; &nbsp; &nbsp; &nbsp;客户至上：客户的满意度是我们工作的最高追求。</p><p style=\"text-align: center;\"> &nbsp; &nbsp;我们的产品</p><p style=\"text-align: center;\"> &nbsp; &nbsp; &nbsp; &nbsp;产品一</p><p style=\"text-align: center;\"> &nbsp; &nbsp; &nbsp; &nbsp;产品二</p><p style=\"text-align: center;\"> &nbsp; &nbsp; &nbsp; &nbsp;产品三</p><p style=\"text-align: center;\"> &nbsp; 联系我们</p><p style=\"text-align: center;\"> &nbsp; 如果您有任何疑问或需要进一步了解，请随时联系我们。</p><p style=\"text-align: center;\"> &nbsp;Email: info@example.com</p><p style=\"text-align: center;\"> &nbsp; &nbsp;电话: 123-456-7890</p>', '2024-04-19 08:52:19');

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
  `company_id` int NOT NULL DEFAULT 0,
  `applicant_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `walfare` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `job_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES (11, 33, 'awdaw', '务农', 0, -1, 1, NULL, '上海', 'adsad', 'dasd', '1', '2024-03-08 14:15:39', '2024-04-18 09:48:39');
INSERT INTO `jobs` VALUES (12, 33, 'awdaw', '务农', 0, 1, 1, NULL, '上海', 'adsad', 'dasdkopk', '1', '2024-03-08 14:26:28', '2024-04-18 09:48:39');
INSERT INTO `jobs` VALUES (14, 30, '软件工程师', 'ABC科技', 0, 1, 1, '1,2,34,40,43', '上海', '健康保险、带薪休假', '寻找一名熟练的软件工程师加入我们的团队，并致力于开展前沿项目。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:39');
INSERT INTO `jobs` VALUES (15, 30, '数据科学家', 'XYZ分析', 0, 0, 1, '12,1', '南京', '401(k)匹配、弹性工作时间', '寻找具有机器学习和统计分析经验的数据科学家。', '2', '2024-03-08 15:49:43', '2024-04-18 09:48:40');
INSERT INTO `jobs` VALUES (16, 30, '市场经理', '全球市场代理', 0, 0, 1, '1', '南京', '健身房会员、公司活动', '我们正在招聘市场经理来监督我们的营销活动和策略。', '1', '2024-03-08 15:49:43', '2024-04-18 09:48:40');
INSERT INTO `jobs` VALUES (17, 30, '产品设计师', '创意设计工作室', 0, -1, 1, '1', '南京', '远程工作选项、专业发展津贴', '加入我们的团队，成为产品设计师，帮助我们创建创新和用户友好的设计。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:41');
INSERT INTO `jobs` VALUES (18, 30, '财务分析师', '投资公司', 1, 1, 1, '5,6,35,1,45', '上海', '股票期权、学费补贴', '我们正在寻找一名熟练的财务分析师，为投资决策提供见解和建议。', '1', '2024-03-08 15:49:43', '2024-04-18 09:48:41');
INSERT INTO `jobs` VALUES (19, 30, '人力资源专员', '人力资源解决方案公司', 2, 0, 1, '0', '北京', '灵活的工作时间表、员工援助计划', '加入我们的人力资源团队，支持员工招聘、入职和留任工作。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:41');
INSERT INTO `jobs` VALUES (20, 30, '销售代表', '销售力公司', 3, 1, 1, '7,8,9,35,43', '南京', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-04-18 09:48:42');
INSERT INTO `jobs` VALUES (21, 30, '客户支持专员', '技术支持解决方案公司', 4, 1, 1, '2,35,40', '北京', '培训报销、在家工作选项', '我们正在招聘客户支持专员，为客户提供优质服务和协助。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:42');
INSERT INTO `jobs` VALUES (22, 30, '平面设计师', '创意代理公司', 3, 0, 1, '3', '南京', '创作自由、团队合作', '加入我们的团队，成为平面设计师，为各种项目创建视觉上吸引人的设计。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:42');
INSERT INTO `jobs` VALUES (23, 30, '项目经理', '项目管理公司', 2, 1, 1, '4,35,34', '上海', '绩效奖金、带薪产假', '寻找经验丰富的项目经理，监督并按时按预算交付成功的项目。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:43');
INSERT INTO `jobs` VALUES (24, 30, '软件工程师2', 'ABC科技', 0, 1, 1, '1,34', '上海', '健康保险、带薪休假', '寻找一名熟练的软件工程师加入我们的团队，并致力于开展前沿项目。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:43');
INSERT INTO `jobs` VALUES (26, 30, '财务分析师2', '投资公司', 1, 1, 1, '5,6,35,1,41', '上海', '股票期权、学费补贴', '我们正在寻找一名熟练的财务分析师，为投资决策提供见解和建议。', '1', '2024-03-08 15:49:43', '2024-04-18 09:48:43');
INSERT INTO `jobs` VALUES (27, 30, '销售代表2', '销售力公司', 3, 1, 1, '7,8,9,35', '北京', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-04-18 09:48:44');
INSERT INTO `jobs` VALUES (29, 30, 'awdaw', '·12·12·12·12·12', 2, 0, 1, NULL, '上海', 'awdawd', 'adwawdaw', '2', '2024-04-10 07:39:27', '2024-04-18 09:48:44');
INSERT INTO `jobs` VALUES (30, 30, '人力资源专员', '人力资源解决方案公司', 2, 1, 1, '0', '北京', '灵活的工作时间表、员工援助计划', '加入我们的人力资源团队，支持员工招聘、入职和留任工作。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:45');
INSERT INTO `jobs` VALUES (31, 30, '销售代表', '销售力公司', 3, 1, 1, '7,8,9,35,43', '南京', '销售佣金、公司车津贴', '寻找有动力的个人加入我们的销售团队，推动收入增长。', '2', '2024-03-08 15:49:43', '2024-04-18 09:48:45');
INSERT INTO `jobs` VALUES (32, 30, '客户支持专员222', '技术支持解决方案公司', 4, 1, 1, '2,35,40', '南京', '培训报销、在家工作选项', '我们正在招聘客户支持专员，为客户提供优质服务和协助。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:45');
INSERT INTO `jobs` VALUES (33, 30, '平面设计师2', '创意代理公司', 3, 1, 1, '3,45,35,40,46,48', '上海', '创作自由、团队合作', '加入我们的团队，成为平面设计师，为各种项目创建视觉上吸引人的设计。', '0', '2024-03-08 15:49:43', '2024-04-27 08:17:20');
INSERT INTO `jobs` VALUES (34, 30, '项目经理3', '项目管理公司', 2, 1, 1, '4,35,34', '南京', '绩效奖金、带薪产假', '寻找经验丰富的项目经理，监督并按时按预算交付成功的项目。', '0', '2024-03-08 15:49:43', '2024-04-18 09:48:46');

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`  (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `lat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`location_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of location
-- ----------------------------
INSERT INTO `location` VALUES (1, 30, '32.208362559399', '118.72043168655', NULL);
INSERT INTO `location` VALUES (2, 30, '32.208362559399', '118.72043168655', NULL);
INSERT INTO `location` VALUES (3, 30, '32.207239', '118.714368', NULL);
INSERT INTO `location` VALUES (4, 30, '32.208362559399', '118.72043168655', NULL);
INSERT INTO `location` VALUES (5, 30, '32.208362559399', '118.72043168655', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 265 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (144, 35, 30, 1, '终于调试好了\n', '2024-03-13 08:14:09');
INSERT INTO `messages` VALUES (145, 35, 30, 1, '感天动地\n', '2024-03-13 08:14:25');
INSERT INTO `messages` VALUES (146, 35, 30, 1, '泪目\n、', '2024-03-13 08:14:28');
INSERT INTO `messages` VALUES (147, 30, 35, 1, '！！！\n', '2024-03-13 08:31:07');
INSERT INTO `messages` VALUES (148, 35, 30, 1, 'wh \n', '2024-03-13 08:32:09');
INSERT INTO `messages` VALUES (149, 35, 30, 1, '>>>\n', '2024-03-13 12:33:40');
INSERT INTO `messages` VALUES (150, 35, 30, 1, 'ddd\n', '2024-03-13 12:51:51');
INSERT INTO `messages` VALUES (151, 35, 30, 1, 'qqq\n', '2024-03-13 12:53:36');
INSERT INTO `messages` VALUES (152, 30, 35, 1, '啊啊\n', '2024-03-13 12:53:48');
INSERT INTO `messages` VALUES (153, 30, 35, 1, '怎么回事呢\n', '2024-03-13 12:54:21');
INSERT INTO `messages` VALUES (154, 30, 35, 1, '嗡嗡嗡\n', '2024-03-13 12:54:31');
INSERT INTO `messages` VALUES (155, 35, 30, 1, '奇奇怪怪\n', '2024-03-13 12:54:56');
INSERT INTO `messages` VALUES (156, 35, 30, 1, '嗡嗡嗡\n', '2024-03-13 12:55:02');
INSERT INTO `messages` VALUES (157, 30, 35, 1, '嗡嗡嗡\n', '2024-03-13 12:55:09');
INSERT INTO `messages` VALUES (158, 35, 30, 1, '嘟嘟嘟\n', '2024-03-13 12:55:18');
INSERT INTO `messages` VALUES (159, 30, 0, 1, '嘟嘟嘟\n', '2024-03-14 10:47:16');
INSERT INTO `messages` VALUES (160, 30, 1, 0, '嗡嗡嗡\n', '2024-03-14 11:05:02');
INSERT INTO `messages` VALUES (161, 30, 1, 0, '哎嘿\n', '2024-03-14 11:17:01');
INSERT INTO `messages` VALUES (162, 30, 35, 1, '奇奇怪怪的呢\n', '2024-03-14 11:17:12');
INSERT INTO `messages` VALUES (163, 30, 0, 1, '钱钱钱\n', '2024-03-15 14:19:32');
INSERT INTO `messages` VALUES (164, 30, 35, 1, '嗡嗡嗡\n', '2024-03-16 11:08:08');
INSERT INTO `messages` VALUES (165, 34, 30, 1, 'www\n', '2024-03-16 11:08:48');
INSERT INTO `messages` VALUES (166, 34, 0, 0, '？？？\n', '2024-03-16 11:11:55');
INSERT INTO `messages` VALUES (167, 30, 35, 1, 'aaaa\n', '2024-03-16 11:21:18');
INSERT INTO `messages` VALUES (168, 30, 35, 1, 'aaa\n', '2024-03-16 11:21:27');
INSERT INTO `messages` VALUES (169, 0, 34, 0, '芜湖\n', '2024-03-16 11:49:25');
INSERT INTO `messages` VALUES (170, 35, 0, 1, 'ww\n', '2024-03-16 12:01:21');
INSERT INTO `messages` VALUES (171, 0, 35, 1, '嗡嗡嗡\n', '2024-03-16 12:05:04');
INSERT INTO `messages` VALUES (172, 34, 0, 0, '？？？\n', '2024-03-16 12:05:42');
INSERT INTO `messages` VALUES (173, 35, 0, 1, 'www\n', '2024-03-16 12:08:07');
INSERT INTO `messages` VALUES (174, 35, 30, 1, 'ddd\n', '2024-03-16 12:11:32');
INSERT INTO `messages` VALUES (175, 0, 35, 1, '嗡嗡嗡\n', '2024-03-16 12:15:10');
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
INSERT INTO `messages` VALUES (188, 0, 35, 1, '???\n', '2024-03-27 06:16:13');
INSERT INTO `messages` VALUES (189, 0, 4, 0, '>>>\\\n', '2024-03-28 11:08:27');
INSERT INTO `messages` VALUES (190, 0, 35, 1, '在这聊天\n\n', '2024-03-28 11:34:47');
INSERT INTO `messages` VALUES (191, 0, 35, 1, '***\n', '2024-03-28 12:26:47');
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
INSERT INTO `messages` VALUES (202, 0, 35, 1, '22\n', '2024-04-03 03:48:05');
INSERT INTO `messages` VALUES (203, 0, 35, 1, '测试\n', '2024-04-03 03:57:45');
INSERT INTO `messages` VALUES (204, 0, 4, 0, 'ww\n', '2024-04-03 04:00:51');
INSERT INTO `messages` VALUES (205, 30, 0, 1, '测试一下\n', '2024-04-03 04:06:23');
INSERT INTO `messages` VALUES (206, 40, 0, 1, '22\n', '2024-04-03 05:08:33');
INSERT INTO `messages` VALUES (207, 0, 35, 1, '22\n', '2024-04-03 05:09:54');
INSERT INTO `messages` VALUES (208, 0, 35, 1, '22\n', '2024-04-03 05:24:52');
INSERT INTO `messages` VALUES (209, 0, 35, 1, '222\n', '2024-04-03 06:14:33');
INSERT INTO `messages` VALUES (210, 0, 4, 0, '；\n', '2024-04-03 06:18:41');
INSERT INTO `messages` VALUES (211, 0, 4, 0, 'sss\n', '2024-04-03 06:19:43');
INSERT INTO `messages` VALUES (212, 0, 4, 0, '终于\n', '2024-04-03 06:20:00');
INSERT INTO `messages` VALUES (213, 0, 35, 1, '222\n', '2024-04-03 06:23:08');
INSERT INTO `messages` VALUES (214, 0, 35, 1, '测试成功\n', '2024-04-03 06:23:15');
INSERT INTO `messages` VALUES (215, 0, 35, 1, '反向代理\n', '2024-04-03 06:23:23');
INSERT INTO `messages` VALUES (216, 43, 30, 1, 'dudud\n', '2024-04-07 08:16:37');
INSERT INTO `messages` VALUES (217, 41, 30, 1, '嘟嘟嘟\n', '2024-04-07 08:50:33');
INSERT INTO `messages` VALUES (218, 0, 30, 1, '小测试\n', '2024-04-07 09:54:14');
INSERT INTO `messages` VALUES (219, 0, 35, 1, '22\n', '2024-04-09 09:33:01');
INSERT INTO `messages` VALUES (220, 30, 35, 1, '玩玩\n', '2024-04-10 07:40:24');
INSERT INTO `messages` VALUES (221, 0, 35, 1, 'qqq\n', '2024-04-10 08:44:28');
INSERT INTO `messages` VALUES (222, 30, 35, 1, '2\n', '2024-04-12 07:10:51');
INSERT INTO `messages` VALUES (223, 40, 0, 1, 'll\n', '2024-04-13 04:30:44');
INSERT INTO `messages` VALUES (224, 30, 1, 0, '111\n', '2024-04-13 05:00:00');
INSERT INTO `messages` VALUES (225, 35, 0, 1, '2\n', '2024-04-13 05:35:21');
INSERT INTO `messages` VALUES (226, 45, 30, 1, '22\n', '2024-04-16 07:22:21');
INSERT INTO `messages` VALUES (227, 30, 35, 1, '222\n', '2024-04-19 11:59:14');
INSERT INTO `messages` VALUES (228, 30, 35, 1, '111\n', '2024-04-19 11:59:21');
INSERT INTO `messages` VALUES (229, 30, 0, 1, 'sss\n', '2024-04-19 12:15:27');
INSERT INTO `messages` VALUES (230, 30, 35, 1, '22\n', '2024-04-19 12:17:49');
INSERT INTO `messages` VALUES (231, 30, 35, 1, 'ww\n', '2024-04-19 12:24:39');
INSERT INTO `messages` VALUES (232, 30, 35, 1, 'ww\n', '2024-04-19 12:28:28');
INSERT INTO `messages` VALUES (233, 30, 35, 1, 'www\n', '2024-04-19 12:34:55');
INSERT INTO `messages` VALUES (234, 35, 0, 1, '‘’\n', '2024-04-19 12:38:50');
INSERT INTO `messages` VALUES (235, 46, 30, 1, '您好，我想要申请贵公司的 平面设计师2\n', '2024-04-19 14:09:14');
INSERT INTO `messages` VALUES (236, 30, 35, 1, '你好\n', '2024-04-20 15:36:36');
INSERT INTO `messages` VALUES (237, 30, 35, 1, '222\n', '2024-04-21 04:24:14');
INSERT INTO `messages` VALUES (238, 35, 30, 1, 'www\n', '2024-04-21 04:25:10');
INSERT INTO `messages` VALUES (239, 30, 35, 1, '222\n', '2024-04-21 04:45:48');
INSERT INTO `messages` VALUES (240, 30, 35, 1, '<p>2333</p>\n', '2024-04-22 05:46:47');
INSERT INTO `messages` VALUES (241, 30, 35, 1, ' <a @click=\'searchCompany(30)\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-22 06:05:41');
INSERT INTO `messages` VALUES (242, 30, 35, 1, ' <a href=\'/company/(undefined)\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-22 06:11:36');
INSERT INTO `messages` VALUES (243, 30, 35, 1, ' <a href=\'/company/(1)\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-22 06:13:33');
INSERT INTO `messages` VALUES (244, 30, 35, 1, ' <a href=\'/company/(undefined)\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-22 06:14:06');
INSERT INTO `messages` VALUES (245, 30, 35, 1, ' <a href=\'/company/1\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-22 06:15:46');
INSERT INTO `messages` VALUES (246, 30, 35, 1, ' <a href=\'/videoChatPage\' style=\'color: green;\'>点此进入面试页面</a>\n', '2024-04-22 06:22:48');
INSERT INTO `messages` VALUES (247, 30, 35, 1, ' <a href=\'/companyLocation/30\' style=\'color: blue;\'>点此进入公司定位</a>\n', '2024-04-22 06:29:31');
INSERT INTO `messages` VALUES (248, 35, 30, 1, '嘟嘟嘟\n', '2024-04-22 06:34:03');
INSERT INTO `messages` VALUES (249, 35, 30, 1, '<a href=\'/api/resume?filename=35_th.jpg \' download=\'th.jpg\'>点此下载</a>\n', '2024-04-22 06:40:14');
INSERT INTO `messages` VALUES (250, 35, 30, 1, '<p>您好，这是我的个人简历，</p><a href=\'/api/resume?filename=35_th.jpg \' download=\'th.jpg\'>点此下载</a>\n', '2024-04-22 06:41:03');
INSERT INTO `messages` VALUES (251, 35, 30, 1, '<p>您好，这是我的个人资料</p> <a href=\'/personalPage/35\' style=\'color: blue;\'>点此查看</a>\n', '2024-04-22 06:43:03');
INSERT INTO `messages` VALUES (252, 35, 30, 1, '<p>您好，这是我的个人资料</p> <a href=\'/applicantPage/35\' style=\'color: blue;\'>点此查看</a>\n', '2024-04-22 06:43:53');
INSERT INTO `messages` VALUES (253, 30, 35, 1, 'https://843mznm4-5200.asse.devtunnels.ms/\n', '2024-04-22 07:23:52');
INSERT INTO `messages` VALUES (254, 30, 35, 1, '<p>您好，这是我的个人简历，</p><a href=\'/api/resume?filename=35_th.jpg \' download=\'th.jpg\'>点此下载</a>\n', '2024-04-22 07:29:50');
INSERT INTO `messages` VALUES (255, 30, 35, 1, '<p>您好，这是我的个人简历，</p><a href=\'/api/resume?filename=35_th.jpg \' download=\'th.jpg\'>点此下载</a>', '2024-04-22 07:29:58');
INSERT INTO `messages` VALUES (256, 35, 30, 1, 'www\n', '2024-04-22 07:33:09');
INSERT INTO `messages` VALUES (257, 30, 35, 1, '22\n', '2024-04-22 08:36:41');
INSERT INTO `messages` VALUES (258, 35, 30, 1, '<p>您好，这是我的个人简历，</p><a href=\'/api/resume?filename=35_th.jpg \' download=\'th.jpg\'>点此下载</a>\n', '2024-04-23 14:35:32');
INSERT INTO `messages` VALUES (259, 35, 30, 1, '<p>您好，这是我的个人资料</p> <a href=\'/applicantPage/35\' style=\'color: blue;\'>点此查看</a>\n', '2024-04-23 14:35:41');
INSERT INTO `messages` VALUES (260, 30, 35, 1, ' <a href=\'/company/1\' style=\'color: red;\'>点此访问公司</a><p>,上述为我司的详情介绍</p>\n', '2024-04-23 14:39:26');
INSERT INTO `messages` VALUES (261, 35, 30, 1, '嗡嗡嗡\n', '2024-04-27 08:13:58');
INSERT INTO `messages` VALUES (262, 48, 30, 1, '您好，我想要申请贵公司的 平面设计师2\n', '2024-04-27 08:17:24');
INSERT INTO `messages` VALUES (263, 35, 30, 1, '嘟嘟嘟\n', '2024-04-29 13:53:03');
INSERT INTO `messages` VALUES (264, 35, 30, 0, 'aawawawd\n', '2024-04-29 13:53:14');

-- ----------------------------
-- Table structure for test_url
-- ----------------------------
DROP TABLE IF EXISTS `test_url`;
CREATE TABLE `test_url`  (
  `URl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_url
-- ----------------------------
INSERT INTO `test_url` VALUES ('https://4gw13gv1-5200.asse.devtunnels.ms/');
INSERT INTO `test_url` VALUES ('edge://flags/#unsafely-treat-insecure-origin-as-secure');
INSERT INTO `test_url` VALUES ('https://4gw13gv1-5200.asse.devtunnels.ms/');
INSERT INTO `test_url` VALUES ('https://4gw13gv1-5200.asse.devtunnels.ms/');
INSERT INTO `test_url` VALUES ('https://sg3qvl7g-5200.inc1.devtunnels.ms/');

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
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `users` VALUES (45, 'test11122', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '18,33,null', '30,null', 'yueyvlunhui@outlook.com', '18061203051', 'NUIST', '南京', 'yuye', '南京', 2, '呢备注', '2024-04-16 07:16:49', '2024-04-26 09:57:52');
INSERT INTO `users` VALUES (35, 'testdemo', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, 'th.jpg', '34,18', '30', '@outlook.com', '', '', '', '无', '', 0, NULL, '2024-03-11 11:59:13', '2024-04-26 09:27:13');
INSERT INTO `users` VALUES (48, 'testdemo1', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '33,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-27 08:17:10', '2024-04-27 08:17:20');
INSERT INTO `users` VALUES (1, 'Timothy Adams', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'timothy1213@mail.com', '312-894-2062', NULL, NULL, NULL, NULL, NULL, NULL, '2017-10-01 02:04:03', '2024-04-09 06:38:21');
INSERT INTO `users` VALUES (8, 'Yamazaki Eita', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, 'yamazakieit131@outlook.com', '718-400-6535', NULL, NULL, NULL, NULL, NULL, NULL, '2021-10-03 20:56:51', '2024-04-09 06:38:22');
INSERT INTO `users` VALUES (2, 'Yu Yuning', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '0', 'yuninyu6@gmail.com', '5050 737219', '某某大学', '某某地址', '某某', '南京', NULL, NULL, '2010-01-12 06:21:42', '2024-04-26 09:57:46');
INSERT INTO `users` VALUES (43, 'yueyv112121', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '20,14,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:50:32', '2024-04-09 06:38:22');
INSERT INTO `users` VALUES (46, 'yueyv123', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, '33,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-19 14:09:05', '2024-04-19 14:09:11');
INSERT INTO `users` VALUES (47, 'yueyv1234', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-20 15:26:22', '2024-04-20 15:26:22');
INSERT INTO `users` VALUES (30, 'yueyvlunhui', 'nx0fN7LKRMnYvyodk/3kvg==', 1, 'README.md', NULL, '', '35,48', 'asdasd@ada.com222', 'asdasd', '12121', 'asdasd', '刘某', 'asdas', NULL, '阿萨大苏打实打实大苏打的是2313', '2024-02-26 11:49:01', '2024-04-27 08:17:21');
INSERT INTO `users` VALUES (40, 'yueyvtest', 'nx0fN7LKRMnYvyodk/3kvg==', 2, '模块.md', '前端开发_刘辉_南京信息工程大学.pdf', '33,14,21,null', '30,0', 'yueyvlunhui@outlook.com', '18061203051', NULL, '当涂县', '某某', '南京', 2, '测试测试', '2024-04-02 07:31:32', '2024-04-26 09:57:45');
INSERT INTO `users` VALUES (41, 'yueyvtest2', 'nx0fN7LKRMnYvyodk/3kvg==', 2, '前端开发_刘辉_南京信息工程大学.pdf', '前端开发_刘辉_南京信息工程大学.pdf', '26,null', '30,null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:43:19', '2024-04-09 06:38:23');
INSERT INTO `users` VALUES (42, 'yueyvtest5', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-03 05:45:37', '2024-04-09 06:38:24');
INSERT INTO `users` VALUES (0, '客服', 'nx0fN7LKRMnYvyodk/3kvg==', 0, NULL, NULL, NULL, '30,4,1,5,7,33,40', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2008-03-03 15:02:40', '2024-04-23 14:40:30');

-- ----------------------------
-- Table structure for video_chat
-- ----------------------------
DROP TABLE IF EXISTS `video_chat`;
CREATE TABLE `video_chat`  (
  `rtc_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`rtc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of video_chat
-- ----------------------------
INSERT INTO `video_chat` VALUES (1, 'yueyvlunhui', '2024-04-13 05:11:52', 'yueyvtest2', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (2, 'yueyvlunhui', '2024-04-13 05:23:35', 'testdemo', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (3, 'yueyvlunhui', '2024-04-13 05:37:26', 'yueyvtest2', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (4, 'yueyvlunhui', '2024-04-13 05:42:43', 'Timothy Adams', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (5, 'yueyvlunhui', '2024-04-13 05:43:04', 'testdemo', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (6, 'yueyvlunhui', '2024-04-13 05:44:25', 'testdemo', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (7, 'yueyvlunhui', '2024-04-13 05:47:24', 'testdemo', '2024-04-13 05:50:08', 0);
INSERT INTO `video_chat` VALUES (8, 'yueyvlunhui', '2024-04-13 05:53:28', 'testdemo', '2024-04-13 05:53:43', 0);
INSERT INTO `video_chat` VALUES (9, 'yueyvlunhui', '2024-04-13 05:55:09', 'testdemo', '2024-04-13 05:55:41', 0);
INSERT INTO `video_chat` VALUES (10, 'yueyvlunhui', '2024-04-13 05:59:50', 'testdemo', '2024-04-13 06:00:41', 0);
INSERT INTO `video_chat` VALUES (11, 'yueyvlunhui', '2024-04-13 06:04:06', 'yueyvtest', '2024-04-13 06:04:14', 0);
INSERT INTO `video_chat` VALUES (12, 'yueyvlunhui', '2024-04-13 06:20:17', 'yueyvtest', '2024-04-13 06:20:57', 0);
INSERT INTO `video_chat` VALUES (13, 'yueyvlunhui', '2024-04-13 06:28:00', 'yueyvtest', '2024-04-13 06:28:18', 0);
INSERT INTO `video_chat` VALUES (14, 'yueyvlunhui', '2024-04-16 10:35:46', 'test11122', '2024-04-16 10:35:46', 1);
INSERT INTO `video_chat` VALUES (15, 'yueyvlunhui', '2024-04-16 10:47:03', 'yueyvtest2', '2024-04-16 10:47:03', 1);
INSERT INTO `video_chat` VALUES (16, 'yueyvlunhui', '2024-04-16 10:48:27', 'Timothy Adams', '2024-04-16 10:48:27', 1);
INSERT INTO `video_chat` VALUES (17, 'yueyvlunhui', '2024-04-16 10:48:35', 'yueyvtest', '2024-04-17 11:10:56', 0);
INSERT INTO `video_chat` VALUES (18, 'yueyvlunhui', '2024-04-19 12:17:52', 'testdemo', '2024-04-19 12:18:04', 0);
INSERT INTO `video_chat` VALUES (19, 'yueyvlunhui', '2024-04-19 12:35:39', 'testdemo', '2024-04-19 12:38:39', 0);
INSERT INTO `video_chat` VALUES (20, 'yueyvlunhui', '2024-04-19 12:35:53', 'yueyvtest', '2024-04-19 12:36:03', 0);
INSERT INTO `video_chat` VALUES (21, 'yueyvlunhui', '2024-04-19 15:45:36', 'testdemo', '2024-04-19 15:46:17', 0);
INSERT INTO `video_chat` VALUES (22, 'yueyvlunhui', '2024-04-19 15:47:32', 'testdemo', '2024-04-19 15:48:22', 0);
INSERT INTO `video_chat` VALUES (23, 'yueyvlunhui', '2024-04-19 15:48:19', 'testdemo', '2024-04-19 15:48:22', 0);
INSERT INTO `video_chat` VALUES (24, 'yueyvlunhui', '2024-04-19 15:49:45', 'testdemo', '2024-04-19 15:50:25', 0);
INSERT INTO `video_chat` VALUES (25, 'yueyvlunhui', '2024-04-19 15:51:20', 'testdemo', '2024-04-19 15:51:27', 0);
INSERT INTO `video_chat` VALUES (26, 'yueyvlunhui', '2024-04-20 05:55:53', 'testdemo', '2024-04-20 05:58:55', 0);
INSERT INTO `video_chat` VALUES (27, 'yueyvlunhui', '2024-04-20 06:00:02', 'testdemo', '2024-04-20 15:37:42', 0);
INSERT INTO `video_chat` VALUES (28, 'yueyvlunhui', '2024-04-20 06:06:56', 'testdemo', '2024-04-20 15:37:42', 0);
INSERT INTO `video_chat` VALUES (29, 'yueyvlunhui', '2024-04-21 04:20:41', 'testdemo', '2024-04-21 04:25:17', 0);
INSERT INTO `video_chat` VALUES (30, 'yueyvlunhui', '2024-04-21 04:22:36', 'testdemo', '2024-04-21 04:25:17', 0);
INSERT INTO `video_chat` VALUES (31, 'yueyvlunhui', '2024-04-22 05:40:24', 'testdemo', '2024-04-22 05:42:03', 0);
INSERT INTO `video_chat` VALUES (32, 'yueyvlunhui', '2024-04-22 07:11:05', 'testdemo', '2024-04-22 07:18:00', 0);
INSERT INTO `video_chat` VALUES (33, 'yueyvlunhui', '2024-04-22 07:33:36', 'testdemo', '2024-04-22 07:33:56', 0);

SET FOREIGN_KEY_CHECKS = 1;
