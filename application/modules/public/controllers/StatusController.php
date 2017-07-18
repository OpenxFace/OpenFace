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
    private $_AutoEmbed;
	private $_requestObj;
	private $_requestUri;
	private $_User_Status;
	private $_User_Status_Likes;
	private $_User_Status_Comment;

    public function init()
    {    	    	
        $this->_AutoEmbed              = new AutoEmbed;
    	$this->_User_Status            = new User_Status;
    	$this->_User_Status_Likes      = new User_Status_Likes;
    	$this->_User_Status_Comment    = new User_Status_Comment;
    	
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
			
			// current user
			$currentUser = user();
			
			$method = $_POST['method'];
			$json	= array();			
			
			switch( $method ) {
                case 'completeUploads':

                    // START:   Complete any file uploads
                    $Upload = new Upload();
                    $json   = $Upload->completeFileUpload( $_POST['uuid'] );
                    // END:     Complete any file uploads

                    break;

				case 'add':
				    // ip
				    $_POST['ip'] = getIP();
				    
				    // add to DB
					$result	= $this->_User_Status->insert( $_POST );
						
					if( (int)$result > 0 ) {
					    $User = new User;

						$json['status']   = 'OK';
						$json['data']     = array(
						    'id'                => $result,
						    'status'            => $this->_AutoEmbed->parse( $_POST['status'] ),
						    'current_user'      => $currentUser,
						    'owner'             => $currentUser,
                            			    'timeline_owner'    => $User->fetchUserDetailsByUUID( $_POST['timeline_owner'] ),
						);
						
						if( isset( $_POST['uuid'] ) ) {
						    $json['data']['uuid'] = $_POST['uuid'];
						}
					} else {
						$json['status'] = 'ERROR';
					}
					
					break;

				case 'comment':
				    // ip
				    $_POST['ip'] = getIP();
				    
				    // add to DB
				    $result	= $this->_User_Status_Comment->insert( $_POST );
				
				    if( (int)$result > 0 ) {
				        // get the status owner
				        $record = $this->_User_Status->getBy( 
				            array(
				                'uuid' => $_POST['parent_uuid']  				                
                            )
				        );
				        
				        $json['status']   = 'OK';
				        $json['data']     = array(
				            'id'            => $result,
				            'current_user'  => $currentUser,
				            'owner'         => $record['user_uuid']
				        );
				
				        if( isset( $_POST['uuid'] ) ) {
				            $json['data']['uuid'] = $_POST['uuid'];
				        }
				    } else {
				        $json['status'] = 'ERROR';
				    }
				    	
				    break;
					    					
				case 'delete': 			
				    $statusId = (int)$_POST['statusId'];
				    
 				    // START:  Check Owner
 				    $record = $this->_User_Status->getById( $statusId );

 				    if( !empty( $record ) ) {
 				        if( @$record['user_uuid'] == $_SESSION['user']['uuid'] OR @$record['timeline_owner'] == $_SESSION['user']['uuid'] ) {
 				            $result	= $this->_User_Status->deleteById( $statusId );

 				            if( (int)$result > 0 ) {
 				                $json['status'] = 'OK';
 				            } else {
 				                $json['status'] = 'ERROR';
 				            }
 				        } else {
 				            $json['status'] = 'ERROR';
 				        } 				        
 				    } else {
 				        $json['status'] = 'ERROR';
 				    }				   
 				    // END:    Check Owner

				    break;
				    
				case 'commentDelete':
			    case 'deleteComment':
			        $result	= $this->_User_Status_Comment->deleteById( $_POST['id'] );
			    
			        if( (int)$result > 0 ) {
			            $json['status'] = 'OK';
			        } else {
			            $json['status'] = 'ERROR';
			        }
			         
			        break;	
			        
			    case 'fetchPublicTimeline':
			        $result	= $this->_User_Status->getBy( 
                        array( 
                            'privacy' => 'public'                 
                        ), 
                        SITE_DEFAULT_STATUS_FETCH_LIMIT,
                        (int)$_POST['offset'], 
                        array( 
                            'date' => 'DESC'                
                        ) 
                    );
			        
			        // total count
			        $countTotal = $this->_User_Status->countBy( 'privacy', 'public' );
			         
			        if( !empty( $result ) ) {
			            // START:    AutoEmbed
			            foreach( $result AS $key => $value ) {
			                $result[ $key ]['status'] = $this->_AutoEmbed->parse( $value['status'] );    
			            }
			            // END:      AutoEmbed
			            
			            $json['status']  = 'OK';
			            $json['data']    = array(
			                'data'   => $result,
			                'count'  => count( $result ),
			                'total'  => $countTotal,
			            );			            
			        } else {
			            $json['status'] = 'ERROR';
			        }
			        
			        break;

			    case 'like':
			        // ip
			        $_POST['ip'] = getIP();
			        
			        // add to DB
			        $result	= $this->_User_Status_Likes->insert( $_POST );
			    
			        if( (int)$result > 0 ) {
			            $json['status']   = 'OK';
			            $json['data']     = array(
			                'id' => $result
			            );
			        } else {
			            $json['status'] = 'ERROR';
			        }
			        	
			        break;	

			    case 'unlike':
			        $result	= $this->_User_Status_Likes->deleteBy( 
			            'parent_uuid', 
			            $_POST['parent_uuid']
			        );
			        
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