<?php
/**
 * OpenFace
 * Index Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, November 27, 2012, 04:18 PM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Controllers
 * @package     OpenFace
*/

class IndexController extends Zend_Controller_Action
{	
    private $_User_Status;
    private $_User_Status_Likes;
    
    public function init() 
    {
        $this->_User_Status         = new User_Status;
        $this->_User_Status_Likes   = new User_Status_Likes;
    }
    
    public function indexAction() 
    {
        // total count
        $countTotal = $this->_User_Status->countBy( 'privacy', 'public' );
        
        // get status messages
        $messages = $this->_User_Status->getBy( 
            array( 
                'privacy' => 'public'                 
            ), 
            SITE_DEFAULT_STATUS_FETCH_LIMIT, 
            0, 
            array( 
                'date' => 'DESC'                
            ) 
        );
        
        // fetched message count
        $countFetched = count( $messages );
        
        if( !empty( $messages ) ) {            
            $AutoEmbed              = new AutoEmbed;
            $User_Status_Comment    = new User_Status_Comment;
            $User_Status_Media      = new User_Status_Media;
            $User                   = new User;
            
            foreach( $messages AS $key => $value ) {
                // current user
                $currentUser                        = user();
                $messages[ $key ]['current_user']   = $currentUser;

                // message owner
                $messages[ $key ]['owner'] = $User->fetchUserDetailsByUUID( $value['user_uuid'] );

                // timeline owner
                $messages[ $key ]['timeline_owner'] = $User->fetchUserDetailsByUUID( $value['timeline_owner'] );

                // START:   status
                // AutoEmbed
                $messages[ $key ]['status'] = $AutoEmbed->parse( $value['status'] );
                
                // Instagram Embed
                //$messages[ $key ]['status'] = embed_instagram( $value['status'] );
                // END:     status
                
                // like data
                $messages[ $key ]['has_liked'] = $this->_User_Status_Likes->fetchLikeByUserId( 
                    $value['uuid'], 
                    @$_SESSION['user']['uuid'] 
                );

                $messages[ $key ]['like_data']          = array();
                $messages[ $key ]['like_data']['users'] = $this->_User_Status_Likes->getBy(
                    array(
                        'parent_uuid' => $value['uuid']
                    ),
                    0,
                    0
                ); 
                
                $messages[ $key ]['like_data']['count'] = count( $messages[ $key ]['like_data']['users'] );                

                // START:   Get comments
                $messages[$key]['comments'] = $User_Status_Comment->getBy(
                    array(
                        'parent_uuid' => $value['uuid']
                    ),
                    0,
                    0,
                    array(
                        'date' => 'ASC'
                    )
                );
                // END:     Get comments
                
                // START:   Get the comment owner
                if( !empty( $messages[$key]['comments'] ) ) {
                    foreach( $messages[$key]['comments'] AS $commentKey => $commentValue ) {
                        $messages[$key]['comments'][$commentKey]['author'] = $User->getBy(
                            array(
                                'uuid' => $commentValue['user_uuid']
                            )
                        );
                        
                        $messages[$key]['comments'][$commentKey]['current_user']    = $currentUser;
                        $messages[$key]['comments'][$commentKey]['owner']           = array(
                            'uuid' => $value['user_uuid']
                        );
                    }
                }
                // END:     Get the comment owner

                // get media
                $messages[ $key ]['media'] = $User_Status_Media->getBy(
                    array(
                        'parent_uuid' => $value['uuid']
                    ),
                    100
                );
            }    
        }

        $this->view->countTotal     = $countTotal;
        $this->view->countFetched   = $countFetched;
        $this->view->messages       = $messages;
    }
}