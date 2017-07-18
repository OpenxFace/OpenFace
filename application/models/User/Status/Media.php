<?php
/**
 * BizLogic Base Framework
 * User Media Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2017 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Saturday, July 15, 2017, 20:31 GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 */

class User_Status_Media extends Db
{
	public function __construct()
	{	    
	    $this->tableName = DB_TABLE_PREFIX.'user_status_media';
		parent::__construct( $this->tableName );
	}


    public function deleteByParentUuid( $parentUuid = '' )
    {
        $data = $this->getBy(
            array(
                'parent_uuid' => $parentUuid
            ),
            0
        );

        if( !empty( $data ) ) {

            foreach( $data AS $key => $value ) {
                if( is_file( $value['filepath'] ) ) {
                    unlink( $value['filepath'] );
                }
            }

            deltree( dirname( $value['filepath'] ) );

            $sql = "DELETE FROM ";
            $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
            $sql .= "WHERE `parent_uuid` = '".mysqli_real_escape_string( $this->db, $parentUuid )."' ";

            $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );

            return mysqli_affected_rows( $this->db );
        }
    }
	 
    // END OF THIS CLASS
}