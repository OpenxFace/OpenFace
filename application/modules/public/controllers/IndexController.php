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
    
    public function init() 
    {
        $this->_User_Status = new User_Status;
    }
    
    public function indexAction() 
    {
        // get status messages
        $messages = $this->_User_Status->getBy( 
            array( 
                'user_uuid' => $_SESSION['user']['uuid']                 
            ), 
            SITE_DEFAULT_STATUS_FETCH_LIMIT, 
            0, 
            array( 
                'date' => 'DESC'                
            ) 
        );
        
        $this->view->messages = $messages;
    }
}