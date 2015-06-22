-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 17, 2015 at 01:59 AM
-- Server version: 5.5.42-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `bizlogic_openface_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `openface_banned_email`
--

CREATE TABLE IF NOT EXISTS `openface_banned_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openface_banned_ip`
--

CREATE TABLE IF NOT EXISTS `openface_banned_ip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IP or IP range',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openface_language`
--

CREATE TABLE IF NOT EXISTS `openface_language` (
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
-- Dumping data for table `openface_language`
--

INSERT INTO `openface_language` (`id`, `locale_id`, `iso_3166_1`, `iso_639`, `display_name`, `friendly_name`, `native_name`, `active`) VALUES
(1, 'en-us', 'us', 'en', 'English (U.S.)', 'English (U.S.)', 'English', '1'),
(2, 'de-de', 'de', 'de', 'Deutsch', 'German', 'Deutsch', '1'),
(3, 'ru-ru', 'ru', 'ru', 'русский', 'Russian', 'русский', '1'),
(4, 'tr-tr', 'tr', 'tr', 'Türkçe', 'Turkish', 'Türkçe', '1'),
(5, 'es-es', 'es', 'es', 'Español', 'Spanish', 'Español', '1'),
(6, 'zh-tw', 'tw', 'zh', '中國（繁體）', 'Chinese (Traditional)', '中國（繁體）', '1');

-- --------------------------------------------------------

--
-- Table structure for table `openface_metadata`
--

CREATE TABLE IF NOT EXISTS `openface_metadata` (
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
-- Table structure for table `openface_oauth_app`
--

CREATE TABLE IF NOT EXISTS `openface_oauth_app` (
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
-- Dumping data for table `openface_oauth_app`
--

INSERT INTO `openface_oauth_app` (`id`, `uuid`, `secret`, `name`, `description`, `image_url`, `image_file_path`, `date_created`) VALUES
(1, '684144f0-fdb6-11e3-a3ac-0800200c9a66', 'hvgVeaOFH3lLSRdWU1C6nwKfpnWYjWBdYyXVtvjBAc5ch', 'Example App', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vehicula sem risus, eget luctus tortor fermentum eu. Vestibulum malesuada posuere nulla, id tempor urna lacinia a. Vivamus euismod tempus nisi, ut vulputate lectus blandit in. Pellentesque habita', NULL, NULL, 1403844646);

-- --------------------------------------------------------

--
-- Table structure for table `openface_oauth_token`
--

CREATE TABLE IF NOT EXISTS `openface_oauth_token` (
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
-- Table structure for table `openface_phrase`
--

CREATE TABLE IF NOT EXISTS `openface_phrase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_id_2` (`language_id`,`name`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=831 ;

--
-- Dumping data for table `openface_phrase`
--

INSERT INTO `openface_phrase` (`id`, `language_id`, `name`, `text`) VALUES
(1, 1, 'language', 'Language'),
(2, 2, 'language', 'Sprache'),
(5, 1, 'upload', 'Upload'),
(6, 2, 'upload', 'Hochladen'),
(7, 1, 'add_files', 'Add Files'),
(8, 2, 'add_files', 'Dateien hinzufügen'),
(9, 1, 'to', 'To'),
(10, 2, 'to', 'An'),
(13, 1, 'from', 'From'),
(14, 2, 'from', 'Von'),
(15, 1, 'your_email', 'Your e-mail'),
(16, 2, 'your_email', 'Ihre E-Mail'),
(17, 1, 'your_friend_email', 'Your friend''s e-mail'),
(18, 2, 'your_friend_email', 'Email des Freundes'),
(19, 1, 'message', 'Message'),
(20, 2, 'message', 'Nachricht'),
(21, 1, 'transfer', 'Transfer'),
(22, 2, 'transfer', 'Übertragen'),
(23, 1, 'file_upload_success', 'YEAH! Your files were successfully uploaded!'),
(24, 2, 'file_upload_success', 'Ja! Ihre Dateien wurden erfolgreich hochgeladen!'),
(25, 1, 'http_error_404_text', 'The document that you have requested does not exist'),
(26, 2, 'http_error_404_text', 'Das Dokument, das Sie angefordert haben existiert nicht'),
(27, 1, 'site_default_admin_preloader_image_path', 'Preloader Image Path (URL)'),
(28, 1, 'site_allow_language_change', 'Allow Language Change'),
(29, 1, 'site_allow_template_change', 'Allow Template Change'),
(30, 1, 'site_allowed_file_types', 'Allowed File Types'),
(31, 1, 'site_archive_prefix', 'Archive Prefix'),
(32, 1, 'site_default_avatar_url', 'Default Avatar URL'),
(33, 1, 'admin', 'Admin'),
(34, 1, 'global', 'Global'),
(35, 1, 'site_default_landing_page', 'Default Landing Page (After Login)'),
(36, 1, 'site_default_language', 'Default Site Language'),
(37, 1, 'site_default_max_upload_size', 'Max Upload Size'),
(38, 1, 'site_default_preloader_image_path', 'Site Preloader Image'),
(39, 1, 'site_default_template', 'Default Site Template'),
(40, 1, 'site_email_address', 'Site e-mail Address'),
(41, 1, 'site_guest_max_file_size', 'Max File Size for Guests'),
(42, 1, 'site_guest_max_queue_size', 'Queue Size Limit for Guests'),
(43, 1, 'site_guest_max_recipients', 'Max Number of Recipients for Guests'),
(44, 1, 'site_guest_total_file_size', 'Total Queue Size for Guests'),
(45, 1, 'site_guest_upload_retention', 'Guest Upload Retention'),
(46, 1, 'site_local_theme_url_root', 'Relative URL path of themes'),
(47, 1, 'site_moderate_new_users', 'Moderate New Users'),
(48, 1, 'site_name', 'Site Name'),
(49, 1, 'user', 'User'),
(50, 1, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration'),
(51, 1, 'site_upload_dir_users', 'Path of upload directory for end-users'),
(52, 1, 'site_upload_dir', 'Path of upload directory '),
(53, 1, 'site_token_max_length', 'Max Token Length'),
(54, 1, 'site_token_min_length', 'Minimum token length'),
(55, 1, 'site_settings', 'Site Settings'),
(56, 2, 'site_settings', 'Site-Einstellungen'),
(57, 2, 'user', 'Benutzer'),
(58, 2, 'settings', 'Einstellungen'),
(59, 2, 'site', 'Webseite'),
(60, 2, 'phrases', 'Sätze'),
(61, 2, 'users', 'Benutzer'),
(62, 2, 'all', 'alle'),
(63, 2, 'logoff', 'Abmelden'),
(64, 2, 'account_settings', 'Konto-Einstellungen'),
(65, 2, 'files', 'Dateien'),
(66, 1, 'template_color', 'Template Color'),
(67, 2, 'template_color', 'Schablone Farbe'),
(68, 1, 'save_changes', 'Save Changes'),
(69, 1, 'cancel', 'Cancel'),
(70, 2, 'save_changes', 'Änderungen speichern'),
(71, 2, 'cancel', 'Abbrechen'),
(72, 2, 'site_phrases', 'Website-Sätze'),
(73, 1, 'site_phrases', 'Site Phrases'),
(74, 1, 'logoff', 'Logout'),
(75, 1, 'uploaded_files', 'Uploaded Files'),
(76, 2, 'uploaded_files', 'Hochgeladene Dateien'),
(77, 1, 'orphaned_files', 'Orphaned Files'),
(78, 2, 'orphaned_files', 'Verwaiste Dateien'),
(79, 1, 'login', 'Login'),
(80, 2, 'login', 'Anmelden'),
(81, 1, 'forgotten_password', 'Forgotten Password'),
(82, 2, 'forgotten_password', 'Passwort vergessen'),
(83, 1, 'error', 'Error'),
(84, 1, 'login_username_does_not_exist', 'Authentication Failure'),
(85, 1, 'authentication_failure', 'Authentication Failure'),
(86, 1, 'logout', 'Logout'),
(87, 2, 'logout', 'Abmelden'),
(88, 1, 'help', 'Help'),
(89, 2, 'help', 'Hilfe'),
(92, 1, 'themes', 'Themes'),
(93, 2, 'themes', 'Thema'),
(94, 1, 'password', 'Password'),
(95, 2, 'password', 'Kennwort'),
(96, 1, 'email', 'e-mail'),
(97, 2, 'email', 'Email'),
(98, 1, 'to_top', 'Top'),
(99, 2, 'to_top', 'Nach oben'),
(100, 1, 'all_rights_reserved', 'All Rights Reserved'),
(101, 2, 'all_rights_reserved', 'Alle Rechte vorbehalten'),
(102, 1, 'copyright', 'Copyright'),
(103, 2, 'copyright', 'Copyright'),
(104, 1, 'authorization', 'Authorization'),
(105, 1, 'authorize', 'Authorize'),
(106, 1, 'search', 'Search'),
(107, 1, 'about', 'About'),
(108, 1, 'exception', 'Exception'),
(109, 1, 'add_user', 'Add User'),
(110, 1, 'social', 'Social'),
(111, 1, 'site_cookie_expiration_date', 'Cookie Expiration Date'),
(112, 1, 'site_default_landing_page_after_login', 'Default Landing Page after Login'),
(113, 1, 'site_guest_usergroup_id', 'Usergroup ID for Guests'),
(114, 1, 'site_facebook_app_id', 'Facebook App ID'),
(115, 1, 'site_moderate_uploads', 'Moderate Uploads'),
(116, 1, 'site_url', 'Site URL'),
(117, 1, 'site_use_blockui', 'Use BlockUI'),
(118, 1, 'site_allow_social_login', 'Allow Social Login'),
(119, 1, 'site_twitter_api_key', 'Twitter API Key'),
(120, 1, 'site_twitter_api_secret', 'Twitter API Secret'),
(121, 1, 'site_windows_live_client_id', 'Windows Live Client ID'),
(122, 1, 'site_windows_live_client_secret', 'Windows Live Client Secret'),
(123, 1, 'site_yahoo_app_id', 'Yahoo! App ID'),
(124, 1, 'site_yahoo_consumer_key', 'Yahoo! Consumer Key'),
(125, 1, 'site_yahoo_consumer_secret', 'Yahoo! Consumer Secret'),
(126, 1, 'site_yahoo_domain', 'Yahoo! Domain'),
(127, 1, 'your_account', 'Your Account'),
(128, 1, 'about_us', 'About Us'),
(129, 1, 'support', 'Support'),
(130, 1, 'privacy', 'Privacy'),
(131, 1, 'terms', 'Terms'),
(132, 2, 'your_account', 'Dein Konto'),
(133, 2, 'about_us', 'Über Uns'),
(134, 2, 'terms', 'Nutzungsbedingungen'),
(135, 2, 'privacy', 'Privatsphäre\r\n'),
(136, 1, 'homepage_header', 'Meet Instagram'),
(137, 2, 'homepage_header', 'Instagram stellt sich vor.'),
(138, 2, 'homepage_app_description', '<p>\r\nEs ist ein <b>schneller</b>, <b>schöner</b> und <b>lustiger</b> Weg, Deine Freunde durch Bilder an Deinem Leben teilhaben zu lassen.\r\n</p>\r\n<p>\r\nMache ein Bild mit Deinem iPhone, wähle einen Filter, um das Aussehen und die Stimmung des Bildes zu ändern, sende es zu Facebook, Twitter oder Tumblr –  so einfach ist das! Ein ganz neuer Weg, Deine Bilder zu zeigen.\r\n</p>\r\n<p>\r\nUnd haben wir es schon erwähnt? Es ist kostenlos!\r\n</p>'),
(139, 1, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it''s as easy as pie. It''s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>'),
(140, 1, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.'),
(141, 1, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.'),
(144, 1, 'user_is_private', 'This user is private'),
(145, 1, 'need_to_follow', 'You need to be following'),
(146, 1, 'like_or_comment', 'to like or comment'),
(147, 1, 'no_photos_to_display', 'No photos to show.'),
(148, 1, 'no_upload_permission', 'Your account does not have upload permissions'),
(151, 1, 'permission_error_edit_own_profile', 'Your account does not have the ''Edit Profile'' permission'),
(152, 1, 'permission_error_change_own_password', 'Your account has not been granted the ''Change Password'' permission'),
(153, 1, 'permission_error_view_user_profiles', 'Your account does not have the ''View User Profiles'' permission'),
(154, 1, 'no_recent_photos', 'No Recent Photos'),
(155, 2, 'no_recent_photos', 'Kein Aktuelle Fotos'),
(158, 1, 'you', 'You'),
(159, 2, 'you', 'Du'),
(160, 1, 'like_this_object', 'like this'),
(161, 2, 'like_this_object', 'gefällt das'),
(162, 1, 'forgot_password', 'Forgot Password?'),
(163, 2, 'forgot_password', 'Passwort vergessen?'),
(164, 1, 'reset_password', 'Reset Password'),
(165, 2, 'reset_password', 'Passwort zurücksetzen'),
(168, 1, 'register', 'Register'),
(169, 2, 'register', 'Registrieren'),
(170, 1, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.'),
(171, 2, 'password_reset_tip', 'Wir können Ihnen helfen, Ihr Passwort zurückzusetzen mit Ihrem Benutzernamen oder Instagram die E-Mail-Adresse in Verbindung mit Ihrem Konto.'),
(172, 1, 'email_or_username', 'e-mail or Username'),
(173, 2, 'email_or_username', 'E-Mail oder Benutzername'),
(174, 2, 'support', 'Unterstützung'),
(175, 1, 'username', 'Username'),
(176, 2, 'username', 'Benutzername'),
(181, 1, 'first_name', 'First Name'),
(182, 1, 'last_name', 'Last Name'),
(183, 1, 'ago', 'ago'),
(184, 2, 'ago', 'vorher'),
(185, 1, 'hours', 'hours'),
(186, 2, 'hours', 'Stunden'),
(189, 1, 'site_allow_signup', 'Allow User Registration'),
(193, 1, 'site_thumbnail_height', 'Thumbnail Height'),
(194, 1, 'site_thumbnail_width', 'Thumbnail Width'),
(195, 1, 'site_allowed_image_types', 'Allow Image Types'),
(196, 1, 'site_allowed_video_types', 'Allowed Video Types'),
(197, 1, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)'),
(198, 1, 'site_comp_image_limit', 'User Profile Header Image Limit'),
(199, 1, 'site_medium_image_height', 'Medium Image Height'),
(200, 1, 'site_medium_image_width', 'Medium Image Width'),
(201, 1, 'site_default_admin_template', 'Site Admin Template'),
(202, 1, 'site_default_admin_template_path', 'Admin Template Path'),
(203, 1, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)'),
(206, 1, 'site_default_image_resize_type', 'Image Resize Type'),
(207, 1, 'site_rotate_user_comp_header', 'Rotate User Header Images'),
(208, 1, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)'),
(209, 1, 'site_user_comp_header_flip_interval', 'Header Flip Interval'),
(210, 1, 'site_ffmpeg_path', 'FFMPEG Path'),
(211, 1, 'site_comment_fetch_limit', 'Comment Fetch Limit'),
(212, 1, 'site_allow_url_in_comment', 'Allow URLs in Comments'),
(213, 1, 'site_parse_url_in_comment', 'Parse URLs in Comments'),
(214, 1, 'site_censor_replacement', 'Censor Replacement'),
(215, 1, 'site_censor_replacement_type', 'Censor Replacement'),
(216, 1, 'site_debug', 'Debug Mode'),
(218, 1, 'site_cookie_timeout', 'Cookie Timeout'),
(219, 1, 'site_cookie_path', 'Cookie Path'),
(220, 1, 'site_recaptcha_public_key', 'reCAPTHCA Public Key'),
(221, 1, 'site_recaptcha_private_key', 'reCAPTCHA Private Key'),
(223, 1, 'site_cookie_domain', 'Cookie Domain'),
(224, 1, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User'),
(227, 1, 'site_default_usergroup', 'Default Usergroup'),
(228, 1, 'site_demo_mode', 'Demo Mode'),
(230, 1, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview'),
(231, 1, 'site_recent_activity_threshold', 'Recent Activity Threshold'),
(232, 1, 'site_recent_post_limit', 'Recent Post Limit'),
(234, 1, 'id', 'ID'),
(235, 1, 'site_status', 'Status'),
(236, 1, 'signup_ip', 'Signup IP'),
(237, 1, 'last_ip', 'Last IP'),
(238, 1, 'join_date', 'Join Date'),
(239, 1, 'last_active', 'Last Active'),
(240, 1, 'edit', 'Edit'),
(241, 1, 'site_show_user_suggestions', 'Display User Suggestions'),
(242, 1, 'site_mp4box_path', 'MP4Box Path'),
(243, 1, 'last_login_date', 'Date of Last Login'),
(244, 1, 'private_profile', 'Private Profile'),
(245, 1, 'avatar_url', 'Avatar URL'),
(246, 1, 'title', 'Title'),
(247, 1, 'phone_number', 'Phone Number'),
(248, 1, 'birth_month', 'Birth Month'),
(249, 1, 'birth_day', 'Birth Day'),
(250, 1, 'birth_year', 'Birth Year'),
(251, 1, 'gender', 'Gender'),
(252, 1, 'bio', 'Bio'),
(253, 1, 'website', 'Website'),
(254, 1, 'site_language', 'Site Language'),
(255, 1, 'name', 'Name'),
(256, 1, 'comment', 'Comment'),
(257, 1, 'can_view_site', 'Can View Site'),
(258, 1, 'can_upload', 'Can Upload'),
(259, 1, 'can_admin_site', 'Can Administer Site'),
(260, 1, 'can_view_debug_messages', 'Can View Debug Messages'),
(261, 1, 'can_view_user_profiles', 'Can View User Profiles'),
(262, 1, 'can_edit_own_profile', 'Can Edit Own Profile'),
(263, 1, 'can_change_own_password', 'Can Change Own Password'),
(264, 1, 'site', 'Site'),
(267, 1, 'news_feed', 'News Feed'),
(268, 1, 'duplicate_uploads_forbidden', 'Duplicate uploads forbidden'),
(269, 1, 'buy_me', 'Buy Me'),
(270, 1, 'error_upload_image_height', 'This image''s height is less than the minimum requirement of:  '),
(271, 1, 'error_upload_image_width', 'This image''s width is less than the minimum requirement of:  '),
(272, 1, 'error_duplicate_uploads_forbidden', 'Duplicate uploads are forbidden by the Site Administrator. This file is already uploaded to your account.'),
(273, 3, 'username', 'Имя пользователя'),
(274, 3, 'login', 'Войти'),
(275, 3, 'password', 'пароль'),
(276, 3, 'register', 'Регистрация'),
(277, 3, 'forgot_password', 'Забыли Пароль?'),
(278, 3, 'language', 'язык'),
(279, 3, 'theme', 'тема'),
(280, 1, 'logon_to', 'Log on to'),
(281, 3, 'logon_to', 'Войдите на'),
(282, 2, 'logon_to', 'Melden Sie sich an'),
(283, 3, 'logout', 'Выход'),
(284, 1, 'view_profile', 'View Profile'),
(285, 1, 'edit_profile', 'Edit Profile'),
(286, 3, 'upload', 'Загрузить'),
(287, 3, 'buy_me', 'Купить этот'),
(288, 3, 'view_profile', 'Просмотр профиля'),
(289, 3, 'edit_profile', 'Редактировать профиль'),
(290, 1, 'prompt_write_comment', 'Write a comment...'),
(291, 2, 'prompt_write_comment', 'Schreibe einen Kommentar...'),
(292, 3, 'prompt_write_comment', 'Написать комментарий...'),
(293, 3, 'you', 'вы'),
(294, 3, 'like_this', 'полюбоваться этим'),
(295, 2, 'like_this', 'mögen diese'),
(296, 2, 'likes_this', 'gefällt das'),
(297, 3, 'likes_this', 'любит это'),
(298, 1, 'prompt_no_likes', 'No one has liked this yet'),
(299, 3, 'prompt_no_likes', 'Никто не еще это понравилось'),
(300, 2, 'prompt_no_likes', 'Niemand hat diese gefallen'),
(301, 2, 'others_like_this', 'anderen gefällt das'),
(302, 1, 'like_this', 'like this'),
(303, 1, 'others_like_this', 'others like this'),
(305, 1, 'report_content', 'Report Inappropriate Content'),
(306, 1, 'view_media', 'View Media'),
(307, 1, 'media_options', 'Media Options'),
(309, 2, 'view_profile', 'Profil ansehen'),
(310, 2, 'edit_profile', 'Profil bearbeiten'),
(311, 2, 'buy_me', 'Kauf mich'),
(315, 3, 'cancel', 'отменить'),
(316, 3, 'media_options', 'Опции СМИ'),
(317, 3, 'view_media', 'Посмотреть СМИ'),
(318, 3, 'report_content', 'Сообщить о недопустимом содержимом'),
(319, 2, 'report_content', 'Missbrauch bei Moderator melden'),
(320, 2, 'media_options', 'Medienoptionen'),
(321, 2, 'view_media', 'Medien Anschauen'),
(322, 1, 'and', 'and'),
(323, 2, 'and', 'und'),
(324, 3, 'and', 'и'),
(325, 1, 'prompt_leave_comment', 'Leave a comment...'),
(326, 2, 'prompt_leave_comment', 'Kommentar schreiben...'),
(327, 3, 'prompt_leave_comment', 'Оставить комментарий...'),
(328, 1, 'change_password', 'Change Password'),
(329, 3, 'change_password', 'Изменить Пароль'),
(330, 3, 'your_account', 'Ваш аккаунт'),
(331, 3, 'news_feed', 'Лента новостей'),
(332, 2, 'news_feed', 'Nachrichten'),
(333, 1, 'select', 'Select'),
(334, 2, 'select', 'Wählen'),
(335, 3, 'select', 'выбрать'),
(336, 1, 'files', 'Files'),
(337, 3, 'files', 'файлы'),
(339, 1, 'finish', 'Finish'),
(340, 2, 'finish', 'Fertig'),
(341, 3, 'finish', 'отделка'),
(342, 1, 'no_files_selected', 'No files selected'),
(343, 3, 'no_files_selected', 'Никакие файлы не выбран'),
(344, 2, 'no_files_selected', 'Keine Dateien ausgewählt'),
(345, 3, 'permission_error_edit_own_profile', 'Ваша учетная запись не имеет Редактировать профиль разрешение'),
(346, 3, 'error', 'ошибка'),
(347, 2, 'error', 'Fehler'),
(348, 2, 'change_password', 'Kennwort ändern'),
(349, 2, 'permission_error_edit_own_profile', 'Ihr Konto habt nicht die "Profil bearbeiten" Berechtigung'),
(350, 1, 'finalize', 'Finalize'),
(351, 2, 'finalize', 'Fertig'),
(352, 3, 'finalize', 'окончательную'),
(353, 1, 'caption', 'Caption'),
(354, 3, 'caption', 'подпись'),
(355, 2, 'caption', 'Bildunterschrift'),
(356, 1, 'photo', 'Photo'),
(357, 2, 'photo', 'Bild'),
(358, 1, 'video', 'Video'),
(359, 1, 'by', 'by'),
(360, 1, 'on', 'on'),
(361, 3, 'video', 'видео'),
(362, 3, 'photo', 'фото'),
(363, 3, 'by', 'по'),
(364, 2, 'by', 'von'),
(365, 2, 'on', 'auf'),
(366, 3, 'on', 'на'),
(367, 1, 'blocked_by_user', 'You are blocked by this user'),
(368, 2, 'blocked_by_user', 'Sie sind bei dieses Benutzers blockiert'),
(369, 3, 'blocked_by_user', 'Вы заблокированы на этого пользователя'),
(370, 1, 'report_user', 'Report User'),
(371, 1, 'all_items_loaded', 'All items loaded'),
(372, 2, 'all_items_loaded', 'Alle Einzelteile geladen'),
(373, 3, 'all_items_loaded', 'Все детали загружен'),
(374, 1, 'posts', 'posts'),
(375, 3, 'posts', 'пункты'),
(376, 2, 'posts', 'Einträge'),
(377, 2, 'followers', 'Anhänger'),
(378, 2, 'following', 'Folgende'),
(379, 3, 'followers', 'последователи'),
(380, 3, 'following', 'после'),
(381, 1, 'loading', 'Loading'),
(382, 2, 'loading', 'Laden'),
(383, 3, 'loading', 'загрузка'),
(384, 1, 'load_more', 'Load more'),
(385, 2, 'load_more', 'laden mehr'),
(386, 3, 'load_more', 'Загрузить еще'),
(387, 1, 'follow', 'Follow'),
(388, 2, 'follow', 'Folgen'),
(389, 3, 'follow', 'следовать'),
(390, 1, 'requested', 'Requested'),
(391, 2, 'requested', 'Angeforderte'),
(392, 3, 'requested', 'запрошенный'),
(393, 2, 'edit', 'Bearbeiten'),
(394, 3, 'edit', 'менять'),
(395, 1, 'prompt_field_required', 'This field is required'),
(396, 4, 'buy_me', 'Beni satın'),
(397, 4, 'edit', 'Düzenle'),
(398, 4, 'language', 'Dil'),
(399, 4, 'upload', 'Yükle'),
(400, 4, 'cancel', 'iptal'),
(401, 4, 'logout', 'Çıkış'),
(402, 4, 'view_profile', 'Profili'),
(403, 4, 'edit_profile', 'Profil Düzenle'),
(404, 4, 'posts', 'mesajlar'),
(405, 4, 'followers', 'takipçileri'),
(406, 4, 'following', 'aşağıdaki'),
(407, 4, 'december', 'Aralık'),
(408, 4, 'loading', 'yükleme'),
(409, 4, 'top', 'üst'),
(410, 4, 'news_feed', 'Haber kaynağı'),
(411, 4, 'your_account', 'Hesabınız'),
(412, 4, 'media_options', 'medya seçenekleri'),
(413, 4, 'view_media', 'görünümü medya'),
(414, 4, 'report_content', 'uygunsuz içeriği rapor'),
(415, 4, 'you', 'Sen'),
(416, 4, 'like_this', 'bu hayran'),
(417, 4, 'caption', 'başlık'),
(418, 4, 'prompt_write_comment', 'Bir Yorum Yazın'),
(419, 4, 'prompt_no_likes', 'Henüz hiç kimse bu sevdim etti'),
(420, 1, 'prompt_comment_delete', 'Comment Deletion'),
(421, 4, 'prompt_comment_deletion', 'Bu yorumu silmek istiyor emin misiniz?'),
(422, 1, 'prompt_comment_deletion', 'Are you sure that you wish to delete this comment?'),
(423, 4, 'prompt_comment_delete', 'Silme Yorum'),
(424, 4, 'login', 'Oturum Aç'),
(425, 4, 'register', 'Kayıt'),
(426, 4, 'forgot_password', 'Parolanızı Mı Unuttunuz?'),
(427, 4, 'username', 'Kullanıcı adı'),
(428, 4, 'password', 'şifre'),
(429, 1, 'demo_credentials', 'Demo Credentials'),
(430, 4, 'demo_credentials', 'gösteri Kimlik'),
(431, 2, 'demo_credentials', 'Demo Referenzen'),
(432, 3, 'demo_credentials', 'Демо Полномочия'),
(433, 1, 'theme', 'Theme'),
(434, 4, 'theme', 'Motif'),
(435, 4, 'prompt_leave_comment', 'Mesaj bırakın'),
(436, 4, 'logon_to', 'oturum açma'),
(437, 4, 'first_name', 'İsim'),
(438, 4, 'last_name', 'Soyadı'),
(439, 4, 'email', 'E-posta'),
(440, 1, 'password_confirm', 'Password Confirm'),
(441, 4, 'password_confirm', 'Şifre Onayla'),
(442, 4, 'reset_password', 'Parola Sıfırlama'),
(443, 4, 'guest', 'konuk'),
(444, 3, 'guest', 'гость'),
(445, 1, 'guest', 'Guest'),
(446, 2, 'guest', 'Gast'),
(447, 2, 'first_name', 'Vorname'),
(448, 2, 'last_name', 'Nachname'),
(449, 2, 'password_confirm', 'Kennort Bestätigen'),
(450, 3, 'first_name', 'Имя'),
(451, 3, 'last_name', 'фамилия'),
(452, 3, 'email', 'е-мейл'),
(453, 3, 'password_confirm', 'Подтвердите Пароль'),
(454, 4, 'select', 'seçmek'),
(455, 4, 'finalize', 'sonuçlandırmak'),
(456, 4, 'finish', 'bitirmek'),
(457, 4, 'add_captions', 'başlık eklemek'),
(458, 4, 'upload_more', 'daha fazla yüklemek'),
(459, 4, 'change_password', 'Şifre Değiştir'),
(460, 4, 'files', 'Dosyalar'),
(461, 4, 'no_files_selected', 'Seçili dosya yok'),
(462, 4, 'error_duplicate_uploads_forbidden', 'Yinelenen yüklenenler Sitesi Yöneticisi tarafından yasak. Bu dosya zaten hesabınıza yüklenir.'),
(463, 1, 'upload_complete', 'Upload Complete'),
(464, 4, 'upload_complete', 'Tam yükle'),
(465, 4, 'on', 'üzerinde'),
(466, 4, 'by', 'tarafından'),
(467, 1, 'prompt_uploads_complete', 'Your upload(s) have successfully completed.<br>You have the option to upload more files or add captions.<br>Captions are automatically saved.'),
(468, 4, 'prompt_uploads_complete', 'Sizin yükleme (lar) başarıyla tamamladınız.<br>Daha fazla dosya yükleyebilir veya başlık eklemek için seçeneğiniz vardır.<br>Başlıklar otomatik olarak kaydedilir.'),
(469, 3, 'prompt_uploads_complete', 'Ваше загрузки успешно завершена.<br>У вас есть возможность загружать несколько файлов или добавить титры.<br>Подписи сохраняются автоматически.'),
(470, 2, 'prompt_uploads_complete', 'Upload erfolgreich abgeschlossen haben.<br>Sie haben die Möglichkeit, mehr Dateien hochladen oder Bildunterschriften hinzufügen.<br>Untertitel werden automatisch gespeichert.'),
(471, 1, 'upload_more', 'Upload more'),
(472, 1, 'add_captions', 'Add Captions'),
(473, 3, 'add_captions', 'Добавить подписи'),
(474, 3, 'upload_more', 'Загрузить больше'),
(475, 2, 'upload_complete', 'Hochladen abgeschlossen'),
(476, 2, 'add_captions', 'Bildunterschriften hinzufügen'),
(477, 2, 'upload_more', 'Laden mehrere'),
(478, 3, 'error_duplicate_uploads_forbidden', 'Повторяющиеся добавления запрещено администратором сайта. Этот файл уже закачан на ваш аккаунт.'),
(479, 2, 'error_duplicate_uploads_forbidden', 'Doppelte Uploads werden vom Administrator verboten. Diese Datei ist bereits auf Ihr Konto hochgeladen.'),
(480, 4, 'permission_error_edit_own_profile', 'Hesabınız ''Profil Düzenle'' izni yok'),
(481, 4, 'error', 'Hata'),
(482, 4, 'permission_error_change_own_password', 'Hesabınız ''Şifre Değiştirme'' izni verilmiş değil'),
(483, 2, 'permission_error_change_own_password', 'Ihr Konto hat nicht die "Change Password" Erlaubnis'),
(484, 3, 'permission_error_change_own_password', 'Ваша учетная запись не была предоставлена "Изменить пароль" разрешение'),
(485, 5, 'you', 'Usted'),
(486, 5, 'login', 'Iniciar Sesión'),
(487, 5, 'username', 'Nombre de usuario'),
(488, 5, 'password', 'Contraseña'),
(489, 5, 'register', 'Registrarse'),
(490, 5, 'forgot_password', 'Has Olvidado Tu Contraseña?'),
(491, 5, 'language', 'Idioma'),
(492, 5, 'theme', 'Estilo'),
(493, 5, 'logon_to', 'Inicie sesión en'),
(494, 5, 'demo_credentials', 'Credenciales de demostración'),
(495, 5, 'december', 'Diciembre'),
(496, 5, 'buy_me', 'Compra de mí'),
(497, 5, 'on', 'en'),
(498, 5, 'edit', 'Editar'),
(499, 5, 'upload', 'Subir'),
(500, 5, 'posts', 'mensajes'),
(501, 5, 'followers', 'seguidores'),
(502, 5, 'following', 'siguiente'),
(503, 5, 'logout', 'Cerrar sesión'),
(504, 5, 'loading', 'Cargando'),
(505, 5, 'all_items_loaded', 'Todos los artículos cargados'),
(506, 5, 'view_profile', 'Ver Perfil'),
(507, 5, 'edit_profile', 'Editar Perfil'),
(508, 5, 'prompt_leave_comment', 'Deja un comentario'),
(509, 5, 'media_options', 'Opciones de medios'),
(510, 5, 'view_media', 'Ver página de medios'),
(511, 5, 'report_content', 'Denuncia contenido inapropiado'),
(512, 5, 'like_this', 'admirar este'),
(513, 5, 'others_like_this', 'otros admiran este'),
(514, 5, 'prompt_no_likes', 'Nadie ha gustado esto todavía'),
(515, 3, 'december', 'декабрь'),
(516, 2, 'december', 'Dezember'),
(517, 1, 'january', 'January'),
(518, 2, 'february', 'Februar'),
(519, 2, 'march', 'März'),
(520, 2, 'april', 'April'),
(521, 2, 'may', 'Mai'),
(522, 2, 'june', 'Juni'),
(523, 2, 'july', 'Juli'),
(524, 2, 'october', 'Oktober'),
(525, 3, 'january', 'январь'),
(526, 3, 'february', 'февраль'),
(527, 3, 'march', 'март'),
(528, 3, 'april', 'апреля'),
(529, 3, 'may', 'мая'),
(530, 3, 'june', 'июнь'),
(531, 3, 'july', 'июль'),
(532, 3, 'august', 'август'),
(533, 3, 'september', 'сентябрь'),
(534, 3, 'october', 'октября'),
(535, 3, 'november', 'ноябрь'),
(536, 5, 'january', 'Enero'),
(537, 5, 'february', 'Febrero'),
(538, 5, 'march', 'Marzo'),
(539, 5, 'april', 'Abril'),
(540, 5, 'may', 'Mayo'),
(541, 5, 'june', 'Junio'),
(542, 5, 'july', 'Julio'),
(543, 5, 'august', 'Agosto'),
(544, 5, 'september', 'Septiembre'),
(545, 5, 'october', 'Octubre'),
(546, 5, 'november', 'Noviembre'),
(547, 4, 'january', 'Ocak'),
(548, 4, 'february', 'Şubat'),
(549, 4, 'march', 'Mart'),
(550, 4, 'april', 'Nisan'),
(551, 4, 'may', 'Mayıs'),
(552, 4, 'june', 'Haziran'),
(553, 4, 'july', 'Temmuz'),
(554, 4, 'august', 'Ağustos'),
(555, 4, 'september', 'Eylül'),
(556, 4, 'october', 'Ekim'),
(557, 4, 'november', 'Kasım'),
(558, 5, 'cancel', 'Cancelar'),
(559, 5, 'prompt_write_comment', 'Escribir un comentario'),
(560, 5, 'load_more', 'Cargar más'),
(561, 5, 'your_account', 'Su cuenta'),
(562, 5, 'change_password', 'Cambiar La Contraseña'),
(563, 5, 'news_feed', 'Suministro de noticias'),
(564, 5, 'files', 'Archivos'),
(565, 5, 'no_files_selected', 'No hay archivos seleccionados'),
(566, 5, 'select', 'Seleccionar'),
(567, 5, 'finish', 'Acabado'),
(568, 5, 'finalize', 'Ultimar'),
(569, 5, 'upload_more', 'Sube más'),
(570, 5, 'add_captions', 'Añadir títulos'),
(571, 5, 'upload_complete', 'Carga completa'),
(572, 5, 'error_duplicate_uploads_forbidden', 'Archivos duplicados están prohibidos por el administrador del sitio. Este archivo ya se ha cargado a su cuenta.'),
(573, 5, 'caption', 'Subtítulo'),
(574, 5, 'prompt_uploads_complete', 'La subida han completado con éxito.<br>Usted tiene la opción de cargar más archivos o añadir subtítulos.<br>Los subtítulos se guardan automáticamente.'),
(575, 5, 'error', 'Fracaso'),
(576, 5, 'permission_error_edit_own_profile', 'Su cuenta no tiene permiso "Editar Perfil"'),
(577, 5, 'permission_error_change_own_password', 'Tu cuenta no se ha concedido el permiso ''Cambiar Contraseña'''),
(578, 5, 'delete', 'Borrar'),
(579, 5, 'prompt_comment_delete', 'Supresión Comentario'),
(580, 3, 'prompt_comment_delete', 'Комментарий Удаление'),
(581, 2, 'prompt_comment_delete', 'Kommentar Löschen'),
(582, 2, 'prompt_comment_deletion', 'Bist du sicher, dass du diesen Kommentar löschen wollen?'),
(583, 3, 'prompt_comment_deletion', 'Вы уверены, что хотите удалить этот комментарий?'),
(584, 5, 'prompt_comment_deletion', '¿Seguro que desea eliminar este comentario?'),
(585, 1, 'delete', 'Delete'),
(586, 2, 'delete', 'Löschen'),
(587, 4, 'delete', 'Silmek'),
(588, 3, 'delete', 'удалять'),
(589, 6, 'language', '語言'),
(590, 6, 'login', '登錄'),
(591, 6, 'username', '用戶名'),
(592, 6, 'password', '密碼'),
(593, 6, 'register', '註冊'),
(594, 6, 'forgot_password', '忘記密碼？'),
(595, 6, 'demo_credentials', '演示證書'),
(596, 6, 'theme', '主題'),
(597, 6, 'logon_to', '登錄到'),
(599, 6, 'buy_me', '我買'),
(600, 1, 'authentication_ok', 'Authentication Successful'),
(601, 1, 'authentication_ok_text', 'You were successfully logged in. Let''s Rock!'),
(602, 6, 'upload', '上傳'),
(603, 6, 'logout', '註銷'),
(604, 6, 'view_profile', '查看資料'),
(605, 6, 'edit_profile', '編輯個人資料'),
(606, 6, 'cancel', '取消'),
(607, 6, 'media_options', '媒體選項'),
(608, 6, 'prompt_no_likes', '沒有人喜歡這個尚未'),
(609, 6, 'view_media', '查看媒體頁面'),
(610, 6, 'report_content', '舉報不適當的內容'),
(611, 6, 'you', '你'),
(612, 6, 'like_this', '佩服這個'),
(613, 6, 'prompt_write_comment', '寫評論'),
(614, 6, 'authentication_ok', '認證成功'),
(615, 6, 'authentication_ok_text', '您可以登錄'),
(616, 6, 'error', '錯誤'),
(617, 6, 'authentication_failure', '驗證失敗'),
(618, 6, 'edit', '編輯'),
(619, 6, 'december', '十二月'),
(620, 6, 'posts', '帖子'),
(621, 6, 'loading', '載入中'),
(622, 6, 'followers', '追隨者'),
(623, 6, 'following', '以下'),
(624, 6, 'delete', '刪除'),
(625, 6, 'prompt_leave_comment', '發表評論'),
(626, 6, 'prompt_comment_deletion', '你確定要刪除此評論嗎？'),
(627, 6, 'prompt_comment_delete', '刪除評論'),
(628, 6, 'change_password', '更改密碼'),
(629, 6, 'select', '選擇'),
(630, 6, 'finish', '完'),
(631, 6, 'your_account', '您的帳戶'),
(632, 6, 'news_feed', '新聞源'),
(633, 6, 'files', '檔'),
(634, 6, 'no_files_selected', '未選擇任何文件'),
(635, 6, 'add_captions', '添加字幕'),
(636, 6, 'upload_complete', '上傳完成'),
(637, 6, 'upload_more', '上傳更多'),
(638, 6, 'prompt_uploads_complete', '上載已成功完成。<br>你要上傳多個文件或添加字幕的選項。<br>字幕被自動保存。'),
(639, 6, 'error_duplicate_uploads_forbidden', '重複上傳由站點管理員禁止。此文件已上傳到您的帳戶。'),
(640, 1, 'media_deletion', 'Media Deletion'),
(641, 1, 'prompt_media_delete', 'Are you sure that you wish to delete this media item?'),
(642, 6, 'photo', '照片'),
(643, 6, 'by', '由'),
(644, 6, 'on', '上'),
(645, 6, 'media_deletion', '媒體刪除'),
(646, 6, 'prompt_media_delete', '你確定要刪除這個媒體項目？'),
(647, 2, 'prompt_media_delete', 'Sind Sie sicher, dass Sie diese Medien wirklich löschen wollen?'),
(648, 2, 'media_deletion', 'Medien Löschen'),
(649, 5, 'media_deletion', 'Medios Supresión'),
(650, 5, 'prompt_media_delete', '¿Estás seguro que quieres borrar este archivo de medios?'),
(651, 4, 'prompt_media_delete', 'Eğer bu medya öğeyi silmek istediğinizden emin misiniz?'),
(652, 4, 'media_deletion', 'Medya Silme'),
(653, 3, 'media_deletion', 'Медиа Удаление'),
(654, 3, 'prompt_media_delete', 'Вы уверены, что хотите удалить эту композицию?'),
(655, 2, 'authentication_ok', 'Authentifizierung erfolgreich'),
(656, 2, 'authentication_ok_text', 'Sie sind jetzt angemeldet. Jetzt gehts los.'),
(657, 4, 'authentication_ok', 'Başarılı Kimlik Doğrulama'),
(658, 4, 'authentication_ok_text', 'Şimdi kaydedilir. Lütfen bekleyin.'),
(659, 5, 'authentication_ok_text', 'Ahora está en el sistema. Por favor, espere.'),
(660, 5, 'authentication_ok', 'Autenticación Exitosa'),
(661, 3, 'authentication_ok', 'Аутентификация Преемник'),
(662, 3, 'authentication_ok_text', 'Вы вошли в систему. Пожалуйста, подождите.'),
(663, 1, 'likes_this', 'likes this'),
(664, 1, 'error_exceeds_max_size', 'This file exceeds the maximum permitted file size for this file type.'),
(665, 1, 'email_confirm', 'Confirm e-mail'),
(666, 1, 'try_again', 'Try again'),
(667, 1, 'username_exists', 'Username exists'),
(668, 1, 'user_registration_ok', 'Registration Succeeded'),
(669, 1, 'reset', 'Reset'),
(670, 1, 'account_created', 'Account Created'),
(671, 1, 'prompt_error_confirm_code', 'The specified account confirmation code does not exist'),
(672, 1, 'account_confirmed', 'Account Confirmed'),
(673, 1, 'prompt_confirm_code_ok', 'Your account has been successfully confirmed'),
(674, 1, 'recaptcha_error', 'reCAPTCHA Error'),
(675, 1, 'check_your_email', 'Check your e-mail'),
(676, 1, 'error_user_account', 'User Account Error'),
(677, 1, 'password_reset', 'Password Reset'),
(678, 1, 'prompt_password_reset_ok', 'Your password has been reset. Check your e-mail for further details.'),
(679, 1, 'prompt_error_password_reset', 'An error has occurred while resetting your password. Your password has not been changed.'),
(680, 1, 'prompt_error_permission', 'Your account does not have sufficient permissions to perform this action.'),
(681, 3, 'about_us', 'О нас'),
(682, 3, 'privacy', 'Конфиденциальность'),
(683, 3, 'terms', 'Условия'),
(684, 3, 'admin', 'Admin'),
(685, 3, 'ago', 'ago'),
(686, 3, 'avatar_url', 'Avatar URL'),
(687, 3, 'bio', 'Bio'),
(688, 3, 'birth_day', 'Birth Day'),
(689, 3, 'birth_month', 'Birth Month'),
(690, 3, 'birth_year', 'Birth Year'),
(691, 3, 'can_admin_site', 'Can Administer Site'),
(692, 3, 'can_change_own_password', 'Can Change Own Password'),
(693, 3, 'can_edit_own_profile', 'Can Edit Own Profile'),
(694, 3, 'can_upload', 'Can Upload'),
(695, 3, 'can_view_debug_messages', 'Can View Debug Messages'),
(696, 3, 'can_view_site', 'Can View Site'),
(697, 3, 'can_view_user_profiles', 'Can View User Profiles'),
(698, 3, 'comment', 'Comment'),
(699, 3, 'email_or_username', 'e-mail or Username'),
(700, 3, 'gender', 'Gender'),
(701, 3, 'homepage_app_description', '<p>\r\nIt’s a <b>fast</b>, <b>beautiful</b> and <b>fun</b> way to share your photos with friends and family.\r\n</p>\r\n<p>\r\nSnap a picture, choose a filter to transform its look and feel, then post to Instagram. Share to Facebook, Twitter, and Tumblr too – it''s as easy as pie. It''s photo sharing, reinvented.\r\n</p>\r\n<p>\r\nOh yeah, did we mention it’s free?\r\n</p>'),
(702, 3, 'homepage_header', 'Meet Instagram'),
(703, 3, 'hours', 'hours'),
(704, 3, 'http_error_404_text', 'Sorry, this page could not be found.'),
(705, 3, 'id', 'ID'),
(706, 3, 'join_date', 'Join Date'),
(707, 3, 'last_active', 'Last Active'),
(708, 3, 'last_ip', 'Last IP'),
(709, 3, 'last_login_date', 'Date of Last Login'),
(710, 3, 'like_or_comment', 'to like or comment'),
(711, 3, 'like_this_object', 'like this'),
(712, 3, 'name', 'Name'),
(713, 3, 'need_to_follow', 'You need to be following'),
(714, 3, 'no_photos_to_display', 'No photos to show.'),
(715, 3, 'no_recent_photos', 'No Recent Photos'),
(716, 3, 'no_upload_permission', 'Your account does not have upload permissions'),
(717, 3, 'password_reset_tip', 'We can help you reset your password using your Instagram username or the email address linked to your account.'),
(718, 3, 'permission_error_view_user_profiles', 'Your account does not have the ''View User Profiles'' permission'),
(719, 3, 'phone_number', 'Phone Number'),
(720, 3, 'private_profile', 'Private Profile'),
(721, 3, 'profile_privacy_notice', 'This profile is private. Only users who follow this user can view this page.'),
(722, 3, 'reset_password', 'Reset Password'),
(723, 3, 'self_profile_privacy_notice', 'Your profile is private. Only users who follow you can view this page.'),
(724, 3, 'signup_ip', 'Signup IP'),
(725, 3, 'site', 'Site'),
(726, 3, 'site_admin_pagination_items_per_page', 'Items per page (Admin Pagination)'),
(727, 3, 'site_allow_duplicate_uploads_same_user', 'Allow Duplicate Uploads from Same User'),
(728, 3, 'site_allow_signup', 'Allow User Registration'),
(729, 3, 'site_allow_template_change', 'Allow Template Change'),
(730, 3, 'site_allow_url_in_comment', 'Allow URLs in Comments'),
(731, 3, 'site_allowed_image_types', 'Allow Image Types'),
(732, 3, 'site_allowed_video_types', 'Allowed Video Types'),
(733, 3, 'site_censor_replacement', 'Censor Replacement'),
(734, 3, 'site_censor_replacement_type', 'Censor Replacement'),
(735, 3, 'site_comment_fetch_limit', 'Comment Fetch Limit'),
(736, 3, 'site_comp_image_limit', 'User Profile Header Image Limit'),
(737, 3, 'site_cookie_domain', 'Cookie Domain'),
(738, 3, 'site_cookie_path', 'Cookie Path'),
(739, 3, 'site_cookie_timeout', 'Cookie Timeout'),
(740, 3, 'site_debug', 'Debug Mode'),
(741, 3, 'site_default_admin_template', 'Site Admin Template'),
(742, 3, 'site_default_admin_template_path', 'Admin Template Path'),
(743, 3, 'site_default_avatar_url', 'Default Avatar URL'),
(744, 3, 'site_default_image_resize_type', 'Image Resize Type'),
(745, 3, 'site_default_landing_page', 'Default Landing Page'),
(746, 3, 'site_default_landing_page_after_login', 'Landing Page After Login'),
(747, 3, 'site_default_language', 'Default Site Language'),
(748, 3, 'site_default_media_fetch_limit', 'Media Fetch Limit (on user profile page)'),
(749, 3, 'site_default_preloader_image_path', 'Preloader URL Path'),
(750, 3, 'site_default_template', 'Default Site Template'),
(751, 3, 'site_default_usergroup', 'Default Usergroup'),
(752, 3, 'site_demo_mode', 'Demo Mode'),
(753, 3, 'site_ffmpeg_path', 'FFMPEG Path'),
(754, 3, 'site_language', 'Site Language'),
(755, 3, 'site_local_theme_url_root', 'Theme Root Path'),
(756, 3, 'site_medium_image_height', 'Medium Image Height'),
(757, 3, 'site_medium_image_width', 'Medium Image Width'),
(758, 3, 'site_moderate_new_users', 'Moderate New Users'),
(759, 3, 'site_mp4box_path', 'MP4Box Path'),
(760, 3, 'site_name', 'Site Name'),
(761, 3, 'site_overview_comment_display', 'Numbers of Comments to Display in Overview'),
(762, 3, 'site_parse_url_in_comment', 'Parse URLs in Comments'),
(763, 3, 'site_recaptcha_private_key', 'reCAPTCHA Private Key'),
(764, 3, 'site_recaptcha_public_key', 'reCAPTHCA Public Key'),
(765, 3, 'site_recent_activity_threshold', 'Recent Activity Threshold'),
(766, 3, 'site_recent_post_limit', 'Recent Post Limit'),
(767, 3, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration?'),
(768, 3, 'site_rotate_user_comp_header', 'Rotate User Header Images'),
(769, 3, 'site_rotate_user_comp_header_interval', 'Header Rotation Interval (in seconds)'),
(770, 3, 'site_show_user_suggestions', 'Display User Suggestions'),
(771, 3, 'site_status', 'Status'),
(772, 3, 'site_thumbnail_height', 'Thumbnail Height'),
(773, 3, 'site_thumbnail_width', 'Thumbnail Width'),
(774, 3, 'site_upload_dir', 'Upload Diretory'),
(775, 3, 'site_upload_dir_users', 'Destination Directory for User Uploads'),
(776, 3, 'site_user_comp_header_flip_interval', 'Header Flip Interval'),
(777, 3, 'support', 'Support'),
(778, 3, 'title', 'Title'),
(779, 3, 'user', 'User'),
(780, 3, 'user_is_private', 'This user is private'),
(781, 3, 'website', 'Website'),
(782, 1, 'site_avatar_height', 'Avatar Height'),
(783, 3, 'site_avatar_height', 'Аватар Высота'),
(784, 1, 'save', 'Save'),
(785, 3, 'save', 'Сохранить'),
(786, 1, 'media', 'Media'),
(787, 3, 'media', 'Медиа'),
(788, 2, 'media', 'Medien'),
(790, 3, 'site_phrases', 'сайт Фразы'),
(791, 1, 'site_config', 'Site Config'),
(792, 3, 'site_config', 'Конфигурация сайта'),
(794, 3, 'site_settings', 'Настройки сайта'),
(795, 1, 'phrases_saved', 'Phrases saved'),
(796, 3, 'phrases_saved', 'Фразы сохранены'),
(797, 1, 'update_successful', 'Update successful'),
(798, 3, 'update_successful', 'Обновление успешно'),
(799, 1, 'you_are_here', 'You are here'),
(800, 3, 'you_are_here', 'Вы здесь'),
(801, 1, 'users', 'Users'),
(802, 3, 'users', 'Пользователи'),
(803, 1, 'usergroups', 'Usergroups'),
(804, 3, 'usergroups', 'Группы'),
(805, 1, 'my_account', 'My Account'),
(806, 3, 'my_account', 'Мой аккаунт'),
(807, 1, 'profile', 'Profile'),
(808, 3, 'profile', 'Профиль'),
(809, 1, 'upgrade', 'Upgrade'),
(810, 3, 'upgrade', 'модернизация'),
(811, 1, 'upgrade_required', 'Upgrade Required'),
(812, 1, 'can_delete_own_account', 'Can Delete Own Account'),
(813, 1, 'prompt_follow_people', 'Follow friends and interesting people to see their photos here.'),
(814, 1, 'prompt_suggestions', 'Here are some suggestions.'),
(815, 1, 'following', 'Following'),
(816, 1, 'prompt_how_is_work', 'How is Work?'),
(817, 2, 'prompt_how_is_work', 'Wie ist die Arbeit?'),
(818, 1, 'post', 'Post'),
(819, 1, 'prompt_whats_new', 'What''s New?'),
(820, 2, 'prompt_whats_new', 'Wie läuft''s bei dir?'),
(823, 1, 'like', 'Like'),
(824, 2, 'like', 'Gefällt mir'),
(825, 2, 'comment', 'Kommentieren'),
(828, 1, 'deletion_confirmation', 'Deletion Confirmation'),
(829, 1, 'prompt_message_deletion_confirmation', 'Are you sure that you want to delete this message?'),
(830, 2, 'post', 'Absenden');

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_config`
--

CREATE TABLE IF NOT EXISTS `openface_site_config` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=95 ;

--
-- Dumping data for table `openface_site_config`
--

INSERT INTO `openface_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `editable`, `hint`, `comment`) VALUES
(1, 'site_name', 'OpenFace', NULL, 'global', 'text', '1', 'Site Name', NULL),
(2, 'site_default_preloader_image_path', '<i class="fa fa-spinner fa-spin"></i>', NULL, 'global', 'text', '1', NULL, NULL),
(3, 'site_default_landing_page', '', NULL, 'global', 'text', '1', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL),
(4, 'site_allow_template_change', '1', '0,1', 'global', 'radio', '1', 'Allow Template Change', NULL),
(5, 'site_default_template', 'openface', NULL, 'global', 'text', '1', NULL, NULL),
(6, 'site_default_max_upload_size', '1073741824', NULL, 'upload', 'text', '1', 'Max upload size in bytes', 'in bytes'),
(7, 'site_allowed_file_types', '*', NULL, 'upload', 'text', '1', 'File types allowed for upload. Separate entries with commas. Use * to allow all.', NULL),
(8, 'site_default_avatar_url', '__BASEURL__/images/profiles/default.png', NULL, 'user', 'text', '1', 'Full URL of the default user avatar', NULL),
(9, 'site_default_language', 'en-us', NULL, 'global', 'text', '1', NULL, NULL),
(10, 'site_guest_max_recipients', '3', NULL, 'upload', 'text', '1', NULL, NULL),
(11, 'site_guest_max_queue_size', '5', NULL, 'upload', 'text', '1', NULL, NULL),
(12, 'site_guest_max_file_size', '2', NULL, 'upload', 'text', '1', NULL, 'in MB'),
(13, 'site_guest_total_file_size', '10', NULL, 'upload', 'text', '1', NULL, 'in MB'),
(14, 'site_allow_language_change', '1', '0,1', 'global', 'radio', '1', 'Allow Language Change', NULL),
(15, 'site_guest_upload_retention', '168', NULL, 'upload', 'text', '1', NULL, 'in hours'),
(16, 'site_moderate_new_users', '1', '0,1', 'user', 'radio', '1', NULL, NULL),
(17, 'site_require_email_confirm', '1', '0,1', 'user', 'radio', '1', 'Require e-mail confirmation for new user registrations', NULL),
(18, 'site_email_address', 'admin@bizlogicdev.com', NULL, 'global', 'text', '1', NULL, NULL),
(19, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory', NULL),
(20, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', '1', 'Relative path of the local file upload directory for end-users', NULL),
(22, 'site_token_min_length', '8', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL),
(23, 'site_token_max_length', '15', NULL, 'upload', 'text', '1', 'Tokens match users to available files', NULL),
(24, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', '1', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root'),
(25, 'site_default_admin_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'admin', 'text', '1', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL),
(26, 'site_default_landing_page_after_login', '', NULL, 'global', 'text', '1', NULL, NULL),
(52, 'site_use_blockui', '1', '1,0', 'global', 'radio', '1', NULL, NULL),
(53, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', '1', NULL, NULL),
(64, 'site_url', '__BASEURL__', NULL, 'global', 'text', '1', NULL, 'including scheme'),
(77, 'site_facebook_app_id', '324640691020497', NULL, 'social', 'text', '1', NULL, NULL),
(78, 'site_twitter_api_key', 'KS0tMXGV1jBPHcr9B2NsxplmU', NULL, 'social', 'text', '1', NULL, NULL),
(79, 'site_twitter_api_secret', '4SaA3aauMozDQqJIbEZIiwmJTYj1hBmaF6Ql0PILnBFHi604By', NULL, 'social', 'text', '1', NULL, NULL),
(80, 'site_allow_social_login', '1', '0,1', 'social', 'radio', '1', NULL, NULL),
(81, 'site_yahoo_consumer_key', 'dj0yJmk9RlBPU09OTXZxY3hPJmQ9WVdrOVZuVkRWWGRHTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Mg--', NULL, 'social', 'text', '1', NULL, NULL),
(82, 'site_yahoo_consumer_secret', 'e15419d9ab06e7cd727a252c16f03877e68cc7eb', NULL, 'social', 'text', '1', NULL, NULL),
(83, 'site_yahoo_app_id', 'VuCUwF36', NULL, 'social', 'text', '1', NULL, NULL),
(84, 'site_yahoo_domain', 'dev.vevoclone.com', NULL, 'social', 'text', '1', NULL, NULL),
(85, 'site_windows_live_client_id', '000000004811FC1F', NULL, 'social', 'text', '1', NULL, NULL),
(86, 'site_windows_live_client_secret', '2YIn7AR1kyqSliK5GVh-V6X3U6Bhn6pF', NULL, 'social', 'text', '1', NULL, NULL),
(87, 'site_guest_usergroup_id', '1', NULL, 'user', 'text', '1', NULL, NULL),
(88, 'site_cookie_expiration_date', '3153600000', NULL, 'global', 'text', '1', NULL, NULL),
(89, 'site_cookie_timeout', '3153600000', NULL, 'global', 'text', '1', NULL, NULL),
(90, 'site_cookie_path', '/', NULL, 'global', 'text', '1', NULL, NULL),
(91, 'site_global_html_header', NULL, NULL, 'global', 'text', '1', NULL, NULL),
(92, 'site_global_html_body_start', NULL, NULL, 'global', 'text', '1', NULL, NULL),
(93, 'site_global_html_body_end', NULL, NULL, 'global', 'text', '1', NULL, NULL),
(94, 'site_default_status_fetch_limit', '50', NULL, 'global', 'text', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_permission`
--

CREATE TABLE IF NOT EXISTS `openface_site_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_type` enum('admin','site','upload','user') COLLATE utf8_unicode_ci DEFAULT 'site',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_name` (`permission_name`,`permission_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `openface_site_permission`
--

INSERT INTO `openface_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES
(1, 'can_view_site', 'site', NULL),
(2, 'can_upload', 'upload', NULL),
(3, 'can_admin_site', 'admin', NULL),
(4, 'can_view_debug_messages', 'admin', NULL),
(5, 'can_view_user_profiles', 'site', NULL),
(6, 'can_edit_own_profile', 'user', NULL),
(7, 'can_change_own_password', 'user', NULL),
(8, 'can_delete_own_account', 'user', NULL),
(9, 'can_admin_site_phrases', 'admin', NULL),
(10, 'can_admin_users', 'admin', NULL),
(11, 'can_admin_files', 'admin', 'Can Administer Uploaded Files (Admin)'),
(12, 'can_use_firephp', 'admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_site_theme`
--

CREATE TABLE IF NOT EXISTS `openface_site_theme` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('custom','bootstrap','jquery-ui') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'custom',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=25 ;

--
-- Dumping data for table `openface_site_theme`
--

INSERT INTO `openface_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES
(1, 'bootstrap', 'cerulean', 'Cerulean', '1'),
(2, 'bootstrap', 'flatly', 'Flatly', '1'),
(4, 'bootstrap', 'slate', 'Slate', '1'),
(5, 'bootstrap', 'cosmo', 'Cosmo', '1'),
(6, 'bootstrap', 'darkly', 'Darkly', '1'),
(7, 'bootstrap', 'cyborg', 'Cyborg', '1'),
(8, 'bootstrap', 'journal', 'Journal', '1'),
(9, 'bootstrap', 'lumen', 'Lumen', '1'),
(10, 'bootstrap', 'readable', 'Readable', '1'),
(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1'),
(12, 'bootstrap', 'simplex', 'Simplex', '1'),
(13, 'bootstrap', 'spacelab', 'Spacelab', '1'),
(14, 'bootstrap', 'superhero', 'Superhero', '1'),
(15, 'bootstrap', 'united', 'United', '1'),
(16, 'bootstrap', 'bootstrap-theme', 'Bootstrap (w/ theme)', '1'),
(17, 'bootstrap', 'yeti', 'Yeti', '1'),
(22, 'bootstrap', 'paper', 'Paper', '1'),
(23, 'bootstrap', 'openface', 'OpenFace', '1');

-- --------------------------------------------------------

--
-- Table structure for table `openface_user`
--

CREATE TABLE IF NOT EXISTS `openface_user` (
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
-- Dumping data for table `openface_user`
--

INSERT INTO `openface_user` (`id`, `uuid`, `email`, `username`, `first_name`, `last_name`, `password`, `avatar_url`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES
(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'admin@openface.org', 'OpenFace', 'Site', 'Admin', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 1, 'auto_confirmed', 1383254334, NULL, NULL, 1434527615, 1434527615, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup`
--

CREATE TABLE IF NOT EXISTS `openface_usergroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `openface_usergroup`
--

INSERT INTO `openface_usergroup` (`id`, `name`, `title`, `comment`) VALUES
(0, 'Banned', 'Banned', 'Banned Users'),
(1, 'Guest', 'Unauthenticated', 'Guests'),
(2, 'User', 'Normal Users', 'Normal Users'),
(3, 'Administrator', 'Site Administrators', 'Site Administrators'),
(4, 'Demo', 'Demo Users', 'Demo Users');

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup_member`
--

CREATE TABLE IF NOT EXISTS `openface_usergroup_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `usergroup_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_and_usergroup_id` (`user_id`,`usergroup_id`),
  KEY `user_id` (`user_id`),
  KEY `usergroup_id` (`usergroup_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `openface_usergroup_member`
--

INSERT INTO `openface_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES
(1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `openface_usergroup_permission`
--

CREATE TABLE IF NOT EXISTS `openface_usergroup_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usergroup_id` int(10) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroup_id_and_permissions_id` (`usergroup_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

--
-- Dumping data for table `openface_usergroup_permission`
--

INSERT INTO `openface_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES
(16, 2, 1),
(13, 2, 2),
(12, 2, 5),
(1, 3, 1),
(2, 3, 2),
(3, 3, 3),
(4, 3, 4),
(9, 3, 5),
(10, 3, 6),
(11, 3, 7),
(18, 3, 9),
(19, 3, 10),
(20, 3, 11),
(21, 3, 12),
(14, 4, 1),
(15, 4, 2),
(17, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_confirm`
--

CREATE TABLE IF NOT EXISTS `openface_user_confirm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_metadata`
--

CREATE TABLE IF NOT EXISTS `openface_user_metadata` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `parent_uuid` (`parent_uuid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status`
--

CREATE TABLE IF NOT EXISTS `openface_user_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` text COLLATE utf8_unicode_ci,
  `privacy` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` int(10) unsigned NOT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_uuid` (`user_uuid`),
  KEY `date` (`date`),
  KEY `ip` (`ip`),
  KEY `privacy` (`privacy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openface_user_status_metadata`
--

CREATE TABLE IF NOT EXISTS `openface_user_status_metadata` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `parent_uuid` (`parent_uuid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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