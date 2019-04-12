/*
Navicat MySQL Data Transfer

Source Server         : xq_app
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-04-12 18:42:13
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Table structure for `xq_chat_room`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat_room`;
CREATE TABLE `xq_chat_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(255) NOT NULL COMMENT '房间Id',
  `describe` varchar(2048) NOT NULL COMMENT '房间描述',
  `creater` varchar(255) NOT NULL COMMENT '创建者',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '解散时间',
  `public` int(11) NOT NULL DEFAULT '0' COMMENT '是否公开（0：私密   1：公开）',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '房间状态（0：未匹配成功  1：匹配成功）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_chat_room
-- ----------------------------
INSERT INTO `xq_chat_room` VALUES ('73', '15701162', '我的世界', 'wys30201', '2019-04-11 23:31:46', '2019-04-11 23:31:46', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('74', '15701180', '一起来相亲吧', 'wys30201', '2019-04-11 23:31:50', '2019-04-11 23:31:50', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('75', '15701190', '一起来相亲吧', 'wys30201', '2019-04-11 23:31:53', '2019-04-11 23:32:53', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('76', '17810473', 'KTV某YY', 'wys30201', '2019-04-11 23:33:52', '2019-04-11 23:33:59', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('77', '15701208', '路路欧总', 'wys30201', '2019-04-11 23:34:20', '2019-04-11 23:35:30', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('78', '17810497', '一起来相亲吧', 'wys30201', '2019-04-11 23:38:05', '2019-04-11 23:38:23', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('79', '17810499', '我的世界', 'wys30201', '2019-04-11 23:38:34', '2019-04-11 23:38:39', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('80', '17810507', '一起来相亲吧', 'wys30201', '2019-04-11 23:39:33', '2019-04-11 23:41:57', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('81', '17810519', '一起来相亲吧', 'wys30201', '2019-04-11 23:42:06', '2019-04-11 23:42:17', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('82', '15701258', '一起来相亲吧', 'wys30201', '2019-04-11 23:42:59', '2019-04-11 23:44:47', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('83', '15701294', '一起来相亲吧', 'wys30201', '2019-04-11 23:49:34', '2019-04-11 23:49:58', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('84', '15701304', '提兔兔我啦咯了', 'wys30201', '2019-04-11 23:51:05', '2019-04-11 23:51:25', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('85', '17810571', '芬恩噢噢噢哦哦', 'wys30201', '2019-04-11 23:51:41', '2019-04-11 23:52:02', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('86', '17810591', '来吧', 'wys30201', '2019-04-11 23:55:18', '2019-04-12 01:16:14', '1', '0');
INSERT INTO `xq_chat_room` VALUES ('87', '17810873', '一起来相亲吧', 'wys30201', '2019-04-12 01:39:48', '2019-04-12 01:44:07', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=394 DEFAULT CHARSET=utf8 COMMENT='金币消费记录';

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
INSERT INTO `xq_gift_item` VALUES ('4', '2', '4', '入门券', '50', '3', '/thinkphp/image/card_enter_room.png', '用于免费进入房间一次', '/thinkphp/image/gif_love.gif');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='用来记录卡的使用期限';

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('17', 'wys30201', '1', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('18', 'wys30201', '3', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('19', 'wys30201', '4', '2', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('20', 'wys30201', '6', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('21', 'wys30201', '4', '2', '3', null, null, '1');
INSERT INTO `xq_gift_user` VALUES ('22', 'wys30201', '6', '2', '-1', '2019-04-10 21:59:22', '2019-04-11 21:59:22', '2');
INSERT INTO `xq_gift_user` VALUES ('23', 'wys30201', '2', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('24', 'wys30201', '5', '1', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('27', 'wys30201', '6', '1', '-1', '2019-04-11 23:51:04', '2019-04-12 23:51:04', '1');
INSERT INTO `xq_gift_user` VALUES ('28', 'wys30202', '4', '0', '-1', null, null, '0');
INSERT INTO `xq_gift_user` VALUES ('29', 'wys30202', '4', '1', '0', null, null, '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for `xq_room_record`
-- ----------------------------
DROP TABLE IF EXISTS `xq_room_record`;
CREATE TABLE `xq_room_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL COMMENT '房间Id',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `status` int(11) NOT NULL COMMENT '房间状态（0：未匹配成功  1：匹配成功）',
  `enter_time` datetime NOT NULL COMMENT '进入时间',
  `exit_time` datetime DEFAULT NULL COMMENT '退出时间',
  `room_role_type` int(11) NOT NULL DEFAULT '0' COMMENT '进入房间的角色（2：围观者   1：参与者）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='用户进出房间表';

-- ----------------------------
-- Records of xq_room_record
-- ----------------------------
INSERT INTO `xq_room_record` VALUES ('114', '15701162', 'wys30201', '0', '2019-04-11 23:24:17', '2019-04-11 23:24:34', '1');
INSERT INTO `xq_room_record` VALUES ('115', '15701180', 'wys30201', '0', '2019-04-11 23:28:25', '2019-04-11 23:29:12', '1');
INSERT INTO `xq_room_record` VALUES ('116', '15701190', 'wys30201', '0', '2019-04-11 23:30:28', '2019-04-11 23:32:53', '1');
INSERT INTO `xq_room_record` VALUES ('117', '17810473', 'wys30201', '0', '2019-04-11 23:33:52', '2019-04-11 23:33:59', '1');
INSERT INTO `xq_room_record` VALUES ('118', '15701208', 'wys30201', '0', '2019-04-11 23:34:20', '2019-04-11 23:35:30', '1');
INSERT INTO `xq_room_record` VALUES ('119', '17810497', 'wys30201', '0', '2019-04-11 23:38:05', '2019-04-11 23:38:23', '1');
INSERT INTO `xq_room_record` VALUES ('120', '17810499', 'wys30201', '0', '2019-04-11 23:38:34', '2019-04-11 23:38:39', '1');
INSERT INTO `xq_room_record` VALUES ('121', '17810507', 'wys30201', '0', '2019-04-11 23:39:33', '2019-04-11 23:41:57', '1');
INSERT INTO `xq_room_record` VALUES ('122', '17810519', 'wys30201', '0', '2019-04-11 23:42:06', '2019-04-11 23:42:17', '1');
INSERT INTO `xq_room_record` VALUES ('123', '15701258', 'wys30201', '0', '2019-04-11 23:42:59', '2019-04-11 23:44:47', '1');
INSERT INTO `xq_room_record` VALUES ('124', '15701294', 'wys30201', '0', '2019-04-11 23:49:34', '2019-04-11 23:49:58', '1');
INSERT INTO `xq_room_record` VALUES ('125', '15701304', 'wys30201', '0', '2019-04-11 23:51:05', '2019-04-11 23:51:25', '1');
INSERT INTO `xq_room_record` VALUES ('126', '17810571', 'wys30201', '0', '2019-04-11 23:51:41', '2019-04-11 23:52:02', '1');
INSERT INTO `xq_room_record` VALUES ('127', '17810591', 'wys30201', '0', '2019-04-11 23:55:18', '2019-04-12 01:16:14', '1');
INSERT INTO `xq_room_record` VALUES ('128', '17810591', 'wys30202', '0', '2019-04-12 01:14:25', '2019-04-12 01:16:13', '1');
INSERT INTO `xq_room_record` VALUES ('129', '17810873', 'wys30201', '0', '2019-04-12 01:39:48', '2019-04-12 01:44:07', '1');
INSERT INTO `xq_room_record` VALUES ('130', '17810873', 'wys30202', '0', '2019-04-12 01:43:48', '2019-04-12 01:43:51', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='用户列表';

-- ----------------------------
-- Records of xq_user
-- ----------------------------
INSERT INTO `xq_user` VALUES ('1', 'wys30201', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 19:36:04', '2019-01-14 22:05:13');
INSERT INTO `xq_user` VALUES ('2', 'aaa', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 22:24:02', '2019-01-15 00:21:07');
INSERT INTO `xq_user` VALUES ('10', 'wys30202', 'a3104028f10587ab4891049563ddddb9', '2018-05-16 23:58:46', '2019-01-13 12:46:30');
INSERT INTO `xq_user` VALUES ('12', 'wys30203', 'a3104028f10587ab4891049563ddddb9', '2018-05-30 23:31:16', '2019-01-13 12:46:27');
INSERT INTO `xq_user` VALUES ('15', 'wys30204', 'a3104028f10587ab4891049563ddddb9', '2018-05-31 21:28:30', '2019-01-13 12:46:23');
INSERT INTO `xq_user` VALUES ('16', 'wys30205', 'a3104028f10587ab4891049563ddddb9', '2018-12-16 13:36:00', '2019-01-13 12:46:20');

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
  `role_type` varchar(255) CHARACTER SET utf8 NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='用户详情列表';

-- ----------------------------
-- Records of xq_user_info
-- ----------------------------
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', '神龙', '男', 'angel', '0', '2226', '26', '172', '博士及以上', 'IT工程师', '湖南', '0', '深圳市南山区', '', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2019-04-08 21:47:20', '2019-04-08 22:22:40', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', 'guest', '0', '71', '23', '170', '本科', 'IT', '广东', '0', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2019-04-08 22:10:22', '');
INSERT INTO `xq_user_info` VALUES ('5', '12', 'wys30203', '孤星', '女', 'guest', '0', '0', '22', '158', '硕士', '销售', '湖北', '0', '武汉', '', '/thinkphp/upload/XQ/IMG_20190112162444_308.jpg', '2018-05-30 23:31:29', '0000-00-00 00:00:00', '');
INSERT INTO `xq_user_info` VALUES ('6', '15', 'wys30204', '如风', '男', 'guest', '0', '0', '27', '183', '博士', '工程经理', '湖南', '0', '南山科技园', '', '/thinkphp/upload/XQ/IMG_20180617104128_144.jpg', '2018-05-31 21:37:17', '0000-00-00 00:00:00', '新高浮雕升高个');
INSERT INTO `xq_user_info` VALUES ('7', '16', 'wys30205', 'wys30205', '男', 'guest', '0', '0', '28', '170', '硕士', '及', '湖南', '0', '上海', '', '/thinkphp/upload/XQ/IMG_20181216140228_600.jpg', '2018-12-16 14:02:16', '0000-00-00 00:00:00', '理想随风');

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
