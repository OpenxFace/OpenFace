#!/usr/bin/php
<?php
/**
 * Priceless PHP Base
 * CLI Config for Doctrine 2.x
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright	2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Thursday, July 24, 2014, 16:41 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Scripts; Bash
 * @package     Base Framework
*/

error_reporting( E_ALL );
ini_set( 'display_errors', true );

if ( function_exists('set_time_limit') AND get_cfg_var('safe_mode') == 0 ) {
	@set_time_limit(0);
}

if( !defined( 'BASEDIR' ) ) {
	define( 'BASEDIR', dirname( dirname( dirname( __FILE__ ) ) ) );	
}

set_include_path( 
	BASEDIR.'/application/'.PATH_SEPARATOR.
	BASEDIR.'/application/configs'.PATH_SEPARATOR.
	BASEDIR.'/application/models'.PATH_SEPARATOR.
	BASEDIR.'/library/'.PATH_SEPARATOR. 
	BASEDIR.'/library/PEAR'.PATH_SEPARATOR.
	get_include_path()
);

// Run environment
define( 'RUN_ENV', 'dev' );

require_once('Zend/Loader/Autoloader.php');
$autoloader = Zend_Loader_Autoloader::getInstance();
$autoloader->setFallbackAutoloader( true );

use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping\Driver\AnnotationDriver;
use Doctrine\Common\Annotations\AnnotationReader;
use Doctrine\Common\Annotations\AnnotationRegistry;
use Doctrine\ORM\EntityRepository;

$config	= new Zend_Config_Ini( BASEDIR.'/application/configs/db.ini', strtolower( RUN_ENV ) );
$db		= $config->params->toArray();

// configuration
$paths		= array( __DIR__.'/export' );
$isDevMode	= ( RUN_ENV == 'dev' ) ? true : false; 
$config 	= new \Doctrine\ORM\Configuration();

// create non-existant paths
foreach( $paths AS $key => $value ) {
	if( !file_exists( $value ) ) {
		mkdir( $value );	
	}	
}

// Proxies 
$config->setProxyDir( __DIR__ . '/Proxies' );
$config->setProxyNamespace('Proxies');

$config->setAutoGenerateProxyClasses( true );

// Driver 
$driver = new AnnotationDriver( new AnnotationReader(), $paths );

// registering noop annotation autoloader - allow all annotations by default
AnnotationRegistry::registerLoader('class_exists');
$config->setMetadataDriverImpl( $driver );

// Caching Configuration
if ( RUN_ENV == 'dev' ) {
	$cache = new \Doctrine\Common\Cache\ArrayCache();
} else {
	$cache = new \Doctrine\Common\Cache\ApcCache();
}

$config->setMetadataCacheImpl($cache);
$config->setQueryCacheImpl($cache);

// $config = Setup::createAnnotationMetadataConfiguration( array( __DIR__.'/export' ), $isDevMode, null, null, false );

$connectionOptions = array(
	'driver'		=> 'pdo_mysql',
	'host'			=> $db['host'],
	'user'     		=> $db['username'],
	'password' 		=> $db['password'],
	'dbname'   		=> $db['dbname'],
	'charset' 		=> 'utf8',
	'driverOptions' => array(
		'1002' =>'SET NAMES utf8'
	)
);

$em		= \Doctrine\ORM\EntityManager::create($connectionOptions, $config);
$conn	= $em->getConnection();
$conn->getDatabasePlatform()->registerDoctrineTypeMapping('enum', 'string');
$conn->getDatabasePlatform()->registerDoctrineTypeMapping('set', 'string');

$helperSet = new \Symfony\Component\Console\Helper\HelperSet(
	array(
		'db' => new \Doctrine\DBAL\Tools\Console\Helper\ConnectionHelper( $em->getConnection() ),
		'em' => new \Doctrine\ORM\Tools\Console\Helper\EntityManagerHelper( $em )
	)
);