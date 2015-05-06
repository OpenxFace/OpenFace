<?php
/**
 * Priceless PHP Base
 * Site Theme Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, September 24, 2013, 10:55 AM GMT+1 mknox
 * @edited      $Date: 2014-06-27 08:00:19 -0700 (Fri, 27 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Themes.php 62 2014-06-27 15:00:19Z hire@bizlogicdev.com $
 */

class Site_Theme extends Db
{	
    public function __construct()
    {
		$this->tableName = DB_TABLE_PREFIX.'site_theme';
		parent::__construct( $this->tableName );
    }
	
	/**
	 * Fetch Themes for Display 
	 * in the UI
	 * 
	 * @param  string  $orderBy
	 * @param  string  $sortOrder
	 * @param  int     $active
	 * @return array
	*/
	public function fetchThemesForDisplay( $orderBy = 'display_name', $sortOrder = 'ASC', $active = 1 )
	{		
		$sql = "SELECT * FROM ";
		$sql .= "`".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql .= "WHERE `active` = '".mysqli_real_escape_string( $this->db, $active )."'  ";
		$sql .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder )." ";
				
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = array();
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[$row['name']] = $row;
			}
			
			return $data;
		} else {
			return array();
		}
	}
	
	/**
	 * Fetch Bootstrap Themes 
	 * for Display in the UI
	 *
	 * @param  string  $orderBy
	 * @param  string  $sortOrder
	 * @return array
	*/
	public function fetchBootstrapThemesForDisplay( $orderBy = 'display_name', $sortOrder = 'ASC', $active = 1 )
	{
		$sql = "SELECT * FROM ";
		$sql .= "`".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql .= "WHERE `active` = '".mysqli_real_escape_string( $this->db, $active )."' ";
		$sql .= "AND `type` = 'bootstrap' ";
		$sql .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder )." ";
		
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = array();
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[$row['name']] = $row;
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
	/**
	 * Fetch Active Themes 
	 *
	 * @param  string  $orderBy
	 * @param  string  $sortOrder
	 * @return array
	*/
	public function fetchActiveThemes( $orderBy = 'display_name', $sortOrder = 'ASC' )
	{
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";	
		$sql .= "WHERE `active` = '1' ";
		$sql .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder )." ";
		
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		 
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;				
			}

			return $data;
			 		
		} else {
			return array();
		}		
	}

	/**
	 * Fetch All Themes
	 *
	 * @param  string  $orderBy
	 * @param  string  $sortOrder
	 * @return array
	*/
	public function fetchAllThemes( $orderBy = 'display_name', $sortOrder = 'ASC' )
	{
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";	
		$sql .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
		$sql .= mysqli_real_escape_string( $this->db, $sortOrder )." ";
		
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
			
			return $data;
				
		} else {
			return array();
		}
	}	
}