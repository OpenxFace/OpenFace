<?php
/**
 * OpenFace
 * User Status Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, June 16, 2015, 10:51 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 * 
 * @category    Models
 * @package     OpenFace
*/

class User_Status extends Db
{
	// START OF THIS CLASS	
	
    protected $_Likes;
    
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'user_status';
	    parent::__construct( $this->tableName );
	    
	    $this->_Likes = new User_Status_Likes;
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
	    $sql = "INSERT INTO `".$this->tableName."` ( ";
	
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
	
	/**
	 * Get by Columns & Values
	 *
	 * @param	array	$attribues
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @return	array
	*/
	public function getBy( $attributes = array(), $limit = 1, $offset = 0, $orderBy = array() )
	{
	    if( empty( $attributes ) OR !is_array( $attributes ) ) {
	        return false;
	    }
	
	    // escape
	    foreach( $attributes AS $key => $value ) {
	        $attributes[$key] = mysqli_real_escape_string( $this->db, $value );
	    }
	
	    $i 			= 0;
	    $count		= count( $attributes );
	
	    $query = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $query .= "WHERE ";
	    
	    foreach( $attributes AS $key => $value ) {
	        $i++;
	        $query .= "`".$key."` = '".$value."' ";
	        if( $i < $count ) {
	            $query .= " AND ";
	        }
	    }
	
	    if( !empty( $orderBy ) ) {
	        $count 	= count( $orderBy );
	        $i		= 0;
	
	        $query .= "ORDER BY ";
	        foreach( $orderBy AS $orderKey => $orderValue ) {
	            $i++;
	
	            $query .= "`".mysqli_real_escape_string( $this->db, $orderKey )."` ";
	            $query .= mysqli_real_escape_string( $this->db, $orderValue )." ";
	
	            if( $i < $count ) {
	                $query .= ", ";
	            }
	        }
	    }
	
	    $limit	= (int)$limit;
	    $offset = (int)$offset;
	    $data	= array();
	
	    if( ( $limit > 0 ) AND ( $offset >= 0 ) ) {
	        $query .= "LIMIT ".$offset.", ".$limit;
	    } elseif ( $limit == 1 ) {
	        $query .= "LIMIT 1 ";
	    }
	
	    $res = mysqli_query( $this->db, $query ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$query.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	    
	    if( mysqli_num_rows( $res ) > 0 ) {
	        $User = new User;
	        
	        while( $row = mysqli_fetch_assoc( $res ) ) {
	            // like data
	            $row['has_liked'] = $this->_Likes->fetchLikeByUserId( $row['uuid'], $_SESSION['user']['uuid'] );
	            $row['like_data'] = $this->_Likes->fetchAllLikesByParentUUID( $row['uuid'] );
	            	            
	            // get the owner
	            $row['owner'] = $User->fetchUserDetailsByUUID( $row['user_uuid'] );
	            
	            // the final row
	            $data[] = $row;
	        }
	    }
	
	    $data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
	
	    return $data;
	}	
	
    // END OF THIS CLASS
}