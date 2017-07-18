<?php
/**
 * BizLogic Base Framework
 * Datatables
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2017 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Saturday, July 15, 2017, 11:28 AM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
*/

class Datatables extends Db
{

    public function __construct( $tableName = '' )
    {
        $this->tableName = DB_TABLE_PREFIX.$tableName;
        parent::__construct( $this->tableName );
    }

    /**
     * Fetch DB Data for DataTables
     *
     * @link	http://datatables.net/release-datatables/examples/data_sources/server_side.html
     * @param	array	$params
     * @return	array
    */
    public function get( $params = array(), $aColumns = array(), $sIndexColumn = 'id' )
    {
        if( empty( $params ) ) {
            return array();
        }

        extract( $params );

        /* DB table to use */
        $sTable = $this->tableName;

        /*
         * Paging
        */
        $sLimit = '';

        if ( isset( $start ) && $length != '-1' ) {
            $sLimit = "LIMIT ".mysqli_real_escape_string( $this->db, $start ).", ".
                mysqli_real_escape_string( $this->db, $length );
        }

        /**
         * Ordering
        */
        $sOrder = '';

        if ( isset( $params['order'] ) ) {
            $sOrder = "ORDER BY  ";

            for ( $i = 0; $i < count( $params['order'] ); $i++ ) {
                if ( $params['columns'][ $i ]['orderable'] == 'true' ) {
                    $sOrder .= "`".$aColumns[ intval( $params['order'][ $i ]['column'] ) ]."` ".
                        ( $params['order'][ $i ]['dir'] === 'asc' ? 'asc' : 'desc') .", ";
                }
            }

            $sOrder = substr_replace( $sOrder, '', -2 );

            if ( $sOrder == 'ORDER BY' ) {
                $sOrder = '';
            }
        }

        /**
         * Filtering
         * NOTE this does not match the built-in DataTables filtering which does it
         * word by word on any field. It's possible to do here, but concerned about efficiency
         * on very large tables, and MySQL's regex functionality is very limited
        */
        $sWhere = '';

        if ( isset( $params['search'] ) ) {

            $sWhere = "WHERE (";

            for ( $i = 0; $i < count( $aColumns ); $i++ ) {
                $sWhere .= $aColumns[ $i ]." LIKE '%".mysqli_real_escape_string( $this->db, $params['search']['value'] )."%' OR ";
            }

            $sWhere = substr_replace( $sWhere, "", -3 );
            $sWhere .= ')';
        }

        /* Individual column filtering */
        for ( $i = 0; $i < count( $aColumns ); $i++ ) {
            if ( isset( $params['columns'][ $i ]['searchable'] ) &&
                $params['columns'][ $i ]['searchable'] == 'true' &&
                $params['columns'][ $i ]['search']['value'] != '' ) {
                if ( $sWhere == '' ) {
                    $sWhere = 'WHERE ';
                } else {
                    $sWhere .= ' AND ';
                }

                $sWhere .= "`".$aColumns[ $i ]."` LIKE '%".mysqli_real_escape_string( $this->db, $params['columns'][ $i ]['search']['value'] )."%' ";
            }
        }

        /*
         * SQL queries
        * Get data to display
        */
        $sQuery	= "SELECT SQL_CALC_FOUND_ROWS ".str_replace(" , ", " ", implode(", ", $aColumns) )." FROM ";
        $sQuery .= $sTable." ";
        $sQuery .= $sWhere." ";
        $sQuery .= $sOrder." ";
        $sQuery .= $sLimit;

        $rResult = mysqli_query( $this->db, $sQuery ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sQuery.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );

        /* Data set length after filtering */
        $sQuery				= "SELECT FOUND_ROWS()";
        $rResultFilterTotal = mysqli_query( $this->db, $sQuery ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sQuery.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
        $aResultFilterTotal = mysqli_fetch_array( $rResultFilterTotal );
        $iFilteredTotal		= $aResultFilterTotal[0];

        /* Total data set length */
        $sQuery			= "SELECT COUNT(".$sIndexColumn.") FROM $sTable";
        $rResultTotal	= mysqli_query( $this->db, $sQuery ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
        $aResultTotal	= mysqli_fetch_array( $rResultTotal );
        $iTotal			= $aResultTotal[0];

        /*
         * Output
        */
        $output = array(
            'draw'              => (int)$params['draw'],
            'recordsTotal'      => $iTotal,
            'recordsFiltered'	=> $iFilteredTotal,
            'data'              => array()
        );

        while ( $aRow = mysqli_fetch_array( $rResult ) ) {
            $row = array();
            for ( $i = 0; $i < count( $aColumns ); $i++ ) {
                switch( $aColumns[$i] ) {
                    case 'site_language':
                        $row[] = $this->_Language->fetchFriendlyNameById( $aRow[ $aColumns[$i] ] );

                        break;

                    case 'last_ip':
                    case 'signup_ip':
                    case 'username':
                        $row[] = ( strlen( $aRow[ $aColumns[$i] ] ) ) ? $aRow[ $aColumns[$i] ] : '-';

                        break;

                    default:
                        // general output
                        $row[] = $aRow[ $aColumns[$i] ];
                }
            }

            $output['aaData'][] = $row;
        }

        return $output;
    }

}