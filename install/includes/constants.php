<?php
/**
 * BizLogic Base Framework
 * Installer, Constants
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @license     GNU Affero General Public License v3
 * @link        http://bizlogicdev.com
 *
 * @since       Thursday, October 22, 2009 / 12:05 PM GMT+1 mknox
 * @edited      $Date: 2014-10-02 17:52:49 +0200 (Thu, 02 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Revision: 66 $
 *
 * @package     BizLogic Base Framework
 * @category    Installer
*/

define('BASEDIR', dirname( dirname( __FILE__ ) ) );
define('ROOT_DIR', dirname( BASEDIR ) );
define('BASEURL', fetchServerURL() );
define('DEFAULT_PRELOADER_IMAGE', BASEURL.'/img/preloader/default.gif');
define('SMARTY_CACHE_DIR', BASEDIR.'/templates_cache' );
define('SMARTY_COMPILE_DIR', BASEDIR.'/templates_c' );
define('SMARTY_TEMPLATE_BASEDIR', BASEDIR.'/templates/' );
define('SMARTY_TEMPLATENAME','default' );
define('SMARTY_TEMPLATE_DIR', SMARTY_TEMPLATE_BASEDIR.SMARTY_TEMPLATENAME );
define('SMARTY_TEMPLATE_HTML', SMARTY_TEMPLATE_DIR.SMARTY_TEMPLATENAME.'/html' );
define('SMARTY_TEMPLATE_ROOT', BASEURL.'/templates/'.SMARTY_TEMPLATENAME );
define('SMARTY_TEMPLATE_CSS', BASEURL.'/templates/'.SMARTY_TEMPLATENAME.'/css' );
define('SMARTY_TEMPLATE_IMG', BASEURL.'/templates/'.SMARTY_TEMPLATENAME.'/images' );
define('SMARTY_TEMPLATE_JS', BASEURL.'/templates/'.SMARTY_TEMPLATENAME.'/js' );
define('THIS_URL', curPageURL() );
define('CURRENT_SCRIPT', ltrim( $_SERVER['SCRIPT_NAME'],'/' ) );
define('DEFAULT_JQUERY_UI_THEME', 'Delta');
define('INSTALL_SQL', ROOT_DIR.'/scripts/build/db/base.sql');
define('DB_TABLE_PREFIX', 'base_');
define('APP_NAME', 'BizLogic Base Framework');
define('APP_LOGO_HTML', '<i style="font-size: xx-large; color: #007acc;" class="fa fa-magic" alt="'.APP_NAME.'" title="'.APP_NAME.'"></i>');