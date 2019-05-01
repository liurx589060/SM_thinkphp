/*
Navicat MySQL Data Transfer

Source Server         : xq
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-05-01 22:29:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xq_banner`
-- ----------------------------
DROP TABLE IF EXISTS `xq_banner`;
CREATE TABLE `xq_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_banner
-- ----------------------------
INSERT INTO `xq_banner` VALUES ('1', 'http://img.ivsky.com/img/bizhi/co/201711/27/nissan_vmotion2_0-001.jpg', '1');
INSERT INTO `xq_banner` VALUES ('2', 'http://img.ivsky.com/img/tupian/co/201709/18/zise_huaduo.jpg', '2');
INSERT INTO `xq_banner` VALUES ('3', 'http://img.ivsky.com/img/tupian/co/201709/16/dahailidehaiguitupian.jpg', '3');

-- ----------------------------
-- Table structure for `xq_black_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_black_user`;
CREATE TABLE `xq_black_user` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `report_msg` varchar(255) NOT NULL COMMENT '自定义举报内容',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '禁止开始时间',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '禁止结束时间',
  `room_id` int(255) NOT NULL COMMENT '被举报时的房间号',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '是否禁止状态（1：禁止    0：解禁）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户举报';

-- ----------------------------
-- Records of xq_black_user
-- ----------------------------
INSERT INTO `xq_black_user` VALUES ('9', 'wys30201', '言语或视频违背伦理;', '2019-04-09 01:01:50', '2019-04-11 01:01:54', '15378694', '0');

-- ----------------------------
-- Table structure for `xq_bonus_item`
-- ----------------------------
DROP TABLE IF EXISTS `xq_bonus_item`;
CREATE TABLE `xq_bonus_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_bonus_item
-- ----------------------------
INSERT INTO `xq_bonus_item` VALUES ('1', '注册赠送');
INSERT INTO `xq_bonus_item` VALUES ('2', '匹配成功赠送');

-- ----------------------------
-- Table structure for `xq_bonus_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_bonus_user`;
CREATE TABLE `xq_bonus_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bonus_id` int(11) DEFAULT NULL,
  `gift_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL COMMENT '发放对象',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modify_time` timestamp NULL DEFAULT NULL COMMENT '领取时间',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '发放的数量',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '是否已领取（0：未领取    1：已领取）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_bonus_user
-- ----------------------------
INSERT INTO `xq_bonus_user` VALUES ('4', '1', '8', 'wys30211', '2019-05-01 22:03:33', '2019-05-01 22:04:18', '1', '1');
INSERT INTO `xq_bonus_user` VALUES ('5', '1', '6', 'wys30211', '2019-05-01 22:03:33', '2019-05-01 22:04:18', '5', '1');
INSERT INTO `xq_bonus_user` VALUES ('6', '1', '4', 'wys30212', '2019-05-01 22:05:49', '2019-05-01 22:06:09', '1', '1');
INSERT INTO `xq_bonus_user` VALUES ('7', '1', '7', 'wys30212', '2019-05-01 22:05:49', '2019-05-01 22:06:09', '2', '1');
INSERT INTO `xq_bonus_user` VALUES ('8', '1', '7', 'wys30214', '2019-05-01 22:09:26', '2019-05-01 22:09:30', '2', '1');

-- ----------------------------
-- Table structure for `xq_chat`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat`;
CREATE TABLE `xq_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(255) NOT NULL COMMENT '房间Id',
  `title` varchar(255) DEFAULT NULL COMMENT '主题',
  `describe` varchar(255) NOT NULL COMMENT '房间描述',
  `user_name` varchar(255) NOT NULL COMMENT '创建者',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '解散时间',
  `public` int(11) NOT NULL DEFAULT '1' COMMENT '是否公开（0：私密   1：公开）',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '房间状态（0：未匹配成功  1：匹配成功  -1：取消）',
  `appoint_time` timestamp NULL DEFAULT NULL COMMENT '预约的时间',
  `limit_level` int(11) NOT NULL DEFAULT '-1' COMMENT '等级（-1：不限等级）',
  `limit_angel` int(11) NOT NULL DEFAULT '1' COMMENT '爱心大使上限',
  `limit_lady` int(11) NOT NULL DEFAULT '10' COMMENT '女嘉宾上限',
  `limit_man` int(11) NOT NULL DEFAULT '1' COMMENT '男嘉宾上限',
  `count_angel` int(11) DEFAULT '0' COMMENT '当前爱心大使人数',
  `count_lady` int(11) NOT NULL DEFAULT '0' COMMENT '当前女嘉宾人数',
  `count_man` int(11) NOT NULL DEFAULT '0' COMMENT '当前男嘉宾人数',
  `work` int(11) NOT NULL DEFAULT '0' COMMENT '工作状态（0：初始化   1：进行中    2：已结束）',
  `push_address` varchar(255) DEFAULT NULL,
  `play_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='聊天室创建和删除记录表';

-- ----------------------------
-- Records of xq_chat
-- ----------------------------
INSERT INTO `xq_chat` VALUES ('52', '17944471', '一起来相亲吧', '', 'wys30201', '2019-04-29 00:07:10', '2019-04-29 00:17:13', '1', '0', '2019-04-29 00:43:00', '-1', '1', '2', '1', '1', '1', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('53', '15837894', '一起来相亲吧', '', 'wys30201', '2019-04-29 01:27:42', '2019-04-29 01:31:56', '1', '0', '2019-04-30 09:00:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('54', '17947209', '一起来相亲吧', '', 'wys30201', '2019-04-29 01:33:18', '2019-04-29 01:40:56', '1', '0', '2019-04-29 11:00:00', '-1', '1', '2', '1', '1', '1', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('55', '17947239', '一起来相亲吧', '', 'wys30201', '2019-04-29 01:44:08', '2019-04-29 01:59:19', '1', '0', '2019-04-29 11:23:00', '-1', '1', '2', '1', '1', '2', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('56', '15839052', '一起来相亲吧', '', 'wys30201', '2019-04-29 02:18:33', '2019-05-01 17:59:49', '1', '0', '2019-04-30 00:00:00', '-1', '1', '2', '1', '1', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('57', '15857004', '一起来相亲吧', '', 'wys30201', '2019-05-01 18:07:22', '2019-05-01 18:09:32', '1', '0', '2019-05-01 19:12:00', '-1', '1', '2', '1', '1', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('58', '15857008', '一起来相亲吧', '', 'wys30201', '2019-05-01 18:09:56', '2019-05-01 18:20:42', '1', '0', '2019-05-01 19:14:00', '-1', '1', '2', '1', '1', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');

-- ----------------------------
-- Table structure for `xq_chat_room`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat_room`;
CREATE TABLE `xq_chat_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `inner_id` varchar(255) DEFAULT NULL COMMENT '匹配房间id',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '匹配结果（0：失败    1：成功）',
  `man_user` varchar(255) DEFAULT NULL COMMENT '匹配成功的男嘉宾',
  `lady_user` varchar(255) DEFAULT NULL COMMENT '匹配成功女嘉宾',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room
-- ----------------------------
INSERT INTO `xq_chat_room` VALUES ('58', '17944471', '2019-04-29 00:15:35', '2019-04-29 00:16:37', 'R2019042955101525', '1', 'wys30204', 'wys30203');
INSERT INTO `xq_chat_room` VALUES ('59', '17947209', '2019-04-29 01:35:01', '2019-04-29 01:37:17', 'R2019042953555157', '0', 'wys30204', 'wys30203');
INSERT INTO `xq_chat_room` VALUES ('60', '17947239', '2019-04-29 01:45:13', '2019-04-29 01:46:49', 'R2019042957554854', '1', 'wys30204', 'wys30202');
INSERT INTO `xq_chat_room` VALUES ('61', '17947239', '2019-04-29 01:49:03', '2019-04-29 01:49:43', 'R2019042910298975', '1', 'wys30204', 'wys30202');

-- ----------------------------
-- Table structure for `xq_chat_room_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat_room_user`;
CREATE TABLE `xq_chat_room_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `inner_id` varchar(255) DEFAULT NULL COMMENT '匹配房间id',
  `room_role_type` int(11) NOT NULL DEFAULT '0' COMMENT '进入房间的角色（2：围观者   1：参与者）',
  `user_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '是否成功（1：成功     0：失败）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room_user
-- ----------------------------
INSERT INTO `xq_chat_room_user` VALUES ('250', '17944471', '2019-04-29 00:15:35', '2019-04-29 00:16:35', 'R2019042955101525', '1', 'wys30202', '1');
INSERT INTO `xq_chat_room_user` VALUES ('251', '17944471', '2019-04-29 00:15:35', '2019-04-29 00:16:37', 'R2019042955101525', '1', 'wys30203', '1');
INSERT INTO `xq_chat_room_user` VALUES ('252', '17944471', '2019-04-29 00:15:35', '2019-04-29 00:16:35', 'R2019042955101525', '1', 'wys30204', '1');
INSERT INTO `xq_chat_room_user` VALUES ('253', '17944471', '2019-04-29 00:15:35', '2019-04-29 00:16:35', 'R2019042955101525', '1', 'wys30201', '1');
INSERT INTO `xq_chat_room_user` VALUES ('254', '17947209', '2019-04-29 01:35:01', '2019-04-29 01:37:00', 'R2019042953555157', '1', 'wys30203', '1');
INSERT INTO `xq_chat_room_user` VALUES ('255', '17947209', '2019-04-29 01:35:01', '2019-04-29 01:36:17', 'R2019042953555157', '1', 'wys30202', '1');
INSERT INTO `xq_chat_room_user` VALUES ('256', '17947209', '2019-04-29 01:35:01', '2019-04-29 01:37:17', 'R2019042953555157', '1', 'wys30204', '0');
INSERT INTO `xq_chat_room_user` VALUES ('257', '17947209', '2019-04-29 01:35:01', '2019-04-29 01:36:17', 'R2019042953555157', '1', 'wys30201', '1');
INSERT INTO `xq_chat_room_user` VALUES ('258', '17947239', '2019-04-29 01:45:13', '2019-04-29 01:46:01', 'R2019042957554854', '1', 'wys30203', '1');
INSERT INTO `xq_chat_room_user` VALUES ('259', '17947239', '2019-04-29 01:45:13', '2019-04-29 01:46:01', 'R2019042957554854', '1', 'wys30202', '1');
INSERT INTO `xq_chat_room_user` VALUES ('260', '17947239', '2019-04-29 01:45:13', '2019-04-29 01:46:49', 'R2019042957554854', '1', 'wys30204', '1');
INSERT INTO `xq_chat_room_user` VALUES ('261', '17947239', '2019-04-29 01:45:13', '2019-04-29 01:46:01', 'R2019042957554854', '1', 'wys30201', '1');
INSERT INTO `xq_chat_room_user` VALUES ('262', '17947239', '2019-04-29 01:49:03', '2019-04-29 01:49:42', 'R2019042910298975', '1', 'wys30203', '1');
INSERT INTO `xq_chat_room_user` VALUES ('263', '17947239', '2019-04-29 01:49:03', '2019-04-29 01:49:42', 'R2019042910298975', '1', 'wys30202', '1');
INSERT INTO `xq_chat_room_user` VALUES ('264', '17947239', '2019-04-29 01:49:03', '2019-04-29 01:49:43', 'R2019042910298975', '1', 'wys30204', '1');
INSERT INTO `xq_chat_room_user` VALUES ('265', '17947239', '2019-04-29 01:49:03', '2019-04-29 01:49:42', 'R2019042910298975', '1', 'wys30201', '1');

-- ----------------------------
-- Table structure for `xq_chat_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat_user`;
CREATE TABLE `xq_chat_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL COMMENT '房间Id',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `start_time` datetime NOT NULL COMMENT '进入时间',
  `end_time` datetime DEFAULT NULL COMMENT '退出时间',
  `room_role_type` int(11) NOT NULL DEFAULT '0' COMMENT '进入房间的角色（2：围观者   1：参与者）',
  `in_room` int(11) NOT NULL DEFAULT '0' COMMENT '是否在房间内（0：不在     1：在）',
  `work` int(11) NOT NULL DEFAULT '0' COMMENT '工作状态（0：初始化   1：进行中    2：已结束）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COMMENT='用户进出聊天室表';

-- ----------------------------
-- Records of xq_chat_user
-- ----------------------------
INSERT INTO `xq_chat_user` VALUES ('231', '17944471', 'wys30201', '2019-04-29 00:07:10', '2019-04-29 00:17:13', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('232', '17944471', 'wys30202', '2019-04-29 00:07:14', '2019-04-29 00:17:15', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('233', '17944471', 'wys30203', '2019-04-29 00:07:30', '2019-04-29 00:16:37', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('234', '17944471', 'wys30204', '2019-04-29 00:07:45', '2019-04-29 00:17:17', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('235', '15837894', 'wys30201', '2019-04-29 01:27:42', '2019-04-29 01:31:56', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('236', '15837894', 'wys30202', '2019-04-29 01:28:33', '2019-04-29 01:32:50', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('237', '15837894', 'wys30203', '2019-04-29 01:30:55', '2019-04-29 01:33:22', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('238', '15837894', 'wys30204', '2019-04-29 01:31:25', '2019-04-29 01:32:56', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('239', '17947209', 'wys30201', '2019-04-29 01:33:18', '2019-04-29 01:40:56', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('240', '17947209', 'wys30203', '2019-04-29 01:33:28', '2019-04-29 01:37:00', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('241', '17947209', 'wys30202', '2019-04-29 01:33:51', '2019-04-29 01:40:57', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('242', '17947209', 'wys30204', '2019-04-29 01:33:58', '2019-04-29 01:37:17', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('243', '17947239', 'wys30201', '2019-04-29 01:44:08', '2019-04-29 01:59:19', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('244', '17947239', 'wys30203', '2019-04-29 01:44:29', '2019-04-29 01:59:22', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('245', '17947239', 'wys30202', '2019-04-29 01:44:47', '2019-04-29 01:59:21', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('246', '17947239', 'wys30204', '2019-04-29 01:45:00', '2019-04-29 01:46:49', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('247', '17947239', 'wys30204', '2019-04-29 01:48:47', '2019-04-29 01:49:43', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('248', '15839052', 'wys30201', '2019-04-29 02:18:33', '2019-05-01 17:59:49', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('249', '15857004', 'wys30201', '2019-05-01 18:07:22', '2019-05-01 18:09:32', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('250', '15857008', 'wys30201', '2019-05-01 18:09:56', '2019-05-01 18:20:42', '1', '0', '2');

-- ----------------------------
-- Table structure for `xq_coin_consume_history`
-- ----------------------------
DROP TABLE IF EXISTS `xq_coin_consume_history`;
CREATE TABLE `xq_coin_consume_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物自身id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户',
  `to_user` varchar(255) DEFAULT NULL COMMENT '赠送对方',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '购买时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=utf8 COMMENT='金币消费记录';

-- ----------------------------
-- Records of xq_coin_consume_history
-- ----------------------------
INSERT INTO `xq_coin_consume_history` VALUES ('318', '1', 'wys30201', 'wys30201', '2019-04-09 00:01:15');
INSERT INTO `xq_coin_consume_history` VALUES ('319', '1', 'wys30201', 'wys30201', '2019-04-09 00:01:16');
INSERT INTO `xq_coin_consume_history` VALUES ('320', '1', 'wys30201', 'wys30201', '2019-04-09 00:01:17');
INSERT INTO `xq_coin_consume_history` VALUES ('321', '2', 'wys30201', 'wys30201', '2019-04-09 00:01:20');
INSERT INTO `xq_coin_consume_history` VALUES ('322', '3', 'wys30201', 'wys30201', '2019-04-09 00:01:21');
INSERT INTO `xq_coin_consume_history` VALUES ('323', '3', 'wys30201', 'wys30201', '2019-04-09 00:01:23');
INSERT INTO `xq_coin_consume_history` VALUES ('324', '5', 'wys30201', 'wys30201', '2019-04-09 00:01:25');
INSERT INTO `xq_coin_consume_history` VALUES ('325', '2', 'wys30201', 'wys30201', '2019-04-09 00:16:51');
INSERT INTO `xq_coin_consume_history` VALUES ('326', '1', 'wys30201', 'wys30201', '2019-04-09 00:17:01');
INSERT INTO `xq_coin_consume_history` VALUES ('327', '1', 'wys30201', 'wys30201', '2019-04-09 00:19:57');
INSERT INTO `xq_coin_consume_history` VALUES ('328', '1', 'wys30201', 'wys30201', '2019-04-09 00:20:05');
INSERT INTO `xq_coin_consume_history` VALUES ('329', '3', 'wys30201', 'wys30201', '2019-04-09 00:20:07');
INSERT INTO `xq_coin_consume_history` VALUES ('330', '3', 'wys30201', 'wys30201', '2019-04-09 00:20:08');
INSERT INTO `xq_coin_consume_history` VALUES ('331', '3', 'wys30201', 'wys30201', '2019-04-09 00:20:10');
INSERT INTO `xq_coin_consume_history` VALUES ('332', '3', 'wys30201', 'wys30201', '2019-04-09 00:20:11');
INSERT INTO `xq_coin_consume_history` VALUES ('333', '1', 'wys30201', 'wys30201', '2019-04-09 00:22:13');
INSERT INTO `xq_coin_consume_history` VALUES ('334', '1', 'wys30201', 'wys30201', '2019-04-09 00:22:15');
INSERT INTO `xq_coin_consume_history` VALUES ('335', '1', 'wys30201', 'wys30201', '2019-04-09 00:23:00');
INSERT INTO `xq_coin_consume_history` VALUES ('336', '1', 'wys30201', 'wys30201', '2019-04-09 00:23:02');
INSERT INTO `xq_coin_consume_history` VALUES ('337', '1', 'wys30201', 'wys30201', '2019-04-09 00:23:36');
INSERT INTO `xq_coin_consume_history` VALUES ('338', '1', 'wys30201', 'wys30201', '2019-04-09 00:24:33');
INSERT INTO `xq_coin_consume_history` VALUES ('339', '1', 'wys30201', 'wys30201', '2019-04-09 00:28:49');
INSERT INTO `xq_coin_consume_history` VALUES ('340', '1', 'wys30201', 'wys30201', '2019-04-09 00:28:56');
INSERT INTO `xq_coin_consume_history` VALUES ('341', '3', 'wys30201', 'wys30201', '2019-04-09 00:30:07');
INSERT INTO `xq_coin_consume_history` VALUES ('342', '2', 'wys30201', 'wys30201', '2019-04-09 00:30:15');
INSERT INTO `xq_coin_consume_history` VALUES ('343', '6', 'wys30201', 'wys30201', '2019-04-09 01:16:37');
INSERT INTO `xq_coin_consume_history` VALUES ('344', '6', 'wys30201', 'wys30201', '2019-04-09 01:18:14');
INSERT INTO `xq_coin_consume_history` VALUES ('345', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:37');
INSERT INTO `xq_coin_consume_history` VALUES ('346', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:38');
INSERT INTO `xq_coin_consume_history` VALUES ('347', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:40');
INSERT INTO `xq_coin_consume_history` VALUES ('348', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:41');
INSERT INTO `xq_coin_consume_history` VALUES ('349', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:42');
INSERT INTO `xq_coin_consume_history` VALUES ('350', '1', 'wys30201', 'wys30201', '2019-04-09 01:28:43');
INSERT INTO `xq_coin_consume_history` VALUES ('351', '2', 'wys30202', 'wys30201', '2019-04-09 01:32:43');
INSERT INTO `xq_coin_consume_history` VALUES ('352', '1', 'wys30202', 'wys30201', '2019-04-09 01:33:08');
INSERT INTO `xq_coin_consume_history` VALUES ('353', '1', 'wys30202', 'wys30201', '2019-04-09 01:33:13');
INSERT INTO `xq_coin_consume_history` VALUES ('354', '1', 'wys30202', 'wys30201', '2019-04-09 01:34:47');
INSERT INTO `xq_coin_consume_history` VALUES ('355', '1', 'wys30201', 'wys30202', '2019-04-09 01:36:58');
INSERT INTO `xq_coin_consume_history` VALUES ('356', '3', 'wys30202', 'wys30201', '2019-04-09 01:56:04');
INSERT INTO `xq_coin_consume_history` VALUES ('357', '3', 'wys30202', 'wys30201', '2019-04-09 01:56:05');
INSERT INTO `xq_coin_consume_history` VALUES ('358', '1', 'wys30202', 'wys30201', '2019-04-09 01:56:23');
INSERT INTO `xq_coin_consume_history` VALUES ('359', '2', 'wys30201', 'wys30202', '2019-04-09 22:25:34');
INSERT INTO `xq_coin_consume_history` VALUES ('360', '4', 'wys30201', 'wys30201', '2019-04-09 22:27:20');
INSERT INTO `xq_coin_consume_history` VALUES ('361', '4', 'wys30201', 'wys30201', '2019-04-09 22:29:18');
INSERT INTO `xq_coin_consume_history` VALUES ('362', '4', 'wys30201', 'wys30201', '2019-04-09 22:29:40');
INSERT INTO `xq_coin_consume_history` VALUES ('363', '6', 'wys30201', 'wys30201', '2019-04-09 22:34:59');
INSERT INTO `xq_coin_consume_history` VALUES ('364', '1', 'wys30201', 'wys30201', '2019-04-10 21:52:40');
INSERT INTO `xq_coin_consume_history` VALUES ('365', '3', 'wys30201', 'wys30201', '2019-04-10 21:52:42');
INSERT INTO `xq_coin_consume_history` VALUES ('366', '4', 'wys30201', 'wys30201', '2019-04-10 21:55:14');
INSERT INTO `xq_coin_consume_history` VALUES ('367', '6', 'wys30201', 'wys30201', '2019-04-10 21:55:17');
INSERT INTO `xq_coin_consume_history` VALUES ('368', '6', 'wys30201', 'wys30201', '2019-04-10 22:03:50');
INSERT INTO `xq_coin_consume_history` VALUES ('369', '2', 'wys30201', 'wys30201', '2019-04-10 22:03:54');
INSERT INTO `xq_coin_consume_history` VALUES ('370', '2', 'wys30201', 'wys30201', '2019-04-10 22:03:55');
INSERT INTO `xq_coin_consume_history` VALUES ('371', '2', 'wys30201', 'wys30201', '2019-04-10 22:03:56');
INSERT INTO `xq_coin_consume_history` VALUES ('372', '4', 'wys30201', 'wys30201', '2019-04-10 22:03:59');
INSERT INTO `xq_coin_consume_history` VALUES ('373', '5', 'wys30201', 'wys30201', '2019-04-10 22:04:00');
INSERT INTO `xq_coin_consume_history` VALUES ('374', '1000', 'wys30201', 'wys30201', '2019-04-11 23:49:33');
INSERT INTO `xq_coin_consume_history` VALUES ('375', '6', 'wys30201', 'wys30201', '2019-04-11 23:50:56');
INSERT INTO `xq_coin_consume_history` VALUES ('376', '1001', 'wys30202', 'wys30202', '2019-04-12 00:07:42');
INSERT INTO `xq_coin_consume_history` VALUES ('377', '4', 'wys30202', 'wys30202', '2019-04-12 00:10:27');
INSERT INTO `xq_coin_consume_history` VALUES ('378', '4', 'wys30202', 'wys30202', '2019-04-12 00:10:31');
INSERT INTO `xq_coin_consume_history` VALUES ('379', '4', 'wys30201', 'wys30201', '2019-04-12 00:37:53');
INSERT INTO `xq_coin_consume_history` VALUES ('390', '4', 'wys30202', 'wys30202', '2019-04-12 01:10:45');
INSERT INTO `xq_coin_consume_history` VALUES ('391', '2', 'wys30202', 'wys30201', '2019-04-12 01:14:40');
INSERT INTO `xq_coin_consume_history` VALUES ('392', '1001', 'wys30202', 'wys30202', '2019-04-12 01:43:27');
INSERT INTO `xq_coin_consume_history` VALUES ('393', '1001', 'wys30202', 'wys30202', '2019-04-12 01:43:48');
INSERT INTO `xq_coin_consume_history` VALUES ('394', '6', 'wys30201', 'wys30201', '2019-04-13 11:10:57');
INSERT INTO `xq_coin_consume_history` VALUES ('395', '1000', 'wys30201', 'wys30201', '2019-04-14 19:15:51');
INSERT INTO `xq_coin_consume_history` VALUES ('396', '1001', 'wys30202', 'wys30202', '2019-04-15 21:55:06');
INSERT INTO `xq_coin_consume_history` VALUES ('397', '1000', 'wys30201', 'wys30201', '2019-04-15 23:33:51');
INSERT INTO `xq_coin_consume_history` VALUES ('398', '1000', 'wys30201', 'wys30201', '2019-04-15 23:41:34');
INSERT INTO `xq_coin_consume_history` VALUES ('399', '1000', 'wys30201', 'wys30201', '2019-04-18 16:46:03');
INSERT INTO `xq_coin_consume_history` VALUES ('400', '1000', 'wys30201', 'wys30201', '2019-04-18 21:19:09');
INSERT INTO `xq_coin_consume_history` VALUES ('401', '1000', 'wys30201', 'wys30201', '2019-04-18 21:20:44');
INSERT INTO `xq_coin_consume_history` VALUES ('402', '1000', 'wys30201', 'wys30201', '2019-04-18 21:30:10');
INSERT INTO `xq_coin_consume_history` VALUES ('403', '1000', 'wys30201', 'wys30201', '2019-04-18 23:41:08');
INSERT INTO `xq_coin_consume_history` VALUES ('404', '1000', 'wys30201', 'wys30201', '2019-04-18 23:45:10');
INSERT INTO `xq_coin_consume_history` VALUES ('405', '1000', 'wys30201', 'wys30201', '2019-04-18 23:47:55');
INSERT INTO `xq_coin_consume_history` VALUES ('406', '6', 'wys30201', 'wys30201', '2019-04-18 23:51:53');
INSERT INTO `xq_coin_consume_history` VALUES ('407', '1001', 'wys30202', 'wys30202', '2019-04-19 13:20:13');
INSERT INTO `xq_coin_consume_history` VALUES ('408', '1001', 'wys30202', 'wys30202', '2019-04-19 16:06:33');
INSERT INTO `xq_coin_consume_history` VALUES ('409', '1001', 'wys30202', 'wys30202', '2019-04-19 16:13:41');
INSERT INTO `xq_coin_consume_history` VALUES ('410', '1001', 'wys30202', 'wys30202', '2019-04-19 16:18:23');
INSERT INTO `xq_coin_consume_history` VALUES ('411', '1001', 'wys30202', 'wys30202', '2019-04-19 16:20:53');
INSERT INTO `xq_coin_consume_history` VALUES ('412', '1001', 'wys30202', 'wys30202', '2019-04-19 16:23:35');
INSERT INTO `xq_coin_consume_history` VALUES ('413', '1000', 'wys30205', 'wys30205', '2019-04-19 22:58:31');
INSERT INTO `xq_coin_consume_history` VALUES ('414', '1000', 'wys30205', 'wys30205', '2019-04-19 23:02:01');
INSERT INTO `xq_coin_consume_history` VALUES ('415', '1001', 'wys30202', 'wys30202', '2019-04-20 00:22:32');
INSERT INTO `xq_coin_consume_history` VALUES ('416', '1001', 'wys30202', 'wys30202', '2019-04-20 00:25:41');
INSERT INTO `xq_coin_consume_history` VALUES ('417', '1001', 'wys30202', 'wys30202', '2019-04-20 00:27:31');
INSERT INTO `xq_coin_consume_history` VALUES ('418', '1001', 'wys30202', 'wys30202', '2019-04-20 00:32:29');
INSERT INTO `xq_coin_consume_history` VALUES ('419', '1001', 'wys30202', 'wys30202', '2019-04-20 00:38:46');
INSERT INTO `xq_coin_consume_history` VALUES ('420', '1001', 'wys30202', 'wys30202', '2019-04-20 00:39:31');
INSERT INTO `xq_coin_consume_history` VALUES ('421', '1001', 'wys30202', 'wys30202', '2019-04-20 00:40:06');
INSERT INTO `xq_coin_consume_history` VALUES ('422', '1001', 'wys30202', 'wys30202', '2019-04-20 00:40:47');
INSERT INTO `xq_coin_consume_history` VALUES ('423', '1001', 'wys30202', 'wys30202', '2019-04-20 02:56:52');
INSERT INTO `xq_coin_consume_history` VALUES ('424', '1001', 'wys30202', 'wys30202', '2019-04-20 03:02:32');
INSERT INTO `xq_coin_consume_history` VALUES ('425', '1001', 'wys30202', 'wys30202', '2019-04-20 03:06:44');
INSERT INTO `xq_coin_consume_history` VALUES ('426', '1001', 'wys30202', 'wys30202', '2019-04-20 03:08:40');
INSERT INTO `xq_coin_consume_history` VALUES ('427', '1001', 'wys30202', 'wys30202', '2019-04-20 03:10:17');
INSERT INTO `xq_coin_consume_history` VALUES ('428', '4', 'wys30202', 'wys30202', '2019-04-20 03:13:10');
INSERT INTO `xq_coin_consume_history` VALUES ('429', '1001', 'wys30202', 'wys30202', '2019-04-20 03:18:53');
INSERT INTO `xq_coin_consume_history` VALUES ('430', '1000', 'wys30201', 'wys30201', '2019-04-20 12:55:55');
INSERT INTO `xq_coin_consume_history` VALUES ('431', '1000', 'wys30201', 'wys30201', '2019-04-20 12:58:08');
INSERT INTO `xq_coin_consume_history` VALUES ('432', '1000', 'wys30201', 'wys30201', '2019-04-20 12:58:31');
INSERT INTO `xq_coin_consume_history` VALUES ('433', '1001', 'wys30202', 'wys30202', '2019-04-20 12:59:38');
INSERT INTO `xq_coin_consume_history` VALUES ('434', '1001', 'wys30202', 'wys30202', '2019-04-20 13:09:57');
INSERT INTO `xq_coin_consume_history` VALUES ('435', '1001', 'wys30202', 'wys30202', '2019-04-20 13:27:47');
INSERT INTO `xq_coin_consume_history` VALUES ('436', '1001', 'wys30202', 'wys30202', '2019-04-20 13:30:46');
INSERT INTO `xq_coin_consume_history` VALUES ('437', '1001', 'wys30202', 'wys30202', '2019-04-20 13:31:40');
INSERT INTO `xq_coin_consume_history` VALUES ('438', '1001', 'wys30202', 'wys30202', '2019-04-20 13:35:46');
INSERT INTO `xq_coin_consume_history` VALUES ('439', '1001', 'wys30202', 'wys30202', '2019-04-20 13:38:50');
INSERT INTO `xq_coin_consume_history` VALUES ('440', '1001', 'wys30202', 'wys30202', '2019-04-20 13:39:09');
INSERT INTO `xq_coin_consume_history` VALUES ('441', '1001', 'wys30202', 'wys30202', '2019-04-20 13:39:31');
INSERT INTO `xq_coin_consume_history` VALUES ('442', '1001', 'wys30202', 'wys30202', '2019-04-20 14:48:42');
INSERT INTO `xq_coin_consume_history` VALUES ('443', '1001', 'wys30202', 'wys30202', '2019-04-20 14:49:06');
INSERT INTO `xq_coin_consume_history` VALUES ('444', '6', 'wys30201', 'wys30201', '2019-04-20 14:54:14');
INSERT INTO `xq_coin_consume_history` VALUES ('445', '1001', 'wys30202', 'wys30202', '2019-04-20 14:55:30');
INSERT INTO `xq_coin_consume_history` VALUES ('446', '1001', 'wys30202', 'wys30202', '2019-04-20 14:56:03');
INSERT INTO `xq_coin_consume_history` VALUES ('447', '1001', 'wys30202', 'wys30202', '2019-04-20 15:04:18');
INSERT INTO `xq_coin_consume_history` VALUES ('448', '1001', 'wys30202', 'wys30202', '2019-04-20 15:32:48');
INSERT INTO `xq_coin_consume_history` VALUES ('449', '1001', 'wys30202', 'wys30202', '2019-04-20 15:32:58');
INSERT INTO `xq_coin_consume_history` VALUES ('450', '1001', 'wys30202', 'wys30202', '2019-04-20 15:42:59');
INSERT INTO `xq_coin_consume_history` VALUES ('451', '1001', 'wys30202', 'wys30202', '2019-04-20 15:43:47');
INSERT INTO `xq_coin_consume_history` VALUES ('452', '4', 'wys30202', 'wys30202', '2019-04-20 15:50:48');
INSERT INTO `xq_coin_consume_history` VALUES ('453', '1000', 'wys30201', 'wys30201', '2019-04-21 19:27:23');
INSERT INTO `xq_coin_consume_history` VALUES ('454', '1000', 'wys30201', 'wys30201', '2019-04-21 20:34:17');
INSERT INTO `xq_coin_consume_history` VALUES ('455', '1000', 'wys30201', 'wys30201', '2019-04-21 20:52:29');
INSERT INTO `xq_coin_consume_history` VALUES ('456', '6', 'wys30201', 'wys30201', '2019-04-23 21:31:32');
INSERT INTO `xq_coin_consume_history` VALUES ('457', '4', 'wys30203', 'wys30203', '2019-04-23 21:52:24');
INSERT INTO `xq_coin_consume_history` VALUES ('458', '1001', 'wys30203', 'wys30203', '2019-04-24 00:25:57');
INSERT INTO `xq_coin_consume_history` VALUES ('459', '1001', 'wys30203', 'wys30203', '2019-04-24 20:27:31');
INSERT INTO `xq_coin_consume_history` VALUES ('460', '4', 'wys30203', 'wys30203', '2019-04-24 20:28:33');
INSERT INTO `xq_coin_consume_history` VALUES ('461', '4', 'wys30204', 'wys30204', '2019-04-24 21:07:59');
INSERT INTO `xq_coin_consume_history` VALUES ('462', '4', 'wys30201', 'wys30201', '2019-04-24 21:52:29');
INSERT INTO `xq_coin_consume_history` VALUES ('463', '6', 'wys30201', 'wys30201', '2019-04-24 21:52:34');
INSERT INTO `xq_coin_consume_history` VALUES ('464', '4', 'wys30202', 'wys30202', '2019-04-24 22:51:08');
INSERT INTO `xq_coin_consume_history` VALUES ('465', '1', 'wys30201', 'wys30202', '2019-04-25 20:53:22');
INSERT INTO `xq_coin_consume_history` VALUES ('466', '3', 'wys30201', 'wys30202', '2019-04-25 20:53:39');
INSERT INTO `xq_coin_consume_history` VALUES ('467', '2', 'wys30201', 'wys30202', '2019-04-25 20:53:59');
INSERT INTO `xq_coin_consume_history` VALUES ('468', '3', 'wys30202', 'wys30201', '2019-04-25 20:54:21');
INSERT INTO `xq_coin_consume_history` VALUES ('469', '1', 'wys30203', 'wys30202', '2019-04-25 21:40:12');
INSERT INTO `xq_coin_consume_history` VALUES ('470', '6', 'wys30201', 'wys30201', '2019-04-25 21:57:00');
INSERT INTO `xq_coin_consume_history` VALUES ('471', '4', 'wys30204', 'wys30204', '2019-04-25 21:57:19');
INSERT INTO `xq_coin_consume_history` VALUES ('472', '4', 'wys30203', 'wys30203', '2019-04-25 21:57:31');
INSERT INTO `xq_coin_consume_history` VALUES ('473', '4', 'wys30202', 'wys30202', '2019-04-25 23:11:41');
INSERT INTO `xq_coin_consume_history` VALUES ('474', '1', 'wys30203', 'wys30202', '2019-04-25 23:56:42');
INSERT INTO `xq_coin_consume_history` VALUES ('475', '3', 'wys30203', 'wys30202', '2019-04-25 23:57:13');
INSERT INTO `xq_coin_consume_history` VALUES ('476', '4', 'wys30203', 'wys30203', '2019-04-26 00:42:55');
INSERT INTO `xq_coin_consume_history` VALUES ('477', '4', 'wys30204', 'wys30204', '2019-04-26 00:43:07');
INSERT INTO `xq_coin_consume_history` VALUES ('478', '1000', 'wys30201', 'wys30201', '2019-04-28 22:18:47');
INSERT INTO `xq_coin_consume_history` VALUES ('479', '6', 'wys30201', 'wys30201', '2019-04-28 22:19:36');
INSERT INTO `xq_coin_consume_history` VALUES ('480', '1', 'wys30202', 'wys30203', '2019-04-29 00:05:05');
INSERT INTO `xq_coin_consume_history` VALUES ('481', '4', 'wys30202', 'wys30202', '2019-04-29 01:44:43');
INSERT INTO `xq_coin_consume_history` VALUES ('482', '4', 'wys30204', 'wys30204', '2019-04-29 01:44:57');
INSERT INTO `xq_coin_consume_history` VALUES ('483', '6', 'wys30201', 'wys30201', '2019-05-01 18:06:47');
INSERT INTO `xq_coin_consume_history` VALUES ('484', '6', 'wys30201', 'wys30201', '2019-05-01 18:07:37');
INSERT INTO `xq_coin_consume_history` VALUES ('485', '6', 'wys30201', 'wys30201', '2019-05-01 18:09:45');
INSERT INTO `xq_coin_consume_history` VALUES ('486', '6', 'wys30201', 'wys30201', '2019-05-01 18:10:10');

-- ----------------------------
-- Table structure for `xq_gift_category`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_category`;
CREATE TABLE `xq_gift_category` (
  `position` int(11) DEFAULT NULL COMMENT '位置 （1：我的   2：房间礼品  3：房间卡包）',
  `gift_id` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `is_trade` int(11) DEFAULT '1' COMMENT '是否可交易（0：不可交易  1：可交易）',
  `name` varchar(255) DEFAULT NULL COMMENT '名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_category
-- ----------------------------
INSERT INTO `xq_gift_category` VALUES ('1', '1', '3', '1', '玫瑰');
INSERT INTO `xq_gift_category` VALUES ('1', '2', '5', '1', '爱心');
INSERT INTO `xq_gift_category` VALUES ('1', '3', '4', '1', '白开水');
INSERT INTO `xq_gift_category` VALUES ('1', '5', '6', '1', '礼品券');
INSERT INTO `xq_gift_category` VALUES ('1', '6', '2', '1', '建房卡（1天）');
INSERT INTO `xq_gift_category` VALUES ('1', '7', '1', '1', '延时卡');
INSERT INTO `xq_gift_category` VALUES ('2', '1', '1', '1', '玫瑰');
INSERT INTO `xq_gift_category` VALUES ('2', '2', '2', '1', '爱心');
INSERT INTO `xq_gift_category` VALUES ('2', '3', '3', '1', '白开水');
INSERT INTO `xq_gift_category` VALUES ('3', '7', '1', '1', '延时卡');
INSERT INTO `xq_gift_category` VALUES ('1', '4', '7', '1', '入门券');

-- ----------------------------
-- Table structure for `xq_gift_consume`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_consume`;
CREATE TABLE `xq_gift_consume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物自身id（同表xq_gift_item对应）',
  `user_name` varchar(255) DEFAULT NULL,
  `to_user` varchar(255) DEFAULT NULL COMMENT '来自用户名',
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_consume
-- ----------------------------

-- ----------------------------
-- Table structure for `xq_gift_item`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_item`;
CREATE TABLE `xq_gift_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` int(11) NOT NULL COMMENT '类型（1：礼品   2：卡券  100：固定消耗品）',
  `gift_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '礼品名称',
  `coin` int(11) NOT NULL COMMENT '需要的coin',
  `value` varchar(11) NOT NULL DEFAULT '' COMMENT '数值（比如积分或者延时秒数）',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `gif` varchar(255) DEFAULT NULL COMMENT 'gif动图',
  PRIMARY KEY (`id`,`gift_id`),
  UNIQUE KEY `gift_id` (`gift_id`),
  UNIQUE KEY `gift_id_2` (`gift_id`),
  UNIQUE KEY `gift_id_3` (`gift_id`),
  UNIQUE KEY `gift_id_4` (`gift_id`),
  UNIQUE KEY `gift_id_5` (`gift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_item
-- ----------------------------
INSERT INTO `xq_gift_item` VALUES ('1', '1', '1', '玫瑰', '2', '0', '/thinkphp/image/rose.png', '赠人玫瑰，手留余香', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('2', '1', '2', '爱心', '2', '0', '/thinkphp/image/love.png', '给你的爱滔滔不绝', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('3', '1', '3', '白开水', '2', '0', '/thinkphp/image/bottle.png', '平平淡淡', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('4', '2', '4', '入门券', '50', '20', '/thinkphp/image/card_enter_room.png', '用于免费进入房间一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('5', '1', '5', '礼品券', '2', '0', '/thinkphp/image/card_gift.png', '可兑换2钻石的礼物，只能兑换一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('6', '2', '6', '临时建房卡（1天）', '100', '24', '/thinkphp/image/card_jianfang.png', '可用于1天免费建房', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('7', '2', '7', '延时卡', '300', '30', '/thinkphp/image/card_yanshi.png', '在房间中当自己发言时，使用后可增加30s的发言时间', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('8', '100', '1000', '创建房间', '2', '', '', null, null);
INSERT INTO `xq_gift_item` VALUES ('9', '100', '1001', '加入房间', '1', '', '', null, null);
INSERT INTO `xq_gift_item` VALUES ('11', '2', '8', '长期建房卡（10天）', '900', '240', '/thinkphp/image/card_jianfang.png', '可用于10天免费建房', '/thinkphp/image/gif_love.gif');

-- ----------------------------
-- Table structure for `xq_gift_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_user`;
CREATE TABLE `xq_gift_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT '',
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物Id',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `expiry_num` int(11) DEFAULT '-1' COMMENT '总共可使用次数（-1：此数值无效，不使用）',
  `start_time` datetime DEFAULT NULL COMMENT '使用的开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '使用的截至时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '使用状态（0：未使用     1：正在使用   2：已过期）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用来记录卡的使用期限';

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('10', 'wys30201', '4', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('11', 'wys30201', '3', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('12', 'wys30201', '1', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('13', 'wys30211', '8', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('14', 'wys30211', '6', '5', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('15', 'wys30212', '4', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('16', 'wys30212', '7', '2', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('17', 'wys30214', '7', '2', '-1', null, null, '0');

-- ----------------------------
-- Table structure for `xq_pay_item`
-- ----------------------------
DROP TABLE IF EXISTS `xq_pay_item`;
CREATE TABLE `xq_pay_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '钻石数',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '人民币（分）',
  `bonus` int(11) NOT NULL DEFAULT '0' COMMENT '额外奖励',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '次序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '商品描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_pay_item
-- ----------------------------
INSERT INTO `xq_pay_item` VALUES ('1', '60', '60', '0', '1', '60钻石');
INSERT INTO `xq_pay_item` VALUES ('2', '300', '300', '0', '3', '300钻石');
INSERT INTO `xq_pay_item` VALUES ('3', '980', '980', '0', '4', '980钻石');
INSERT INTO `xq_pay_item` VALUES ('4', '1980', '1980', '0', '5', '1980钻石');
INSERT INTO `xq_pay_item` VALUES ('5', '100', '100', '0', '2', '100钻石');

-- ----------------------------
-- Table structure for `xq_pay_order`
-- ----------------------------
DROP TABLE IF EXISTS `xq_pay_order`;
CREATE TABLE `xq_pay_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(36) DEFAULT NULL COMMENT '订单id',
  `serial_id` varchar(128) DEFAULT NULL COMMENT '流水号',
  `pay_type` int(11) DEFAULT '-1' COMMENT '支付方式（1：微信  2：支付宝  10:其他）',
  `user_name` varchar(40) DEFAULT NULL COMMENT '下单用户名',
  `coin` int(11) DEFAULT '0' COMMENT '订单钻石数',
  `money` int(11) DEFAULT '0' COMMENT '订单金额（人民币）',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '支付状态（1：未处理   1：支付成功  2：支付失败  3:补单）',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '生产时间',
  `modify_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `channel` varchar(255) DEFAULT NULL COMMENT 'app发布渠道',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_pay_order
-- ----------------------------
INSERT INTO `xq_pay_order` VALUES ('38', 'O2019040949551004', null, '1', 'wys30201', '60', '60', '0', '2019-04-09 00:43:13', null, null);
INSERT INTO `xq_pay_order` VALUES ('39', 'O2019040953485710', '2019040953505610', '1', 'wys30201', '60', '60', '1', '2019-04-09 00:47:17', '2019-04-09 00:47:17', null);
INSERT INTO `xq_pay_order` VALUES ('40', 'O2019040949575797', '2019040949994850', '1', 'wys30201', '60', '60', '1', '2019-04-09 01:05:53', '2019-04-09 01:05:53', null);
INSERT INTO `xq_pay_order` VALUES ('41', 'O2019040910049489', '2019040910051555', '1', 'wys30201', '60', '60', '1', '2019-04-09 01:07:41', '2019-04-09 01:07:41', null);
INSERT INTO `xq_pay_order` VALUES ('42', 'O2019040998519897', '2019040998535356', '1', 'wys30201', '60', '60', '1', '2019-04-09 01:11:23', '2019-04-09 01:11:23', null);
INSERT INTO `xq_pay_order` VALUES ('43', 'O2019040910154100', '2019040910156535', '1', 'wys30201', '300', '300', '1', '2019-04-09 01:18:38', '2019-04-09 01:18:38', null);
INSERT INTO `xq_pay_order` VALUES ('44', 'O2019040910110099', '2019040910248991', '1', 'wys30201', '1980', '1980', '1', '2019-04-09 22:33:18', '2019-04-09 22:33:19', null);
INSERT INTO `xq_pay_order` VALUES ('45', 'O2019040957515310', '2019040957539757', '1', 'wys30201', '60', '60', '1', '2019-04-09 22:33:45', '2019-04-09 22:33:45', null);
INSERT INTO `xq_pay_order` VALUES ('46', 'O2019040910056101', '2019040910097525', '1', 'wys30201', '60', '60', '1', '2019-04-09 22:36:29', '2019-04-09 22:36:29', null);
INSERT INTO `xq_pay_order` VALUES ('47', 'O2019040957489855', '2019040957505797', '1', 'wys30201', '60', '60', '1', '2019-04-09 22:39:05', '2019-04-09 22:39:05', null);
INSERT INTO `xq_pay_order` VALUES ('48', 'O2019040956575250', '2019040956985256', '1', 'wys30201', '60', '60', '1', '2019-04-09 22:46:16', '2019-04-09 22:46:16', null);
INSERT INTO `xq_pay_order` VALUES ('49', 'O2019040953565349', '2019040953579952', '1', 'wys30201', '60', '60', '1', '2019-04-09 22:51:49', '2019-04-09 22:51:49', null);
INSERT INTO `xq_pay_order` VALUES ('50', 'O2019040999515056', '2019040999525751', '1', 'wys30201', '60', '60', '1', '2019-04-09 23:00:28', '2019-04-09 23:00:28', null);
INSERT INTO `xq_pay_order` VALUES ('51', 'O2019040910049534', '2019040910050551', '1', 'wys30201', '60', '60', '1', '2019-04-09 23:01:33', '2019-04-09 23:01:33', null);
INSERT INTO `xq_pay_order` VALUES ('52', 'O2019040951102514', '2019040952495610', '1', 'wys30201', '60', '60', '1', '2019-04-09 23:03:31', '2019-04-09 23:03:32', null);
INSERT INTO `xq_pay_order` VALUES ('53', 'O2019041257575310', '2019041257989852', '1', 'wys30202', '100', '100', '1', '2019-04-12 01:06:49', '2019-04-12 01:06:49', null);
INSERT INTO `xq_pay_order` VALUES ('54', 'O2019041256575157', '2019041256985049', '1', 'wys30202', '100', '100', '1', '2019-04-12 01:10:16', '2019-04-12 01:10:16', null);
INSERT INTO `xq_pay_order` VALUES ('55', 'O2019041355525154', null, '1', 'wys30203', '60', '60', '0', '2019-04-13 23:07:35', null, null);
INSERT INTO `xq_pay_order` VALUES ('56', 'O2019041348535197', null, '1', 'wys30203', '60', '60', '0', '2019-04-13 23:16:32', null, null);
INSERT INTO `xq_pay_order` VALUES ('57', 'O2019041310154574', null, '1', 'wys30203', '60', '60', '0', '2019-04-13 23:20:14', null, null);
INSERT INTO `xq_pay_order` VALUES ('58', 'O2019041348521021', '2019041348545652', '1', 'wys30203', '60', '60', '1', '2019-04-13 23:29:20', '2019-04-13 23:29:20', null);
INSERT INTO `xq_pay_order` VALUES ('59', 'O2019041354545353', null, '1', 'wys30203', '60', '60', '0', '2019-04-13 23:45:58', null, null);
INSERT INTO `xq_pay_order` VALUES ('60', 'O2019041398525648', null, '1', 'wys30203', '60', '60', '0', '2019-04-13 23:56:43', null, null);
INSERT INTO `xq_pay_order` VALUES ('61', 'O2019041452504998', null, '1', 'wys30203', '60', '60', '1', '2019-04-14 00:15:00', '2019-04-14 00:15:00', null);
INSERT INTO `xq_pay_order` VALUES ('62', 'O2019041457535357', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:15:53', '2019-04-14 00:15:53', null);
INSERT INTO `xq_pay_order` VALUES ('63', 'O2019041457101491', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:16:09', '2019-04-14 00:16:10', null);
INSERT INTO `xq_pay_order` VALUES ('64', 'O2019041449505097', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:19:13', '2019-04-14 00:19:13', null);
INSERT INTO `xq_pay_order` VALUES ('65', 'O2019041410053505', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:25:17', '2019-04-14 00:25:17', null);
INSERT INTO `xq_pay_order` VALUES ('66', 'O2019041455985299', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:25:27', '2019-04-14 00:25:27', null);
INSERT INTO `xq_pay_order` VALUES ('67', 'O2019041450555310', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:25:38', '2019-04-14 00:25:38', null);
INSERT INTO `xq_pay_order` VALUES ('68', 'O2019041499535710', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:26:04', '2019-04-14 00:26:04', null);
INSERT INTO `xq_pay_order` VALUES ('69', 'O2019041450995599', null, '1', 'wys30201', '60', '60', '1', '2019-04-14 00:26:42', '2019-04-14 00:26:42', null);
INSERT INTO `xq_pay_order` VALUES ('70', 'O2019041449100975', null, '1', 'wys30201', '60', '60', '0', '2019-04-14 19:15:13', null, null);
INSERT INTO `xq_pay_order` VALUES ('71', 'O2019041953979855', null, '1', 'wys30205', '100', '100', '0', '2019-04-19 22:57:41', null, null);
INSERT INTO `xq_pay_order` VALUES ('72', 'O2019042049101101', null, '1', 'wys30202', '100', '100', '0', '2019-04-20 03:19:45', null, null);

-- ----------------------------
-- Table structure for `xq_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_user`;
CREATE TABLE `xq_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户Id',
  `user_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1 COMMENT='用户列表';

-- ----------------------------
-- Records of xq_user
-- ----------------------------
INSERT INTO `xq_user` VALUES ('1', 'wys30201', 'a3104028f10587ab4891049563ddddb9', '2019-05-01 17:59:43', '2019-05-01 17:59:43');
INSERT INTO `xq_user` VALUES ('2', 'aaa', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 22:24:02', '2019-01-15 00:21:07');
INSERT INTO `xq_user` VALUES ('10', 'wys30202', 'a3104028f10587ab4891049563ddddb9', '2018-05-16 23:58:46', '2019-01-13 12:46:30');
INSERT INTO `xq_user` VALUES ('12', 'wys30203', 'a3104028f10587ab4891049563ddddb9', '2018-05-30 23:31:16', '2019-01-13 12:46:27');
INSERT INTO `xq_user` VALUES ('15', 'wys30204', 'a3104028f10587ab4891049563ddddb9', '2018-05-31 21:28:30', '2019-01-13 12:46:23');
INSERT INTO `xq_user` VALUES ('16', 'wys30205', 'a3104028f10587ab4891049563ddddb9', '2018-12-16 13:36:00', '2019-01-13 12:46:20');
INSERT INTO `xq_user` VALUES ('23', 'wys30211', 'a3104028f10587ab4891049563ddddb9', '2019-05-01 22:03:33', '0000-00-00 00:00:00');
INSERT INTO `xq_user` VALUES ('24', 'wys30212', 'aa7ca9532f6b0d5bfb87370e7392ee0d', '2019-05-01 22:05:48', '0000-00-00 00:00:00');
INSERT INTO `xq_user` VALUES ('25', 'wys30213', 'a3104028f10587ab4891049563ddddb9', '2019-05-01 22:07:43', '0000-00-00 00:00:00');
INSERT INTO `xq_user` VALUES ('26', 'wys30214', '8254782fee751ec1bf052701fc1e3c38', '2019-05-01 22:09:25', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `xq_user_friend`
-- ----------------------------
DROP TABLE IF EXISTS `xq_user_friend`;
CREATE TABLE `xq_user_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL COMMENT '用户名',
  `targetName` varchar(255) NOT NULL COMMENT '好友用户名',
  `roomId` int(11) NOT NULL COMMENT '房间号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户好友';

-- ----------------------------
-- Records of xq_user_friend
-- ----------------------------
INSERT INTO `xq_user_friend` VALUES ('14', 'wys30201', 'wys30204', '124587', '2019-01-21 22:47:00');
INSERT INTO `xq_user_friend` VALUES ('15', 'wys30201', 'wys30203', '124587', '2019-01-23 00:17:00');
INSERT INTO `xq_user_friend` VALUES ('16', 'wys30204', 'wys30201', '124587', '2019-01-31 00:10:13');
INSERT INTO `xq_user_friend` VALUES ('17', 'wys30203', 'wys30201', '124587', '2019-01-31 00:12:16');

-- ----------------------------
-- Table structure for `xq_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `xq_user_info`;
CREATE TABLE `xq_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8 DEFAULT '',
  `gender` varchar(16) CHARACTER SET utf8 NOT NULL,
  `role_type` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '角色（爱心大使：angel   嘉宾：guest   观众：looker）',
  `level` int(11) NOT NULL,
  `balance` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `tall` int(11) NOT NULL,
  `scholling` varchar(255) CHARACTER SET utf8 COLLATE utf8_estonian_ci NOT NULL,
  `professional` varchar(255) CHARACTER SET utf8 NOT NULL,
  `native_place` varchar(255) CHARACTER SET utf8 NOT NULL,
  `marrige` int(1) NOT NULL DEFAULT '0',
  `job_address` text CHARACTER SET utf8 NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8 NOT NULL,
  `head_image` text CHARACTER SET utf8 NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `special_info` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COMMENT='用户详情列表';

-- ----------------------------
-- Records of xq_user_info
-- ----------------------------
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', 'wys30201', '男', '爱心大使', '0', '1518', '26', '175', '博士及以上', 'IT工程师', '湖南', '1', '深圳市南山区', '13609613560', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2019-04-08 21:47:20', '2019-04-27 21:57:04', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', '嘉宾', '0', '290', '23', '170', '博士及以上', 'IT', '广东', '1', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2019-04-15 21:54:59', '');
INSERT INTO `xq_user_info` VALUES ('5', '12', 'wys30203', 'wys30203', '女', '嘉宾', '0', '96', '22', '158', '硕士', '销售', '湖北', '1', '武汉', '', '/thinkphp/upload/XQ/IMG_20190112162444_308.jpg', '2018-05-30 23:31:29', '2019-04-24 20:47:08', '');
INSERT INTO `xq_user_info` VALUES ('6', '15', 'wys30204', 'wys30204', '男', '嘉宾', '0', '400', '27', '183', '本科', '工程经理', '山东省青岛市城阳区', '1', '江西省景德镇市乐平市', '', '/thinkphp/upload/XQ/IMG_20190429234015_411.jpg', '2018-05-31 21:37:17', '2019-04-30 21:49:59', '新高浮雕升高个');
INSERT INTO `xq_user_info` VALUES ('7', '16', 'wys30205', 'wys30205', '男', '观众', '0', '96', '28', '170', '硕士', '及', '湖南', '1', '上海', '', '/thinkphp/upload/XQ/IMG_20190419225458_846.jpg', '2018-12-16 14:02:16', '2019-04-19 22:57:08', '理想随风');
INSERT INTO `xq_user_info` VALUES ('8', '17', 'wys30210', '心莹', '女', '嘉宾', '0', '100', '33', '162', '硕士', '教师', '广东', '2', '深圳', '', '/thinkphp/upload/XQ/IMG_20190419223229_752.jpg', '2019-04-19 22:23:30', '2019-04-19 22:32:32', '我的阅历足够美');
INSERT INTO `xq_user_info` VALUES ('11', '23', 'wys30211', 'wys', '男', '爱心大使', '0', '0', '12', '14', '本科以下', 'xc', '河北省石家庄市长安区', '1', '北京市北京市东城区', '', '/thinkphp/upload/XQ/IMG_20190501220300_354.jpg', '2019-05-01 22:03:33', '2019-05-01 22:03:33', '');
INSERT INTO `xq_user_info` VALUES ('12', '24', 'wys30212', 'thv', '男', '嘉宾', '0', '0', '12', '156', '本科以下', 'xzgg', '山西省太原市小店区', '1', '河北省石家庄市长安区', '', '/thinkphp/upload/XQ/IMG_20190501220501_723.jpg', '2019-05-01 22:05:48', '2019-05-01 22:05:49', '');
INSERT INTO `xq_user_info` VALUES ('13', '25', 'wys30213', 'xxfg', '男', '观众', '0', '0', '74', '145', '硕士', 'sgghj', '山西省太原市小店区', '2', '内蒙古呼和浩特市新城区', '', '/thinkphp/upload/XQ/IMG_20190501220706_431.jpg', '2019-05-01 22:07:44', '2019-05-01 22:07:44', 'gbnzx');
INSERT INTO `xq_user_info` VALUES ('14', '26', 'wys30214', 'ddgg', '女', '嘉宾', '0', '0', '445', '455', '硕士', 'dfh', '山西省太原市小店区', '1', '重庆市重庆市渝中区', '', '/thinkphp/upload/XQ/IMG_20190501220918_899.jpg', '2019-05-01 22:09:26', '2019-05-01 22:09:26', '');

-- ----------------------------
-- Table structure for `xq_user_report`
-- ----------------------------
DROP TABLE IF EXISTS `xq_user_report`;
CREATE TABLE `xq_user_report` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `report_type` int(10) NOT NULL COMMENT '举报类型',
  `report_msg` varchar(255) NOT NULL COMMENT '自定义举报内容',
  `room_id` int(255) NOT NULL COMMENT '房间号',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='用户举报';

-- ----------------------------
-- Records of xq_user_report
-- ----------------------------
INSERT INTO `xq_user_report` VALUES ('31', 'wys30201', '3', '', '15378694', '0000-00-00 00:00:00');
INSERT INTO `xq_user_report` VALUES ('32', 'wys30201', '3', '', '15378694', '0000-00-00 00:00:00');
INSERT INTO `xq_user_report` VALUES ('33', 'wys30201', '3', 'Vddf', '15378694', '0000-00-00 00:00:00');
INSERT INTO `xq_user_report` VALUES ('34', 'wys30201', '3', '111111', '15378694', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `xq_version`
-- ----------------------------
DROP TABLE IF EXISTS `xq_version`;
CREATE TABLE `xq_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_code` int(11) NOT NULL,
  `version_name` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `down_url` varchar(255) NOT NULL COMMENT '新apk下载url',
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_force` int(11) NOT NULL DEFAULT '0' COMMENT '是否强制更新',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_version
-- ----------------------------
INSERT INTO `xq_version` VALUES ('1', '1', 'V1.0.2', '1.V2版震撼来袭，功能强大，链式编程，调用简单，集成轻松，扩展性强大\\n2.老规矩先看V2效果，这个版本最大的特点就是使用非常简单，相对于1.+版本\\n3.更强大的自定义界面支持\\n4.compile \'com.allenliu.versionchecklib:library:2.0.0\'\\n5.该模式最简单的使用', 'http://test-1251233192.coscd.myqcloud.com/1_1.apk', '2019-04-29 21:29:50', '0');
