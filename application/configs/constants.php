<?php
/**
 * BizLogic Base Framework
 * Constants
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2014 BizLogic
 * @link        http://bizlogicdev.com
 *
 * @since       Saturday, April 23, 2011 / 02:00 PM GMT+1
 * @version     $Id: constants.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $
 *
 * @package     BizLogic Base Framework
 * @category    Global Config
*/

define( 'BASE_DIR', dirname( dirname( dirname(__FILE__) ) ) );
define( 'BASEDIR', BASE_DIR );
define( 'BASE_URL', fetchServerURL() );
define( 'BASEURL', BASE_URL );

$protocolRelativeUrl = str_replace('http://', '//', BASEURL );
$protocolRelativeUrl = str_replace('https://', '//', $protocolRelativeUrl );
define( 'PROTOCOL_RELATIVE_URL', $protocolRelativeUrl );

define( 'ADMIN_URL', BASEURL.'/admin' );
define( 'IMG_URL', BASEURL.'/img' );
define( 'IMGURL', IMG_URL );
define( 'ROOT_DIR', BASEDIR );
define( 'LOG_DIR', ROOT_DIR.'/data/logs' );
define( 'TMP_DIR', ROOT_DIR.'/data/temp' );
define( 'APP_DIR', ROOT_DIR.'/application' );
define( 'MODULES_DIR', APP_DIR.'/modules' );
define( 'VIEWS_DIR', MODULES_DIR.'/public/views/scripts' );
define( 'PARTIAL_TEMPLATE_DIR', APP_DIR.'/modules/public/views/templates/shared/partials' );
define( 'SHARED_TEMPLATE_DIR', APP_DIR.'/modules/public/views/templates/shared/scripts' );
define( 'IS_MOBILE', is_mobile() );
define( 'IS_TABLET', is_tablet() );
define( 'ENABLE_FIREPHP', true );
// @link	http://en.wikipedia.org/wiki/Year_2038_problem
define( 'UNIX_TIMESTAMP32_END', 2147483647 );