<?php
/**
 * OpenFace
 * Direct Messages Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2017 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Sunday, July 02, 2015, 09:45 AM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: IndexController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
 */

class DmController extends Zend_Controller_Action
{
    private $_AutoEmbed;
    private $_Direct_Messages;
    private $_User;

    public function init()
    {
        $this->_AutoEmbed       = new AutoEmbed;
        $this->_Direct_Messages = new Direct_Messages;
        $this->_User            = new User;
    }

    public function __call( $methodName = '', $params = array() )
    {
        // An action method is called
        if ( 'Action' == substr( $methodName, -6 ) ) {
            $action = substr( $methodName, 0, -6 );

            $params = $this->_request->getParams();
            $slug   = $params['action'];
            $user   = $this->_User->getBy(
                array(
                    'url_slug' => $slug
                )
            );

            if( !empty( $user ) ) {
                $user = $this->_User->fetchUserDetailsById( $user['id'] );
                return $this->_forward( 'list', null, null, array( 'user' => $user ) );
            }

        } else {
            parent::__call( $methodName, $params );
        }
    }

    public function ajaxAction()
    {
        $this->_helper->viewRenderer->setNoRender( true );

        if( !empty( $_POST ) ) {
            header('Content-Type: application/json');

            $method = @$_POST['method'];
            $json	= array();

            switch( $method ) {
                case 'add':
                    // ip
                    $_POST['ip'] = getIP();

                    // from
                    $_POST['from'] = myUUID();

                    // date
                    $_POST['date'] = time();

                    // add to DB
                    $result	= $this->_Direct_Messages->insert( $_POST );

                    // current user
                    $currentUser = user();

                    if( (int)$result > 0 ) {
                        $json['status']   = 'OK';
                        $json['data']     = array(
                            'id'            => $result,
                            'text'          => $this->_AutoEmbed->parse( $_POST['text'] ),
                            'current_user'  => $currentUser,
                            'owner'         => $currentUser,
                        );
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

    public function listAction()
    {
        $params = $this->_request->getParams();

        if( (int)$params['user']['id'] > 0 ) {
            $messages = $this->_Direct_Messages->getConversation( $params['user']['uuid'], myUUID() );
        } else {
            forceError();
        }

        $this->view->user       = $params['user'];
        $this->view->messages   = $messages;
    }

}
