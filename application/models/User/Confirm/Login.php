<?php
/**
 * PricelessPHP Base Framework
 * User Confirm Login Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Wednesday, November 28, 2013, 01:08 AM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Media.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 */

class User_Confirm_Login extends Db
{
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'user_confirm_login';
        parent::__construct( $this->tableName );
    }
	 
    // END OF THIS CLASS
}