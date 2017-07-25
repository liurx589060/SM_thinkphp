-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-07-25 10:40:55
-- 服务器版本： 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thinkphp`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_device`
--

CREATE TABLE `think_device` (
  `id` int(8) NOT NULL,
  `token` varchar(255) NOT NULL COMMENT 'koken值',
  `imei` varchar(255) NOT NULL COMMENT '设备IMEI值',
  `create_time` int(20) UNSIGNED NOT NULL COMMENT ' 创建时间',
  `modify_time` int(20) UNSIGNED NOT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_device`
--

INSERT INTO `think_device` (`id`, `token`, `imei`, `create_time`, `modify_time`) VALUES
(1, 'I5YXKeC3mDGhUGkb', '00000000000000', 1500970382, 1500970382),
(2, 'XwEeYIMROpHJBr8m', '868256024810748', 1500970394, 1500970394);

-- --------------------------------------------------------

--
-- 表的结构 `think_head_image`
--

CREATE TABLE `think_head_image` (
  `id` int(4) UNSIGNED NOT NULL,
  `user_id` int(5) UNSIGNED NOT NULL,
  `head_image` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_head_image`
--

INSERT INTO `think_head_image` (`id`, `user_id`, `head_image`, `create_time`) VALUES
(11, 19, 'file/headImage/19/596b06b788409.jpg', 1500186295),
(12, 18, 'file/headImage/18/596b0a4f7707f.jpg', 1500187215),
(13, 20, 'file/headImage/20/596b6a75a85b0.png', 1500211829),
(14, 19, 'file/headImage/19/596b6aaf7e5bf.jpg', 1500211887),
(15, 19, 'file/headImage/19/596d971c9a3a8.jpg', 1500354332),
(16, 19, 'file/headImage/19/596d978870f1a.jpg', 1500354440);

-- --------------------------------------------------------

--
-- 表的结构 `think_html`
--

CREATE TABLE `think_html` (
  `id` int(8) NOT NULL,
  `key_word` varchar(255) NOT NULL COMMENT '关键字',
  `css` text NOT NULL COMMENT 'css样式代码',
  `javascript` text NOT NULL COMMENT 'javascript代码',
  `html` text NOT NULL COMMENT 'heml代码'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='html';

--
-- 转存表中的数据 `think_html`
--

INSERT INTO `think_html` (`id`, `key_word`, `css`, `javascript`, `html`) VALUES
(1, '皇马新闻1', '#main {            margin-left: 8pt;            margin-right: 8pt;            margin-top: 12pt;            font-family: 微软雅黑;            /*background-color: #cccccc;*/        }        #title {            font-size: 15pt;            font-weight: bold;        }        #currentTime {            font-size: 10pt;            font-weight: bold;            color: #666666;            margin-top: 10pt;        }       .pic {           width: 100%;        }        .text {            text-indent: 2em;        }', 'var imageArray = new Array();        Date.prototype.Format = function (fmt) {            var o = {                \'M+\': this.getMonth() + 1,                \'d+\': this.getDate(),                \'H+\': this.getHours(),                \'m+\': this.getMinutes(),                \'s+\': this.getSeconds(),                \'q+\': Math.floor((this.getMonth() + 3) / 3),                \'S\': this.getMilliseconds()            };            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + \'\').substr(4 - RegExp.$1.length));            for (var k in o)                if (new RegExp(\'(\' + k + \')\').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : ((\'00\' + o[k]).substr((\'\' + o[k]).length)));            return fmt;        };        function load() {            var time = (new Date()).Format(\'MM-dd HH:mm:ss\');            document.getElementById(\'currentTime\').innerHTML = time + \'  皇马官网\';            getImageUrlList();            if(window.rsWeb) {                window.rsWeb.webLoadComplete(document.body.scrollHeight);            }            alert(document.body.scrollHeight);        };        function getImageUrlList() {            var array = document.getElementsByTagName(\'img\');            for (var i = 0 ; i < array.length ; i++) {                imageArray[i] = array[i].src;            }        };        function imageOnClick(src) {            var index;            for (var i=0;i<imageArray.length;i++) {                if(src===imageArray[i]) {                    index = i;                    break;                }            }            alert(src+\'--->>\'+index);            if(window.rsWeb) {                window.rsWeb.imageOnClick(imageArray,i);            }        };', '<div id=\'main\'><div id=\'titleDiv\'>    <label id=\'title\'><big><font color=\'#354678\'>官方：皇马将于12月13日出战世俱杯</font></big></label><br>    <label id=\'currentTime\'>07-22 07：44：59 皇马官网</label><p></div><div id=\'content\'>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs/M00/11/97/oYYBAFhw3q6AOVVDAAHV0V10KoM520.jpg\' onclick=\'imageOnClick(src)\'>    <div style=\'text-align: center\'><u>C罗领取金球奖</u></div>    <p class=\'text\'>直播吧7月22日讯 作为欧冠改制以来的第一支卫冕球队，皇马将于12月13日踏上世俱杯的征程，他们也有望卫冕世俱杯的冠军。</p>    <img class=\'pic\' src=\'http://www.sxdaily.com.cn/NMediaFile/2016/1213/SXRB201612130918000207152431133.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯的举办地点是阿拉伯联合酋长国，决赛时间是12月16日。欧冠冠军皇马将于12月13日参加半决赛的比赛，半决赛的对手目前还不得而知        。决赛的时间是12月16日当地时间晚上9点，同时三四名决赛也是于当天下午6点进行，三场比赛的地点都是在阿布扎比的扎耶德体育城。</p>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs1/M00/7F/62/pIYBAFkvkfWAL_xeAAJhPUgBtic469.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯将于12月6日在阿布扎比拉开战幕，届时包括欧洲、非洲、南美洲、亚洲、、大洋洲的冠军以及东道主代表球队为世俱杯展开拼搏。</p>    <p class=\'text\'>(Mselin)</p></div></div>'),
(3, '皇马新闻3', '#main {            margin-left: 8pt;            margin-right: 8pt;            margin-top: 12pt;            font-family: 微软雅黑;            /*background-color: #cccccc;*/        }        #title {            font-size: 15pt;            font-weight: bold;        }        #currentTime {            font-size: 10pt;            font-weight: bold;            color: #666666;            margin-top: 10pt;        }       .pic {           width: 100%;        }        .text {            text-indent: 2em;        }', 'var imageArray = new Array();        Date.prototype.Format = function (fmt) {            var o = {                \'M+\': this.getMonth() + 1,                \'d+\': this.getDate(),                \'H+\': this.getHours(),                \'m+\': this.getMinutes(),                \'s+\': this.getSeconds(),                \'q+\': Math.floor((this.getMonth() + 3) / 3),                \'S\': this.getMilliseconds()            };            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + \'\').substr(4 - RegExp.$1.length));            for (var k in o)                if (new RegExp(\'(\' + k + \')\').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : ((\'00\' + o[k]).substr((\'\' + o[k]).length)));            return fmt;        };        function load() {            var time = (new Date()).Format(\'MM-dd HH:mm:ss\');            document.getElementById(\'currentTime\').innerHTML = time + \'  皇马官网\';            getImageUrlList();            if(window.rsWeb) {                window.rsWeb.webLoadComplete(document.body.scrollHeight);            }            alert(document.body.scrollHeight);        };        function getImageUrlList() {            var array = document.getElementsByTagName(\'img\');            for (var i = 0 ; i < array.length ; i++) {                imageArray[i] = array[i].src;            }        };        function imageOnClick(src) {            var index;            for (var i=0;i<imageArray.length;i++) {                if(src===imageArray[i]) {                    index = i;                    break;                }            }            alert(src+\'--->>\'+index);            if(window.rsWeb) {                window.rsWeb.imageOnClick(imageArray,i);            }        };', '<div id=\'main\'><div id=\'titleDiv\'>    <label id=\'title\'><big><font color=\'#354678\'>官方：皇马将于12月13日出战世俱杯</font></big></label><br>    <label id=\'currentTime\'>07-22 07：44：59 皇马官网</label><p></div><div id=\'content\'>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs/M00/11/97/oYYBAFhw3q6AOVVDAAHV0V10KoM520.jpg\' onclick=\'imageOnClick(src)\'>    <div style=\'text-align: center\'><u>C罗领取金球奖</u></div>    <p class=\'text\'>直播吧7月22日讯 作为欧冠改制以来的第一支卫冕球队，皇马将于12月13日踏上世俱杯的征程，他们也有望卫冕世俱杯的冠军。</p>    <img class=\'pic\' src=\'http://www.sxdaily.com.cn/NMediaFile/2016/1213/SXRB201612130918000207152431133.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯的举办地点是阿拉伯联合酋长国，决赛时间是12月16日。欧冠冠军皇马将于12月13日参加半决赛的比赛，半决赛的对手目前还不得而知        。决赛的时间是12月16日当地时间晚上9点，同时三四名决赛也是于当天下午6点进行，三场比赛的地点都是在阿布扎比的扎耶德体育城。</p>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs1/M00/7F/62/pIYBAFkvkfWAL_xeAAJhPUgBtic469.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯将于12月6日在阿布扎比拉开战幕，届时包括欧洲、非洲、南美洲、亚洲、、大洋洲的冠军以及东道主代表球队为世俱杯展开拼搏。</p>    <p class=\'text\'>(Mselin)</p></div></div>'),
(2, '皇马新闻2', '#main {            margin-left: 8pt;            margin-right: 8pt;            margin-top: 12pt;            font-family: 微软雅黑;            /*background-color: #cccccc;*/        }        #title {            font-size: 15pt;            font-weight: bold;        }        #currentTime {            font-size: 10pt;            font-weight: bold;            color: #666666;            margin-top: 10pt;        }       .pic {           width: 100%;        }        .text {            text-indent: 2em;        }', 'var imageArray = new Array();        Date.prototype.Format = function (fmt) {            var o = {                \'M+\': this.getMonth() + 1,                \'d+\': this.getDate(),                \'H+\': this.getHours(),                \'m+\': this.getMinutes(),                \'s+\': this.getSeconds(),                \'q+\': Math.floor((this.getMonth() + 3) / 3),                \'S\': this.getMilliseconds()            };            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + \'\').substr(4 - RegExp.$1.length));            for (var k in o)                if (new RegExp(\'(\' + k + \')\').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : ((\'00\' + o[k]).substr((\'\' + o[k]).length)));            return fmt;        };        function load() {            var time = (new Date()).Format(\'MM-dd HH:mm:ss\');            document.getElementById(\'currentTime\').innerHTML = time + \'  皇马官网\';            getImageUrlList();            if(window.rsWeb) {                window.rsWeb.webLoadComplete(document.body.scrollHeight);            }            alert(document.body.scrollHeight);        };        function getImageUrlList() {            var array = document.getElementsByTagName(\'img\');            for (var i = 0 ; i < array.length ; i++) {                imageArray[i] = array[i].src;            }        };        function imageOnClick(src) {            var index;            for (var i=0;i<imageArray.length;i++) {                if(src===imageArray[i]) {                    index = i;                    break;                }            }            alert(src+\'--->>\'+index);            if(window.rsWeb) {                window.rsWeb.imageOnClick(imageArray,i);            }        };', '<div id=\'main\'><div id=\'titleDiv\'>    <label id=\'title\'><big><font color=\'#354678\'>官方：皇马将于12月13日出战世俱杯</font></big></label><br>    <label id=\'currentTime\'>07-22 07：44：59 皇马官网</label><p></div><div id=\'content\'>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs/M00/11/97/oYYBAFhw3q6AOVVDAAHV0V10KoM520.jpg\' onclick=\'imageOnClick(src)\'>    <div style=\'text-align: center\'><u>C罗领取金球奖</u></div>    <p class=\'text\'>直播吧7月22日讯 作为欧冠改制以来的第一支卫冕球队，皇马将于12月13日踏上世俱杯的征程，他们也有望卫冕世俱杯的冠军。</p>    <img class=\'pic\' src=\'http://www.sxdaily.com.cn/NMediaFile/2016/1213/SXRB201612130918000207152431133.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯的举办地点是阿拉伯联合酋长国，决赛时间是12月16日。欧冠冠军皇马将于12月13日参加半决赛的比赛，半决赛的对手目前还不得而知        。决赛的时间是12月16日当地时间晚上9点，同时三四名决赛也是于当天下午6点进行，三场比赛的地点都是在阿布扎比的扎耶德体育城。</p>    <img class=\'pic\' src=\'http://img1.dongqiudi.com/fastdfs1/M00/7F/62/pIYBAFkvkfWAL_xeAAJhPUgBtic469.jpg\' onclick=\'imageOnClick(src)\'>    <p class=\'text\'>今年世俱杯将于12月6日在阿布扎比拉开战幕，届时包括欧洲、非洲、南美洲、亚洲、、大洋洲的冠军以及东道主代表球队为世俱杯展开拼搏。</p>    <p class=\'text\'>(Mselin)</p></div></div>');

-- --------------------------------------------------------

--
-- 表的结构 `think_user`
--

CREATE TABLE `think_user` (
  `user_id` int(8) UNSIGNED NOT NULL COMMENT '用户id',
  `user_data` varchar(255) NOT NULL COMMENT '用户数据',
  `head_image` varchar(255) NOT NULL COMMENT '用户头像',
  `create_time` int(16) UNSIGNED NOT NULL COMMENT '创建时间',
  `modify_time` int(16) UNSIGNED NOT NULL COMMENT '修改时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_user`
--

INSERT INTO `think_user` (`user_id`, `user_data`, `head_image`, `create_time`, `modify_time`) VALUES
(18, '宋月', 'file/headImage/18/596b0a4f7707f.jpg', 1500119674, 1500198527),
(19, '刘润雄', 'file/headImage/19/596d978870f1a.jpg', 1500119814, 1500354440),
(20, '刘楚丹', 'file/headImage/20/596b6a75a85b0.png', 1500119823, 1500211829);

-- --------------------------------------------------------

--
-- 表的结构 `think_user_info`
--

CREATE TABLE `think_user_info` (
  `id` int(8) UNSIGNED NOT NULL,
  `user_id` int(4) UNSIGNED NOT NULL COMMENT '用户id',
  `age` int(3) UNSIGNED NOT NULL COMMENT '年龄',
  `sex` varchar(10) NOT NULL COMMENT '性别',
  `house_address` varchar(255) NOT NULL COMMENT '房屋地址',
  `job_address` varchar(255) NOT NULL COMMENT '工作地址'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息';

--
-- 转存表中的数据 `think_user_info`
--

INSERT INTO `think_user_info` (`id`, `user_id`, `age`, `sex`, `house_address`, `job_address`) VALUES
(1, 18, 24, '女', '深圳市西丽红花岭', '科技园'),
(2, 19, 27, '男', '深圳市固戍', '科技园'),
(3, 20, 24, '女', '深圳市布吉', '深圳下沙');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `think_device`
--
ALTER TABLE `think_device`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_head_image`
--
ALTER TABLE `think_head_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_html`
--
ALTER TABLE `think_html`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_user`
--
ALTER TABLE `think_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `think_user_info`
--
ALTER TABLE `think_user_info`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `think_device`
--
ALTER TABLE `think_device`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `think_head_image`
--
ALTER TABLE `think_head_image`
  MODIFY `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- 使用表AUTO_INCREMENT `think_html`
--
ALTER TABLE `think_html`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `think_user`
--
ALTER TABLE `think_user`
  MODIFY `user_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id', AUTO_INCREMENT=26;
--
-- 使用表AUTO_INCREMENT `think_user_info`
--
ALTER TABLE `think_user_info`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
