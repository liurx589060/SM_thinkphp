/*
Navicat MySQL Data Transfer

Source Server         : lrx
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-03-26 23:02:49
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
  `start_time` int(255) NOT NULL COMMENT '禁止开始时间',
  `end_time` int(255) NOT NULL COMMENT '禁止结束时间',
  `room_id` int(255) NOT NULL COMMENT '被举报时的房间号',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '是否禁止状态（1：禁止    0：解禁）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户举报';

-- ----------------------------
-- Records of xq_black_user
-- ----------------------------
INSERT INTO `xq_black_user` VALUES ('9', 'wys30201', '言语或视频违背伦理;', '1550321714', '1550419200', '15378694', '0');

-- ----------------------------
-- Table structure for `xq_chat_room`
-- ----------------------------
DROP TABLE IF EXISTS `xq_chat_room`;
CREATE TABLE `xq_chat_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(255) NOT NULL COMMENT '房间Id',
  `describe` varchar(2048) NOT NULL COMMENT '房间描述',
  `creater` varchar(255) NOT NULL COMMENT '创建者',
  `create_time` int(255) NOT NULL COMMENT '创建时间',
  `delete_time` int(255) NOT NULL COMMENT '解散时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '房间状态（0：未匹配成功  1：匹配成功）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_chat_room
-- ----------------------------
INSERT INTO `xq_chat_room` VALUES ('1', '15372498', '一起来相亲吧', 'wys30201', '1547306140', '1547306145', '0');
INSERT INTO `xq_chat_room` VALUES ('2', '15372510', '一起来相亲吧', 'wys30201', '1547311280', '1547311932', '0');
INSERT INTO `xq_chat_room` VALUES ('3', '12982611', '一起来相亲吧', 'wys30201', '1547354840', '1547354884', '0');
INSERT INTO `xq_chat_room` VALUES ('4', '15373930', '一起来相亲吧', 'wys30201', '1547354910', '1547357351', '0');
INSERT INTO `xq_chat_room` VALUES ('5', '12982621', '一起来相亲吧', 'wys30201', '1547357386', '1547358250', '0');
INSERT INTO `xq_chat_room` VALUES ('6', '15373976', '一起来相亲吧', 'wys30201', '1547359657', '1547359837', '1');
INSERT INTO `xq_chat_room` VALUES ('7', '15373984', '一起来相亲吧', 'wys30201', '1547360075', '1547360768', '0');
INSERT INTO `xq_chat_room` VALUES ('8', '12982677', '一起来相亲吧', 'wys30201', '1547360969', '1547361648', '0');
INSERT INTO `xq_chat_room` VALUES ('9', '12982751', '一起来相亲吧', 'wys30201', '1547372792', '1547373144', '0');
INSERT INTO `xq_chat_room` VALUES ('10', '12982757', '一起来相亲吧', 'wys30201', '1547373886', '1547374066', '0');
INSERT INTO `xq_chat_room` VALUES ('11', '15374180', '一起来相亲吧', 'wys30201', '1547386195', '1547386655', '0');
INSERT INTO `xq_chat_room` VALUES ('12', '15374190', '一起来相亲吧', 'wys30201', '1547386940', '1547389505', '0');
INSERT INTO `xq_chat_room` VALUES ('13', '15374216', '一起来相亲吧', 'wys30201', '1547389512', '1547389706', '0');
INSERT INTO `xq_chat_room` VALUES ('14', '12983623', '一起来相亲吧', 'wys30201', '1547479312', '1547479365', '0');
INSERT INTO `xq_chat_room` VALUES ('15', '12984619', '一起来相亲吧', 'wys30201', '1547562441', '1547562498', '0');
INSERT INTO `xq_chat_room` VALUES ('16', '15375938', '一起来相亲吧', 'wys30201', '1547562952', '1547562975', '0');
INSERT INTO `xq_chat_room` VALUES ('17', '12984621', '一起来相亲吧', 'wys30201', '1547563235', '1547563248', '0');
INSERT INTO `xq_chat_room` VALUES ('18', '15377214', '一起来相亲吧', 'wys30201', '1547644391', '1547644819', '0');
INSERT INTO `xq_chat_room` VALUES ('19', '15377222', '一起来相亲吧', 'wys30201', '1547644549', '1547644554', '0');
INSERT INTO `xq_chat_room` VALUES ('20', '12985903', '一起来相亲吧', 'wys30201', '1547644558', '1547644651', '0');
INSERT INTO `xq_chat_room` VALUES ('21', '15377230', '一起来相亲吧', 'wys30201', '1547644855', '1547645048', '0');
INSERT INTO `xq_chat_room` VALUES ('22', '15377240', '一起来相亲吧', 'wys30201', '1547645095', '1547645151', '0');
INSERT INTO `xq_chat_room` VALUES ('23', '12985919', '一起来相亲吧', 'wys30201', '1547645176', '0', '0');
INSERT INTO `xq_chat_room` VALUES ('24', '12985921', '一起来相亲吧', 'wys30201', '1547645176', '1547645194', '0');
INSERT INTO `xq_chat_room` VALUES ('25', '15377276', '一起来相亲吧', 'wys30201', '1547649467', '1547649480', '0');
INSERT INTO `xq_chat_room` VALUES ('26', '12985959', '一起来相亲吧', 'wys30201', '1547649571', '1547649618', '0');
INSERT INTO `xq_chat_room` VALUES ('27', '15377298', '一起来相亲吧', 'wys30201', '1547651097', '1547651100', '0');
INSERT INTO `xq_chat_room` VALUES ('28', '12985987', '一起来相亲吧', 'wys30201', '1547652835', '1547652854', '0');
INSERT INTO `xq_chat_room` VALUES ('29', '15378646', '一起来相亲吧', 'wys30201', '1547731202', '1547731205', '0');
INSERT INTO `xq_chat_room` VALUES ('30', '15378650', '一起来相亲吧', 'wys30201', '1547731836', '1547731838', '0');
INSERT INTO `xq_chat_room` VALUES ('31', '15378652', '一起来相亲吧', 'wys30201', '1547732065', '1547732463', '0');
INSERT INTO `xq_chat_room` VALUES ('32', '15378666', '一起来相亲吧', 'wys30201', '1547733161', '1547733169', '0');
INSERT INTO `xq_chat_room` VALUES ('33', '15378668', '一起来相亲吧', 'wys30201', '1547733215', '1547733262', '0');
INSERT INTO `xq_chat_room` VALUES ('34', '15378672', '一起来相亲吧', 'wys30201', '1547733296', '1547733368', '0');
INSERT INTO `xq_chat_room` VALUES ('35', '12987387', '一起来相亲吧', 'wys30201', '1547735292', '1547735384', '0');
INSERT INTO `xq_chat_room` VALUES ('36', '12987389', '一起来相亲吧', 'wys30201', '1547735430', '1547735442', '0');
INSERT INTO `xq_chat_room` VALUES ('37', '12987391', '一起来相亲吧', 'wys30201', '1547735516', '1547735527', '0');
INSERT INTO `xq_chat_room` VALUES ('38', '12987393', '一起来相亲吧', 'wys30201', '1547735819', '1547735871', '0');
INSERT INTO `xq_chat_room` VALUES ('39', '12987399', '一起来相亲吧', 'wys30201', '1547737074', '1547737099', '0');
INSERT INTO `xq_chat_room` VALUES ('40', '15378694', '一起来相亲吧', 'wys30201', '1547737484', '1547737537', '0');
INSERT INTO `xq_chat_room` VALUES ('41', '12988959', '一起来相亲吧', 'wys30201', '1547820891', '1547821037', '0');
INSERT INTO `xq_chat_room` VALUES ('42', '12988963', '一起来相亲吧', 'wys30201', '1547821214', '1547821996', '0');
INSERT INTO `xq_chat_room` VALUES ('43', '15380260', '一起来相亲吧', 'wys30201', '1547821440', '1547821478', '0');
INSERT INTO `xq_chat_room` VALUES ('44', '15380262', '一起来相亲吧', 'wys30201', '1547821704', '1547821754', '0');
INSERT INTO `xq_chat_room` VALUES ('45', '15395858', '一起来相亲吧', 'wys30201', '1548571602', '1548571608', '0');
INSERT INTO `xq_chat_room` VALUES ('46', '17504623', '一起来相亲吧', 'wys30201', '1548571669', '1548571771', '0');
INSERT INTO `xq_chat_room` VALUES ('47', '17504627', '一起来相亲吧', 'wys30201', '1548571894', '1548571897', '0');

-- ----------------------------
-- Table structure for `xq_coin_consume_history`
-- ----------------------------
DROP TABLE IF EXISTS `xq_coin_consume_history`;
CREATE TABLE `xq_coin_consume_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物自身id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户',
  `create_time` int(11) DEFAULT NULL COMMENT '购买时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_coin_consume_history
-- ----------------------------
INSERT INTO `xq_coin_consume_history` VALUES ('33', '4', 'wys30201', '1553263239');
INSERT INTO `xq_coin_consume_history` VALUES ('34', '1', 'wys30201', '1553263969');
INSERT INTO `xq_coin_consume_history` VALUES ('35', '2', 'wys30201', '1553263975');
INSERT INTO `xq_coin_consume_history` VALUES ('36', '2', 'wys30201', '1553264003');
INSERT INTO `xq_coin_consume_history` VALUES ('37', '1', 'wys30201', '1553264007');
INSERT INTO `xq_coin_consume_history` VALUES ('38', '2', 'wys30201', '1553264014');
INSERT INTO `xq_coin_consume_history` VALUES ('39', '2', 'wys30201', '1553264015');
INSERT INTO `xq_coin_consume_history` VALUES ('40', '2', 'wys30201', '1553264015');
INSERT INTO `xq_coin_consume_history` VALUES ('41', '2', 'wys30201', '1553264015');
INSERT INTO `xq_coin_consume_history` VALUES ('42', '2', 'wys30201', '1553264016');
INSERT INTO `xq_coin_consume_history` VALUES ('43', '2', 'wys30202', '1553264182');
INSERT INTO `xq_coin_consume_history` VALUES ('44', '2', 'wys30202', '1553264187');
INSERT INTO `xq_coin_consume_history` VALUES ('45', '2', 'wys30201', '1553264408');
INSERT INTO `xq_coin_consume_history` VALUES ('46', '1', 'wys30201', '1553264416');
INSERT INTO `xq_coin_consume_history` VALUES ('47', '4', 'wys30201', '1553264454');
INSERT INTO `xq_coin_consume_history` VALUES ('48', '5', 'wys30201', '1553264484');
INSERT INTO `xq_coin_consume_history` VALUES ('49', '7', 'wys30201', '1553265167');
INSERT INTO `xq_coin_consume_history` VALUES ('50', '7', 'wys30201', '1553266254');
INSERT INTO `xq_coin_consume_history` VALUES ('51', '2', 'wys30201', '1553266395');
INSERT INTO `xq_coin_consume_history` VALUES ('52', '2', 'wys30201', '1553266396');
INSERT INTO `xq_coin_consume_history` VALUES ('53', '5', 'wys30201', '1553267204');
INSERT INTO `xq_coin_consume_history` VALUES ('54', '6', 'wys30201', '1553267209');
INSERT INTO `xq_coin_consume_history` VALUES ('55', '5', 'wys30201', '1553280055');
INSERT INTO `xq_coin_consume_history` VALUES ('56', '2', 'wys30201', '1553280060');
INSERT INTO `xq_coin_consume_history` VALUES ('57', '6', 'wys30201', '1553280067');
INSERT INTO `xq_coin_consume_history` VALUES ('58', '1', 'wys30201', '1553317246');
INSERT INTO `xq_coin_consume_history` VALUES ('59', '1', 'wys30201', '1553317247');
INSERT INTO `xq_coin_consume_history` VALUES ('60', '1', 'wys30201', '1553317247');
INSERT INTO `xq_coin_consume_history` VALUES ('61', '1', 'wys30201', '1553317247');
INSERT INTO `xq_coin_consume_history` VALUES ('62', '1', 'wys30201', '1553317248');
INSERT INTO `xq_coin_consume_history` VALUES ('63', '1', 'wys30201', '1553317248');
INSERT INTO `xq_coin_consume_history` VALUES ('64', '1', 'wys30201', '1553317248');
INSERT INTO `xq_coin_consume_history` VALUES ('65', '1', 'wys30201', '1553317248');
INSERT INTO `xq_coin_consume_history` VALUES ('66', '1', 'wys30201', '1553317248');
INSERT INTO `xq_coin_consume_history` VALUES ('67', '5', 'wys30201', '1553317250');
INSERT INTO `xq_coin_consume_history` VALUES ('68', '5', 'wys30201', '1553317254');
INSERT INTO `xq_coin_consume_history` VALUES ('69', '6', 'wys30201', '1553317256');
INSERT INTO `xq_coin_consume_history` VALUES ('70', '6', 'wys30201', '1553317256');
INSERT INTO `xq_coin_consume_history` VALUES ('71', '6', 'wys30201', '1553317256');
INSERT INTO `xq_coin_consume_history` VALUES ('72', '6', 'wys30201', '1553317257');
INSERT INTO `xq_coin_consume_history` VALUES ('73', '3', 'wys30201', '1553321569');
INSERT INTO `xq_coin_consume_history` VALUES ('74', '7', 'wys30201', '1553321572');
INSERT INTO `xq_coin_consume_history` VALUES ('75', '2', 'wys30201', '1553321609');
INSERT INTO `xq_coin_consume_history` VALUES ('76', '2', 'wys30201', '1553321609');
INSERT INTO `xq_coin_consume_history` VALUES ('77', '2', 'wys30201', '1553321609');
INSERT INTO `xq_coin_consume_history` VALUES ('78', '2', 'wys30201', '1553321610');
INSERT INTO `xq_coin_consume_history` VALUES ('79', '2', 'wys30201', '1553321610');
INSERT INTO `xq_coin_consume_history` VALUES ('80', '2', 'wys30201', '1553321611');
INSERT INTO `xq_coin_consume_history` VALUES ('81', '2', 'wys30201', '1553321611');
INSERT INTO `xq_coin_consume_history` VALUES ('82', '2', 'wys30201', '1553321612');
INSERT INTO `xq_coin_consume_history` VALUES ('83', '2', 'wys30201', '1553321612');
INSERT INTO `xq_coin_consume_history` VALUES ('84', '2', 'wys30201', '1553321612');
INSERT INTO `xq_coin_consume_history` VALUES ('85', '3', 'wys30201', '1553321886');
INSERT INTO `xq_coin_consume_history` VALUES ('86', '3', 'wys30201', '1553321887');
INSERT INTO `xq_coin_consume_history` VALUES ('87', '3', 'wys30201', '1553321887');
INSERT INTO `xq_coin_consume_history` VALUES ('88', '3', 'wys30201', '1553321887');
INSERT INTO `xq_coin_consume_history` VALUES ('89', '3', 'wys30201', '1553321888');
INSERT INTO `xq_coin_consume_history` VALUES ('90', '3', 'wys30201', '1553321888');
INSERT INTO `xq_coin_consume_history` VALUES ('91', '3', 'wys30201', '1553321902');
INSERT INTO `xq_coin_consume_history` VALUES ('92', '2', 'wys30201', '1553322175');
INSERT INTO `xq_coin_consume_history` VALUES ('93', '2', 'wys30201', '1553322175');
INSERT INTO `xq_coin_consume_history` VALUES ('94', '2', 'wys30201', '1553322175');
INSERT INTO `xq_coin_consume_history` VALUES ('95', '2', 'wys30201', '1553322177');
INSERT INTO `xq_coin_consume_history` VALUES ('96', '2', 'wys30201', '1553322177');
INSERT INTO `xq_coin_consume_history` VALUES ('97', '3', 'wys30201', '1553322177');
INSERT INTO `xq_coin_consume_history` VALUES ('98', '1', 'wys30201', '1553322179');
INSERT INTO `xq_coin_consume_history` VALUES ('99', '2', 'wys30201', '1553322209');
INSERT INTO `xq_coin_consume_history` VALUES ('100', '2', 'wys30201', '1553322209');
INSERT INTO `xq_coin_consume_history` VALUES ('101', '1', 'wys30201', '1553322210');
INSERT INTO `xq_coin_consume_history` VALUES ('102', '1', 'wys30201', '1553322210');
INSERT INTO `xq_coin_consume_history` VALUES ('103', '3', 'wys30201', '1553322212');
INSERT INTO `xq_coin_consume_history` VALUES ('104', '3', 'wys30201', '1553322212');
INSERT INTO `xq_coin_consume_history` VALUES ('105', '1', 'wys30201', '1553325092');
INSERT INTO `xq_coin_consume_history` VALUES ('106', '1', 'wys30201', '1553325093');
INSERT INTO `xq_coin_consume_history` VALUES ('107', '1', 'wys30201', '1553325093');
INSERT INTO `xq_coin_consume_history` VALUES ('108', '1', 'wys30201', '1553325094');
INSERT INTO `xq_coin_consume_history` VALUES ('109', '1', 'wys30201', '1553325094');
INSERT INTO `xq_coin_consume_history` VALUES ('110', '1', 'wys30201', '1553325094');
INSERT INTO `xq_coin_consume_history` VALUES ('111', '1', 'wys30201', '1553325095');
INSERT INTO `xq_coin_consume_history` VALUES ('112', '1', 'wys30201', '1553325095');
INSERT INTO `xq_coin_consume_history` VALUES ('113', '1', 'wys30201', '1553325096');
INSERT INTO `xq_coin_consume_history` VALUES ('114', '1', 'wys30201', '1553325096');
INSERT INTO `xq_coin_consume_history` VALUES ('115', '2', 'wys30201', '1553325099');
INSERT INTO `xq_coin_consume_history` VALUES ('116', '1', 'wys30201', '1553325100');
INSERT INTO `xq_coin_consume_history` VALUES ('117', '7', 'wys30201', '1553328113');
INSERT INTO `xq_coin_consume_history` VALUES ('118', '7', 'wys30201', '1553328114');
INSERT INTO `xq_coin_consume_history` VALUES ('119', '7', 'wys30201', '1553328114');
INSERT INTO `xq_coin_consume_history` VALUES ('120', '3', 'wys30201', '1553333611');
INSERT INTO `xq_coin_consume_history` VALUES ('121', '6', 'wys30201', '1553333752');

-- ----------------------------
-- Table structure for `xq_gift_item`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_item`;
CREATE TABLE `xq_gift_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` int(11) NOT NULL COMMENT '类型（1：礼品   2：卡券）',
  `sort` int(11) NOT NULL COMMENT '次序',
  `gift_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '礼品名称',
  `coin` int(11) NOT NULL COMMENT '需要的coin',
  `is_show` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示（1：显示   0：不显示）',
  `is_trade` int(11) NOT NULL DEFAULT '1' COMMENT '是否可交易（1：可交易    0：不可交易）',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_item
-- ----------------------------
INSERT INTO `xq_gift_item` VALUES ('1', '1', '1', '1', '玫瑰', '2', '1', '1', '/thinkphp/image/rose.png', '赠人玫瑰，手留余香');
INSERT INTO `xq_gift_item` VALUES ('2', '1', '2', '2', '爱心', '2', '1', '1', '/thinkphp/image/love.png', '给你的爱滔滔不绝');
INSERT INTO `xq_gift_item` VALUES ('3', '1', '3', '3', '白开水', '2', '1', '1', '/thinkphp/image/bottle.png', '平平淡淡');
INSERT INTO `xq_gift_item` VALUES ('4', '1', '4', '4', '入门券', '50', '1', '1', '/thinkphp/image/card_enter_room.png', '用于免费进入房间一次');
INSERT INTO `xq_gift_item` VALUES ('5', '1', '5', '5', '礼品券', '2', '1', '1', '/thinkphp/image/card_gift.png', '可兑换2钻石的礼物，只能兑换一次');
INSERT INTO `xq_gift_item` VALUES ('6', '2', '6', '6', '建房卡（1天）', '100', '1', '1', '/thinkphp/image/card_jianfang.png', '可用于1天免费建房');
INSERT INTO `xq_gift_item` VALUES ('7', '2', '7', '7', '延时卡', '300', '1', '1', '/thinkphp/image/card_yanshi.png', '在房间中当自己发言时，使用后可增加30s的发言时间');

-- ----------------------------
-- Table structure for `xq_gift_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_user`;
CREATE TABLE `xq_gift_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物自身id（同表xq_gift_item对应）',
  `user_name` varchar(255) DEFAULT NULL,
  `to_user` varchar(255) DEFAULT NULL COMMENT '来自用户名',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('1', '1', 'wys30201', 'wys30201', '1553317247');
INSERT INTO `xq_gift_user` VALUES ('2', '1', 'wys30201', 'wys30201', '1553317247');
INSERT INTO `xq_gift_user` VALUES ('3', '1', 'wys30201', 'wys30201', '1553317248');
INSERT INTO `xq_gift_user` VALUES ('4', '1', 'wys30201', 'wys30201', '1553317248');
INSERT INTO `xq_gift_user` VALUES ('5', '1', 'wys30201', 'wys30201', '1553317249');
INSERT INTO `xq_gift_user` VALUES ('6', '1', 'wys30201', 'wys30201', '1553317249');
INSERT INTO `xq_gift_user` VALUES ('7', '1', 'wys30201', 'wys30201', '1553317249');
INSERT INTO `xq_gift_user` VALUES ('8', '1', 'wys30201', 'wys30201', '1553317249');
INSERT INTO `xq_gift_user` VALUES ('9', '1', 'wys30201', 'wys30201', '1553317249');
INSERT INTO `xq_gift_user` VALUES ('10', '5', 'wys30201', 'wys30201', '1553317251');
INSERT INTO `xq_gift_user` VALUES ('11', '5', 'wys30201', 'wys30201', '1553317254');
INSERT INTO `xq_gift_user` VALUES ('12', '6', 'wys30201', 'wys30201', '1553317256');
INSERT INTO `xq_gift_user` VALUES ('13', '6', 'wys30201', 'wys30201', '1553317256');
INSERT INTO `xq_gift_user` VALUES ('14', '6', 'wys30201', 'wys30201', '1553317257');
INSERT INTO `xq_gift_user` VALUES ('15', '6', 'wys30201', 'wys30201', '1553317257');
INSERT INTO `xq_gift_user` VALUES ('16', '3', 'wys30201', 'wys30201', '1553321569');
INSERT INTO `xq_gift_user` VALUES ('17', '7', 'wys30201', 'wys30201', '1553321573');
INSERT INTO `xq_gift_user` VALUES ('18', '2', 'wys30201', 'wys30201', '1553321610');
INSERT INTO `xq_gift_user` VALUES ('19', '2', 'wys30201', 'wys30201', '1553321610');
INSERT INTO `xq_gift_user` VALUES ('20', '2', 'wys30201', 'wys30201', '1553321611');
INSERT INTO `xq_gift_user` VALUES ('21', '2', 'wys30201', 'wys30201', '1553321611');
INSERT INTO `xq_gift_user` VALUES ('22', '2', 'wys30201', 'wys30201', '1553321611');
INSERT INTO `xq_gift_user` VALUES ('23', '2', 'wys30201', 'wys30201', '1553321611');
INSERT INTO `xq_gift_user` VALUES ('24', '2', 'wys30201', 'wys30201', '1553321612');
INSERT INTO `xq_gift_user` VALUES ('25', '2', 'wys30201', 'wys30201', '1553321612');
INSERT INTO `xq_gift_user` VALUES ('26', '2', 'wys30201', 'wys30201', '1553321612');
INSERT INTO `xq_gift_user` VALUES ('27', '2', 'wys30201', 'wys30201', '1553321613');
INSERT INTO `xq_gift_user` VALUES ('28', '3', 'wys30201', 'wys30201', '1553321887');
INSERT INTO `xq_gift_user` VALUES ('29', '3', 'wys30201', 'wys30201', '1553321888');
INSERT INTO `xq_gift_user` VALUES ('30', '3', 'wys30201', 'wys30201', '1553321888');
INSERT INTO `xq_gift_user` VALUES ('31', '3', 'wys30201', 'wys30201', '1553321888');
INSERT INTO `xq_gift_user` VALUES ('32', '3', 'wys30201', 'wys30201', '1553321888');
INSERT INTO `xq_gift_user` VALUES ('33', '3', 'wys30201', 'wys30201', '1553321889');
INSERT INTO `xq_gift_user` VALUES ('34', '3', 'wys30201', 'wys30201', '1553321902');
INSERT INTO `xq_gift_user` VALUES ('35', '2', 'wys30201', 'wys30201', '1553322175');
INSERT INTO `xq_gift_user` VALUES ('36', '2', 'wys30201', 'wys30201', '1553322176');
INSERT INTO `xq_gift_user` VALUES ('37', '2', 'wys30201', 'wys30201', '1553322178');
INSERT INTO `xq_gift_user` VALUES ('38', '3', 'wys30201', 'wys30201', '1553322178');
INSERT INTO `xq_gift_user` VALUES ('39', '2', 'wys30201', 'wys30201', '1553322178');
INSERT INTO `xq_gift_user` VALUES ('40', '2', 'wys30201', 'wys30201', '1553322178');
INSERT INTO `xq_gift_user` VALUES ('41', '1', 'wys30201', 'wys30201', '1553322179');
INSERT INTO `xq_gift_user` VALUES ('42', '2', 'wys30201', 'wys30201', '1553322209');
INSERT INTO `xq_gift_user` VALUES ('43', '2', 'wys30201', 'wys30201', '1553322209');
INSERT INTO `xq_gift_user` VALUES ('44', '1', 'wys30201', 'wys30201', '1553322210');
INSERT INTO `xq_gift_user` VALUES ('45', '1', 'wys30201', 'wys30201', '1553322211');
INSERT INTO `xq_gift_user` VALUES ('46', '3', 'wys30201', 'wys30201', '1553322212');
INSERT INTO `xq_gift_user` VALUES ('47', '3', 'wys30201', 'wys30201', '1553322213');
INSERT INTO `xq_gift_user` VALUES ('48', '1', 'wys30201', 'wys30201', '1553325094');
INSERT INTO `xq_gift_user` VALUES ('49', '1', 'wys30201', 'wys30201', '1553325094');
INSERT INTO `xq_gift_user` VALUES ('50', '1', 'wys30201', 'wys30201', '1553325094');
INSERT INTO `xq_gift_user` VALUES ('51', '1', 'wys30201', 'wys30201', '1553325094');
INSERT INTO `xq_gift_user` VALUES ('52', '1', 'wys30201', 'wys30201', '1553325095');
INSERT INTO `xq_gift_user` VALUES ('53', '1', 'wys30201', 'wys30201', '1553325095');
INSERT INTO `xq_gift_user` VALUES ('54', '1', 'wys30201', 'wys30201', '1553325095');
INSERT INTO `xq_gift_user` VALUES ('55', '1', 'wys30201', 'wys30201', '1553325096');
INSERT INTO `xq_gift_user` VALUES ('56', '1', 'wys30201', 'wys30201', '1553325096');
INSERT INTO `xq_gift_user` VALUES ('57', '1', 'wys30201', 'wys30201', '1553325097');
INSERT INTO `xq_gift_user` VALUES ('58', '2', 'wys30201', 'wys30201', '1553325099');
INSERT INTO `xq_gift_user` VALUES ('59', '1', 'wys30201', 'wys30201', '1553325100');
INSERT INTO `xq_gift_user` VALUES ('60', '7', 'wys30201', 'wys30201', '1553328114');
INSERT INTO `xq_gift_user` VALUES ('61', '7', 'wys30201', 'wys30201', '1553328114');
INSERT INTO `xq_gift_user` VALUES ('62', '7', 'wys30201', 'wys30201', '1553328115');
INSERT INTO `xq_gift_user` VALUES ('63', '3', 'wys30201', 'wys30201', '1553333611');
INSERT INTO `xq_gift_user` VALUES ('64', '6', 'wys30201', 'wys30201', '1553333752');

-- ----------------------------
-- Table structure for `xq_pay_item`
-- ----------------------------
DROP TABLE IF EXISTS `xq_pay_item`;
CREATE TABLE `xq_pay_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '钻石数',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '人民币',
  `bonus` int(11) NOT NULL DEFAULT '0' COMMENT '额外奖励',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '次序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_pay_item
-- ----------------------------
INSERT INTO `xq_pay_item` VALUES ('1', '60', '6', '0', '1');
INSERT INTO `xq_pay_item` VALUES ('2', '300', '30', '0', '3');
INSERT INTO `xq_pay_item` VALUES ('3', '980', '98', '0', '4');
INSERT INTO `xq_pay_item` VALUES ('4', '1980', '198', '0', '5');
INSERT INTO `xq_pay_item` VALUES ('5', '100', '10', '0', '2');

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
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '支付状态（0：未处理   1：支付成功  2:补单）',
  `create_time` bigint(20) DEFAULT NULL COMMENT '生产时间',
  `modify_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_pay_order
-- ----------------------------
INSERT INTO `xq_pay_order` VALUES ('2', 'O2019031997100495', '2019032055974954', '1', 'wys30201', '60', '6', '1', '1553004490', '1553093591');
INSERT INTO `xq_pay_order` VALUES ('3', 'O2019031997101555', '2019031910152515', '1', 'wys30201', '60', '6', '1', '1553004554', '1553011054');
INSERT INTO `xq_pay_order` VALUES ('4', 'O2019031952101499', '2019032155491005', '1', 'wys30201', '60', '6', '1', '1553004788', '1553098999');
INSERT INTO `xq_pay_order` VALUES ('5', 'O2019032349985498', '2019032356514898', '1', 'wys30201', '60', '6', '1', '1553325809', '1553325896');
INSERT INTO `xq_pay_order` VALUES ('6', 'O2019032353509954', '2019032354102515', '1', 'wys30201', '60', '6', '1', '1553325829', '1553325958');
INSERT INTO `xq_pay_order` VALUES ('7', 'O2019032350515350', '2019032355100495', '1', 'wys30201', '60', '6', '1', '1553325986', '1553325991');
INSERT INTO `xq_pay_order` VALUES ('8', 'O2019032357554852', '2019032351101101', '1', 'wys30201', '60', '6', '1', '1553327433', '1553327523');
INSERT INTO `xq_pay_order` VALUES ('9', 'O2019032349565450', '2019032350485751', '1', 'wys30201', '60', '6', '1', '1553327537', '1553327538');
INSERT INTO `xq_pay_order` VALUES ('10', 'O2019032350985455', '2019032350101985', '1', 'wys30201', '60', '6', '1', '1553327570', '1553327570');
INSERT INTO `xq_pay_order` VALUES ('11', 'O2019032397531021', '2019032397575052', '1', 'wys30201', '100', '10', '1', '1553327578', '1553327578');
INSERT INTO `xq_pay_order` VALUES ('12', 'O2019032353555551', '2019032353985698', '1', 'wys30201', '1980', '198', '1', '1553327589', '1553327589');
INSERT INTO `xq_pay_order` VALUES ('13', 'O2019032352535051', '2019032352565753', '1', 'wys30201', '60', '6', '1', '1553333588', '1553333588');
INSERT INTO `xq_pay_order` VALUES ('14', 'O2019032398501005', '2019032398554910', '1', 'wys30201', '60', '6', '1', '1553333595', '1553333595');
INSERT INTO `xq_pay_order` VALUES ('15', 'O2019032598529957', '2019032599555399', '1', 'wys30201', '60', '6', '1', '1553522747', '1553522748');
INSERT INTO `xq_pay_order` VALUES ('16', 'O2019032551100505', '2019032552495710', '1', 'wys30201', '60', '6', '1', '1553523267', '1553523268');
INSERT INTO `xq_pay_order` VALUES ('17', 'O2019032557541005', '2019032557975153', '1', 'wys30201', '60', '6', '1', '1553523577', '1553523577');
INSERT INTO `xq_pay_order` VALUES ('18', 'O2019032551495457', '2019032551525697', '1', 'wys30201', '100', '10', '1', '1553525043', '1553525043');
INSERT INTO `xq_pay_order` VALUES ('19', 'O2019032553525249', '2019032553555457', '1', 'wys30201', '60', '6', '1', '1553525061', '1553525061');
INSERT INTO `xq_pay_order` VALUES ('20', 'O2019032553511015', '2019032553555554', '1', 'wys30201', '60', '6', '1', '1553525189', '1553525189');
INSERT INTO `xq_pay_order` VALUES ('21', 'O2019032556481021', '2019032556511001', '1', 'wys30201', '1980', '198', '1', '1553525720', '1553525720');
INSERT INTO `xq_pay_order` VALUES ('22', 'O2019032550525599', '2019032550575752', '1', 'wys30201', '60', '6', '1', '1553526530', '1553526530');

-- ----------------------------
-- Table structure for `xq_room_record`
-- ----------------------------
DROP TABLE IF EXISTS `xq_room_record`;
CREATE TABLE `xq_room_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL COMMENT '房间Id',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `status` int(11) NOT NULL COMMENT '房间状态（0：未匹配成功  1：匹配成功）',
  `enter_time` int(11) NOT NULL COMMENT '进入时间',
  `exit_time` int(11) NOT NULL COMMENT '退出时间',
  `room_role_type` int(11) NOT NULL DEFAULT '0' COMMENT '进入房间的角色（2：围观者   1：参与者）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='用户进出房间表';

-- ----------------------------
-- Records of xq_room_record
-- ----------------------------
INSERT INTO `xq_room_record` VALUES ('1', '15372510', 'wys30203', '0', '1547311283', '1547311894', '1');
INSERT INTO `xq_room_record` VALUES ('2', '15372510', 'wys30202', '0', '1547311290', '0', '1');
INSERT INTO `xq_room_record` VALUES ('3', '15372510', 'wys30204', '0', '1547311294', '1547311894', '1');
INSERT INTO `xq_room_record` VALUES ('4', '12982611', 'wys30203', '0', '1547354848', '0', '1');
INSERT INTO `xq_room_record` VALUES ('5', '12982611', 'wys30202', '0', '1547354851', '0', '1');
INSERT INTO `xq_room_record` VALUES ('6', '12982611', 'wys30204', '0', '1547354856', '0', '1');
INSERT INTO `xq_room_record` VALUES ('7', '15373930', 'wys30202', '0', '1547354914', '0', '1');
INSERT INTO `xq_room_record` VALUES ('8', '15373930', 'wys30203', '0', '1547354918', '0', '1');
INSERT INTO `xq_room_record` VALUES ('9', '15373930', 'wys30204', '0', '1547354921', '0', '1');
INSERT INTO `xq_room_record` VALUES ('10', '12982621', 'wys30202', '0', '1547357393', '0', '1');
INSERT INTO `xq_room_record` VALUES ('11', '12982621', 'wys30203', '0', '1547357490', '0', '1');
INSERT INTO `xq_room_record` VALUES ('12', '12982621', 'wys30204', '0', '1547357495', '0', '1');
INSERT INTO `xq_room_record` VALUES ('13', '15373976', 'wys30203', '0', '1547359661', '0', '1');
INSERT INTO `xq_room_record` VALUES ('14', '15373976', 'wys30202', '0', '1547359665', '0', '1');
INSERT INTO `xq_room_record` VALUES ('15', '15373976', 'wys30204', '0', '1547359671', '0', '1');
INSERT INTO `xq_room_record` VALUES ('16', '15373984', 'wys30203', '0', '1547360081', '0', '1');
INSERT INTO `xq_room_record` VALUES ('17', '15373984', 'wys30202', '0', '1547360088', '0', '1');
INSERT INTO `xq_room_record` VALUES ('18', '15373984', 'wys30204', '0', '1547360091', '0', '1');
INSERT INTO `xq_room_record` VALUES ('19', '12982677', 'wys30203', '0', '1547360977', '0', '1');
INSERT INTO `xq_room_record` VALUES ('20', '12982677', 'wys30202', '0', '1547360992', '0', '1');
INSERT INTO `xq_room_record` VALUES ('21', '12982677', 'wys30204', '0', '1547360998', '0', '1');
INSERT INTO `xq_room_record` VALUES ('22', '12982751', 'wys30203', '0', '1547372796', '0', '1');
INSERT INTO `xq_room_record` VALUES ('23', '12982751', 'wys30202', '0', '1547372800', '0', '1');
INSERT INTO `xq_room_record` VALUES ('24', '12982751', 'wys30204', '0', '1547372803', '0', '1');
INSERT INTO `xq_room_record` VALUES ('25', '12982757', 'wys30202', '0', '1547373890', '0', '1');
INSERT INTO `xq_room_record` VALUES ('26', '12982757', 'wys30203', '0', '1547373892', '0', '1');
INSERT INTO `xq_room_record` VALUES ('27', '12982757', 'wys30204', '0', '1547373897', '0', '1');
INSERT INTO `xq_room_record` VALUES ('28', '15374180', 'wys30203', '0', '1547386202', '0', '1');
INSERT INTO `xq_room_record` VALUES ('29', '15374180', 'wys30202', '0', '1547386207', '0', '1');
INSERT INTO `xq_room_record` VALUES ('30', '15374180', 'wys30204', '0', '1547386212', '0', '1');
INSERT INTO `xq_room_record` VALUES ('31', '15374190', 'wys30202', '0', '1547386946', '0', '1');
INSERT INTO `xq_room_record` VALUES ('32', '15374190', 'wys30203', '0', '1547386977', '0', '1');
INSERT INTO `xq_room_record` VALUES ('33', '15374190', 'wys30204', '0', '1547386980', '0', '1');
INSERT INTO `xq_room_record` VALUES ('34', '15374216', 'wys30202', '0', '1547389515', '0', '1');
INSERT INTO `xq_room_record` VALUES ('35', '15374216', 'wys30203', '0', '1547389519', '1547389617', '1');
INSERT INTO `xq_room_record` VALUES ('36', '15374216', 'wys30204', '0', '1547389522', '1547389617', '1');
INSERT INTO `xq_room_record` VALUES ('37', '12983623', 'wys30201', '0', '1547479312', '1547479366', '1');
INSERT INTO `xq_room_record` VALUES ('38', '12984619', 'wys30201', '0', '1547562441', '1547562500', '1');
INSERT INTO `xq_room_record` VALUES ('39', '15375938', 'wys30201', '0', '1547562953', '1547562975', '1');
INSERT INTO `xq_room_record` VALUES ('40', '12984621', 'wys30201', '0', '1547563235', '1547563248', '1');
INSERT INTO `xq_room_record` VALUES ('41', '15377214', 'wys30201', '0', '1547644391', '1547644819', '1');
INSERT INTO `xq_room_record` VALUES ('42', '15377222', 'wys30201', '0', '1547644549', '1547644554', '1');
INSERT INTO `xq_room_record` VALUES ('43', '12985903', 'wys30201', '0', '1547644558', '1547644651', '1');
INSERT INTO `xq_room_record` VALUES ('44', '15377230', 'wys30201', '0', '1547644855', '1547645049', '1');
INSERT INTO `xq_room_record` VALUES ('45', '15377240', 'wys30201', '0', '1547645095', '1547645151', '1');
INSERT INTO `xq_room_record` VALUES ('46', '12985919', 'wys30201', '0', '1547645177', '0', '1');
INSERT INTO `xq_room_record` VALUES ('47', '12985921', 'wys30201', '0', '1547645177', '1547645194', '1');
INSERT INTO `xq_room_record` VALUES ('48', '15377276', 'wys30201', '0', '1547649467', '1547649481', '1');
INSERT INTO `xq_room_record` VALUES ('49', '12985959', 'wys30201', '0', '1547649571', '1547649619', '1');
INSERT INTO `xq_room_record` VALUES ('50', '15377298', 'wys30201', '0', '1547651098', '1547651100', '1');
INSERT INTO `xq_room_record` VALUES ('51', '12985987', 'wys30201', '0', '1547652835', '1547652854', '1');
INSERT INTO `xq_room_record` VALUES ('52', '15378646', 'wys30201', '0', '1547731202', '1547731205', '1');
INSERT INTO `xq_room_record` VALUES ('53', '15378650', 'wys30201', '0', '1547731836', '1547731838', '1');
INSERT INTO `xq_room_record` VALUES ('54', '15378652', 'wys30201', '0', '1547732065', '1547732463', '1');
INSERT INTO `xq_room_record` VALUES ('55', '15378666', 'wys30201', '0', '1547733161', '1547733169', '1');
INSERT INTO `xq_room_record` VALUES ('56', '15378668', 'wys30201', '0', '1547733215', '1547733263', '1');
INSERT INTO `xq_room_record` VALUES ('57', '15378672', 'wys30201', '0', '1547733296', '1547733368', '1');
INSERT INTO `xq_room_record` VALUES ('58', '12987387', 'wys30201', '0', '1547735293', '1547735384', '1');
INSERT INTO `xq_room_record` VALUES ('59', '12987389', 'wys30201', '0', '1547735430', '1547735443', '1');
INSERT INTO `xq_room_record` VALUES ('60', '12987391', 'wys30201', '0', '1547735518', '1547735527', '1');
INSERT INTO `xq_room_record` VALUES ('61', '12987393', 'wys30201', '0', '1547735819', '1547735871', '1');
INSERT INTO `xq_room_record` VALUES ('62', '12987399', 'wys30201', '0', '1547737075', '1547737099', '1');
INSERT INTO `xq_room_record` VALUES ('63', '15378694', 'wys30201', '0', '1547737484', '1547737537', '1');
INSERT INTO `xq_room_record` VALUES ('64', '12988959', 'wys30201', '0', '1547820891', '1547821038', '1');
INSERT INTO `xq_room_record` VALUES ('65', '12988963', 'wys30201', '0', '1547821214', '1547821996', '1');
INSERT INTO `xq_room_record` VALUES ('66', '15380260', 'wys30201', '0', '1547821440', '1547821478', '1');
INSERT INTO `xq_room_record` VALUES ('67', '15380262', 'wys30201', '0', '1547821705', '1547821754', '1');
INSERT INTO `xq_room_record` VALUES ('68', '15395858', 'wys30201', '0', '1548571603', '1548571609', '1');
INSERT INTO `xq_room_record` VALUES ('69', '17504623', 'wys30201', '0', '1548571670', '1548571772', '1');
INSERT INTO `xq_room_record` VALUES ('70', '17504627', 'wys30201', '0', '1548571894', '1548571897', '1');

-- ----------------------------
-- Table structure for `xq_user`
-- ----------------------------
DROP TABLE IF EXISTS `xq_user`;
CREATE TABLE `xq_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户Id',
  `user_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `create_time` varchar(255) CHARACTER SET utf8 NOT NULL,
  `modify_time` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='用户列表';

-- ----------------------------
-- Records of xq_user
-- ----------------------------
INSERT INTO `xq_user` VALUES ('1', 'wys30201', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 19:36:04', '2019-01-14 22:05:13');
INSERT INTO `xq_user` VALUES ('2', 'aaa', 'a3104028f10587ab4891049563ddddb9', '2018-05-14 22:24:02', '2019-01-15 0:21:07');
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
  `time` varchar(20) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户好友';

-- ----------------------------
-- Records of xq_user_friend
-- ----------------------------
INSERT INTO `xq_user_friend` VALUES ('14', 'wys30201', 'wys30204', '124587', '2019-01-21 22:47');
INSERT INTO `xq_user_friend` VALUES ('15', 'wys30201', 'wys30203', '124587', '2019-01-23 0:17:');
INSERT INTO `xq_user_friend` VALUES ('16', 'wys30204', 'wys30201', '124587', '2019-01-31 0:10:13');
INSERT INTO `xq_user_friend` VALUES ('17', 'wys30203', 'wys30201', '124587', '2019-01-31 0:12:16');

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
  `create_time` varchar(255) CHARACTER SET utf8 NOT NULL,
  `modify_time` varchar(255) CHARACTER SET utf8 NOT NULL,
  `special_info` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='用户详情列表';

-- ----------------------------
-- Records of xq_user_info
-- ----------------------------
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', '神龙', '男', 'angel', '0', '4571', '26', '172', '博士及以上', 'IT工程师', '湖南', '0', '深圳市南山区', '', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2018-05-15 21:57:43', '2018-12-02 0:49:11', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', 'guest', '0', '-4', '23', '170', '本科', 'IT', '广东', '0', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2018-08-03 23:57:16', '');
INSERT INTO `xq_user_info` VALUES ('5', '12', 'wys30203', '孤星', '女', 'guest', '0', '0', '22', '158', '硕士', '销售', '湖北', '0', '武汉', '', '/thinkphp/upload/XQ/IMG_20190112162444_308.jpg', '2018-05-30 23:31:29', '2019-01-13 0:24:46', '');
INSERT INTO `xq_user_info` VALUES ('6', '15', 'wys30204', '如风', '男', 'guest', '0', '0', '27', '183', '博士', '工程经理', '湖南', '0', '南山科技园', '', '/thinkphp/upload/XQ/IMG_20180617104128_144.jpg', '2018-05-31 21:37:17', '2018-12-01 22:27:14', '新高浮雕升高个');
INSERT INTO `xq_user_info` VALUES ('7', '16', 'wys30205', 'wys30205', '男', 'guest', '0', '0', '28', '170', '硕士', '及', '湖南', '0', '上海', '', '/thinkphp/upload/XQ/IMG_20181216140228_600.jpg', '2018-12-16 14:02:16', '2018-12-16 14:03:34', '理想随风');

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
  `time` int(255) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='用户举报';

-- ----------------------------
-- Records of xq_user_report
-- ----------------------------
INSERT INTO `xq_user_report` VALUES ('31', 'wys30201', '3', '', '15378694', '1547737490');
INSERT INTO `xq_user_report` VALUES ('32', 'wys30201', '3', '', '15378694', '1547737494');
INSERT INTO `xq_user_report` VALUES ('33', 'wys30201', '3', 'Vddf', '15378694', '1547737504');
INSERT INTO `xq_user_report` VALUES ('34', 'wys30201', '3', '111111', '15378694', '1547737515');
