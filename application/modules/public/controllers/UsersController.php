<?php
/**
 * Priceless PHP Base
 * Users Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Thursday, November 29, 2012, 12:52 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: UsersController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class UsersController extends Zend_Controller_Action
{
	private $_requestObj;
	private $_requestUri;
	private $_User;
	
    public function __call( $method, $args ) {}

    public function init()
    {    	    	
    	$this->_User = new User;    	    	    	
        $this->_requestObj = $this->getRequest();
        $this->_requestUri = $this->_requestObj->getRequestUri();
        
        $action = $this->getRequest()->getParam('action');                
    }
    
    public function ajaxAction()
    {
		$this->_helper->viewRenderer->setNoRender( true );
    	    	
		if( !empty( $_POST ) ) {
			header('Content-Type: application/json');						
			
			$method = $_POST['method'];
			$json	= array();			
			
			switch( $method ) {
				case 'userLogin':
					$result	= $this->_User->login( $_POST['username'], $_POST['password'] );
						
					if( $result == 'LOGIN_OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
					break;
				case 'userLoginExternal':
					$result	= $this->_User->loginExternal( $_POST['data'] );
					if( $result == 'LOGIN_OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'removeTempAvatar':
					$result = (int)$this->_User->removeOwnTempAvatar();
					
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'TEMP_DELETE_ERROR';
					}
					 
					break;
					
				case 'changeOwnAvatar':
					$result	= $this->_User->changeOwnAvatar();
					if( $result['status'] == 'OK' ) {
						$json['status'] = 'OK';
						$json['url']	= $result['url'];
					} else {
						$json['status'] = 'ERROR';
					}
				
					break;
											
				case 'uploadOwnAvatar':					
					$result	= $this->_User->uploadOwnAvatar();
					if( $result['status'] == 'OK' ) {
						$json['status'] = 'OK';
						$json['url']	= $result['url'];
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result['error'];
					}
				
					break;
									
				case 'unblockUser':
					$result	= (int)$this->_User->unblockUserById( $_POST['requesterId'], $_POST['id'] );
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'blockUser':
					$result	= (int)$this->_User->blockUserById( $_POST['requesterId'], $_POST['id'] );
					if( $result > 0 ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
					
				case 'resetOwnPassword':
					$result	= $this->_User->resetOwnPassword( $_POST['username'], $_POST['challenge'], $_POST['response'] );
					if( $result == 'OK' ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= $result;
					}
				
					break;
									
				case 'updateTheme':
					$theme = $_POST['theme'];
					setcookie('theme', $theme, 315360000, '/');
					$_SESSION['theme'] = $theme;
					$json['status'] = 'OK';
				
					break;
									
				case 'changeOwnPassword':
					$result	= $this->_User->changeOwnPassword( $_POST['password'], $_POST['new_password'] );
					if( $result ) {
						$json['status'] = 'OK';
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'PASSWORD_ERROR';
					}
				
					break;
									
				case 'changeLang':
					$result	= $this->_User->changeUserLangByLangId( (int)$_POST['langId'] );
					if( $result ) {
						$json['status'] = 'OK';						
					} else {
						$json['status'] = 'ERROR';
						$json['error']	= 'LANG_ID_DOES_NOT_EXIST';
					}
										
					break;

				default:
					$json['status'] = 'ERROR';
					$json['error']	= 'UNHANDLED_EXCEPTION';
			}	
					
			exit( json_encode( $json ) );			
		} else {
			header( 'Location: '.BASEURL.'');
		}     	
    }

    public function indexAction() {}

    public function editAction() {}
}