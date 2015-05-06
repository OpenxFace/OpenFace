<?php
/**
 * Priceless PHP Base
 * Language Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, November 27, 2012, 08:00 AM GMT+1 mknox
 * @edited      $Date: 2014-07-20 10:40:37 -0700 (Sun, 20 Jul 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Languages.php 66 2014-07-20 17:40:37Z hire@bizlogicdev.com $
*/

class Language extends Db
{    
    public static $_db;
    public static $_tableName;
    
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'language';        
        parent::__construct( $this->tableName );
        
        self::$_db          = Zend_Registry::get('DB_CONNECTION');
        self::$_tableName   = DB_TABLE_PREFIX.'language';
    }
        
	/**
	 * Fetch all language data
	 *
	 * @return  array
	*/
	public function fetchAllLanguages()
	{
		$data = array();
	
		$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
		}
		
		return $data;
	}
	
    /**
     * Fetch All Active Languages
     *
     * @return  array
    */
    public function fetchActive()
    {
        $data = array();
        $sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql .= "WHERE `active` = '1' ";
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
        if( mysqli_num_rows( $res ) > 0 ) {
            while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[] = $row;
            }
        }
    
        return $data;
    }
        
    /**
     * Fetch All Active Languages
     *
     * @return  array
    */
    public function fetchActiveLanguages()
    {
        return $this->fetchActive();
    }
		
    /**
     * Fetch language ID via locale string
     *
     * @param   string  $locale
     * @return  int
    */
    public function fetchLanguageIdByLocale( $locale )
    {
        $sql = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql .= "WHERE `iso_639` = '".mysqli_real_escape_string( $this->db, $locale )."' ";
        $sql .= "LIMIT 1 ";

        $res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );

        if( mysqli_num_rows( $res ) > 0 ) {
            $data = mysqli_fetch_assoc( $res );
            return $data['id'];
        }
    }
    
    /**
     * Determine if a language 
     * exists by ID
     *
     * @param   int     $id
     * @return  boolean
    */    
    public function languageExistsById( $id )
    {
    	$sql = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    	
    	if( mysqli_num_rows( $res ) > 0 ) {
			return true;
    	}    	
    }
    
    /**
     * Fetch friendly name 
     * by ID
     *
     * @param   int     $id
     * @return  string
    */
    public static function fetchFriendlyNameById( $id )
    {
    	$sql = "SELECT `friendly_name` FROM `".mysqli_real_escape_string( self::$_db, self::$_tableName )."` ";
    	$sql .= "WHERE `id` = '".mysqli_real_escape_string( self::$_db, $id )."' ";
    	$sql .= "LIMIT 1 ";
    
    	$res = mysqli_query( self::$_db, $sql ) OR die( mysqli_error( self::$_db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data['friendly_name'];
    	}
    }
    
    public function fetchNativeNameById( $id )
    {
    	$sql = "SELECT `native_name` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    	
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data['native_name'];
    	}
    }  
      
    public function fetchById( $id )
    {
    	$sql = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
    	$sql .= "LIMIT 1 ";
    	
    	$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    	
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data;
    	}
    }    
        
    /**
     * Fetch language ID via 
     * ISO-3166-1
     *
     * @link    http://en.wikipedia.org/wiki/ISO_3166-1
     * @param   string  $locale
     * @return  int
    */    
    public function fetchLanguageIdByIso31661( $locale )
    {
    	$sql = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql .= "WHERE `iso_3166_1` = '".mysqli_real_escape_string( $this->db, $locale )."' ";
    	$sql .= "LIMIT 1 ";   
    	
    	$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data['id'];
    	}
    }

    /**
     * Fetch language ID via
     * Locale ID
     *
     * @link    http://www.i18nguy.com/unicode/language-identifiers.html
     * @param   string  $code
     * @return  int
    */
    public function fetchLanguageIdByLocaleId( $localeId )
    {
        $sql    = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql   .= "WHERE `locale_id` = '".mysqli_real_escape_string( $this->db, $localeId )."' ";
        $sql   .= "LIMIT 1 ";
    
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
        if( mysqli_num_rows( $res ) > 0 ) {
            $data = mysqli_fetch_assoc( $res );
            return $data['id'];
        }
    }    

    /**
     * Fetch language ID via
     * ISO-639
     *
     * @link    http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
     * @param   string  $code
     * @return  int
    */
    public function fetchLanguageIdByIso369( $code )
    {
        $sql    = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql   .= "WHERE `iso_639` = '".mysqli_real_escape_string( $this->db, $code )."' ";
        $sql   .= "LIMIT 1 ";
    
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
        if( mysqli_num_rows( $res ) > 0 ) {
            $data = mysqli_fetch_assoc( $res );
            return $data['id'];
        }
    }
        
    /**
     * Fetch all phrases 
     * by language ID
     *
     * @param   int     $id
     * @return  array
    */
    public function fetchPhrasesByLanguageId( $id )
    {
        $data   = array();
        $sql    = "SELECT `name`, `text` FROM `".DB_TABLE_PREFIX."phrase` ";
        $sql   .= "WHERE `language_id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );

        if( mysqli_num_rows( $res ) > 0 ) {
            while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[ $row['name'] ] = $row['text'];
            }

            return $data;
        }
    }
    
    /**
     * Get all languages
     *
     * @return  array
    */
    public function getAll( $orderBy = array() )
    {
        $data   = array();
        
        $sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";        
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
        if( mysqli_num_rows( $res ) > 0 ) {
            while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[] = $row;
            }

            return $data;
        }
    }   

    /**
     * Get active languages
     *
     * @param   string  $orderBy
     * @param   string  $sortOrder
     * @return  array
    */
    public function getActive( $orderBy = 'native_name', $sortOrder = 'ASC' )
    {
        $data   = array();
        
        $sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $sql   .= "WHERE `active` = '1'  ";
        $sql   .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ";
        $sql   .= " ".mysqli_real_escape_string( $this->db, $sortOrder )." ";
    
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    
        if( mysqli_num_rows( $res ) > 0 ) {
            while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[] = $row;
            }

            return $data;
        }
    }    
}