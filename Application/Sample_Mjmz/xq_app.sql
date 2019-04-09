/*
Navicat MySQL Data Transfer

Source Server         : xq
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : xq_app

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-04-03 22:48:56
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

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
INSERT INTO `xq_chat_room` VALUES ('48', '17741211', '一起来相亲吧', 'wys30201', '1554129881', '1554129913', '0');
INSERT INTO `xq_chat_room` VALUES ('49', '17741219', '一起来相亲吧', 'wys30201', '1554130045', '1554130136', '0');
INSERT INTO `xq_chat_room` VALUES ('50', '17741233', '一起来相亲吧', 'wys30201', '1554130285', '1554130383', '0');
INSERT INTO `xq_chat_room` VALUES ('51', '17741259', '一起来相亲吧', 'wys30201', '1554130583', '1554130970', '0');
INSERT INTO `xq_chat_room` VALUES ('52', '17741297', '一起来相亲吧', 'wys30201', '1554131194', '1554131288', '0');
INSERT INTO `xq_chat_room` VALUES ('53', '17741305', '一起来相亲吧', 'wys30201', '1554131330', '1554131393', '0');
INSERT INTO `xq_chat_room` VALUES ('54', '17741321', '一起来相亲吧', 'wys30201', '1554131567', '1554131849', '0');
INSERT INTO `xq_chat_room` VALUES ('55', '17741361', '一起来相亲吧', 'wys30201', '1554132336', '1554132584', '0');
INSERT INTO `xq_chat_room` VALUES ('56', '17741367', '一起来相亲吧', 'wys30201', '1554132393', '1554132592', '0');
INSERT INTO `xq_chat_room` VALUES ('57', '15632592', '一起来相亲吧', 'wys30201', '1554132662', '1554132722', '0');
INSERT INTO `xq_chat_room` VALUES ('58', '17741395', '一起来相亲吧', 'wys30201', '1554132839', '1554132997', '0');
INSERT INTO `xq_chat_room` VALUES ('59', '15632614', '一起来相亲吧', 'wys30201', '1554133048', '1554133079', '0');
INSERT INTO `xq_chat_room` VALUES ('60', '15632618', '一起来相亲吧', 'wys30201', '1554133090', '1554133095', '0');
INSERT INTO `xq_chat_room` VALUES ('61', '15632626', '一起来相亲吧', 'wys30201', '1554133166', '1554133203', '0');
INSERT INTO `xq_chat_room` VALUES ('62', '17741471', '一起来相亲吧', 'wys30201', '1554133989', '1554134058', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8 COMMENT='金币消费记录';

-- ----------------------------
-- Records of xq_coin_consume_history
-- ----------------------------
INSERT INTO `xq_coin_consume_history` VALUES ('185', '1', 'wys30201', '1554020270');
INSERT INTO `xq_coin_consume_history` VALUES ('186', '3', 'wys30201', '1554020271');
INSERT INTO `xq_coin_consume_history` VALUES ('187', '2', 'wys30201', '1554020272');
INSERT INTO `xq_coin_consume_history` VALUES ('188', '2', 'wys30201', '1554020380');
INSERT INTO `xq_coin_consume_history` VALUES ('189', '3', 'wys30201', '1554020382');
INSERT INTO `xq_coin_consume_history` VALUES ('190', '1', 'wys30201', '1554020383');
INSERT INTO `xq_coin_consume_history` VALUES ('191', '2', 'wys30201', '1554020386');
INSERT INTO `xq_coin_consume_history` VALUES ('192', '2', 'wys30201', '1554020387');
INSERT INTO `xq_coin_consume_history` VALUES ('193', '4', 'wys30201', '1554020679');
INSERT INTO `xq_coin_consume_history` VALUES ('194', '1', 'wys30201', '1554020920');
INSERT INTO `xq_coin_consume_history` VALUES ('195', '2', 'wys30201', '1554021152');
INSERT INTO `xq_coin_consume_history` VALUES ('196', '2', 'wys30201', '1554021509');
INSERT INTO `xq_coin_consume_history` VALUES ('197', '2', 'wys30201', '1554021550');
INSERT INTO `xq_coin_consume_history` VALUES ('198', '1', 'wys30201', '1554021567');
INSERT INTO `xq_coin_consume_history` VALUES ('199', '7', 'wys30201', '1554032855');
INSERT INTO `xq_coin_consume_history` VALUES ('200', '1', 'wys30201', '1554034299');
INSERT INTO `xq_coin_consume_history` VALUES ('201', '1', 'wys30201', '1554034302');
INSERT INTO `xq_coin_consume_history` VALUES ('202', '7', 'wys30201', '1554034343');
INSERT INTO `xq_coin_consume_history` VALUES ('203', '3', 'wys30201', '1554036168');
INSERT INTO `xq_coin_consume_history` VALUES ('204', '1', 'wys30201', '1554039673');
INSERT INTO `xq_coin_consume_history` VALUES ('205', '1', 'wys30201', '1554039790');
INSERT INTO `xq_coin_consume_history` VALUES ('206', '1', 'wys30201', '1554039880');
INSERT INTO `xq_coin_consume_history` VALUES ('207', '1', 'wys30201', '1554039979');
INSERT INTO `xq_coin_consume_history` VALUES ('208', '1', 'wys30201', '1554040054');
INSERT INTO `xq_coin_consume_history` VALUES ('209', '1', 'wys30201', '1554040425');
INSERT INTO `xq_coin_consume_history` VALUES ('210', '1', 'wys30201', '1554040433');
INSERT INTO `xq_coin_consume_history` VALUES ('211', '3', 'wys30201', '1554040438');
INSERT INTO `xq_coin_consume_history` VALUES ('212', '1', 'wys30201', '1554040503');
INSERT INTO `xq_coin_consume_history` VALUES ('213', '1', 'wys30201', '1554040598');
INSERT INTO `xq_coin_consume_history` VALUES ('214', '3', 'wys30201', '1554040611');
INSERT INTO `xq_coin_consume_history` VALUES ('215', '3', 'wys30201', '1554040628');
INSERT INTO `xq_coin_consume_history` VALUES ('216', '1', 'wys30201', '1554040716');
INSERT INTO `xq_coin_consume_history` VALUES ('217', '1', 'wys30201', '1554040873');
INSERT INTO `xq_coin_consume_history` VALUES ('218', '1', 'wys30201', '1554040964');
INSERT INTO `xq_coin_consume_history` VALUES ('219', '3', 'wys30201', '1554041226');
INSERT INTO `xq_coin_consume_history` VALUES ('220', '2', 'wys30201', '1554041232');
INSERT INTO `xq_coin_consume_history` VALUES ('221', '3', 'wys30201', '1554041539');
INSERT INTO `xq_coin_consume_history` VALUES ('222', '3', 'wys30201', '1554041569');
INSERT INTO `xq_coin_consume_history` VALUES ('223', '1', 'wys30201', '1554041581');
INSERT INTO `xq_coin_consume_history` VALUES ('224', '3', 'wys30201', '1554041694');
INSERT INTO `xq_coin_consume_history` VALUES ('225', '2', 'wys30201', '1554041718');
INSERT INTO `xq_coin_consume_history` VALUES ('226', '3', 'wys30201', '1554042187');
INSERT INTO `xq_coin_consume_history` VALUES ('227', '2', 'wys30201', '1554042194');
INSERT INTO `xq_coin_consume_history` VALUES ('228', '3', 'wys30201', '1554044039');
INSERT INTO `xq_coin_consume_history` VALUES ('229', '3', 'wys30201', '1554044053');
INSERT INTO `xq_coin_consume_history` VALUES ('230', '3', 'wys30201', '1554044053');
INSERT INTO `xq_coin_consume_history` VALUES ('231', '3', 'wys30201', '1554044069');
INSERT INTO `xq_coin_consume_history` VALUES ('232', '3', 'wys30201', '1554044073');
INSERT INTO `xq_coin_consume_history` VALUES ('233', '3', 'wys30201', '1554044089');
INSERT INTO `xq_coin_consume_history` VALUES ('234', '3', 'wys30201', '1554044667');
INSERT INTO `xq_coin_consume_history` VALUES ('235', '3', 'wys30201', '1554044751');
INSERT INTO `xq_coin_consume_history` VALUES ('236', '3', 'wys30201', '1554044760');
INSERT INTO `xq_coin_consume_history` VALUES ('237', '3', 'wys30201', '1554044765');
INSERT INTO `xq_coin_consume_history` VALUES ('238', '3', 'wys30201', '1554044800');
INSERT INTO `xq_coin_consume_history` VALUES ('239', '1', 'wys30201', '1554044816');
INSERT INTO `xq_coin_consume_history` VALUES ('240', '1', 'wys30201', '1554044816');
INSERT INTO `xq_coin_consume_history` VALUES ('241', '1', 'wys30201', '1554044817');
INSERT INTO `xq_coin_consume_history` VALUES ('242', '1', 'wys30201', '1554044820');
INSERT INTO `xq_coin_consume_history` VALUES ('243', '1', 'wys30201', '1554044820');
INSERT INTO `xq_coin_consume_history` VALUES ('244', '1', 'wys30201', '1554044821');
INSERT INTO `xq_coin_consume_history` VALUES ('245', '1', 'wys30201', '1554044821');
INSERT INTO `xq_coin_consume_history` VALUES ('246', '1', 'wys30201', '1554044824');
INSERT INTO `xq_coin_consume_history` VALUES ('247', '1', 'wys30201', '1554044828');
INSERT INTO `xq_coin_consume_history` VALUES ('248', '1', 'wys30201', '1554044832');
INSERT INTO `xq_coin_consume_history` VALUES ('249', '1', 'wys30201', '1554044836');
INSERT INTO `xq_coin_consume_history` VALUES ('250', '1', 'wys30201', '1554044840');
INSERT INTO `xq_coin_consume_history` VALUES ('251', '1', 'wys30201', '1554044843');
INSERT INTO `xq_coin_consume_history` VALUES ('252', '1', 'wys30201', '1554044848');
INSERT INTO `xq_coin_consume_history` VALUES ('253', '1', 'wys30201', '1554044851');
INSERT INTO `xq_coin_consume_history` VALUES ('254', '1', 'wys30201', '1554044855');
INSERT INTO `xq_coin_consume_history` VALUES ('255', '1', 'wys30201', '1554044859');
INSERT INTO `xq_coin_consume_history` VALUES ('256', '1', 'wys30201', '1554044864');
INSERT INTO `xq_coin_consume_history` VALUES ('257', '1', 'wys30201', '1554044867');
INSERT INTO `xq_coin_consume_history` VALUES ('258', '1', 'wys30201', '1554044871');
INSERT INTO `xq_coin_consume_history` VALUES ('259', '1', 'wys30201', '1554044875');
INSERT INTO `xq_coin_consume_history` VALUES ('260', '3', 'wys30201', '1554050011');
INSERT INTO `xq_coin_consume_history` VALUES ('261', '3', 'wys30201', '1554128208');
INSERT INTO `xq_coin_consume_history` VALUES ('262', '1', 'wys30201', '1554128304');
INSERT INTO `xq_coin_consume_history` VALUES ('263', '1', 'wys30201', '1554128411');
INSERT INTO `xq_coin_consume_history` VALUES ('264', '1', 'wys30201', '1554128472');
INSERT INTO `xq_coin_consume_history` VALUES ('265', '2', 'wys30201', '1554128482');
INSERT INTO `xq_coin_consume_history` VALUES ('266', '1', 'wys30201', '1554130064');
INSERT INTO `xq_coin_consume_history` VALUES ('267', '2', 'wys30201', '1554130313');
INSERT INTO `xq_coin_consume_history` VALUES ('268', '2', 'wys30201', '1554130596');
INSERT INTO `xq_coin_consume_history` VALUES ('269', '1', 'wys30201', '1554130710');
INSERT INTO `xq_coin_consume_history` VALUES ('270', '1', 'wys30201', '1554130739');
INSERT INTO `xq_coin_consume_history` VALUES ('271', '3', 'wys30201', '1554130805');
INSERT INTO `xq_coin_consume_history` VALUES ('272', '1', 'wys30202', '1554130872');
INSERT INTO `xq_coin_consume_history` VALUES ('273', '1', 'wys30201', '1554131228');
INSERT INTO `xq_coin_consume_history` VALUES ('274', '3', 'wys30201', '1554131253');
INSERT INTO `xq_coin_consume_history` VALUES ('275', '3', 'wys30201', '1554131258');
INSERT INTO `xq_coin_consume_history` VALUES ('276', '2', 'wys30201', '1554131344');
INSERT INTO `xq_coin_consume_history` VALUES ('277', '1', 'wys30201', '1554131587');
INSERT INTO `xq_coin_consume_history` VALUES ('278', '3', 'wys30202', '1554131612');
INSERT INTO `xq_coin_consume_history` VALUES ('279', '3', 'wys30202', '1554131618');
INSERT INTO `xq_coin_consume_history` VALUES ('280', '1', 'wys30202', '1554131667');
INSERT INTO `xq_coin_consume_history` VALUES ('281', '3', 'wys30202', '1554131689');
INSERT INTO `xq_coin_consume_history` VALUES ('282', '3', 'wys30201', '1554131715');
INSERT INTO `xq_coin_consume_history` VALUES ('283', '2', 'wys30201', '1554132685');
INSERT INTO `xq_coin_consume_history` VALUES ('284', '3', 'wys30201', '1554132850');
INSERT INTO `xq_coin_consume_history` VALUES ('285', '3', 'wys30202', '1554132893');
INSERT INTO `xq_coin_consume_history` VALUES ('286', '1', 'wys30202', '1554132916');
INSERT INTO `xq_coin_consume_history` VALUES ('287', '3', 'wys30202', '1554132927');
INSERT INTO `xq_coin_consume_history` VALUES ('288', '2', 'wys30202', '1554132934');
INSERT INTO `xq_coin_consume_history` VALUES ('289', '2', 'wys30202', '1554132942');
INSERT INTO `xq_coin_consume_history` VALUES ('290', '1', 'wys30202', '1554133062');
INSERT INTO `xq_coin_consume_history` VALUES ('291', '1', 'wys30201', '1554133178');
INSERT INTO `xq_coin_consume_history` VALUES ('292', '3', 'wys30202', '1554133194');
INSERT INTO `xq_coin_consume_history` VALUES ('293', '3', 'wys30201', '1554134012');
INSERT INTO `xq_coin_consume_history` VALUES ('294', '1', 'wys30202', '1554134024');
INSERT INTO `xq_coin_consume_history` VALUES ('295', '1', 'wys30201', '1554134035');
INSERT INTO `xq_coin_consume_history` VALUES ('296', '1', 'wys30201', '1554134043');
INSERT INTO `xq_coin_consume_history` VALUES ('297', '1', 'wys30201', '1554134049');

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
-- Table structure for `xq_gift_expiry`
-- ----------------------------
DROP TABLE IF EXISTS `xq_gift_expiry`;
CREATE TABLE `xq_gift_expiry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT '',
  `gift_id` int(11) DEFAULT NULL COMMENT '礼物Id',
  `num` int(11) DEFAULT '0' COMMENT '总共可使用次数',
  `start_time` int(11) DEFAULT '0' COMMENT '使用的开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '使用的截至时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用来记录卡的使用期限';

-- ----------------------------
-- Records of xq_gift_expiry
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_item
-- ----------------------------
INSERT INTO `xq_gift_item` VALUES ('1', '1', '1', '玫瑰', '2', '0', '/thinkphp/image/rose.png', '赠人玫瑰，手留余香', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('2', '1', '2', '爱心', '2', '0', '/thinkphp/image/love.png', '给你的爱滔滔不绝', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('3', '1', '3', '白开水', '2', '0', '/thinkphp/image/bottle.png', '平平淡淡', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('4', '1', '4', '入门券', '50', '0', '/thinkphp/image/card_enter_room.png', '用于免费进入房间一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('5', '1', '5', '礼品券', '2', '0', '/thinkphp/image/card_gift.png', '可兑换2钻石的礼物，只能兑换一次', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('6', '2', '6', '建房卡（1天）', '100', '0', '/thinkphp/image/card_jianfang.png', '可用于1天免费建房', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('7', '2', '7', '延时卡', '300', '30', '/thinkphp/image/card_yanshi.png', '在房间中当自己发言时，使用后可增加30s的发言时间', '/thinkphp/image/gif_love.gif');
INSERT INTO `xq_gift_item` VALUES ('8', '100', '1000', '创建房间', '2', '', '', null, null);
INSERT INTO `xq_gift_item` VALUES ('9', '100', '1001', '加入房间', '1', '', '', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_gift_user
-- ----------------------------
INSERT INTO `xq_gift_user` VALUES ('114', '3', 'wys30201', 'wys30201', '1554020271');
INSERT INTO `xq_gift_user` VALUES ('116', '2', 'wys30201', 'wys30202', '1554020344');
INSERT INTO `xq_gift_user` VALUES ('117', '2', 'wys30201', 'wys30202', '1554020380');
INSERT INTO `xq_gift_user` VALUES ('118', '3', 'wys30201', 'wys30202', '1554020382');
INSERT INTO `xq_gift_user` VALUES ('119', '1', 'wys30201', 'wys30202', '1554020383');
INSERT INTO `xq_gift_user` VALUES ('120', '2', 'wys30201', 'wys30202', '1554020386');
INSERT INTO `xq_gift_user` VALUES ('121', '2', 'wys30201', 'wys30202', '1554020387');
INSERT INTO `xq_gift_user` VALUES ('122', '4', 'wys30201', 'wys30201', '1554020679');
INSERT INTO `xq_gift_user` VALUES ('123', '1', 'wys30201', 'wys30202', '1554020920');
INSERT INTO `xq_gift_user` VALUES ('127', '1', 'wys30201', 'wys30202', '1554021567');
INSERT INTO `xq_gift_user` VALUES ('128', '2', 'wys30201', 'wys30202', '1554021586');
INSERT INTO `xq_gift_user` VALUES ('129', '2', 'wys30201', 'wys30202', '1554021586');
INSERT INTO `xq_gift_user` VALUES ('130', '1', 'wys30201', 'wys30202', '1554021587');
INSERT INTO `xq_gift_user` VALUES ('131', '2', 'wys30201', 'wys30202', '1554021588');
INSERT INTO `xq_gift_user` VALUES ('132', '7', 'wys30201', 'wys30202', '1554032855');
INSERT INTO `xq_gift_user` VALUES ('135', '7', 'wys30201', 'wys30201', '1554034343');
INSERT INTO `xq_gift_user` VALUES ('136', '3', 'wys30201', 'wys30202', '1554036168');
INSERT INTO `xq_gift_user` VALUES ('137', '1', 'wys30201', 'wys30202', '1554037020');
INSERT INTO `xq_gift_user` VALUES ('138', '1', 'wys30201', 'wys30202', '1554037224');
INSERT INTO `xq_gift_user` VALUES ('139', '1', 'wys30201', 'wys30202', '1554039673');
INSERT INTO `xq_gift_user` VALUES ('140', '1', 'wys30201', 'wys30202', '1554039790');
INSERT INTO `xq_gift_user` VALUES ('141', '1', 'wys30201', 'wys30202', '1554039880');
INSERT INTO `xq_gift_user` VALUES ('142', '1', 'wys30201', 'wys30202', '1554039979');
INSERT INTO `xq_gift_user` VALUES ('143', '1', 'wys30201', 'wys30202', '1554040054');
INSERT INTO `xq_gift_user` VALUES ('144', '1', 'wys30201', 'wys30202', '1554040425');
INSERT INTO `xq_gift_user` VALUES ('145', '1', 'wys30201', 'wys30202', '1554040433');
INSERT INTO `xq_gift_user` VALUES ('146', '3', 'wys30201', 'wys30202', '1554040438');
INSERT INTO `xq_gift_user` VALUES ('147', '1', 'wys30201', 'wys30202', '1554040503');
INSERT INTO `xq_gift_user` VALUES ('148', '1', 'wys30201', 'wys30202', '1554040598');
INSERT INTO `xq_gift_user` VALUES ('149', '3', 'wys30201', 'wys30202', '1554040611');
INSERT INTO `xq_gift_user` VALUES ('150', '3', 'wys30201', 'wys30202', '1554040628');
INSERT INTO `xq_gift_user` VALUES ('151', '1', 'wys30201', 'wys30202', '1554040716');
INSERT INTO `xq_gift_user` VALUES ('152', '1', 'wys30201', 'wys30202', '1554040873');
INSERT INTO `xq_gift_user` VALUES ('153', '1', 'wys30201', 'wys30202', '1554040964');
INSERT INTO `xq_gift_user` VALUES ('154', '3', 'wys30201', 'wys30202', '1554041226');
INSERT INTO `xq_gift_user` VALUES ('155', '2', 'wys30201', 'wys30202', '1554041232');
INSERT INTO `xq_gift_user` VALUES ('156', '3', 'wys30201', 'wys30202', '1554041539');
INSERT INTO `xq_gift_user` VALUES ('157', '3', 'wys30201', 'wys30202', '1554041569');
INSERT INTO `xq_gift_user` VALUES ('158', '1', 'wys30201', 'wys30202', '1554041581');
INSERT INTO `xq_gift_user` VALUES ('159', '3', 'wys30201', 'wys30202', '1554041694');
INSERT INTO `xq_gift_user` VALUES ('160', '2', 'wys30201', 'wys30202', '1554041718');
INSERT INTO `xq_gift_user` VALUES ('161', '3', 'wys30201', 'wys30202', '1554042187');
INSERT INTO `xq_gift_user` VALUES ('162', '2', 'wys30201', 'wys30202', '1554042194');
INSERT INTO `xq_gift_user` VALUES ('163', '3', 'wys30201', 'wys30202', '1554044039');
INSERT INTO `xq_gift_user` VALUES ('164', '3', 'wys30201', 'wys30202', '1554044053');
INSERT INTO `xq_gift_user` VALUES ('165', '3', 'wys30201', 'wys30202', '1554044053');
INSERT INTO `xq_gift_user` VALUES ('166', '3', 'wys30201', 'wys30202', '1554044069');
INSERT INTO `xq_gift_user` VALUES ('167', '3', 'wys30201', 'wys30202', '1554044073');
INSERT INTO `xq_gift_user` VALUES ('168', '3', 'wys30201', 'wys30202', '1554044089');
INSERT INTO `xq_gift_user` VALUES ('169', '3', 'wys30201', 'wys30202', '1554044667');
INSERT INTO `xq_gift_user` VALUES ('170', '3', 'wys30201', 'wys30202', '1554044751');
INSERT INTO `xq_gift_user` VALUES ('171', '3', 'wys30201', 'wys30202', '1554044760');
INSERT INTO `xq_gift_user` VALUES ('172', '3', 'wys30201', 'wys30202', '1554044765');
INSERT INTO `xq_gift_user` VALUES ('173', '3', 'wys30201', 'wys30202', '1554044800');
INSERT INTO `xq_gift_user` VALUES ('174', '1', 'wys30201', 'wys30202', '1554044816');
INSERT INTO `xq_gift_user` VALUES ('175', '1', 'wys30201', 'wys30202', '1554044816');
INSERT INTO `xq_gift_user` VALUES ('176', '1', 'wys30201', 'wys30202', '1554044817');
INSERT INTO `xq_gift_user` VALUES ('177', '1', 'wys30201', 'wys30202', '1554044820');
INSERT INTO `xq_gift_user` VALUES ('178', '1', 'wys30201', 'wys30202', '1554044820');
INSERT INTO `xq_gift_user` VALUES ('179', '1', 'wys30201', 'wys30202', '1554044821');
INSERT INTO `xq_gift_user` VALUES ('180', '1', 'wys30201', 'wys30202', '1554044821');
INSERT INTO `xq_gift_user` VALUES ('181', '1', 'wys30201', 'wys30202', '1554044824');
INSERT INTO `xq_gift_user` VALUES ('182', '1', 'wys30201', 'wys30202', '1554044828');
INSERT INTO `xq_gift_user` VALUES ('183', '1', 'wys30201', 'wys30202', '1554044832');
INSERT INTO `xq_gift_user` VALUES ('184', '1', 'wys30201', 'wys30202', '1554044836');
INSERT INTO `xq_gift_user` VALUES ('185', '1', 'wys30201', 'wys30202', '1554044840');
INSERT INTO `xq_gift_user` VALUES ('186', '1', 'wys30201', 'wys30202', '1554044843');
INSERT INTO `xq_gift_user` VALUES ('187', '1', 'wys30201', 'wys30202', '1554044848');
INSERT INTO `xq_gift_user` VALUES ('188', '1', 'wys30201', 'wys30202', '1554044851');
INSERT INTO `xq_gift_user` VALUES ('189', '1', 'wys30201', 'wys30202', '1554044855');
INSERT INTO `xq_gift_user` VALUES ('190', '1', 'wys30201', 'wys30202', '1554044859');
INSERT INTO `xq_gift_user` VALUES ('191', '1', 'wys30201', 'wys30202', '1554044864');
INSERT INTO `xq_gift_user` VALUES ('192', '1', 'wys30201', 'wys30202', '1554044867');
INSERT INTO `xq_gift_user` VALUES ('193', '1', 'wys30201', 'wys30202', '1554044871');
INSERT INTO `xq_gift_user` VALUES ('194', '1', 'wys30201', 'wys30202', '1554044875');
INSERT INTO `xq_gift_user` VALUES ('195', '3', 'wys30201', 'wys30202', '1554050011');
INSERT INTO `xq_gift_user` VALUES ('196', '3', 'wys30201', 'wys30202', '1554128208');
INSERT INTO `xq_gift_user` VALUES ('197', '1', 'wys30201', 'wys30202', '1554128304');
INSERT INTO `xq_gift_user` VALUES ('198', '1', 'wys30201', 'wys30202', '1554128411');
INSERT INTO `xq_gift_user` VALUES ('199', '1', 'wys30201', 'wys30202', '1554128472');
INSERT INTO `xq_gift_user` VALUES ('200', '2', 'wys30201', 'wys30202', '1554128482');
INSERT INTO `xq_gift_user` VALUES ('201', '1', 'wys30201', 'wys30202', '1554130064');
INSERT INTO `xq_gift_user` VALUES ('202', '2', 'wys30201', 'wys30202', '1554130313');
INSERT INTO `xq_gift_user` VALUES ('203', '2', 'wys30201', 'wys30202', '1554130596');
INSERT INTO `xq_gift_user` VALUES ('204', '1', 'wys30201', 'wys30202', '1554130710');
INSERT INTO `xq_gift_user` VALUES ('205', '1', 'wys30201', 'wys30202', '1554130739');
INSERT INTO `xq_gift_user` VALUES ('206', '3', 'wys30201', 'wys30202', '1554130805');
INSERT INTO `xq_gift_user` VALUES ('207', '1', 'wys30202', 'wys30201', '1554130872');
INSERT INTO `xq_gift_user` VALUES ('208', '1', 'wys30201', 'wys30202', '1554131228');
INSERT INTO `xq_gift_user` VALUES ('209', '3', 'wys30201', 'wys30202', '1554131253');
INSERT INTO `xq_gift_user` VALUES ('210', '3', 'wys30201', 'wys30202', '1554131258');
INSERT INTO `xq_gift_user` VALUES ('211', '2', 'wys30201', 'wys30202', '1554131344');
INSERT INTO `xq_gift_user` VALUES ('212', '1', 'wys30201', 'wys30202', '1554131587');
INSERT INTO `xq_gift_user` VALUES ('213', '3', 'wys30202', 'wys30201', '1554131612');
INSERT INTO `xq_gift_user` VALUES ('214', '3', 'wys30202', 'wys30201', '1554131618');
INSERT INTO `xq_gift_user` VALUES ('215', '1', 'wys30202', 'wys30201', '1554131667');
INSERT INTO `xq_gift_user` VALUES ('216', '3', 'wys30202', 'wys30201', '1554131689');
INSERT INTO `xq_gift_user` VALUES ('217', '3', 'wys30201', 'wys30202', '1554131715');
INSERT INTO `xq_gift_user` VALUES ('218', '2', 'wys30201', 'wys30202', '1554132685');
INSERT INTO `xq_gift_user` VALUES ('219', '3', 'wys30201', 'wys30202', '1554132850');
INSERT INTO `xq_gift_user` VALUES ('220', '3', 'wys30202', 'wys30201', '1554132893');
INSERT INTO `xq_gift_user` VALUES ('221', '1', 'wys30202', 'wys30201', '1554132916');
INSERT INTO `xq_gift_user` VALUES ('222', '3', 'wys30202', 'wys30201', '1554132927');
INSERT INTO `xq_gift_user` VALUES ('223', '2', 'wys30202', 'wys30201', '1554132934');
INSERT INTO `xq_gift_user` VALUES ('224', '2', 'wys30202', 'wys30201', '1554132942');
INSERT INTO `xq_gift_user` VALUES ('225', '1', 'wys30202', 'wys30201', '1554133062');
INSERT INTO `xq_gift_user` VALUES ('226', '1', 'wys30201', 'wys30202', '1554133178');
INSERT INTO `xq_gift_user` VALUES ('227', '3', 'wys30202', 'wys30201', '1554133194');
INSERT INTO `xq_gift_user` VALUES ('228', '3', 'wys30201', 'wys30202', '1554134012');
INSERT INTO `xq_gift_user` VALUES ('229', '1', 'wys30202', 'wys30201', '1554134024');
INSERT INTO `xq_gift_user` VALUES ('230', '1', 'wys30201', 'wys30202', '1554134035');
INSERT INTO `xq_gift_user` VALUES ('231', '1', 'wys30201', 'wys30202', '1554134043');
INSERT INTO `xq_gift_user` VALUES ('232', '1', 'wys30201', 'wys30202', '1554134049');

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
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '支付状态（0：未处理   1：支付成功  2:补单）',
  `create_time` bigint(20) DEFAULT NULL COMMENT '生产时间',
  `modify_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xq_pay_order
-- ----------------------------
INSERT INTO `xq_pay_order` VALUES ('26', 'O2019033156102495', '2019033157495754', '1', 'wys30201', '60', '60', '1', '1554021496', '1554021497');
INSERT INTO `xq_pay_order` VALUES ('27', 'O2019033199985153', '2019033199100485', '1', 'wys30201', '60', '60', '1', '1554032652', '1554032652');
INSERT INTO `xq_pay_order` VALUES ('28', 'O2019033156519798', '2019033156544810', '1', 'wys30201', '60', '60', '1', '1554032840', '1554032840');
INSERT INTO `xq_pay_order` VALUES ('29', 'O2019033110198535', '2019033110110048', '1', 'wys30201', '100', '100', '1', '1554032846', '1554032846');
INSERT INTO `xq_pay_order` VALUES ('30', 'O2019033148534854', '2019033148545356', '1', 'wys30201', '100', '100', '1', '1554032848', '1554032848');
INSERT INTO `xq_pay_order` VALUES ('31', 'O2019033148559949', '2019033148575210', '1', 'wys30201', '300', '300', '1', '1554034336', '1554034336');
INSERT INTO `xq_pay_order` VALUES ('32', 'O2019033149101511', '2019033150484810', '1', 'wys30201', '300', '300', '1', '1554044081', '1554044082');

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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COMMENT='用户进出房间表';

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
INSERT INTO `xq_room_record` VALUES ('71', '17741211', 'wys30201', '0', '1554129881', '1554129913', '1');
INSERT INTO `xq_room_record` VALUES ('72', '17741219', 'wys30201', '0', '1554130045', '1554130136', '1');
INSERT INTO `xq_room_record` VALUES ('73', '17741219', 'wys30202', '0', '1554130049', '1554130117', '1');
INSERT INTO `xq_room_record` VALUES ('74', '17741233', 'wys30201', '0', '1554130285', '1554130383', '1');
INSERT INTO `xq_room_record` VALUES ('75', '17741233', 'wys30202', '0', '1554130305', '0', '1');
INSERT INTO `xq_room_record` VALUES ('76', '17741259', 'wys30201', '0', '1554130583', '1554130970', '1');
INSERT INTO `xq_room_record` VALUES ('77', '17741259', 'wys30202', '0', '1554130586', '0', '1');
INSERT INTO `xq_room_record` VALUES ('78', '17741297', 'wys30201', '0', '1554131194', '1554131288', '1');
INSERT INTO `xq_room_record` VALUES ('79', '17741297', 'wys30202', '0', '1554131197', '0', '1');
INSERT INTO `xq_room_record` VALUES ('80', '17741305', 'wys30201', '0', '1554131330', '1554131393', '1');
INSERT INTO `xq_room_record` VALUES ('81', '17741305', 'wys30202', '0', '1554131332', '0', '1');
INSERT INTO `xq_room_record` VALUES ('82', '17741321', 'wys30201', '0', '1554131567', '1554131849', '1');
INSERT INTO `xq_room_record` VALUES ('83', '17741321', 'wys30202', '0', '1554131574', '0', '1');
INSERT INTO `xq_room_record` VALUES ('84', '17741361', 'wys30201', '0', '1554132336', '1554132584', '1');
INSERT INTO `xq_room_record` VALUES ('85', '17741367', 'wys30201', '0', '1554132393', '1554132592', '1');
INSERT INTO `xq_room_record` VALUES ('86', '17741361', 'wys30202', '0', '1554132401', '0', '1');
INSERT INTO `xq_room_record` VALUES ('87', '15632592', 'wys30201', '0', '1554132662', '1554132722', '1');
INSERT INTO `xq_room_record` VALUES ('88', '15632592', 'wys30202', '0', '1554132665', '1554132720', '1');
INSERT INTO `xq_room_record` VALUES ('89', '17741395', 'wys30201', '0', '1554132839', '1554132997', '1');
INSERT INTO `xq_room_record` VALUES ('90', '17741395', 'wys30202', '0', '1554132843', '0', '1');
INSERT INTO `xq_room_record` VALUES ('91', '15632614', 'wys30201', '0', '1554133048', '1554133079', '1');
INSERT INTO `xq_room_record` VALUES ('92', '15632614', 'wys30202', '0', '1554133052', '0', '1');
INSERT INTO `xq_room_record` VALUES ('93', '15632618', 'wys30201', '0', '1554133090', '1554133095', '1');
INSERT INTO `xq_room_record` VALUES ('94', '15632626', 'wys30201', '0', '1554133166', '1554133203', '1');
INSERT INTO `xq_room_record` VALUES ('95', '15632626', 'wys30202', '0', '1554133169', '0', '1');
INSERT INTO `xq_room_record` VALUES ('96', '17741471', 'wys30201', '0', '1554133989', '1554134058', '1');
INSERT INTO `xq_room_record` VALUES ('97', '17741471', 'wys30202', '0', '1554134002', '0', '1');

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
INSERT INTO `xq_user_info` VALUES ('1', '1', 'wys30201', '神龙', '男', 'angel', '0', '222', '26', '172', '博士及以上', 'IT工程师', '湖南', '0', '深圳市南山区', '', '/thinkphp/upload/XQ/IMG_20181120001732_901.jpg', '2018-05-15 21:57:43', '2018-12-02 0:49:11', '我的世界我做主');
INSERT INTO `xq_user_info` VALUES ('4', '10', 'wys30202', '莹宝', '女', 'guest', '0', '466', '23', '170', '本科', 'IT', '广东', '0', '长沙', '', '/thinkphp/upload/XQ/IMG_20180616164817_283.jpg', '2018-05-16 23:59:15', '2018-08-03 23:57:16', '');
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
