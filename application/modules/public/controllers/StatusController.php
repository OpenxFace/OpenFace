<?php
/**
 * OpenFace
 * Users Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, June 16, 2015, 10:29 AM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Controllers
 * @package     OpenFace
*/

class StatusController extends Zend_Controller_Action
{
	private $_requestObj;
	private $_requestUri;
	private $_User_Status;
	
    public function __call( $method, $args ) {}

    public function init()
    {    	    	
    	$this->_User_Status = new User_Status;    	    	    	
        $this->_requestObj = $this->getRequest();
        $this->_requestUri = $this->_requestObj->getRequestUri();
        
        $action = $this->getRequest()->getParam('action');                
    }
    
    public function indexAction()
    {
        forceError();
    } 
    
    public function editAction() {}
    
    public function ajaxAction()
    {
		$this->_helper->viewRenderer->setNoRender( true );
    	    	
		if( !empty( $_POST ) ) {
			header('Content-Type: application/json');						
			
			$method = $_POST['method'];
			$json	= array();			
			
			switch( $method ) {
				case 'add':
					$result	= $this->_User_Status->insert( $_POST );
						
					if( (int)$result > 0 ) {
						$json['status']   = 'OK';
						$json['data']     = array(
						    'id' => $result
						);
					} else {
						$json['status'] = 'ERROR';
					}
					
					break;
					
				case 'delete':
 				    $result	= $this->_User_Status->deleteById( $_POST['statusId'] );
				
				    if( (int)$result > 0 ) {
				        $json['status'] = 'OK';
				    } else {
				        $json['status'] = 'ERROR';
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
}