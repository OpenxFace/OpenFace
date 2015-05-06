<?php
/**
 * Priceless PHP Base
 * Usergroup Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Staturday, August 31, 2013, 23:03 GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Usergroups.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
*/

class Usergroup extends Db
{
    private $_columnNames;
        
    public function __construct()
    {
        $this->tableName    = DB_TABLE_PREFIX.'usergroup';
        $this->_columnNames	= fetchColumnNames( $this->tableName );
                
        parent::__construct( $this->tableName );
	}
	
	public function fetchUsergroupPermissionsById( $id )
	{
		$data = array();
		
		$sql = "SELECT * FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
		$sql .= "WHERE `usergroup_id` = '".mysqli_real_escape_string( $this->db, (int)$id )."' ";
			
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
			
			return $data;
		} else {
			return array();
		}		
	}
	
	public function updateUsergroupPermissionsById( $id, $data = array() )
	{
		$id = (int)$id;
		
		if( empty( $data ) ) {
			$sql = "DELETE FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
			$sql .= "WHERE `usergroup_id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
			
			$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
			return true;
		}
		
		$existingPerms	= $this->fetchUsergroupPermissionsById( $id );
		$permIds		= array();
		$newPermIds 	= array();
		
		if( !empty( $existingPerms ) ) {
			// START:	fetch existing permissions			
			foreach( $existingPerms AS $key => $value ) {
				$permIds[] = $value['permission_id'];
			}
			// END:		fetch existing permissions

			// START:	fetch new permissions
			foreach( $data AS $key => $value ) {
				$newPermIds[] = $value;
			}
			// END:		fetch new permissions
			
			// compare arrays
			$diff = array_diff( $permIds, $newPermIds );
			
			// START:	remove perms
			if( !empty( $diff ) ) {
				foreach( $diff AS $key => $value ) {
					$sql = "DELETE FROM `".DB_TABLE_PREFIX."usergroup_permission` ";
					$sql .= "WHERE `permission_id` = '".mysqli_real_escape_string( $this->db, (int)$value )."' ";
					$sql .= "AND `usergroup_id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
					$sql .= "LIMIT 1";
						
					$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );					
				}
			}
			// END:		remove perms
		}
			
	
		foreach( $data AS $key => $value ) {		
			$sql = "INSERT IGNORE INTO `".DB_TABLE_PREFIX."usergroup_permission` ( ";
			$sql .= "`usergroup_id`, `permission_id` ";
			$sql .= ") VALUES ( ";
			$sql .= "'".mysqli_real_escape_string( $this->db, $id )."', ";
			$sql .= "'".mysqli_real_escape_string( $this->db, (int)$value )."' ";
			$sql .= ") ";
			
			$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );			
		}
	
		return mysqli_affected_rows( $this->db );
	}	
	
	public function updateUsergroupById( $id, $data = array() )
	{
		if( empty( $data ) ) {
			return false;	
		}
		
		// START:	filter input
		foreach( $data AS $key => $value ) {
			if( !in_array( $key, $this->_columnNames ) ) {
				unset( $data[$key] );
			}
		}
		// END:		filter input
			
		if( empty( $data ) ) {
			return false;
		}		
		
		$count	= count( $data );
		$i		= 1;
		
		$sql    = "UPDATE `".DB_TABLE_PREFIX."usergroup` SET ";
		
		foreach( $data AS $key => $value ) {
			$sql .= "`".mysqli_real_escape_string( $this->db, $key )."` = '".mysqli_real_escape_string( $this->db, $value )."' ";
			
			if( $i < $count ) {
				$sql .= ", ";	
			}
			
			$i++;			
		}
		
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$id )."' ";
		$sql   .= "LIMIT 1 ";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		return mysqli_affected_rows( $this->db );
	}
		
	public function deleteUsergroupById( $id )
	{
		$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\n".$sql );
		
		return mysqli_affected_rows( $this->db );		
	}
	
	public function fetchAllUsergroups( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$data = array();
			
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql .= "ORDER BY ".mysqli_real_escape_string( $this->db, $orderBy )." ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder )." ";
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
	
		return $data;
	}

	public function fetchUsergroupById( $id )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );				
			return $data;
		} else {
			return array();
		}
	}	
		
	public function fetchUsergroupsByUserId( $userId )
	{
		$sql    = "SELECT `usergroup_id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `user_id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
		 
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		 
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row['usergroup_id'];				
			}
			
			return $data;
			 		
		} else {
			return array();
		}		
	}

	public function setUsersUsergroupById( $userId, $usergroupId )
	{
		$sql    = "UPDATE `".DB_TABLE_PREFIX."usergroup_member` ";
		$sql   .= "SET `usergroup_id` = '".mysqli_real_escape_string( $this->db, (int)$usergroupId )."' ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );		
		
		return mysqli_affected_rows( $this->db );
	}	
}