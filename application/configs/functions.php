<?php
/**
 * Priceless PHP Base
 * Various Functions
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 *
 * @since       Wednesday, April 20, 2011 / 10:30 PM GMT+1
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $
 * @version     $Id: functions.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @package     Priceless PHP
 * @category    Core
*/

if( !function_exists('getallheaders') ) {
	function getallheaders()
	{
		$headers = array();

		foreach ( $_SERVER AS $name => $value ) {
			if (substr($name, 0, 5) == 'HTTP_') {
				$headers[str_replace(' ', '-', ucwords( strtolower( str_replace( '_', ' ', substr( $name, 5 ) ) ) ) )] = $value;
			}
		}

		return $headers;
	}
}


function get_all_headers()
{
	$headers	= headers_list();
	$headerList = array();

	if( !empty( $headers ) ) {
		foreach( $headers AS $key => $value ) {
			$params = explode( ':', $value, 2 );
			$headerList[ $params[0] ] = $params[1];
		}
	}

	return $headerList;
}

// @link	https://coderwall.com/p/8mmicq
function objectToArray($d)
{
	if ( is_object( $d ) ) {
		$d = get_object_vars( $d );
	}

	return is_array($d) ? array_map(__FUNCTION__, $d) : $d;
}

// @link	https://coderwall.com/p/8mmicq
function arrayToObject($d)
{
	return is_array($d) ? (object) array_map(__FUNCTION__, $d) : $d;
}

/**
 * Convert an object to an array
 *
 * @link	http://www.sitepoint.com/forums//showthread.php?t=438748
 * @link	https://gist.github.com/victorbstan/744478
 */
function convertObjectToArray( $object )
{
	return json_decode( json_encode( $object ), true );
}

// @link	http://www.electrictoolbox.com/mysql-show-indexes-table
function get_table_indexes( $table, $returnOriginal = false )
{
	$sql = "SHOW INDEXES FROM `".mysql_real_escape_string( $table )."` ";
	$res = mysql_query( $sql ) OR die( mysql_error() );

	if( mysql_num_rows( $res ) > 0 ) {
		$data = array();
		while( $row = mysql_fetch_assoc( $res ) ) {
			$data[] = $row;
		}

		if( $returnOriginal ) {
			return $data;
		} else {
			$simple = array();
			$i		= 0;
				
			foreach( $data AS $key => $value ) {
				$simple[$i]					= array();
				$simple[$i]['column_name']	= $value['Column_name'];
				$simple[$i]['key_name']		= $value['Key_name'];
					
				$i++;
			}

			return $simple;
		}
	} else {
		return array();
	}
}

// hashtag to link
function link_hashtag( $string )
{
	return preg_replace('/(^|\s)#(\w*[a-zA-Z_]+\w*)/', '\1<a href="'.BASEURL.'/search/\2" rel="nofollow" target="blank">#\2</a>', $string );
}

// @ to link
function link_mention( $string )
{
	return preg_replace('/(^|\s)@(\w*[a-zA-Z_]+\w*)/', '\1<a href="'.BASEURL.'/\2" rel="nofollow" target="blank">@\2</a>', $string );
}

// @link	http://php.net/manual/en/function.mime-content-type.php#87856
if(!function_exists('mime_content_type') ) {
	function mime_content_type( $filename )
	{
		$mime_types = generate_mime_type_array();

		$ext = strtolower(array_pop(explode('.',$filename)));
		if (array_key_exists($ext, $mime_types)) {
			return $mime_types[$ext];
		} elseif (function_exists('finfo_open')) {
			$finfo = finfo_open(FILEINFO_MIME);
			$mimetype = finfo_file($finfo, $filename);
			finfo_close($finfo);
			return $mimetype;
		} else {
			return 'application/octet-stream';
		}
	}
}

// @link	http://php.net/manual/en/function.mime-content-type.php#107798
function generate_mime_type_array( $url = 'http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types' )
{
	$mimeTypes = array();
	foreach( @explode("\n",@file_get_contents( $url ) ) AS $x ) {
		if( isset( $x[0] ) && $x[0] !=='#' && preg_match_all( '#([^\s]+)#', $x, $out ) && isset( $out[1] ) && ( $c = count( $out[1] ) ) > 1 ) {
			for( $i = 1; $i < $c; $i++ ) {
				$mimeTypes[$out[1][$i]] = $out[1][0];
			}
		}
	}

	ksort( $mimeTypes, SORT_STRING );

	return $mimeTypes;
}

function log_text( $filename, $text, $mode = 'a', $date = true )
{
	$fd = fopen( $filename, $mode );
	if( $date ) {
		fwrite( $fd, "[" .date('l, F j, Y / h:i:s A T (\G\M\TO)'). "]\n" );
	}

	fwrite( $fd, $text. "\n" );
	fclose( $fd );
}

function background_exec( $cmd, $pipeFile, $pidFile )
{
	exec( sprintf("%s > %s 2>&1 & echo $! >> %s", $cmd, $pipeFile, $pidFile ) );
}

function link_url( $string ) 
{
	return preg_replace( '/((?:http|https|ftp):\/\/(?:[A-Z0-9][A-Z0-9_-]*(?:\.[A-Z0-9][A-Z0-9_-]*)+):?(\d+)?\/?[^\s\"\']+)/i','<a href="$1" rel="nofollow" target="blank">$1</a>', $string );	
}

// http://stackoverflow.com/a/20874702
function hms_to_sec( $string )
{
	return strtotime('1970-01-01 '.$string.' UTC');
}

// http://stackoverflow.com/a/4834230
function hms_to_secs( $string )
{
	$string = preg_replace( "/^([\d]{1,2})\:([\d]{2})$/", "00:$1:$2", $string );
	sscanf( $string, "%d:%d:%d", $hours, $minutes, $seconds );

	return $hours * 3600 + $minutes * 60 + $seconds;
}

function is_resolution( $string )
{
	$pattern = '/([0-9.]+)x([0-9.]+)/';

	if( preg_match( $pattern, $string ) ) {
		return true;
	}
}

function curl_post_file( $url, $files = array() )
{
	$request = curl_init( $url );
	
	// send a file
	curl_setopt($request, CURLOPT_POST, true);
	curl_setopt(
	$request,
	CURLOPT_POSTFIELDS,
    array(
      'file' =>
          '@'            . $files['tmp_name']
          . ';filename=' . $files['name']
          . ';type='     . $files['type']
    ));
	
	// output the response
	curl_setopt($request, CURLOPT_RETURNTRANSFER, true);
	echo curl_exec($request);
	
	// close the session
	curl_close($request);	
}

// @link	http://stackoverflow.com/a/4128377
function in_array_recursive($needle, $haystack, $strict = false)
{
	foreach ($haystack as $item) {
		if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && in_array_recursive($needle, $item, $strict))) {
			return true;
		}
	}

	return false;
}

function get_user_defined_constants()
{
	$constants = get_defined_constants( true );
	return ( isset( $constants['user'] ) ? $constants['user'] : array() );
}

function get_defined_constants_by_type( $type = null )
{
	$constants = get_defined_constants( true );

	if( !is_null( $type ) ) {
		return ( isset( $constants[$type] ) ? $constants[$type] : array() );
	}

	return $constants;
}

// @link	http://stackoverflow.com/a/3161830
// @link	http://stackoverflow.com/a/79986
function truncate_safe( $string, $length = 100, $append = '...' )
{
	$string = trim( $string );

	if( strlen( $string ) > $length ) {
		$string = wordwrap( $string, $length );
		$string = explode( "\n",$string );
		$string = array_shift( $string ) . $append;
	}

	return $string;
}

/**
 * Remove old files
 *
 * @param	string	$dir
 * @param	string	$expiry
 * @param	boolean	$removeDirectories
 * @param	boolean	$removeParent
 */
function remove_old_files( $dir, $expiry = '-1 days', $removeDirectories = true, $removeParent = false )
{
	$files = glob( $dir.'/*' );
	$time  = time();
	
	if( empty( $files ) ) {
		return false;
	}

	foreach( $files AS $file ) {
		if( is_file( $file ) ) {
			if( filemtime( $file ) <= strtotime( $expiry ) ) {
				unlink( $file );
			}
		} elseif ( $removeDirectories ) {
			if( filemtime( $file ) <= strtotime( $expiry ) ) {
				if( $file == '.' AND !$removeParent ) {
					// do nothing
				} else {
					delTree( $file );
				}
			}
		}
	}
}

/**
 * Truncate long text posted by an idiot
 *
 * @param string $str: string to truncate
 * @param integer $maxlen: max allowed length
 * @param integer $newlen: new length
*/
function truncate_idiot_text( $str, $maxlen = 30, $newlen = 20 )
{
	$new = array();
	$phrase_array = explode(' ',$str);
	foreach($phrase_array AS $key=>$value)
	{
		if(strlen($value) >= $maxlen)
		{
			$value = truncate ($value,$newlen);
		}
		array_push($new,$value);
	}
	$fixed = join(' ',$new);
	if(strlen($fixed))
	{
		return $fixed;
	}
}

function divisible_by( $number, $divisibleBy )
{
	$divisibleBy	= (int)$divisibleBy;
	$number			= (int)$number;
	
	if( ( $divisibleBy < 1 ) OR ( $number < 1 ) ) {
		return false;	
	}
	
	if( ( $number % $divisibleBy ) == 0 ) {	
		return true;		
	}
}

function truncate( $string, $length = 100, $indicator = '...' )
{
	return ( strlen( $string ) > $length ) ? substr( $string, 0, $length - strlen( $indicator ) ) . $indicator : $string;
}

function remove_brackets_from_array( $array )
{
	return array_map( 'remove_brackets', $array );
}

function remove_surrounding_brackets( $value )
{
	$value = str_replace( '[', '', $value );
	$value = str_replace( ']', '', $value );
	
	return $value;
}

function remove_brackets( $value )
{
	return str_replace( '[]', '', $value );
}

function remove_array_key_brackets( $array )
{
	$final = array();
	
	foreach( $array AS $key => $value ) {
		$key = str_replace( '[]', '', $key ); 
		$final[$key] = $value;		
	}
	
	return $final;	
}

function add_backticks( $value )
{
	return "`".$value."`";
}

function add_backticks_to_array_elements( $array )
{
	return array_map( 'add_backticks', $array );
}

// @link	http://nsaunders.wordpress.com/2007/01/12/running-a-background-process-in-php/
function run_in_background( $command, $priority = 0)
{
	if( $priority > 0 ) {
		$pid = shell_exec('nohup nice -n '.$priority.' '.$command.' 2> /dev/null & echo $!');
	} else {
		$pid = shell_exec('nohup '.$command.' 2> /dev/null & echo $!');
	}
		
	return $pid;
}

// @link	http://nsaunders.wordpress.com/2007/01/12/running-a-background-process-in-php/
function is_process_running( $pid )
{
	exec('ps '.$pid.' ', $processState );
	return( count( $processState ) >= 2 );
}

function url_to_href( $string ) 
{
	$pattern = '/((?:http|https|ftp)(?::\\/{2}[\\w]+)(?:[\\/|\\.]?)(?:[^\\s"]*))/is';
	$replace = '<a target="_blank" href="$1">$1</a>';
	
	return preg_replace( $pattern, $replace, $string );
}

function isValidEmail( $string )
{
	if( filter_var( $string, FILTER_VALIDATE_EMAIL ) ) {
		return true;
	}
}

function hasPermission( $permission, $permissionGroup )
{
	if( !isset( $_SESSION['site']['permissions'][$permissionGroup] ) ) {
		return false;
	}

	if( !is_array( $_SESSION['site']['permissions'][$permissionGroup] ) ) {
		return false;
	}

	if( in_array( $permission, $_SESSION['site']['permissions'][$permissionGroup] ) ) {
		return true;
	}

	return false;
}

/**
 * Determine if a User has a Permission
 *
 * @access	public
 * @param	string	$permission
 * @return	boolean
*/
function has_permission( $permission )
{
	if( !isset( $_SESSION['site']['permissions'] ) ) {
		return false;
	}
	
	foreach( $_SESSION['site']['permissions'] AS $key => $value ) {
		if( in_array( $permission, $value ) ) {
			return true;
		}
	}
}

function hasAdminPermissions()
{
    if( !empty( $_SESSION['site']['permissions']['admin'] ) ) {
        return true;
    }
}

function hasAdminPerms()
{
    return hasAdminPermissions();
}

function canAdmin()
{
    return hasAdminPermissions();
}

function makeAlphaNumeric( $string )
{
	// to keep letters & numbers
	$string = preg_replace( '/[^a-z0-9]+/i', '-', $string );
	return $string;	
}

function bytesToHumanReadable($bytes, $precision = 2) 
{
    $unit = array('B','KB','MB','GB','TB','PB','EB');
    return @round( $bytes / pow( 1024, ( $i = floor( log( $bytes, 1024 ) ) ) ), $precision ).' '.$unit[$i];
}

if (!function_exists('getallheaders'))
{	
	$headers = array();
	foreach ($_SERVER AS $name => $value) {
		if (substr($name, 0, 5) == 'HTTP_') {
			$name = str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))));
			$headers[$name] = $value;
		} else if ($name == 'CONTENT_TYPE') {
			$headers['Content-Type'] = $value;
		} else if ($name == 'CONTENT_LENGTH') {
			$headers['Content-Length'] = $value;
		}
	}
	
	return $headers;	
}

/**
 * fetch a translation from the user's session
 *
 * @param	string	$phrase
 * @param	string	$case
 * @return  string
 */
function fetchTranslation( $phrase, $case = 'AS_IS' )
{
	if( !isset( $_SESSION['site']['phrases'] ) ) {
		return $phrase;	
	}
	
	if( array_key_exists( $phrase, $_SESSION['site']['phrases'] ) ) {		
		$phrase = $_SESSION['site']['phrases'][$phrase];		
	}
	
	switch( $case ) {
		// converts the first character of a string to lowercase
		case 'lcfirst':
			$phrase = lcfirst( $phrase );
			break;
				
			// converts a string to lowercase
		case 'strtolower':
			$phrase = strtolower( $phrase );
			break;
	
			// converts a string to uppercase
		case 'strtoupper':
			$phrase = strtoupper( $phrase );
			break;
	
			// converts the first character of a string to uppercase
		case 'ucfirst':
			$phrase = ucfirst( $phrase );
			break;
	
			// converts the first character of each word in a string to uppercase
		case 'ucwords':
			$phrase = ucwords( $phrase );
			break;
	}	
	
	return $phrase;	
}

/**
 * fetch a translation from the user's session
 *
 * @param	string	$phrase
 * @param	string	$case
 * @return  string
*/
function translate( $phrase, $case = 'AS_IS' )
{
    return fetchTranslation( $phrase, $case );
}

function hoursToSeconds( $hours )
{
	return (int)( (int)$hours * 3600 );	
}

function delTree( $dir ) 
{
	$files = array_diff( scandir($dir), array('.', '..') );
	foreach( $files AS $file ) {
		( is_dir( $dir.'/'.$file ) ) ? delTree( $dir.'/'.$file ) : unlink( $dir.'/'.$file );
	}
	
	return rmdir( $dir );
}

function fetchColumns( $tableName, $returnAllData = false )
{
    return fetchColumnNames( $tableName, $returnAllData );
}

function fetchColumnNames( $tableName, $returnAllData = false )
{
    $db = Zend_Registry::get( 'DB_CONNECTION' );
    
    $result = mysqli_query( $db, "SHOW COLUMNS FROM `".mysqli_real_escape_string( $db, $tableName )."` ");
    if ( !$result ) {
        return mysqli_error( $db );
    }

    if( mysqli_num_rows( $result ) > 0 ) {
        $columnNames = array();
        while ( $row = mysqli_fetch_assoc( $result ) ) {
            $columnNames[] = $row;
        }

        if( $returnAllData ) {
            return $columnNames;
        } else {
            $columns = array();
            foreach( $columnNames AS $key => $value ) {
                $columns[] = $value['Field'];
            }
            	
            return $columns;
        }
    }
}

// http://stackoverflow.com/a/11429272
function get_enum_values( $table, $column )
{
	$enum = array();
	$sql = "SHOW COLUMNS FROM ".mysql_real_escape_string( $table )." WHERE Field = '".mysql_real_escape_string( $column )."'";
	$res = mysql_query( $sql ) OR die( mysql_error() );

	if( mysql_num_rows( $res ) > 0 ) {
		$data = mysql_fetch_assoc( $res );
		preg_match('/^enum\((.*)\)$/', $data['Type'], $matches);

		foreach( explode(',', $matches[1]) AS $value ) {
			$enum[] = trim( trim( $value, "'" ) );
		}

		return $enum;
	}
}

function urlExists( $url )
{
	$handle = curl_init($url);
	curl_setopt($handle,  CURLOPT_RETURNTRANSFER, true);
	
	$response = curl_exec($handle);
	
	/* Check for 404 (file not found). */
	$httpCode = curl_getinfo($handle, CURLINFO_HTTP_CODE);
	
	if($httpCode >= 403) {
		$exists = false;
	} else {
		$exists = true;	
	}
	
	curl_close($handle);

	return $exists;
}

function randomString( $length = 10 )
{
	return substr( str_shuffle( md5( microtime() ) ), 0, $length );	
}

/**
 * Detect a mobile device
 *
 * @return  boolean
*/
function is_mobile()
{
	require_once('Mobile_Detect.php');	
	$detect = new Mobile_Detect;
	
	// any mobile device (phones or tablets).
	if ( $detect->isMobile() ) {
		return true;	
	}	
	
	return false;
}

function is_tablet()
{
	require_once('Mobile_Detect.php');
	$detect = new Mobile_Detect;

	// any mobile device (phones or tablets).
	if ( $detect->isTablet() ) {
		return true;
	}

	return false;
}

/**
 * fetch file extension
 *
 * @param   string
 * @return  string
*/
function fetchFileExt($file)
{
    return strtolower( substr($file, strrpos($file, '.', -1) + 1) );
}

/**
 * recursive glob
 *
 * @author  arvin@sudocode.net
 * @param   string  $path       path of folder to search
 * @param   string  $pattern    glob pattern
 * @param   string  $flags      glob flags
 * @param   string  $depth      0 for current folder only,
 *                              1 to descend 1 folder down and so on.
 *                              -1 for no limit.
 * @link    http://www.php.net/manual/en/function.glob.php#101017
 * @return  array
*/
function bfglob($path, $pattern = '*', $flags = 0, $depth = 0)
{
    $matches = array();
    $folders = array(rtrim($path, DIRECTORY_SEPARATOR));

    while($folder = array_shift($folders)) {
        $matches = array_merge($matches, glob($folder.DIRECTORY_SEPARATOR.$pattern, $flags));
        if($depth != 0) {
            $moreFolders    = glob($folder.DIRECTORY_SEPARATOR.'*', GLOB_ONLYDIR);
            $depth          = ($depth < -1) ? -1: $depth + count($moreFolders) - 2;
            $folders        = array_merge($folders, $moreFolders);
        }
    }

    return $matches;
}

/**
 * fetch filename
 *
 * @param   string
 * @return  string
*/
function fetchFilename($file)
{
    return substr($file, 0, strrpos($file, '.', -1));
}

/**
 * determine the server URL
 *
 * @return  string
*/
function fetchServerURL()
{
	if( defined('SITE_URL') ) {
		return SITE_URL;	
	}
	
    $url = fetchCurrentURL();

    if( preg_match( '/phpunit/', $url ) ) {
        return 'phpunit';
    }

    $url = parse_url($url);

    if(!strlen(@$url['path'])) {
        return;
    }

    $pathinfo   = pathinfo($url['path']);
    $serverURL  = 'http';

    if( @$_SERVER['HTTPS'] == 'on' ) {
	    $serverURL .= 's';
	}

	$serverURL .= "://";
 	$serverURL .= @$_SERVER['HTTP_HOST'];
 	$dirname	= array_filter( explode( '/', $pathinfo['dirname'] ) );

 	if( empty( $dirname ) ) {
		$pathinfo['dirname'] = ''; 		
 	}
 		 	
	$serverURL .= $pathinfo['dirname'];
	 
    return $serverURL;
}

/**
 * determine the current URL
 *
 * @return  string
*/
function fetchCurrentURL()
{
    if(strlen(@$_SERVER['SHELL'])) {
        return $_SERVER['PHP_SELF'];
    }

    $pageURL = 'http';

    if (@$_SERVER['HTTPS'] == 'on') {
	    $pageURL .= 's';
	}

	$pageURL    .= "://";
 	$pageURL    .= (isset($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : '';
	$pageURL    .= $_SERVER['PHP_SELF'];
	$queryString = (isset($_SERVER['QUERY_STRING'])) ? $_SERVER['QUERY_STRING'] : '';

    if(strlen($queryString)) {
	    $pageURL .= '?'.$queryString;
	}

    return $pageURL;
}

/**
 * convert a string to a valid MySQL datetime value
 *
 * @param   string  $str
 * @return  string
*/
function stringToMySQLDateTime($str)
{
    return date('Y-m-d H:i:s', strtotime($str));
}

/**
 * convert a string to a valid MySQL date value
 *
 * @param   string  $str
 * @return  string
*/
function stringToMySQLDate($str)
{
    return date('Y-m-d', strtotime($str));
}

/**
 * convert a string to the month year
 *
 * @param   string  $str
 * @return  string
*/
function stringToMonthYear($str)
{
    return date('m/Y', strtotime($str));
}

/**
 * detect URLs in text
 *
 * @param   string  $text
 * @return  array
*/
function detectFullURLs($text)
{
    $pattern    = '(((http)(s?)\:\/\/))';
    $pattern   .= '[A-Za-z0-9][A-Za-z0-9.-]+(:\d+)?(\/[^ ]*)?';

    if(preg_match_all('/'.$pattern.'/', $text, $matches)) {
        return $matches[0];
    }
}

/**
 * detect partial URLs in text
 *
 * @param   string  $text
 * @return  array
*/
function detectAllUrls($text)
{
    $pattern = '(http|https)(:\/\/)?+[^\s)]*';

    if(preg_match_all('/'.$pattern.'/', $text, $matches)) {
        return $matches[0];
    }
    
    $pattern = '#[-a-zA-Z0-9@:%_\+.~\#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~\#?&//=]*)?#si';
    if(preg_match_all($pattern, $text, $matches)) {
        return $matches[0];
    }
}

/**
 * remove URLs from text
 *
 * @param   string  $text
 * @return  string
*/
function removeUrls($text)
{
    $urls = detectURLs($text);
    if(!empty($urls)) {
        foreach($urls AS $key => $value) {
            $text = str_ireplace($value, '', $text);
        }
    }

    return trim($text);
}

/**
 * remove all URLs, including partial
 * ones from text
 *
 * @param   string  $text
 * @return  string
*/
function removePartialHttpUrls($text)
{
    $urls = detectPartialHttpUrls($text);
    if(!empty($urls)) {
        foreach($urls AS $key => $value) {
            $text = str_ireplace($value, '', $text);
        }
    }

    return trim($text);
}

/**
 * get_redirect_url()
 * Gets the address that the provided URL redirects to,
 * or FALSE if there's no redirect.
 *
 * @link    http://w-shadow.com/blog/2008/07/05/how-to-get-redirect-url-in-php/
 * @param   string  $url
 * @return  string
*/
function get_redirect_url($url)
{
	$redirect_url = null;

    if(!preg_match('/http/', $url) AND !preg_match('/https/', $url)) {
        $url = 'http://'.$url;
    }

	$url_parts = @parse_url($url);
	if (!$url_parts) return false;
	if (!isset($url_parts['host'])) {
        // can't process relative URLs
        return false;
	}
	if (!isset($url_parts['path'])) $url_parts['path'] = '/';

	$sock = fsockopen($url_parts['host'], (isset($url_parts['port']) ? (int)$url_parts['port'] : 80), $errno, $errstr, 30);
	if (!$sock) return false;

	$request = "HEAD " . $url_parts['path'] . (isset($url_parts['query']) ? '?'.$url_parts['query'] : '') . " HTTP/1.1\r\n";
	$request .= 'Host: ' . $url_parts['host'] . "\r\n";
	$request .= "Connection: Close\r\n\r\n";
	fwrite($sock, $request);
	$response = '';
	while(!feof($sock)) $response .= fread($sock, 8192);
	fclose($sock);

	if (preg_match('/^Location: (.+?)$/m', $response, $matches)) {
		if ( substr($matches[1], 0, 1) == "/" )
			return $url_parts['scheme'] . "://" . $url_parts['host'] . trim($matches[1]);
		else
			return trim($matches[1]);

	} else {
		return false;
	}
}

/**
 * get_all_redirects()
 * Follows and collects all redirects, in order, for the given URL.
 *
 * @param   string  $url
 * @return  array
*/
function get_all_redirects($url)
{
	$redirects = array();
	while ($newurl = get_redirect_url($url)) {
		if (in_array($newurl, $redirects)) {
			break;
		}
		$redirects[] = $newurl;
		$url = $newurl;
	}
	return $redirects;
}

/**
 * get_final_url()
 * Gets the address that the URL ultimately leads to.
 * Returns $url itself if it isn't a redirect.
 *
 * @param   string $url
 * @return  string
*/
function get_final_url($url)
{
	$redirects = get_all_redirects($url);
	if (count($redirects) > 0) {
		return array_pop($redirects);
	} else {
		return $url;
	}
}

function fopen_url($url, $save_path)
{
	$f = fopen( $save_path , 'w+');
	$handle = fopen($url , "rb");
	while (!feof($handle)) {
		$contents = fread($handle, 8192);
		fwrite($f , $contents);
	}
	fclose($handle);
	fclose($f);
}

function curl_download( $url, $destination )
{
	set_time_limit(0);
	//File to save the contents to
	$fp = fopen($destination, 'w+');
	//Here is the file we are downloading, replace spaces with %20
	$ch = curl_init(str_replace(" ","%20",$url));
	curl_setopt($ch, CURLOPT_TIMEOUT, 50);
	//give curl the file pointer so that it can write to it
	curl_setopt($ch, CURLOPT_FILE, $fp);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	$data = curl_exec($ch);//get curl response
	// done
	curl_close($ch);
}

/**
 * Post to a URL via cURL
 *
 * @link	http://bavotasan.com/2011/post-url-using-curl-php
 * @link	http://davidwalsh.name/curl-post
 *
 * @param   string  $url
 * @param	array	$data
 * @param	array	$headers
 * @param   boolean $returnCurlInfo
 * @param   int     $timeout
 * @param   int     $maxRedirs
 * @return  array
 */
function curl_post_url( $url, $data = array(), $headers = array(), $returnCurlInfo = false, $timeout = 60, $maxRedirs = 10 ) 
{
	if( empty( $data ) ) {
		return array();
	}

	$fields = '';
	foreach( $data AS $key => $value ) {
		// decode if already URL encoded, 
		// this insures that the URL is URL encoded
		$fields .= $key . '=' . urlencode( urldecode( $value ) ) . '&';
	}

	rtrim( $fields, '&' );

	$post = curl_init();

	if( !empty( $headers ) ) {
		curl_setopt( $post, CURLOPT_HTTPHEADER, $headers );		
	}
	curl_setopt( $post, CURLOPT_USERAGENT, 'PHP '. phpversion() );
	curl_setopt( $post, CURLOPT_URL, $url );
	curl_setopt( $post, CURLOPT_POST, count( $data ) );
	curl_setopt( $post, CURLOPT_POSTFIELDS, $fields );
	curl_setopt( $post, CURLOPT_FOLLOWLOCATION, true );
	curl_setopt( $post, CURLOPT_MAXREDIRS, $maxRedirs );
	curl_setopt( $post, CURLOPT_RETURNTRANSFER, true );
	curl_setopt( $post, CURLOPT_BINARYTRANSFER, true );
	curl_setopt( $post, CURLOPT_HEADER, false );

	if( $returnCurlInfo ) {
		curl_setopt( $post, CURLINFO_HEADER_OUT, true );
	}

	curl_setopt( $post, CURLOPT_SSL_VERIFYPEER, false );
	curl_setopt( $post, CURLOPT_TIMEOUT, $timeout );

	$response = curl_exec( $post );

	if( $returnCurlInfo ) {
		$originalResponse   = $response;
		$response           = array();
		$response['info']   = curl_getinfo( $post );
		$response['html']   = $originalResponse;
	}

	if( $error = curl_error( $post ) ) {
		$response['error']      = $error;
		$response['errorno']    = curl_errno( $post );
	}

	curl_close( $post );

	return $response;
}

/**
 * fetch the response of a URL via cURL
 *
 * @param   string  $url
 * @param	array	$headers
 * @param   boolean $returnCurlInfo
 * @param	boolean	$anonymizeReferrer
 * @param	boolean	$randomizeUserAgent
 * @param	string	$userAgent
 * @param   int     $timeout
 * @param   int     $maxRedirs
 * @return  mixed	array or string
 */
function curl_get_url($url, $headers = array(), $returnCurlInfo = false, $anonymizeReferrer = false, $randomizeUserAgent = false, $userAgent = null, $timeout = 60, $maxRedirs = 10)
{
    if(!strlen($url)) {
        return false ;
    }

    if( $anonymizeReferrer ) {
    	$referers = array(
    		'www.google.com',
                        'yahoo.com',
                        'msn.com',
                        'ask.com',
                        'live.com'
                    );
    $referer    = array_rand($referers);
    $referer    = 'http://' . $referers[$referer];
    }

    if( $randomizeUserAgent ) {
	    $browsers = array(
	    	'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0',
                        'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3',
                        'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20060918 Firefox/2.0',
                        'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3',
                        'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)',
                        'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0',
                        'Googlebot/2.1 (+http://www.google.com/bot.html)'
                    );
    $browser    = array_rand($browsers);
    $browser    = $browsers[$browser];
    }

    $ch = curl_init($url);
    if( !empty( $headers ) ) {
    	curl_setopt( $ch, CURLOPT_HTTPHEADER, $headers );    	
    }
    if( $randomizeUserAgent ) {
    curl_setopt($ch, CURLOPT_USERAGENT, $browser);
    } else {
    	curl_setopt( $ch, CURLOPT_USERAGENT, 'PHP '. phpversion() );
    }
    if( $anonymizeReferrer ) {
    curl_setopt($ch, CURLOPT_REFERER, $referer);
    }
    curl_setopt($ch, CURLOPT_AUTOREFERER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, $maxRedirs);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    if($returnCurlInfo) {
        curl_setopt($ch, CURLINFO_HEADER_OUT, true);
    }

    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);

    $response = curl_exec($ch);

    if($returnCurlInfo) {
        $originalResponse   = $response;
        $response           = array();
        $response['info']   = curl_getinfo($ch);
        $response['data']   = $originalResponse;
    }

    if($error = curl_error($ch)) {
        $response['error']      = $error;
        $response['errorno']    = curl_errno($ch);
    }

    curl_close($ch);

    return $response;
}

/**
 * fetch the final URL of a URL via cURL
 *
 * @param   string  $url
 * @param   boolean $returnCurlInfo
 * @param   int     $timeout
 * @param   int     $maxRedirs
 * @return  string
 */
function curl_get_final_url($url, $returnCurlInfo = false, $timeout = 60, $maxRedirs = 10)
{
    if(!strlen($url)) {
        return;
    }

    if(!preg_match('/http/', $url) AND !preg_match('/https/', $url)) {
        $url = 'http://'.$url;
    }

    $referers   = array('www.google.com',
                        'yahoo.com',
                        'msn.com',
                        'ask.com',
                        'live.com'
                    );
    $referer    = array_rand($referers);
    $referer    = 'http://' . $referers[$referer];

    $browsers   = array('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0',
                        'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3',
                        'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20060918 Firefox/2.0',
                        'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3',
                        'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)',
                        'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0',
                        'Googlebot/2.1 (+http://www.google.com/bot.html)'
                    );
    $browser    = array_rand($browsers);
    $browser    = $browsers[$browser];

    $ch = curl_init($url);

    curl_setopt($ch, CURLOPT_USERAGENT, $browser);
    curl_setopt($ch, CURLOPT_REFERER, $referer);
    curl_setopt($ch, CURLOPT_AUTOREFERER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, $maxRedirs);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    if($returnCurlInfo) {
        curl_setopt($ch, CURLINFO_HEADER_OUT, true);
    }

    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);

    $response = curl_exec($ch);
    $finalUrl = curl_getinfo($ch, CURLINFO_EFFECTIVE_URL);

    if($returnCurlInfo) {
        $originalResponse   = $response;
        $response           = array();
        $response['info']   = curl_getinfo($ch);
        $response['html']   = $originalResponse;
    }

    if($error = curl_error($ch)) {
        $response['error']      = $error;
        $response['errorno']    = curl_errno($ch);
    }

    curl_close($ch);

    return $finalUrl;
}

/**
 * fetch the HTTP response code of a URL via cURL
 *
 * @param   string  $url
 * @param   int     $timeout
 * @param   int     $maxRedirs
 * @return  string
 */
function getHttpResponse($url, $timeout = 60, $maxRedirs = 10)
{
    if(!strlen($url)) {
        return;
    }

    $referers   = array('www.google.com',
                        'yahoo.com',
                        'msn.com',
                        'ask.com',
                        'live.com'
                    );
    $referer    = array_rand($referers);
    $referer    = 'http://' . $referers[$referer];

    $browsers   = array('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20100101 Firefox/5.0',
                        'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3',
                        'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20060918 Firefox/2.0',
                        'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3',
                        'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)'
                    );
    $browser    = array_rand($browsers);
    $browser    = $browsers[$browser];

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_USERAGENT, $browser);
    curl_setopt($ch, CURLOPT_REFERER, $referer);
    curl_setopt($ch, CURLOPT_NOBODY, true);
    curl_setopt($ch, CURLOPT_AUTOREFERER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, $maxRedirs);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
    curl_setopt($ch, CURLOPT_HEADER, true);
    $response = curl_exec($ch);

    return curl_getinfo($ch, CURLINFO_HTTP_CODE);
}

/**
 * determine if the content type is an image
 *
 * @param   string  $contentType
 * @return  boolean
 */
function isImage($contentType)
{
    if(preg_match('/image/i', $contentType)) {
        return true;
    }
}

/**
 * determine if the content type is HTML
 *
 * @param   string  $contentType
 * @return  boolean
 */
function isHtml($contentType)
{
    if(preg_match('/html/i', $contentType)) {
        return true;
    }
}

/**
 * convert a unix timestamp to MySQL DATETIME
 *
 * @param   int     $timestamp
 * @return  string
 */
function timestamp_to_mysql_datetime($timestamp = null)
{
    $timestamp = is_null($timestamp) ? time() : $timestamp;
    return date('Y-m-d H:i:s', $timestamp);
}

/**
 * convert a unix timestamp to MySQL DATE
 *
 * @param   int     $timestamp
 * @return  string
 */
function timestamp_to_mysql_date($timestamp = null)
{
    $timestamp = is_null($timestamp) ? time() : $timestamp;
    return date('Y-m-d', $timestamp);
}

/**
 * convert a MySQL timestamp to a unix timestamp
 *
 * @param   int     $timestamp
 * @return  string
 */
function mysql_timestamp_to_unix_timestamp($timestamp = null)
{
    return strtotime($timestamp);
}

/**
 * flatten an array
 *
 * @link    http://chriswa.wordpress.com/2011/04/25/array_flatten-in-php/
 * @param   array   $array
 */
function flatten_array($array)
{
    return call_user_func_array('array_merge', $array);
}

/**
 * initialize the initial session values if
 * they are not stored in the end-user's session
 */
function setInitialSessionValues()
{

}

/**
 * str_word_count does not count numbers
 * this is a workaround
 *
 * @param   string  $text
 * @return  int
 */
function strWordCount($text)
{
    return count(explode(' ', $text));
}

/**
 * calculate percent increase / decrease
 *
 * @link    http://www.onemathematicalcat.org/algebra_book/online_problems/calc_percent_inc_dec.htm
 * @link    http://www.google.com/search?q=percent+increase+from+zero
 * @param   int     $start
 * @param   int     $end
 * @return  string
 */
function percentChange($start, $end)
{
    $start  = (int)$start;
    $end    = (int)$end;

    if($start == 0) {
        // infinity
        return 'INFINITY';
    }

    if($start < $end) {
        $change = (($start - $end) / $start) * 100;
        // remove the negative sign
        $change = str_replace('-', '', $change);
    } else {
        $change = (($end - $start) / $start) * 100;
    }

    $change = round($change, 2);

    return $change;
}

/**
 * Determine if a number is negative
 *
 * @param   int     $number
 * @return  boolean
*/
function isNegativeNumber($number)
{
    if($number < 0) {
        return true;
    }
}

/**
 * determine if a string is JSON
 *
 * @param   string  $string
 * @return  boolean
*/
function is_json($string)
{
    return (is_string($string) && is_object(json_decode($string))) ? true : false;
}

/**
 * convert seconds to days
 *
 * @param   int     $seconds
 * @return  int
*/
function secondsToDays($seconds)
{
    // 86400 seconds = 24 hours
    $data = ($seconds / 86400);
    $data = floor($data);

    return $data;
}

/**
 * replace a word using preg_replace
 *
 * @link    http://chumby.net/?p=44
 * @param   string  $needle
 * @param   string  $replacement
 * @param   string  $haystack
 * @param   boolean $caseInsensitive
 * @return  string  $haystack
 */
function str_replace_word($needle, $replacement, $haystack, $caseInsensitive = true)
{
    $needle     = str_replace('/', '\/', $needle);
    $needle     = str_replace('(', '\(', $needle);
    $needle     = str_replace(')', '\)', $needle);

    if($caseInsensitive) {
        $pattern = "/\b".$needle."\b/i";
    } else {
        $pattern = "/\b".$needle."\b";
    }
    $haystack   = preg_replace($pattern, $replacement, $haystack);

    return $haystack;
}

/**
 * return JSONP data
 *
 * @param   string  $callback
 * @param   string  $json
 * @return  string
 */
function outputJsonP($callback, $json)
{
    return $callback.'('.$json.');';
}

/**
 * signal handler function
 *
 * @link    http://www.php.net/manual/en/function.pcntl-signal.php
 * @link    http://tuxradar.com/practicalphp/16/1/6
 * @link    http://www.php.net/manual/en/pcntl.constants.php
 * @link    http://www.php.net/manual/en/pcntl.example.php
 * @param   string  $signo
 */
function signal_handler($signo)
{
    switch ($signo) {
        case SIGCHLD:
            while (pcntl_waitpid(0, $status) != -1) {
                $status = pcntl_wexitstatus($status);
                echo "Child ".$status." completed\n";
            }

            exit;
            break;

        case SIGTERM:
            // handle shutdown tasks
            exit;
            break;

         case SIGHUP:
            // handle restart tasks
            break;

         case SIGUSR1:
            echo "Caught SIGUSR1...\n";
            break;

         default:
             // handle all other signals
     }
}

/**
 * determine the time elapsed since a Unix timestamp
 *
 * @param   int     $timestamp
 * @return  string
 */
function elapsedTime($timestamp, $returnAgo = false)
{
    $difference = time() - $timestamp;

    // if more than a year ago
    if ($difference >= 60*60*24*365) {
        $int    = intval($difference / (60*60*24*365));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' year' . $s;
    // if more than five weeks ago
    } elseif ($difference >= 60*60*24*7*5) {
        $int    = intval($difference / (60*60*24*30));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' month' . $s;
    // if more than a week ago
    } elseif ($difference >= 60*60*24*7) {
        $int    = intval($difference / (60*60*24*7));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' week' . $s;
    // if more than a day ago
    } elseif ($difference >= 60*60*24) {
        $int    = intval($difference / (60*60*24));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' day' . $s;
    // if more than an hour ago
    } elseif ($difference >= 60*60) {
        $int    = intval($difference / (60*60));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' hour' . $s;
    // if more than a minute ago
    } elseif($difference >= 60) {
        $int    = intval($difference / (60));
        $s      = ($int > 1) ? 's' : '';
        $r      = $int . ' minute' . $s;
    // if less than a minute ago
    } else {
        $r = 'moments ago';
    }

    if( $returnAgo AND $r != 'moments ago' ) {
        $r .= ' ago';
    }

    return $r;
}

function get_elapsed_time($ts, $datetime = true)
{
    if($datetime) {
        $ts = date('U', strtotime($ts));
    }

    $mins   = floor((time() - $ts) / 60);
    $hours  = floor($mins / 60);
    $mins  -= $hours * 60;
    $days   = floor($hours / 24);
    $hours -= $days * 24;
    $months = floor($days / 30);
    $weeks  = floor($days / 7);
    $days  -= $weeks * 7;
    $t      = '';

    if ($months > 0) {
        return $months.' month' . ($months > 1 ? 's ago' : ' ago');
    }

    if ($weeks > 0) {
        return $weeks.' week' . ($weeks > 1 ? 's ago' : ' ago');
    }

    if ($days > 0) {
        return $days.' day' . ($days > 1 ? 's ago' : ' ago');
    }

    if ($hours > 0) {
        return $hours. ' hour' . ($hours > 1 ? 's ago' : ' ago');
    }

    if ($mins > 0) {
        return $mins. ' min' . ($mins > 1 ? 's ago' : ' ago');
    }

    return '< 1 min';
}

/**
 * return the first element of an array
 *
 * @param   array    $array
 * @return  mixed
 */
function fetchFirstArrayElement($array)
{
    return array_shift( $array );
}

/**
 * Replace all linebreaks with one whitespace.
 *
 * @link    http://www.php.net/manual/en/function.str-replace.php#97374
 * @access  public
 * @param   string    $string The text to be processed.
 * @return  string   The given text without any linebreaks.
 */
function remove_newlines($string)
{
    return (string)str_replace(array("\r", "\r\n", "\n"), '', $string);
}

/**
 * determine if a script is running by name
 *
 * @param   string    $scriptName
 * @return  boolean
 */
function isScriptRunningByName($scriptName)
{
    $psArray    = array();
    $output     = array();
    $return     = '';
    $ps         = exec('pgrep -f '.$scriptName, $psArray, $return);
    $count      = count($psArray);

    if(empty($psArray) OR $count < 1) {
        return false;
    } else {
        return true;
    }
}

/**
 * determine if a script is running with specific command-line paramters
 *
 * @param   string    $scriptName
 * @return  boolean
 */
function isScriptRunningWithArgs($scriptName)
{
    $psArray    = array();
    $output     = array();
    $return     = '';
    $ps         = exec('ps -fp $(pgrep -d, -x php)', $psArray, $return);

    if(!empty($psArray)) {
        foreach($psArray AS $key => $value) {
            if( preg_match('/'.$scriptName.'/', $value) ) {
                return true;
            }
        }
    }
}

function fetchScriptRunCount($scriptName)
{
    $psArray = fetchScriptPids($scriptName);
    if( !empty($psArray) ) {
        $myPid = getmypid();
        // remove self
        foreach($psArray AS $key => $value) {
            if($value == $myPid) {
                unset($psArray[$key]);
            }
        }

        return count($psArray);
        
    } else {
        return 0;
    }
}

function fetchScriptPids($scriptName)
{
    $psArray    = array();
    $output     = array();
    $return     = '';
    $ps         = exec("ps -eo pid,command | grep ".$scriptName." | grep -v grep | grep -v /bin/sh | grep -v 'sh -c' | awk '{print $1}'", $psArray, $return);

    return $psArray;
}

/**
 * a recursive function which adds the values of two multidimensional
 * arrays with the same key structure:
 *
 * @author  George Pligor
 * @link    http://www.php.net/manual/en/function.array-sum.php#104222
 * @param   array   $left
 * @param   array   $right
 * @return  array
 */
function multiDimArrayAdd(& $left, $right)
{
    if(is_array($left) && is_array($right)) {
        foreach($left as $key => $val) {
            if( is_array($val) ) {
                multiDimArrayAdd($left[$key], $right[$key]);
            }
            $left[$key] += $right[$key];
        }
    }
}

/**
 * determine if a URL exists within a string
 *
 * @link    http://daringfireball.net/2009/11/liberal_regex_for_matching_urls
 * @link    http://stackoverflow.com/questions/3539009/preg-match-to-domain-tld
 * @param   string  $string
 * @return  boolean
 */
function containsUrl($string)
{
    if(preg_match_all('#\bhttps?://[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))#', $string, $match)) {
        return true;
    }

    if (preg_match('/^[-a-z0-9]+\.a[cdefgilmnoqrstuwxz]|b[abdefghijmnorstvwyz]|c[acdfghiklmnoruvxyz]|d[ejkmoz]|e[cegrstu]|f[ijkmor]|g[abdefghilmnpqrstuwy]|h[kmnrtu]|i[delmnoqrst]|j[emop]|k[eghimnprwyz]|l[abcikrstuvy]|m[acdeghklmnopqrstuvwxyz]|n[acefgilopruz]|om|p[aefghklmnrstwy]|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t[cdfghjklmnoprtvwz]|u[agksyz]|v[aceginu]|w[fs]|y[et]|z[amw]|biz|cat|co|com|edu|gov|int|mil|net|org|pro|tel|aero|arpa|asia|to|tv|coop|info|jobs|mobi|name|museum|travel|arpa|xn--[a-z0-9]+$/', strtolower($string))) {
        return true;
    }

}

/**
 * remove an item from an array by value
 *
 * @link    http://dev-tips.com/featured/remove-an-item-from-an-array-by-value
 * @param   string  $value
 * @param   array   $array
 * @return  array
 */
function removeArrayElementByValue($value, $array)
{
    return array_diff( $array, array($value) );
}

/**
 * determine the run environment based on the server IP
 *
 * @return  string
 */
function determineRunEnvironment()
{
	$config = parse_ini_file( BASEDIR.'/application/configs/config.ini', true );
	
	if( strlen( $config['env']['run_env'] ) ) {
		return $config['env']['run_env'];
	}

    return 'UNKNOWN';
}

/**
 * set the run environment
 */
function setRunEnvironment($env)
{
    if( !defined('RUN_ENV') ) {
        define('RUN_ENV', $env);
    }
}

function fetchLocalServerIP()
{
    $ip = ( isset($_SERVER['SERVER_ADDR']) ) ? $_SERVER['SERVER_ADDR'] : fetchLocalServerIPViaBash();
    return $ip;
}

function fetchLocalServerIPViaBash()
{
    exec("ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'", $output, $return);
    if( !empty($output) ) {
        return $output[0];
    }
}

/**
 * Determine the user's locale
 *
 * @link    http://framework.zend.com/manual/1.12/en/zend.locale.functions.html#zend.locale.getlocale
 * @return  string
*/
function determineUserLocale()
{
    $locale = new Zend_Locale();
    return $locale->getLanguage();
}

function preserveFormat()
{
	echo '<pre>';	
}

function file_upload_error( $errorCode )
{
	switch ( $errorCode ) {
		case UPLOAD_ERR_OK:
			$response = 'UPLOAD_ERR_OK';
			break;
			
		case UPLOAD_ERR_INI_SIZE:
			$response = 'The uploaded file exceeds the upload_max_filesize directive in php.ini.';
			break;
		case UPLOAD_ERR_FORM_SIZE:
			$response = 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form.';
			break;
		case UPLOAD_ERR_PARTIAL:
			$response = 'The uploaded file was only partially uploaded.';
			break;
		case UPLOAD_ERR_NO_FILE:
			$response = 'No file was uploaded.';
			break;
		case UPLOAD_ERR_NO_TMP_DIR:
			$response = 'Missing a temporary folder. Introduced in PHP 4.3.10 and PHP 5.0.3.';
			break;
		case UPLOAD_ERR_CANT_WRITE:
			$response = 'Failed to write file to disk. Introduced in PHP 5.1.0.';
			break;
		case UPLOAD_ERR_EXTENSION:
			$response = 'File upload stopped by extension. Introduced in PHP 5.2.0.';
			break;
		default:
			$response = 'Unknown error';
			break;
	}

	return $response;
}

/**
 * determine if a file is an image
 *
 * @link	www.php.net/manual/en/function.image-type-to-mime-type.php#refsect1-function.image-type-to-mime-type-returnvalues
 * @param	string	$filePath
 * @return  boolean	
 */
function is_image( $filePath )
{
	$size = getimagesize( $filePath );
	if( !$size ) {
		return false;
	}
	
	$validImageTypes = array(	IMAGETYPE_GIF,
								IMAGETYPE_JPEG,
								IMAGETYPE_PNG,
								IMAGETYPE_SWF,
								IMAGETYPE_PSD,
								IMAGETYPE_BMP,
								IMAGETYPE_TIFF_II,
								IMAGETYPE_TIFF_MM,
								IMAGETYPE_JPC,
								IMAGETYPE_JP2,
								IMAGETYPE_JPX,
								IMAGETYPE_JB2,
								IMAGETYPE_SWC,
								IMAGETYPE_IFF,
								IMAGETYPE_WBMP,
								IMAGETYPE_XBM,
								IMAGETYPE_ICO								
	);
	
	if( in_array( $size[2],  $validImageTypes ) ) {
		return true;
	} else {
		return false;
	}	
}

function is_video_mime_type( $filePath )
{
	$type = mime_content_type( $filePath );

	if( preg_match('/video/', $type ) ) {
		return true;	
	}
	
	return false;
}

function is_video( $filePath )
{
	$videoFiles = array(
		'avi',
		'divx',
		'dv',
		'flv',			
		'm2ts',		
		'm2v',
		'm4v',
		'mov',			
		'mts',
		'mkv',			
		'mp4',
		'mpg',
		'mpeg',
		'mpeg4',
		'qt',
		'vob',
		'wmv',
		'xvid'
	);
	
	$ext = fetchFileExt( $filePath );
	
	if( in_array( $ext, $videoFiles ) ) {
		return true;	
	}
}

/**
 * Determine if a file type is allowed
 * for upload
 *
 * @param	string	$fileExt
 * @return  boolean
*/
function isAllowedFileType( $fileExt )
{	
	if( trim( SITE_ALLOWED_FILE_TYPES ) == '*' ) {
		return true;	
	}
	
	$allowedFileTypes = array_map('trim', explode( ',', SITE_ALLOWED_FILE_TYPES ) );
	
	if( !in_array( $fileExt, $allowedFileTypes ) ) {
		return false;
	} else {
		return true;
	}	
}

/**
 * determine if a media type is allowed
 * for upload 
 *
 * @param	string	$fileExt
 * @return  boolean
*/
function isAllowedMediaType( $fileExt )
{
	// trim spaces
	$allowedImageTypes = array_map('trim', explode( ',', SITE_ALLOWED_IMAGE_TYPES ) );
	$allowedVideoTypes = array_map('trim', explode( ',', SITE_ALLOWED_VIDEO_TYPES ) );	
	
	if( !in_array( $fileExt, $allowedImageTypes ) AND !in_array( $fileExt, $allowedVideoTypes ) ) {
		return false;	
	} else {
		return true;		
	}
}

/**
 * Convert number of seconds into hours, minutes and seconds
 * and return an array containing those values
 * 
 * @link	http://codeaid.net/php/convert-seconds-to-hours-minutes-and-seconds-%28php%29
 * @param	integer	$seconds Number of seconds to parse
 * @return	array
*/
function seconds_to_hms( $seconds )
{
	// extract hours
	$hours = floor($seconds / (60 * 60));

	// extract minutes
	$divisor_for_minutes = $seconds % (60 * 60);
	$minutes = floor($divisor_for_minutes / 60);

	// extract the remaining seconds
	$divisor_for_seconds = $divisor_for_minutes % 60;
	$seconds = ceil($divisor_for_seconds);
	// return the final array
	$obj = array(
			"h" => (int) $hours,
			"m" => (int) $minutes,
			"s" => (int) $seconds,
	);
	return $obj;
}

/**
 Last date of a month of a year
 @param[in] $month - Integer. Default = Current Month
 @param[in] $year - Integer. Default = Current Year
 @return Last date of the month and year in yyyy-mm-dd format
*/
function get_last_day_of_month($month = '', $year = '')
{
	if (empty($month))
	{
		$month = date('m');
	}
	if (empty($year))
	{
		$year = date('Y');
	}
	$result = strtotime("{$year}-{$month}-01");
	$result = strtotime('-1 second', strtotime('+1 month', $result));
	return date('Y-m-d', $result);
}

function get_timezones()
{
	$o = array();
	$t_zones = timezone_identifiers_list();
	foreach($t_zones as $a)
	{
		$t = '';
		try
		{
			//this throws exception for 'US/Pacific-New'
			$zone = new DateTimeZone($a);
			 
			$seconds = $zone->getOffset( new DateTime("now" , $zone) );
			$hours = sprintf( "%+02d" , intval($seconds/3600));
			$minutes = sprintf( "%02d" , ($seconds%3600)/60 );
			 
			$t = $a ."  [ $hours:$minutes ]" ;
			 
			$o[$a] = $t;
		}
		 
		//exceptions must be catched, else a blank page
		catch(Exception $e)
		{
			//die("Exception : " . $e->getMessage() . '<br />');
			//what to do in catch ? , nothing just relax
		}
	}
	 
	ksort($o);
	 
	return $o;
}

function soundcloud_embed_code( $url )
{
	$embedded = '';
	if (preg_match_all('/(http:\/\/|https:\/\/)soundcloud\.com\/([^\s]+)/i', $vars['object']->body, $matches)) {
	
		foreach ($matches[0] as $m) {
			$embedded .= '<div id="sc_'.md5($m).'" class="soundcloud-embed" data-url="'.$m.'"></div>';
		}			
	}
	
	return $embedded;	
}

function console_log( $string )
{
    FB::log( $string );
}

function console_info( $string )
{
    FB::info( $string );
}

function console_warn( $string )
{
    FB::warn( $string );
}

/**
 * This file is part of the array_column library
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * @copyright Copyright (c) 2013 Ben Ramsey <http://benramsey.com>
 * @license http://opensource.org/licenses/MIT MIT
*/
if (!function_exists('array_column')) {

	/**
	 * Returns the values from a single column of the input array, identified by
	 * the $columnKey.
	 *
	 * Optionally, you may provide an $indexKey to index the values in the returned
	 * array by the values from the $indexKey column in the input array.
	 *
	 * @param array $input A multi-dimensional array (record set) from which to pull
	 * a column of values.
	 * @param mixed $columnKey The column of values to return. This value may be the
	 * integer key of the column you wish to retrieve, or it
	 * may be the string key name for an associative array.
	 * @param mixed $indexKey (Optional.) The column to use as the index/keys for
	 * the returned array. This value may be the integer key
	 * of the column, or it may be the string key name.
	 * @return array
	*/
	function array_column($input = null, $columnKey = null, $indexKey = null)
	{
		// Using func_get_args() in order to check for proper number of
		// parameters and trigger errors exactly as the built-in array_column()
		// does in PHP 5.5.
		$argc = func_num_args();
		$params = func_get_args();

		if ($argc < 2) {
			trigger_error("array_column() expects at least 2 parameters, {$argc} given", E_USER_WARNING);
			return null;
		}

		if (!is_array($params[0])) {
			trigger_error('array_column() expects parameter 1 to be array, ' . gettype($params[0]) . ' given', E_USER_WARNING);
			return null;
		}

		if (!is_int($params[1])
				&& !is_float($params[1])
				&& !is_string($params[1])
				&& $params[1] !== null
				&& !(is_object($params[1]) && method_exists($params[1], '__toString'))
		) {
			trigger_error('array_column(): The column key should be either a string or an integer', E_USER_WARNING);
			return false;
		}

		if (isset($params[2])
				&& !is_int($params[2])
				&& !is_float($params[2])
				&& !is_string($params[2])
				&& !(is_object($params[2]) && method_exists($params[2], '__toString'))
		) {
			trigger_error('array_column(): The index key should be either a string or an integer', E_USER_WARNING);
			return false;
		}

		$paramsInput = $params[0];
		$paramsColumnKey = ($params[1] !== null) ? (string) $params[1] : null;

		$paramsIndexKey = null;
		if (isset($params[2])) {
			if (is_float($params[2]) || is_int($params[2])) {
				$paramsIndexKey = (int) $params[2];
			} else {
				$paramsIndexKey = (string) $params[2];
			}
		}

		$resultArray = array();

		foreach ($paramsInput as $row) {

			$key = $value = null;
			$keySet = $valueSet = false;

			if ($paramsIndexKey !== null && array_key_exists($paramsIndexKey, $row)) {
				$keySet = true;
				$key = (string) $row[$paramsIndexKey];
			}

			if ($paramsColumnKey === null) {
				$valueSet = true;
				$value = $row;
			} elseif (is_array($row) && array_key_exists($paramsColumnKey, $row)) {
				$valueSet = true;
				$value = $row[$paramsColumnKey];
			}

			if ($valueSet) {
				if ($keySet) {
					$resultArray[$key] = $value;
				} else {
					$resultArray[] = $value;
				}
			}

		}

		return $resultArray;
	}
}

function isNegative( $int )
{
    return preg_match( '/-/', $int );
}

function strip_all_slashes( $string )
{
    $string = str_replace( '\\', '', $string );
    $string = stripslashes( $string );

    return $string;
}

function get_image_dimensions( $filePath )
{
    $data = array();
    $info = getimagesize( $filePath );

    if( !empty( $info ) ) {
        $data['width']	= $info[0];
        $data['height'] = $info[1];
    }

    return $data;
}

function print_array_readable( $array )
{
    echo '<pre>';
    print_r( $array );
}

function uuid()
{
    return UUID::mint( 4 )->__toString();
}

function hashId( $string = '', $salt = SITE_HASH_SALT )
{
    $string = trim( $string );
    
    if( !strlen( $string ) ) {
        $string = randomString( mt_rand() );
    }
    
    $hashids    = new Hashids( $salt );
    $id         = $hashids->encode( $string );

    return $id;
}

/**
 * Modifies a string to remove 
 * all non ASCII characters and spaces
 * 
 * @link    http://sourcecookbook.com/en/recipes/8/function-to-slugify-strings-in-php
 * @link    http://cubiq.org/the-perfect-php-clean-url-generator
 * @link    http://www.paulund.co.uk/how-to-create-a-url-slug-with-php
*/
function slugify( $text, $limit = 255 )
{
    // replace non letter or digits by -
    $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

    // trim
    $text = trim( $text, '-' );

    // transliterate
    if ( function_exists('iconv') ) {
        $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
    }

    // lowercase
    $text = strtolower($text);

    // remove unwanted characters
    $text = preg_replace('~[^-\w]+~', '', $text);

    if ( empty( $text ) ) {
        return '';
    }

    return truncate( $text, $limit, '' );
}

/**
 * Get the username from
 * an e-mail address
 *
 * @param   string  $emailAddress
 * @return  string
*/
function getUsernameFromEmailAddress( $emailAddress )
{
    $parts = explode( '@', $emailAddress );
    return @$parts[0];
}

// @link    http://www.virendrachandak.com/techtalk/getting-real-client-ip-address-in-php-2/
function getIP()
{
    $ipaddress = '';
    if (getenv('HTTP_CLIENT_IP'))
        $ipaddress = getenv('HTTP_CLIENT_IP');
    else if(getenv('HTTP_X_FORWARDED_FOR'))
        $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
    else if(getenv('HTTP_X_FORWARDED'))
        $ipaddress = getenv('HTTP_X_FORWARDED');
    else if(getenv('HTTP_FORWARDED_FOR'))
        $ipaddress = getenv('HTTP_FORWARDED_FOR');
    else if(getenv('HTTP_FORWARDED'))
        $ipaddress = getenv('HTTP_FORWARDED');
    else if(getenv('REMOTE_ADDR'))
        $ipaddress = getenv('REMOTE_ADDR');
    else
        $ipaddress = 'UNKNOWN';

    return $ipaddress;
}

function getStartOfDay( $timestamp = null )
{
    $timestamp = ( is_null( $timestamp ) ) ? time() : $timestamp;
    return strtotime( 'midnight', $timestamp );    
}

function getEndOfDay( $timestamp = null )
{
    $timestamp  = ( is_null( $timestamp ) ) ? time() : $timestamp;
    $beginOfDay = strtotime( 'midnight', $timestamp );
    $endOfDay   = strtotime( 'tomorrow', $beginOfDay ) - 1;

    return $endOfDay;
}

function getStartOfMonth( $format = 'Y-m-01' )
{
    return date( $format );
}

function getLastDayOfMonth( $format = 'Y-m-t' )
{
    return date( $format );
}

/**
 * Generate a Date Range
 *
 * @link	http://www.rarst.net/script/php-date-range
 * @param	int		$first	start date
 * @param	int		$last	end date
 * @param	string	$step	date interval
 * @param	string	$setAs	keys or values
 * @param	string	$format	date format
 * @return	array
 */
function dateRange( $first, $last, $step = '+1 day', $setAs = 'keys', $format = 'm-d-Y' )
{
    $dates		= array();
    $current	= $first;

    while( $current <= $last ) {
        if( $setAs == 'values' ) {
            $dates[] = date( $format, $current );
        } else {
            $dates[date( $format, $current )] = '';
        }

        $current = strtotime( $step, $current );
    }

    return $dates;
}

// @link	php.net/manual/en/language.types.type-juggling.php#language.types.typecasting
function typecast( $var, $type = 'int' )
{
    switch( $type ) {
        case 'array':
            $var = (array)$var;

        case 'bool':
        case 'boolean':
            $var = (bool)$var;
            break;
            	
        case 'double':
        case 'float':
        case 'real':
            $var = (float)$var;
            break;
            	
        case 'string':
            $var = (string)$var;
            break;

        case 'object':
            $var = (object)$var;
            break;

        case 'unset':
            $var = (unset)$var;
            break;
            	
        default:
            $var = (int)$var;
    }

    return $var;
}

function typecastToInteger( $var )
{
    return typecast( $var, 'int' );
}

function typecastToInt( $var )
{
    return typecastToInteger( $var );
}

function getPercentage( $value, $total, $precision = 1 )
{
    return number_format( ( ( $value / $total ) * 100 ), $precision );
}

function array_column_multidimensional( $array, $column )
{
    $result = array();
    foreach( $array AS $key => $value ){
        if( isset( $value[$column] ) ) {
            $result[] = $value[$column];
        }
    }

    return $result;
}

/**
 * Translates a number to a short alhanumeric version
 *
 * Translated any number up to 9007199254740992
 * to a shorter version in letters e.g.:
 * 9007199254740989 --> PpQXn7COf
 *
 * specifiying the second argument true, it will
 * translate back e.g.:
 * PpQXn7COf --> 9007199254740989
 *
 * this function is based on any2dec && dec2any by
 * fragmer[at]mail[dot]ru
 * see: http://nl3.php.net/manual/en/function.base-convert.php#52450
 *
 * If you want the alphaID to be at least 3 letter long, use the
 * $pad_up = 3 argument
 *
 * In most cases this is better than totally random ID generators
 * because this can easily avoid duplicate ID's.
 * For example if you correlate the alpha ID to an auto incrementing ID
 * in your database, you're done.
 *
 * The reverse is done because it makes it slightly more cryptic,
 * but it also makes it easier to spread lots of IDs in different
 * directories on your filesystem. Example:
 * $part1 = substr($alpha_id,0,1);
 * $part2 = substr($alpha_id,1,1);
 * $part3 = substr($alpha_id,2,strlen($alpha_id));
 * $destindir = "/".$part1."/".$part2."/".$part3;
 * // by reversing, directories are more evenly spread out. The
 * // first 26 directories already occupy 26 main levels
 *
 * more info on limitation:
 * - http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/165372
 *
 * if you really need this for bigger numbers you probably have to look
 * at things like: http://theserverpages.com/php/manual/en/ref.bc.php
 * or: http://theserverpages.com/php/manual/en/ref.gmp.php
 * but I haven't really dugg into this. If you have more info on those
 * matters feel free to leave a comment.
 *
 * The following code block can be utilized by PEAR's Testing_DocTest
 * <code>
 * // Input //
 * $number_in = 2188847690240;
 * $alpha_in  = "SpQXn7Cb";
 *
 * // Execute //
 * $alpha_out  = alphaID($number_in, false, 8);
 * $number_out = alphaID($alpha_in, true, 8);
 *
 * if ($number_in != $number_out) {
 *	 echo "Conversion failure, ".$alpha_in." returns ".$number_out." instead of the ";
 *	 echo "desired: ".$number_in."\n";
 * }
 * if ($alpha_in != $alpha_out) {
 *	 echo "Conversion failure, ".$number_in." returns ".$alpha_out." instead of the ";
 *	 echo "desired: ".$alpha_in."\n";
 * }
 *
 * // Show //
 * echo $number_out." => ".$alpha_out."\n";
 * echo $alpha_in." => ".$number_out."\n";
 * echo alphaID(238328, false)." => ".alphaID(alphaID(238328, false), true)."\n";
 *
 * // expects:
 * // 2188847690240 => SpQXn7Cb
 * // SpQXn7Cb => 2188847690240
 * // aaab => 238328
 *
 * </code>
 *
 * @author      Kevin van Zonneveld <kevin@vanzonneveld.net>
 * @author      Simon Franz
 * @author      Deadfish
 * @author      SK83RJOSH
 * @copyright   2008 Kevin van Zonneveld (http://kevin.vanzonneveld.net)
 * @license     http://www.opensource.org/licenses/bsd-license.php New BSD Licence
 * @link        http://kevin.vanzonneveld.net/
 *
 * @param   mixed   $in         String or long input to translate
 * @param   boolean $to_num     Reverses translation when true
 * @param   mixed   $pad_up     Number or boolean padds the result up to a specified length
 * @param   string  $pass_key   Supplying a password makes it harder to calculate the original ID
 *
 * @return mixed string or long
*/
function alphaID($in = null, $to_num = false, $pad_up = false, $pass_key = null)
{
    if( !is_null( $in ) ) {
        $in = mt_rand();
    }

    $out   =   '';
    $index = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $base  = strlen($index);

    if ($pass_key !== null) {
        // Although this function's purpose is to just make the
        // ID short - and not so much secure,
        // with this patch by Simon Franz (http://blog.snaky.org/)
        // you can optionally supply a password to make it harder
        // to calculate the corresponding numeric ID

        for ($n = 0; $n < strlen($index); $n++) {
            $i[] = substr($index, $n, 1);
        }

        $pass_hash = hash('sha256',$pass_key);
        $pass_hash = (strlen($pass_hash) < strlen($index) ? hash('sha512', $pass_key) : $pass_hash);

        for ($n = 0; $n < strlen($index); $n++) {
            $p[] =  substr($pass_hash, $n, 1);
        }

        array_multisort($p, SORT_DESC, $i);
        $index = implode($i);
    }

    if ($to_num) {
        // Digital number  <<--  alphabet letter code
        $len = strlen($in) - 1;

        for ($t = $len; $t >= 0; $t--) {
            $bcp = bcpow($base, $len - $t);
            $out = $out + strpos($index, substr($in, $t, 1)) * $bcp;
        }

        if (is_numeric($pad_up)) {
            $pad_up--;

            if ($pad_up > 0) {
                $out -= pow($base, $pad_up);
            }
        }
    } else {
        // Digital number  -->>  alphabet letter code
        if (is_numeric($pad_up)) {
            $pad_up--;

            if ($pad_up > 0) {
                $in += pow($base, $pad_up);
            }
        }

        for ($t = ($in != 0 ? floor(log($in, $base)) : 0); $t >= 0; $t--) {
            $bcp = bcpow($base, $t);
            $a   = floor($in / $bcp) % $base;
            $out = $out . substr($index, $a, 1);
            $in  = $in - ($a * $bcp);
        }
    }

    return $out;
}

/**
 * Generate a Hash ID
 *
 * @uses	HashIds
 * @link	https://github.com/ivanakimov/hashids.php
 * @param	string	$source
 * @param	string	$salt
 * @return	string
*/
function generateHashId( $source, $salt = SITE_HASHID_SALT )
{
    $hashIdObj  = new HashIds( $salt );
    $hashId     = $hashIdObj->encode( $source );

    return $hashId;
}

/**
 * Return the array key with the highest 
 * value
 *
 * @param	array	$array
 * @return	int
*/
function getMaxArrayKey( $array )
{
    return max( array_keys( $array ) );
}

/**
 * Internationlize a date
 *
 * @param   int     $date
 * @param   string  $locale
 * @return  string
*/
function internationlizeDate( $date, $locale = 'en-us', $format = 'm Y' )
{
    // convert to Unix timestamp
    $date = ( !is_int( $date ) ) ? strtotime( $date ) : $date;

    switch( $date ) {
        default:
            $date = date( $format, $date );
    }

    return $date;
}

/**
 * Internationlize a date
 *
 * @link    http://php.net/str_word_count
 * @param   int     $date
 * @return  string
*/
function translateDate( $date )
{
    $words = str_word_count( $date, 1 );
    if( !empty( $words ) ) {
        foreach( $words AS $key => $value ) {
            $date = str_replace( $value, translate( $value ), $date );
        }
    }

    return $date;
}

/**
 * Get Headers with cURL
 *
 * @param   string  $url
 * @param   int     $timeout
 * @param   int     $maxRedirs
 * @return  array
 */
function curlGetHeaders( $url, $timeout = 60, $maxRedirs = 3 )
{
    $ch = curl_init($url);
    curl_setopt( $ch, CURLOPT_NOBODY, true );
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, false );
    curl_setopt( $ch, CURLOPT_HEADER, false );
    curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, true );
    curl_setopt( $ch, CURLOPT_TIMEOUT, $timeout );
    curl_setopt( $ch, CURLOPT_MAXREDIRS, $maxRedirs );

    curl_exec( $ch );

    $headers = curl_getinfo( $ch );

    curl_close( $ch );

    return $headers;
}

/**
 * Download a file with
 * cURL
 *
 * @link    http://www.w3bees.com/2013/09/download-file-from-remote-server-with.html
 * @param   string  $url
 * @param   string  $destination
 * @return  boolean
 */
function curlDownload( $url, $destination )
{
    // replace spaces with %20
    $url = str_replace(' ', '%20', $url );

    # open file to write
    $fp = fopen( $destination, 'w+' );

    # start curl
    $ch = curl_init();

    curl_setopt( $ch, CURLOPT_URL, $url );

    # set return transfer to false
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, false );
    curl_setopt( $ch, CURLOPT_BINARYTRANSFER, true );
    curl_setopt( $ch, CURLOPT_SSL_VERIFYPEER, false );
    curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, true );

    # increase timeout to download big file
    curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT, 10 );

    # write data to local file
    curl_setopt( $ch, CURLOPT_FILE, $fp );

    # execute curl
    curl_exec( $ch );

    # close curl
    curl_close( $ch );

    # close local file
    fclose( $fp );

    if ( file_exists( $destination ) AND filesize( $destination ) > 0 ) {
        return true;
    }

    return false;
}

/**
 * Get Remote File Size
 *
 * @link    http://www.w3bees.com/2013/03/get-remote-file-size-using-php.html
 * @param   string  $url
 * @return  int
*/
function getRemoteFileSize( $url )
{
    if( function_exists( 'get_headers' ) ) {
        # Get all header information
        $data = get_headers( $url, true );

        # Look up validity
        if ( isset( $data['Content-Length'] ) ) {
            # Return file size
            return (int)$data['Content-Length'];
        }
    } elseif ( function_exists('curl_init') ) {
        $ch = curl_init($url);

         curl_setopt($ch, CURLOPT_NOBODY, 1);
         curl_setopt($ch, CURLOPT_RETURNTRANSFER, 0);
         curl_setopt($ch, CURLOPT_HEADER, 0);
         curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
         curl_setopt($ch, CURLOPT_MAXREDIRS, 3);
         curl_exec($ch);
        
         $filesize = curl_getinfo($ch, CURLINFO_CONTENT_LENGTH_DOWNLOAD);
        
         curl_close($ch);

        if ( $filesize ) {
            return $filesize;
        }
    }

    return 0;
}

function isZero( $int = 0 )
{
    $int = (int)$int;
    return ( $int == 0 ) ? true : false;
}

function currencySymbol( $currency )
{
    $symbol = '';

    $currency = trim( $currency );
    if( !strlen( $currency ) ) {
        return $symbol;
    }

    // conver to uppercase
    $currency = strtoupper( $currency );

    switch( $currency ) {
        case 'EUR':
            $symbol = '&euro;';
            break;

        case 'GBP':
            $symbol = '&pound;';
            break;

        case 'USD':
                $symbol = '&#36;';
            break;
    }

    return $symbol;
}

function printAndExit( $value )
{
    $type = gettype( $value );

    // pre HTML tag
    echo '<pre>';

    switch( $type ) {
        case 'array':
        case 'object':
            print_r( $value );

            break;

        default:
            echo $value;
    }

    // exit
    exit;
}

function makeEmbedResponsive( $string, $targetWidth = '100%' )
{
    $string = preg_replace(
        array( '/width="\d+"/i' ),
        array( sprintf( 'width="%s"', $targetWidth ) ),
        $string
    );

    return $string;
}

function getScheme( $url )
{
    if( strpos( $url, 'http://' ) !== false ) {
        return 'http://';
    } else if( strpos( $url, 'https://' ) !== false ) {
        return 'https://';
    } else if( strpos( $url, 'ftp://' ) !== false ) {
        return 'ftp://';
    }

    return '';
}

function makeEven( $number )
{
    $number = (int)$number;
    if( $number == 0 ) {
        return 0;
    }

    while( !isEven( $number ) ) {
        $number = ( $number - 1 );
    }
    
    return $number;
}

function isEven( $number )
{
    $number = (int)$number;
    if( $number == 0 ) {
        return false;
    }
    
    if ( $number % 2 == 0 ) {
        return true;    
    }
    
    return false;
}

/**
 * Remove traling slash 
 * from a string
 * 
 * @param   string  $string
 * @return  string
*/
function removeTrailingSlash( $string )
{
    $string = rtrim( $string, '/' );
    return $string;    
}  

/**
 * Get all Controllers
 * 
 * @param   boolean $namesOnly
 * @return  array
*/
function getAllControllers( $namesOnly = true )
{   
    $controllers = array();
    
    // get the front controller instance
    $front  = Zend_Controller_Front::getInstance();
    $dir    = $front->getControllerDirectory();
    
    if( !empty( $dir ) ) {
        foreach( $dir AS $key => $value ) {
            $files = glob( $value.'/*' );
            
            if( !empty( $files ) ) {
                foreach( $files AS $file ) {
                    if( is_file( $file ) ) {
                        if( $namesOnly ) {
                            $controllers[] = str_replace( 'Controller', '', fetchFilename( basename( $file ) ) );
                        } else {
                            $controllers[] = basename( $file );                            
                        }
                    }
                }
            }            
        }
    }
    
    return $controllers;    
}
