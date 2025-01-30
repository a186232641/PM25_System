/*
 Navicat Premium Dump SQL

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : pm25_predict

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 28/01/2025 20:01:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for citylist
-- ----------------------------
DROP TABLE IF EXISTS `citylist`;
CREATE TABLE `citylist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `status` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_city` (`city`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of citylist
-- ----------------------------
BEGIN;
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (1, '北京', 'Beijing', 116.398000, 40.046000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (2, '天津', 'Tianjin', 117.322000, 39.077700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (3, '石家庄', 'Shijiazhuang', 114.493000, 38.033600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (4, '唐山', 'Tangshan', 118.183000, 39.645000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (5, '秦皇岛', 'Qinhuangdao', 119.607000, 39.936200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (6, '邯郸', 'Handan', 114.514000, 36.607900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (7, '保定', 'Baoding', 115.485000, 38.876300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (8, '张家口', 'Zhangjiakou', 114.901000, 40.802700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (9, '承德', 'Chengde', 117.928000, 40.964200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (10, '廊坊', 'Langfang', 116.715000, 39.526100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (11, '沧州', 'Cangzhou', 116.872000, 38.315800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (12, '衡水', 'Hengshui', 115.676000, 37.744800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (13, '邢台', 'Xingtai', 114.507000, 37.077100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (14, '太原', 'Taiyuan', 112.509000, 37.848900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (15, '呼和浩特', 'Huhehaote', 111.667000, 40.807700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (16, '大连', 'Dalian', 121.628000, 38.959000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (17, '上海', 'Shanghai', 121.453000, 31.210800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (18, '南京', 'Nanjing', 118.774000, 32.048800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (19, '苏州', 'Suzhou', 119.521000, 32.002900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (20, '南通', 'Nantong', 120.879000, 31.990400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (21, '连云港', 'Lianyungang', 119.176000, 34.588500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (22, '徐州', 'Xuzhou', 117.230000, 34.260400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (23, '扬州', 'Yangzhou', 119.396000, 32.393100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (24, '无锡', 'Wuxi', 120.290000, 31.570200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (25, '常州', 'Changzhou', 119.945000, 31.791100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (26, '镇江', 'Zhenjiang', 119.534000, 32.178400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (27, '台州', 'Taizhou', 120.630000, 30.548200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (28, '淮安', 'Huaian', 119.036000, 33.582100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (29, '盐城', 'Yancheng', 120.166000, 33.397000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (30, '宿迁', 'Suqian', 118.307000, 33.951700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (31, '杭州', 'Hangzhou', 120.082000, 30.211200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (32, '宁波', 'Ningbo', 121.629000, 29.866700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (33, '绍兴', 'Shaoxing', 120.605000, 29.991900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (34, '湖州', 'Huzhou', 120.070000, 30.824400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (35, '嘉兴', 'Jiaxing', 120.735000, 30.771200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (36, '金华', 'Jinhua', 119.666000, 29.090000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (37, '衢州', 'Quzhou', 118.866000, 28.960400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (38, '丽水', 'Lishui', 119.908000, 28.444400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (39, '合肥', 'Hefei', 117.248000, 31.848200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (40, '南昌', 'Nanchang', 115.873000, 28.702800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (41, '济南', 'Jinan', 117.009000, 36.657600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (42, '青岛', 'Qingdao', 120.361000, 36.148800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (43, '郑州', 'Zhengzhou', 113.665000, 34.760600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (44, '武汉', 'Wuhan', 114.287000, 30.576800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (45, '长沙', 'Zhangsha', 112.984000, 28.205200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (46, '重庆', 'Zhongqing', 106.502000, 29.617800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (47, '成都', 'Chengdou', 104.002000, 30.715500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (48, '西安', 'Xian', 108.995000, 34.302700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (49, '兰州', 'Lanzhou', 103.863000, 36.040500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (50, '银川', 'Yinchuan', 106.107000, 38.534200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (51, '包头', 'Baotou', 109.908000, 40.627800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (52, '鄂尔多斯', 'Eerduosi', 109.902000, 39.725000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (53, '葫芦岛', 'Huludao', 120.865000, 40.738400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (54, '莱芜', 'Laiwu', 117.679000, 36.228900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (55, '临沂', 'Linyi', 118.329000, 35.047700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (56, '聊城', 'Liaocheng', 115.984000, 36.458400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (57, '滨州', 'Binzhou', 117.995000, 37.378300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (58, '淄博', 'Zibo', 118.020000, 36.753500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (59, '枣庄', 'Zaozhuang', 117.514000, 34.806000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (60, '烟台', 'Yantai', 121.360000, 37.507400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (61, '潍坊', 'Weifang', 119.152000, 36.725300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (62, '济宁', 'Jining', 116.590000, 35.415400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (63, '泰安', 'Taian', 117.113000, 36.188100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (64, '日照', 'Rizhao', 119.492000, 35.420600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (65, '东营', 'Dongying', 118.502000, 37.465800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (66, '菏泽', 'Heze', 115.451000, 35.252100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (67, '大同', 'Datong', 113.313000, 40.097700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (68, '长治', 'Zhangzhi', 113.095000, 36.186600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (69, '临汾', 'Linfen', 111.519000, 36.079800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (70, '阳泉', 'Yangquan', 113.562000, 37.860700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (71, '锦州', 'Jinzhou', 121.118000, 41.058800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (72, '芜湖', 'Wuhu', 118.374000, 31.367800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (73, '马鞍山', 'Maanshan', 118.525000, 31.696800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (74, '九江', 'Jiujiang', 115.990000, 29.673300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (75, '洛阳', 'Luoyang', 112.420000, 34.657200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (76, '安阳', 'Anyang', 114.376000, 36.086000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (77, '开封', 'Kaifeng', 114.334000, 34.790800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (78, '焦作', 'Jiaozuo', 113.224000, 35.216100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (79, '平顶山', 'Pingdingshan', 113.260000, 33.732500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (80, '三门峡', 'Sanmenxia', 111.175000, 34.785600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (81, '宜昌', 'Yichang', 111.311000, 30.707600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (82, '荆州', 'Jingzhou', 112.250000, 30.324800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (83, '岳阳', 'Yueyang', 113.151000, 29.403600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (84, '常德', 'Changde', 111.707000, 29.057900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (85, '张家界', 'Zhangjiajie', 110.503000, 29.205900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (86, '绵阳', 'Mianyang', 104.733000, 31.475300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (87, '宜宾', 'Yibin', 104.620000, 28.775100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (88, '泸州', 'Luzhou', 105.435000, 28.900000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (89, '自贡', 'Zigong', 104.762000, 29.351900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (90, '德阳', 'Deyang', 104.392000, 31.120400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (91, '南充', 'Nanchong', 106.086000, 30.803100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (92, '咸阳', 'Xianyang', 108.700000, 34.339900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (93, '铜川', 'Tongchuan', 108.988000, 34.949500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (94, '延安', 'Yanan', 109.488000, 36.596700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (95, '宝鸡', 'Baoji', 107.190000, 34.354100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (96, '渭南', 'Weinan', 109.465000, 34.498500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (97, '石嘴山', 'Shizuishan', 106.548000, 39.047400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (98, '章丘', 'Zhangqiu', 117.541000, 36.710000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (99, '即墨', 'Jimo', 120.470000, 36.390000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (100, '胶南', 'Jiaonan', 120.005000, 35.878000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (101, '胶州', 'Jiaozhou', 120.014000, 36.253000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (102, '莱西', 'Laixi', 120.515000, 36.885000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (103, '平度', 'Pingdu', 119.952000, 36.792000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (104, '蓬莱', 'Penglai', 120.760000, 37.817000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (105, '招远', 'Zhaoyuan', 120.399000, 37.374000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (106, '莱州', 'Laizhou', 119.950000, 37.178500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (107, '乳山', 'Rushan', 121.531000, 36.913000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (108, '吴江', 'Wujiang', 120.643000, 31.165700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (109, '太仓', 'Taicang', 121.140000, 31.422000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (110, '句容', 'Jurong', 119.146000, 31.955000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (111, '江阴', 'Jiangyin', 120.269000, 31.916300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (112, '宜兴', 'Yixing', 119.818000, 31.354000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (113, '金坛', 'Jintan', 119.579000, 31.744000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (114, '溧阳', 'Liyang', 119.449000, 31.358500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (115, '临安', 'Linan', 119.718000, 30.236600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (116, '阜阳', 'Fuyang', 117.210000, 31.934000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (117, '义乌', 'Yiwu', 120.065000, 29.319500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (118, '信阳', 'Xinyang', 114.062000, 32.130100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (119, '周口', 'Zhoukou', 114.657000, 33.621500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (120, '晋城', 'Jincheng', 112.846000, 35.500600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (121, '朔州', 'Shuozhou', 112.431000, 39.344700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (122, '晋中', 'Jinzhong', 112.732000, 37.707200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (123, '运城', 'Yuncheng', 111.007000, 35.055300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (124, '忻州', 'Xinzhou', 112.725000, 38.454400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (125, '吕梁', 'Lu:liang', 111.141000, 37.521100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (126, '乌海', 'Wuhai', 106.808000, 39.675300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (127, '巴彦淖尔', 'Bayannaoer', 107.507000, 40.838400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (128, '乌兰察布', 'Wulanchabu', 113.131000, 40.992300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (129, '阿拉善盟', 'Alashanmeng', 105.700000, 38.843000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (130, '朝阳', 'Chaoyang', 120.421000, 41.590900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (131, '蚌埠', 'Bangbu', 117.357000, 32.929200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (132, '淮南', 'Huainan', 116.836000, 32.666500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (133, '淮北', 'Huaibei', 116.797000, 33.940300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (134, '铜陵', 'Tongling', 117.809000, 30.929600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (135, '安庆', 'Anqing', 117.025000, 30.546900, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (136, '黄山', 'Huangshan', 118.255000, 29.903000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (137, '滁州', 'Chuzhou', 118.317000, 32.300000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (138, '六安', 'Liuan', 116.515000, 31.762400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (139, '池州', 'Chizhou', 117.484000, 30.657800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (140, '宣城', 'Xuancheng', 118.738000, 30.954000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (141, '景德镇', 'Jingdezhen', 117.224000, 29.304200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (142, '鹰潭', 'Yingtan', 117.013000, 28.208600, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (143, '上饶', 'Shangrao', 117.958000, 28.448800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (144, '鹤壁', 'Hebi', 114.251000, 35.794500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (145, '新乡', 'Xinxiang', 113.868000, 35.295000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (146, '濮阳', 'Puyang', 115.057000, 35.765700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (147, '许昌', 'Xuchang', 113.812000, 34.003500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (148, '漯河', 'Luohe', 114.027000, 33.570300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (149, '南阳', 'Nanyang', 112.532000, 32.990100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (150, '商丘', 'Shangqiu', 115.655000, 34.421500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (151, '驻马店', 'Zhumadian', 114.009000, 32.989300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (152, '黄石', 'Huangshi', 115.015000, 30.213100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (153, '十堰', 'Shiyan', 110.858000, 32.563700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (154, '襄樊', 'Xiangfan', 112.172000, 32.070100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (155, '鄂州', 'Ezhou', 114.867000, 30.393000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (156, '荆门', 'Jingmen', 112.206000, 31.025400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (157, '孝感', 'Xiaogan', 113.929000, 30.918000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (158, '黄冈', 'Huanggang', 114.903000, 30.474200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (159, '咸宁', 'Xianning', 114.313000, 29.840400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (160, '随州', 'Suizhou', 113.380000, 31.716400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (161, '恩施州', 'Enshizhou', 109.486000, 30.290400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (162, '益阳', 'Yiyang', 112.341000, 28.581800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (163, '湘西州', 'Xiangxizhou', 109.714000, 28.292200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (164, '广元', 'Guangyuan', 105.849000, 32.437400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (165, '遂宁', 'Suining', 105.697000, 30.574300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (166, '内江', 'Neijiang', 105.053000, 29.588500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (167, '乐山', 'Leshan', 103.760000, 29.573800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (168, '眉山', 'Meishan', 103.870000, 30.069000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (169, '广安', 'Guangan', 106.632000, 30.459700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (170, '达州', 'Dazhou', 107.503000, 31.221400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (171, '雅安', 'Yaan', 103.011000, 29.983400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (172, '资阳', 'Ziyang', 104.641000, 30.133000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (173, '汉中', 'Hanzhong', 107.010000, 33.072200, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (174, '安康', 'Ankang', 109.022000, 32.689700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (175, '商洛', 'Shangluo', 109.915000, 33.871500, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (176, '白银', 'Baiyin', 104.173000, 36.547000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (177, '天水', 'Tianshui', 105.795000, 34.573300, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (178, '平凉', 'Pingliang', 106.687000, 35.537800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (179, '庆阳', 'Qingyang', 107.653000, 35.653100, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (180, '定西', 'Dingxi', 104.620000, 35.584400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (181, '临夏州', 'Linxiazhou', 103.210000, 35.601800, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (182, '吴忠', 'Wuzhong', 106.199000, 37.978400, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (183, '中卫', 'Zhongwei', 105.189000, 37.258700, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
INSERT INTO `citylist` (`id`, `name`, `city`, `longitude`, `latitude`, `status`, `created_at`, `updated_at`) VALUES (184, '固原', 'Guyuan', 106.250000, 36.055000, 1, '2025-01-28 15:05:32', '2025-01-28 15:05:32');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
