<?php
/**
 * BizLogic Base Framework
 * Bootstrap
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Thursday, April 21, 2011 / 01:04 AM GMT+1
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $
 * @version     $Id: Bootstrap.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 *
 * @category    Bootstrap
 * @package     BizLogic Base Framework
*/

error_reporting( E_ALL );
ini_set( 'display_errors', false );
ini_set( 'log_errors', true );

@set_time_limit( 0 );
date_default_timezone_set('UTC');

// common functions
require_once('functions.php');

// global constants
require_once('constants.php');

// error log
ini_set('error_log', LOG_DIR.'/error/php/'.date('m-d-Y').'.log');

require_once('Zend/Loader/Autoloader.php');
$Zend_Loader_Autoloader = Zend_Loader_Autoloader::getInstance();
$Zend_Loader_Autoloader->setFallbackAutoloader( true );

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    private $_Cache;

    /**
     * Bootstrap constructor
     *
     * @param   string  $env    application environment
    */
    public function __construct( $env )
    {
    	$this->_checkInstall();
    	$this->_setRunEnv();    	
    	$this->_checkFolderPerms();
    	$this->_setupDB();
        $this->_Cache = new Cache;
        $this->_setupSession();
        $this->_setupLocale();
        $this->_setupCache();
        $this->_setupSiteConfig();
        $this->_setupLanguage();
        $this->_setupThemes();
        // cleanup
        $this->__cleanup();
        $this->_updateUserSession();
        $this->_checkUpgrade();
        $this->_setupFirePHP();
    }
    
    private function _checkInstall()
    {
        $currentUri = basename( $_SERVER['REQUEST_URI'] );
        
    	if( file_exists( BASEDIR.'/install' ) ) {
    		if( !file_exists( BASEDIR.'/install/install.lock' ) ) {
    		    if( $currentUri != 'install' ) {
    		        header('Location: '.BASEURL.'/install');    		    
    		    }    		        			
    		}	
    	}	
    }
    
    private function _checkUpgrade()
    {
    	$allowedPaths = array(
    		'ajax',
    		'login',
			'upgrade',
    		'users'
    	);
    	$allowed = false;
    	if( file_exists( BASEDIR.'/data/temp/.upgrade' ) ) {
    		foreach( $allowedPaths AS $key => $value ) {
    			if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
    				$allowed = true;
    			}    			
    		}
    		if( !$allowed ) {
    			header('Location: '.BASEURL.'/upgrade');
    		}
    	}    	
    }
    
    private function _checkFolderPerms()
    {
    	$errors		= array();    	
    	$required	= array();
    	$required[]	= BASEDIR.'/data';
    	$required[]	= BASEDIR.'/data/cache';
    	$required[]	= BASEDIR.'/data/logs';
    	$required[]	= BASEDIR.'/data/logs/encode';
    	$required[]	= BASEDIR.'/data/logs/error/php';
    	$required[]	= BASEDIR.'/data/sessions';
    	$required[]	= BASEDIR.'/data/temp';
    	$required[]	= BASEDIR.'/data/temp/encode';
    	$required[]	= BASEDIR.'/data/uploads';
    	$required[]	= BASEDIR.'/data/uploads/users';    	
    	
    	foreach( $required AS $key => $value ) {
    	    if( !file_exists( $value ) ) {
    	       mkdir( $value, 0777, true ); 
    	       file_put_contents( $value.'/.htaccess', 'deny from all' );   
    	    }
    	    
    		if( !is_writeable( $value ) ) {
				$errors[] = $value;    			
    		}	
    	}
    	
    	if( !empty( $errors ) ) {
    		$errorMessage = 'The following file permission errors are preventing the application from functioning properly:<ol type="">';    		
    		
    		foreach( $errors AS $key => $value ) {
    			$errorMessage .= '<li>'.$value.' is not writeable. chmod it to 0777</li>'; 
    		}    		
    		
    		$errorMessage .= '</ol>';
    		$errorMessage .= '<button onClick="window.location.reload();" style="width: 150px; height: 35px;">Retry</butto>';
    		
    		exit( $errorMessage );
    	}
    }

    private function _setupThemes()
    {
    	global $SITE_THEMES;
    	global $BOOTSTRAP_THEMES;
    	
    	$Site_Theme    = new Site_Theme;
    	$SITE_THEMES           = $Site_Theme->fetchThemesForDisplay();
    	$BOOTSTRAP_THEMES      = $Site_Theme->fetchBootstrapThemesForDisplay();
    }
    
    private function _setupSessionParams()
    {
        // until the end of time...
        // @link	http://en.wikipedia.org/wiki/Year_2038_problem
        if( !defined('COOKIE_TIMEOUT') ) {
            define( 'COOKIE_TIMEOUT', 2147483647 );
        }

        if( !defined('GARBAGE_TIMEOUT') ) {
            define( 'GARBAGE_TIMEOUT', COOKIE_TIMEOUT );
        }

        ini_set( 'session.gc_maxlifetime', GARBAGE_TIMEOUT );
        session_set_cookie_params( COOKIE_TIMEOUT, '/' );

        // setting session dir
        if( isset( $_SERVER['HTTP_HOST'] ) ) {
            $sessdir = '/tmp/'.$_SERVER['HTTP_HOST'];
        } else {
            $sessdir = '/tmp/BizLogic';
        }

        // if session dir not exists, create directory
        if ( !is_dir( $sessdir ) ) {
            @mkdir( $sessdir, 0777, true );
        }

        //if directory exists, then set session.savepath otherwise let it go as is
        if( is_dir( $sessdir ) ) {
            ini_set( 'session.save_path', $sessdir );
        }
    }

    private function _setupSiteConfig()
    {
        $Base = new Base;
        $Base->defineSiteConfig();
    }

    private function _setupSession()
    {
        $this->_setupSessionParams();

        if( !isset( $_SESSION ) ) {
            session_start();
        }

        setInitialSessionValues();        
    }

    /**
     * setup Zend_Cache
     *
     * @link    http://framework.zend.com/manual/en/zend.cache.introduction.html
     * @todo    move cache lifetime to ini file
     */
    private function _setupCache()
    {
        $this->_Cache->setupCache( 86400, 'cache' );
        $this->_Cache->setupCache( 3600, 'cacheOneHour' );
        $this->_Cache->setupCache( 900, 'cacheFifteenMin' );
    }

    /**
     * Setup a DB connection
    */
    protected function _setupDB()
    {    	
    	$config    = new Zend_Config_Ini( APP_DIR.'/configs/db.ini', 'live' );
    	$db        = $config->params->toArray();
    	
    	// define DB table prefix
    	define( 'DB_TABLE_PREFIX', $db['table_prefix'] );
    	
    	$mysqli = mysqli_connect( 
    	    $db['host'], 
    	    $db['username'], 
    	    $db['password'],
    	    $db['dbname']
        ) OR die( mysqli_connect_error() );
    	
    	// set charset
    	mysqli_set_charset( $mysqli, $db['charset'] ); 

    	// save in registry
    	Zend_Registry::set( 'DB_CONNECTION', $mysqli );    	
    }   

    protected function _setupLocale()
    {
        $_SESSION['user']['locale'] = determineUserLocale();
    }

    protected function _setupLanguage()
    {        
    	global $SITE_LANGUAGES; 
	   	
        $Language	= new Language();
        $SITE_LANGUAGES		= $Language->fetchActiveLanguages();
        
        if( isset( $_SESSION['user']['lang_override'] ) ) {
        	if( $_SESSION['user']['lang_override'] ) {
        		$_SESSION['user']['language_id'] = $_SESSION['user']['selected_lang_id'];
        	}	
        }
        
        // we merge the default language w/ the detected language, in case 
        // phrases do not exist in the detected language
        $siteDefaultLanguageId = $Language->fetchLanguageIdByLocaleId( SITE_DEFAULT_LANGUAGE );
        
        if( !@$_SESSION['user']['lang_override'] ) {
        	$_SESSION['user']['language_id'] = (int)$Language->fetchLanguageIdByLocale( $_SESSION['user']['locale'] );
        	$_SESSION['user']['language_id'] = ( $_SESSION['user']['language_id'] == 0 ) ? $siteDefaultLanguageId : $_SESSION['user']['language_id'];
        	$_SESSION['user']['site_language'] = $_SESSION['user']['language_id']; 
        } else {
        	$_SESSION['user']['language_id']	= ( (int)$_SESSION['user']['language_id'] == 0 ) ? $siteDefaultLanguageId : $_SESSION['user']['language_id'];
        	$_SESSION['user']['site_language']	= $_SESSION['user']['language_id'];
        }
        
        $siteDefaultPhrases				= $Language->fetchPhrasesByLanguageId( $siteDefaultLanguageId );
        $_SESSION['site']['phrases']	= $Language->fetchPhrasesByLanguageId( $_SESSION['user']['language_id'] );
        
        if( $_SESSION['user']['language_id'] != $siteDefaultLanguageId ) {
        	$_SESSION['site']['phrases'] = array_merge( $siteDefaultPhrases, $_SESSION['site']['phrases'] );
        }
    }

    protected function _setRunEnv()
    {
        $env = determineRunEnvironment();
        setRunEnvironment( $env );

        Zend_Registry::set( 'RUN_ENV', $env );
    }
    
    protected function _updateUserSession()
    {    	 	
    	// we want to update the user session on every page hit
    	$User = new User();		
    	$User->updateUserSession();
    	if( !isset( $_COOKIE['theme'] ) ) {
    		setcookie( 'theme', SITE_DEFAULT_TEMPLATE, ( time() + SITE_COOKIE_EXPIRATION_DATE ) );    		
    	}
    	
    	$allowedPaths = array(
    	    'ajax',
    	    'forgot',
    	    'login',
    	    'register',
    	    'upgrade',
    	    'users',
    	    'profile\/password',
    	    'profile\/register',
    	    'logout',
    	);    	

    	if( @$_SESSION['user']['logged_in'] ) {
    		if( empty( $_SESSION['site']['permissions'] ) ) {
    		    $allowed = false;
    		    
    		    foreach( $allowedPaths AS $key => $value ) {
    		        if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
    		            $allowed = true;
    		        }
    		    }
    		    
    		    if( !$allowed ) {
                    $this->noPerms();
    		    }
    		}    		
    	}

    	if( !has_permission('can_view_site') ) {
    	    $allowedPaths = array(
    	        'ajax',
    	        'forgot',
    	        'login',
    	        'register',
    	        'upgrade',
    	        'users',
    	        'profile\/password',
    	        'profile\/register',
    	        'logout',    	        
    	    );
    	
    	    $allowed = false;
    	    	
    	    foreach( $allowedPaths AS $key => $value ) {
    	        if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
    	            $allowed = true;
    	        }
    	    }
    	    	
    	    if( !$allowed ) {
    	        if( (int)$_SESSION['user']['logged_in'] != 1 ) {
    	            header('Location: '.BASEURL.'/login');
    	            exit;
    	        } else {
    	            exit('Your account does not have permission to access this site');
    	        }
    	    }
    	}    	

		$siteStatus = @$_SESSION['user']['site_status'];
		switch( $siteStatus ) {
			case 'banned':
				$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
				$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
				$html = str_replace( '__ERROR_MESSAGE__', 'Your user account is banned', $html );
				$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
				$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
				
				exit( $html );
				
				break;
				
			case 'pending':				
				$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
				$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
				$html = str_replace( '__ERROR_MESSAGE__', 'Please check your e-mail for information on how to activate your account', $html );
				$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
				$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
								
				exit( $html );				

				break;
		}
		
		if( !has_permission('can_view_site') ) {
			$allowedPaths = array(
				'ajax',
			    'forgot',
				'login',
			    'register',
				'upgrade',
				'users'
			);
			 
			$allowed = false;
			
			foreach( $allowedPaths AS $key => $value ) {
				if( preg_match('/'.$value.'/', $_SERVER['REQUEST_URI'] ) ) {
					$allowed = true;
				}
			}
			
			if( !$allowed ) {
				if( (int)$_SESSION['user']['logged_in'] != 1 ) {
					header('Location: '.BASEURL.'/login');
				} else {
					exit('Your account does not have permission to access this site');
				}
			}	
		}
    }
    
    /**
     * Setup FirePHP
     * 
     * @link    http://www.firephp.org/HQ/Use.htm
     * @return  void 
    */
    protected function _setupFirePHP()
    {    	
    	if( (int)ENABLE_FIREPHP == 1 ) {
    		if( has_permission('can_use_firephp') ) {
    			require_once('FirePHP/FirePHP.class.php');
    			$firephp = FirePHP::getInstance( true );
    			require_once('FirePHP/fb.php');

                $firephp->setEnabled( true );
    			    			
    			$firephp->registerErrorHandler( $throwErrorExceptions = false );
    			$firephp->registerExceptionHandler();
    			$firephp->registerAssertionHandler(
    				$convertAssertionErrorsToExceptions = true,
    				$throwAssertionExceptions = false
				);
    			 
    			// START:	FirePHP
    			$firebugWriter = new Zend_Log_Writer_Firebug();
    			$firebugLogger = new Zend_Log( $firebugWriter );
    			Zend_Registry::set( 'firebugLogger', $firebugLogger );
    			// END:		FirePHP    			
    		} 		
    	}
    }
    
    protected function noPerms()
    {
		define( 'NO_SITE_PERMS', true );		
		$_SESSION['user']['logged_in'] = false;	

		$html = file_get_contents( VIEWS_DIR.'/error/static/error.phtml' );
		$html = str_replace( '__SITE_NAME__', SITE_NAME, $html );
		$html = str_replace( '__ERROR_MESSAGE__', 'Your account has not been granted permissions for this site', $html );
		$html = str_replace( '__THEME_PATH__', PROTOCOL_RELATIVE_URL.'/'.SITE_LOCAL_THEME_URL_ROOT.'/'.SITE_DEFAULT_TEMPLATE, $html );
		$html = str_replace( '__JS_PATH__', PROTOCOL_RELATIVE_URL.'/js', $html );
		$html = str_replace( '__PROTOCOL_RELATIVE_URL__', PROTOCOL_RELATIVE_URL, $html );
		$html = str_replace( '__BASEURL__', PROTOCOL_RELATIVE_URL, $html );
		$html = str_replace( '__SITE_DEFAULT_PRELOADER_IMAGE_PATH__', SITE_DEFAULT_PRELOADER_IMAGE_PATH, $html );
		
		exit( $html );
    }
    
    protected function __cleanup()
    {
    	$minute = date('i');
    	$minute = (int)$minute;
    	if( $minute >= 58 ) {
    		remove_old_files( BASEDIR.'/data/temp', '-6 hours' );
    		remove_old_files( BASEDIR.'/data/logs', '-5 days' );
    	}    	
    }
   
    public function run()
    {      		    	
        $front = Zend_Controller_Front::getInstance();
        $front->throwExceptions( false );
        try {       
	        $front->setControllerDirectory(
	        	array('default' => PATH.'/application/modules/public/controllers')
	        );
	        
	        $front->setParam( 'useDefaultControllerAlways', false );
	        $front->setParam( 'displayExceptions', true );
            $front->dispatch();
        } catch( Exception $e ) {
            $request = $front->getRequest();            
            $request->setModuleName('default');
            $request->setControllerName('error');
            $request->setActionName('error');

            $error              = new Zend_Controller_Plugin_ErrorHandler();
            $error->type        = Zend_Controller_Plugin_ErrorHandler::EXCEPTION_OTHER;
            $error->request     = clone($request);
            $error->exception   = $e;
            
            $request->setParam('error_handler', $error);
        }
    }
}
