-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2018-06-10 16:19:04
-- 服务器版本： 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `xq_app`
--

-- --------------------------------------------------------

--
-- 表的结构 `xq_user`
--

CREATE TABLE `xq_user` (
  `user_id` int(11) NOT NULL COMMENT '用户Id',
  `user_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `create_time` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户列表';

--
-- 转存表中的数据 `xq_user`
--

INSERT INTO `xq_user` (`user_id`, `user_name`, `password`, `create_time`) VALUES
(1, 'wys30201', '123456', '2018-05-14 19:36:04'),
(2, 'aaa', '123456', '2018-05-14 22:24:02'),
(10, 'wys30202', '123456', '2018-05-16 23:58:46'),
(12, 'wys30203', '123456', '2018-05-30 23:31:16'),
(15, 'wys30204', '123456', '2018-05-31 21:28:30');

-- --------------------------------------------------------

--
-- 表的结构 `xq_user_info`
--

CREATE TABLE `xq_user_info` (
  `id` int(11) NOT NULL,
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
  `modify_time` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户详情列表';

--
-- 转存表中的数据 `xq_user_info`
--

INSERT INTO `xq_user_info` (`id`, `user_id`, `user_name`, `nick_name`, `gender`, `role_type`, `level`, `balance`, `age`, `tall`, `scholling`, `professional`, `native_place`, `marrige`, `job_address`, `phone`, `head_image`, `create_time`, `modify_time`) VALUES
(1, 1, 'wys30201', '孤单的人', '男', 'angel', 0, 0, 25, 0, '本科', 'IT工程师', '湖南', 0, '深圳市南山区', '', 'http://192.168.1.103/thinkphp/upload/XQ/small_22.png', '2018-05-15 21:57:43', '2018-05-25 21:59:41'),
(4, 10, 'wys30202', '随心所动', '女', 'guest', 0, 0, 23, 170, '本科', 'IT', '广东', 0, '长沙', '', 'http://192.168.1.103/thinkphp/upload/XQ/small_01.png', '2018-05-16 23:59:15', '2018-05-29 23:44:09'),
(5, 12, 'wys30203', '孤星', '女', 'guest', 0, 0, 22, 158, '硕士', '销售', '湖北', 0, '武汉', '', 'http://192.168.1.103/thinkphp/upload/XQ/small_24.png', '2018-05-30 23:31:29', '2018-05-30 23:32:20'),
(6, 15, 'wys30204', '如风', '男', 'guest', 0, 0, 27, 183, '博士', '工程经理', '湖南', 0, '南山科技园', '', 'http://192.168.1.103/thinkphp/upload/XQ/small_08.png', '2018-05-31 21:37:17', '2018-05-31 21:59:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `xq_user`
--
ALTER TABLE `xq_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `xq_user_info`
--
ALTER TABLE `xq_user_info`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `xq_user`
--
ALTER TABLE `xq_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户Id', AUTO_INCREMENT=16;
--
-- 使用表AUTO_INCREMENT `xq_user_info`
--
ALTER TABLE `xq_user_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
