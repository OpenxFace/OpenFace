#!/usr/bin/php
<?php
/**
 * Priceless PHP Base
 * Generate Models, Doctrine 1.x
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright	2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Thursday, July 17, 2014, 18:13 GMT+1
 * @modified    $Date: 2013-10-12 00:13:50 -0700 (Sat, 12 Oct 2013) $ $Author: marquis@marquisknox.com $
 * @version     $Id: UploadController.php 61 2013-10-12 07:13:50Z marquis@marquisknox.com $
 *
 * @category    Scripts; Bash
 * @package     Base Framework
*/

error_reporting( E_ALL );
ini_set( 'display_errors', true );

if ( function_exists('set_time_limit') AND get_cfg_var('safe_mode') == 0 ) {
	@set_time_limit(0);
}

define( 'BASEPATH', dirname( dirname( dirname( __FILE__ ) ) ) );
set_include_path( 
	BASEPATH.'/application/'.PATH_SEPARATOR.
	BASEPATH.'/application/configs'.PATH_SEPARATOR.
	BASEPATH.'/application/models'.PATH_SEPARATOR.
	BASEPATH.'/library/'.PATH_SEPARATOR. 
	BASEPATH.'/library/PEAR'.PATH_SEPARATOR.
	get_include_path()
);

require_once('Zend/Loader/Autoloader.php');
$autoloader = Zend_Loader_Autoloader::getInstance();
$autoloader->setFallbackAutoloader( true );

require_once('functions.php');
require_once('constants.php');

$config	= new Zend_Config_Ini( APP_DIR.'/configs/db.ini', 'live' );
$db		= $config->params->toArray();
    	    	
// require the main file from Doctrine    	
require_once( 'Doctrine.php' );
    	
// Turn debug on/off
Doctrine_Core::debug( true );

// create the singleton Doctrine_Manager instance   	
$manager = Doctrine_Manager::getInstance();
    	
// enable automatic queries resource freeing  	
$manager->setAttribute( Doctrine_Core::ATTR_AUTO_FREE_QUERY_OBJECTS, true );
    	
// enable accessor override
$manager->setAttribute( Doctrine_Core::ATTR_AUTO_ACCESSOR_OVERRIDE, true );

// enable convervative model loading
$manager->setAttribute( Doctrine_Core::ATTR_MODEL_LOADING, Doctrine_Core::MODEL_LOADING_CONSERVATIVE );
    	
// create a connection
$dm = Doctrine_Manager::connection('mysql://'.$db['username'].':'.$db['password'].'@'.$db['host'].'/'.$db['dbname'], 'doctrine');

// generate the models from the DB schema in the models folder
Doctrine_Core::generateModelsFromDb(
	BASEPATH.'/application/models',
	array('doctrine'),
	array(	
		'generateTableClasses'	=> true, 
		'baseClassPrefix'		=> 'Generated_',
		'baseClassesDirectory'	=> 'Generated',
		'baseClassPrefixFiles'	=> false,
		'classPrefixFiles'		=> false
	)
); 