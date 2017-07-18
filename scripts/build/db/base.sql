-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 18, 2017 at 02:14 PM
-- Server version: 5.5.55-cll
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `openface`
--

-- --------------------------------------------------------

--
-- Table structure for table `openface_banned_email`
--

CREATE TABLE `openface_banned_email` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_banned_ip`
--

CREATE TABLE `openface_banned_ip` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IP or IP range',
  `comment` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_direct_messages`
--

CREATE TABLE `openface_direct_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `from` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `to` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_direct_messages_rel`
--

CREATE TABLE `openface_direct_messages_rel` (
  `id` int(10) UNSIGNED NOT NULL,
  `message_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rel` enum('sender','receiver') COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('read','unread') COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_follower`
--

CREATE TABLE `openface_follower` (
  `id` int(10) UNSIGNED NOT NULL,
  `followee_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `follower_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_language`
--

CREATE TABLE `openface_language` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `locale_id` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_3166_1` varchar(5) COLLATE utf8_unicode_ci NOT NULL COMMENT 'http://en.wikipedia.org/wiki/ISO_3166-1',
  `iso_639` varchar(2) COLLATE utf8_unicode_ci NOT NULL COMMENT 'locale',
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `native_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_language`
--

INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(1, 'en-us', 'us', 'en', 'English (U.S.)', 'English (U.S.)', 'English', '1');
INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(2, 'de-de', 'de', 'de', 'Deutsch', 'German', 'Deutsch', '1');
INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(3, 'ru-ru', 'ru', 'ru', 'русский', 'Russian', 'русский', '1');
INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(4, 'tr-tr', 'tr', 'tr', 'Türkçe', 'Turkish', 'Türkçe', '1');
INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(5, 'es-es', 'es', 'es', 'Español', 'Spanish', 'Español', '1');
INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(6, 'zh-tw', 'tw', 'zh', '中國（繁體）', 'Chinese (Traditional)', '中國（繁體）', '1');

-- --------------------------------------------------------

--
-- Table structure for table `openface_metadata`
--

CREATE TABLE `openface_metadata` (
  `id` int(10) UNSIGNED NOT NULL,
  `object_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_mime_types`
--

CREATE TABLE `openface_mime_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `file_extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_mime_types`
--

INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3768, '*', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1, '123', 'application/vnd.lotus-1-2-3');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3581, '323', 'text/h323');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(983, '3dm', 'x-world/x-3dmf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(984, '3dmf', 'x-world/x-3dmf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2, '3dml', 'text/vnd.in3d.3dml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3, '3ds', 'image/x-3ds');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(4, '3g2', 'video/3gpp2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(5, '3gp', 'video/3gpp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(6, '7z', 'application/x-7z-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(985, 'a', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(7, 'aab', 'application/x-authorware-bin');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(8, 'aac', 'audio/x-aac');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(9, 'aam', 'application/x-authorware-map');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(10, 'aas', 'application/x-authorware-seg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(989, 'abc', 'text/vnd.abc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(11, 'abw', 'application/x-abiword');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(12, 'ac', 'application/pkix-attr-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(13, 'acc', 'application/vnd.americandynamics.acc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(14, 'ace', 'application/x-ace-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(990, 'acgi', 'text/html');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(15, 'acu', 'application/vnd.acucobol');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(16, 'acutc', 'application/vnd.acucorp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3582, 'acx', 'application/internet-property-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(17, 'adp', 'audio/adpcm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(18, 'aep', 'application/vnd.audiograph');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(991, 'afl', 'video/animaflex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(19, 'afm', 'application/x-font-type1');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(20, 'afp', 'application/vnd.ibm.modcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(21, 'ahead', 'application/vnd.ahead.space');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(22, 'ai', 'application/postscript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2281, 'aif', 'audio/aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(23, 'aif', 'audio/x-aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2283, 'aifc', 'audio/aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(24, 'aifc', 'audio/x-aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2285, 'aiff', 'audio/aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(25, 'aiff', 'audio/x-aiff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(999, 'aim', 'application/x-aim');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1000, 'aip', 'text/x-audiosoft-intra');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(26, 'air', 'application/vnd.adobe.air-application-installer-package+zip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(27, 'ait', 'application/vnd.dvb.ait');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(28, 'ami', 'application/vnd.amiga.ami');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1001, 'ani', 'application/x-navi-animation');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3560, 'anx', 'application/annodex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1002, 'aos', 'application/x-nokia-9000-communicator-add-on-software');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(29, 'apk', 'application/vnd.android.package-archive');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(30, 'appcache', 'text/cache-manifest');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(31, 'applicatio', 'application/x-ms-application');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(32, 'apr', 'application/vnd.lotus-approach');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1003, 'aps', 'application/mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2292, 'arc', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(33, 'arc', 'application/x-freearc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1005, 'arj', 'application/arj');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2294, 'arj', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1007, 'art', 'image/x-jg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(34, 'asc', 'application/pgp-signature');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(35, 'asf', 'video/x-ms-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(36, 'asm', 'text/x-asm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(37, 'aso', 'application/vnd.accpac.simply.aso');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1010, 'asp', 'text/asp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3588, 'asr', 'video/x-ms-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2299, 'asx', 'application/x-mplayer2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(38, 'asx', 'video/x-ms-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2301, 'asx', 'video/x-ms-asf-plugin');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3579, 'asx', 'video/x-ms-asx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(39, 'atc', 'application/vnd.acucorp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(40, 'atom', 'application/atom+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(41, 'atomcat', 'application/atomcat+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(42, 'atomsvc', 'application/atomsvc+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(43, 'atx', 'application/vnd.antix.game-component');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(44, 'au', 'audio/basic');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2303, 'au', 'audio/x-au');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2304, 'avi', 'application/x-troff-msvideo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2305, 'avi', 'video/avi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2306, 'avi', 'video/msvideo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(45, 'avi', 'video/x-msvideo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1020, 'avs', 'video/avs-video');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(46, 'aw', 'application/applixware');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3562, 'axa', 'audio/annodex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3592, 'axs', 'application/olescript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3561, 'axv', 'video/annodex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(47, 'azf', 'application/vnd.airzip.filesecure.azf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(48, 'azs', 'application/vnd.airzip.filesecure.azs');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(49, 'azw', 'application/vnd.amazon.ebook');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3593, 'bas', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(50, 'bat', 'application/x-msdownload');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(51, 'bcpio', 'application/x-bcpio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(52, 'bdf', 'application/x-font-bdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(53, 'bdm', 'application/vnd.syncml.dm+wbxml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(54, 'bed', 'application/vnd.realvnc.bed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(55, 'bh2', 'application/vnd.fujitsu.oasysprs');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2310, 'bin', 'application/mac-binary');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2311, 'bin', 'application/macbinary');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(56, 'bin', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2313, 'bin', 'application/x-binary');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2314, 'bin', 'application/x-macbinary');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(57, 'blb', 'application/x-blorb');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(58, 'blorb', 'application/x-blorb');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1027, 'bm', 'image/bmp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(59, 'bmi', 'application/vnd.bmi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(60, 'bmp', 'image/bmp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2317, 'bmp', 'image/x-windows-bmp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1030, 'boo', 'application/book');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2319, 'book', 'application/book');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(61, 'book', 'application/vnd.framemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(62, 'box', 'application/vnd.previewsystems.box');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(63, 'boz', 'application/x-bzip2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(64, 'bpk', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1033, 'bsh', 'application/x-bsh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(65, 'btif', 'image/prs.btif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(66, 'bz', 'application/x-bzip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(67, 'bz2', 'application/x-bzip2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2324, 'c', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(68, 'c', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1038, 'c++', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(69, 'c11amc', 'application/vnd.cluetrust.cartomobile-config');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(70, 'c11amz', 'application/vnd.cluetrust.cartomobile-config-pkg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(71, 'c4d', 'application/vnd.clonk.c4group');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(72, 'c4f', 'application/vnd.clonk.c4group');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(73, 'c4g', 'application/vnd.clonk.c4group');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(74, 'c4p', 'application/vnd.clonk.c4group');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(75, 'c4u', 'application/vnd.clonk.c4group');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(76, 'cab', 'application/vnd.ms-cab-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(77, 'caf', 'audio/x-caf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(78, 'cap', 'application/vnd.tcpdump.pcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(79, 'car', 'application/vnd.curl.car');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(80, 'cat', 'application/vnd.ms-pki.seccat');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3598, 'cat', 'application/vnd.ms-pkiseccat');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(81, 'cb7', 'application/x-cbr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(82, 'cba', 'application/x-cbr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(83, 'cbr', 'application/x-cbr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(84, 'cbt', 'application/x-cbr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(85, 'cbz', 'application/x-cbr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2328, 'cc', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(86, 'cc', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1042, 'ccad', 'application/clariscad');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1043, 'cco', 'application/x-cocoa');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(87, 'cct', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(88, 'ccxml', 'application/ccxml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(89, 'cdbcmsg', 'application/vnd.contact.cmsg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2332, 'cdf', 'application/cdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2333, 'cdf', 'application/x-cdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(90, 'cdf', 'application/x-netcdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3574, 'cdg', 'video/x-cdg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(91, 'cdkey', 'application/vnd.mediastation.cdkey');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(92, 'cdmia', 'application/cdmi-capability');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(93, 'cdmic', 'application/cdmi-container');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(94, 'cdmid', 'application/cdmi-domain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(95, 'cdmio', 'application/cdmi-object');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(96, 'cdmiq', 'application/cdmi-queue');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(97, 'cdx', 'chemical/x-cdx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(98, 'cdxml', 'application/vnd.chemdraw+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(99, 'cdy', 'application/vnd.cinderella');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(100, 'cer', 'application/pkix-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2336, 'cer', 'application/x-x509-ca-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(101, 'cfs', 'application/x-cfs-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(102, 'cgm', 'image/cgm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1049, 'cha', 'application/x-chat');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(103, 'chat', 'application/x-chat');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(104, 'chm', 'application/vnd.ms-htmlhelp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(105, 'chrt', 'application/vnd.kde.kchart');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(106, 'cif', 'chemical/x-cif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(107, 'cii', 'application/vnd.anser-web-certificate-issue-initiation');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(108, 'cil', 'application/vnd.ms-artgalry');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(109, 'cla', 'application/vnd.claymore');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2339, 'class', 'application/java');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2340, 'class', 'application/java-byte-code');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(110, 'class', 'application/java-vm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3601, 'class', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2341, 'class', 'application/x-java-class');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(111, 'clkk', 'application/vnd.crick.clicker.keyboard');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(112, 'clkp', 'application/vnd.crick.clicker.palette');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(113, 'clkt', 'application/vnd.crick.clicker.template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(114, 'clkw', 'application/vnd.crick.clicker.wordbank');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(115, 'clkx', 'application/vnd.crick.clicker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(116, 'clp', 'application/x-msclip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(117, 'cmc', 'application/vnd.cosmocaller');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(118, 'cmdf', 'chemical/x-cmdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(119, 'cml', 'chemical/x-cml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(120, 'cmp', 'application/vnd.yellowriver-custom-menu');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(121, 'cmx', 'image/x-cmx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(122, 'cod', 'application/vnd.rim.cod');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3604, 'cod', 'image/cis-cod');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2342, 'com', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(123, 'com', 'application/x-msdownload');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2343, 'com', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(124, 'conf', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(125, 'cpio', 'application/x-cpio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(126, 'cpp', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(127, 'cpt', 'application/mac-compactpro');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2348, 'cpt', 'application/x-compactpro');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2349, 'cpt', 'application/x-cpt');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(128, 'crd', 'application/x-mscardfile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2350, 'crl', 'application/pkcs-crl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(129, 'crl', 'application/pkix-crl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2352, 'crt', 'application/pkix-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(130, 'crt', 'application/x-x509-ca-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2354, 'crt', 'application/x-x509-user-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(131, 'cryptonote', 'application/vnd.rig.cryptonote');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(132, 'csh', 'application/x-csh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2356, 'csh', 'text/x-script.csh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(133, 'csml', 'chemical/x-csml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(134, 'csp', 'application/vnd.commonspace');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2357, 'css', 'application/x-pointplus');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(135, 'css', 'text/css');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(136, 'cst', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(137, 'csv', 'text/csv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(138, 'cu', 'application/cu-seeme');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(139, 'curl', 'text/vnd.curl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(140, 'cww', 'application/prs.cww');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(141, 'cxt', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2359, 'cxx', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(142, 'cxx', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(143, 'dae', 'model/vnd.collada+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(144, 'daf', 'application/vnd.mobius.daf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(145, 'dart', 'application/vnd.dart');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(146, 'dataless', 'application/vnd.fdsn.seed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(147, 'davmount', 'application/davmount+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(148, 'dbk', 'application/docbook+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(149, 'dcr', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(150, 'dcurl', 'text/vnd.curl.dcurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(151, 'dd2', 'application/vnd.oma.dd2+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(152, 'ddd', 'application/vnd.fujixerox.ddd');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(153, 'deb', 'application/x-debian-package');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1073, 'deepv', 'application/x-deepv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(154, 'def', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(155, 'deploy', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(156, 'der', 'application/x-x509-ca-cert');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(157, 'dfac', 'application/vnd.dreamfactory');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(158, 'dgc', 'application/x-dgc-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(159, 'dic', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1076, 'dif', 'video/x-dv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(160, 'dir', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(161, 'dis', 'application/vnd.mobius.dis');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(162, 'dist', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(163, 'distz', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(982, 'divx', 'video/divx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3575, 'divx', 'video/x-divx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(164, 'djv', 'image/vnd.djvu');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(165, 'djvu', 'image/vnd.djvu');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1078, 'dl', 'video/dl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2367, 'dl', 'video/x-dl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(166, 'dll', 'application/x-msdownload');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(167, 'dmg', 'application/x-apple-diskimage');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(168, 'dmp', 'application/vnd.tcpdump.pcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(169, 'dms', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(170, 'dna', 'application/vnd.dna');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(171, 'doc', 'application/msword');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(172, 'docm', 'application/vnd.ms-word.document.macroenabled.12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(173, 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(174, 'dot', 'application/msword');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(175, 'dotm', 'application/vnd.ms-word.template.macroenabled.12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(176, 'dotx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2370, 'dp', 'application/commonground');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(177, 'dp', 'application/vnd.osgi.dp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(178, 'dpg', 'application/vnd.dpgraph');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(179, 'dra', 'audio/vnd.dra');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1083, 'drw', 'application/drafting');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(180, 'dsc', 'text/prs.lines.tag');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(181, 'dssc', 'application/dssc+der');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(182, 'dtb', 'application/x-dtbook+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(183, 'dtd', 'application/xml-dtd');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(184, 'dts', 'audio/vnd.dts');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(185, 'dtshd', 'audio/vnd.dts.hd');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(186, 'dump', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1085, 'dv', 'video/x-dv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(187, 'dvb', 'video/vnd.dvb.file');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(188, 'dvi', 'application/x-dvi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3577, 'dvr-ms', 'video/x-ms-dvr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2375, 'dwf', 'drawing/x-dwf (old)');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(189, 'dwf', 'model/vnd.dwf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2377, 'dwg', 'application/acad');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(190, 'dwg', 'image/vnd.dwg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2379, 'dwg', 'image/x-dwg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2380, 'dxf', 'application/dxf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2381, 'dxf', 'image/vnd.dwg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(191, 'dxf', 'image/vnd.dxf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2382, 'dxf', 'image/x-dwg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(192, 'dxp', 'application/vnd.spotfire.dxp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(193, 'dxr', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(194, 'ecelp4800', 'audio/vnd.nuera.ecelp4800');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(195, 'ecelp7470', 'audio/vnd.nuera.ecelp7470');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(196, 'ecelp9600', 'audio/vnd.nuera.ecelp9600');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(197, 'ecma', 'application/ecmascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(198, 'edm', 'application/vnd.novadigm.edm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(199, 'edx', 'application/vnd.novadigm.edx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(200, 'efif', 'application/vnd.picsel');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(201, 'ei6', 'application/vnd.pg.osasli');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1096, 'el', 'text/x-script.elisp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(202, 'elc', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2385, 'elc', 'application/x-bytecode.elisp (compiled elisp)');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2386, 'elc', 'application/x-elc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(203, 'emf', 'application/x-msmetafile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(204, 'eml', 'message/rfc822');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(205, 'emma', 'application/emma+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(206, 'emz', 'application/x-msmetafile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1099, 'env', 'application/x-envoy');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(207, 'eol', 'audio/vnd.digital-winds');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(208, 'eot', 'application/vnd.ms-fontobject');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(209, 'eps', 'application/postscript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(210, 'epub', 'application/epub+zip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1101, 'es', 'application/x-esrehber');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(211, 'es3', 'application/vnd.eszigno3+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(212, 'esa', 'application/vnd.osgi.subsystem');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(213, 'esf', 'application/vnd.epson.esf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(214, 'et3', 'application/vnd.eszigno3+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(215, 'etx', 'text/x-setext');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(216, 'eva', 'application/x-eva');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2391, 'evy', 'application/envoy');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(217, 'evy', 'application/x-envoy');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2393, 'exe', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(218, 'exe', 'application/x-msdownload');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(219, 'exi', 'application/exi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(220, 'ext', 'application/vnd.novadigm.ext');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(221, 'ez', 'application/andrew-inset');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(222, 'ez2', 'application/vnd.ezpix-album');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(223, 'ez3', 'application/vnd.ezpix-package');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2394, 'f', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(224, 'f', 'text/x-fortran');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(225, 'f4v', 'video/x-f4v');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(226, 'f77', 'text/x-fortran');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2397, 'f90', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(227, 'f90', 'text/x-fortran');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(228, 'fbs', 'image/vnd.fastbidsheet');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(229, 'fcdt', 'application/vnd.adobe.formscentral.fcdt');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(230, 'fcs', 'application/vnd.isac.fcs');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(231, 'fdf', 'application/vnd.fdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(232, 'fe_launch', 'application/vnd.denovo.fcselayout-link');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(233, 'fg5', 'application/vnd.fujitsu.oasysgp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(234, 'fgd', 'application/x-director');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(235, 'fh', 'image/x-freehand');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(236, 'fh4', 'image/x-freehand');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(237, 'fh5', 'image/x-freehand');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(238, 'fh7', 'image/x-freehand');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(239, 'fhc', 'image/x-freehand');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1112, 'fif', 'application/fractals');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2401, 'fif', 'image/fif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(240, 'fig', 'application/x-xfig');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(241, 'flac', 'audio/x-flac');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2402, 'fli', 'video/fli');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(242, 'fli', 'video/x-fli');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(243, 'flo', 'application/vnd.micrografx.flo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2404, 'flo', 'image/florian');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3625, 'flr', 'x-world/x-vrml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3567, 'flv', 'video/flv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(244, 'flv', 'video/x-flv');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(245, 'flw', 'application/vnd.kde.kivio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(246, 'flx', 'text/vnd.fmi.flexstor');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(247, 'fly', 'text/vnd.fly');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(248, 'fm', 'application/vnd.framemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1118, 'fmf', 'video/x-atomic3d-feature');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(249, 'fnc', 'application/vnd.frogans.fnc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2407, 'for', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(250, 'for', 'text/x-fortran');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(251, 'fpx', 'image/vnd.fpx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2410, 'fpx', 'image/vnd.net-fpx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(252, 'frame', 'application/vnd.framemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1123, 'frl', 'application/freeloader');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(253, 'fsc', 'application/vnd.fsc.weblaunch');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(254, 'fst', 'image/vnd.fst');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(255, 'ftc', 'application/vnd.fluxtime.clip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(256, 'fti', 'application/vnd.anser-web-funds-transfer-initiation');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1124, 'funk', 'audio/make');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(257, 'fvt', 'video/vnd.fvt');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(258, 'fxp', 'application/vnd.adobe.fxp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(259, 'fxpl', 'application/vnd.adobe.fxp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(260, 'fzs', 'application/vnd.fuzzysheet');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1125, 'g', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(261, 'g2w', 'application/vnd.geoplan');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(262, 'g3', 'image/g3fax');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(263, 'g3w', 'application/vnd.geospace');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(264, 'gac', 'application/vnd.groove-account');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(265, 'gam', 'application/x-tads');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(266, 'gbr', 'application/rpki-ghostbusters');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(267, 'gca', 'application/x-gca-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(268, 'gdl', 'model/vnd.gdl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(269, 'geo', 'application/vnd.dynageo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(270, 'gex', 'application/vnd.geometry-explorer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(271, 'ggb', 'application/vnd.geogebra.file');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(272, 'ggt', 'application/vnd.geogebra.tool');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(273, 'ghf', 'application/vnd.groove-help');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(274, 'gif', 'image/gif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(275, 'gim', 'application/vnd.groove-identity-message');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1128, 'gl', 'video/gl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2417, 'gl', 'video/x-gl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(276, 'gml', 'application/gml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(277, 'gmx', 'application/vnd.gmx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(278, 'gnumeric', 'application/x-gnumeric');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(279, 'gph', 'application/vnd.flographit');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(280, 'gpx', 'application/gpx+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(281, 'gqf', 'application/vnd.grafeq');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(282, 'gqs', 'application/vnd.grafeq');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(283, 'gram', 'application/srgs');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(284, 'gramps', 'application/x-gramps-xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(285, 'gre', 'application/vnd.geometry-explorer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(286, 'grv', 'application/vnd.groove-injector');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(287, 'grxml', 'application/srgs+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1130, 'gsd', 'audio/x-gsm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(288, 'gsf', 'application/x-font-ghostscript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1131, 'gsm', 'audio/x-gsm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1132, 'gsp', 'application/x-gsp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1133, 'gss', 'application/x-gss');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(289, 'gtar', 'application/x-gtar');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(290, 'gtm', 'application/vnd.groove-tool-message');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(291, 'gtw', 'model/vnd.gtw');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(292, 'gv', 'text/vnd.graphviz');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(293, 'gxf', 'application/gxf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(294, 'gxt', 'application/vnd.geonext');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1135, 'gz', 'application/x-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2424, 'gz', 'application/x-gzip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1137, 'gzip', 'application/x-gzip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2426, 'gzip', 'multipart/x-gzip');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2427, 'h', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(295, 'h', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2428, 'h', 'text/x-h');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(296, 'h261', 'video/h261');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(297, 'h263', 'video/h263');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(298, 'h264', 'video/h264');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(299, 'hal', 'application/vnd.hal+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(300, 'hbci', 'application/vnd.hbci');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(301, 'hdf', 'application/x-hdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1142, 'help', 'application/x-helpfile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1143, 'hgl', 'application/vnd.hp-hpgl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2432, 'hh', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(302, 'hh', 'text/x-c');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2433, 'hh', 'text/x-h');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1146, 'hlb', 'text/x-script');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2435, 'hlp', 'application/hlp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(303, 'hlp', 'application/winhlp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2436, 'hlp', 'application/x-helpfile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2437, 'hlp', 'application/x-winhelp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1150, 'hpg', 'application/vnd.hp-hpgl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(304, 'hpgl', 'application/vnd.hp-hpgl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(305, 'hpid', 'application/vnd.hp-hpid');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(306, 'hps', 'application/vnd.hp-hps');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2440, 'hqx', 'application/binhex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2441, 'hqx', 'application/binhex4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2442, 'hqx', 'application/mac-binhex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(307, 'hqx', 'application/mac-binhex40');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2444, 'hqx', 'application/x-binhex40');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2445, 'hqx', 'application/x-mac-binhex40');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1158, 'hta', 'application/hta');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1159, 'htc', 'text/x-component');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(308, 'htke', 'application/vnd.kenameaapp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(309, 'htm', 'text/html');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(310, 'html', 'text/html');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1162, 'htmls', 'text/html');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1163, 'htt', 'text/webviewhtml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1164, 'htx', 'text/html');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(311, 'hvd', 'application/vnd.yamaha.hv-dic');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(312, 'hvp', 'application/vnd.yamaha.hv-voice');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(313, 'hvs', 'application/vnd.yamaha.hv-script');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(314, 'i2g', 'application/vnd.intergeo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(315, 'icc', 'application/vnd.iccprofile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(316, 'ice', 'x-conference/x-cooltalk');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(317, 'icm', 'application/vnd.iccprofile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(318, 'ico', 'image/x-icon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(319, 'ics', 'text/calendar');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1167, 'idc', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(320, 'ief', 'image/ief');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1169, 'iefs', 'image/ief');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(321, 'ifb', 'text/calendar');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(322, 'ifm', 'application/vnd.shana.informed.formdata');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2458, 'iges', 'application/iges');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(323, 'iges', 'model/iges');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(324, 'igl', 'application/vnd.igloader');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(325, 'igm', 'application/vnd.insors.igm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2460, 'igs', 'application/iges');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(326, 'igs', 'model/iges');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(327, 'igx', 'application/vnd.micrografx.igx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(328, 'iif', 'application/vnd.shana.informed.interchange');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3640, 'iii', 'application/x-iphone');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1174, 'ima', 'application/x-ima');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1175, 'imap', 'application/x-httpd-imap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(329, 'imp', 'application/vnd.accpac.simply.imp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(330, 'ims', 'application/vnd.ms-ims');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(331, 'in', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1176, 'inf', 'application/inf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(332, 'ink', 'application/inkml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(333, 'inkml', 'application/inkml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3641, 'ins', 'application/x-internet-signup');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1177, 'ins', 'application/x-internett-signup');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(334, 'install', 'application/x-install-instructions');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(335, 'iota', 'application/vnd.astraea-software.iota');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1178, 'ip', 'application/x-ip2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(336, 'ipfix', 'application/ipfix');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(337, 'ipk', 'application/vnd.shana.informed.package');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(338, 'irm', 'application/vnd.ibm.rights-management');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(339, 'irp', 'application/vnd.irepository.package+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(340, 'iso', 'application/x-iso9660-image');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3642, 'isp', 'application/x-internet-signup');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1179, 'isu', 'video/x-isvideo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1180, 'it', 'audio/it');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(341, 'itp', 'application/vnd.shana.informed.formtemplate');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1181, 'iv', 'application/x-inventor');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(342, 'ivp', 'application/vnd.immervision-ivp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1182, 'ivr', 'i-world/i-vrml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(343, 'ivu', 'application/vnd.immervision-ivu');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1183, 'ivy', 'application/x-livescreen');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(344, 'jad', 'text/vnd.sun.j2me.app-descriptor');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(345, 'jam', 'application/vnd.jam');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2472, 'jam', 'audio/x-jam');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(346, 'jar', 'application/java-archive');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1185, 'jav', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2474, 'jav', 'text/x-java-source');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2475, 'java', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(347, 'java', 'text/x-java-source');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1189, 'jcm', 'application/x-java-commerce');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1190, 'jfif', 'image/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3643, 'jfif', 'image/pipeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2479, 'jfif', 'image/pjpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1192, 'jfif-tbnl', 'image/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(348, 'jisp', 'application/vnd.jisp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(349, 'jlt', 'application/vnd.hp-jlyt');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(350, 'jnlp', 'application/x-java-jnlp-file');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(351, 'joda', 'application/vnd.joost.joda-archive');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(352, 'jpe', 'image/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2482, 'jpe', 'image/pjpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(353, 'jpeg', 'image/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2484, 'jpeg', 'image/pjpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(354, 'jpg', 'image/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2486, 'jpg', 'image/pjpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(355, 'jpgm', 'video/jpm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(356, 'jpgv', 'video/jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(357, 'jpm', 'video/jpm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1199, 'jps', 'image/x-jps');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3132, 'js', 'application/ecmascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(358, 'js', 'application/javascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2488, 'js', 'application/x-javascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3134, 'js', 'text/ecmascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3133, 'js', 'text/javascript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(359, 'json', 'application/json');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(360, 'jsonml', 'application/jsonml+json');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1205, 'jut', 'image/jutvision');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(361, 'kar', 'audio/midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2491, 'kar', 'music/x-karaoke');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(362, 'karbon', 'application/vnd.kde.karbon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(363, 'kfo', 'application/vnd.kde.kformula');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(364, 'kia', 'application/vnd.kidspiration');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(365, 'kml', 'application/vnd.google-earth.kml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(366, 'kmz', 'application/vnd.google-earth.kmz');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(367, 'kne', 'application/vnd.kinar');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(368, 'knp', 'application/vnd.kinar');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(369, 'kon', 'application/vnd.kde.kontour');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(370, 'kpr', 'application/vnd.kde.kpresenter');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(371, 'kpt', 'application/vnd.kde.kpresenter');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(372, 'kpxx', 'application/vnd.ds-keypoint');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1208, 'ksh', 'application/x-ksh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2493, 'ksh', 'text/x-script.ksh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(373, 'ksp', 'application/vnd.kde.kspread');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(374, 'ktr', 'application/vnd.kahootz');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(375, 'ktx', 'image/ktx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(376, 'ktz', 'application/vnd.kahootz');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(377, 'kwd', 'application/vnd.kde.kword');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(378, 'kwt', 'application/vnd.kde.kword');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1210, 'la', 'audio/nspaudio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2495, 'la', 'audio/x-nspaudio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1212, 'lam', 'audio/x-liveaudio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(379, 'lasxml', 'application/vnd.las.las+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(380, 'latex', 'application/x-latex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(381, 'lbd', 'application/vnd.llamagraphics.life-balance.desktop');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(382, 'lbe', 'application/vnd.llamagraphics.life-balance.exchange+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(383, 'les', 'application/vnd.hhe.lesson-player');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2498, 'lha', 'application/lha');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2499, 'lha', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2500, 'lha', 'application/x-lha');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(384, 'lha', 'application/x-lzh-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1217, 'lhx', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(385, 'link66', 'application/vnd.route66.link66+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(386, 'list', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(387, 'list3820', 'application/vnd.ibm.modcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(388, 'listafp', 'application/vnd.ibm.modcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1219, 'lma', 'audio/nspaudio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2504, 'lma', 'audio/x-nspaudio');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(389, 'lnk', 'application/x-ms-shortcut');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(390, 'log', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(391, 'lostxml', 'application/lost+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(392, 'lrf', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(393, 'lrm', 'application/vnd.ms-lrm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3578, 'lsf', 'video/x-la-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1222, 'lsp', 'application/x-lisp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2507, 'lsp', 'text/x-script.lisp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1224, 'lst', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1225, 'lsx', 'text/x-la-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3651, 'lsx', 'video/x-la-asf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(394, 'ltf', 'application/vnd.frogans.ltf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1226, 'ltx', 'application/x-latex');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(395, 'lvp', 'audio/vnd.lucent.voice');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(396, 'lwp', 'application/vnd.lotus-wordpro');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2511, 'lzh', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2512, 'lzh', 'application/x-lzh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(397, 'lzh', 'application/x-lzh-compressed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1229, 'lzx', 'application/lzx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2514, 'lzx', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2515, 'lzx', 'application/x-lzx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1232, 'm', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2517, 'm', 'text/x-m');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(398, 'm13', 'application/x-msmediaview');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(399, 'm14', 'application/x-msmediaview');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(400, 'm1v', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(401, 'm21', 'application/mp21');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(402, 'm2a', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(403, 'm2v', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(404, 'm3a', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(405, 'm3u', 'audio/x-mpegurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2521, 'm3u', 'audio/x-mpequrl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(406, 'm3u8', 'application/vnd.apple.mpegurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(407, 'm4u', 'video/vnd.mpegurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(408, 'm4v', 'video/x-m4v');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(409, 'ma', 'application/mathematica');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(410, 'mads', 'application/mads+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(411, 'mag', 'application/vnd.ecowin.chart');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(412, 'maker', 'application/vnd.framemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2522, 'man', 'application/x-troff-man');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(413, 'man', 'text/troff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1239, 'map', 'application/x-navimap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(414, 'mar', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2524, 'mar', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(415, 'mathml', 'application/mathml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(416, 'mb', 'application/mathematica');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1241, 'mbd', 'application/mbedlet');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(417, 'mbk', 'application/vnd.mobius.mbk');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(418, 'mbox', 'application/mbox');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1242, 'mc$', 'application/x-magic-cap-package-1.0');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(419, 'mc1', 'application/vnd.medcalcdata');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2527, 'mcd', 'application/mcad');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(420, 'mcd', 'application/vnd.mcd');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2528, 'mcd', 'application/x-mathcad');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1245, 'mcf', 'image/vasa');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2530, 'mcf', 'text/mcf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1247, 'mcp', 'application/netmc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(421, 'mcurl', 'text/vnd.curl.mcurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(422, 'mdb', 'application/x-msaccess');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(423, 'mdi', 'image/vnd.ms-modi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2532, 'me', 'application/x-troff-me');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(424, 'me', 'text/troff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(425, 'mesh', 'model/mesh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(426, 'meta4', 'application/metalink4+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(427, 'metalink', 'application/metalink+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(428, 'mets', 'application/mets+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(429, 'mfm', 'application/vnd.mfmp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(430, 'mft', 'application/rpki-manifest');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(431, 'mgp', 'application/vnd.osgeo.mapguide.package');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(432, 'mgz', 'application/vnd.proteus.magazine');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1249, 'mht', 'message/rfc822');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1250, 'mhtml', 'message/rfc822');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2535, 'mid', 'application/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3661, 'mid', 'audio/mid');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(433, 'mid', 'audio/midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2537, 'mid', 'audio/x-mid');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2538, 'mid', 'audio/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2539, 'mid', 'music/crescendo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2540, 'mid', 'x-music/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2541, 'midi', 'application/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(434, 'midi', 'audio/midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2543, 'midi', 'audio/x-mid');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2544, 'midi', 'audio/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2545, 'midi', 'music/crescendo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2546, 'midi', 'x-music/x-midi');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(435, 'mie', 'application/x-mie');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(436, 'mif', 'application/vnd.mif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2547, 'mif', 'application/x-frame');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2548, 'mif', 'application/x-mif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(437, 'mime', 'message/rfc822');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2550, 'mime', 'www/mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(438, 'mj2', 'video/mj2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1267, 'mjf', 'audio/x-vnd.audioexplosion.mjuicemediafile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(439, 'mjp2', 'video/mj2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1268, 'mjpg', 'video/x-motion-jpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(440, 'mk3d', 'video/x-matroska');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(441, 'mka', 'audio/x-matroska');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(442, 'mks', 'video/x-matroska');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3559, 'mkv', 'application/x-matroska');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(443, 'mkv', 'video/x-matroska');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(444, 'mlp', 'application/vnd.dolby.mlp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1269, 'mm', 'application/base64');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2554, 'mm', 'application/x-meme');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(445, 'mmd', 'application/vnd.chipnuts.karaoke-mmd');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1271, 'mme', 'application/base64');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(446, 'mmf', 'application/vnd.smaf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(447, 'mmr', 'image/vnd.fujixerox.edmics-mmr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(448, 'mng', 'video/x-mng');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(449, 'mny', 'application/x-msmoney');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(450, 'mobi', 'application/x-mobipocket-ebook');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1272, 'mod', 'audio/mod');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2557, 'mod', 'audio/x-mod');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(451, 'mods', 'application/mods+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1274, 'moov', 'video/quicktime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(452, 'mov', 'video/quicktime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(453, 'movie', 'video/x-sgi-movie');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(454, 'mp2', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2562, 'mp2', 'audio/x-mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2563, 'mp2', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3569, 'mp2', 'video/mpeg-2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2564, 'mp2', 'video/x-mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2565, 'mp2', 'video/x-mpeq2a');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(455, 'mp21', 'application/mp21');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(456, 'mp2a', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(457, 'mp3', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2566, 'mp3', 'audio/mpeg3');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2567, 'mp3', 'audio/x-mpeg-3');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2568, 'mp3', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2569, 'mp3', 'video/x-mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(458, 'mp4', 'video/mp4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3570, 'mp4', 'video/mpeg4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(459, 'mp4a', 'audio/mp4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(460, 'mp4s', 'application/mp4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(461, 'mp4v', 'video/mp4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3568, 'mp4v', 'video/mp4v-es');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1286, 'mpa', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2571, 'mpa', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(462, 'mpc', 'application/vnd.mophun.certificate');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2572, 'mpc', 'application/x-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(463, 'mpe', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(464, 'mpeg', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2575, 'mpg', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(465, 'mpg', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(466, 'mpg4', 'video/mp4');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(467, 'mpga', 'audio/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(468, 'mpkg', 'application/vnd.apple.installer+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(469, 'mpm', 'application/vnd.blueice.multipass');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(470, 'mpn', 'application/vnd.mophun.application');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(471, 'mpp', 'application/vnd.ms-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(472, 'mpt', 'application/vnd.ms-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2579, 'mpt', 'application/x-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1296, 'mpv', 'application/x-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3672, 'mpv2', 'video/mpeg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1297, 'mpx', 'application/x-project');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(473, 'mpy', 'application/vnd.ibm.minipay');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(474, 'mqy', 'application/vnd.mobius.mqy');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(475, 'mrc', 'application/marc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(476, 'mrcx', 'application/marcxml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2583, 'ms', 'application/x-troff-ms');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(477, 'ms', 'text/troff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(478, 'mscml', 'application/mediaservercontrol+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(479, 'mseed', 'application/vnd.fdsn.mseed');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(480, 'mseq', 'application/vnd.mseq');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(481, 'msf', 'application/vnd.epson.msf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3862, 'msg', 'application/vnd.ms-outlook');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(482, 'msh', 'model/mesh');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(483, 'msi', 'application/x-msdownload');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(484, 'msl', 'application/vnd.mobius.msl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(485, 'msty', 'application/vnd.muvee.style');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(486, 'mts', 'model/vnd.mts');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(487, 'mus', 'application/vnd.musician');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(488, 'musicxml', 'application/vnd.recordare.musicxml+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1300, 'mv', 'video/x-sgi-movie');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(489, 'mvb', 'application/x-msmediaview');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(490, 'mwf', 'application/vnd.mfer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(491, 'mxf', 'application/mxf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(492, 'mxl', 'application/vnd.recordare.musicxml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(493, 'mxml', 'application/xv+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(494, 'mxs', 'application/vnd.triscape.mxs');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(495, 'mxu', 'video/vnd.mpegurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1301, 'my', 'audio/make');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1302, 'mzz', 'application/x-vnd.audioexplosion.mzz');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(496, 'n-gage', 'application/vnd.nokia.n-gage.symbian.install');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(497, 'n3', 'text/n3');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1303, 'nap', 'image/naplps');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1304, 'naplps', 'image/naplps');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(498, 'nb', 'application/mathematica');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(499, 'nbp', 'application/vnd.wolfram.player');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(500, 'nc', 'application/x-netcdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1306, 'ncm', 'application/vnd.nokia.configuration-message');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(501, 'ncx', 'application/x-dtbncx+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(502, 'nfo', 'text/x-nfo');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(503, 'ngdat', 'application/vnd.nokia.n-gage.data');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1307, 'nif', 'image/x-niff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1308, 'niff', 'image/x-niff');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(504, 'nitf', 'application/vnd.nitf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1309, 'nix', 'application/x-mix-transfer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(505, 'nlu', 'application/vnd.neurolanguage.nlu');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(506, 'nml', 'application/vnd.enliven');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(507, 'nnd', 'application/vnd.noblenet-directory');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(508, 'nns', 'application/vnd.noblenet-sealer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(509, 'nnw', 'application/vnd.noblenet-web');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(510, 'npx', 'image/vnd.net-fpx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(511, 'nsc', 'application/x-conference');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(512, 'nsf', 'application/vnd.lotus-notes');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(513, 'ntf', 'application/vnd.nitf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1311, 'nvd', 'application/x-navidoc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3675, 'nws', 'message/rfc822');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(514, 'nzb', 'application/x-nzb');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1312, 'o', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(515, 'oa2', 'application/vnd.fujitsu.oasys2');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(516, 'oa3', 'application/vnd.fujitsu.oasys3');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(517, 'oas', 'application/vnd.fujitsu.oasys');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(518, 'obd', 'application/x-msbinder');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(519, 'obj', 'application/x-tgif');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(520, 'oda', 'application/oda');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(521, 'odb', 'application/vnd.oasis.opendocument.database');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(522, 'odc', 'application/vnd.oasis.opendocument.chart');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(523, 'odf', 'application/vnd.oasis.opendocument.formula');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(524, 'odft', 'application/vnd.oasis.opendocument.formula-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(525, 'odg', 'application/vnd.oasis.opendocument.graphics');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(526, 'odi', 'application/vnd.oasis.opendocument.image');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(527, 'odm', 'application/vnd.oasis.opendocument.text-master');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(528, 'odp', 'application/vnd.oasis.opendocument.presentation');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(529, 'ods', 'application/vnd.oasis.opendocument.spreadsheet');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(530, 'odt', 'application/vnd.oasis.opendocument.text');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(531, 'oga', 'audio/ogg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(532, 'ogg', 'audio/ogg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3571, 'ogm', 'video/ogm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(533, 'ogv', 'video/ogg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3563, 'ogx', 'application/kate');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(534, 'ogx', 'application/ogg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1314, 'omc', 'application/x-omc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1315, 'omcd', 'application/x-omcdatamaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1316, 'omcr', 'application/x-omcregerator');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(535, 'omdoc', 'application/omdoc+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(536, 'onepkg', 'application/onenote');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(537, 'onetmp', 'application/onenote');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(538, 'onetoc', 'application/onenote');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(539, 'onetoc2', 'application/onenote');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(540, 'opf', 'application/oebps-package+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(541, 'opml', 'text/x-opml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(542, 'oprc', 'application/vnd.palm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(543, 'org', 'application/vnd.lotus-organizer');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(544, 'osf', 'application/vnd.yamaha.openscoreformat');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(545, 'osfpvg', 'application/vnd.yamaha.openscoreformat.osfpvg+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(546, 'otc', 'application/vnd.oasis.opendocument.chart-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(547, 'otf', 'application/x-font-otf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(548, 'otg', 'application/vnd.oasis.opendocument.graphics-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(549, 'oth', 'application/vnd.oasis.opendocument.text-web');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(550, 'oti', 'application/vnd.oasis.opendocument.image-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(551, 'otp', 'application/vnd.oasis.opendocument.presentation-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(552, 'ots', 'application/vnd.oasis.opendocument.spreadsheet-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(553, 'ott', 'application/vnd.oasis.opendocument.text-template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(554, 'oxps', 'application/oxps');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(555, 'oxt', 'application/vnd.openofficeorg.extension');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(556, 'p', 'text/x-pascal');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(557, 'p10', 'application/pkcs10');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2603, 'p10', 'application/x-pkcs10');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2604, 'p12', 'application/pkcs-12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(558, 'p12', 'application/x-pkcs12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1322, 'p7a', 'application/x-pkcs7-signature');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(559, 'p7b', 'application/x-pkcs7-certificates');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(560, 'p7c', 'application/pkcs7-mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2608, 'p7c', 'application/x-pkcs7-mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(561, 'p7m', 'application/pkcs7-mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2610, 'p7m', 'application/x-pkcs7-mime');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(562, 'p7r', 'application/x-pkcs7-certreqresp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(563, 'p7s', 'application/pkcs7-signature');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3683, 'p7s', 'application/x-pkcs7-signature');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(564, 'p8', 'application/pkcs8');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1329, 'part', 'application/pro_eng');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2614, 'pas', 'text/pascal');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(565, 'pas', 'text/x-pascal');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(566, 'paw', 'application/vnd.pawaafile');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(567, 'pbd', 'application/vnd.powerbuilder6');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(568, 'pbm', 'image/x-portable-bitmap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(569, 'pcap', 'application/vnd.tcpdump.pcap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(570, 'pcf', 'application/x-font-pcf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(571, 'pcl', 'application/vnd.hp-pcl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2617, 'pcl', 'application/x-pcl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(572, 'pclxl', 'application/vnd.hp-pclxl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(573, 'pct', 'image/x-pict');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(574, 'pcurl', 'application/vnd.curl.pcurl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(575, 'pcx', 'image/x-pcx');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(576, 'pdb', 'application/vnd.palm');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2620, 'pdb', 'chemical/x-pdb');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(577, 'pdf', 'application/pdf');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(578, 'pfa', 'application/x-font-type1');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(579, 'pfb', 'application/x-font-type1');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(580, 'pfm', 'application/x-font-type1');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(581, 'pfr', 'application/font-tdpfr');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1338, 'pfunk', 'audio/make');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2623, 'pfunk', 'audio/make.my.funk');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(582, 'pfx', 'application/x-pkcs12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(583, 'pgm', 'image/x-portable-graymap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2625, 'pgm', 'image/x-portable-greymap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(584, 'pgn', 'application/x-chess-pgn');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(585, 'pgp', 'application/pgp-encrypted');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2626, 'pic', 'image/pict');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(586, 'pic', 'image/x-pict');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1343, 'pict', 'image/pict');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(587, 'pkg', 'application/octet-stream');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2628, 'pkg', 'application/x-newton-compatible-pkg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(588, 'pki', 'application/pkixcmp');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(589, 'pkipath', 'application/pkix-pkipath');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1345, 'pko', 'application/vnd.ms-pki.pko');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3688, 'pko', 'application/ynd.ms-pkipko');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1346, 'pl', 'text/plain');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2631, 'pl', 'text/x-script.perl');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(590, 'plb', 'application/vnd.3gpp.pic-bw-large');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(591, 'plc', 'application/vnd.mobius.plc');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(592, 'plf', 'application/vnd.pocketlearn');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(593, 'pls', 'application/pls+xml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1348, 'plx', 'application/x-pixclscript');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1349, 'pm', 'image/x-xpixmap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2634, 'pm', 'text/x-script.perl-module');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1351, 'pm4', 'application/x-pagemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1352, 'pm5', 'application/x-pagemaker');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3689, 'pma', 'application/x-perfmon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3690, 'pmc', 'application/x-perfmon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(594, 'pml', 'application/vnd.ctc-posml');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3691, 'pml', 'application/x-perfmon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3692, 'pmr', 'application/x-perfmon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(3693, 'pmw', 'application/x-perfmon');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(595, 'png', 'image/png');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2638, 'pnm', 'application/x-portable-anymap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(596, 'pnm', 'image/x-portable-anymap');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(597, 'portpkg', 'application/vnd.macports.portpkg');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(2640, 'pot', 'application/mspowerpoint');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(598, 'pot', 'application/vnd.ms-powerpoint');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(599, 'potm', 'application/vnd.ms-powerpoint.template.macroenabled.12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(600, 'potx', 'application/vnd.openxmlformats-officedocument.presentationml.template');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1358, 'pov', 'model/x-pov');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(1359, 'ppa', 'application/vnd.ms-powerpoint');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(601, 'ppam', 'application/vnd.ms-powerpoint.addin.macroenabled.12');
INSERT INTO `openface_mime_types` (`id`, `file_extension`, `mime_type`) VALUES(602, 'ppd', 'application/vnd.cups-ppd');

-- --------------------------------------------------------

--
-- Table structure for table `openface_oauth_app`
--

CREATE TABLE `openface_oauth_app` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_url` text COLLATE utf8_unicode_ci,
  `image_file_path` text COLLATE utf8_unicode_ci,
  `date_created` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_oauth_app`
--

INSERT INTO `openface_oauth_app` (`id`, `uuid`, `secret`, `name`, `description`, `image_url`, `image_file_path`, `date_created`) VALUES(1, '684144f0-fdb6-11e3-a3ac-0800200c9a66', 'hvgVeaOFH3lLSRdWU1C6nwKfpnWYjWBdYyXVtvjBAc5ch', 'Example App', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vehicula sem risus, eget luctus tortor fermentum eu. Vestibulum malesuada posuere nulla, id tempor urna lacinia a. Vivamus euismod tempus nisi, ut vulputate lectus blandit in. Pellentesque habita', NULL, NULL, 1403844646);

-- --------------------------------------------------------

--
-- Table structure for table `openface_oauth_token`
--

CREATE TABLE `openface_oauth_token` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('access','request') COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `valid_until` int(10) UNSIGNED DEFAULT NULL,
  `date_created` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_phrase`
--

CREATE TABLE `openface_phrase` (
  `id` int(10) UNSIGNED NOT NULL,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_phrase`
--

INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(1, 1, 'about', 'About');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(2, 1, 'about_us', 'About Us');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(3, 1, 'account_confirmed', 'Account Confirmed');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(4, 1, 'account_created', 'Account Created');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(5, 1, 'add_captions', 'Add Captions');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(6, 1, 'add_files', 'Add Files');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(7, 1, 'add_user', 'Add User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(8, 1, 'admin', 'Admin');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(9, 1, 'ago', 'ago');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(10, 1, 'all', 'All');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(11, 1, 'all_items_loaded', 'All items loaded');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(12, 1, 'all_rights_reserved', 'All Rights Reserved');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(13, 1, 'and', 'and');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(14, 1, 'april', 'April');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(15, 1, 'august', 'August');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(16, 1, 'authentication_failure', 'Authentication Failure');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(17, 1, 'authentication_ok', 'Authentication Successful');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(18, 1, 'authentication_ok_text', 'You were successfully logged in. Let\'s Rock!');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(19, 1, 'authorization', 'Authorization');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(20, 1, 'authorize', 'Authorize');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(21, 1, 'avatar_url', 'Avatar URL');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(22, 1, 'bio', 'Bio');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(23, 1, 'birth_day', 'Birth Day');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(24, 1, 'birth_month', 'Birth Month');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(25, 1, 'birth_year', 'Birth Year');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(26, 1, 'blocked_by_user', 'You are blocked by this user');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(27, 1, 'buy_me', 'Buy Me');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(28, 1, 'by', 'by');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(29, 1, 'can_admin_site', 'Can Administer Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(30, 1, 'can_change_own_password', 'Can Change Own Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(31, 1, 'can_delete_own_account', 'Can Delete Own Account');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(32, 1, 'can_edit_own_profile', 'Can Edit Own Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(33, 1, 'can_upload', 'Can Upload');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(34, 1, 'can_view_debug_messages', 'Can View Debug Messages');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(35, 1, 'can_view_site', 'Can View Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(36, 1, 'can_view_user_profiles', 'Can View User Profiles');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(37, 1, 'cancel', 'Cancel');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(38, 1, 'caption', 'Caption');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(39, 1, 'change_password', 'Change Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(40, 1, 'check_your_email', 'Check your e-mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(41, 1, 'comment', 'Comment');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(42, 1, 'company', 'Company');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(43, 1, 'copyright', 'Copyright');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(44, 1, 'december', 'December');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(45, 1, 'delete', 'Delete');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(46, 1, 'deletion_confirmation', 'Deletion Confirmation');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(47, 1, 'demo_credentials', 'Demo Credentials');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(48, 1, 'direct_messages', 'Direct Messages');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(49, 1, 'directory', 'Directory');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(50, 1, 'duplicate_uploads_forbidden', 'Duplicate uploads forbidden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(51, 1, 'edit', 'Edit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(52, 1, 'edit_profile', 'Edit Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(53, 1, 'email', 'e-mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(54, 1, 'email_confirm', 'Confirm e-mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(55, 1, 'email_or_username', 'e-mail or Username');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(56, 1, 'email_passwordless_login_body', 'Please confirm that you wish to log in to your account by following this URL:  ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(57, 1, 'email_passwordless_login_greeting', 'Hello');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(58, 1, 'email_passwordless_login_subject', 'Password-less Login Confirmation');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(59, 1, 'error', 'Error');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(60, 1, 'error_duplicate_uploads_forbidden', 'Duplicate uploads are forbidden by the Site Administrator. This file is already uploaded to your account.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(61, 1, 'error_exceeds_max_size', 'This file exceeds the maximum permitted file size for this file type.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(62, 1, 'error_occurred', 'An error has occurred.<br>Contact Technical Support if this issue persists.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(63, 1, 'error_upload_image_height', 'This image\'s height is less than the minimum requirement of:  ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(64, 1, 'error_upload_image_width', 'This image\'s width is less than the minimum requirement of:  ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(65, 1, 'error_user_account', 'User Account Error');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(66, 1, 'europe', 'Europe');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(67, 1, 'exception', 'Exception');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(68, 1, 'february', 'February');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(69, 1, 'female', 'Female');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(70, 1, 'file_upload_success', 'YEAH! Your files were successfully uploaded!');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(71, 1, 'files', 'Files');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(72, 1, 'finalize', 'Finalize');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(73, 1, 'finish', 'Finish');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(74, 1, 'first_name', 'First Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(75, 1, 'follow', 'Follow');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(76, 1, 'following', 'Following');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(77, 1, 'forgot_password', 'Forgot Password?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(78, 1, 'forgotten_password', 'Forgotten Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(79, 1, 'from', 'From');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(80, 1, 'gender', 'Gender');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(81, 1, 'global', 'Global');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(82, 1, 'groups', 'Groups');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(83, 1, 'guest', 'Guest');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(84, 1, 'help', 'Help');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(85, 1, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it\'s as easy as pie. It\'s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(86, 1, 'homepage_header', 'Meet Instagram');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(87, 1, 'hours', 'hours');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(88, 1, 'http_error_404_text', 'The document that you have requested does not exist');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(89, 1, 'id', 'ID');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(90, 1, 'january', 'January');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(91, 1, 'job_title', 'Job Title');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(92, 1, 'join_date', 'Join Date');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(93, 1, 'joined', 'Joined');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(94, 1, 'july', 'July');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(95, 1, 'june', 'June');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(96, 1, 'language', 'Language');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(97, 1, 'last_active', 'Last Active');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(98, 1, 'last_ip', 'Last IP');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(99, 1, 'last_login_date', 'Date of Last Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(100, 1, 'last_name', 'Last Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(101, 1, 'last_seen', 'Last Seen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(102, 1, 'like', 'Like');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(103, 1, 'like_or_comment', 'to like or comment');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(104, 1, 'like_this', 'like this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(105, 1, 'like_this_object', 'like this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(106, 1, 'likes_this', 'likes this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(107, 1, 'load_more', 'Load more');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(108, 1, 'loading', 'Loading');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(109, 1, 'login', 'Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(110, 1, 'login_username_does_not_exist', 'Authentication Failure');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(111, 1, 'logoff', 'Logout');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(112, 1, 'logon_to', 'Log on to');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(113, 1, 'logout', 'Logout');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(114, 1, 'maie', 'Male');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(115, 1, 'male', 'Male');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(116, 1, 'march', 'March');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(117, 1, 'may', 'May');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(118, 1, 'media', 'Media');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(119, 1, 'media_deletion', 'Media Deletion');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(120, 1, 'media_options', 'Media Options');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(121, 1, 'message', 'Message');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(122, 1, 'my_account', 'My Account');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(123, 1, 'name', 'Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(124, 1, 'need_to_follow', 'You need to be following');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(125, 1, 'news_feed', 'News Feed');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(126, 1, 'no_files_selected', 'No files selected');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(127, 1, 'no_messages', 'No messages');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(128, 1, 'no_photos_to_display', 'No photos to show.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(129, 1, 'no_recent_photos', 'No Recent Photos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(130, 1, 'no_upload_permission', 'Your account does not have upload permissions');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(131, 1, 'november', 'November');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(132, 1, 'october', 'October');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(133, 1, 'ok', 'OK');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(134, 1, 'on', 'on');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(135, 1, 'orphaned_files', 'Orphaned Files');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(136, 1, 'others_like_this', 'others like this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(137, 1, 'password', 'Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(138, 1, 'password_confirm', 'Password Confirm');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(139, 1, 'password_reset', 'Password Reset');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(140, 1, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(141, 1, 'permission_error_change_own_password', 'Your account has not been granted the \'Change Password\' permission');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(142, 1, 'permission_error_edit_own_profile', 'Your account does not have the \'Edit Profile\' permission');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(143, 1, 'permission_error_view_user_profiles', 'Your account does not have the \'View User Profiles\' permission');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(144, 1, 'phone_number', 'Phone Number');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(145, 1, 'photo', 'Photo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(146, 1, 'phrases_saved', 'Phrases saved');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(147, 1, 'post', 'Post');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(148, 1, 'posted_on_timeline_of', 'posted on timeline of');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(149, 1, 'posts', 'posts');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(150, 1, 'privacy', 'Privacy');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(151, 1, 'private_profile', 'Private Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(152, 1, 'profile', 'Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(153, 1, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(154, 1, 'prompt_comment_delete', 'Comment Deletion');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(155, 1, 'prompt_comment_deletion', 'Are you sure that you wish to delete this comment?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(156, 1, 'prompt_confirm_code_ok', 'Your account has been successfully confirmed');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(157, 1, 'prompt_error_confirm_code', 'The specified account confirmation code does not exist');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(158, 1, 'prompt_error_password_reset', 'An error has occurred while resetting your password. Your password has not been changed.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(159, 1, 'prompt_error_permission', 'Your account does not have sufficient permissions to perform this action.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(160, 1, 'prompt_field_required', 'This field is required');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(161, 1, 'prompt_follow_people', 'Follow friends and interesting people to see their photos here.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(162, 1, 'prompt_how_is_work', 'How is Work?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(163, 1, 'prompt_leave_comment', 'Leave a comment...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(164, 1, 'prompt_media_delete', 'Are you sure that you wish to delete this media item?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(165, 1, 'prompt_message_deletion_confirmation', 'Are you sure that you want to delete this message?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(166, 1, 'prompt_no_likes', 'No one has liked this yet');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(167, 1, 'prompt_password_reset_ok', 'Your password has been reset. Check your e-mail for further details.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(168, 1, 'prompt_suggestions', 'Here are some suggestions.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(169, 1, 'prompt_uploads_complete', 'Your upload(s) have successfully completed.<br>You have the option to upload more files or add captions.<br>Captions are automatically saved.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(170, 1, 'prompt_whats_new', 'What\'s New?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(171, 1, 'prompt_write_comment', 'Write a comment...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(172, 1, 'recaptcha_error', 'reCAPTCHA Error');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(173, 1, 'register', 'Register');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(174, 1, 'reply', 'Reply');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(175, 1, 'report_content', 'Report Inappropriate Content');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(176, 1, 'report_user', 'Report User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(177, 1, 'requested', 'Requested');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(178, 1, 'required_data', 'Required Data');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(179, 1, 'reset', 'Reset');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(180, 1, 'reset_password', 'Reset Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(181, 1, 'save', 'Save');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(182, 1, 'save_changes', 'Save Changes');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(183, 1, 'search', 'Search');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(184, 1, 'select', 'Select');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(185, 1, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(186, 1, 'send', 'Send');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(187, 1, 'september', 'September');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(188, 1, 'signup_ip', 'Signup IP');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(189, 1, 'site', 'Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(190, 1, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(191, 1, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(192, 1, 'site_allow_language_change', 'Allow Language Change');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(193, 1, 'site_allow_signup', 'Allow User Registration');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(194, 1, 'site_allow_social_login', 'Allow Social Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(195, 1, 'site_allow_template_change', 'Allow Template Change');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(196, 1, 'site_allow_url_in_comment', 'Allow URLs in Comments');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(197, 1, 'site_allowed_file_types', 'Allowed File Types');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(198, 1, 'site_allowed_image_types', 'Allow Image Types');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(199, 1, 'site_allowed_video_types', 'Allowed Video Types');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(200, 1, 'site_archive_prefix', 'Archive Prefix');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(201, 1, 'site_avatar_height', 'Avatar Height');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(202, 1, 'site_censor_replacement', 'Censor Replacement');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(203, 1, 'site_censor_replacement_type', 'Censor Replacement');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(204, 1, 'site_comment_fetch_limit', 'Comment Fetch Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(205, 1, 'site_comp_image_limit', 'User Profile Header Image Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(206, 1, 'site_config', 'Site Config');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(207, 1, 'site_cookie_domain', 'Cookie Domain');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(208, 1, 'site_cookie_expiration_date', 'Cookie Expiration Date');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(209, 1, 'site_cookie_path', 'Cookie Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(210, 1, 'site_cookie_timeout', 'Cookie Timeout');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(211, 1, 'site_debug', 'Debug Mode');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(212, 1, 'site_default_admin_preloader_image_path', 'Preloader Image Path (URL)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(213, 1, 'site_default_admin_template', 'Site Admin Template');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(214, 1, 'site_default_admin_template_path', 'Admin Template Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(215, 1, 'site_default_avatar_url', 'Default Avatar URL');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(216, 1, 'site_default_image_resize_type', 'Image Resize Type');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(217, 1, 'site_default_landing_page', 'Default Landing Page (After Login)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(218, 1, 'site_default_landing_page_after_login', 'Default Landing Page after Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(219, 1, 'site_default_language', 'Default Site Language');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(220, 1, 'site_default_max_upload_size', 'Max Upload Size');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(221, 1, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(222, 1, 'site_default_preloader_image_path', 'Site Preloader Image');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(223, 1, 'site_default_template', 'Default Site Template');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(224, 1, 'site_default_usergroup', 'Default Usergroup');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(225, 1, 'site_demo_mode', 'Demo Mode');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(226, 1, 'site_email_address', 'Site e-mail Address');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(227, 1, 'site_facebook_app_id', 'Facebook App ID');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(228, 1, 'site_ffmpeg_path', 'FFMPEG Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(229, 1, 'site_guest_max_file_size', 'Max File Size for Guests');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(230, 1, 'site_guest_max_queue_size', 'Queue Size Limit for Guests');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(231, 1, 'site_guest_max_recipients', 'Max Number of Recipients for Guests');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(232, 1, 'site_guest_total_file_size', 'Total Queue Size for Guests');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(233, 1, 'site_guest_upload_retention', 'Guest Upload Retention');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(234, 1, 'site_guest_usergroup_id', 'Usergroup ID for Guests');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(235, 1, 'site_language', 'Site Language');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(236, 1, 'site_local_theme_url_root', 'Relative URL path of themes');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(237, 1, 'site_medium_image_height', 'Medium Image Height');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(238, 1, 'site_medium_image_width', 'Medium Image Width');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(239, 1, 'site_moderate_new_users', 'Moderate New Users');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(240, 1, 'site_moderate_uploads', 'Moderate Uploads');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(241, 1, 'site_mp4box_path', 'MP4Box Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(242, 1, 'site_name', 'Site Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(243, 1, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(244, 1, 'site_parse_url_in_comment', 'Parse URLs in Comments');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(245, 1, 'site_phrases', 'Site Phrases');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(246, 1, 'site_recaptcha_private_key', 'reCAPTCHA Private Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(247, 1, 'site_recaptcha_public_key', 'reCAPTHCA Public Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(248, 1, 'site_recent_activity_threshold', 'Recent Activity Threshold');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(249, 1, 'site_recent_post_limit', 'Recent Post Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(250, 1, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(251, 1, 'site_rotate_user_comp_header', 'Rotate User Header Images');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(252, 1, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(253, 1, 'site_settings', 'Site Settings');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(254, 1, 'site_show_user_suggestions', 'Display User Suggestions');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(255, 1, 'site_status', 'Status');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(256, 1, 'site_thumbnail_height', 'Thumbnail Height');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(257, 1, 'site_thumbnail_width', 'Thumbnail Width');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(258, 1, 'site_token_max_length', 'Max Token Length');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(259, 1, 'site_token_min_length', 'Minimum token length');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(260, 1, 'site_twitter_api_key', 'Twitter API Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(261, 1, 'site_twitter_api_secret', 'Twitter API Secret');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(262, 1, 'site_upload_dir', 'Path of upload directory ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(263, 1, 'site_upload_dir_users', 'Path of upload directory for end-users');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(264, 1, 'site_url', 'Site URL');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(265, 1, 'site_use_blockui', 'Use BlockUI');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(266, 1, 'site_user_comp_header_flip_interval', 'Header Flip Interval');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(267, 1, 'site_windows_live_client_id', 'Windows Live Client ID');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(268, 1, 'site_windows_live_client_secret', 'Windows Live Client Secret');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(269, 1, 'site_yahoo_app_id', 'Yahoo! App ID');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(270, 1, 'site_yahoo_consumer_key', 'Yahoo! Consumer Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(271, 1, 'site_yahoo_consumer_secret', 'Yahoo! Consumer Secret');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(272, 1, 'site_yahoo_domain', 'Yahoo! Domain');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(273, 1, 'social', 'Social');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(274, 1, 'status_reply_help', 'Press Enter to post');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(275, 1, 'support', 'Support');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(276, 1, 'team', 'Team');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(277, 1, 'template_color', 'Template Color');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(278, 1, 'terms', 'Terms');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(279, 1, 'theme', 'Theme');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(280, 1, 'themes', 'Themes');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(281, 1, 'title', 'Title');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(282, 1, 'to', 'To');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(283, 1, 'to_top', 'Top');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(284, 1, 'today', 'Today');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(285, 1, 'transfer', 'Transfer');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(286, 1, 'try_again', 'Try again');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(287, 1, 'unhandled_exception', 'Unhandled Exception');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(288, 1, 'unlike', 'Unlike');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(289, 1, 'update_successful', 'Update successful');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(290, 1, 'upgrade', 'Upgrade');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(291, 1, 'upgrade_required', 'Upgrade Required');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(292, 1, 'upload', 'Upload');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(293, 1, 'upload_complete', 'Upload Complete');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(294, 1, 'upload_more', 'Upload more');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(295, 1, 'uploaded_files', 'Uploaded Files');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(296, 1, 'user', 'User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(297, 1, 'user_is_private', 'This user is private');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(298, 1, 'user_registration_ok', 'Registration Succeeded');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(299, 1, 'usergroups', 'Usergroups');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(300, 1, 'username', 'Username');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(301, 1, 'username_exists', 'Username exists');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(302, 1, 'users', 'Users');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(303, 1, 'video', 'Video');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(304, 1, 'view_media', 'View Media');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(305, 1, 'view_profile', 'View Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(306, 1, 'website', 'Website');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(307, 1, 'you', 'You');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(308, 1, 'you_are_here', 'You are here');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(309, 1, 'you_like_this', 'You like this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(310, 1, 'your_account', 'Your Account');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(311, 1, 'your_email', 'Your e-mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(312, 1, 'your_friend_email', 'Your friend\'s e-mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(313, 2, 'about', 'Über');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(314, 2, 'about_us', 'Über Uns');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(315, 2, 'account_settings', 'Konto-Einstellungen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(316, 2, 'add_captions', 'Bildunterschriften hinzufügen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(317, 2, 'add_files', 'Dateien hinzufügen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(318, 2, 'ago', 'vorher');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(319, 2, 'all', 'alle');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(320, 2, 'all_items_loaded', 'Alle Einzelteile geladen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(321, 2, 'all_rights_reserved', 'Alle Rechte vorbehalten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(322, 2, 'and', 'und');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(323, 2, 'april', 'April');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(324, 2, 'august', 'August');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(325, 2, 'authentication_ok', 'Authentifizierung erfolgreich');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(326, 2, 'authentication_ok_text', 'Sie sind jetzt angemeldet. Jetzt gehts los.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(327, 2, 'blocked_by_user', 'Sie sind bei dieses Benutzers blockiert');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(328, 2, 'buy_me', 'Kauf mich');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(329, 2, 'by', 'von');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(330, 2, 'cancel', 'Abbrechen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(331, 2, 'caption', 'Bildunterschrift');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(332, 2, 'change_password', 'Kennwort ändern');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(333, 2, 'check_email_verify_login', 'Bitte überprüfen Sie Ihre E-Mail (%EMAIL%), um Ihre Anmeldung zu überprüfen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(334, 2, 'comment', 'Kommentieren');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(335, 2, 'copyright', 'Copyright');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(336, 2, 'december', 'Dezember');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(337, 2, 'delete', 'Löschen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(338, 2, 'demo_credentials', 'Demo Referenzen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(339, 2, 'edit', 'Bearbeiten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(340, 2, 'edit_profile', 'Profil bearbeiten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(341, 2, 'email', 'Email');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(342, 2, 'email_or_username', 'E-Mail oder Benutzername');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(343, 2, 'email_passwordless_login_body', 'Bitte bestätigen Sie, dass Sie sich bei Ihrem Konto anmelden möchten:  ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(344, 2, 'email_passwordless_login_greeting', 'Hallo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(345, 2, 'email_passwordless_login_subject', 'Kennwortlos Anmeldung Bestätigung');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(346, 2, 'error', 'Fehler');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(347, 2, 'error_duplicate_uploads_forbidden', 'Doppelte Uploads werden vom Administrator verboten. Diese Datei ist bereits auf Ihr Konto hochgeladen.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(348, 2, 'error_occurred', 'Ein Fehler ist aufgetreten.<br>Kontaktieren Sie den technischen Support, wenn dieses Problem weiterhin besteht.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(349, 2, 'europe', 'Europa');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(350, 2, 'february', 'Februar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(351, 2, 'file_upload_success', 'Ja! Ihre Dateien wurden erfolgreich hochgeladen!');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(352, 2, 'files', 'Dateien');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(353, 2, 'finalize', 'Fertig');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(354, 2, 'finish', 'Fertig');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(355, 2, 'first_name', 'Vorname');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(356, 2, 'follow', 'Folgen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(357, 2, 'followers', 'Anhänger');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(358, 2, 'following', 'Folgende');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(359, 2, 'forgot_password', 'Passwort vergessen?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(360, 2, 'forgotten_password', 'Passwort vergessen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(361, 2, 'from', 'Von');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(362, 2, 'guest', 'Gast');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(363, 2, 'help', 'Hilfe');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(364, 2, 'homepage_app_description', '<p>\r\nEs ist ein <b>schneller</b>, <b>schöner</b> und <b>lustiger</b> Weg, Deine Freunde durch Bilder an Deinem Leben teilhaben zu lassen.\r\n</p>\r\n<p>\r\nMache ein Bild mit Deinem iPhone, wähle einen Filter, um das Aussehen und die Stimmung des Bildes zu ändern, sende es zu Facebook, Twitter oder Tumblr –  so einfach ist das! Ein ganz neuer Weg, Deine Bilder zu zeigen.\r\n</p>\r\n<p>\r\nUnd haben wir es schon erwähnt? Es ist kostenlos!\r\n</p>');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(365, 2, 'homepage_header', 'Instagram stellt sich vor.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(366, 2, 'hours', 'Stunden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(367, 2, 'http_error_404_text', 'Das Dokument, das Sie angefordert haben existiert nicht');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(368, 2, 'january', 'Januar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(369, 2, 'joined', 'Beigetreten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(370, 2, 'july', 'Juli');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(371, 2, 'june', 'Juni');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(372, 2, 'language', 'Sprache');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(373, 2, 'last_name', 'Nachname');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(374, 2, 'last_seen', 'Zuletzt gesehen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(375, 2, 'like', 'Gefällt mir');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(376, 2, 'like_this', 'mögen diese');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(377, 2, 'like_this_object', 'gefällt das');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(378, 2, 'likes_this', 'gefällt das');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(379, 2, 'load_more', 'laden mehr');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(380, 2, 'loading', 'Laden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(381, 2, 'login', 'Anmelden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(382, 2, 'logoff', 'Abmelden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(383, 2, 'logon_to', 'Melden Sie sich an');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(384, 2, 'logout', 'Abmelden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(385, 2, 'march', 'März');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(386, 2, 'may', 'Mai');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(387, 2, 'media', 'Medien');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(388, 2, 'media_deletion', 'Medien Löschen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(389, 2, 'media_options', 'Medienoptionen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(390, 2, 'message', 'Nachricht');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(391, 2, 'news_feed', 'Nachrichten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(392, 2, 'no_files_selected', 'Keine Dateien ausgewählt');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(393, 2, 'no_messages', 'keine Nachrichten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(394, 2, 'no_recent_photos', 'Kein Aktuelle Fotos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(395, 2, 'november', 'November');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(396, 2, 'october', 'Oktober');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(397, 2, 'on', 'auf');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(398, 2, 'orphaned_files', 'Verwaiste Dateien');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(399, 2, 'others_like_this', 'anderen gefällt das');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(400, 2, 'password', 'Kennwort');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(401, 2, 'password_confirm', 'Kennort Bestätigen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(402, 2, 'password_reset_tip', 'Wir können Ihnen helfen, Ihr Passwort zurückzusetzen mit Ihrem Benutzernamen oder Instagram die E-Mail-Adresse in Verbindung mit Ihrem Konto.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(403, 2, 'permission_error_change_own_password', 'Ihr Konto hat nicht die \"Change Password\" Erlaubnis');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(404, 2, 'permission_error_edit_own_profile', 'Ihr Konto habt nicht die \"Profil bearbeiten\" Berechtigung');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(405, 2, 'photo', 'Bild');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(406, 2, 'phrases', 'Sätze');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(407, 2, 'post', 'Absenden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(408, 2, 'posted_on_timeline_of', 'gepostet auf Chronik von');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(409, 2, 'posts', 'Einträge');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(410, 2, 'privacy', 'Privatsphäre\r\n');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(411, 2, 'prompt_comment_delete', 'Kommentar Löschen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(412, 2, 'prompt_comment_deletion', 'Bist du sicher, dass du diesen Kommentar löschen wollen?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(413, 2, 'prompt_how_is_work', 'Wie ist die Arbeit?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(414, 2, 'prompt_leave_comment', 'Kommentar schreiben...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(415, 2, 'prompt_media_delete', 'Sind Sie sicher, dass Sie diese Medien wirklich löschen wollen?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(416, 2, 'prompt_no_likes', 'Niemand hat diese gefallen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(417, 2, 'prompt_uploads_complete', 'Upload erfolgreich abgeschlossen haben.<br>Sie haben die Möglichkeit, mehr Dateien hochladen oder Bildunterschriften hinzufügen.<br>Untertitel werden automatisch gespeichert.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(418, 2, 'prompt_whats_new', 'Wie läuft\'s bei dir?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(419, 2, 'prompt_write_comment', 'Schreibe einen Kommentar...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(420, 2, 'register', 'Registrieren');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(421, 2, 'reply', 'Antworten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(422, 2, 'report_content', 'Missbrauch bei Moderator melden');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(423, 2, 'requested', 'Angeforderte');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(424, 2, 'reset_password', 'Passwort zurücksetzen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(425, 2, 'save_changes', 'Änderungen speichern');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(426, 2, 'select', 'Wählen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(427, 2, 'september', 'September');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(428, 2, 'settings', 'Einstellungen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(429, 2, 'site', 'Webseite');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(430, 2, 'site_phrases', 'Website-Sätze');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(431, 2, 'site_settings', 'Site-Einstellungen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(432, 2, 'status_reply_help', 'Drücken Sie die Eingabetaste, um zu Posten');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(433, 2, 'support', 'Unterstützung');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(434, 2, 'template_color', 'Schablone Farbe');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(435, 2, 'terms', 'Nutzungsbedingungen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(436, 2, 'themes', 'Thema');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(437, 2, 'to', 'An');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(438, 2, 'to_top', 'Nach oben');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(439, 2, 'today', 'Heute');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(440, 2, 'transfer', 'Übertragen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(441, 2, 'unhandled_exception', 'Unbehandelte Ausnahme');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(442, 2, 'unlike', 'Gefällt mir nicht mehr');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(443, 2, 'upload', 'Hochladen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(444, 2, 'upload_complete', 'Hochladen abgeschlossen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(445, 2, 'upload_more', 'Laden mehrere');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(446, 2, 'uploaded_files', 'Hochgeladene Dateien');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(447, 2, 'user', 'Benutzer');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(448, 2, 'username', 'Benutzername');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(449, 2, 'users', 'Benutzer');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(450, 2, 'view_media', 'Medien Anschauen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(451, 2, 'view_profile', 'Profil ansehen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(452, 2, 'you', 'Du');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(453, 2, 'you_like_this', 'Dir gefällt das');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(454, 2, 'your_account', 'Dein Konto');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(455, 2, 'your_email', 'Ihre E-Mail');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(456, 2, 'your_friend_email', 'Email des Freundes');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(457, 3, 'about_us', 'О нас');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(458, 3, 'add_captions', 'Добавить подписи');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(459, 3, 'admin', 'Admin');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(460, 3, 'ago', 'ago');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(461, 3, 'all_items_loaded', 'Все детали загружен');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(462, 3, 'and', 'и');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(463, 3, 'april', 'апреля');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(464, 3, 'august', 'август');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(465, 3, 'authentication_ok', 'Аутентификация Преемник');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(466, 3, 'authentication_ok_text', 'Вы вошли в систему. Пожалуйста, подождите.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(467, 3, 'avatar_url', 'Avatar URL');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(468, 3, 'bio', 'Bio');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(469, 3, 'birth_day', 'Birth Day');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(470, 3, 'birth_month', 'Birth Month');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(471, 3, 'birth_year', 'Birth Year');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(472, 3, 'blocked_by_user', 'Вы заблокированы на этого пользователя');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(473, 3, 'buy_me', 'Купить этот');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(474, 3, 'by', 'по');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(475, 3, 'can_admin_site', 'Can Administer Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(476, 3, 'can_change_own_password', 'Can Change Own Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(477, 3, 'can_edit_own_profile', 'Can Edit Own Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(478, 3, 'can_upload', 'Can Upload');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(479, 3, 'can_view_debug_messages', 'Can View Debug Messages');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(480, 3, 'can_view_site', 'Can View Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(481, 3, 'can_view_user_profiles', 'Can View User Profiles');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(482, 3, 'cancel', 'отменить');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(483, 3, 'caption', 'подпись');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(484, 3, 'change_password', 'Изменить Пароль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(485, 3, 'comment', 'Comment');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(486, 3, 'december', 'декабрь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(487, 3, 'delete', 'удалять');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(488, 3, 'demo_credentials', 'Демо Полномочия');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(489, 3, 'edit', 'менять');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(490, 3, 'edit_profile', 'Редактировать профиль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(491, 3, 'email', 'е-мейл');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(492, 3, 'email_or_username', 'e-mail or Username');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(493, 3, 'error', 'ошибка');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(494, 3, 'error_duplicate_uploads_forbidden', 'Повторяющиеся добавления запрещено администратором сайта. Этот файл уже закачан на ваш аккаунт.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(495, 3, 'february', 'февраль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(496, 3, 'files', 'файлы');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(497, 3, 'finalize', 'окончательную');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(498, 3, 'finish', 'отделка');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(499, 3, 'first_name', 'Имя');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(500, 3, 'follow', 'следовать');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(501, 3, 'followers', 'последователи');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(502, 3, 'following', 'после');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(503, 3, 'forgot_password', 'Забыли Пароль?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(504, 3, 'gender', 'Gender');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(505, 3, 'guest', 'гость');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(506, 3, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it\'s as easy as pie. It\'s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(507, 3, 'homepage_header', 'Meet Instagram');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(508, 3, 'hours', 'hours');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(509, 3, 'http_error_404_text', 'Sorry, this page could not be found.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(510, 3, 'id', 'ID');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(511, 3, 'january', 'январь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(512, 3, 'join_date', 'Join Date');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(513, 3, 'july', 'июль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(514, 3, 'june', 'июнь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(515, 3, 'language', 'язык');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(516, 3, 'last_active', 'Last Active');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(517, 3, 'last_ip', 'Last IP');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(518, 3, 'last_login_date', 'Date of Last Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(519, 3, 'last_name', 'фамилия');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(520, 3, 'like_or_comment', 'to like or comment');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(521, 3, 'like_this', 'полюбоваться этим');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(522, 3, 'like_this_object', 'like this');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(523, 3, 'likes_this', 'любит это');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(524, 3, 'load_more', 'Загрузить еще');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(525, 3, 'loading', 'загрузка');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(526, 3, 'login', 'Войти');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(527, 3, 'logon_to', 'Войдите на');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(528, 3, 'logout', 'Выход');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(529, 3, 'march', 'март');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(530, 3, 'may', 'мая');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(531, 3, 'media', 'Медиа');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(532, 3, 'media_deletion', 'Медиа Удаление');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(533, 3, 'media_options', 'Опции СМИ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(534, 3, 'my_account', 'Мой аккаунт');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(535, 3, 'name', 'Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(536, 3, 'need_to_follow', 'You need to be following');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(537, 3, 'news_feed', 'Лента новостей');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(538, 3, 'no_files_selected', 'Никакие файлы не выбран');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(539, 3, 'no_photos_to_display', 'No photos to show.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(540, 3, 'no_recent_photos', 'No Recent Photos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(541, 3, 'no_upload_permission', 'Your account does not have upload permissions');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(542, 3, 'november', 'ноябрь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(543, 3, 'october', 'октября');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(544, 3, 'on', 'на');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(545, 3, 'password', 'пароль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(546, 3, 'password_confirm', 'Подтвердите Пароль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(547, 3, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(548, 3, 'permission_error_change_own_password', 'Ваша учетная запись не была предоставлена \"Изменить пароль\" разрешение');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(549, 3, 'permission_error_edit_own_profile', 'Ваша учетная запись не имеет Редактировать профиль разрешение');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(550, 3, 'permission_error_view_user_profiles', 'Your account does not have the \'View User Profiles\' permission');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(551, 3, 'phone_number', 'Phone Number');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(552, 3, 'photo', 'фото');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(553, 3, 'phrases_saved', 'Фразы сохранены');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(554, 3, 'posts', 'пункты');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(555, 3, 'privacy', 'Конфиденциальность');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(556, 3, 'private_profile', 'Private Profile');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(557, 3, 'profile', 'Профиль');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(558, 3, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(559, 3, 'prompt_comment_delete', 'Комментарий Удаление');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(560, 3, 'prompt_comment_deletion', 'Вы уверены, что хотите удалить этот комментарий?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(561, 3, 'prompt_leave_comment', 'Оставить комментарий...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(562, 3, 'prompt_media_delete', 'Вы уверены, что хотите удалить эту композицию?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(563, 3, 'prompt_no_likes', 'Никто не еще это понравилось');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(564, 3, 'prompt_uploads_complete', 'Ваше загрузки успешно завершена.<br>У вас есть возможность загружать несколько файлов или добавить титры.<br>Подписи сохраняются автоматически.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(565, 3, 'prompt_write_comment', 'Написать комментарий...');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(566, 3, 'register', 'Регистрация');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(567, 3, 'report_content', 'Сообщить о недопустимом содержимом');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(568, 3, 'requested', 'запрошенный');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(569, 3, 'reset_password', 'Reset Password');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(570, 3, 'save', 'Сохранить');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(571, 3, 'select', 'выбрать');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(572, 3, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(573, 3, 'september', 'сентябрь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(574, 3, 'signup_ip', 'Signup IP');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(575, 3, 'site', 'Site');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(576, 3, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(577, 3, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(578, 3, 'site_allow_signup', 'Allow User Registration');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(579, 3, 'site_allow_template_change', 'Allow Template Change');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(580, 3, 'site_allow_url_in_comment', 'Allow URLs in Comments');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(581, 3, 'site_allowed_image_types', 'Allow Image Types');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(582, 3, 'site_allowed_video_types', 'Allowed Video Types');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(583, 3, 'site_avatar_height', 'Аватар Высота');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(584, 3, 'site_censor_replacement', 'Censor Replacement');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(585, 3, 'site_censor_replacement_type', 'Censor Replacement');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(586, 3, 'site_comment_fetch_limit', 'Comment Fetch Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(587, 3, 'site_comp_image_limit', 'User Profile Header Image Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(588, 3, 'site_config', 'Конфигурация сайта');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(589, 3, 'site_cookie_domain', 'Cookie Domain');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(590, 3, 'site_cookie_path', 'Cookie Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(591, 3, 'site_cookie_timeout', 'Cookie Timeout');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(592, 3, 'site_debug', 'Debug Mode');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(593, 3, 'site_default_admin_template', 'Site Admin Template');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(594, 3, 'site_default_admin_template_path', 'Admin Template Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(595, 3, 'site_default_avatar_url', 'Default Avatar URL');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(596, 3, 'site_default_image_resize_type', 'Image Resize Type');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(597, 3, 'site_default_landing_page', 'Default Landing Page');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(598, 3, 'site_default_landing_page_after_login', 'Landing Page After Login');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(599, 3, 'site_default_language', 'Default Site Language');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(600, 3, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(601, 3, 'site_default_preloader_image_path', 'Preloader URL Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(602, 3, 'site_default_template', 'Default Site Template');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(603, 3, 'site_default_usergroup', 'Default Usergroup');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(604, 3, 'site_demo_mode', 'Demo Mode');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(605, 3, 'site_ffmpeg_path', 'FFMPEG Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(606, 3, 'site_language', 'Site Language');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(607, 3, 'site_local_theme_url_root', 'Theme Root Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(608, 3, 'site_medium_image_height', 'Medium Image Height');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(609, 3, 'site_medium_image_width', 'Medium Image Width');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(610, 3, 'site_moderate_new_users', 'Moderate New Users');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(611, 3, 'site_mp4box_path', 'MP4Box Path');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(612, 3, 'site_name', 'Site Name');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(613, 3, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(614, 3, 'site_parse_url_in_comment', 'Parse URLs in Comments');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(615, 3, 'site_phrases', 'сайт Фразы');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(616, 3, 'site_recaptcha_private_key', 'reCAPTCHA Private Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(617, 3, 'site_recaptcha_public_key', 'reCAPTHCA Public Key');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(618, 3, 'site_recent_activity_threshold', 'Recent Activity Threshold');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(619, 3, 'site_recent_post_limit', 'Recent Post Limit');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(620, 3, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(621, 3, 'site_rotate_user_comp_header', 'Rotate User Header Images');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(622, 3, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(623, 3, 'site_settings', 'Настройки сайта');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(624, 3, 'site_show_user_suggestions', 'Display User Suggestions');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(625, 3, 'site_status', 'Status');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(626, 3, 'site_thumbnail_height', 'Thumbnail Height');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(627, 3, 'site_thumbnail_width', 'Thumbnail Width');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(628, 3, 'site_upload_dir', 'Upload Diretory');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(629, 3, 'site_upload_dir_users', 'Destination Directory for User Uploads');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(630, 3, 'site_user_comp_header_flip_interval', 'Header Flip Interval');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(631, 3, 'support', 'Support');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(632, 3, 'terms', 'Условия');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(633, 3, 'theme', 'тема');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(634, 3, 'title', 'Title');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(635, 3, 'update_successful', 'Обновление успешно');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(636, 3, 'upgrade', 'модернизация');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(637, 3, 'upload', 'Загрузить');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(638, 3, 'upload_more', 'Загрузить больше');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(639, 3, 'user', 'User');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(640, 3, 'user_is_private', 'This user is private');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(641, 3, 'usergroups', 'Группы');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(642, 3, 'username', 'Имя пользователя');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(643, 3, 'users', 'Пользователи');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(644, 3, 'video', 'видео');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(645, 3, 'view_media', 'Посмотреть СМИ');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(646, 3, 'view_profile', 'Просмотр профиля');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(647, 3, 'website', 'Website');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(648, 3, 'you', 'вы');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(649, 3, 'you_are_here', 'Вы здесь');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(650, 3, 'your_account', 'Ваш аккаунт');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(651, 4, 'add_captions', 'başlık eklemek');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(652, 4, 'april', 'Nisan');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(653, 4, 'august', 'Ağustos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(654, 4, 'authentication_ok', 'Başarılı Kimlik Doğrulama');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(655, 4, 'authentication_ok_text', 'Şimdi kaydedilir. Lütfen bekleyin.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(656, 4, 'buy_me', 'Beni satın');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(657, 4, 'by', 'tarafından');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(658, 4, 'cancel', 'iptal');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(659, 4, 'caption', 'başlık');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(660, 4, 'change_password', 'Şifre Değiştir');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(661, 4, 'december', 'Aralık');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(662, 4, 'delete', 'Silmek');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(663, 4, 'demo_credentials', 'gösteri Kimlik');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(664, 4, 'edit', 'Düzenle');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(665, 4, 'edit_profile', 'Profil Düzenle');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(666, 4, 'email', 'E-posta');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(667, 4, 'error', 'Hata');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(668, 4, 'error_duplicate_uploads_forbidden', 'Yinelenen yüklenenler Sitesi Yöneticisi tarafından yasak. Bu dosya zaten hesabınıza yüklenir.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(669, 4, 'february', 'Şubat');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(670, 4, 'files', 'Dosyalar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(671, 4, 'finalize', 'sonuçlandırmak');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(672, 4, 'finish', 'bitirmek');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(673, 4, 'first_name', 'İsim');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(674, 4, 'followers', 'takipçileri');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(675, 4, 'following', 'aşağıdaki');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(676, 4, 'forgot_password', 'Parolanızı Mı Unuttunuz?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(677, 4, 'guest', 'konuk');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(678, 4, 'january', 'Ocak');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(679, 4, 'july', 'Temmuz');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(680, 4, 'june', 'Haziran');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(681, 4, 'language', 'Dil');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(682, 4, 'last_name', 'Soyadı');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(683, 4, 'like_this', 'bu hayran');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(684, 4, 'loading', 'yükleme');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(685, 4, 'login', 'Oturum Aç');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(686, 4, 'logon_to', 'oturum açma');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(687, 4, 'logout', 'Çıkış');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(688, 4, 'march', 'Mart');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(689, 4, 'may', 'Mayıs');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(690, 4, 'media_deletion', 'Medya Silme');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(691, 4, 'media_options', 'medya seçenekleri');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(692, 4, 'news_feed', 'Haber kaynağı');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(693, 4, 'no_files_selected', 'Seçili dosya yok');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(694, 4, 'november', 'Kasım');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(695, 4, 'october', 'Ekim');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(696, 4, 'on', 'üzerinde');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(697, 4, 'password', 'şifre');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(698, 4, 'password_confirm', 'Şifre Onayla');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(699, 4, 'permission_error_change_own_password', 'Hesabınız \'Şifre Değiştirme\' izni verilmiş değil');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(700, 4, 'permission_error_edit_own_profile', 'Hesabınız \'Profil Düzenle\' izni yok');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(701, 4, 'posts', 'mesajlar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(702, 4, 'prompt_comment_delete', 'Silme Yorum');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(703, 4, 'prompt_comment_deletion', 'Bu yorumu silmek istiyor emin misiniz?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(704, 4, 'prompt_leave_comment', 'Mesaj bırakın');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(705, 4, 'prompt_media_delete', 'Eğer bu medya öğeyi silmek istediğinizden emin misiniz?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(706, 4, 'prompt_no_likes', 'Henüz hiç kimse bu sevdim etti');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(707, 4, 'prompt_uploads_complete', 'Sizin yükleme (lar) başarıyla tamamladınız.<br>Daha fazla dosya yükleyebilir veya başlık eklemek için seçeneğiniz vardır.<br>Başlıklar otomatik olarak kaydedilir.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(708, 4, 'prompt_write_comment', 'Bir Yorum Yazın');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(709, 4, 'register', 'Kayıt');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(710, 4, 'report_content', 'uygunsuz içeriği rapor');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(711, 4, 'reset_password', 'Parola Sıfırlama');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(712, 4, 'select', 'seçmek');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(713, 4, 'september', 'Eylül');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(714, 4, 'theme', 'Motif');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(715, 4, 'top', 'üst');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(716, 4, 'upload', 'Yükle');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(717, 4, 'upload_complete', 'Tam yükle');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(718, 4, 'upload_more', 'daha fazla yüklemek');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(719, 4, 'username', 'Kullanıcı adı');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(720, 4, 'view_media', 'görünümü medya');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(721, 4, 'view_profile', 'Profili');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(722, 4, 'you', 'Sen');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(723, 4, 'your_account', 'Hesabınız');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(724, 5, 'add_captions', 'Añadir títulos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(725, 5, 'all_items_loaded', 'Todos los artículos cargados');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(726, 5, 'april', 'Abril');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(727, 5, 'august', 'Agosto');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(728, 5, 'authentication_ok', 'Autenticación Exitosa');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(729, 5, 'authentication_ok_text', 'Ahora está en el sistema. Por favor, espere.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(730, 5, 'buy_me', 'Compra de mí');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(731, 5, 'cancel', 'Cancelar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(732, 5, 'caption', 'Subtítulo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(733, 5, 'change_password', 'Cambiar La Contraseña');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(734, 5, 'december', 'Diciembre');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(735, 5, 'delete', 'Borrar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(736, 5, 'demo_credentials', 'Credenciales de demostración');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(737, 5, 'edit', 'Editar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(738, 5, 'edit_profile', 'Editar Perfil');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(739, 5, 'error', 'Fracaso');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(740, 5, 'error_duplicate_uploads_forbidden', 'Archivos duplicados están prohibidos por el administrador del sitio. Este archivo ya se ha cargado a su cuenta.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(741, 5, 'february', 'Febrero');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(742, 5, 'files', 'Archivos');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(743, 5, 'finalize', 'Ultimar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(744, 5, 'finish', 'Acabado');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(745, 5, 'followers', 'seguidores');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(746, 5, 'following', 'siguiente');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(747, 5, 'forgot_password', 'Has Olvidado Tu Contraseña?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(748, 5, 'january', 'Enero');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(749, 5, 'july', 'Julio');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(750, 5, 'june', 'Junio');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(751, 5, 'language', 'Idioma');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(752, 5, 'like_this', 'admirar este');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(753, 5, 'load_more', 'Cargar más');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(754, 5, 'loading', 'Cargando');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(755, 5, 'login', 'Iniciar Sesión');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(756, 5, 'logon_to', 'Inicie sesión en');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(757, 5, 'logout', 'Cerrar sesión');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(758, 5, 'march', 'Marzo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(759, 5, 'may', 'Mayo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(760, 5, 'media_deletion', 'Medios Supresión');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(761, 5, 'media_options', 'Opciones de medios');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(762, 5, 'news_feed', 'Suministro de noticias');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(763, 5, 'no_files_selected', 'No hay archivos seleccionados');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(764, 5, 'november', 'Noviembre');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(765, 5, 'october', 'Octubre');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(766, 5, 'on', 'en');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(767, 5, 'others_like_this', 'otros admiran este');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(768, 5, 'password', 'Contraseña');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(769, 5, 'permission_error_change_own_password', 'Tu cuenta no se ha concedido el permiso \'Cambiar Contraseña\'');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(770, 5, 'permission_error_edit_own_profile', 'Su cuenta no tiene permiso \"Editar Perfil\"');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(771, 5, 'posts', 'mensajes');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(772, 5, 'prompt_comment_delete', 'Supresión Comentario');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(773, 5, 'prompt_comment_deletion', '¿Seguro que desea eliminar este comentario?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(774, 5, 'prompt_leave_comment', 'Deja un comentario');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(775, 5, 'prompt_media_delete', '¿Estás seguro que quieres borrar este archivo de medios?');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(776, 5, 'prompt_no_likes', 'Nadie ha gustado esto todavía');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(777, 5, 'prompt_uploads_complete', 'La subida han completado con éxito.<br>Usted tiene la opción de cargar más archivos o añadir subtítulos.<br>Los subtítulos se guardan automáticamente.');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(778, 5, 'prompt_write_comment', 'Escribir un comentario');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(779, 5, 'register', 'Registrarse');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(780, 5, 'report_content', 'Denuncia contenido inapropiado');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(781, 5, 'select', 'Seleccionar');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(782, 5, 'september', 'Septiembre');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(783, 5, 'theme', 'Estilo');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(784, 5, 'upload', 'Subir');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(785, 5, 'upload_complete', 'Carga completa');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(786, 5, 'upload_more', 'Sube más');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(787, 5, 'username', 'Nombre de usuario');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(788, 5, 'view_media', 'Ver página de medios');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(789, 5, 'view_profile', 'Ver Perfil');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(790, 5, 'you', 'Usted');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(791, 5, 'your_account', 'Su cuenta');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(792, 6, 'add_captions', '添加字幕');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(793, 6, 'authentication_failure', '驗證失敗');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(794, 6, 'authentication_ok', '認證成功');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(795, 6, 'authentication_ok_text', '您可以登錄');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(796, 6, 'buy_me', '我買');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(797, 6, 'by', '由');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(798, 6, 'cancel', '取消');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(799, 6, 'change_password', '更改密碼');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(800, 6, 'december', '十二月');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(801, 6, 'delete', '刪除');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(802, 6, 'demo_credentials', '演示證書');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(803, 6, 'edit', '編輯');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(804, 6, 'edit_profile', '編輯個人資料');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(805, 6, 'error', '錯誤');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(806, 6, 'error_duplicate_uploads_forbidden', '重複上傳由站點管理員禁止。此文件已上傳到您的帳戶。');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(807, 6, 'files', '檔');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(808, 6, 'finish', '完');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(809, 6, 'followers', '追隨者');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(810, 6, 'following', '以下');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(811, 6, 'forgot_password', '忘記密碼？');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(812, 6, 'language', '語言');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(813, 6, 'like_this', '佩服這個');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(814, 6, 'loading', '載入中');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(815, 6, 'login', '登錄');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(816, 6, 'logon_to', '登錄到');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(817, 6, 'logout', '註銷');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(818, 6, 'media_deletion', '媒體刪除');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(819, 6, 'media_options', '媒體選項');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(820, 6, 'news_feed', '新聞源');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(821, 6, 'no_files_selected', '未選擇任何文件');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(822, 6, 'on', '上');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(823, 6, 'password', '密碼');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(824, 6, 'photo', '照片');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(825, 6, 'posts', '帖子');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(826, 6, 'prompt_comment_delete', '刪除評論');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(827, 6, 'prompt_comment_deletion', '你確定要刪除此評論嗎？');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(828, 6, 'prompt_leave_comment', '發表評論');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(829, 6, 'prompt_media_delete', '你確定要刪除這個媒體項目？');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(830, 6, 'prompt_no_likes', '沒有人喜歡這個尚未');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(831, 6, 'prompt_uploads_complete', '上載已成功完成。<br>你要上傳多個文件或添加字幕的選項。<br>字幕被自動保存。');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(832, 6, 'prompt_write_comment', '寫評論');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(833, 6, 'register', '註冊');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(834, 6, 'report_content', '舉報不適當的內容');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(835, 6, 'select', '選擇');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(836, 6, 'theme', '主題');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(837, 6, 'upload', '上傳');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(838, 6, 'upload_complete', '上傳完成');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(839, 6, 'upload_more', '上傳更多');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(840, 6, 'username', '用戶名');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(841, 6, 'view_media', '查看媒體頁面');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(842, 6, 'view_profile', '查看資料');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(843, 6, 'you', '你');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(844, 6, 'your_account', '您的帳戶');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(1130, 1, 'check_email_verify_login', 'Please check your e-mail (%EMAIL%) to verify your login request');
INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES(1135, 1, 'date_joined', 'Date Joined');

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_config`
--

CREATE TABLE `openface_site_config` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `possible_values` text COLLATE utf8_unicode_ci,
  `category` enum('admin','global','social','upload','user') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `ui_type` enum('radio','select','text','textarea') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `editable` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `hint` text COLLATE utf8_unicode_ci COMMENT 'hint to present in the UI',
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_site_config`
--

INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(1, 'site_allow_language_change', '1', '0,1', 'global', 'radio', '1', 'Allow Language Change', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(2, 'site_allow_social_login', '0', '0,1', 'social', 'radio', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(3, 'site_allow_template_change', '1', '0,1', 'global', 'radio', '1', 'Allow Template Change', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(4, 'site_allowed_email_domains', '*', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(5, 'site_allowed_file_types', '*', NULL, 'upload', 'text', '1', 'File types allowed for upload. Separate entries with commas. Use * to allow all.', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(6, 'site_cookie_domain', '.openface.org', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(7, 'site_cookie_expiration_date', '3153600000', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(8, 'site_cookie_path', '/', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(9, 'site_cookie_timeout', '3153600000', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(10, 'site_default_admin_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'admin', 'text', '1', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(11, 'site_default_avatar_url', '__BASEURL__/images/profiles/default.png', NULL, 'user', 'text', '1', 'Full URL of the default user avatar', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(12, 'site_default_avatar_url_female', '__BASEURL__/images/profiles/female.png', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(13, 'site_default_avatar_url_small', '__BASEURL__/images/profiles/default/male/nobody_m.32x32.jpg', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(14, 'site_default_date_format', 'F d, Y', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(15, 'site_default_date_time_format', 'F d, Y H:i:s', '', 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(16, 'site_default_landing_page', '', NULL, 'global', 'text', '1', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(17, 'site_default_landing_page_after_login', '', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(18, 'site_default_language', 'en-us', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(19, 'site_default_layout_type', 'fluid', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(20, 'site_default_max_upload_size', '1073741824', NULL, 'upload', 'text', '1', 'Max upload size in bytes', 'in bytes');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(21, 'site_default_preloader_image_path', '<i class=\"fa fa-spinner fa-spin\"></i>', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(22, 'site_default_status_fetch_limit', '50', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(23, 'site_default_template', 'openface', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(24, 'site_default_usergroup_id', '2', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(25, 'site_email_address', 'admin@openface.org', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(26, 'site_email_regex', '/^[A-Za-z]+\\.[A-Za-z]+@(openface)\\.(org)$/', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(27, 'site_email_system', 'mailjet', 'php,mailjet,smtp', 'global', 'select', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(28, 'site_facebook_app_id', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(29, 'site_global_html_body_end', NULL, NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(30, 'site_global_html_body_start', NULL, NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(31, 'site_global_html_header', NULL, NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(32, 'site_guest_max_file_size', '2', NULL, 'upload', 'text', '1', NULL, 'in MB');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(33, 'site_guest_max_queue_size', '5', NULL, 'upload', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(34, 'site_guest_max_recipients', '3', NULL, 'upload', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(35, 'site_guest_total_file_size', '10', NULL, 'upload', 'text', '1', NULL, 'in MB');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(36, 'site_guest_upload_retention', '168', NULL, 'upload', 'text', '1', NULL, 'in hours');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(37, 'site_guest_usergroup_id', '1', NULL, 'user', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(38, 'site_lightbox', 'fresco', 'fresco,lightgallery.js', 'global', 'select', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(39, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', '1', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(40, 'site_login_confirmation_timeout', '86400', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(41, 'site_login_domain_regex_sql', '(openface).(org)$', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(42, 'site_login_type', 'username_password', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(43, 'site_logo_html', '<img src=\"__BASEURL__/images/logo/small.png\" border=\"0\">', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(44, 'site_mailjet_api_public_key', 'dff60041a3d162abc0085342ada40265', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(45, 'site_mailjet_api_secret_key', '896b9a041ba7ff7af853ac6615db037a', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(46, 'site_mailjet_smtp_password', '896b9a041ba7ff7af853ac6615db037a', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(47, 'site_mailjet_smtp_server_host', 'in-v3.mailjet.com', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(48, 'site_mailjet_smtp_server_port', '587', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(49, 'site_mailjet_smtp_username', 'dff60041a3d162abc0085342ada40265', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(50, 'site_moderate_new_users', '1', '0,1', 'user', 'radio', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(51, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(52, 'site_name', 'OpenFace', NULL, 'global', 'text', '1', 'Site Name', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(53, 'site_require_email_confirm', '1', '0,1', 'user', 'radio', '1', 'Require e-mail confirmation for new user registrations', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(54, 'site_required_user_data', 'first_name,last_name,gender', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(55, 'site_stream_type', 'global', 'follow,global', 'global', 'select', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(56, 'site_token_max_length', '15', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(57, 'site_token_min_length', '8', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(58, 'site_twitter_api_key', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(59, 'site_twitter_api_secret', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(60, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(61, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory for end-users', NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(62, 'site_url', '__BASEURL__', NULL, 'global', 'text', '1', NULL, 'including scheme');
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(63, 'site_use_blockui', '1', '1,0', 'global', 'radio', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(64, 'site_windows_live_client_id', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(65, 'site_windows_live_client_secret', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(66, 'site_yahoo_app_id', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(67, 'site_yahoo_consumer_key', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(68, 'site_yahoo_consumer_secret', NULL, NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(69, 'site_yahoo_domain', NULL, NULL, 'social', 'text', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_permission`
--

CREATE TABLE `openface_site_permission` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_type` enum('admin','site','upload','user') COLLATE utf8_unicode_ci DEFAULT 'site',
  `comment` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_site_permission`
--

INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(1, 'can_view_site', 'site', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(2, 'can_upload', 'upload', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(3, 'can_admin_site', 'admin', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(4, 'can_view_debug_messages', 'admin', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(5, 'can_view_user_profiles', 'site', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(6, 'can_edit_own_profile', 'user', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(7, 'can_change_own_password', 'user', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(8, 'can_delete_own_account', 'user', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(9, 'can_admin_site_phrases', 'admin', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(10, 'can_admin_users', 'admin', NULL);
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(11, 'can_admin_files', 'admin', 'Can Administer Uploaded Files (Admin)');
INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(12, 'can_use_firephp', 'admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_theme`
--

CREATE TABLE `openface_site_theme` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('custom','bootstrap','jquery-ui') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'custom',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_site_theme`
--

INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(1, 'bootstrap', 'cerulean', 'Cerulean', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(2, 'bootstrap', 'flatly', 'Flatly', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(4, 'bootstrap', 'slate', 'Slate', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(5, 'bootstrap', 'cosmo', 'Cosmo', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(6, 'bootstrap', 'darkly', 'Darkly', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(7, 'bootstrap', 'cyborg', 'Cyborg', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(8, 'bootstrap', 'journal', 'Journal', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(9, 'bootstrap', 'lumen', 'Lumen', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(10, 'bootstrap', 'readable', 'Readable', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(12, 'bootstrap', 'simplex', 'Simplex', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(13, 'bootstrap', 'spacelab', 'Spacelab', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(14, 'bootstrap', 'superhero', 'Superhero', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(15, 'bootstrap', 'united', 'United', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(16, 'bootstrap', 'bootstrap-theme', 'Bootstrap (w/ theme)', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(17, 'bootstrap', 'yeti', 'Yeti', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(22, 'bootstrap', 'paper', 'Paper', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(23, 'bootstrap', 'openface', 'OpenFace', '1');
INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(24, 'bootstrap', 'ios7', 'iOS 7', '1');

-- --------------------------------------------------------

--
-- Table structure for table `openface_user`
--

CREATE TABLE `openface_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_url` text COLLATE utf8_unicode_ci,
  `url_slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `site_language` bigint(20) UNSIGNED DEFAULT NULL,
  `site_status` enum('banned','pending','confirmed','auto_confirmed','unconfirmed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unconfirmed',
  `date_created` int(10) UNSIGNED NOT NULL,
  `signup_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_upload` int(10) UNSIGNED DEFAULT NULL,
  `last_active` int(10) UNSIGNED DEFAULT NULL,
  `last_login_date` int(10) UNSIGNED DEFAULT NULL,
  `last_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_user`
--

INSERT INTO `openface_user` (`id`, `uuid`, `email`, `first_name`, `last_name`, `password`, `avatar_url`, `url_slug`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'demo@openface.org', 'Demo', 'User', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 'openface', 5, 'auto_confirmed', 1383254334, NULL, NULL, 1500361894, 1500361793, NULL);
INSERT INTO `openface_user` (`id`, `uuid`, `email`, `first_name`, `last_name`, `password`, `avatar_url`, `url_slug`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES(2, '3065674b-c125-4360-9b48-7e988d0484b2', 'example@openface.org', 'Example', 'User', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 'example-user', 1, 'auto_confirmed', 1454275932, NULL, NULL, 1456385629, 1455624096, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup`
--

CREATE TABLE `openface_usergroup` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_usergroup`
--

INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES(0, 'Banned', 'Banned', 'Banned Users');
INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES(1, 'Guest', 'Unauthenticated', 'Guests');
INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES(2, 'User', 'Normal Users', 'Normal Users');
INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES(3, 'Administrator', 'Site Administrators', 'Site Administrators');
INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES(4, 'Demo', 'Demo Users', 'Demo Users');

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup_member`
--

CREATE TABLE `openface_usergroup_member` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `usergroup_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_usergroup_member`
--

INSERT INTO `openface_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES(1, 1, 2);
INSERT INTO `openface_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup_permission`
--

CREATE TABLE `openface_usergroup_permission` (
  `id` int(10) UNSIGNED NOT NULL,
  `usergroup_id` int(10) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_usergroup_permission`
--

INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(16, 2, 1);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(13, 2, 2);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(12, 2, 5);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(1, 3, 1);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(2, 3, 2);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(3, 3, 3);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(4, 3, 4);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(9, 3, 5);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(10, 3, 6);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(11, 3, 7);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(18, 3, 9);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(19, 3, 10);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(20, 3, 11);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(21, 3, 12);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(14, 4, 1);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(15, 4, 2);
INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(17, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_confirm`
--

CREATE TABLE `openface_user_confirm` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_metadata`
--

CREATE TABLE `openface_user_metadata` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_preferences`
--

CREATE TABLE `openface_user_preferences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status`
--

CREATE TABLE `openface_user_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timeline_owner` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` text COLLATE utf8_unicode_ci,
  `privacy` enum('public','friends','only_me','custom') COLLATE utf8_unicode_ci DEFAULT 'public',
  `date` int(10) UNSIGNED NOT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_user_status`
--


-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status_comment`
--

CREATE TABLE `openface_user_status_comment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_user_status_comment`
--

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status_likes`
--

CREATE TABLE `openface_user_status_likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `openface_user_status_likes`
--

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status_media`
--

CREATE TABLE `openface_user_status_media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `file_path` text COLLATE utf8_unicode_ci,
  `url` text COLLATE utf8_unicode_ci,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status_metadata`
--

CREATE TABLE `openface_user_status_metadata` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `openface_banned_email`
--
ALTER TABLE `openface_banned_email`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `openface_banned_ip`
--
ALTER TABLE `openface_banned_ip`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `openface_direct_messages`
--
ALTER TABLE `openface_direct_messages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `date` (`date`),
  ADD KEY `from` (`from`) USING BTREE,
  ADD KEY `to` (`to`) USING BTREE,
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `openface_direct_messages_rel`
--
ALTER TABLE `openface_direct_messages_rel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_uuid` (`message_uuid`) USING BTREE,
  ADD KEY `user_uuid` (`user_uuid`),
  ADD KEY `rel` (`rel`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `openface_follower`
--
ALTER TABLE `openface_follower`
  ADD PRIMARY KEY (`id`),
  ADD KEY `followee_uuid` (`followee_uuid`),
  ADD KEY `follower_uuid` (`follower_uuid`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `openface_language`
--
ALTER TABLE `openface_language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locale_id` (`locale_id`),
  ADD UNIQUE KEY `display_name` (`display_name`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `openface_metadata`
--
ALTER TABLE `openface_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid_key_value` (`object_uuid`,`key`,`value`),
  ADD KEY `key` (`key`),
  ADD KEY `value` (`value`),
  ADD KEY `object_uuid` (`object_uuid`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `openface_mime_types`
--
ALTER TABLE `openface_mime_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `file_extension_mime_type_pair` (`file_extension`,`mime_type`) USING BTREE,
  ADD KEY `file_extension` (`file_extension`),
  ADD KEY `mime` (`mime_type`);

--
-- Indexes for table `openface_oauth_app`
--
ALTER TABLE `openface_oauth_app`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD UNIQUE KEY `secret` (`secret`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `openface_oauth_token`
--
ALTER TABLE `openface_oauth_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `type` (`type`),
  ADD KEY `value` (`value`),
  ADD KEY `valid_until` (`valid_until`),
  ADD KEY `parent_uuid` (`parent_uuid`);

--
-- Indexes for table `openface_phrase`
--
ALTER TABLE `openface_phrase`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `language_id_2` (`language_id`,`name`),
  ADD KEY `language_id` (`language_id`);

--
-- Indexes for table `openface_site_config`
--
ALTER TABLE `openface_site_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `category` (`category`),
  ADD KEY `comment` (`comment`),
  ADD KEY `value` (`value`),
  ADD KEY `editable` (`editable`);

--
-- Indexes for table `openface_site_permission`
--
ALTER TABLE `openface_site_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_name` (`permission_name`,`permission_type`);

--
-- Indexes for table `openface_site_theme`
--
ALTER TABLE `openface_site_theme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `display_name` (`display_name`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `openface_user`
--
ALTER TABLE `openface_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD UNIQUE KEY `url_slug` (`url_slug`),
  ADD KEY `site_language` (`site_language`),
  ADD KEY `signup_ip` (`signup_ip`),
  ADD KEY `last_ip` (`last_ip`),
  ADD KEY `last_login_date` (`last_login_date`),
  ADD KEY `password` (`password`),
  ADD KEY `username_password` (`password`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `last_upload` (`last_upload`),
  ADD KEY `last_active` (`last_active`),
  ADD KEY `first_name` (`first_name`),
  ADD KEY `last_name` (`last_name`);

--
-- Indexes for table `openface_usergroup`
--
ALTER TABLE `openface_usergroup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `openface_usergroup_member`
--
ALTER TABLE `openface_usergroup_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_and_usergroup_id` (`user_id`,`usergroup_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `usergroup_id` (`usergroup_id`);

--
-- Indexes for table `openface_usergroup_permission`
--
ALTER TABLE `openface_usergroup_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usergroup_id_and_permissions_id` (`usergroup_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `openface_user_confirm`
--
ALTER TABLE `openface_user_confirm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `openface_user_metadata`
--
ALTER TABLE `openface_user_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_uuid` (`parent_uuid`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `openface_user_preferences`
--
ALTER TABLE `openface_user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_uuid` (`user_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `openface_user_status`
--
ALTER TABLE `openface_user_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `user_uuid` (`user_uuid`),
  ADD KEY `date` (`date`),
  ADD KEY `ip` (`ip`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `timeline_owner` (`timeline_owner`);

--
-- Indexes for table `openface_user_status_comment`
--
ALTER TABLE `openface_user_status_comment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `parent_uuid` (`parent_uuid`),
  ADD KEY `user_uuid` (`user_uuid`),
  ADD KEY `date` (`date`),
  ADD KEY `reply_to` (`reply_to`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `openface_user_status_likes`
--
ALTER TABLE `openface_user_status_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD UNIQUE KEY `parent_user_pair` (`parent_uuid`,`user_uuid`),
  ADD KEY `parent_uuid` (`parent_uuid`),
  ADD KEY `user_uuid` (`user_uuid`),
  ADD KEY `date` (`date`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `openface_user_status_media`
--
ALTER TABLE `openface_user_status_media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `parent_uuid` (`parent_uuid`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `openface_user_status_metadata`
--
ALTER TABLE `openface_user_status_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_uuid` (`parent_uuid`),
  ADD KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `openface_banned_email`
--
ALTER TABLE `openface_banned_email`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_banned_ip`
--
ALTER TABLE `openface_banned_ip`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_direct_messages`
--
ALTER TABLE `openface_direct_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_direct_messages_rel`
--
ALTER TABLE `openface_direct_messages_rel`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_follower`
--
ALTER TABLE `openface_follower`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_language`
--
ALTER TABLE `openface_language`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `openface_metadata`
--
ALTER TABLE `openface_metadata`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_mime_types`
--
ALTER TABLE `openface_mime_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3863;
--
-- AUTO_INCREMENT for table `openface_oauth_app`
--
ALTER TABLE `openface_oauth_app`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `openface_oauth_token`
--
ALTER TABLE `openface_oauth_token`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_phrase`
--
ALTER TABLE `openface_phrase`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=847;
--
-- AUTO_INCREMENT for table `openface_site_config`
--
ALTER TABLE `openface_site_config`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT for table `openface_site_permission`
--
ALTER TABLE `openface_site_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `openface_site_theme`
--
ALTER TABLE `openface_site_theme`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `openface_user`
--
ALTER TABLE `openface_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `openface_usergroup`
--
ALTER TABLE `openface_usergroup`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `openface_usergroup_member`
--
ALTER TABLE `openface_usergroup_member`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `openface_usergroup_permission`
--
ALTER TABLE `openface_usergroup_permission`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `openface_user_confirm`
--
ALTER TABLE `openface_user_confirm`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_user_metadata`
--
ALTER TABLE `openface_user_metadata`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_user_preferences`
--
ALTER TABLE `openface_user_preferences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_user_status`
--
ALTER TABLE `openface_user_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT for table `openface_user_status_comment`
--
ALTER TABLE `openface_user_status_comment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;
--
-- AUTO_INCREMENT for table `openface_user_status_likes`
--
ALTER TABLE `openface_user_status_likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `openface_user_status_media`
--
ALTER TABLE `openface_user_status_media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `openface_user_status_metadata`
--
ALTER TABLE `openface_user_status_metadata`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `openface_oauth_token`
--
ALTER TABLE `openface_oauth_token`
  ADD CONSTRAINT `openface_oauth_token_ibfk_1` FOREIGN KEY (`parent_uuid`) REFERENCES `openface_oauth_app` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `openface_phrase`
--
ALTER TABLE `openface_phrase`
  ADD CONSTRAINT `openface_phrase_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `openface_language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `openface_user`
--
ALTER TABLE `openface_user`
  ADD CONSTRAINT `openface_user_ibfk_1` FOREIGN KEY (`site_language`) REFERENCES `openface_language` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `openface_usergroup_member`
--
ALTER TABLE `openface_usergroup_member`
  ADD CONSTRAINT `openface_usergroup_member_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `openface_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `openface_usergroup_member_ibfk_2` FOREIGN KEY (`usergroup_id`) REFERENCES `openface_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `openface_usergroup_permission`
--
ALTER TABLE `openface_usergroup_permission`
  ADD CONSTRAINT `openface_usergroup_permission_ibfk_1` FOREIGN KEY (`usergroup_id`) REFERENCES `openface_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `openface_usergroup_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `openface_site_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `openface_user_confirm`
--
ALTER TABLE `openface_user_confirm`
  ADD CONSTRAINT `openface_user_confirm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `openface_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `openface_user_preferences`
--
ALTER TABLE `openface_user_preferences`
  ADD CONSTRAINT `openface_user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `openface_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;