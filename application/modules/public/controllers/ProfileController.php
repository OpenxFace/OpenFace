<?php
/**
 * OpenFace
 * Profile Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Thursday, May 07, 2015, 08:55 AM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: IndexController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class ProfileController extends Zend_Controller_Action
{
    private $_User_Status;

    public function init()
    {
        $this->_User_Status         = new User_Status;
        $this->_User_Status_Likes   = new User_Status_Likes;
    }
    
    public function indexAction() {}

    public function displayAction()
    {
        $params = $this->_request->getParams();

        if( empty( $params['user'] ) ) {
            forceError();
        } else {
            if( is_null( $params['user']['avatar_url'] ) ) {
                switch( $params['user']['gender'] ) {
                    case 'female':
                        $params['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL_FEMALE;

                        break;

                    default:
                        $params['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
                }
            }

            $messages = $this->_User_Status->getBy(
                array(
                    'timeline_owner' => $params['user']['uuid']
                ),
                100,
                0,
                array(
                    'date' => 'DESC'
                )
            );

            if( !empty( $messages ) ) {
                $AutoEmbed              = new AutoEmbed;
                $User_Status_Comment    = new User_Status_Comment;
                $User                   = new User;

                foreach ( $messages AS $key => $value ) {
                    // current user
                    $currentUser                    = user();
                    $messages[$key]['current_user'] = $currentUser;

                    // START:   status
                    // AutoEmbed
                    $messages[$key]['status'] = $AutoEmbed->parse($value['status']);

                    // Instagram Embed
                    //$messages[ $key ]['status'] = embed_instagram( $value['status'] );
                    // END:     status

                    // like data
                    $messages[$key]['has_liked'] = $this->_User_Status_Likes->fetchLikeByUserId(
                        $value['uuid'],
                        @$_SESSION['user']['uuid']
                    );

                    $messages[$key]['like_data']            = array();
                    $messages[$key]['like_data']['users']   = $this->_User_Status_Likes->getBy(
                        array(
                            'parent_uuid' => $value['uuid']
                        ),
                        0,
                        0
                    );

                    $messages[$key]['like_data']['count'] = count($messages[$key]['like_data']['users']);

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
                    if (!empty($messages[$key]['comments'])) {
                        foreach ($messages[$key]['comments'] AS $commentKey => $commentValue) {
                            $messages[$key]['comments'][$commentKey]['author'] = $User->getBy(
                                array(
                                    'uuid' => $commentValue['user_uuid']
                                )
                            );

                            $messages[$key]['comments'][$commentKey]['current_user'] = $currentUser;
                            $messages[$key]['comments'][$commentKey]['owner'] = array(
                                'uuid' => $value['user_uuid']
                            );
                        }
                    }
                    // END:     Get the comment owner
                }
            }
			
			// metadata
            $User_Metadata = new User_Metadata;
            $params['user']['metadata'] = $User_Metadata->getBy(
                array(
                    'parent_uuid'   => $params['user']['uuid'],
                ),
                0
            );			

            $this->view->messages   = $messages;
            $this->view->user       = $params['user'];
        }
    }

    public function mandatoryAction()
    {
        if( empty( $_SESSION['user']['required_data'] ) ) {
            return header('Location: '.BASEURL);
        }
    }

}
