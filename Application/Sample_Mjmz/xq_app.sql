/*
Navicat MySQL Data Transfer

Source Server         : xq
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-04-25 01:46:57
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='聊天室创建和删除记录表';

-- ----------------------------
-- Records of xq_chat
-- ----------------------------
INSERT INTO `xq_chat` VALUES ('20', '17896861', '一起来相亲吧', '', 'wys30201', '2019-04-25 00:30:02', '2019-04-25 00:56:41', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('21', '15787656', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:02:37', '2019-04-25 01:20:23', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('22', '15787704', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:23:10', '2019-04-25 01:26:35', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('23', '17897007', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:27:28', '2019-04-25 01:29:56', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('24', '17897025', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:31:32', '2019-04-25 01:36:59', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('25', '17897053', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:38:03', '2019-04-25 01:41:32', '1', '0', '2019-04-25 23:59:00', '-1', '1', '2', '1', '1', '2', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('26', '17897065', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:41:44', '2019-04-25 01:42:04', '1', '0', '2019-04-25 11:41:00', '-1', '1', '2', '1', '1', '1', '1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('27', '15787778', '一起来相亲吧', '', 'wys30201', '2019-04-25 01:42:33', null, '1', '0', '2019-04-25 08:42:00', '-1', '1', '2', '1', '1', '1', '0', '0', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDMvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room
-- ----------------------------
INSERT INTO `xq_chat_room` VALUES ('12', '17896861', '2019-04-25 00:30:22', '2019-04-25 00:38:42', 'R2019042510148489', '1', 'wys30204', 'wys30202');
INSERT INTO `xq_chat_room` VALUES ('13', '17896861', '2019-04-25 00:53:05', '2019-04-25 00:53:59', 'R2019042549995649', '1', 'wys30204', 'wys30202');
INSERT INTO `xq_chat_room` VALUES ('14', '17896861', '2019-04-25 00:56:09', null, 'R2019042557521005', '0', null, null);
INSERT INTO `xq_chat_room` VALUES ('15', '15787656', '2019-04-25 01:05:19', '2019-04-25 01:08:03', 'R2019042510255989', '1', 'wys30204', 'wys30203');
INSERT INTO `xq_chat_room` VALUES ('16', '15787656', '2019-04-25 01:11:37', '2019-04-25 01:20:44', 'R2019042557559756', '1', 'wys30204', 'wys30203');
INSERT INTO `xq_chat_room` VALUES ('17', '15787704', '2019-04-25 01:24:49', '2019-04-25 01:26:45', 'R2019042549971029', '1', 'wys30204', 'wys30202');
INSERT INTO `xq_chat_room` VALUES ('18', '17897007', '2019-04-25 01:27:55', '2019-04-25 01:30:07', 'R2019042598999954', '0', 'wys30204', 'wys30202');
INSERT INTO `xq_chat_room` VALUES ('19', '17897025', '2019-04-25 01:31:47', '2019-04-25 01:37:14', 'R2019042551505399', '1', 'wys30204', 'wys30203');
INSERT INTO `xq_chat_room` VALUES ('20', '17897053', '2019-04-25 01:40:27', null, 'R2019042598100995', '0', null, null);
INSERT INTO `xq_chat_room` VALUES ('21', '15787778', '2019-04-25 01:42:55', '2019-04-25 01:45:53', 'R2019042510297100', '1', 'wys30204', 'wys30203');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room_user
-- ----------------------------
INSERT INTO `xq_chat_room_user` VALUES ('21', '17896861', '2019-04-25 00:30:22', '2019-04-25 00:31:06', 'R2019042510148489', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('22', '17896861', '2019-04-25 00:30:22', '2019-04-25 00:38:42', 'R2019042510148489', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('23', '17896861', '2019-04-25 00:30:22', '2019-04-25 00:31:06', 'R2019042510148489', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('24', '17896861', '2019-04-25 00:30:22', '2019-04-25 00:31:06', 'R2019042510148489', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('25', '17896861', '2019-04-25 00:53:05', '2019-04-25 00:53:58', 'R2019042549995649', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('26', '17896861', '2019-04-25 00:53:05', '2019-04-25 00:53:58', 'R2019042549995649', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('27', '17896861', '2019-04-25 00:53:05', '2019-04-25 00:53:59', 'R2019042549995649', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('28', '17896861', '2019-04-25 00:53:05', '2019-04-25 00:53:58', 'R2019042549995649', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('29', '17896861', '2019-04-25 00:56:09', null, 'R2019042557521005', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('30', '17896861', '2019-04-25 00:56:09', null, 'R2019042557521005', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('31', '17896861', '2019-04-25 00:56:09', null, 'R2019042557521005', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('32', '17896861', '2019-04-25 00:56:09', null, 'R2019042557521005', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('33', '15787656', '2019-04-25 01:05:19', '2019-04-25 01:07:52', 'R2019042510255989', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('34', '15787656', '2019-04-25 01:05:19', '2019-04-25 01:08:01', 'R2019042510255989', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('35', '15787656', '2019-04-25 01:05:19', '2019-04-25 01:08:03', 'R2019042510255989', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('36', '15787656', '2019-04-25 01:05:19', '2019-04-25 01:06:23', 'R2019042510255989', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('37', '15787656', '2019-04-25 01:11:37', '2019-04-25 01:20:34', 'R2019042557559756', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('38', '15787656', '2019-04-25 01:11:37', '2019-04-25 01:20:28', 'R2019042557559756', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('39', '15787656', '2019-04-25 01:11:37', '2019-04-25 01:20:44', 'R2019042557559756', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('40', '15787656', '2019-04-25 01:11:37', '2019-04-25 01:12:52', 'R2019042557559756', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('41', '15787704', '2019-04-25 01:24:49', '2019-04-25 01:26:41', 'R2019042549971029', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('42', '15787704', '2019-04-25 01:24:49', '2019-04-25 01:26:45', 'R2019042549971029', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('43', '15787704', '2019-04-25 01:24:49', '2019-04-25 01:26:40', 'R2019042549971029', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('44', '15787704', '2019-04-25 01:24:49', '2019-04-25 01:25:50', 'R2019042549971029', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('45', '17897007', '2019-04-25 01:27:55', '2019-04-25 01:30:02', 'R2019042598999954', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('46', '17897007', '2019-04-25 01:27:55', '2019-04-25 01:29:12', 'R2019042598999954', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('47', '17897007', '2019-04-25 01:27:55', '2019-04-25 01:30:07', 'R2019042598999954', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('48', '17897007', '2019-04-25 01:27:55', '2019-04-25 01:29:12', 'R2019042598999954', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('49', '17897025', '2019-04-25 01:31:47', '2019-04-25 01:37:10', 'R2019042551505399', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('50', '17897025', '2019-04-25 01:31:47', '2019-04-25 01:37:04', 'R2019042551505399', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('51', '17897025', '2019-04-25 01:31:47', '2019-04-25 01:37:14', 'R2019042551505399', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('52', '17897025', '2019-04-25 01:31:47', '2019-04-25 01:32:45', 'R2019042551505399', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('53', '17897053', '2019-04-25 01:40:27', null, 'R2019042598100995', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('54', '17897053', '2019-04-25 01:40:27', null, 'R2019042598100995', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('55', '17897053', '2019-04-25 01:40:27', null, 'R2019042598100995', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('56', '17897053', '2019-04-25 01:40:27', null, 'R2019042598100995', '1', 'wys30201');
INSERT INTO `xq_chat_room_user` VALUES ('57', '15787778', '2019-04-25 01:42:55', '2019-04-25 01:45:52', 'R2019042510297100', '1', 'wys30204');
INSERT INTO `xq_chat_room_user` VALUES ('58', '15787778', '2019-04-25 01:42:55', '2019-04-25 01:45:53', 'R2019042510297100', '1', 'wys30203');
INSERT INTO `xq_chat_room_user` VALUES ('59', '15787778', '2019-04-25 01:42:55', '2019-04-25 01:43:52', 'R2019042510297100', '1', 'wys30202');
INSERT INTO `xq_chat_room_user` VALUES ('60', '15787778', '2019-04-25 01:42:55', '2019-04-25 01:43:52', 'R2019042510297100', '1', 'wys30201');

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
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='用户进出聊天室表';

-- ----------------------------
-- Records of xq_chat_user
-- ----------------------------
INSERT INTO `xq_chat_user` VALUES ('72', '17896861', 'wys30201', '2019-04-25 00:30:02', '2019-04-25 00:56:41', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('73', '17896861', 'wys30204', '2019-04-25 00:30:06', '2019-04-25 00:56:57', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('74', '17896861', 'wys30202', '2019-04-25 00:30:09', '2019-04-25 00:31:07', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('75', '17896861', 'wys30203', '2019-04-25 00:30:14', '2019-04-25 00:56:50', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('76', '17896861', 'wys30202', '2019-04-25 00:50:25', '2019-04-25 00:53:59', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('77', '17896861', 'wys30202', '2019-04-25 00:55:49', '2019-04-25 00:56:46', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('78', '15787656', 'wys30201', '2019-04-25 01:02:37', '2019-04-25 01:20:23', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('79', '15787656', 'wys30202', '2019-04-25 01:03:08', '2019-04-25 01:07:52', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('80', '15787656', 'wys30204', '2019-04-25 01:03:41', '2019-04-25 01:08:01', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('81', '15787656', 'wys30203', '2019-04-25 01:05:11', '2019-04-25 01:08:03', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('82', '15787656', 'wys30202', '2019-04-25 01:08:08', '2019-04-25 01:20:34', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('83', '15787656', 'wys30204', '2019-04-25 01:11:16', '2019-04-25 01:20:28', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('84', '15787656', 'wys30203', '2019-04-25 01:11:19', '2019-04-25 01:20:44', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('85', '15787704', 'wys30201', '2019-04-25 01:23:10', '2019-04-25 01:26:35', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('86', '15787704', 'wys30203', '2019-04-25 01:23:16', '2019-04-25 01:26:41', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('87', '15787704', 'wys30204', '2019-04-25 01:23:20', '2019-04-25 01:26:45', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('88', '15787704', 'wys30202', '2019-04-25 01:24:24', '2019-04-25 01:26:40', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('89', '17897007', 'wys30201', '2019-04-25 01:27:28', '2019-04-25 01:29:53', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('90', '17897007', 'wys30204', '2019-04-25 01:27:42', '2019-04-25 01:30:02', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('91', '17897007', 'wys30202', '2019-04-25 01:27:44', '2019-04-25 01:31:12', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('92', '17897007', 'wys30203', '2019-04-25 01:27:45', '2019-04-25 01:30:07', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('93', '17897025', 'wys30201', '2019-04-25 01:31:32', '2019-04-25 01:36:51', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('94', '17897025', 'wys30202', '2019-04-25 01:31:36', '2019-04-25 01:37:10', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('95', '17897025', 'wys30204', '2019-04-25 01:31:37', '2019-04-25 01:37:04', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('96', '17897025', 'wys30203', '2019-04-25 01:31:39', '2019-04-25 01:37:14', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('97', '17897053', 'wys30201', '2019-04-25 01:38:03', '2019-04-25 01:41:32', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('98', '17897053', 'wys30204', '2019-04-25 01:38:06', '2019-04-25 01:41:35', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('99', '17897053', 'wys30203', '2019-04-25 01:38:10', '2019-04-25 01:41:36', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('100', '17897053', 'wys30202', '2019-04-25 01:39:57', '2019-04-25 01:41:37', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('101', '17897065', 'wys30201', '2019-04-25 01:41:44', '2019-04-25 01:42:04', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('102', '17897065', 'wys30204', '2019-04-25 01:41:47', '2019-04-25 01:42:12', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('103', '17897065', 'wys30203', '2019-04-25 01:41:53', '2019-04-25 01:42:16', '1', '0', '2');
INSERT INTO `xq_chat_user` VALUES ('104', '15787778', 'wys30201', '2019-04-25 01:42:33', null, '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('105', '15787778', 'wys30204', '2019-04-25 01:42:37', '2019-04-25 01:45:52', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('106', '15787778', 'wys30203', '2019-04-25 01:42:45', '2019-04-25 01:45:53', '1', '1', '2');
INSERT INTO `xq_chat_user` VALUES ('107', '15787778', 'wys30202', '2019-04-25 01:42:50', null, '1', '1', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8 COMMENT='金币消费记录';

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `gift_id` (`gift_id`),
  UNIQUE KEY `gift_id_2` (`gift_id`),
  UNIQUE KEY `gift_id_3` (`gift_id`),
  UNIQUE KEY `gift_id_4` (`gift_id`),
  UNIQUE KEY `gift_id_5` (`gift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_item
-- ----------------------------
INSERT INTO `xq_gift_item` VALUES ('1', '1', '1', '玫瑰', '2', '0', '/thinkphp/image/rose.png', '赠人玫瑰，手留余香', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('2', '1', '2', '爱心', '2', '0', '/thinkphp/image/love.png', '给你的爱滔滔不绝', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('3', '1', '3', '白开水', '2', '0', '/thinkphp/image/bottle.png', '平平淡淡', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('4', '2', '4', '入门券', '50', '20', '/thinkphp/image/card_enter_room.png', '用于免费进入房间一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('5', '1', '5', '礼品券', '2', '0', '/thinkphp/image/card_gift.png', '可兑换2钻石的礼物，只能兑换一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('6', '2', '6', '建房卡（1天）', '100', '24', '/thinkphp/image/card_jianfang.png', '可用于1天免费建房', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('7', '2', '7', '延时卡', '300', '30', '/thinkphp/image/card_yanshi.png', '在房间中当自己发言时，使用后可增加30s的发言时间', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('8', '100', '1000', '创建房间', '2', '', '', null, null);
INSERT INTO `xq_gift_item` VALUES ('9', '100', '1001', '加入房间', '1', '', '', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='用来记录卡的使用期限';

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('17', 'wys30201', '1', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('18', 'wys30201', '3', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('19', 'wys30201', '4', '3', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('20', 'wys30201', '6', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('22', 'wys30201', '6', '7', '-1', '2019-04-10 21:59:22', '2019-04-11 21:59:22', '2');
INSERT INTO `xq_gift_user` VALUES ('23', 'wys30201', '2', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('24', 'wys30201', '5', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('27', 'wys30201', '6', '6', '-1', '2019-04-11 23:51:04', '2019-04-12 23:51:04', '2');
INSERT INTO `xq_gift_user` VALUES ('28', 'wys30202', '4', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('29', 'wys30202', '4', '4', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('30', 'wys30201', '6', '5', '-1', '2019-04-13 11:11:05', '2019-04-14 11:11:05', '2');
INSERT INTO `xq_gift_user` VALUES ('31', 'wys30201', '6', '4', '-1', '2019-04-18 23:51:57', '2019-04-19 23:51:57', '2');
INSERT INTO `xq_gift_user` VALUES ('32', 'wys30202', '4', '3', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('33', 'wys30201', '6', '3', '-1', '2019-04-20 14:54:19', '2019-04-21 14:54:19', '2');
INSERT INTO `xq_gift_user` VALUES ('34', 'wys30202', '4', '2', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('35', 'wys30201', '6', '2', '-1', '2019-04-23 21:31:37', '2019-04-24 21:31:37', '2');
INSERT INTO `xq_gift_user` VALUES ('36', 'wys30203', '4', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('37', 'wys30203', '4', '2', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('38', 'wys30203', '4', '1', '1', null, null, '1');
INSERT INTO `xq_gift_user` VALUES ('39', 'wys30204', '4', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('40', 'wys30204', '4', '1', '1', null, null, '1');
INSERT INTO `xq_gift_user` VALUES ('41', 'wys30201', '6', '1', '-1', '2019-04-24 21:52:39', '2019-04-25 21:52:39', '1');
INSERT INTO `xq_gift_user` VALUES ('42', 'wys30202', '4', '1', '6', null, null, '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COMMENT='用户列表';

-- ----------------------------
-- Records of xq_user
-- ----------------------------
INSERT INTO `xq_user` VALUES ('1', 'wys30201', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 19:36:04', '2019-01-14 22:05:13');
INSERT INTO `xq_user` VALUES ('2', 'aaa', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 22:24:02', '2019-01-15 00:21:07');
INSERT INTO `xq_user` VALUES ('10', 'wys30202', 'a3104028f10587ab4891049563ddddb9', '2018-05-16 23:58:46', '2019-01-13 12:46:30');
INSERT INTO `xq_user` VALUES ('12', 'wys30203', 'a3104028f10587ab4891049563ddddb9', '2018-05-30 23:31:16', '2019-01-13 12:46:27');
INSERT INTO `xq_user` VALUES ('15', 'wys30204', 'a3104028f10587ab4891049563ddddb9', '2018-05-31 21:28:30', '2019-01-13 12:46:23');
INSERT INTO `xq_user` VALUES ('16', 'wys30205', 'a3104028f10587ab4891049563ddddb9', '2018-12-16 13:36:00', '2019-01-13 12:46:20');
INSERT INTO `xq_user` VALUES ('17', 'wys30211', 'a3104028f10587ab4891049563ddddb9', '2019-04-20 02:57:28', '2019-04-20 02:57:28');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='用户详情列表';

-- ----------------------------
-- Records of xq_user_info
-- ----------------------------
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', 'wys30201', '男', 'angel', '0', '2124', '26', '172', '博士及以上', 'IT工程师', '湖南', '1', '深圳市南山区', '', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2019-04-08 21:47:20', '2019-04-24 20:46:42', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', 'guest', '0', '382', '23', '170', '博士及以上', 'IT', '广东', '1', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2019-04-15 21:54:59', '');
INSERT INTO `xq_user_info` VALUES ('5', '12', 'wys30203', 'wys30203', '女', 'guest', '0', '200', '22', '158', '硕士', '销售', '湖北', '1', '武汉', '', '/thinkphp/upload/XQ/IMG_20190112162444_308.jpg', '2018-05-30 23:31:29', '2019-04-24 20:47:08', '');
INSERT INTO `xq_user_info` VALUES ('6', '15', 'wys30204', 'wys30204', '男', 'guest', '0', '550', '27', '183', '博士', '工程经理', '湖南', '1', '南山科技园', '', '/thinkphp/upload/XQ/IMG_20180617104128_144.jpg', '2018-05-31 21:37:17', '2019-04-24 21:03:38', '新高浮雕升高个');
INSERT INTO `xq_user_info` VALUES ('7', '16', 'wys30205', 'wys30205', '男', 'angel', '0', '96', '28', '170', '硕士', '及', '湖南', '1', '上海', '', '/thinkphp/upload/XQ/IMG_20190419225458_846.jpg', '2018-12-16 14:02:16', '2019-04-19 22:57:08', '理想随风');
INSERT INTO `xq_user_info` VALUES ('8', '17', 'wys30210', '心莹', '女', 'guest', '0', '100', '33', '162', '硕士', '教师', '广东', '2', '深圳', '', '/thinkphp/upload/XQ/IMG_20190419223229_752.jpg', '2019-04-19 22:23:30', '2019-04-19 22:32:32', '我的阅历足够美');

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
INSERT INTO `xq_version` VALUES ('1', '1', 'V1.0.2', '1.V2版震撼来袭，功能强大，链式编程，调用简单，集成轻松，扩展性强大\\n2.老规矩先看V2效果，这个版本最大的特点就是使用非常简单，相对于1.+版本\\n3.更强大的自定义界面支持\\n4.compile \'com.allenliu.versionchecklib:library:2.0.0\'\\n5.该模式最简单的使用', 'http://test-1251233192.coscd.myqcloud.com/1_1.apk', '2019-04-13 01:58:35', '0');
