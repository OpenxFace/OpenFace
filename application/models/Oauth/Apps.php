<?php
/**
 * BizLogic Base Framework
 * Oauth Apps Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Friday, June 27, 2014, 06:55 AM GMT+1 mknox
 * @edited      $Date: 2014-06-14 09:21:49 -0700 (Sat, 14 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Apps.php 56 2014-06-14 16:21:49Z hire@bizlogicdev.com $
*/

class Oauth_Apps extends Db
{
	// START OF THIS CLASS	
	
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'oauth_apps';
	    parent::__construct( $this->tableName );
	}
	
	/**
	 * Insert Data
	 *
	 * @param   array	$data
	 * @return  mixed	int or boolean
	*/	
	public function insert( $data = array() )
	{
		if( empty( $data ) ) {
			return false;				
		}
		
		$id = (int)$this->_db->insert( $this->_tableName, $data );
		if( $id > 0 ) {
			return $id;	
		}
	}	
			
    /**
     * Get Data by ID
     *
     * @param   int		$id
     * @return  array
    */
    public function getById( $id )
    {
    	$this->_db->where( 'id', $id );
    	$data = $this->_db->getOne( $this->_tableName );
    	
    	return $data;
    }

    /**
     * Set Data by ID
     *
     * @param   int		$id
     * @return  boolean
    */    
    public function setById( $id, $data = array() )
    {
    	if( empty( $data ) ) {
			return false;				
		}
		
		$this->_db->where( 'id', $id );
		if( $this->_db->update( $this->_tableName, $data ) ) {
			return true; 
		}
    }   
    
    /**
     * Get Data by Column & Value
     *
     * @param   mixed	$value
     * @param	string	$column
     * @param	int		$limit
     * @return  array
    */    
    public function getBy( $value, $column, $limit = 1 )
    {
    	$this->_db->where( $column, $value );
    	if( (int)$limit == 1 ) {
    		$data = $this->_db->getOne( $this->_tableName );    		
    	} else {
    		$data = $this->_db->get( $this->_tableName );
    	}
    	
    	return $data;
    }
        
    /**
     * Set Data by Column & Value
     *
     * @param   string	$column
     * @param	mixed	$value
     * @param	array	$data
     * @param	int		$limit
     * @return  boolean
    */   
    public function setBy( $column, $value, $data = array(), $limit = 1 )
    {
		if( empty( $data ) ) {
			return false;				
		}
		
		$this->_db->where( $column, $value );
		if( $this->_db->update( $this->_tableName, $data ) ) {
			return true; 
		}
    }    
	
    // END OF THIS CLASS
}