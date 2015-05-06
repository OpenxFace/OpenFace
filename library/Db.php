<?php
/**
 * BizLogic Base Framework
 * DB Library
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Saturday, July 26, 2014, 08:19 PM GMT+1 mknox
 * @edited      $Date: 2014-08-03 23:49:06 +0200 (Sun, 03 Aug 2014) $ $Author: bizlogic $
 * @version     $Id: Db.php 44 2014-08-03 21:49:06Z bizlogic $
*/

class Db
{
	public $db;
	public $NOW;
	public $tableName;
	
	public function __construct( $tableName = '' )
	{
		$this->db         = Zend_Registry::get('DB_CONNECTION');
		$this->NOW        = time();
		$this->tableName  = trim( $tableName ); 
				
		if( !strlen( $this->tableName ) ) {
		    echo '<pre>';
		    trigger_error( 
                'Table name not specified:  '.debug_print_backtrace(), 
                E_USER_ERROR 
            );		    
		}
	}		

	/**
	 * Get by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/
	public function getById( $id )
	{
	    $data  = array();
	    $id    = (int)$id;

        if( isZero( $id ) ) {
            return $data;
        }	    
	    
	    $sql = "SELECT * FROM ";
	    $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id ) ."' ";
	    $sql .= "LIMIT 1 ";
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_fetch_assoc( $this->db, $res );
	}

	/**
	 * Update a record by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/	
	public function setById( $id = 0, $data = array() )
	{
	    return $this->updateById( $id, $data );
	}
	
	/**
	 * Update a record by ID
	 *
	 * @param	int		$id
	 * @return	array
	*/	
	public function updateById( $id = 0, $data = array() )
	{
	    if( isZero( $id ) ) {
	        return false;
	    }
	
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
	
	    $count	= count( $data );
	    $i		= 1;
	
	    $sql = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "SET ";
	
	    foreach( $data AS $key => $value ) {
	        $sql .= "`".mysqli_real_escape_string( $this->db, $key )."` = '".mysqli_real_escape_string( $this->db, $value )."' ";
	        	
	        if( $i < $count ) {
	            $sql .= ", ";
	        }
	        	
	        $i++;
	    }
	
	    $sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$id ) ."' ";
	    $sql .= "LIMIT 1 ";
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_affected_rows( $this->db );
	}	
	
	/**
	 * Update by column & value
	 *
	 * @param	string		$id
	 * @return	array
	*/
	public function updateBy( $name, $value, $limit = 1 )
	{
	    $limit = (int)$limit;
	    	    	     
	    // get column names for filtering
	    $columnNames = fetchColumns( $this->tableName );
	     
	    // filter
        if( !in_array( $name, $columnNames ) ) {
            return false;
        }
	
	    $sql = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "SET ";
	    $sql .= " `".mysqli_real_escape_string( $this->db, $name )."` ";
	    $sql .= " = '".mysqli_real_escape_string( $this->db, $value )."' ";	
	    $sql .= "WHERE `".mysqli_real_escape_string( $this->db, $name )."` ";
	    $sql .= " '".mysqli_real_escape_string( $this->db, $value )."' ";
	    
        if( $limit >= 1 ) {
            $sql .= "LIMIT ";
            $sql .= mysqli_real_escape_string( $this->db, $limit );
        }
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_affected_rows( $this->db );
	}
		
	/**
	 * Get records
	 * 
	 * @param	int		$limit
	 * @param	int		$offset
	 * @param	array	$orderBy
	 * @return	array
	*/
	public function get( $limit = null, $offset = null, $orderBy = array( ) )
	{		
	    $data  = array();
	    
		$query = "SELECT * FROM ";
		$query .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		
		if( !empty( $orderBy ) ) {
			$count 	= count( $orderBy );
			$i		= 0;
			
			$query .= "ORDER BY ";
			foreach( $orderBy AS $orderKey => $orderValue ) {
				$i++;
				$query .= "`".$orderKey."` ".$orderValue." ";
				
				if( $i < $count ) {
					$query .= ", ";	
				}
			}
		}
		
		$limit	= (int)$limit;
		$offset = (int)$offset;
		
		if( ( $limit > 0 ) AND ( $offset > 0 ) ) {
			$query .= "LIMIT ".$offset.", ".$limit;	
		}

		$res  = mysqli_query( $this->db, $query ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$query.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
		    while( $row = mysqli_fetch_assoc( $res ) ) {
		        $data[] = $row;		        
		    }   
		}
	
		return $data;
	}
	
	public function count()
	{
		$query = "SELECT COUNT(*) AS `count` FROM ";
		$query .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		
		$res	= mysqli_query( $this->db, $query ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$query.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );		
		$data	= mysqli_fetch_assoc( $res );
		
		return $data['count'];		
	}
	
	public function countBy( $column, $value )
	{
		$column = mysqli_real_escape_string( $this->db, $column );
		$value	= mysqli_real_escape_string( $this->db, $value ); 
		
		$query = "SELECT COUNT(*) AS `count` FROM ";
		$query .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$query .= "WHERE `".$column."` = '".$value."' ";
				
		$res	= mysqli_query( $this->db, $query ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$query.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
		$data	= mysqli_fetch_assoc( $res );
		
		return $data['count'];
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
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;	
			}	
		}
		
		$data = ( ( $limit == 1 ) AND isset( $data[0] ) ) ? $data[0] : $data;
		
		return $data;
	}
	
	/**
	 * Get all records 
	 * 
	 * @param	array	$orderBy
	 * @return	array
	*/
	public function getAll( $orderBy = array() )
	{
        return $this->get( null, null, $orderBy );	
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
	 * Delete by ID
	 *
	 * @param	int	$id
	 * @return	boolean
	*/
	public function deleteById( $id = 0 )
	{
	    $id = (int)$id;
	    
	    if( isZero( $id ) ) {
	        return false;
	    }

	    $sql = "DELETE FROM ";
	    $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
	    $sql .= "LIMIT 1 ";
		
        $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
		
		return mysqli_affected_rows( $this->db );		
	}

	/**
	 * Delete by column & value
	 *
	 * @param  name    $string
	 * @param  mixed   $value   
	 * @param  int     $limit
	 * @return int
	*/
	public function deleteBy( $name, $value, $limit = 1 )
	{
	    $limit = (int)$limit;
	    
	    $sql = "DELETE FROM ";
	    $sql .= " `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= "WHERE `".mysqli_real_escape_string( $this->db, $name )."` ";
	    $sql .= " = '".mysqli_real_escape_string( $this->db, $value ) ."' ";
	    
	    if( $limit >= 1 ) {
	        $sql .= "LIMIT ";
	        $sql .= " = '".mysqli_real_escape_string( $this->db, $limit ) ."' ";
	    }
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_affected_rows( $this->db, $res );
	}	

	/**
	 * Delete by UUID
	 *
	 * @param	string	$uuid
	 * @return	int
	*/
	public function deleteByUUID( $uuid )
	{
        return $this->deleteBy( 'uuid', $uuid, 1 );
	}	
	
	/**
	 * Set by UUID
	 *
	 * @param	string	$uuid
	 * @param	$data	array
	 * @return	boolean
	*/
	public function setByUUID( $uuid, $data = array() )
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
	
	    $count	= count( $data );
	    $i		= 1;
	
	    $sql = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
	    $sql .= " SET ";
	
	    foreach( $data AS $key => $value ) {
	        $sql .= "`".mysqli_real_escape_string( $this->db, $key )."` = '".mysqli_real_escape_string( $this->db, $value )."' ";
	        	
	        if( $i < $count ) {
	            $sql .= ", ";
	        }
	        	
	        $i++;
	    }
	
	    $sql .= "WHERE `uuid` = '".mysqli_real_escape_string( $this->db, $uuid ) ."' ";
	    $sql .= "LIMIT 1 ";
	
	    $res = mysqli_query( $this->db, $sql ) OR die( '<pre>SQL Error:  '.mysqli_error( $this->db ).'<br>SQL:  '.$sql.'<br>File:  '.__FILE__.'<br>Line:  '.__LINE__ );
	
	    return mysqli_affected_rows( $this->db );
	}
	
	/**
	 * Get by UUID
	 *
	 * @param	string	$uuid
	 * @return	array
	*/
	public function getByUUID( $uuid )
	{
	    $data = $this->getBy( 
	        array( 'uuid' => $uuid ) 
        );
	    
	    if( !empty( $data ) ) {
	        return $data['uuid'];
	    }

	    return array();
	}
	
	/**
	 * Get name by ID
	 *
	 * @param	int		$id
	 * @return	string
	*/
	public function getNameById( $id )
	{
	    $data = $this->getById( $id );
	    if( !empty( $data ) ) {
	        return $data['name'];
	    }

	    return '';
	}
	
	/**
	 * Get UUID by ID
	 *
	 * @param	int		$id
	 * @return	string
	*/
	public function getUUIDById( $id = 0 )
	{
	    $data = $this->getById( $id );
	    if( !empty( $data ) ) {
	        return $data['uuid'];
	    }

	    return '';
	}
	
}