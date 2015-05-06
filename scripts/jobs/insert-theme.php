#!/usr/bin/php
<?php 
/**
 * Priceless PHP Base
 * Insert Themes into the DB
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright	2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Wednesday, September 24, 2014, 10:39 AM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Scripts; Bash
 * @package     Priceless PHP Base
*/

error_reporting( E_ALL );
ini_set( 'display_errors', true );

$dbHost     = 'localhost';
$dbUsername = '';
$dbName     = '';
$dbPassword = '';
$dbPrefix   = '';

// BASEDIR
define( 'BASEDIR', dirname( dirname( dirname( __FILE__ ) ) ) );

// theme dir
define( 'THEME_DIR', BASEDIR.'/css/bootstrap/themes' );

$link = mysql_connect( $dbHost, $dbName, $dbPassword );
if ( !$link ) {
	exit( 'Not connected : ' . mysql_error() );
}

// select the database
$dbSelected = mysql_select_db( $dbName, $link );
if ( !$dbSelected ) {
	exit( mysql_error() );
}

// get the theme list
$theme = array();
$files = glob( BASEDIR.'/css/bootstrap/themes/*', GLOB_ONLYDIR );
foreach ( $files AS $key => $value ) {
    $name           = pathinfo( $value, PATHINFO_FILENAME );
    $theme[ $name ] = str_replace( '-', ' ', $name ); 
}
			
if( !empty( $theme ) ) {    
	foreach( $theme AS $key => $value ) {
		$sql  = "INSERT IGNORE INTO `".mysql_real_escape_string( $dbPrefix )."site_theme` ( ";
		$sql .= "`type`, ";
		$sql .= "`name`, ";
		$sql .= "`display_name`, ";
		$sql .= "`active` ";
		$sql .= ") VALUES ( ";
		$sql .= "'bootstrap', ";
		$sql .= "'".mysql_real_escape_string( $key )."', ";
		$sql .= "'".mysql_real_escape_string( ucwords( $value ) )."', ";
		$sql .= "'1' ";
		$sql .= "); ";
			
		$res = mysql_query( $sql ) OR die( mysql_error() );
			
		echo "inserted theme w/ name of:  ".ucwords( $value )."\n";
		flush();		
	}	
} else {
    echo "No themes found in:  ".THEME_DIR."\n";
    flush();    
}