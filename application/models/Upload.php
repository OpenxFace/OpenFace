<?php
/**
 * BizLogic Base Framework
 * Upload Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Monday, August 26, 2013, 22:09 GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Upload.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
*/

class Upload extends Db
{
	protected $_User;
	
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'user_status_media';
	    parent::__construct( $this->tableName );
	}

    /**
     * Add files to the DB
     *
     * @param   array	$data
     * @param   array	$uploadedFiles
     * @return  boolean
    */
    public function addFiles( $data = array() )
    {    		    	
        return $this->addUploadedFiles( $data );
    }
    
    public function addUploadedFiles( $data = array() )
    {
        return $this->insert( $data );
    }    
    
    public function handleTempFileUpload( $filePath, $fileData = array() ) 
    {    	
    	extract( $fileData );
    	    	
    	$fileExt	= strtolower( $fileExt );
    	$filename	= strtolower( $filename ).'.'.$fileExt;
    	$uuid		= ( isset( $uuid ) ) ? $uuid : '';    	
    	$tempPath	= BASEDIR.'/data/temp/'.$uuid;
    	$tempFile	= $tempPath.'/'.$filename;    	 
    	
    	if( !file_exists( $tempPath ) ) {
			mkdir( $tempPath, 0777, true );    		
    	}
    	 
    	$upload = rename( $filePath, $tempFile );
    	$json	= array();
    	
    	if( $upload ) {    		    	
			$json['status'] = 'OK';			
			return json_encode( $json );
    	} else {
    		$json['status']	= 'ERROR';
    		$json['error']	= 'FILE_UPLOAD';
    		
    		return json_encode( $json );    		
    	}    	
    }    	
    
    public function completeFileUpload( $uuid = '' )
    {    	    	
    	if( !strlen( $uuid ) ) {
    	    return false;
        }

		$tempPath	= BASEDIR.'/data/temp/'.$uuid;
		$files		= glob( $tempPath.'/*' );
        $json       = array(
            'status' => array(),
            'result' => array(),
        );

        if( !empty( $files ) ) {
            $fileDetails = array();
			$User_Status = new User_Status;

            foreach( $files AS $key => $value ) {

                $status = $User_Status->getBy(
			        array(
			            'uuid' => $uuid
                    )
                );

			    if( !empty( $status ) ) {
			        $owner = $status['user_uuid'];

			        if( strlen( $owner ) ) {
                        $rootDir                                = BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$owner.'/'.$uuid;
                        $destination                            = $rootDir.'/'.basename( $value );
                        $fileDetails[ $key ]['filename']        = basename( $value );
                        $fileDetails[ $key ]['filesize']        = bytesToHumanReadable( filesize( $value ) );
                        $fileDetails[ $key ]['filesize_bytes']  = filesize( $value );
                        $fileDetails[ $key ]['parent_uuid']     = $uuid;
                        $fileDetails[ $key ]['uuid']            = uuid();
                        $fileDetails[ $key ]['date']            = time();
                        $fileDetails[ $key ]['url']             = PROTOCOL_RELATIVE_URL.'/data/uploads/users/'.$owner.'/'.$uuid.'/'.basename( $value );
                        $fileDetails[ $key ]['filepath']        = $destination;
                        $fileDetails[ $key ]['mime_type']       = getMimeTypeFromFile( $fileDetails[ $key ]['filename'] );

                        if( !file_exists( $rootDir ) ) {
                            mkdir( $rootDir, 0777, true );
                        }

                        if( file_exists( $rootDir ) ) {
                            file_put_contents( $rootDir.'/.htaccess',  "allow from all\n" );
                            $move = rename( $value, $destination );
                        }

                        if( $move ) {
                            // insert in the DB
                            $dbId = (int)$this->addFiles( $fileDetails[ $key ] );

                            if( $dbId > 0 ) {
                                $json['status'][] = 'OK';
                                $json['result'][] = $dbId;
                            }
                        } else {
                            error_log( "[".date("m-d-Y, H:i:s")."] ERROR:  failed to move file ".$value."\n" );

                            $json['status'][] = 'ERROR';
                            $json['error'][]  = 'FILE_MOVE';
                        }
                    }
                }

            }

            deltree( $tempPath );
		}

        // return JSON
        return $json;

    }

}