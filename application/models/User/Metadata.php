<?php
/**
 * OpenFace
 * User Metadata
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2017 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Sunday, June 25, 2017, 09:46 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 */

class User_Metadata extends Db
{
    // START OF THIS CLASS

    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'user_metadata';
        parent::__construct( $this->tableName );
    }

}