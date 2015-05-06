-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 25, 2015 at 05:39 AM
-- Server version: 5.5.40-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `base_xnami_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `base_banned_email`
--

CREATE TABLE IF NOT EXISTS `base_banned_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `base_banned_ip`
--

CREATE TABLE IF NOT EXISTS `base_banned_ip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IP or IP range',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `base_language`
--

CREATE TABLE IF NOT EXISTS `base_language` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `locale_id` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_3166_1` varchar(5) COLLATE utf8_unicode_ci NOT NULL COMMENT 'http://en.wikipedia.org/wiki/ISO_3166-1',
  `iso_639` varchar(2) COLLATE utf8_unicode_ci NOT NULL COMMENT 'locale',
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `native_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `locale_id` (`locale_id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `base_language`
--

INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(1, 'en-us', 'us', 'en', 'English (U.S.)', 'English (U.S.)', 'English', '1');
INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(2, 'de-de', 'de', 'de', 'Deutsch', 'German', 'Deutsch', '1');
INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(3, 'ru-ru', 'ru', 'ru', 'русский', 'Russian', 'русский', '1');
INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(4, 'tr-tr', 'tr', 'tr', 'Türkçe', 'Turkish', 'Türkçe', '1');
INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(5, 'es-es', 'es', 'es', 'Español', 'Spanish', 'Español', '1');
INSERT INTO `base_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES(6, 'zh-tw', 'tw', 'zh', '中國（繁體）', 'Chinese (Traditional)', '中國（繁體）', '1');

-- --------------------------------------------------------

--
-- Table structure for table `base_metadata`
--

CREATE TABLE IF NOT EXISTS `base_metadata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid_key_value` (`object_uuid`,`key`,`value`),
  KEY `key` (`key`),
  KEY `value` (`value`),
  KEY `object_uuid` (`object_uuid`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `base_oauth_app`
--

CREATE TABLE IF NOT EXISTS `base_oauth_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_url` text COLLATE utf8_unicode_ci,
  `image_file_path` text COLLATE utf8_unicode_ci,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `secret` (`secret`),
  KEY `date_created` (`date_created`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `base_oauth_app`
--

INSERT INTO `base_oauth_app` (`id`, `uuid`, `secret`, `name`, `description`, `image_url`, `image_file_path`, `date_created`) VALUES(1, '684144f0-fdb6-11e3-a3ac-0800200c9a66', 'hvgVeaOFH3lLSRdWU1C6nwKfpnWYjWBdYyXVtvjBAc5ch', 'Example App', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vehicula sem risus, eget luctus tortor fermentum eu. Vestibulum malesuada posuere nulla, id tempor urna lacinia a. Vivamus euismod tempus nisi, ut vulputate lectus blandit in. Pellentesque habita', NULL, NULL, 1403844646);

-- --------------------------------------------------------

--
-- Table structure for table `base_oauth_token`
--

CREATE TABLE IF NOT EXISTS `base_oauth_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('access','request') COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `valid_until` int(10) unsigned DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_created` (`date_created`),
  KEY `type` (`type`),
  KEY `value` (`value`),
  KEY `valid_until` (`valid_until`),
  KEY `parent_uuid` (`parent_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `base_phrase`
--

CREATE TABLE IF NOT EXISTS `base_phrase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_id_2` (`language_id`,`name`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=816 ;

--
-- Dumping data for table `base_phrase`
--

INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(1, 1, 'language', 'Language');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(2, 2, 'language', 'Sprache');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(5, 1, 'upload', 'Upload');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(6, 2, 'upload', 'Hochladen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(7, 1, 'add_files', 'Add Files');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(8, 2, 'add_files', 'Dateien hinzufügen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(9, 1, 'to', 'To');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(10, 2, 'to', 'An');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(13, 1, 'from', 'From');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(14, 2, 'from', 'Von');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(15, 1, 'your_email', 'Your e-mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(16, 2, 'your_email', 'Ihre E-Mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(17, 1, 'your_friend_email', 'Your friend''s e-mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(18, 2, 'your_friend_email', 'Email des Freundes');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(19, 1, 'message', 'Message');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(20, 2, 'message', 'Nachricht');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(21, 1, 'transfer', 'Transfer');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(22, 2, 'transfer', 'Übertragen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(23, 1, 'file_upload_success', 'YEAH! Your files were successfully uploaded!');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(24, 2, 'file_upload_success', 'Ja! Ihre Dateien wurden erfolgreich hochgeladen!');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(25, 1, 'http_error_404_text', 'The document that you have requested does not exist');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(26, 2, 'http_error_404_text', 'Das Dokument, das Sie angefordert haben existiert nicht');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(27, 1, 'site_default_admin_preloader_image_path', 'Preloader Image Path (URL)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(28, 1, 'site_allow_language_change', 'Allow Language Change');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(29, 1, 'site_allow_template_change', 'Allow Template Change');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(30, 1, 'site_allowed_file_types', 'Allowed File Types');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(31, 1, 'site_archive_prefix', 'Archive Prefix');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(32, 1, 'site_default_avatar_url', 'Default Avatar URL');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(33, 1, 'admin', 'Admin');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(34, 1, 'global', 'Global');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(35, 1, 'site_default_landing_page', 'Default Landing Page (After Login)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(36, 1, 'site_default_language', 'Default Site Language');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(37, 1, 'site_default_max_upload_size', 'Max Upload Size');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(38, 1, 'site_default_preloader_image_path', 'Site Preloader Image');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(39, 1, 'site_default_template', 'Default Site Template');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(40, 1, 'site_email_address', 'Site e-mail Address');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(41, 1, 'site_guest_max_file_size', 'Max File Size for Guests');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(42, 1, 'site_guest_max_queue_size', 'Queue Size Limit for Guests');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(43, 1, 'site_guest_max_recipients', 'Max Number of Recipients for Guests');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(44, 1, 'site_guest_total_file_size', 'Total Queue Size for Guests');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(45, 1, 'site_guest_upload_retention', 'Guest Upload Retention');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(46, 1, 'site_local_theme_url_root', 'Relative URL path of themes');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(47, 1, 'site_moderate_new_users', 'Moderate New Users');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(48, 1, 'site_name', 'Site Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(49, 1, 'user', 'User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(50, 1, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(51, 1, 'site_upload_dir_users', 'Path of upload directory for end-users');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(52, 1, 'site_upload_dir', 'Path of upload directory ');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(53, 1, 'site_token_max_length', 'Max Token Length');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(54, 1, 'site_token_min_length', 'Minimum token length');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(55, 1, 'site_settings', 'Site Settings');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(56, 2, 'site_settings', 'Site-Einstellungen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(57, 2, 'user', 'Benutzer');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(58, 2, 'settings', 'Einstellungen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(59, 2, 'site', 'Webseite');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(60, 2, 'phrases', 'Sätze');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(61, 2, 'users', 'Benutzer');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(62, 2, 'all', 'alle');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(63, 2, 'logoff', 'Abmelden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(64, 2, 'account_settings', 'Konto-Einstellungen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(65, 2, 'files', 'Dateien');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(66, 1, 'template_color', 'Template Color');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(67, 2, 'template_color', 'Schablone Farbe');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(68, 1, 'save_changes', 'Save Changes');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(69, 1, 'cancel', 'Cancel');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(70, 2, 'save_changes', 'Änderungen speichern');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(71, 2, 'cancel', 'Abbrechen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(72, 2, 'site_phrases', 'Website-Sätze');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(73, 1, 'site_phrases', 'Site Phrases');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(74, 1, 'logoff', 'Logout');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(75, 1, 'uploaded_files', 'Uploaded Files');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(76, 2, 'uploaded_files', 'Hochgeladene Dateien');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(77, 1, 'orphaned_files', 'Orphaned Files');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(78, 2, 'orphaned_files', 'Verwaiste Dateien');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(79, 1, 'login', 'Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(80, 2, 'login', 'Anmelden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(81, 1, 'forgotten_password', 'Forgotten Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(82, 2, 'forgotten_password', 'Passwort vergessen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(83, 1, 'error', 'Error');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(84, 1, 'login_username_does_not_exist', 'Authentication Failure');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(85, 1, 'authentication_failure', 'Authentication Failure');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(86, 1, 'logout', 'Logout');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(87, 2, 'logout', 'Abmelden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(88, 1, 'help', 'Help');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(89, 2, 'help', 'Hilfe');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(92, 1, 'themes', 'Themes');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(93, 2, 'themes', 'Thema');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(94, 1, 'password', 'Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(95, 2, 'password', 'Kennwort');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(96, 1, 'email', 'e-mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(97, 2, 'email', 'Email');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(98, 1, 'to_top', 'Top');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(99, 2, 'to_top', 'Nach oben');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(100, 1, 'all_rights_reserved', 'All Rights Reserved');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(101, 2, 'all_rights_reserved', 'Alle Rechte vorbehalten');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(102, 1, 'copyright', 'Copyright');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(103, 2, 'copyright', 'Copyright');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(104, 1, 'authorization', 'Authorization');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(105, 1, 'authorize', 'Authorize');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(106, 1, 'search', 'Search');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(107, 1, 'about', 'About');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(108, 1, 'exception', 'Exception');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(109, 1, 'add_user', 'Add User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(110, 1, 'social', 'Social');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(111, 1, 'site_cookie_expiration_date', 'Cookie Expiration Date');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(112, 1, 'site_default_landing_page_after_login', 'Default Landing Page after Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(113, 1, 'site_guest_usergroup_id', 'Usergroup ID for Guests');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(114, 1, 'site_facebook_app_id', 'Facebook App ID');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(115, 1, 'site_moderate_uploads', 'Moderate Uploads');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(116, 1, 'site_url', 'Site URL');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(117, 1, 'site_use_blockui', 'Use BlockUI');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(118, 1, 'site_allow_social_login', 'Allow Social Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(119, 1, 'site_twitter_api_key', 'Twitter API Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(120, 1, 'site_twitter_api_secret', 'Twitter API Secret');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(121, 1, 'site_windows_live_client_id', 'Windows Live Client ID');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(122, 1, 'site_windows_live_client_secret', 'Windows Live Client Secret');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(123, 1, 'site_yahoo_app_id', 'Yahoo! App ID');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(124, 1, 'site_yahoo_consumer_key', 'Yahoo! Consumer Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(125, 1, 'site_yahoo_consumer_secret', 'Yahoo! Consumer Secret');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(126, 1, 'site_yahoo_domain', 'Yahoo! Domain');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(127, 1, 'your_account', 'Your Account');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(128, 1, 'about_us', 'About Us');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(129, 1, 'support', 'Support');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(130, 1, 'privacy', 'Privacy');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(131, 1, 'terms', 'Terms');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(132, 2, 'your_account', 'Dein Konto');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(133, 2, 'about_us', 'Über Uns');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(134, 2, 'terms', 'Nutzungsbedingungen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(135, 2, 'privacy', 'Privatsphäre\r\n');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(136, 1, 'homepage_header', 'Meet Instagram');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(137, 2, 'homepage_header', 'Instagram stellt sich vor.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(138, 2, 'homepage_app_description', '<p>\r\nEs ist ein <b>schneller</b>, <b>schöner</b> und <b>lustiger</b> Weg, Deine Freunde durch Bilder an Deinem Leben teilhaben zu lassen.\r\n</p>\r\n<p>\r\nMache ein Bild mit Deinem iPhone, wähle einen Filter, um das Aussehen und die Stimmung des Bildes zu ändern, sende es zu Facebook, Twitter oder Tumblr –  so einfach ist das! Ein ganz neuer Weg, Deine Bilder zu zeigen.\r\n</p>\r\n<p>\r\nUnd haben wir es schon erwähnt? Es ist kostenlos!\r\n</p>');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(139, 1, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it''s as easy as pie. It''s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(140, 1, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(141, 1, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(144, 1, 'user_is_private', 'This user is private');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(145, 1, 'need_to_follow', 'You need to be following');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(146, 1, 'like_or_comment', 'to like or comment');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(147, 1, 'no_photos_to_display', 'No photos to show.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(148, 1, 'no_upload_permission', 'Your account does not have upload permissions');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(151, 1, 'permission_error_edit_own_profile', 'Your account does not have the ''Edit Profile'' permission');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(152, 1, 'permission_error_change_own_password', 'Your account has not been granted the ''Change Password'' permission');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(153, 1, 'permission_error_view_user_profiles', 'Your account does not have the ''View User Profiles'' permission');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(154, 1, 'no_recent_photos', 'No Recent Photos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(155, 2, 'no_recent_photos', 'Kein Aktuelle Fotos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(158, 1, 'you', 'You');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(159, 2, 'you', 'Du');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(160, 1, 'like_this_object', 'like this');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(161, 2, 'like_this_object', 'gefällt das');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(162, 1, 'forgot_password', 'Forgot Password?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(163, 2, 'forgot_password', 'Passwort vergessen?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(164, 1, 'reset_password', 'Reset Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(165, 2, 'reset_password', 'Passwort zurücksetzen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(168, 1, 'register', 'Register');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(169, 2, 'register', 'Registrieren');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(170, 1, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(171, 2, 'password_reset_tip', 'Wir können Ihnen helfen, Ihr Passwort zurückzusetzen mit Ihrem Benutzernamen oder Instagram die E-Mail-Adresse in Verbindung mit Ihrem Konto.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(172, 1, 'email_or_username', 'e-mail or Username');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(173, 2, 'email_or_username', 'E-Mail oder Benutzername');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(174, 2, 'support', 'Unterstützung');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(175, 1, 'username', 'Username');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(176, 2, 'username', 'Benutzername');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(181, 1, 'first_name', 'First Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(182, 1, 'last_name', 'Last Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(183, 1, 'ago', 'ago');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(184, 2, 'ago', 'vorher');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(185, 1, 'hours', 'hours');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(186, 2, 'hours', 'Stunden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(189, 1, 'site_allow_signup', 'Allow User Registration');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(193, 1, 'site_thumbnail_height', 'Thumbnail Height');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(194, 1, 'site_thumbnail_width', 'Thumbnail Width');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(195, 1, 'site_allowed_image_types', 'Allow Image Types');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(196, 1, 'site_allowed_video_types', 'Allowed Video Types');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(197, 1, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(198, 1, 'site_comp_image_limit', 'User Profile Header Image Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(199, 1, 'site_medium_image_height', 'Medium Image Height');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(200, 1, 'site_medium_image_width', 'Medium Image Width');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(201, 1, 'site_default_admin_template', 'Site Admin Template');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(202, 1, 'site_default_admin_template_path', 'Admin Template Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(203, 1, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(206, 1, 'site_default_image_resize_type', 'Image Resize Type');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(207, 1, 'site_rotate_user_comp_header', 'Rotate User Header Images');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(208, 1, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(209, 1, 'site_user_comp_header_flip_interval', 'Header Flip Interval');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(210, 1, 'site_ffmpeg_path', 'FFMPEG Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(211, 1, 'site_comment_fetch_limit', 'Comment Fetch Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(212, 1, 'site_allow_url_in_comment', 'Allow URLs in Comments');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(213, 1, 'site_parse_url_in_comment', 'Parse URLs in Comments');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(214, 1, 'site_censor_replacement', 'Censor Replacement');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(215, 1, 'site_censor_replacement_type', 'Censor Replacement');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(216, 1, 'site_debug', 'Debug Mode');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(218, 1, 'site_cookie_timeout', 'Cookie Timeout');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(219, 1, 'site_cookie_path', 'Cookie Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(220, 1, 'site_recaptcha_public_key', 'reCAPTHCA Public Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(221, 1, 'site_recaptcha_private_key', 'reCAPTCHA Private Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(223, 1, 'site_cookie_domain', 'Cookie Domain');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(224, 1, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(227, 1, 'site_default_usergroup', 'Default Usergroup');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(228, 1, 'site_demo_mode', 'Demo Mode');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(230, 1, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(231, 1, 'site_recent_activity_threshold', 'Recent Activity Threshold');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(232, 1, 'site_recent_post_limit', 'Recent Post Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(234, 1, 'id', 'ID');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(235, 1, 'site_status', 'Status');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(236, 1, 'signup_ip', 'Signup IP');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(237, 1, 'last_ip', 'Last IP');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(238, 1, 'join_date', 'Join Date');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(239, 1, 'last_active', 'Last Active');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(240, 1, 'edit', 'Edit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(241, 1, 'site_show_user_suggestions', 'Display User Suggestions');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(242, 1, 'site_mp4box_path', 'MP4Box Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(243, 1, 'last_login_date', 'Date of Last Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(244, 1, 'private_profile', 'Private Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(245, 1, 'avatar_url', 'Avatar URL');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(246, 1, 'title', 'Title');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(247, 1, 'phone_number', 'Phone Number');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(248, 1, 'birth_month', 'Birth Month');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(249, 1, 'birth_day', 'Birth Day');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(250, 1, 'birth_year', 'Birth Year');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(251, 1, 'gender', 'Gender');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(252, 1, 'bio', 'Bio');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(253, 1, 'website', 'Website');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(254, 1, 'site_language', 'Site Language');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(255, 1, 'name', 'Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(256, 1, 'comment', 'Comment');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(257, 1, 'can_view_site', 'Can View Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(258, 1, 'can_upload', 'Can Upload');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(259, 1, 'can_admin_site', 'Can Administer Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(260, 1, 'can_view_debug_messages', 'Can View Debug Messages');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(261, 1, 'can_view_user_profiles', 'Can View User Profiles');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(262, 1, 'can_edit_own_profile', 'Can Edit Own Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(263, 1, 'can_change_own_password', 'Can Change Own Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(264, 1, 'site', 'Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(267, 1, 'news_feed', 'News Feed');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(268, 1, 'duplicate_uploads_forbidden', 'Duplicate uploads forbidden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(269, 1, 'buy_me', 'Buy Me');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(270, 1, 'error_upload_image_height', 'This image''s height is less than the minimum requirement of:  ');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(271, 1, 'error_upload_image_width', 'This image''s width is less than the minimum requirement of:  ');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(272, 1, 'error_duplicate_uploads_forbidden', 'Duplicate uploads are forbidden by the Site Administrator. This file is already uploaded to your account.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(273, 3, 'username', 'Имя пользователя');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(274, 3, 'login', 'Войти');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(275, 3, 'password', 'пароль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(276, 3, 'register', 'Регистрация');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(277, 3, 'forgot_password', 'Забыли Пароль?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(278, 3, 'language', 'язык');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(279, 3, 'theme', 'тема');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(280, 1, 'logon_to', 'Log on to');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(281, 3, 'logon_to', 'Войдите на');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(282, 2, 'logon_to', 'Melden Sie sich an');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(283, 3, 'logout', 'Выход');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(284, 1, 'view_profile', 'View Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(285, 1, 'edit_profile', 'Edit Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(286, 3, 'upload', 'Загрузить');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(287, 3, 'buy_me', 'Купить этот');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(288, 3, 'view_profile', 'Просмотр профиля');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(289, 3, 'edit_profile', 'Редактировать профиль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(290, 1, 'prompt_write_comment', 'Write a comment...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(291, 2, 'prompt_write_comment', 'Schreibe einen Kommentar...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(292, 3, 'prompt_write_comment', 'Написать комментарий...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(293, 3, 'you', 'вы');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(294, 3, 'like_this', 'полюбоваться этим');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(295, 2, 'like_this', 'mögen diese');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(296, 2, 'likes_this', 'gefällt das');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(297, 3, 'likes_this', 'любит это');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(298, 1, 'prompt_no_likes', 'No one has liked this yet');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(299, 3, 'prompt_no_likes', 'Никто не еще это понравилось');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(300, 2, 'prompt_no_likes', 'Niemand hat diese gefallen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(301, 2, 'others_like_this', 'anderen gefällt das');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(302, 1, 'like_this', 'like this');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(303, 1, 'others_like_this', 'others like this');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(305, 1, 'report_content', 'Report Inappropriate Content');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(306, 1, 'view_media', 'View Media');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(307, 1, 'media_options', 'Media Options');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(309, 2, 'view_profile', 'Profil ansehen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(310, 2, 'edit_profile', 'Profil bearbeiten');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(311, 2, 'buy_me', 'Kauf mich');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(315, 3, 'cancel', 'отменить');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(316, 3, 'media_options', 'Опции СМИ');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(317, 3, 'view_media', 'Посмотреть СМИ');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(318, 3, 'report_content', 'Сообщить о недопустимом содержимом');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(319, 2, 'report_content', 'Missbrauch bei Moderator melden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(320, 2, 'media_options', 'Medienoptionen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(321, 2, 'view_media', 'Medien Anschauen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(322, 1, 'and', 'and');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(323, 2, 'and', 'und');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(324, 3, 'and', 'и');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(325, 1, 'prompt_leave_comment', 'Leave a comment...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(326, 2, 'prompt_leave_comment', 'Kommentar schreiben...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(327, 3, 'prompt_leave_comment', 'Оставить комментарий...');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(328, 1, 'change_password', 'Change Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(329, 3, 'change_password', 'Изменить Пароль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(330, 3, 'your_account', 'Ваш аккаунт');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(331, 3, 'news_feed', 'Лента новостей');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(332, 2, 'news_feed', 'Nachrichten');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(333, 1, 'select', 'Select');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(334, 2, 'select', 'Wählen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(335, 3, 'select', 'выбрать');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(336, 1, 'files', 'Files');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(337, 3, 'files', 'файлы');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(339, 1, 'finish', 'Finish');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(340, 2, 'finish', 'Fertig');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(341, 3, 'finish', 'отделка');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(342, 1, 'no_files_selected', 'No files selected');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(343, 3, 'no_files_selected', 'Никакие файлы не выбран');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(344, 2, 'no_files_selected', 'Keine Dateien ausgewählt');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(345, 3, 'permission_error_edit_own_profile', 'Ваша учетная запись не имеет Редактировать профиль разрешение');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(346, 3, 'error', 'ошибка');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(347, 2, 'error', 'Fehler');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(348, 2, 'change_password', 'Kennwort ändern');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(349, 2, 'permission_error_edit_own_profile', 'Ihr Konto habt nicht die "Profil bearbeiten" Berechtigung');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(350, 1, 'finalize', 'Finalize');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(351, 2, 'finalize', 'Fertig');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(352, 3, 'finalize', 'окончательную');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(353, 1, 'caption', 'Caption');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(354, 3, 'caption', 'подпись');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(355, 2, 'caption', 'Bildunterschrift');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(356, 1, 'photo', 'Photo');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(357, 2, 'photo', 'Bild');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(358, 1, 'video', 'Video');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(359, 1, 'by', 'by');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(360, 1, 'on', 'on');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(361, 3, 'video', 'видео');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(362, 3, 'photo', 'фото');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(363, 3, 'by', 'по');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(364, 2, 'by', 'von');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(365, 2, 'on', 'auf');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(366, 3, 'on', 'на');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(367, 1, 'blocked_by_user', 'You are blocked by this user');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(368, 2, 'blocked_by_user', 'Sie sind bei dieses Benutzers blockiert');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(369, 3, 'blocked_by_user', 'Вы заблокированы на этого пользователя');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(370, 1, 'report_user', 'Report User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(371, 1, 'all_items_loaded', 'All items loaded');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(372, 2, 'all_items_loaded', 'Alle Einzelteile geladen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(373, 3, 'all_items_loaded', 'Все детали загружен');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(374, 1, 'posts', 'posts');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(375, 3, 'posts', 'пункты');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(376, 2, 'posts', 'Einträge');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(377, 2, 'followers', 'Anhänger');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(378, 2, 'following', 'Folgende');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(379, 3, 'followers', 'последователи');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(380, 3, 'following', 'после');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(381, 1, 'loading', 'Loading');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(382, 2, 'loading', 'Laden');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(383, 3, 'loading', 'загрузка');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(384, 1, 'load_more', 'Load more');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(385, 2, 'load_more', 'laden mehr');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(386, 3, 'load_more', 'Загрузить еще');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(387, 1, 'follow', 'Follow');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(388, 2, 'follow', 'Folgen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(389, 3, 'follow', 'следовать');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(390, 1, 'requested', 'Requested');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(391, 2, 'requested', 'Angeforderte');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(392, 3, 'requested', 'запрошенный');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(393, 2, 'edit', 'Bearbeiten');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(394, 3, 'edit', 'менять');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(395, 1, 'prompt_field_required', 'This field is required');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(396, 4, 'buy_me', 'Beni satın');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(397, 4, 'edit', 'Düzenle');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(398, 4, 'language', 'Dil');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(399, 4, 'upload', 'Yükle');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(400, 4, 'cancel', 'iptal');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(401, 4, 'logout', 'Çıkış');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(402, 4, 'view_profile', 'Profili');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(403, 4, 'edit_profile', 'Profil Düzenle');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(404, 4, 'posts', 'mesajlar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(405, 4, 'followers', 'takipçileri');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(406, 4, 'following', 'aşağıdaki');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(407, 4, 'december', 'Aralık');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(408, 4, 'loading', 'yükleme');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(409, 4, 'top', 'üst');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(410, 4, 'news_feed', 'Haber kaynağı');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(411, 4, 'your_account', 'Hesabınız');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(412, 4, 'media_options', 'medya seçenekleri');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(413, 4, 'view_media', 'görünümü medya');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(414, 4, 'report_content', 'uygunsuz içeriği rapor');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(415, 4, 'you', 'Sen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(416, 4, 'like_this', 'bu hayran');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(417, 4, 'caption', 'başlık');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(418, 4, 'prompt_write_comment', 'Bir Yorum Yazın');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(419, 4, 'prompt_no_likes', 'Henüz hiç kimse bu sevdim etti');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(420, 1, 'prompt_comment_delete', 'Comment Deletion');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(421, 4, 'prompt_comment_deletion', 'Bu yorumu silmek istiyor emin misiniz?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(422, 1, 'prompt_comment_deletion', 'Are you sure that you wish to delete this comment?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(423, 4, 'prompt_comment_delete', 'Silme Yorum');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(424, 4, 'login', 'Oturum Aç');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(425, 4, 'register', 'Kayıt');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(426, 4, 'forgot_password', 'Parolanızı Mı Unuttunuz?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(427, 4, 'username', 'Kullanıcı adı');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(428, 4, 'password', 'şifre');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(429, 1, 'demo_credentials', 'Demo Credentials');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(430, 4, 'demo_credentials', 'gösteri Kimlik');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(431, 2, 'demo_credentials', 'Demo Referenzen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(432, 3, 'demo_credentials', 'Демо Полномочия');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(433, 1, 'theme', 'Theme');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(434, 4, 'theme', 'Motif');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(435, 4, 'prompt_leave_comment', 'Mesaj bırakın');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(436, 4, 'logon_to', 'oturum açma');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(437, 4, 'first_name', 'İsim');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(438, 4, 'last_name', 'Soyadı');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(439, 4, 'email', 'E-posta');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(440, 1, 'password_confirm', 'Password Confirm');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(441, 4, 'password_confirm', 'Şifre Onayla');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(442, 4, 'reset_password', 'Parola Sıfırlama');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(443, 4, 'guest', 'konuk');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(444, 3, 'guest', 'гость');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(445, 1, 'guest', 'Guest');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(446, 2, 'guest', 'Gast');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(447, 2, 'first_name', 'Vorname');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(448, 2, 'last_name', 'Nachname');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(449, 2, 'password_confirm', 'Kennort Bestätigen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(450, 3, 'first_name', 'Имя');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(451, 3, 'last_name', 'фамилия');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(452, 3, 'email', 'е-мейл');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(453, 3, 'password_confirm', 'Подтвердите Пароль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(454, 4, 'select', 'seçmek');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(455, 4, 'finalize', 'sonuçlandırmak');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(456, 4, 'finish', 'bitirmek');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(457, 4, 'add_captions', 'başlık eklemek');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(458, 4, 'upload_more', 'daha fazla yüklemek');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(459, 4, 'change_password', 'Şifre Değiştir');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(460, 4, 'files', 'Dosyalar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(461, 4, 'no_files_selected', 'Seçili dosya yok');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(462, 4, 'error_duplicate_uploads_forbidden', 'Yinelenen yüklenenler Sitesi Yöneticisi tarafından yasak. Bu dosya zaten hesabınıza yüklenir.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(463, 1, 'upload_complete', 'Upload Complete');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(464, 4, 'upload_complete', 'Tam yükle');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(465, 4, 'on', 'üzerinde');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(466, 4, 'by', 'tarafından');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(467, 1, 'prompt_uploads_complete', 'Your upload(s) have successfully completed.<br>You have the option to upload more files or add captions.<br>Captions are automatically saved.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(468, 4, 'prompt_uploads_complete', 'Sizin yükleme (lar) başarıyla tamamladınız.<br>Daha fazla dosya yükleyebilir veya başlık eklemek için seçeneğiniz vardır.<br>Başlıklar otomatik olarak kaydedilir.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(469, 3, 'prompt_uploads_complete', 'Ваше загрузки успешно завершена.<br>У вас есть возможность загружать несколько файлов или добавить титры.<br>Подписи сохраняются автоматически.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(470, 2, 'prompt_uploads_complete', 'Upload erfolgreich abgeschlossen haben.<br>Sie haben die Möglichkeit, mehr Dateien hochladen oder Bildunterschriften hinzufügen.<br>Untertitel werden automatisch gespeichert.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(471, 1, 'upload_more', 'Upload more');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(472, 1, 'add_captions', 'Add Captions');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(473, 3, 'add_captions', 'Добавить подписи');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(474, 3, 'upload_more', 'Загрузить больше');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(475, 2, 'upload_complete', 'Hochladen abgeschlossen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(476, 2, 'add_captions', 'Bildunterschriften hinzufügen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(477, 2, 'upload_more', 'Laden mehrere');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(478, 3, 'error_duplicate_uploads_forbidden', 'Повторяющиеся добавления запрещено администратором сайта. Этот файл уже закачан на ваш аккаунт.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(479, 2, 'error_duplicate_uploads_forbidden', 'Doppelte Uploads werden vom Administrator verboten. Diese Datei ist bereits auf Ihr Konto hochgeladen.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(480, 4, 'permission_error_edit_own_profile', 'Hesabınız ''Profil Düzenle'' izni yok');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(481, 4, 'error', 'Hata');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(482, 4, 'permission_error_change_own_password', 'Hesabınız ''Şifre Değiştirme'' izni verilmiş değil');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(483, 2, 'permission_error_change_own_password', 'Ihr Konto hat nicht die "Change Password" Erlaubnis');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(484, 3, 'permission_error_change_own_password', 'Ваша учетная запись не была предоставлена "Изменить пароль" разрешение');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(485, 5, 'you', 'Usted');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(486, 5, 'login', 'Iniciar Sesión');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(487, 5, 'username', 'Nombre de usuario');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(488, 5, 'password', 'Contraseña');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(489, 5, 'register', 'Registrarse');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(490, 5, 'forgot_password', 'Has Olvidado Tu Contraseña?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(491, 5, 'language', 'Idioma');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(492, 5, 'theme', 'Estilo');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(493, 5, 'logon_to', 'Inicie sesión en');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(494, 5, 'demo_credentials', 'Credenciales de demostración');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(495, 5, 'december', 'Diciembre');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(496, 5, 'buy_me', 'Compra de mí');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(497, 5, 'on', 'en');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(498, 5, 'edit', 'Editar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(499, 5, 'upload', 'Subir');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(500, 5, 'posts', 'mensajes');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(501, 5, 'followers', 'seguidores');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(502, 5, 'following', 'siguiente');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(503, 5, 'logout', 'Cerrar sesión');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(504, 5, 'loading', 'Cargando');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(505, 5, 'all_items_loaded', 'Todos los artículos cargados');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(506, 5, 'view_profile', 'Ver Perfil');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(507, 5, 'edit_profile', 'Editar Perfil');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(508, 5, 'prompt_leave_comment', 'Deja un comentario');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(509, 5, 'media_options', 'Opciones de medios');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(510, 5, 'view_media', 'Ver página de medios');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(511, 5, 'report_content', 'Denuncia contenido inapropiado');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(512, 5, 'like_this', 'admirar este');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(513, 5, 'others_like_this', 'otros admiran este');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(514, 5, 'prompt_no_likes', 'Nadie ha gustado esto todavía');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(515, 3, 'december', 'декабрь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(516, 2, 'december', 'Dezember');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(517, 1, 'january', 'January');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(518, 2, 'february', 'Februar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(519, 2, 'march', 'März');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(520, 2, 'april', 'April');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(521, 2, 'may', 'Mai');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(522, 2, 'june', 'Juni');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(523, 2, 'july', 'Juli');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(524, 2, 'october', 'Oktober');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(525, 3, 'january', 'январь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(526, 3, 'february', 'февраль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(527, 3, 'march', 'март');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(528, 3, 'april', 'апреля');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(529, 3, 'may', 'мая');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(530, 3, 'june', 'июнь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(531, 3, 'july', 'июль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(532, 3, 'august', 'август');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(533, 3, 'september', 'сентябрь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(534, 3, 'october', 'октября');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(535, 3, 'november', 'ноябрь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(536, 5, 'january', 'Enero');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(537, 5, 'february', 'Febrero');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(538, 5, 'march', 'Marzo');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(539, 5, 'april', 'Abril');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(540, 5, 'may', 'Mayo');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(541, 5, 'june', 'Junio');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(542, 5, 'july', 'Julio');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(543, 5, 'august', 'Agosto');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(544, 5, 'september', 'Septiembre');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(545, 5, 'october', 'Octubre');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(546, 5, 'november', 'Noviembre');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(547, 4, 'january', 'Ocak');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(548, 4, 'february', 'Şubat');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(549, 4, 'march', 'Mart');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(550, 4, 'april', 'Nisan');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(551, 4, 'may', 'Mayıs');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(552, 4, 'june', 'Haziran');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(553, 4, 'july', 'Temmuz');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(554, 4, 'august', 'Ağustos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(555, 4, 'september', 'Eylül');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(556, 4, 'october', 'Ekim');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(557, 4, 'november', 'Kasım');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(558, 5, 'cancel', 'Cancelar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(559, 5, 'prompt_write_comment', 'Escribir un comentario');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(560, 5, 'load_more', 'Cargar más');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(561, 5, 'your_account', 'Su cuenta');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(562, 5, 'change_password', 'Cambiar La Contraseña');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(563, 5, 'news_feed', 'Suministro de noticias');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(564, 5, 'files', 'Archivos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(565, 5, 'no_files_selected', 'No hay archivos seleccionados');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(566, 5, 'select', 'Seleccionar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(567, 5, 'finish', 'Acabado');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(568, 5, 'finalize', 'Ultimar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(569, 5, 'upload_more', 'Sube más');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(570, 5, 'add_captions', 'Añadir títulos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(571, 5, 'upload_complete', 'Carga completa');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(572, 5, 'error_duplicate_uploads_forbidden', 'Archivos duplicados están prohibidos por el administrador del sitio. Este archivo ya se ha cargado a su cuenta.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(573, 5, 'caption', 'Subtítulo');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(574, 5, 'prompt_uploads_complete', 'La subida han completado con éxito.<br>Usted tiene la opción de cargar más archivos o añadir subtítulos.<br>Los subtítulos se guardan automáticamente.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(575, 5, 'error', 'Fracaso');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(576, 5, 'permission_error_edit_own_profile', 'Su cuenta no tiene permiso "Editar Perfil"');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(577, 5, 'permission_error_change_own_password', 'Tu cuenta no se ha concedido el permiso ''Cambiar Contraseña''');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(578, 5, 'delete', 'Borrar');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(579, 5, 'prompt_comment_delete', 'Supresión Comentario');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(580, 3, 'prompt_comment_delete', 'Комментарий Удаление');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(581, 2, 'prompt_comment_delete', 'Kommentar Löschen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(582, 2, 'prompt_comment_deletion', 'Bist du sicher, dass du diesen Kommentar löschen wollen?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(583, 3, 'prompt_comment_deletion', 'Вы уверены, что хотите удалить этот комментарий?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(584, 5, 'prompt_comment_deletion', '¿Seguro que desea eliminar este comentario?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(585, 1, 'delete', 'Delete');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(586, 2, 'delete', 'Löschen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(587, 4, 'delete', 'Silmek');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(588, 3, 'delete', 'удалять');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(589, 6, 'language', '語言');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(590, 6, 'login', '登錄');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(591, 6, 'username', '用戶名');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(592, 6, 'password', '密碼');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(593, 6, 'register', '註冊');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(594, 6, 'forgot_password', '忘記密碼？');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(595, 6, 'demo_credentials', '演示證書');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(596, 6, 'theme', '主題');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(597, 6, 'logon_to', '登錄到');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(599, 6, 'buy_me', '我買');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(600, 1, 'authentication_ok', 'Authentication Successful');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(601, 1, 'authentication_ok_text', 'You were successfully logged in. Let''s Rock!');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(602, 6, 'upload', '上傳');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(603, 6, 'logout', '註銷');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(604, 6, 'view_profile', '查看資料');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(605, 6, 'edit_profile', '編輯個人資料');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(606, 6, 'cancel', '取消');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(607, 6, 'media_options', '媒體選項');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(608, 6, 'prompt_no_likes', '沒有人喜歡這個尚未');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(609, 6, 'view_media', '查看媒體頁面');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(610, 6, 'report_content', '舉報不適當的內容');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(611, 6, 'you', '你');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(612, 6, 'like_this', '佩服這個');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(613, 6, 'prompt_write_comment', '寫評論');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(614, 6, 'authentication_ok', '認證成功');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(615, 6, 'authentication_ok_text', '您可以登錄');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(616, 6, 'error', '錯誤');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(617, 6, 'authentication_failure', '驗證失敗');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(618, 6, 'edit', '編輯');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(619, 6, 'december', '十二月');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(620, 6, 'posts', '帖子');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(621, 6, 'loading', '載入中');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(622, 6, 'followers', '追隨者');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(623, 6, 'following', '以下');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(624, 6, 'delete', '刪除');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(625, 6, 'prompt_leave_comment', '發表評論');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(626, 6, 'prompt_comment_deletion', '你確定要刪除此評論嗎？');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(627, 6, 'prompt_comment_delete', '刪除評論');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(628, 6, 'change_password', '更改密碼');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(629, 6, 'select', '選擇');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(630, 6, 'finish', '完');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(631, 6, 'your_account', '您的帳戶');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(632, 6, 'news_feed', '新聞源');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(633, 6, 'files', '檔');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(634, 6, 'no_files_selected', '未選擇任何文件');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(635, 6, 'add_captions', '添加字幕');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(636, 6, 'upload_complete', '上傳完成');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(637, 6, 'upload_more', '上傳更多');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(638, 6, 'prompt_uploads_complete', '上載已成功完成。<br>你要上傳多個文件或添加字幕的選項。<br>字幕被自動保存。');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(639, 6, 'error_duplicate_uploads_forbidden', '重複上傳由站點管理員禁止。此文件已上傳到您的帳戶。');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(640, 1, 'media_deletion', 'Media Deletion');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(641, 1, 'prompt_media_delete', 'Are you sure that you wish to delete this media item?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(642, 6, 'photo', '照片');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(643, 6, 'by', '由');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(644, 6, 'on', '上');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(645, 6, 'media_deletion', '媒體刪除');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(646, 6, 'prompt_media_delete', '你確定要刪除這個媒體項目？');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(647, 2, 'prompt_media_delete', 'Sind Sie sicher, dass Sie diese Medien wirklich löschen wollen?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(648, 2, 'media_deletion', 'Medien Löschen');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(649, 5, 'media_deletion', 'Medios Supresión');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(650, 5, 'prompt_media_delete', '¿Estás seguro que quieres borrar este archivo de medios?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(651, 4, 'prompt_media_delete', 'Eğer bu medya öğeyi silmek istediğinizden emin misiniz?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(652, 4, 'media_deletion', 'Medya Silme');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(653, 3, 'media_deletion', 'Медиа Удаление');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(654, 3, 'prompt_media_delete', 'Вы уверены, что хотите удалить эту композицию?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(655, 2, 'authentication_ok', 'Authentifizierung erfolgreich');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(656, 2, 'authentication_ok_text', 'Sie sind jetzt angemeldet. Jetzt gehts los.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(657, 4, 'authentication_ok', 'Başarılı Kimlik Doğrulama');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(658, 4, 'authentication_ok_text', 'Şimdi kaydedilir. Lütfen bekleyin.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(659, 5, 'authentication_ok_text', 'Ahora está en el sistema. Por favor, espere.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(660, 5, 'authentication_ok', 'Autenticación Exitosa');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(661, 3, 'authentication_ok', 'Аутентификация Преемник');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(662, 3, 'authentication_ok_text', 'Вы вошли в систему. Пожалуйста, подождите.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(663, 1, 'likes_this', 'likes this');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(664, 1, 'error_exceeds_max_size', 'This file exceeds the maximum permitted file size for this file type.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(665, 1, 'email_confirm', 'Confirm e-mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(666, 1, 'try_again', 'Try again');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(667, 1, 'username_exists', 'Username exists');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(668, 1, 'user_registration_ok', 'Registration Succeeded');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(669, 1, 'reset', 'Reset');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(670, 1, 'account_created', 'Account Created');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(671, 1, 'prompt_error_confirm_code', 'The specified account confirmation code does not exist');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(672, 1, 'account_confirmed', 'Account Confirmed');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(673, 1, 'prompt_confirm_code_ok', 'Your account has been successfully confirmed');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(674, 1, 'recaptcha_error', 'reCAPTCHA Error');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(675, 1, 'check_your_email', 'Check your e-mail');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(676, 1, 'error_user_account', 'User Account Error');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(677, 1, 'password_reset', 'Password Reset');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(678, 1, 'prompt_password_reset_ok', 'Your password has been reset. Check your e-mail for further details.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(679, 1, 'prompt_error_password_reset', 'An error has occurred while resetting your password. Your password has not been changed.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(680, 1, 'prompt_error_permission', 'Your account does not have sufficient permissions to perform this action.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(681, 3, 'about_us', 'О нас');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(682, 3, 'privacy', 'Конфиденциальность');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(683, 3, 'terms', 'Условия');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(684, 3, 'admin', 'Admin');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(685, 3, 'ago', 'ago');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(686, 3, 'avatar_url', 'Avatar URL');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(687, 3, 'bio', 'Bio');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(688, 3, 'birth_day', 'Birth Day');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(689, 3, 'birth_month', 'Birth Month');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(690, 3, 'birth_year', 'Birth Year');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(691, 3, 'can_admin_site', 'Can Administer Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(692, 3, 'can_change_own_password', 'Can Change Own Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(693, 3, 'can_edit_own_profile', 'Can Edit Own Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(694, 3, 'can_upload', 'Can Upload');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(695, 3, 'can_view_debug_messages', 'Can View Debug Messages');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(696, 3, 'can_view_site', 'Can View Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(697, 3, 'can_view_user_profiles', 'Can View User Profiles');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(698, 3, 'comment', 'Comment');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(699, 3, 'email_or_username', 'e-mail or Username');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(700, 3, 'gender', 'Gender');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(701, 3, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it''s as easy as pie. It''s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(702, 3, 'homepage_header', 'Meet Instagram');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(703, 3, 'hours', 'hours');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(704, 3, 'http_error_404_text', 'Sorry, this page could not be found.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(705, 3, 'id', 'ID');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(706, 3, 'join_date', 'Join Date');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(707, 3, 'last_active', 'Last Active');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(708, 3, 'last_ip', 'Last IP');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(709, 3, 'last_login_date', 'Date of Last Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(710, 3, 'like_or_comment', 'to like or comment');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(711, 3, 'like_this_object', 'like this');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(712, 3, 'name', 'Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(713, 3, 'need_to_follow', 'You need to be following');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(714, 3, 'no_photos_to_display', 'No photos to show.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(715, 3, 'no_recent_photos', 'No Recent Photos');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(716, 3, 'no_upload_permission', 'Your account does not have upload permissions');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(717, 3, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(718, 3, 'permission_error_view_user_profiles', 'Your account does not have the ''View User Profiles'' permission');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(719, 3, 'phone_number', 'Phone Number');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(720, 3, 'private_profile', 'Private Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(721, 3, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(722, 3, 'reset_password', 'Reset Password');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(723, 3, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(724, 3, 'signup_ip', 'Signup IP');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(725, 3, 'site', 'Site');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(726, 3, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(727, 3, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(728, 3, 'site_allow_signup', 'Allow User Registration');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(729, 3, 'site_allow_template_change', 'Allow Template Change');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(730, 3, 'site_allow_url_in_comment', 'Allow URLs in Comments');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(731, 3, 'site_allowed_image_types', 'Allow Image Types');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(732, 3, 'site_allowed_video_types', 'Allowed Video Types');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(733, 3, 'site_censor_replacement', 'Censor Replacement');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(734, 3, 'site_censor_replacement_type', 'Censor Replacement');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(735, 3, 'site_comment_fetch_limit', 'Comment Fetch Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(736, 3, 'site_comp_image_limit', 'User Profile Header Image Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(737, 3, 'site_cookie_domain', 'Cookie Domain');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(738, 3, 'site_cookie_path', 'Cookie Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(739, 3, 'site_cookie_timeout', 'Cookie Timeout');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(740, 3, 'site_debug', 'Debug Mode');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(741, 3, 'site_default_admin_template', 'Site Admin Template');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(742, 3, 'site_default_admin_template_path', 'Admin Template Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(743, 3, 'site_default_avatar_url', 'Default Avatar URL');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(744, 3, 'site_default_image_resize_type', 'Image Resize Type');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(745, 3, 'site_default_landing_page', 'Default Landing Page');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(746, 3, 'site_default_landing_page_after_login', 'Landing Page After Login');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(747, 3, 'site_default_language', 'Default Site Language');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(748, 3, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(749, 3, 'site_default_preloader_image_path', 'Preloader URL Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(750, 3, 'site_default_template', 'Default Site Template');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(751, 3, 'site_default_usergroup', 'Default Usergroup');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(752, 3, 'site_demo_mode', 'Demo Mode');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(753, 3, 'site_ffmpeg_path', 'FFMPEG Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(754, 3, 'site_language', 'Site Language');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(755, 3, 'site_local_theme_url_root', 'Theme Root Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(756, 3, 'site_medium_image_height', 'Medium Image Height');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(757, 3, 'site_medium_image_width', 'Medium Image Width');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(758, 3, 'site_moderate_new_users', 'Moderate New Users');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(759, 3, 'site_mp4box_path', 'MP4Box Path');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(760, 3, 'site_name', 'Site Name');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(761, 3, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(762, 3, 'site_parse_url_in_comment', 'Parse URLs in Comments');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(763, 3, 'site_recaptcha_private_key', 'reCAPTCHA Private Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(764, 3, 'site_recaptcha_public_key', 'reCAPTHCA Public Key');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(765, 3, 'site_recent_activity_threshold', 'Recent Activity Threshold');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(766, 3, 'site_recent_post_limit', 'Recent Post Limit');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(767, 3, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration?');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(768, 3, 'site_rotate_user_comp_header', 'Rotate User Header Images');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(769, 3, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(770, 3, 'site_show_user_suggestions', 'Display User Suggestions');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(771, 3, 'site_status', 'Status');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(772, 3, 'site_thumbnail_height', 'Thumbnail Height');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(773, 3, 'site_thumbnail_width', 'Thumbnail Width');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(774, 3, 'site_upload_dir', 'Upload Diretory');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(775, 3, 'site_upload_dir_users', 'Destination Directory for User Uploads');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(776, 3, 'site_user_comp_header_flip_interval', 'Header Flip Interval');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(777, 3, 'support', 'Support');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(778, 3, 'title', 'Title');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(779, 3, 'user', 'User');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(780, 3, 'user_is_private', 'This user is private');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(781, 3, 'website', 'Website');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(782, 1, 'site_avatar_height', 'Avatar Height');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(783, 3, 'site_avatar_height', 'Аватар Высота');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(784, 1, 'save', 'Save');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(785, 3, 'save', 'Сохранить');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(786, 1, 'media', 'Media');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(787, 3, 'media', 'Медиа');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(788, 2, 'media', 'Medien');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(790, 3, 'site_phrases', 'сайт Фразы');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(791, 1, 'site_config', 'Site Config');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(792, 3, 'site_config', 'Конфигурация сайта');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(794, 3, 'site_settings', 'Настройки сайта');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(795, 1, 'phrases_saved', 'Phrases saved');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(796, 3, 'phrases_saved', 'Фразы сохранены');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(797, 1, 'update_successful', 'Update successful');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(798, 3, 'update_successful', 'Обновление успешно');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(799, 1, 'you_are_here', 'You are here');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(800, 3, 'you_are_here', 'Вы здесь');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(801, 1, 'users', 'Users');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(802, 3, 'users', 'Пользователи');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(803, 1, 'usergroups', 'Usergroups');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(804, 3, 'usergroups', 'Группы');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(805, 1, 'my_account', 'My Account');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(806, 3, 'my_account', 'Мой аккаунт');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(807, 1, 'profile', 'Profile');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(808, 3, 'profile', 'Профиль');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(809, 1, 'upgrade', 'Upgrade');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(810, 3, 'upgrade', 'модернизация');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(811, 1, 'upgrade_required', 'Upgrade Required');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(812, 1, 'can_delete_own_account', 'Can Delete Own Account');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(813, 1, 'prompt_follow_people', 'Follow friends and interesting people to see their photos here.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(814, 1, 'prompt_suggestions', 'Here are some suggestions.');
INSERT INTO `base_phrase` (`id`, `language_id`, `name`, `text`) VALUES(815, 1, 'following', 'Following');

-- --------------------------------------------------------

--
-- Table structure for table `base_site_config`
--

CREATE TABLE IF NOT EXISTS `base_site_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `possible_values` text COLLATE utf8_unicode_ci,
  `category` enum('admin','global','social','upload','user') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `ui_type` enum('radio','select','text','textarea') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `editable` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `hint` text COLLATE utf8_unicode_ci COMMENT 'hint to present in the UI',
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `category` (`category`),
  KEY `comment` (`comment`),
  KEY `value` (`value`),
  KEY `editable` (`editable`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=94 ;

--
-- Dumping data for table `base_site_config`
--

INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(1, 'site_name', 'BizLogic Base Framework', NULL, 'global', 'text', '1', 'Site Name', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(2, 'site_default_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(3, 'site_default_landing_page', '', NULL, 'global', 'text', '1', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(4, 'site_allow_template_change', '1', '0,1', 'global', 'radio', '1', 'Allow Template Change', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(5, 'site_default_template', 'openface', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(6, 'site_default_max_upload_size', '1073741824', NULL, 'upload', 'text', '1', 'Max upload size in bytes', 'in bytes');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(7, 'site_allowed_file_types', '*', NULL, 'upload', 'text', '1', 'File types allowed for upload. Separate entries with commas. Use * to allow all.', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(8, 'site_default_avatar_url', '__BASEURL__/images/profiles/anonymousUser.jpg', NULL, 'user', 'text', '1', 'Full URL of the default user avatar', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(9, 'site_default_language', 'en-us', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(10, 'site_guest_max_recipients', '3', NULL, 'upload', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(11, 'site_guest_max_queue_size', '5', NULL, 'upload', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(12, 'site_guest_max_file_size', '2', NULL, 'upload', 'text', '1', NULL, 'in MB');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(13, 'site_guest_total_file_size', '10', NULL, 'upload', 'text', '1', NULL, 'in MB');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(14, 'site_allow_language_change', '1', '0,1', 'global', 'radio', '1', 'Allow Language Change', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(15, 'site_guest_upload_retention', '168', NULL, 'upload', 'text', '1', NULL, 'in hours');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(16, 'site_moderate_new_users', '1', '0,1', 'user', 'radio', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(17, 'site_require_email_confirm', '1', '0,1', 'user', 'radio', '1', 'Require e-mail confirmation for new user registrations', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(18, 'site_email_address', 'admin@bizlogicdev.com', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(19, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(20, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory for end-users', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(22, 'site_token_min_length', '8', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(23, 'site_token_max_length', '15', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(24, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', '1', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(25, 'site_default_admin_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'admin', 'text', '1', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(26, 'site_default_landing_page_after_login', '', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(52, 'site_use_blockui', '1', '1,0', 'global', 'radio', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(53, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(64, 'site_url', '__BASEURL__', NULL, 'global', 'text', '1', NULL, 'including scheme');
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(77, 'site_facebook_app_id', '324640691020497', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(78, 'site_twitter_api_key', 'KS0tMXGV1jBPHcr9B2NsxplmU', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(79, 'site_twitter_api_secret', '4SaA3aauMozDQqJIbEZIiwmJTYj1hBmaF6Ql0PILnBFHi604By', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(80, 'site_allow_social_login', '1', '0,1', 'social', 'radio', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(81, 'site_yahoo_consumer_key', 'dj0yJmk9RlBPU09OTXZxY3hPJmQ9WVdrOVZuVkRWWGRHTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Mg--', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(82, 'site_yahoo_consumer_secret', 'e15419d9ab06e7cd727a252c16f03877e68cc7eb', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(83, 'site_yahoo_app_id', 'VuCUwF36', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(84, 'site_yahoo_domain', 'dev.vevoclone.com', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(85, 'site_windows_live_client_id', '000000004811FC1F', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(86, 'site_windows_live_client_secret', '2YIn7AR1kyqSliK5GVh-V6X3U6Bhn6pF', NULL, 'social', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(87, 'site_guest_usergroup_id', '1', NULL, 'user', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(88, 'site_cookie_expiration_date', '3153600000', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(89, 'site_cookie_timeout', '3153600000', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(90, 'site_cookie_path', '/', NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(91, 'site_global_html_header', NULL, NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(92, 'site_global_html_body_start', NULL, NULL, 'global', 'text', '1', NULL, NULL);
INSERT INTO `base_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES(93, 'site_global_html_body_end', NULL, NULL, 'global', 'text', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `base_site_permission`
--

CREATE TABLE IF NOT EXISTS `base_site_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_type` enum('admin','site','upload','user') COLLATE utf8_unicode_ci DEFAULT 'site',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_name` (`permission_name`,`permission_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `base_site_permission`
--

INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(1, 'can_view_site', 'site', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(2, 'can_upload', 'upload', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(3, 'can_admin_site', 'admin', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(4, 'can_view_debug_messages', 'admin', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(5, 'can_view_user_profiles', 'site', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(6, 'can_edit_own_profile', 'user', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(7, 'can_change_own_password', 'user', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(8, 'can_delete_own_account', 'user', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(9, 'can_admin_site_phrases', 'admin', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(10, 'can_admin_users', 'admin', NULL);
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(11, 'can_admin_files', 'admin', 'Can Administer Uploaded Files (Admin)');
INSERT INTO `base_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(12, 'can_use_firephp', 'admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `base_site_theme`
--

CREATE TABLE IF NOT EXISTS `base_site_theme` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('custom','bootstrap','jquery-ui') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'custom',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=24 ;

--
-- Dumping data for table `base_site_theme`
--

INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(1, 'bootstrap', 'cerulean', 'Cerulean', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(2, 'bootstrap', 'flatly', 'Flatly', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(3, 'bootstrap', 'amelia', 'Amelia', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(4, 'bootstrap', 'slate', 'Slate', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(5, 'bootstrap', 'cosmo', 'Cosmo', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(6, 'bootstrap', 'darkly', 'Darkly', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(7, 'bootstrap', 'cyborg', 'Cyborg', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(8, 'bootstrap', 'journal', 'Journal', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(9, 'bootstrap', 'lumen', 'Lumen', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(10, 'bootstrap', 'readable', 'Readable', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(12, 'bootstrap', 'simplex', 'Simplex', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(13, 'bootstrap', 'spacelab', 'Spacelab', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(14, 'bootstrap', 'superhero', 'Superhero', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(15, 'bootstrap', 'united', 'United', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(16, 'bootstrap', 'bootstrap-theme', 'Bootstrap (w/ theme)', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(17, 'bootstrap', 'yeti', 'Yeti', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(18, 'bootstrap', 'pastel', 'Pastel', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(19, 'bootstrap', 'autumn-dawn', 'Autumn Dawn', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(20, 'bootstrap', 'candy-box', 'Candy Box', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(21, 'bootstrap', 'sandstone', 'Sandstone', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(22, 'bootstrap', 'paper', 'Paper', '1');
INSERT INTO `base_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(23, 'bootstrap', 'openface', 'OpenFace', '1');

-- --------------------------------------------------------

--
-- Table structure for table `base_user`
--

CREATE TABLE IF NOT EXISTS `base_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_url` text COLLATE utf8_unicode_ci,
  `site_language` bigint(20) unsigned DEFAULT NULL,
  `site_status` enum('banned','pending','confirmed','auto_confirmed','unconfirmed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unconfirmed',
  `date_created` int(10) unsigned NOT NULL,
  `signup_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_upload` int(10) unsigned DEFAULT NULL,
  `last_active` int(10) unsigned DEFAULT NULL,
  `last_login_date` int(10) unsigned DEFAULT NULL,
  `last_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `site_language` (`site_language`),
  KEY `signup_ip` (`signup_ip`),
  KEY `last_ip` (`last_ip`),
  KEY `last_login_date` (`last_login_date`),
  KEY `password` (`password`),
  KEY `username` (`username`),
  KEY `username_password` (`username`,`password`),
  KEY `date_created` (`date_created`),
  KEY `last_upload` (`last_upload`),
  KEY `last_active` (`last_active`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `base_user`
--

INSERT INTO `base_user` (`id`, `uuid`, `email`, `username`, `first_name`, `last_name`, `password`, `avatar_url`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'admin@xnami.com', 'Xnami', NULL, NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 1, 'auto_confirmed', 1383254334, NULL, NULL, 1411984283, 1411934801, '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `base_usergroup`
--

CREATE TABLE IF NOT EXISTS `base_usergroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `base_usergroup`
--

INSERT INTO `base_usergroup` (`id`, `name`, `title`, `comment`) VALUES(0, 'Banned', 'Banned', 'Banned Users');
INSERT INTO `base_usergroup` (`id`, `name`, `title`, `comment`) VALUES(1, 'Guest', 'Unauthenticated', 'Guests');
INSERT INTO `base_usergroup` (`id`, `name`, `title`, `comment`) VALUES(2, 'User', 'Normal Users', 'Normal Users');
INSERT INTO `base_usergroup` (`id`, `name`, `title`, `comment`) VALUES(3, 'Administrator', 'Site Administrators', 'Site Administrators');
INSERT INTO `base_usergroup` (`id`, `name`, `title`, `comment`) VALUES(4, 'Demo', 'Demo Users', 'Demo Users');

-- --------------------------------------------------------

--
-- Table structure for table `base_usergroup_member`
--

CREATE TABLE IF NOT EXISTS `base_usergroup_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `usergroup_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_and_usergroup_id` (`user_id`,`usergroup_id`),
  KEY `user_id` (`user_id`),
  KEY `usergroup_id` (`usergroup_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `base_usergroup_member`
--

INSERT INTO `base_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES(1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `base_usergroup_permission`
--

CREATE TABLE IF NOT EXISTS `base_usergroup_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usergroup_id` int(10) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroup_id_and_permissions_id` (`usergroup_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

--
-- Dumping data for table `base_usergroup_permission`
--

INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(16, 2, 1);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(13, 2, 2);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(12, 2, 5);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(1, 3, 1);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(2, 3, 2);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(3, 3, 3);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(4, 3, 4);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(9, 3, 5);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(10, 3, 6);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(11, 3, 7);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(18, 3, 9);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(19, 3, 10);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(20, 3, 11);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(21, 3, 12);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(14, 4, 1);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(15, 4, 2);
INSERT INTO `base_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(17, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `base_user_confirm`
--

CREATE TABLE IF NOT EXISTS `base_user_confirm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `base_oauth_token`
--
ALTER TABLE `base_oauth_token`
  ADD CONSTRAINT `base_oauth_token_ibfk_1` FOREIGN KEY (`parent_uuid`) REFERENCES `base_oauth_app` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `base_phrase`
--
ALTER TABLE `base_phrase`
  ADD CONSTRAINT `base_phrase_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `base_language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `base_user`
--
ALTER TABLE `base_user`
  ADD CONSTRAINT `base_user_ibfk_1` FOREIGN KEY (`site_language`) REFERENCES `base_language` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `base_usergroup_member`
--
ALTER TABLE `base_usergroup_member`
  ADD CONSTRAINT `base_usergroup_member_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `base_usergroup_member_ibfk_2` FOREIGN KEY (`usergroup_id`) REFERENCES `base_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `base_usergroup_permission`
--
ALTER TABLE `base_usergroup_permission`
  ADD CONSTRAINT `base_usergroup_permission_ibfk_1` FOREIGN KEY (`usergroup_id`) REFERENCES `base_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `base_usergroup_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `base_site_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `base_user_confirm`
--
ALTER TABLE `base_user_confirm`
  ADD CONSTRAINT `base_user_confirm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;