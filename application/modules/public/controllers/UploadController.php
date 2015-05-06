<?php
/**
 * Priceless PHP Base
 * Upload Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Friday, June 28, 2013, 02:38 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: UploadController.php 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class UploadController extends Zend_Controller_Action
{
	protected $_accountStatus;
	protected $_Upload;
	
    public function init() 
    {    	
    	$this->_accountStatus	= $_SESSION['user']['site_status'];    	    	
    	$this->_Upload	= new Upload;
    }
    
    public function indexAction() 
    {
    	$this->_helper->viewRenderer->setNoRender( true );
    	// @link	http://framework.zend.com/manual/1.12/en/zend.controller.action.html#zend.controller.action.utilmethods
    	$this->_forward( 'index', 'index' );    	
    }
    
    public function ajaxAction()
    {
    	if( !in_array('can_upload', $_SESSION['site']['permissions']['upload'] ) ) {
    		$json			= array();
    		$json['status']	= 'ERROR';
    		$json['error']	= 'NO_PERMISSION';
    	
    		header( 'Content-type: application/json; charset=UTF-8' );
    		exit( json_encode( $json ) );
    	}
    	
    	switch( $this->_accountStatus ) {
    		case 'auto_confirmed':
    		case 'confirmed':
    			// OK; do nothing...
    	
    			break;
    	
    		default:
    			$json			= array();
    			$json['status']	= 'ERROR';
    			$json['error']	= 'ACCOUNT_STATUS_BAD';
    	
    			header( 'Content-type: application/json; charset=UTF-8' );
    			exit( json_encode( $json ) );
    	}
    	    	
    	// START:	chunk handling
    	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
    	header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
    	header('Cache-Control: no-store, no-cache, must-revalidate');
    	header('Cache-Control: post-check=0, pre-check=0', false);
    	header('Pragma: no-cache');
    	
    	$uuid				= trim( $_POST['uuid'] );
    	$cleanupTargetDir	= true;
    	$targetDir			= BASEDIR.'/data/temp/'.$uuid;
    	// Temp file age in seconds
    	$maxFileAge			= 5 * 3600;
    	$chunk				= isset( $_REQUEST['chunk'] ) ? intval( $_REQUEST['chunk'] ) : 0;
    	$chunks				= isset( $_REQUEST['chunks'] ) ? intval( $_REQUEST['chunks'] ) : 0;
    	 
    	// create target directory
    	if( !file_exists( $targetDir ) ) {
    		@mkdir( $targetDir, 0777, true );
    	}
    	 
    	// check for filename
    	if ( isset( $_REQUEST['name'] ) ) {
    		$fileName = $_REQUEST['name'];
    	} elseif (!empty($_FILES)) {
    		$fileName = $_FILES['file']['name'];
    	} else {
    		$fileName = uniqid('file_');
    	}
    	 
    	$filePath = $targetDir . DIRECTORY_SEPARATOR . $fileName;
    	 
    	// Remove old temp files
    	if( $cleanupTargetDir ) {
    		if ( !is_dir( $targetDir ) || !$dir = opendir( $targetDir ) ) {
    			die('{"jsonrpc" : "2.0", "error" : {"code": 100, "message": "Failed to open temp directory."}, "id" : "id"}');
    		}
    		 
    		while ( ( $file = readdir( $dir ) ) !== false) {
    			$tmpfilePath = $targetDir . DIRECTORY_SEPARATOR . $file;
    	
    			// if temp file is current file proceed to the next
    			if($tmpfilePath == "{$filePath}.part") {
    				continue;
    			}
    			 
    			// remove temp file if it is older than the max age and is not the current file
    			if (preg_match('/\.part$/', $file) && (filemtime($tmpfilePath) < time() - $maxFileAge)) {
    				@unlink($tmpfilePath);
    			}
    		}
    		 
    		closedir($dir);
    	}
    	 
    	// open temp file
    	if(!$out = @fopen("{$filePath}.part", $chunks ? "ab" : "wb")) {
    		die('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
    	}
    	
    	if( !empty( $_FILES ) ) {
    		if($_FILES["file"]["error"] || !is_uploaded_file($_FILES["file"]["tmp_name"])) {
    			die('{"jsonrpc" : "2.0", "error" : {"code": 103, "message": "Failed to move uploaded file."}, "id" : "id"}');
    		}
    		 
    		// read binary input stream and append it to temp file
    		if( !$in = @fopen( $_FILES["file"]["tmp_name"], "rb" ) ) {
    			die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
    		}
    	} else {
    		if (!$in = @fopen("php://input", "rb")) {
    			die('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
    		}
    	}
    	
    	while ($buff = fread($in, 4096)) {
    		fwrite($out, $buff);
    	}
    	
    	@fclose($out);
    	@fclose($in);
    	
    	// check if file has been uploaded
    	if( !$chunks || $chunk == $chunks - 1 ) {
    		// strip the temp .part suffix off
    		rename("{$filePath}.part", $filePath);
    	} else {
    		// return Success JSON-RPC response
    		exit( json_encode( array(
    				'chunk'			=> $_REQUEST['chunk'],
    				'totalChunks'	=> $_POST['chunks']
    		)
    		)
    		);
    	}
    	// END:		chunk handling
    	 
    	if( !empty( $_POST ) AND !empty( $_FILES ) ) {
    		if ( $_FILES['file']['error'] == UPLOAD_ERR_OK ) {
    			$fileData					= array();
    			$fileData['userId']			= (int)$_SESSION['user']['id'];
    			$fileData['tmp_name']		= $_FILES['file']['tmp_name'];
    	
    			if( isset( $_POST['uuid'] ) ) {
    				$fileData['uuid'] = $_POST['uuid'];
    			} elseif( isset( $_POST['UUID'] ) ) {
    				$fileData['uuid'] = $_POST['UUID'];
    			}
    	
    			$fileData['filename']		= fetchFilename( $_POST['name'] );
    			$fileData['fileExt']		= fetchFileExt( $_POST['name'] );
    			$fileData['uploader_ip'] 	= $_SERVER['REMOTE_ADDR'];
    	
    			$method = $_POST['method'];
    			
    			switch( $method ) {
    				case 'media-embed-thumb':    					
    					if( isAllowedThumbnailType( $fileData['fileExt'] ) ) {
    						header( 'Content-type: application/json; charset=UTF-8' );
    						exit( $this->_Upload->handleTempFileUpload( $filePath, $fileData ) );
    					} else {
    						$json			= array();
    						$json['status']	= 'ERROR';
    						$json['error']	= 'FILE_TYPE_NOT_PERMITTED';
    							
    						header( 'Content-type: application/json; charset=UTF-8' );
    						exit( json_encode( $json ) );
    					}
    					
    					break;
    					
    				default:
    					if( isAllowedFileType( $fileData['fileExt'] ) ) {
    						header( 'Content-type: application/json; charset=UTF-8' );
    						exit( $this->_Upload->handleTempFileUpload( $filePath, $fileData ) );
    					} else {
    						$json			= array();
    						$json['status']	= 'ERROR';
    						$json['error']	= 'FILE_TYPE_NOT_PERMITTED';
    						 
    						header( 'Content-type: application/json; charset=UTF-8' );
    						exit( json_encode( $json ) );
    					}	
    			}
    		} else {
    			$json			= array();
    			$json['status']	= 'ERROR';
    			$json['error']	= $_FILES['file']['error'];
    				
    			header( 'Content-type: application/json' );
    			exit( json_encode( $json ) );
    		}
    	} else {
    		header('Location: '.BASEURL);
    	}    	
    }
}