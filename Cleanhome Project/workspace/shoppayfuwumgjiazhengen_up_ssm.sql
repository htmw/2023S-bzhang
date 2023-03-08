/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : shoppayfuwumgjiazhengen_up_ssm

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2023-03-06 11:50:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wct_address
-- ----------------------------
DROP TABLE IF EXISTS `wct_address`;
CREATE TABLE `wct_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_address
-- ----------------------------
INSERT INTO `wct_address` VALUES ('41', '小米 15123385885 某某地址', '76');

-- ----------------------------
-- Table structure for wct_bill
-- ----------------------------
DROP TABLE IF EXISTS `wct_bill`;
CREATE TABLE `wct_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gids` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `uid` varchar(100) DEFAULT NULL,
  `shop` varchar(100) DEFAULT NULL,
  `ndate` varchar(255) DEFAULT NULL,
  `total` varchar(255) DEFAULT NULL,
  `gnames` varchar(500) DEFAULT NULL,
  `sid` varchar(10) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `statecn` varchar(50) DEFAULT NULL,
  `pnote` varchar(255) DEFAULT NULL,
  `pf` varchar(255) DEFAULT NULL,
  `shstatecn` varchar(255) DEFAULT NULL,
  `shnote` varchar(255) DEFAULT NULL,
  `shtype` varchar(255) DEFAULT NULL,
  `fhnote` varchar(255) DEFAULT NULL,
  `kid` varchar(255) DEFAULT NULL,
  `ktitle` varchar(255) DEFAULT NULL,
  `kcode` varchar(255) DEFAULT NULL,
  `qid` int(11) DEFAULT NULL,
  `qusername` varchar(255) DEFAULT NULL,
  `qtel` varchar(255) DEFAULT NULL,
  `bgcounts` varchar(255) DEFAULT NULL,
  `way` varchar(255) DEFAULT NULL,
  `ydate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_bill
-- ----------------------------
INSERT INTO `wct_bill` VALUES ('111', '', 'ideabobo', '76', '小小家政', '2023-03-02 16:38:31', '300', '衣服清洗', '8', '', '小米 15123385885 某某地址', '', '已评价', '', '5', '', '', '', '', '', '', '', null, '', '', '', '配送', '2023-03-03 16:33');
INSERT INTO `wct_bill` VALUES ('112', '', 'ideabobo', '76', '小小家政', '2023-03-02 16:38:22', '90', '全屋清洁', '8', '', '小米 15123385885 某某地址', '备注详细信息', '已付款', '', '', '', '', '', '', '', '', '', null, '', '', '', '配送', '2023-03-04 16:38');

-- ----------------------------
-- Table structure for wct_good
-- ----------------------------
DROP TABLE IF EXISTS `wct_good`;
CREATE TABLE `wct_good` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(100) DEFAULT NULL,
  `price` varchar(10) DEFAULT NULL,
  `note` varchar(2000) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `typeid` varchar(10) DEFAULT NULL,
  `sid` varchar(10) DEFAULT NULL,
  `shop` varchar(50) DEFAULT NULL,
  `mcount` varchar(50) DEFAULT NULL,
  `btype` varchar(255) DEFAULT NULL,
  `statecn` varchar(255) DEFAULT NULL,
  `stype` varchar(255) DEFAULT NULL,
  `ppid` int(11) DEFAULT NULL,
  `pptitle` varchar(255) DEFAULT NULL,
  `ctype` varchar(255) DEFAULT NULL,
  `ctypeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wct_good
-- ----------------------------
INSERT INTO `wct_good` VALUES ('50', '全屋清洁', '200', '<p>详细的介绍信息</p>', '清洁', 'f94e8730-f3b9-4220-989a-5723e9aab1e0.jpeg', '52', '8', '小小家政', '', '1', '', '', null, '', '', null);
INSERT INTO `wct_good` VALUES ('51', '衣服清洗', '300', '', '清洁', '3ba28493-208e-492f-9014-a64143349a9d.png', '52', '8', '小小家政', '', '1', '', '', null, '', '', null);
INSERT INTO `wct_good` VALUES ('52', '家电维修', '300', '<p>这里详细编辑介绍同样的图文编辑都是可以的</p><p><br/></p>', '电器维修', '21f3d0b6-12d2-4f49-91a1-b60cca12b964.jpg', '51', '8', '小小家政', '', '1', '', '', null, '', '', null);
INSERT INTO `wct_good` VALUES ('53', '全屋清洁', '100', '<p>这里自己详细描述服务项目</p><p>可以自己多图文编辑的</p><p><img src=\"upload/d5f59993-aa37-4f16-a2e6-4f3fe9978158.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"upload/777e0b86-3dff-4c82-a9d5-97cc407edec5.jpeg\" style=\"max-width:100%;\"/><br/></p>', '清洁', '113dd4cb-b2b8-45ff-b10b-6355f9fe50bc.jpg', '52', '8', '小小家政', '', '1', '', '', null, '', '全屋清洁', '4');

-- ----------------------------
-- Table structure for wct_huihua
-- ----------------------------
DROP TABLE IF EXISTS `wct_huihua`;
CREATE TABLE `wct_huihua` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '发送者id',
  `fid` int(11) DEFAULT NULL COMMENT '接收者id',
  `qid` int(11) DEFAULT NULL COMMENT '群id',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `zan` int(11) DEFAULT '0',
  `note` varchar(500) DEFAULT NULL,
  `ndate` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL COMMENT '发送者名称',
  `fusername` varchar(50) DEFAULT NULL COMMENT '接收者名称',
  `attach` varchar(200) DEFAULT NULL,
  `attachname` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `img` varchar(200) DEFAULT NULL COMMENT '图片',
  `qtitle` varchar(255) DEFAULT NULL,
  `msgtype` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_huihua
-- ----------------------------

-- ----------------------------
-- Table structure for wct_message
-- ----------------------------
DROP TABLE IF EXISTS `wct_message`;
CREATE TABLE `wct_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `fid` int(11) DEFAULT NULL COMMENT '朋友id',
  `qid` int(11) DEFAULT NULL COMMENT '群id',
  `type` int(11) DEFAULT NULL COMMENT '消息类型',
  `zan` int(11) DEFAULT '0',
  `note` varchar(500) DEFAULT NULL,
  `ndate` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL COMMENT '发送者名称',
  `fusername` varchar(50) DEFAULT NULL COMMENT '朋友名称',
  `attach` varchar(200) DEFAULT NULL COMMENT '附件文件',
  `attachname` varchar(200) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL COMMENT '图片',
  `qtitle` varchar(255) DEFAULT NULL,
  `msgtype` int(10) DEFAULT NULL,
  `fimg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_message
-- ----------------------------

-- ----------------------------
-- Table structure for wct_notice
-- ----------------------------
DROP TABLE IF EXISTS `wct_notice`;
CREATE TABLE `wct_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `ndate` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wct_notice
-- ----------------------------
INSERT INTO `wct_notice` VALUES ('21', '测试广告资讯', '<p>这里是详细的广告资讯</p>', '2023-03-02 16:31:00', '1', '90eb09bb-1be2-47b8-8adb-17b2fadac078.jpeg');
INSERT INTO `wct_notice` VALUES ('22', '测试新闻', '<p>家政服务平台上线咯</p><p><img src=\"upload/0373b6e6-152a-44f7-b0fa-fc91f48ec4ee.jpg\" style=\"max-width:100%;\"/><br/></p>', '2023-03-02 16:31:02', '1', '84dfe59f-e67f-4873-9717-a2f015673383.jpg');

-- ----------------------------
-- Table structure for wct_posts
-- ----------------------------
DROP TABLE IF EXISTS `wct_posts`;
CREATE TABLE `wct_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `uid` varchar(10) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL,
  `ndate` varchar(50) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `sdate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_posts
-- ----------------------------
INSERT INTO `wct_posts` VALUES ('4', '反馈交流', '<p>可以反馈交流</p>', '76', 'ideabobo', '2023-03-02 16:30:54', '', '1', null, '');
INSERT INTO `wct_posts` VALUES ('5', '可以发帖反馈', '<p>阿萨大大</p>', '76', 'ideabobo', '2023-03-02 16:30:52', '', '1', null, '');
INSERT INTO `wct_posts` VALUES ('6', '可以发帖反馈', '<p>啊手动阀手动阀</p>', '76', 'ideabobo', '2023-03-02 16:37:52', '', '1', null, '');

-- ----------------------------
-- Table structure for wct_replay
-- ----------------------------
DROP TABLE IF EXISTS `wct_replay`;
CREATE TABLE `wct_replay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(10) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `uid` varchar(10) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL,
  `ndate` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_replay
-- ----------------------------
INSERT INTO `wct_replay` VALUES ('3', '4', '回复用户的反馈交流', '', '', '2023-02-13 09:33:06', null);
INSERT INTO `wct_replay` VALUES ('4', '4', '回复反馈', '', '', '2023-03-02 16:36:38', null);

-- ----------------------------
-- Table structure for wct_shop
-- ----------------------------
DROP TABLE IF EXISTS `wct_shop`;
CREATE TABLE `wct_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(100) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `ownid` varchar(10) DEFAULT NULL,
  `passwd` varchar(50) DEFAULT NULL,
  `codeimg` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_shop
-- ----------------------------
INSERT INTO `wct_shop` VALUES ('8', '小小家政', '66b04a62-8ddc-42a0-aec6-d3569370b021.png', '', '重庆市璧山区红宇大道39号', '106.22737819580078', '29.580899949160653', '1613386886', '', '', '');

-- ----------------------------
-- Table structure for wct_type
-- ----------------------------
DROP TABLE IF EXISTS `wct_type`;
CREATE TABLE `wct_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) DEFAULT NULL,
  `ownid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wct_type
-- ----------------------------
INSERT INTO `wct_type` VALUES ('51', '电器维修', '');
INSERT INTO `wct_type` VALUES ('52', '清洁', '');

-- ----------------------------
-- Table structure for wct_type2
-- ----------------------------
DROP TABLE IF EXISTS `wct_type2`;
CREATE TABLE `wct_type2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) DEFAULT NULL,
  `pid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wct_type2
-- ----------------------------
INSERT INTO `wct_type2` VALUES ('1', '电视维修', '51');
INSERT INTO `wct_type2` VALUES ('2', '冰箱维修', '51');
INSERT INTO `wct_type2` VALUES ('3', '空调维修', '51');
INSERT INTO `wct_type2` VALUES ('4', '全屋清洁', '52');
INSERT INTO `wct_type2` VALUES ('5', '衣服清洗', '52');

-- ----------------------------
-- Table structure for wct_user
-- ----------------------------
DROP TABLE IF EXISTS `wct_user`;
CREATE TABLE `wct_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `passwd` varchar(50) DEFAULT NULL,
  `roletype` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `birth` varchar(20) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `sid` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `statecn` varchar(50) DEFAULT NULL,
  `clientId` varchar(200) DEFAULT NULL,
  `nickname` varchar(200) DEFAULT NULL,
  `favs` varchar(200) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `openid` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `typecn` varchar(255) DEFAULT NULL,
  `tiwen` varchar(255) DEFAULT NULL,
  `jknote` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wct_user
-- ----------------------------
INSERT INTO `wct_user` VALUES ('1', 'admin', 'admin', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `wct_user` VALUES ('76', 'ideabobo', '111111', '2', '', '15123375775', '', '', '女', '', '9b521150-edba-4770-a04b-0e8dc9c5a28f.png', '', '', '', '', '', '', '110', '', null, '', '', '');
INSERT INTO `wct_user` VALUES ('77', '小小家政', '111111', '3', '', '15123387787', '', '', '', '', 'f983105a-7596-45c6-8bb0-3232f6fcf5d5.png', '8', '', '', '', '', '', null, '', null, '', '', '');
INSERT INTO `wct_user` VALUES ('78', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '', '', null, 'oe-Zu5opGF3DAuEKmhHvy6zIted0', null, '', '', '');
INSERT INTO `wct_user` VALUES ('79', 'xiaoxiao', '111111', '2', '', '15123375775', '', '', '女', '', '85ab9324-f855-4815-bafd-cb73a3d5b777.png', '', '', '', '', '', '', null, '', null, '', '', '');

-- ----------------------------
-- Table structure for wct_youhuiquan
-- ----------------------------
DROP TABLE IF EXISTS `wct_youhuiquan`;
CREATE TABLE `wct_youhuiquan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total` int(11) DEFAULT NULL,
  `extime` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `fulluse` int(11) DEFAULT NULL,
  `ndate` varchar(255) DEFAULT NULL,
  `extimestr` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `statecn` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wct_youhuiquan
-- ----------------------------
INSERT INTO `wct_youhuiquan` VALUES ('47', '20', '1689091200', '1', null, '1', '200', '2023-02-13 09:24:47', '2023-07-12 11:11', '', '', null);
INSERT INTO `wct_youhuiquan` VALUES ('48', '10', '1681401600', '1', null, '1', '200', '2023-02-13 09:32:58', '2023-04-14 11:11', '', '', null);
INSERT INTO `wct_youhuiquan` VALUES ('49', '10', '1681401600', '1', '76', '2', '200', '2023-03-02 16:38:22', '2023-04-14 11:11', 'ideabobo', '已使用', '48');
INSERT INTO `wct_youhuiquan` VALUES ('50', '20', '1689091200', '1', '76', '2', '200', '2023-02-13 09:38:18', '2023-07-12 11:11', 'ideabobo', '已使用', '47');
INSERT INTO `wct_youhuiquan` VALUES ('51', '5', '1685030400', '1', null, '1', '20', '2023-03-02 16:36:30', '2023-05-26 11:11', '', '', null);
