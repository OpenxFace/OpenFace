<?php
/**
 * BizLogic Base Framework
 * Direct Messages Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2017 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Sunday, July 16, 2017, 21:12 GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 */

class Direct_Messages extends Db
{
	public function __construct()
	{	    
	    $this->tableName = DB_TABLE_PREFIX.'direct_messages';
		parent::__construct( $this->tableName );
	}

	public function getConversation( $from = '', $to = '', $limit = 100, $offset = 0 )
    {
        $sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql .= "WHERE `from` = '".mysqli_real_escape_string( $this->db, $from )."' ";
        $sql .= "AND `to` = '".mysqli_real_escape_string( $this->db, $to )."' ";
        $sql .= "OR ";
        $sql .= "`to` = '".mysqli_real_escape_string( $this->db, $from )."' ";
        $sql .= "AND `from` = '".mysqli_real_escape_string( $this->db, $to )."' ";
        $sql .= "ORDER BY `date` DESC ";

        $limit	= (int)$limit;
        $offset = (int)$offset;
        $data	= array();

        if( ( $limit > 0 ) AND ( $offset >= 0 ) ) {
            $sql .= "LIMIT ".$offset.", ".$limit;
        } elseif ( $limit == 1 ) {
            $sql .= "LIMIT 1 ";
        }

        $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );

        if( mysqli_num_rows( $res ) > 0 ) {
            $User = new User;

            while( $row = mysqli_fetch_assoc( $res ) ) {
                // get the author
                $row['author']  = $User->fetchUserDetailsByUUID( $row['from'] );
                $data[]         = $row;
            }
        }

        $data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;

        return $data;
    }
	 
    // END OF THIS CLASS
}