<?php
/**
 * BizLogic Base Framework
 * Core Library
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, November 27, 2012, 04:39 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Base.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 *
 * @category    Core
 * @package     BizLogic Base Framework
 */

class Base extends Db
{
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'site_config';
        parent::__construct( $this->tableName );
    }
        
    /**
     * Fetch site configuration from the DB
     *
     * @return  array
    */
    public function fetchSiteConfig()
    {
        $data   = array();

        $sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ) );

        if( mysqli_num_rows( $res ) > 0 ) {
            while( $row = mysqli_fetch_assoc( $res ) ) {
                $data[] = $row;
            }
        }

        return $data;
    }

    /**
     * define site configuration
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
}