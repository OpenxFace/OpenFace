<?php
/**
 * PricelessPHP Base
 * Site Permissions Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Pubic License v3
 *
 * @since       Staturday, August 31, 2013, 22:54 GMT+1 mknox
 * @edited      $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Permissions.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
 */

class Site_Permission extends Db
{
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'site_permission';
        parent::__construct( $this->tableName );
    }
        
	public function fetchSitePermissionsByUserId( $userId )
	{
		$userId	= (int)$userId;
		
		if( $userId > 0 ) {
			$sql    = "SELECT `usergroup_id` FROM `".mysqli_real_escape_string( $this->db, DB_TABLE_PREFIX.'usergroup_member' )."` ";
			$sql   .= "WHERE `user_id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
				
			$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
				
			if( mysqli_num_rows( $res ) > 0 ) {
				while( $row = mysqli_fetch_assoc( $res ) ) {
					$data[] = $row['usergroup_id'];
				}
					
				if( !empty( $data ) ) {
					return $this->fetchUsergroupPermissionsByUsergroupId( $data );
				}
			
			} else {
				return array();
			}			
		} else {
			return $this->fetchUsergroupPermissionsByUsergroupId( array( SITE_GUEST_USERGROUP_ID ) );	
		}	
	}
	
	public function fetchSitePermissionsExternal()
	{
		return array('site' => 'can_view_site');	
	}
	
	public function fetchAllSitePermissions()
	{
		$data = array();
		
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, DB_TABLE_PREFIX.'site_permissions' )."` ";			
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		} 
		
		return $data;
	}	

	public function fetchUsergroupPermissionsByUsergroupId( $usergroupId = array() )
	{
		if( !empty( $usergroupId ) ) {
			$groups	= implode ( ',', $usergroupId );			
		}
					
		$sql    = "SELECT `permission_id` FROM `".mysqli_real_escape_string( $this->db, DB_TABLE_PREFIX.'usergroup_permission' )."` ";
		$sql   .= "WHERE `usergroup_id` IN (".mysqli_real_escape_string( $this->db, $groups )."); ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row['permission_id'];
			}
						
			if( !empty( $data ) ) {
				$perms	=  implode ( ',', $data );
 				$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, DB_TABLE_PREFIX.'site_permission' )."` ";
 				$sql	.= "WHERE `id` IN (".mysqli_real_escape_string( $this->db, $perms )."); ";

 				$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
 				
 				if( mysqli_num_rows( $res ) > 0 ) {
 					$sitePerms = array();
 					while( $row = mysqli_fetch_assoc( $res ) ) {
 						$sitePerms[$row['permission_type']][] = $row['permission_name'];
 					}
 					 					
 					return $sitePerms;
 				} 				
			}	
		} else {
			return array();
		}
	}	
}