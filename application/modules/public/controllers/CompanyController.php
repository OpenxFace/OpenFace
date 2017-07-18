<?php
/**
 * OpenFace
 * Company Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2017 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Thursday, July 14, 2017, 15:00 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Controllers
 * @package     Priceless PHP Base
 */

class CompanyController extends Zend_Controller_Action
{
    private $_User;

    public function init()
    {
        $this->_User = new User;
    }

    public function indexAction() {}

    public function directoryAction() {}

}