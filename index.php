<?php
/**
 * Priceless PHP Base
 * Site Index
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2011 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 *
 * @since       Wednesday, July 06, 2011 / 10:17 AM GMT+1
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $
 * @version     $Id: index.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @package     Priceless PHP Base
 * @category    Site Index
*/

define('PATH', dirname(__FILE__));
set_include_path(   
    PATH.'/application/'.PATH_SEPARATOR.
    PATH.'/application/configs'.PATH_SEPARATOR.
    PATH.'/application/models'.PATH_SEPARATOR.
    PATH.'/library/'.PATH_SEPARATOR.
    get_include_path()
);

require_once('Bootstrap.php');
$Bootstrap = new Bootstrap('');
$Bootstrap->run();