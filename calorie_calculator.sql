-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 21, 2024 at 08:00 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `calorie_calculator`
--
CREATE DATABASE IF NOT EXISTS `calorie_calculator` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `calorie_calculator`;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add my user', 6, 'add_myuser'),
(22, 'Can change my user', 6, 'change_myuser'),
(23, 'Can delete my user', 6, 'delete_myuser'),
(24, 'Can view my user', 6, 'view_myuser'),
(25, 'Can add prediction', 7, 'add_prediction'),
(26, 'Can change prediction', 7, 'change_prediction'),
(27, 'Can delete prediction', 7, 'delete_prediction'),
(28, 'Can view prediction', 7, 'view_prediction');

-- --------------------------------------------------------

--
-- Table structure for table `calorieapp_myuser`
--

DROP TABLE IF EXISTS `calorieapp_myuser`;
CREATE TABLE IF NOT EXISTS `calorieapp_myuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `contact` varchar(170) DEFAULT NULL,
  `name` varchar(170) DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calorieapp_myuser`
--

INSERT INTO `calorieapp_myuser` (`id`, `password`, `last_login`, `email`, `is_active`, `is_admin`, `contact`, `name`, `pic`) VALUES
(1, 'pbkdf2_sha256$390000$dF3TMnly96EacGarpWKjdz$+LRvyukOmB9BOqRz4PP8cAtFOcSzOYjDx29blF4kOG8=', '2024-05-18 23:01:36.651500', 'john@gmail.com', 1, 0, '9876543210', 'john', 'user/face7.jpg'),
(2, 'pbkdf2_sha256$390000$rTrISKYpuRLTgfGWKxRQkS$Sn/c+QcoZARcfYmUm2W1OEr9ddtrXMAp2XV8hmXdghs=', '2024-05-21 19:59:09.447327', 'codebook.in@gmail.com', 1, 0, '8555887986', 'codebook', 'user/face15.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `calorieapp_prediction`
--

DROP TABLE IF EXISTS `calorieapp_prediction`;
CREATE TABLE IF NOT EXISTS `calorieapp_prediction` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `calorieapp_prediction_user_id_5c895807` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calorieapp_prediction`
--

INSERT INTO `calorieapp_prediction` (`pid`, `img`, `user_id`) VALUES
(1, 'predict/Image_8_e973aSW_pOb6E9P.jpg', 1),
(2, 'predict/Image_2_WGrb2IJ.jpg', 1),
(3, 'predict/Image_24.png', 1),
(4, 'predict/Image_14.jpg', 1),
(5, 'predict/Image_22.jpg', 1),
(6, 'predict/Image_22_fati3gX.jpg', 1),
(7, 'predict/Image_14_vVOu1Qm.jpg', 1),
(8, 'predict/Image_5_2Ks7Vp2.jpg', 2),
(9, 'predict/Image_9.jpg', 2),
(10, 'predict/Image_5_dq2yEiv.jpg', 2),
(11, 'predict/Image_5_tL1Lxd4.jpg', 2),
(12, 'predict/Image_5_eY5LMdK.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(6, 'calorieapp', 'myuser'),
(7, 'calorieapp', 'prediction');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-05-18 22:59:37.650410'),
(2, 'calorieapp', '0001_initial', '2024-05-18 22:59:37.672397'),
(3, 'admin', '0001_initial', '2024-05-18 22:59:37.805322'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-05-18 22:59:37.821313'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-18 22:59:37.834304'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-05-18 22:59:37.888274'),
(7, 'auth', '0001_initial', '2024-05-18 22:59:38.096155'),
(8, 'auth', '0002_alter_permission_name_max_length', '2024-05-18 22:59:38.128138'),
(9, 'auth', '0003_alter_user_email_max_length', '2024-05-18 22:59:38.147126'),
(10, 'auth', '0004_alter_user_username_opts', '2024-05-18 22:59:38.165116'),
(11, 'auth', '0005_alter_user_last_login_null', '2024-05-18 22:59:38.184105'),
(12, 'auth', '0006_require_contenttypes_0002', '2024-05-18 22:59:38.203097'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2024-05-18 22:59:38.221083'),
(14, 'auth', '0008_alter_user_username_max_length', '2024-05-18 22:59:38.237074'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2024-05-18 22:59:38.253065'),
(16, 'auth', '0010_alter_group_name_max_length', '2024-05-18 22:59:38.283047'),
(17, 'auth', '0011_update_proxy_permissions', '2024-05-18 22:59:38.301037'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2024-05-18 22:59:38.315030'),
(19, 'calorieapp', '0002_myuser_contact_myuser_name_myuser_pic', '2024-05-18 22:59:38.380992'),
(20, 'calorieapp', '0003_remove_myuser_date_of_birth', '2024-05-18 22:59:38.404978'),
(21, 'calorieapp', '0004_prediction', '2024-05-18 22:59:38.442957'),
(22, 'calorieapp', '0005_alter_prediction_user', '2024-05-18 22:59:49.289757'),
(23, 'sessions', '0001_initial', '2024-05-18 22:59:49.335731');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('xlb020vb8ids240a1q4zfigcxwarugnn', '.eJxVjDsOwjAQBe_iGln-xdiU9DmDtev14gBypDipEHeHSCmgfTPzXiLBtta09bKkicRFaHH63RDyo7Qd0B3abZZ5busyodwVedAux5nK83q4fwcVev3WdojIbBUzsoYSOHqH3oA-Z22y9UhMmoZg2GJ2SgX02UWmwt440CTeHwopOO0:1s8T3Y:JrM2-1abywrjYvx3bLTpbwMQnRkYYVcjBTWkeWewD5A', '2024-06-01 23:01:36.653500'),
('c00vx82uthyqz1cjc4s00my4vrj01ily', '.eJxVjEEOwiAQRe_C2hCogzAu3fcMZGCoVA0kpV0Z725JutDkr_57eW_haVuz31pa_MziKgZx-v0CxWcqHfCDyr3KWMu6zEF2RR60ybFyet0O9y-QqeWe5XPSMLECC0wuGb1vMFGhsQ7BOkbNcYoYEUBdkCgEVHY3QwK0Tny-2Nk3wQ:1s9Vdd:9KVrZyfjoLbNgSeBkwOGA2XliWfl8U1kCBXbT8BPppw', '2024-06-04 19:59:09.449326');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
