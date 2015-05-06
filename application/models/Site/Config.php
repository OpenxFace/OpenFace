<?php
/**
 * BizLogic Base Framework
 * Site Config Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, October 08, 2013, 04:39 PM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Config.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
*/

class Site_Config extends Db
{
	// START OF THIS CLASS	

    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'site_config';
        parent::__construct( $this->tableName );
    }
    
	/**
	 * Fetch site configuration
	 *
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return  array
	*/
	public function fetchSiteConfig( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$data = array();
	
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql .= "WHERE `editable` = '1' ";
		$sql .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder );
		
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				if( $row['name'] != 'site_version' ) {
					$data[] = $row;					
				}
			}
		}	
	
		return $data;
	}
	
	/**
	 * Fetch site config grouped by 
	 * category
	 * 
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return  array
	*/
	public function fetchSiteConfigGrouped( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$groupedData = array();
		$data = $this->fetchSiteConfig( $orderBy, $sortOrder );
		
		if( !empty( $data ) ) {
			foreach( $data AS $key => $value ) {
				if( !isset( $groupedData[$value['category']] ) ) {
					$groupedData[$value['category']] = array();
				}
				
				$groupedData[$value['category']][] = $value;
			}
			
			ksort( $groupedData, SORT_STRING );
		}
		
		return $groupedData;
	}
		
	/**
	 * Fetch Site Config Categories
	 *
	 * @param	string	$orderBy
	 * @param	string	$sortOrder
	 * @return  array
	*/
	public function fetchSiteConfigCategories( $orderBy = 'category', $sortOrder = 'ASC' )
	{
		$data   = array();
	
		$sql    = "SELECT DISTINCT `category` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql   .= mysqli_real_escape_string( $this->db, $sortOrder );
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[] = $row['category'];
			}
		}
	
		return $data;
	}	
	
	/**
	 * Define the Site Config
	 * 
	 * @return void
	*/
	public function defineSiteConfig()
	{
		$config = $this->fetchSiteConfig();
	
		if( !empty( $config ) ) {
			foreach( $config AS $key => $value ) {
			    if( preg_match( '/__BASEURL__/', $value['value'] ) ) {
			        $value['value'] = str_replace( '__BASEURL__', PROTOCOL_RELATIVE_URL, $value['value'] );
			    }
			    
				define( strtoupper( $value['name'] ), $value['value'] );
			}
		}
	}

	/**
	 * Update Site Config
	 *
	 * @param	array	$config
	 * @param	string	$sortOrder
	 * @return  int
	*/
	public function updateSiteConfig( $config = array() )
	{
		if( empty( $config ) ) {
			return false;
		}
		
		$affectedRows = array();
	
		foreach( $config AS $key => $value ) {
			$sql  = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
			$sql .= "SET ";
			$sql .= "`value` = '".mysqli_real_escape_string( $this->db, strip_all_slashes( $value ) )."' ";
			$sql .= "WHERE `name` = '".mysqli_real_escape_string( $this->db, $key )."' ";
			$sql .= "LIMIT 1 ";
				
			$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
			
			// affected rows
			$affectedRows[] = mysqli_affected_rows( $this->db );
		}
	
		return array_sum( $affectedRows );
	}	
	
    // END OF THIS CLASS
}