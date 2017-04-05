<?php
/**
 * OpenFace
 * User Preferences
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Thursday, May 28, 2015, 16:08 GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class User_Preferences extends Db
{
	// START OF THIS CLASS	
	
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'user_preferences';
	    parent::__construct( $this->tableName );
	}
	
	/**
	 * Get grouped for a 
	 * specific User ID
	 *  
	 * @param  int     $userId
	 * @return boolean
	*/
	public function getGroupedByUserId( $userId = 0 )
	{
	    $result = array();
	    
        // get the user's preferences            	    
	    $sql = "SELECT * FROM ";
	    $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "WHERE `user_id` ";
	    $sql .= " = '".mysqli_real_escape_string( $this->db, (int)$userId ) ."' ";
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	    
        if( mysqli_num_rows( $res ) > 0 ) {
		    while( $row = mysqli_fetch_assoc( $res ) ) {
		        $result[ $row['name'] ] = $row['value'];		        
		    }   
		}
	    
	    return $result;
	}
	
	/**
	 * Update the user preferences 
	 * of the current user
	 *  
	 * @param  array   $data
	 * @return int
	*/
	public function updateSelf( $data = array() )
	{
	    $affectedRows = 0;

	    if( !empty( $data ) ) {
	        // User ID
	        $userId = (int)$_SESSION['user']['id'];
	        
	        // START:  Check if record exists
	        foreach( $data AS $key => $value ) {
	           $exists = $this->getBy( 
	               array(
                       'name'       => $key,
	                   'user_id'    => $userId
	               ) 
	           );
	           
	           if( $exists ) {
	               // delete existing records            	    
            	    $sql = "DELETE FROM ";
            	    $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
            	    $sql .= "WHERE `name` ";
            	    $sql .= " = '".mysqli_real_escape_string( $this->db, $key ) ."' ";
            	    $sql .= " AND `user_id` = '".mysqli_real_escape_string( $this->db, $userId ) ."' ";
            	
            	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	           }
	           
	           // add new record
	           $result = (int)$this->insert(
	               array(
	                   'name'       => $key,
	                   'value'      => $value,
	                   'user_id'    => $userId
	               )
	           );
	           
	           if( $result > 0 ) {
	               $affectedRows += 1;
	           }	           
	        }
	        // END:    Check if record exists
	    }
	    
	    return $affectedRows;	    
	}
}