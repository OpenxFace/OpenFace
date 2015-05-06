<?php
/**
 * Priceless PHP
 * It's not free, it's priceless
 *
 * @author      MarQuis Knox <opensource@marquisknox.com>
 * @copyright   2015 MarQuis Knox
 * @link        http://marquisknox.com
 * @link        http://pricelessphp.com
 * @license     Affero General Public License v3
 *
 * @since  	    Wednesday, February 04, 2015, 16:25 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    Class
 * @package     Priceless PHP
*/

class Priceless
{
    /**
     * Make an embed responsive
     * 
     * @param   string  $string
     * @param   string  $targetWidth
     * @return  string
    */
    public function makeEmbedResponsive( $string, $targetWidth = '100%' )
    {
        $string = preg_replace(
            array( '/width="\d+"/i' ),
            array( sprintf( 'width="%s"', $targetWidth ) ),
            $string
        );
    
        return $string;
    }
    
    /**
     * Get the mime type based on 
     * the filename
     * 
     * @param   string  $file
     * @return  string
    */
    public function getMimeTypeFromFile( $file )
    {
        $mimeTypes = array(
            '3gp'   => 'video/3gpp',        
            'avi'   => 'video/x-msvideo',
            'css'   => 'text/css',           
            'doc'   => 'application/msword',
            'docx'  => 'application/msword',
            'exe'   => 'application/octet-stream',
            'gif'   => 'image/gif',        
            'htm'   => 'text/html',
            'html'  => 'text/html',
            'jpeg'  => 'image/jpg',
            'jpg'   => 'image/jpg',                
            'js'    => 'application/javascript',
            'jsc'   => 'application/javascript',
            'mp3'   => 'audio/mpeg',
            'mpe'   => 'video/mpeg',                
            'mpeg'  => 'video/mpeg',
            'mpg'   => 'video/mpeg',
            'mov'   => 'video/quicktime',
            'php'   => 'text/html',                                   
            'pdf'   => 'application/pdf',
            'png'   => 'image/png',        
            'ppt'   => 'application/vnd.ms-powerpoint',
            'wav'   => 'audio/x-wav',
            'xls'   => 'application/vnd.ms-excel',             
            'zip'   => 'application/zip',
        );
    
        $extension = strtolower( end( explode( '.', $file ) ) );
    
        return $mimeTypes[ $extension ];
    }   
    
    /**
     * Get the file extension 
     * based on the mime type
     *
     * @param   string  $mimeType
     * @return  string
    */
    public function getFileExtensionFromMimeType( $mimeType ) 
    {
        $extensions = array(
            'image/bmp'     => 'bmp',
            'image/gif'     => 'gif',
            'image/jpg'     => 'jpg',
            'image/jpeg'    => 'jpeg',        
            'image/png'     => 'png',        
            'text/xml'      => 'xml',
        );
    
        return $extensions[ $mimeType ];
    } 
 
    /**
     * Convert an integer to 
     * the corresponding month
     * 
     * @param   int     $integer
     * @return  mixed   boolean or string
    */
    public function integerToMonth( $integer )
    {
        $integer = (int)$integer;
        if( $integer == 0 ) {
            return false;    
        }
        
        return jdmonthname( gregoriantojd( $integer, 1, 1 ), CAL_MONTH_GREGORIAN_LONG );    
    } 
    
    /**
     * Remove traling slash 
     * from a string
     * 
     * @param   string  $string
     * @return  string
    */
    public function removeTrailingSlash( $string )
    {
        $string = rtrim( $string, '/' );
        return $string;    
    }   
    
    /**
     * Recursively delete a directory
     * 
     * @link    http://stackoverflow.com/a/3338133
     * @param   string  $dir
     * @param   boolean $deleteSelf
     * @return  mixed
    */
    public function recursive_rmdir( $dir, $deleteSelf = true ) 
    {
        if ( is_dir( $dir ) ) {
            $objects = scandir( $dir );
            foreach ( $objects AS $object ) {
                if ( ( $object != '.' ) AND ( $object != '..' ) ) {
                    if ( filetype( $dir.'/'.$object ) == 'dir' ) {
                        recursive_rmdir( $dir.'/'.$object );
                    } else {
                        unlink( $dir.'/'.$object );
                    }
                }
            }
        
            if( $deleteSelf ) {
                $result = unlink( $dir );
                return $result;
            }
        }
    }
    
    /**
     * Recursively copy a directory
     * 
     * @link    http://stackoverflow.com/a/7775949
     * @param   string  $source
     * @param   string  $target
     * @return  void
    */
    public function copyRecursive( $source, $target )
    {
        if( !file_exists( $target ) ) {
            mkdir( $target, 0755, true );
        }

        foreach (
            $iterator = new \RecursiveIteratorIterator(
                new \RecursiveDirectoryIterator( $source, \RecursiveDirectoryIterator::SKIP_DOTS),
                \RecursiveIteratorIterator::SELF_FIRST) AS $item
        ) {
            if ( $item->isDir() ) {
                $targetDir = $target . DIRECTORY_SEPARATOR . $iterator->getSubPathName();
                if( !file_exists( $targetDir ) ) {
                    mkdir( $targetDir );
                }
            } else {
                copy( $item, $target . DIRECTORY_SEPARATOR . $iterator->getSubPathName() );
            }
        }
    }

    /**
     * Slugify a string
     * 
     * @param   string  $string
     * @return  string
    */
    public function slugify( $string )
    {
        $string     = strtolower( $string );    
        $search     = array('_', "'", '!', 'ä', 'ö', 'ü');
        $replace    = array('-', '-', '', 'ae', 'oe', 'ue');
    
        // replace
        $string = str_replace( $search, $replace, $string );
    
        return $string;
    }
}
