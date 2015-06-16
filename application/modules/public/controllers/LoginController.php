<?php
/**
 * Priceless PHP Base
 * Login Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, November 27, 2012, 04:18 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: LoginController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class LoginController extends Zend_Controller_Action
{
	protected $_User;
	
    public function init() 
    {
    	$this->_User = new User;
    		
    	if( @$_SESSION['user']['logged_in'] ) {
    		$returnTo = ( strlen( @$_GET['returnTo'] ) ) ? $returnTo : SITE_DEFAULT_LANDING_PAGE_AFTER_LOGIN;
    		header( 'Location: '.BASEURL.'/'.$returnTo );
    	}
    }
    
    public function indexAction() {}
    
    public function ajaxAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	    	
		if( !empty( $_POST ) ) {	
			$method = $_POST['method'];
			header('Content-Type: application/json');			
			
			switch( $method ) {
				case 'userLogin':					
					$data		= $this->_User->login( $_POST['username'], $_POST['password'] );						
					$json		= array();
					$json['data']	= $data;
					
					if( $data == 'LOGIN_OK' ) {
						$json['status'] = 'OK';
					} else {
						session_unset();
						session_destroy();
						
						$json['status'] = 'ERROR';
						
						switch( $data ) {								
							default:
								$json['error'] = $data;
						}
					}					
					
					break;

				default:										
					$json			= array();
					$json['status'] = 'ERROR';
					$json['error']	= 'UNHANDLED_EXCEPTION';										
			}		
			
			exit( json_encode( $json ) );
					
		} else {
			header( 'Location: '.BASEURL.'' );			
		}    	
    }   
    
    /**
     * User Login
    */    
    public function loginAction()
    {    	    	
    	$username = $this->getRequest()->getParam('username');
    	$password = $this->getRequest()->getParam('password');   	    	
    	    	    	    	
    	if( strlen( trim( $username ) ) AND strlen( trim( $password ) ) ) {    		    		
    		$loggedIn = $this->_User->login( $username, $password );

    		if( $loggedIn == 'LOGIN_OK' ) {
    			$_SESSION['user']['login_attempted']	= false;    			
    			$_SESSION['user']['login_error']		= false;
    			
    			$returnTo = ( strlen( @$_GET['returnTo'] ) ) ? $returnTo : SITE_DEFAULT_LANDING_PAGE_AFTER_LOGIN;
    			header( 'Location: '.BASEURL.'/'.$returnTo );
    		} else {
    			$_SESSION['user']['login_attempted']	= true;    			
    			$_SESSION['user']['login_error']		= true;
    			$this->_forward( null, 'accounts' );
    		}    		
    	} else {   		
    		$_SESSION['user']['login_attempted']	= true;    		
    		$_SESSION['user']['login_error']		= true;
    		   		
    		$this->_forward( null, 'accounts' );    		
    	}    	        	    	
    }
    /**
     * Login via Twitter
     *
     * Performs user login through Twitter using OAuth.  If user's have not
     * granted our application access to their account, they will be sent to
     * Twitter to do so.  Once done, they will return to this page again so
     * that we can handle them (e.g. run our application for them).
     *
     * @link	http://raymondkolbe.com/2009/10/03/zend-twitter-and-oauth-made-easy
     * @param	void
     * @return	void
    */
    public function twitterAction()
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	$config = array(
    		'callbackUrl'		=> BASEURL.'/login/twitter',
    		'siteUrl'			=> 'https://api.twitter.com/oauth',
    		'consumerKey'		=> SITE_TWITTER_API_KEY,
    		'consumerSecret'	=> SITE_TWITTER_API_SECRET
    	);
    	$consumer = new Zend_Oauth_Consumer( $config );
    	// START:	check if we have the user's token
    	if( strlen( @$_COOKIE['twitter_access_token'] ) ) {
    		$token = $_COOKIE['twitter_access_token'];
    		$token = unserialize( $token );
    		Zend_Service_Twitter::setHttpClient( $token->getHttpClient( $config ) );
    		$twitter = new Zend_Service_Twitter(array(
    			'username'		=> $token->screen_name,
    			'accessToken'	=> $token,
    			'oauthOptions'	=> array(
    				'consumerKey'		=> SITE_TWITTER_API_KEY,
    				'consumerSecret'	=> SITE_TWITTER_API_SECRET,
    			)
    		));
    		$response = $twitter->account->verifyCredentials();
    		if( strlen( $response->screen_name ) ) {
    			// OK
    			$response = json_decode( $response->getRawResponse(), true );
    			$response['network'] = 'twitter';
    			$this->_User->loginExternal( $response );
    			header('Location: '.BASEURL.'/login');
    			exit;
    		} else {
    			// error
    			unset( $_COOKIE['twitter_access_token'] );
    			header('Location: '.BASEURL.'/login');
    			exit;
    		}    		
    	}
    	// END:		check if we have the user's token
    	if( !strlen( @$_GET['oauth_token'] ) AND !strlen( @$_GET['oauth_verifier'] ) ) {
    		if( !is_null( @$_SESSION['twitter']['request_token'] ) AND strlen( @$_SESSION['twitter']['access_token'] ) ) {
    			$token = unserialize( $_SESSION['twitter']['access_token'] );
    			Zend_Service_Twitter::setHttpClient( $token->getHttpClient( $config ) );
    			$twitter = new Zend_Service_Twitter(array(
    				'username'		=> $token->screen_name,
    				'accessToken'	=> $token,
    				'oauthOptions'	=> array(
    					'consumerKey'		=> SITE_TWITTER_API_KEY,
    					'consumerSecret'	=> SITE_TWITTER_API_SECRET,
    				)
    			));
    			$response = $twitter->account->verifyCredentials();
    			if( strlen( $response->screen_name ) ) {
    				// OK
    				$response = json_decode( $response->getRawResponse(), true );
    				$response['network'] = 'twitter';
    				$this->_User->loginExternal( $response );
    				header('Location: '.BASEURL.'/login');
    				exit;
    			} else {
    				// error
    				unset( $_SESSION['twitter']['access_token'] );
    				header('Location: '.BASEURL.'/login');
    				exit;
    			}    			
    		} else {
    			if( !isset( $_GET['denied'] ) ) {    				
    				$token = $consumer->getRequestToken();
    				$_SESSION['twitter']					= array();
    				$_SESSION['twitter']['request_token']	= serialize( $token );
    				$consumer->redirect();    				
    			} else {
    				$_SESSION['twitter']['request_token'] = null;
    				header('Location: '.BASEURL.'/login');
    				exit;
    			}
    		}   		
    	} else {    		    		
			$token = $consumer->getAccessToken( $_GET, unserialize( $_SESSION['twitter']['request_token'] ) );
    		$_SESSION['twitter']['access_token']	= serialize( $token );
    		$_SESSION['twitter']['request_token']	= null;
    		// This line is very important. Since Zend_Service_Twitter does
    		// not have support for OAuth (yet), this is how we get it to work.
    		// All we are doing is making Zend_Service_Twitter use OAuth's
    		// HTTP Client instance, which will automatically append the proper
    		// OAuth query info to any Twitter service call we make from here
    		// on out.
    		Zend_Service_Twitter::setHttpClient( $token->getHttpClient( $config ) );
			$twitter = new Zend_Service_Twitter(array(
    			'username'		=> $token->screen_name,
    			'accessToken'	=> $token,
    			'oauthOptions'	=> array(
    				'consumerKey'		=> SITE_TWITTER_API_KEY,
    				'consumerSecret'	=> SITE_TWITTER_API_SECRET,
    			)
    		));
    		$response = $twitter->account->verifyCredentials();
			if( strlen( $response->screen_name ) ) {
    			// OK
    			$response = json_decode( $response->getRawResponse(), true );
    			// login    				
    			$response['network'] = 'twitter';
    			$this->_User->loginExternal( $response );    			
    			header('Location: '.BASEURL.'/login');
    			exit;
    		} else {
    			// error
    			header('Location: '.BASEURL.'/login');
    			exit;
    		}		
    	}
    }
}