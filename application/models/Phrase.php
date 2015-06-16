<?php
/**
 * BizLogic Base Framework
 * Site Phrases Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, October 08, 2013, 04:55 PM GMT+1 mknox
 * @edited      $Date: 2014-04-29 16:28:16 -0700 (Tue, 29 Apr 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Phrases.php 38 2014-04-29 23:28:16Z hire@bizlogicdev.com $
*/

class Phrase extends Db
{
    public function __construct()
    {     
        $this->tableName = DB_TABLE_PREFIX.'phrase';
        parent::__construct( $this->tableName );
    }
        
	public function fetchPhraseFromSession( $phrase )
	{	
		if( !isset( $_SESSION['site']['phrases'][$phrase] ) ) {
			return $phrase;	
		}	
		
		return $_SESSION['site']['phrases'][$phrase];
	}
	
	public function fetchAllPhrases( $orderBy = 'name', $sortOrder = 'ASC' )
	{
		$data	= array();
		
		$sql	= "SELECT * FROM ` ".mysqli_real_escape_string( $this->db, $this->tableName )."`  ";
		$sql   .= "ORDER BY ".mysqli_real_escape_string( $this->db, $orderBy )." ";
		$sql   .= mysqli_real_escape_string( $this->db, $sortOrder );
		
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_num_rows( $res ) > 0 ) {			
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}	
		}
		
		return $data;
	}
	 
	public function updateSitePhrases( $phrases )
	{
		if( empty( $phrases ) ) {
			return false;	
		}
						
		foreach( $phrases AS $key => $value ) {
			$sql  = "UPDATE ` ".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
			$sql .= "SET ";			
			$sql .= "`text` = '".mysqli_real_escape_string( $this->db, $value )."' ";
			$sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $key )."' ";
			$sql .= "LIMIT 1 ";
			
			$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );			
		}		

		return true;
	}	
    // END OF THIS CLASS
}