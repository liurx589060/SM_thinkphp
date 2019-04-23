/*
Navicat MySQL Data Transfer

Source Server         : xq_app
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-04-23 18:38:56
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='聊天室创建和删除记录表';

-- ----------------------------
-- Records of xq_chat
-- ----------------------------
INSERT INTO `xq_chat` VALUES ('10', '15749994', '一起来相亲吧', '', 'wys30201', null, '2019-04-19 01:13:03', '1', '-1', '2019-04-19 01:15:00', '-1', '1', '2', '1', '0', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('11', '17859297', '一起来相亲吧', '', 'wys30201', null, '2019-04-19 01:16:16', '1', '-1', '2019-04-19 01:16:00', '-1', '1', '2', '1', '0', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('12', '17859303', '一起来相亲吧', '', 'wys30201', null, '2019-04-19 01:18:41', '1', '0', '2019-04-19 01:20:00', '-1', '1', '2', '1', '0', '0', '0', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('13', '17863265', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 12:54:36', '1', '-1', '2019-04-20 03:47:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMzIuMTMyL2xpdmUvc3RyZWFtMQ==\n', 'cnRtcDovLzE5Mi4xNjguMzIuMTMyL2xpdmUvc3RyZWFtMQ==\n');
INSERT INTO `xq_chat` VALUES ('15', '15759390', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 14:49:53', '1', '0', '2019-04-20 23:55:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('16', '17869119', '灌灌灌灌', '', 'wys30201', null, '2019-04-20 14:57:12', '1', '0', '2019-04-20 23:54:00', '-1', '1', '10', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('17', '17869145', '点十分惹人', '', 'wys30201', null, '2019-04-20 15:04:31', '1', '0', '2019-04-20 23:59:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('18', '15759916', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 15:33:06', '1', '0', '2019-04-20 23:59:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('19', '15759932', '善良的非凡哥', '', 'wys30201', null, '2019-04-20 15:44:36', '1', '0', '2019-04-20 23:59:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('20', '15759946', '啊啊啊啊啊啊啊啊啊啊啊啊', '', 'wys30201', null, '2019-04-20 15:51:06', '1', '0', '2019-04-20 22:50:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('22', '17869251', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 15:56:46', '1', '0', '2019-04-20 23:56:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('23', '17869261', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 15:58:56', '1', '0', '2019-04-20 22:58:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('24', '15759974', '一起来相亲吧', '', 'wys30201', null, '2019-04-20 16:14:16', '1', '0', '2019-04-20 23:59:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('25', '15760024', '一起来相亲吧', '', 'wys30201', null, '2019-04-21 12:30:26', '1', '0', '2019-04-21 08:59:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0x\n');
INSERT INTO `xq_chat` VALUES ('26', '15764624', '一起来相亲吧', '', 'wys30201', null, '2019-04-21 19:20:12', '1', '0', '2019-04-21 19:20:00', '-1', '1', '2', '1', '1', '0', '-2', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('27', '15765868', '一起来相亲吧', '', 'wys30201', null, '2019-04-21 20:33:53', '1', '0', '2019-04-21 20:35:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('28', '15766132', '一起来相亲吧', '', 'wys30201', null, '2019-04-21 20:49:09', '1', '0', '2019-04-21 20:55:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');
INSERT INTO `xq_chat` VALUES ('29', '17875491', '一起来相亲吧', '', 'wys30201', null, '2019-04-21 20:57:15', '1', '0', '2019-04-21 20:56:00', '-1', '1', '2', '1', '1', '0', '-1', '2', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n', 'cnRtcDovLzE5Mi4xNjguMS4xMDIvbGl2ZS9zdHJlYW0xX3d5czMwMjAx\n');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room
-- ----------------------------

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基于聊天室创建的匹配房间';

-- ----------------------------
-- Records of xq_chat_room_user
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 COMMENT='用户进出聊天室表';

-- ----------------------------
-- Records of xq_chat_user
-- ----------------------------
INSERT INTO `xq_chat_user` VALUES ('145', '15749994', 'wys30201', '2019-04-19 01:12:48', null, '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('146', '17859297', 'wys30201', '2019-04-19 01:15:55', null, '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('147', '17859303', 'wys30201', '2019-04-19 01:18:09', '2019-04-19 01:18:41', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('148', '17863265', 'wys30201', '2019-04-19 15:44:38', '2019-04-20 12:54:36', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('149', '17863265', 'wys30202', '2019-04-19 16:23:36', '2019-04-19 16:35:20', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('150', '17863265', 'wys30202', '2019-04-19 16:28:44', '2019-04-19 16:35:20', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('151', '17863265', 'wys30202', '2019-04-19 16:33:11', '2019-04-19 16:35:20', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('152', '17863265', 'wys30202', '2019-04-19 16:33:51', '2019-04-19 16:35:20', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('158', '17863265', 'wys30202', '2019-04-19 16:57:30', '2019-04-19 23:27:39', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('160', '17863265', 'wys30202', '2019-04-19 23:29:03', '2019-04-19 23:53:54', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('161', '17863265', 'wys30202', '2019-04-19 23:58:34', '2019-04-19 23:59:12', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('162', '17863265', 'wys30202', '2019-04-19 23:59:41', '2019-04-19 23:59:56', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('163', '17863265', 'wys30202', '2019-04-20 00:07:38', '2019-04-20 00:08:19', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('164', '17863265', 'wys30202', '2019-04-20 00:08:25', '2019-04-20 00:08:32', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('167', '17863265', 'wys30202', '2019-04-20 00:18:00', '2019-04-20 00:20:31', '2', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('168', '17863265', 'wys30202', '2019-04-20 00:20:35', '2019-04-20 00:22:21', '2', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('175', '17863265', 'wys30202', '2019-04-20 00:37:46', '2019-04-20 00:38:41', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('176', '17863265', 'wys30202', '2019-04-20 00:38:47', '2019-04-20 00:39:16', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('177', '17863265', 'wys30202', '2019-04-20 00:39:31', '2019-04-20 00:39:41', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('178', '17863265', 'wys30202', '2019-04-20 00:39:45', '2019-04-20 00:40:00', '2', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('179', '17863265', 'wys30202', '2019-04-20 00:40:06', '2019-04-20 00:40:25', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('180', '17863265', 'wys30202', '2019-04-20 00:40:37', '2019-04-20 00:40:41', '2', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('181', '17863265', 'wys30202', '2019-04-20 00:40:47', '2019-04-20 02:29:02', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('182', '17863265', 'wys30202', '2019-04-20 02:56:52', '2019-04-20 02:58:27', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('183', '17863265', 'wys30202', '2019-04-20 03:02:32', '2019-04-20 03:06:15', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('184', '17863265', 'wys30202', '2019-04-20 03:06:45', '2019-04-20 03:06:50', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('185', '17863265', 'wys30202', '2019-04-20 03:08:40', '2019-04-20 03:09:35', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('186', '17863265', 'wys30202', '2019-04-20 03:10:18', '2019-04-20 03:12:59', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('187', '17863265', 'wys30202', '2019-04-20 03:13:15', '2019-04-20 03:13:41', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('188', '17863265', 'wys30202', '2019-04-20 03:15:00', '2019-04-20 03:15:08', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('189', '17863265', 'wys30202', '2019-04-20 03:18:20', '2019-04-20 03:18:30', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('190', '17863265', 'wys30202', '2019-04-20 03:18:38', '2019-04-20 03:18:45', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('191', '17863265', 'wys30202', '2019-04-20 03:18:53', '2019-04-20 03:18:58', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('192', '15759384', 'wys30201', '2019-04-20 12:55:55', null, '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('193', '15759390', 'wys30201', '2019-04-20 12:58:31', '2019-04-20 14:49:53', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('194', '15759390', 'wys30202', '2019-04-20 12:59:38', '2019-04-20 13:09:25', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('195', '15759390', 'wys30202', '2019-04-20 13:09:57', '2019-04-20 13:27:08', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('196', '15759390', 'wys30202', '2019-04-20 13:27:47', '2019-04-20 13:30:40', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('197', '15759390', 'wys30202', '2019-04-20 13:30:46', '2019-04-20 13:30:53', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('198', '15759390', 'wys30202', '2019-04-20 13:31:40', '2019-04-20 13:34:27', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('199', '15759390', 'wys30202', '2019-04-20 13:35:46', '2019-04-20 13:38:38', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('200', '15759390', 'wys30202', '2019-04-20 13:38:50', '2019-04-20 13:38:56', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('201', '15759390', 'wys30202', '2019-04-20 13:39:10', '2019-04-20 13:39:19', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('202', '15759390', 'wys30202', '2019-04-20 13:39:31', '2019-04-20 13:39:38', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('203', '15759390', 'wys30202', '2019-04-20 14:48:42', '2019-04-20 14:48:57', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('204', '15759390', 'wys30202', '2019-04-20 14:49:06', '2019-04-20 14:49:16', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('205', '17869119', 'wys30201', '2019-04-20 14:54:20', '2019-04-20 14:57:12', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('206', '17869119', 'wys30202', '2019-04-20 14:55:30', '2019-04-20 14:55:50', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('207', '17869119', 'wys30202', '2019-04-20 14:56:03', '2019-04-20 14:57:30', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('208', '17869145', 'wys30201', '2019-04-20 15:03:49', '2019-04-20 15:04:31', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('209', '17869145', 'wys30202', '2019-04-20 15:04:18', '2019-04-20 15:05:12', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('210', '15759916', 'wys30201', '2019-04-20 15:32:39', '2019-04-20 15:33:06', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('211', '15759916', 'wys30202', '2019-04-20 15:32:48', '2019-04-20 15:32:53', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('212', '15759916', 'wys30202', '2019-04-20 15:32:58', '2019-04-20 15:33:34', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('213', '15759932', 'wys30201', '2019-04-20 15:42:47', '2019-04-20 15:44:36', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('214', '15759932', 'wys30202', '2019-04-20 15:42:59', '2019-04-20 15:43:11', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('215', '15759932', 'wys30202', '2019-04-20 15:43:19', '2019-04-20 15:43:42', '2', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('216', '15759932', 'wys30202', '2019-04-20 15:43:47', '2019-04-20 15:49:02', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('217', '15759946', 'wys30201', '2019-04-20 15:50:09', '2019-04-20 15:51:06', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('218', '15759946', 'wys30202', '2019-04-20 15:50:53', '2019-04-20 15:54:03', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('220', '15759952', 'wys30202', '2019-04-20 15:54:28', '2019-04-20 15:54:59', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('221', '17869251', 'wys30201', '2019-04-20 15:56:25', '2019-04-20 15:56:46', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('222', '17869251', 'wys30202', '2019-04-20 15:56:29', '2019-04-20 15:58:12', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('223', '17869261', 'wys30201', '2019-04-20 15:58:32', '2019-04-20 15:58:56', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('224', '17869261', 'wys30202', '2019-04-20 15:58:36', '2019-04-20 15:58:43', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('225', '17869261', 'wys30202', '2019-04-20 15:58:51', '2019-04-20 15:59:02', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('226', '15759974', 'wys30201', '2019-04-20 15:59:10', '2019-04-20 16:14:16', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('227', '15759974', 'wys30202', '2019-04-20 15:59:14', '2019-04-20 16:01:35', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('228', '15759974', 'wys30202', '2019-04-20 16:02:49', '2019-04-20 16:04:02', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('229', '15759974', 'wys30202', '2019-04-20 16:04:13', '2019-04-20 16:14:32', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('230', '15760024', 'wys30201', '2019-04-20 16:15:41', '2019-04-21 12:30:26', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('231', '15760024', 'wys30202', '2019-04-20 16:15:45', '2019-04-20 23:48:43', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('232', '15760024', 'wys30202', '2019-04-20 23:49:02', '2019-04-20 23:55:49', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('233', '15760024', 'wys30202', '2019-04-20 23:55:53', '2019-04-21 12:30:24', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('234', '15764624', 'wys30201', '2019-04-21 12:30:46', '2019-04-21 19:20:10', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('235', '15764624', 'wys30202', '2019-04-21 12:30:51', '2019-04-21 19:20:20', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('236', '15765868', 'wys30201', '2019-04-21 19:27:24', '2019-04-21 20:33:47', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('237', '15765868', 'wys30202', '2019-04-21 19:27:31', '2019-04-21 20:33:22', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('238', '15766132', 'wys30201', '2019-04-21 20:34:17', '2019-04-21 20:49:09', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('239', '15766132', 'wys30202', '2019-04-21 20:34:20', '2019-04-21 20:50:11', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('240', '17875491', 'wys30201', '2019-04-21 20:52:30', '2019-04-21 20:57:15', '1', '0', '0');
INSERT INTO `xq_chat_user` VALUES ('241', '17875491', 'wys30202', '2019-04-21 20:52:40', '2019-04-21 20:57:18', '1', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8 COMMENT='金币消费记录';

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='用来记录卡的使用期限';

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('17', 'wys30201', '1', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('18', 'wys30201', '3', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('19', 'wys30201', '4', '2', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('20', 'wys30201', '6', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('22', 'wys30201', '6', '5', '-1', '2019-04-10 21:59:22', '2019-04-11 21:59:22', '2');
INSERT INTO `xq_gift_user` VALUES ('23', 'wys30201', '2', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('24', 'wys30201', '5', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('27', 'wys30201', '6', '4', '-1', '2019-04-11 23:51:04', '2019-04-12 23:51:04', '2');
INSERT INTO `xq_gift_user` VALUES ('28', 'wys30202', '4', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('29', 'wys30202', '4', '3', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('30', 'wys30201', '6', '3', '-1', '2019-04-13 11:11:05', '2019-04-14 11:11:05', '2');
INSERT INTO `xq_gift_user` VALUES ('31', 'wys30201', '6', '2', '-1', '2019-04-18 23:51:57', '2019-04-19 23:51:57', '2');
INSERT INTO `xq_gift_user` VALUES ('32', 'wys30202', '4', '2', '0', null, null, '2');
INSERT INTO `xq_gift_user` VALUES ('33', 'wys30201', '6', '1', '-1', '2019-04-20 14:54:19', '2019-04-21 14:54:19', '2');
INSERT INTO `xq_gift_user` VALUES ('34', 'wys30202', '4', '1', '5', null, null, '1');

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
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', '神龙', '男', 'angel', '0', '2374', '26', '172', '博士及以上', 'IT工程师', '湖南', '0', '深圳市南山区', '', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2019-04-08 21:47:20', '2019-04-08 22:22:40', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', 'guest', '0', '432', '23', '170', '博士及以上', 'IT', '广东', '1', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2019-04-15 21:54:59', '');
INSERT INTO `xq_user_info` VALUES ('5', '12', 'wys30203', '孤星', '女', 'guest', '0', '120', '22', '158', '硕士', '销售', '湖北', '0', '武汉', '', '/thinkphp/upload/XQ/IMG_20190112162444_308.jpg', '2018-05-30 23:31:29', '0000-00-00 00:00:00', '');
INSERT INTO `xq_user_info` VALUES ('6', '15', 'wys30204', '如风', '男', 'guest', '0', '0', '27', '183', '博士', '工程经理', '湖南', '0', '南山科技园', '', '/thinkphp/upload/XQ/IMG_20180617104128_144.jpg', '2018-05-31 21:37:17', '0000-00-00 00:00:00', '新高浮雕升高个');
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
