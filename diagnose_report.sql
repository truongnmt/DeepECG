-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:8889
-- Thời gian đã tạo: Th4 10, 2018 lúc 09:19 AM
-- Phiên bản máy phục vụ: 5.6.38
-- Phiên bản PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `diagnose_report`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `url` varchar(200) NOT NULL,
  `result` int(11) DEFAULT '-1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `images`
--

INSERT INTO `images` (`id`, `report_id`, `url`, `result`) VALUES
(12, 15, 'http://10.0.2.2/diagnose-report/uploads/1.jpg', -1),
(13, 16, 'http://10.0.2.2/diagnose-report/uploads/13.png', -1),
(14, 17, 'http://10.0.2.2/diagnose-report/uploads/14.png', -1),
(15, 17, 'http://10.0.2.2/diagnose-report/uploads/15.png', -1),
(16, 19, 'http://10.0.2.2/diagnose-report/uploads/16.png', -1),
(17, 19, 'http://10.0.2.2/diagnose-report/uploads/17.png', -1),
(18, 20, 'http://10.0.2.2/diagnose-report/uploads/18.jpg', -1),
(19, 20, 'http://10.0.2.2/diagnose-report/uploads/19.jpg', -1),
(20, 21, 'http://10.0.2.2/diagnose-report/uploads/20.jpg', 1),
(21, 21, 'http://10.0.2.2/diagnose-report/uploads/21.jpg', 0),
(22, 21, 'http://10.0.2.2/diagnose-report/uploads/22.jpg', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text,
  `patient_name` varchar(200) NOT NULL,
  `patient_age` int(11) NOT NULL,
  `patient_height` int(11) NOT NULL,
  `patient_weight` int(11) NOT NULL,
  `general_result` float DEFAULT '-1',
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `name`, `description`, `patient_name`, `patient_age`, `patient_height`, `patient_weight`, `general_result`, `created_at`) VALUES
(15, 1, 'Liver profile', 'I feel irritate in my stomach', 'Cao Thi Nhi', 15, 155, 45, -1, '2018-04-06'),
(16, 1, 'Liver profile 2', 'I feel irritate in my stomach', 'Cao Thi Nhi', 15, 155, 45, -1, '2018-04-06'),
(17, 1, 'Liver profile 3', 'I feel irritate in my stomach', 'Cao Thi Nhi', 15, 155, 45, -1, '2018-04-07'),
(19, 1, 'Liver profile 3', 'I feel irritate in my stomach', 'Cao Thi Nhi', 15, 155, 45, -1, '2018-04-09'),
(20, 1, 'Stomach profile', 'I aldf aslkdfj aslkdfj alskdjf laskdf jlasdf lasdj flaksd flasdjf lkas jdfasjdf l', 'Nguyen Manh Truong', 23, 179, 66, -1, '2018-04-10'),
(21, 1, 'Lung profile', 'alkfj alskdfj alsdkfj alskdfj fjlaskdf laks fjlaksd jf', 'Nguyen Manh Truong', 23, 170, 66, 66.6, '2018-04-10');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` text NOT NULL,
  `gender` varchar(6) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `hospital_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `gender`, `group_id`, `hospital_id`) VALUES
(1, 'test', 'test@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Male', NULL, NULL),
(2, 'nhict', 'nhict@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Female', NULL, NULL),
(3, 'truongnm', 'truongnm@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Male', NULL, NULL),
(4, 'nhict2', 'nhict2@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Female', NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_report` (`report_id`);

--
-- Chỉ mục cho bảng `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `fk_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
