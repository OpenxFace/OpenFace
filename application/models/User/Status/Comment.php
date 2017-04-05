<?php
/**
 * OpenFace
 * User Status Comment Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since       Sunday, June 28, 2015, 01:08 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 * 
 * @category    Models
 * @package     OpenFace
*/

class User_Status_Comment extends Db
{
	// START OF THIS CLASS	
	
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'user_status_comment';
	    parent::__construct( $this->tableName );
	} 
	
	/**
	 * Insert
	 *
	 * @param   array	$data
	 * @return  mixed
	*/
	public function insert( $data = array() )
	{	    
	    if( empty( $data ) ) {
	        return false;
	    }
	
	    // get column names for filtering
	    $columnNames = fetchColumns( $this->tableName );
	
	    // filter
	    foreach( $data AS $key => $value ) {
	        if( !in_array( $key, $columnNames ) ) {
	            unset( $data[$key] );
	        }
	    }
	
	    // check after filtering
	    if( empty( $data ) ) {
	        return false;
	    }	 

	    // UUID
	    if( !strlen( trim( @$data['uuid'] ) ) ) {
	        $data['uuid'] = uuid();	        
	    }
	    
	    // User UUID
	    $data['user_uuid'] = $_SESSION['user']['uuid'];
	    
	    // date
	    $data['date'] = $this->NOW;
	
	    $count	= count( $data );
	    $i		= 0;
	
	    // start the query
	    $sql = "INSERT IGNORE INTO `".$this->tableName."` ( ";
	
	    foreach( $data AS $key => $value ) {
	        $i++;
	        
	        $comma = ( $i < $count ) ? ', ' : ' ';
	        $key = mysqli_real_escape_string( $this->db, $key );
	        $sql .= "`".mysqli_real_escape_string( $this->db, $key )."` ".$comma;
	    }
	
	    $sql .= " ) VALUES ( ";
	
	    $i = 0;
	    
	    foreach( $data AS $key => $value ) {
	        $i++;
	        
	        $comma = ( $i < $count ) ? ', ' : ' ';
	        $value = mysqli_real_escape_string( $this->db, $value );
	        $sql .= "'".mysqli_real_escape_string( $this->db, $value )."' ".$comma;
	    }
	
	    $sql .= ");";
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_insert_id( $this->db );
	}

	public function fetchAllCommentsByParentUUID( $uuid )
	{
	    $sql    = "SELECT count(*) AS total FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql   .= "WHERE `parent_uuid` = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
	    	
	    $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
	    $likeData	= array();
	    $users		= array();
	    $data		= mysqli_fetch_assoc( $res );
	    $totalLikes = $data['total'];
	
	    $sql    = "SELECT u.* FROM `".DB_TABLE_PREFIX."user` u ";
	    $sql   .= "INNER JOIN `".mysqli_real_escape_string( $this->db, $this->tableName )."` l on u.uuid = l.user_uuid ";
	    $sql   .= "WHERE l.parent_uuid = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
	    $sql   .= "ORDER BY RAND() ";
	    $sql   .= "LIMIT 3 ";
	    	
	    $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
	    if( mysqli_num_rows( $res ) > 0 ) {
	        $users = array();
	        while( $row = mysqli_fetch_assoc( $res ) ) {
	            $users[] = array(
	                'name'     => $row['first_name'].' '.$row['last_name'],
	                'url_slug' => $row['url_slug'],
	            );
	        }
	    }
	
	    $likeData['count'] = $totalLikes;
	    $likeData['users'] = $users;
	
	    return $likeData;
	}
	
	public function fetchCommentByUserUUID( $uuid, $user_uuid )
	{
	    $sql    = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql   .= "WHERE `parent_uuid` = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
	    $sql   .= "AND `user_uuid` = '".mysqli_real_escape_string( $this->db, $user_uuid )."' ";
	    $sql   .= "LIMIT 1";
	    	
	    $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
	    if( mysqli_num_rows( $res ) > 0 ) {
	        return true;
	    }
	
	    return false;
	}	
	
	public function deleteByParentUUID( $uuid )
	{
	    $sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql   .= "WHERE `parent_uuid` = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
	    $sql   .= "AND `user_uuid` = '".mysqli_real_escape_string( $this->db, (int)$_SESSION['user']['uuid'] )."' ";
	    $sql   .= "LIMIT 1";
	    	
	    $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	    	
	    return mysqli_affected_rows( $this->db );
	}
	
	public function removeAllCommentsByParentUUID( $uuid )
	{
	    $sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql   .= "WHERE `parent_uuid` = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
	    $sql   .= "AND `type` = '".mysqli_real_escape_string( $this->db, $type )."' ";
	    	
	    $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	    	
	    return mysqli_affected_rows( $this->db );
	}	
	
    // END OF THIS CLASS
}