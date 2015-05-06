<?php
/**
 * Priceless PHP Base
 * Logout Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Friday, November 29, 2013, 05:33 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: LogoutController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class LogoutController extends Zend_Controller_Action
{	
    public function init() 
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	
    	if( !@$_SESSION['user']['logged_in'] ) {
    		header( 'Location: '.BASEURL.'/login' );
    	}
    	
    	$token = null;
    	if( @$_SESSION['user']['external']['network'] == 'twitter' ) {
    		$token = $_SESSION['twitter']['access_token'];
    	}
    	session_unset();    	
    	session_destroy();
    	
    	// store the token from Twitter
    	if( !is_null( $token ) ) {
		setcookie('twitter_access_token', $token, 2147483647);    		
    	}
    	header( 'Location: '.BASEURL.'/login' );
    }

    public function indexAction() {}
}