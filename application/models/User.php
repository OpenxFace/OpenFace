<?php
/**
 * BizLogic Base Framework
 * User Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Thursday, November 29, 2012, 09:51 AM GMT+1 mknox
 * @edited      $Date: 2014-06-27 08:02:12 -0700 (Fri, 27 Jun 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: Users.php 63 2014-06-27 15:02:12Z hire@bizlogicdev.com $
*/

class User extends Db
{
	private $columnNames;
	protected $_Language;
	protected $_Usergroup;
	protected $_Site_Permission;
	
	public function __construct()
	{
	    $this->tableName = DB_TABLE_PREFIX.'user';	    
	    parent::__construct( $this->tableName );

	    $this->_columnNames       = fetchColumnNames( $this->tableName );
		$this->_Language          = new Language;
		$this->_Usergroup         = new Usergroup;
		$this->_Site_Permission   = new Site_Permission;		
	}
	
	/*
	 * Fetch DB Data for DataTables
	*
	* @link	http://datatables.net/release-datatables/examples/data_sources/server_side.html
	* @param	array	$params
	* @return	array
	*/
	public function fetchDataForDataTables( $params )
	{
		if( empty( $params ) ) {
			return array();
		}
	
		extract( $params );
	
		/* Array of database columns which should be read and sent back to DataTables. Use a space where
		 * you want to insert a non-database field (for example a counter or static image)
		*/
		$aColumns = array(	
		    'email',
            'username',
            'site_language',
            'site_status',
            'date_created',
            'last_upload',
            'last_active',
            'last_login_date',
            'signup_ip',
            'last_ip',
            'id'
		);
	
		/* Indexed column (used for fast and accurate table cardinality) */
		$sIndexColumn = 'id';
	
		/* DB table to use */
		$sTable = $this->tableName;
	
		/*
		 * Paging
		*/
		$sLimit = '';
		if ( isset( $iDisplayStart ) && $iDisplayLength != '-1' ) {
			$sLimit = "LIMIT ".mysqli_real_escape_string( $this->db, $iDisplayStart ).", ".
					mysqli_real_escape_string( $this->db, $iDisplayLength );
		}
	
		/*
		 * Ordering
		*/
		$sOrder = '';
		if ( isset( $params['iSortCol_0'] ) ) {
			$sOrder = "ORDER BY  ";
			for ( $i=0; $i < intval( $params['iSortingCols'] ); $i++ ) {
				if ( $params[ 'bSortable_'.intval( $params['iSortCol_'.$i] ) ] == 'true' ) {
					$sOrder .= "`".$aColumns[ intval( $params['iSortCol_'.$i] ) ]."` ".
							( $params['sSortDir_'.$i] === 'asc' ? 'asc' : 'desc') .", ";
				}
			}
				
			$sOrder = substr_replace( $sOrder, '', -2 );
			if ( $sOrder == 'ORDER BY' ) {
				$sOrder = '';
			}
		}
	
		/*
		 * Filtering
		* NOTE this does not match the built-in DataTables filtering which does it
		* word by word on any field. It's possible to do here, but concerned about efficiency
		* on very large tables, and MySQL's regex functionality is very limited
		*/
		$sWhere = '';
		if ( $sSearch != '' ) {
			$sWhere = "WHERE (";
			for ( $i = 0; $i < count( $aColumns ); $i++ ) {
				$sWhere .= $aColumns[$i]." LIKE '%".mysqli_real_escape_string( $this->db, $sSearch )."%' OR ";
			}
				
			$sWhere = substr_replace( $sWhere, "", -3 );
			$sWhere .= ')';
		}
	
		/* Individual column filtering */
		for ( $i = 0; $i < count( $aColumns ); $i++ ) {
			if ( isset( $params['bSearchable_'.$i] ) &&
					$params['bSearchable_'.$i] == 'true' &&
					$params['sSearch_'.$i] != '' ) {
				if ( $sWhere == '' ) {
					$sWhere = 'WHERE ';
				} else {
					$sWhere .= ' AND ';
				}
	
				$sWhere .= "`".$aColumns[$i]."` LIKE '%".mysqli_real_escape_string( $this->db, $params['sSearch_'.$i] )."%' ";
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
	
		$rResult = mysqli_query( $this->db, $sQuery ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		/* Data set length after filtering */
		$sQuery				= "SELECT FOUND_ROWS()";
		$rResultFilterTotal = mysqli_query( $this->db, $sQuery ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
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
		$output = array('sEcho'					=> intval( $sEcho ),
						'iTotalRecords'			=> $iTotal,
						'iTotalDisplayRecords'	=> $iFilteredTotal,
						'aaData'				=> array()
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
		
	public function removeOwnTempAvatar()
	{
		$files = glob( BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/avatar-wideImageTemp.*' );
		
		if( !empty( $files ) ) {
			foreach( $files AS $filename ) {
				@unlink( $filename );
			}			
		}

		$files = glob( BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/avatar-temp.*' );
		
		if( !empty( $files ) ) {
			foreach( $files AS $filename ) {
				@unlink( $filename );
			}
		}		
		
		return true;
	}	
	
	public function changeOwnAvatar()
	{
		$dir	= BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'];
		$files	= glob( $dir.'/avatar-temp.*' );
				
		if( !empty( $files ) ) {
			$fileExt = fetchFileExt( $files[0] );
			rename( $files[0], $dir.'/avatar.'.$fileExt );

			if( file_exists( $dir.'/avatar.'.$fileExt ) ) {
				$url = PROTOCOL_RELATIVE_URL.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/avatar.'.$fileExt;
				$this->updateUserById( $_SESSION['user']['id'], array( 'avatar_url' => $url ) );
				$this->removeOwnTempAvatar();
				
				return array('status' => 'OK', 'url' => $url );
			}
		}
	
		return false;
	}	
	
	public function uploadOwnAvatar() 
	{		
		if( !empty( $_FILES ) ) {
			if( $_FILES['myNewAvatar']['error'] == UPLOAD_ERR_OK ) {
				if( !is_image( $_FILES['myNewAvatar']['tmp_name'] ) ) {
					return array( 'status' => 'error', 'error' => 'NOT_IMAGE' );
				}
				
				$fileExt			= strtolower( fetchFileExt( $_FILES['myNewAvatar']['name'] ) );
				$wideImage			= 'avatar-wideImageTemp.'.$fileExt;
				$filename			= 'avatar-temp.'.$fileExt;
				$destinationTemp	= BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/'.$wideImage;				
				$destination		= BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/'.$filename;
				
				$moved = move_uploaded_file( $_FILES['myNewAvatar']['tmp_name'], $destinationTemp );
				
				if( $moved ) {
					if( $fileExt != 'gif' ) {
						require_once('WideImage/WideImage.php');						
						WideImage::load( $destinationTemp )->resize( SITE_AVATAR_WIDTH, SITE_AVATAR_HEIGHT, 'inside' )->saveToFile( $destination );												
					} else {
						rename( $destinationTemp, $destination );	
					}
					
					unlink( $destinationTemp );
					
					return array('status' => 'OK',
								 'url' => BASEURL.'/'.SITE_UPLOAD_DIR_USERS.'/'.$_SESSION['user']['id'].'/'.$filename 
					);						
				} else {
					return array( 'status' => 'error', 'error' => 'UPLOAD', 'error_code' => 'UPLOAD_FAILED' );
				}				
			}			
		} else {
			return array( 'status' => 'error', 'error' => 'NO_FILE_UPLOADED', 'error_code' => $_FILES['myNewAvatar']['error'] );
		}
	}
	
	public function banUserById( $userId )
	{
		$sql    = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "SET `site_status` = 'banned' ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		return $this->_Usergroup->setUsersUsergroupById( $userId, 0 );
	}
	
	public function deleteUserById( $userId )
	{
		$userId = (int)$userId;
		if( $userId == 0 ) {
			return;	
		}
		
		$media = $this->_User_Media->fetchAllMediaIdsByUserId( $userId );
		
		if( !empty( $media ) ) {
			$this->_User_Media->deleteMultipleMediaById( $media );			
		}
		
		@delTree( BASEDIR.'/'.SITE_UPLOAD_DIR_USERS.'/'.$userId );
				
		$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
		$sql   .= "LIMIT 1 ";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\n".$sql );
	
		return mysqli_affected_rows( $this->db );		
	}
	
	public function fetchAllUsers( $columns = '*', $offset = 0, $limit = 20, $orderBy = 'username', $sortOrder = 'ASC' )
	{
		$data		= array();		
		$columns	= ( is_array( $columns ) ) ? implode(',', $columns ) : '*';
		
		$sql    = "SELECT ".mysqli_real_escape_string( $this->db, $columns )." FROM `".DB_TABLE_PREFIX."user` ";
		$sql   .= "ORDER BY ".mysqli_real_escape_string( $this->db, $orderBy )." ".mysqli_real_escape_string( $this->db, $sortOrder ) ." ";
		$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$offset ).", ".mysqli_real_escape_string( $this->db, (int)$limit );
		
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {							
				$data[] = $row;
			}
		}
		
		return $data;		
	}	
	
	private function confirmAccountById( $userId )
	{
		$sql    = "UPDATE `".DB_TABLE_PREFIX."user` ";
		$sql   .= "SET `site_status` = 'email_confirmed' ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;
		}
		
		return false;		
	}
	
	public function addUserToUsergroup( $userId, $usergroupId )
	{
		$sql	= "INSERT INTO  `".DB_TABLE_PREFIX."usergroup_member` ";
		$sql   .= "( ";
		$sql   .= "`user_id`, ";
		$sql   .= "`usergroup_id` ";
		$sql   .= ") VALUES ( ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $userId )."', ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $usergroupId )."' ";
		$sql   .= "); ";

		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	}
	
	public function confirmAccountByCode( $code )
	{
		$sql	= "SELECT * FROM `".DB_TABLE_PREFIX."user_confirm` ";
		$sql   .= "WHERE `code` = '".mysqli_real_escape_string( $this->db, trim( $code ) )."' ";
		$sql   .= "LIMIT 1";
		
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );
			
			$this->addUserToUsergroup( $data['user_id'], SITE_DEFAULT_USERGROUP );
			$this->deleteConfirmCodeById( $data['id'] );
			return $this->confirmAccountById( $data['user_id'] );
		}
		
		return false;		
	}
	
	public function deleteConfirmCodeById( $id )
	{
		$sql    = "DELETE FROM `".DB_TABLE_PREFIX."user_confirm` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;
		}
		
		return false;		
	}
	
	public function createUser( $data = array() )
	{
		if( empty( $data ) ) {
			return false;
		}
		
		// START:	filter input
		foreach( $data AS $key => $value ) {
			if( !in_array( $key, $this->_columnNames ) ) {
				unset( $data[$key] );	
			}	
		}
		// END:		filter input
		
		if( !strlen( trim( $data['email'] ) ) ) {
			return 'EMAIL_NOT_SPECIFIED';	
		} 
		
		if( $this->emailExists( $data['email'] ) ) {
			return 'EMAIL_EXISTS';			
		}
		
		if( $this->usernameExists( $data['username'] ) ) {
			return 'USERNAME_EXISTS';
		}		
		
		// START:	set user status
		if( (int)SITE_MODERATE_NEW_USERS == 1 ) {
			$data['site_status'] = 'pending';
		} else if( (int)SITE_REQUIRE_EMAIL_CONFIRM == 1 ) {
			$data['site_status'] = 'unconfirmed';
		} else {
			$data['site_status'] = 'auto_confirmed';
		}		
		// END:		set user status
		
		$data['date_created'] = time();
		
		// START:	hash password
		if( isset( $data['password'] ) ) {
			$data['password'] = sha1( $data['password'] );			
		}		
		// END:		hash password

		// START:	insert user into DB
		$count	= count( $data );
		$i		= 0;
		 
		$sql	= "INSERT INTO `".DB_TABLE_PREFIX."user` ( ";
		foreach( $data AS $key => $value ) {
			$i++;
			$comma = ( $i < $count ) ? ', ' : ' ';
			$key = mysqli_real_escape_string( $this->db, $key );
			$sql .= "`".mysqli_real_escape_string( $this->db, $key )."` ".$comma;
		}
		$sql .= ") VALUES ( ";
		
		$i = 0;
		foreach( $data AS $key => $value ) {
			$i++;
			$comma = ( $i < $count ) ? ', ' : ' ';
			$value = mysqli_real_escape_string( $this->db, $value );
			$sql .= "'".mysqli_real_escape_string( $this->db, $value )."' ".$comma;
		}
		 
		$sql   .= ");";		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\nSQL:  ".$sql );
		
		$userId	= mysqli_insert_id();
		// END:		insert user into DB
		
		// START:	notify moderator, if required
		if( (int)SITE_MODERATE_NEW_USERS == 1 ) {
			// send e-mail to site admin
		}
		// END:		notify moderator, if required
		
		// START:	send e-mail, if required
		if( (int)SITE_REQUIRE_EMAIL_CONFIRM == 1 ) {
			// send e-mail to user
			/* $code = randomString( 60 );
			$this->addEmailConfirmCode( $userId, $code );
			$this->sendNewRegistrationEmail( $userId, $code ); */
		}
		// END:		send e-mail, if required
		
		return 'OK';		
	}
	
	public function resetOwnPassword( $username, $recaptchaChallenge, $recaptchaResponse )
	{
		require_once('recaptcha-php/recaptchalib.php');
		
		$response = recaptcha_check_answer( 
		    SITE_RECAPTCHA_PRIVATE_KEY,
			$_SERVER['REMOTE_ADDR'],
			$recaptchaChallenge,
			$recaptchaResponse
		);
		
		if ( !$response->is_valid ) {
			return $response->error;
		}
				
		if( $this->usernameExists( $username ) ) {
			$this->sendPasswordResetEmail( $username );
			return 'OK';	
		}	

		return 'USER_404';
	}
	
	protected function sendNewRegistrationEmail( $userId, $code )
	{
		require_once('PHPMailer/PHPMailerAutoload.php');
	
		$mail = new PHPMailer;
		$user = $this->fetchUserDetailsById( $userId );
	
		$mail->From		= SITE_EMAIL_ADDRESS;
		$mail->FromName = SITE_NAME;
		$mail->addAddress( $user['email'], $user['first_name'].' '.$user['last_name'] );
		$mail->addReplyTo( SITE_EMAIL_ADDRESS, SITE_NAME );
	
		$mail->WordWrap = 50;
		$mail->isHTML( true );
	
		$mail->Subject	= '['.SITE_NAME.'] Your New Account ('.$user['username'].')';
	
		$body			= 'Hello '.$user['first_name'].' '.$user['last_name'].', ';
		$body    	   .= '<br><br>Please confirm your new account by following this URL:  ';
		$body    	   .= BASEURL.'/accounts/confirm/'.$code;
	
		$mail->Body		= $body;
	
		$body			= "Hello ".$user['first_name']." ".$user['last_name'].", ";
		$body    	   .= "\r\n\r\nPlease confirm your new account by following this URL:  ";
		$body    	   .= BASEURL."/accounts/confirm/".$code;
	
		$mail->AltBody = $body;
	
		if( !$mail->send() ) {
			return $mail->ErrorInfo;
		}
	
		return true;
	}
		
	private function sendPasswordResetEmail( $username )
	{
		require_once('PHPMailer/PHPMailerAutoload.php');
		
		$mail = new PHPMailer;
		$user = $this->fetchUserDetailsByUsername( $username );
		
		$code = randomString( 60 );
		$this->addPasswordResetCode( $user['id'], $code );
		
		$mail->From		= SITE_EMAIL_ADDRESS;
		$mail->FromName = SITE_NAME;
		$mail->addAddress( $user['email'], $user['first_name'].' '.$user['last_name'] );
		$mail->addReplyTo( SITE_EMAIL_ADDRESS, SITE_NAME );
		
		$mail->WordWrap = 50;
		$mail->isHTML( true );
		
		$mail->Subject = '['.SITE_NAME.'] Password Reset';
		
		$body			= 'Hello '.$user['first_name'].' '.$user['last_name'].', ';
		$body    	   .= '<br><br>A request was made to reset your password. ';
		$body    	   .= '<br><br>Please click here if you wish to proceed:  ';
		$body    	   .= BASEURL.'/accounts/password/email-verify/'.$code;
		
		$mail->Body		= $body;
		
		$body			= "Hello ".$user['first_name']." ".$user['last_name'].", ";
		$body    	   .= "\r\n\r\nA request was made to reset your password. ";
		$body    	   .= "\r\n\r\nPlease click here if you wish to proceed:  ";
		$body    	   .= BASEURL."/accounts/password/email-verify/".$code;
				
		$mail->AltBody = $body;
		
		if( !$mail->send() ) {
			return $mail->ErrorInfo;
		}
		
		return true;		
	}
	
	public function sendNewPasswordEmail( $userId, $newPassword )
	{
		require_once('PHPMailer/PHPMailerAutoload.php');
	
		$mail = new PHPMailer;
		$user = $this->fetchUserDetailsById( $userId );
	
		$mail->From		= SITE_EMAIL_ADDRESS;
		$mail->FromName = SITE_NAME;
		$mail->addAddress( $user['email'], $user['first_name'].' '.$user['last_name'] );
		$mail->addReplyTo( SITE_EMAIL_ADDRESS, SITE_NAME );
	
		$mail->WordWrap = 50;
		$mail->isHTML( true );
	
		$mail->Subject = '['.SITE_NAME.'] Password Change';
	
		$body			= 'Hello '.$user['first_name'].' '.$user['last_name'].', ';
		$body    	   .= '<br><br>Per your request, your password has been changed to: '.$newPassword;
	
		$mail->Body		= $body;
	
		$body			= "Hello ".$user['first_name']." ".$user['last_name'].", ";
		$body    	   .= "\r\n\r\nPer your request, your password has been changed to: ".$newPassword;
	
		$mail->AltBody = $body;
	
		if( !$mail->send() ) {
			return $mail->ErrorInfo;
		}
	
		return true;
	}

	private function addEmailConfirmCode( $userId, $code )
	{
		$sql	= "INSERT IGNORE INTO `".DB_TABLE_PREFIX."user_confirm` ( ";
		$sql   .= "`user_id` , `code` , `date` ";
		$sql   .= ") VALUES ( ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $userId )."', ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $code )."', ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, time() )."' ";
		$sql   .= ") ";
	
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;
		}
	
		return false;
	}
		
	private function addPasswordResetCode( $userId, $code )
	{
		$sql	= "INSERT IGNORE INTO `".DB_TABLE_PREFIX."password_reset` ( ";
		$sql   .= "`user_id` , `code` , `date` ";
		$sql   .= ") VALUES ( ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $userId )."', ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, $code )."', ";
		$sql   .= "'".mysqli_real_escape_string( $this->db, time() )."' ";
		$sql   .= ") ";

		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;
		}
		
		return false;		
	}
	
	public function resetPasswordByResetCode( $code )
	{
		$sql	= "SELECT * FROM `".DB_TABLE_PREFIX."password_reset` ";
		$sql   .= "WHERE `code` = '".mysqli_real_escape_string( $this->db, trim( $code ) )."' ";
		$sql   .= "LIMIT 1";
	
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			require_once( 'randlib.class.php' );
			$data = mysqli_fetch_assoc( $res );
			$this->deletePasswordResetCodeById( $data['id'] );
			return $this->changePasswordById( $data['user_id'], random::generateRandomString() );
		}
	
		return false;
	}

	public function deletePasswordResetCodeById( $id )
	{
		$sql    = "DELETE FROM `".DB_TABLE_PREFIX."password_reset` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
		$sql   .= "LIMIT 1 ";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;
		}
	
		return false;
	}	
	
	public function changePasswordById( $id, $newPassword, $notifyUser = true )
	{
		$sql    = "UPDATE `".DB_TABLE_PREFIX."user` ";
		$sql   .= "SET `password` = '".mysqli_real_escape_string( $this->db, sha1( $newPassword ) )."' ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
		$sql   .= "LIMIT 1 ";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );	
	
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			if( $notifyUser ) {
				$this->sendNewPasswordEmail( $id, $newPassword );				
			}
			
			return true;
		}
	
		return false;
	}
		
	public function changeOwnPassword( $password, $newPassword )
	{
		$sql    = "UPDATE `".DB_TABLE_PREFIX."user` ";		
		$sql   .= "SET `password` = '".mysqli_real_escape_string( $this->db, sha1( $newPassword ) )."' ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $_SESSION['user']['id'] )."' ";
		$sql   .= "AND `password` = '".mysqli_real_escape_string( $this->db, sha1( $password ) )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		
		if( mysqli_affected_rows( $this->db ) > 0 ) {
			return true;	
		}
		
		return false;		
	}	
	
    /**
     * User Login
     *
     * @param   string  $username
     * @param	string	$password
     * @return  string
    */
    public function login( $username, $password )
    {
    	if( !$this->usernameExists( $username ) ) {
    		return 'LOGIN_USERNAME_DOES_NOT_EXIST';	
    	} 
    		    	
        $sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user` ";
        $sql   .= "WHERE `username` = '".mysqli_real_escape_string( $this->db, $username )."' ";
        $sql   .= "AND `password` = '".mysqli_real_escape_string( $this->db, $password )."' ";
        $sql   .= "OR `email` = '".mysqli_real_escape_string( $this->db, $username )."' ";
        $sql   .= "AND `password` = '".mysqli_real_escape_string( $this->db, $password )."' ";
        $sql   .= "LIMIT 1 ";

        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );

        if( mysqli_num_rows( $res ) > 0 ) {
            $data = mysqli_fetch_assoc( $res );

            $updateData						= array();
            $updateData['last_active']		= time();
            $updateData['last_login_date']	= time();
            	
            // update user data
            $this->updateUserById( $data['id'], $updateData );            
            
            $_SESSION['user'] = array();
            
            foreach( $data AS $key => $value )  {
            	$_SESSION['user'][$key] = $value;	
            }
            
            $_SESSION['site']['permissions'] = $this->fetchSitePermissionsByUserId( $data['id'] );
            
            if( empty( $_SESSION['site']['permissions'] ) ) {
            	session_unset();
            	session_destroy();
            	
            	return 'NO_SITE_PERMISSIONS';	
            }
            
            if( !in_array( 'can_view_site', @$_SESSION['site']['permissions']['site'] ) ) {
            	session_unset();
            	session_destroy();
            	
            	return 'NO_SITE_VIEW';
            }          
            
            $_SESSION['user']['logged_in'] = true;
			if( !strlen( trim(  $_SESSION['user']['avatar_url'] ) ) ) {
            	 $_SESSION['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
            } elseif ( !urlExists(  $_SESSION['user']['avatar_url'] ) ) {
            	 $_SESSION['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
            }
            $_SESSION['user']['profile_url'] 	= BASEURL.'/'.$_SESSION['user']['username'];
            $_SESSION['user']['full_name'] 		= $_SESSION['user']['first_name'].' '.$_SESSION['user']['last_name'];
            
            // remove the user's password from the session
            unset( $_SESSION['user']['password'] );
            
            return 'LOGIN_OK';
        } else {
       		return 'LOGIN_INVALID_PASSWORD'; 	
        }      
    }
    /**
     * User Login via an External Service
     *
     * @param   array	$data
     * @return  string
    */
    public function loginExternal( $data = array() )
    {  
    	$_SESSION['user']['logged_in']	= true;    	
    	$_SESSION['user']['external']	= $data;
    	return 'LOGIN_OK';	
    }
    
    /**
     * Fetch User Data via User ID
     *
     * @param   string  $userId
     * @return  array
     */
    public function fetchUserDetailsById( $userId )
    {
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user` ";
    	$sql   .= "WHERE `id` = ".mysqli_real_escape_string( $this->db, (int)$userId )." ";
    	$sql   .= "LIMIT 1 ";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );  
    		
    		if( !strlen( trim( $data['avatar_url'] ) ) ) {
    			$data['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
    		} elseif ( !urlExists( $data['avatar_url'] ) ) {
    			$data['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
    		}    		
    		
    		return $data;
    	} else {
    		return array();
    	}
    } 
    
    /**
     * Fetch User Data via Username
     *
     * @param   string  $username
     * @return  array
     */
    public function fetchUserDetailsByUsername( $username )
    {    		
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user` ";
    	$sql   .= "WHERE `username` = '".mysqli_real_escape_string( $this->db, $username )."' ";
    	$sql   .= "OR `email` = '".mysqli_real_escape_string( $this->db, $username )."' ";
    	$sql   .= "LIMIT 1";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$now	= time();
    		$data	= mysqli_fetch_assoc( $res );
    		
			if( !strlen( trim( $data['avatar_url'] ) ) ) {
    			$data['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
    		} elseif ( !urlExists( $data['avatar_url'] ) ) {
    			$data['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
    		}     		
    		    		
    		return $data;
    	} else {
    		return array();	
    	}
    }

    /**
     * Fetch Username via User ID
     *
     * @param   string  $userId
     * @return  string
     */
    public function fetchUsernameById( $userId )
    {
    	$sql    = "SELECT `username` FROM `".DB_TABLE_PREFIX."user` ";
    	$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
    	$sql   .= "LIMIT 1 ";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data['username'];
    	}
    }

    /**
     * Fetch User's e-mail Address via User ID
     *
     * @param   string  $userId
     * @return  string
     */
    public function fetchEmailById( $userId )
    {
    	$sql    = "SELECT `email` FROM `".DB_TABLE_PREFIX."user` ";
    	$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
    	$sql   .= "LIMIT 1 ";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		$data = mysqli_fetch_assoc( $res );
    		return $data['email'];
    	}
    }    

    /**
     * Determine if a username exists or not
     *
     * @param   string	$username
     * @return  boolean	
    */
    public function usernameExists( $username )
    {
        $sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user` ";
        $sql   .= "WHERE `username` = '".mysqli_real_escape_string( $this->db, $username )."' ";
        $sql   .= "OR `email` = '".mysqli_real_escape_string( $this->db, $username )."' ";
        $sql   .= "LIMIT 1 ";

        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );

        if( mysqli_num_rows( $res ) > 0 ) {
            return true;
        }
        
        return false;
    }
    
    /**
     * Determine if an e-mail address exists or not
     *
     * @param   string	$email
     * @return  boolean
     */
    public function emailExists( $email )
    {
    	$sql    = "SELECT * FROM `".DB_TABLE_PREFIX."user` ";
    	$sql   .= "WHERE `email` = '".mysqli_real_escape_string( $this->db, $email )."' ";
    	$sql   .= "LIMIT 1 ";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    
    	if( mysqli_num_rows( $res ) > 0 ) {
    		return true;
    	}
    
    	return false;
    }    
    
    /**
     * Update a user's session
     */    
    public function updateUserSession()
    {
		if( isset( $_SESSION['user']['id'] ) ) {
			$data = $this->fetchUserDetailsById( $_SESSION['user']['id'] );
			if( empty( $data ) ) {				
				session_destroy();
				setcookie('PHPSESSID', '', time() - 3600 );
				
				return;	
			}
			
			$newData					= array();
			$newData['last_active'] 	= time();
			$newData['last_ip'] 		= $_SERVER['REMOTE_ADDR'];
			
			$this->updateUserById( $_SESSION['user']['id'], $newData );
			            
            foreach( $data AS $key => $value )  {
            	$_SESSION['user'][$key] = $value;	
            }
            
            $_SESSION['site']['permissions']	= $this->fetchSitePermissionsByUserId( $data['id'] );            
            $_SESSION['user']['logged_in']		= true;
            $_SESSION['user']['avatar_url'] 	= ( strlen( $_SESSION['user']['avatar_url'] ) ) ? $_SESSION['user']['avatar_url'] : SITE_DEFAULT_AVATAR_URL;
            
            if( !strlen( trim(  $_SESSION['user']['avatar_url'] ) ) ) {
            	 $_SESSION['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
            } elseif ( !urlExists(  $_SESSION['user']['avatar_url'] ) ) {
            	 $_SESSION['user']['avatar_url'] = SITE_DEFAULT_AVATAR_URL;
            }            
                        
            $_SESSION['user']['profile_url']	= BASEURL.'/'.$_SESSION['user']['username'];
            $_SESSION['user']['full_name'] 		= $_SESSION['user']['first_name'].' '.$_SESSION['user']['last_name'];
            
            // remove the user's password from the session
            unset( $_SESSION['user']['password'] );			
		} else {
			if( isset( $_SESSION['user']['external'] ) ) {
				if( !empty( $_SESSION['user']['external'] ) ) {
					$_SESSION['user']['logged_in']		= true;
					$_SESSION['user']['name']			= $_SESSION['user']['external']['name'];
					$network = $_SESSION['user']['external']['network'];
					switch( $network ) {
						case 'twitter':
							$_SESSION['user']['email']		= '@'.$_SESSION['user']['external']['screen_name'];
							$_SESSION['user']['avatar_url'] = $_SESSION['user']['external']['profile_image_url'];
							break;
						default:
							$_SESSION['user']['email'] = $_SESSION['user']['external']['email'];
					}
					$_SESSION['site']['permissions'] = $this->fetchSitePermissionsExternal();
				} else {
			$_SESSION['user']['logged_in']	= false;
			$_SESSION['user']['username']	= 'Guest';
			$_SESSION['user']['avatar_url']	= SITE_DEFAULT_AVATAR_URL;
				}	
			} else {
				$_SESSION['site']['permissions']	= $this->fetchSitePermissionsByUserId();
				$_SESSION['user']['logged_in']		= false;
				$_SESSION['user']['username']		= 'Guest';
				$_SESSION['user']['avatar_url']		= SITE_DEFAULT_AVATAR_URL;	

				if( !isset( $_SESSION['user']['uuid'] ) ) {
					$_SESSION['user']['uuid'] = UUID::mint( 4 )->__toString();
				}				
			}
		}   	
    }
    
    public function updateUserById($id, $data)
    {
    	if( !empty( $data ) ) {    		
    		// START:	filter input
    		foreach( $data AS $key => $value ) {
    			if( !in_array( $key, $this->_columnNames ) ) {
    				unset( $data[$key] );
    			}
    		}
    		// END:		filter input

    		// check the data array again after filtering
    		if( empty( $data ) ) {
    			return false;
    		}    		
    		    		
    		$count	= count( $data );
    		
	        $sql    = "UPDATE `".DB_TABLE_PREFIX."user` ";
	        $sql   .= "SET ";
	        $i		= 0;
	        foreach( $data AS $key => $value ) {
				$i++;	        	
	        	if( !is_numeric( $key ) ) {
	        		$sql .= "`".mysqli_real_escape_string( $this->db, $key )."` = '".mysqli_real_escape_string( $this->db, $value )."' ";
	        		if( $i < $count ) {
	        			$sql .= ", ";	
	        		}	
	        	}	        	
	        }
	        
	        $sql   .= "WHERE `id` = ".mysqli_real_escape_string( $this->db, (int)$id )." ";
	        $sql   .= "LIMIT 1 ";  

	        $res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
	        
	        return mysqli_affected_rows( $this->db );	        
    	} 
    }  

    public function fetchSitePermissionsByUserId( $userId = 0 )
    {
    	return $this->_Site_Permission->fetchSitePermissionsByUserId( $userId );    	
    }
    
    public function fetchSitePermissionsExternal()
    {
    	return $this->_Site_Permission->fetchSitePermissionsExternal();
    }
    
    public function changeUserLangByLangId( $langId )
    {
    	// @TODO:	verify that language exists
    	$langId = (int)$langId;
    	
    	if( !$this->_Language->languageExistsById( $langId ) ) {
    		return false;	
    	}
    	
    	$_SESSION['user']['lang_override']		= true;
		$_SESSION['user']['selected_lang_id']	= $langId;
		$_SESSION['user']['site_language']		= $langId;
		
		if( $_SESSION['user']['logged_in'] ) {
			$this->updateUserById( $_SESSION['user']['id'], array( 'site_language' => $langId ) );			
		}
		
		return true;
    }
    
    /**
     * Fetch User Data via User ID
     *
     * @param   string  $userId
     * @return  array
    */
    public function getById( $userId )
    {
		return $this->fetchUserDetailsById( $userId );
    }
}