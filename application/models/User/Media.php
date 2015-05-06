<?php
/**
 * BizLogic Base Framework
 * User Media Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Wednesday, November 28, 2013, 01:08 AM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Media.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 */

class User_Media extends Db
{
	protected $_Likes;
	protected $_Media_Comments;
	protected $_Upload;
	
	public function __construct()
	{	    
	    $this->tableName          = DB_TABLE_PREFIX.'user_media';
		$this->_Likes             = new Likes;
		$this->_Media_Comments    = new Media_Comments;
		$this->_Upload            = new Upload;
		
		parent::__construct( $this->tableName );
	}
	
	public function updateMediaById( $id, $data = array() )
	{
		if( empty( $data ) ) {
			return false;	
		}
		
		$count	= count( $data );
		$i		= 1;
		
		$sql = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` SET ";
		
		foreach( $data AS $key => $value ) {
			$sql .= "`".mysqli_real_escape_string( $this->db, $key )."` = '".mysqli_real_escape_string( $this->db, $value )."' ";
			
			if( $i < $count ) {
				$sql .= ", ";	
			}
			
			$i++;	
		}
		
		$sql .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$id ) ."' ";
		$sql .= "LIMIT 1 ";
	
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		return mysqli_affected_rows( $this->db );
	}	

	public function updateCaptionByMediaId( $mediaId, $comment )
	{
		$sql = "UPDATE `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql .= "SET `caption` = '".mysqli_real_escape_string( $this->db, $comment ) ."' ";
		$sql .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, $_SESSION['user']['id'] ) ."' ";
		$sql .= "AND `id` = '".mysqli_real_escape_string( $this->db, $mediaId ) ."' ";
		$sql .= "LIMIT 1 ";
		
		$res = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		return mysqli_affected_rows( $this->db );
	}

	public function repostMediaById( $mediaId )
	{
		$data = $this->fetchMediaDataById( $mediaId );

		if( !empty( $data ) ) {						
			$data['repost_source']	= ( strlen( $data['repost_source'] ) ) ? $data['repost_source'] : $data['id'];
			$data['is_repost']		= 1;
			$data['upload_date']	= time();
			$data['owner_id']		= $_SESSION['user']['id'];
			$data['uuid']			= Rand::generateRandomString( rand ( 8, 11 ) );
			
			unset( $data['id'] );
			
			return $this->_Upload->add_media( $data );				
		}
	}
	
	public function deleteOwnMediabyId( $mediaId )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );
				
			@unlink( $data['file_path'] );
			@unlink( $data['mid_path'] );
			@unlink( $data['thumb_path'] );
				
			$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
			$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
			$sql   .= "AND `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$_SESSION['user']['id'] )."' ";
			$sql   .= "LIMIT 1";
		
			$this->_Likes->removeAllLikesBySubjectId( (int)$mediaId, 'media' );
			
			$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
			return true;
		}		
	}
	
	public function deleteMultipleMediaById( $media = array() )
	{
		if( empty( $media ) ) {
			return;
		}
		
		foreach( $media AS $key => $value ) {
			$this->deleteMediaById( (int)$value );	
		}
		
		return true;
	}
	
	public function deleteMediaById( $mediaId )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );
			
			@unlink( $data['file_path'] );
			@unlink( $data['mid_path'] );			
			@unlink( $data['thumb_path'] );
			
			$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
			$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
			$sql   .= "LIMIT 1";
				
			$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
			$this->_Likes->removeAllLikesBySubjectId( (int)$mediaId, 'media' );			

			return true;
		}
	}
	
	public function fetchMediaDataById( $id )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $id )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );
			return $data;
		} else {
			return array();
		}
	}	
	
	public function getMediaDataByUUID( $uuid )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `uuid` = '".mysqli_real_escape_string( $this->db, $uuid )."' ";
		$sql   .= "LIMIT 1";
		 
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		 
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );
			return $data; 		
		} else {
			return array();
		}		
	} 
	
	public function fetchAllMediaIdsByUserId( $userId )
	{
		$sql    = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
			
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row['id'];
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
	public function fetchAllMediaByUserId( $userId )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";		 
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
		 
		if( mysqli_num_rows( $res ) > 0 ) {
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$data[] = $row;
			}
	
			return $data;
	
		} else {
			return array();
		}
	}
		
    public function fetchMediaByUserId( $userId, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT, $orderBy = 'upload_date', $sortOrder = 'DESC', $offset = 0 )
    {    	
    	$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
    	$sql   .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ".mysqli_real_escape_string( $this->db, $sortOrder )." ";
    	$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$offset ).", ".mysqli_real_escape_string( $this->db, (int)$limit );
    	
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    	
    	if( mysqli_num_rows( $res ) > 0 ) {
    		while( $row = mysqli_fetch_assoc( $res ) ) {
    			$data[] = $row;
    		}
    		
    		return $data;
    		
    	} else {
    		return array();
    	}    	
    }
    
    public function fetchMediaCountByUserId( $userId )
    {
    	$sql    = "SELECT COUNT(*) AS `count` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
    	 
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );    	
    	$data	= mysqli_fetch_assoc( $res );
    	
    	return $data['count'];    	
    }

    public function fetchTotalMediaCount()
    {
    	$sql    = "SELECT COUNT(*) AS `count` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    	$data	= mysqli_fetch_assoc( $res );
    	 
    	return $data['count'];
    }   

    public function fetchRandomMediaByUserId( $userId, $limit = null )
    {
    	if( is_null( $limit ) ) {
    		$limit = 14;
    	}
    	    	
    	$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";
    	$sql   .= "ORDER BY RAND() ";    	
    	$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$limit );
    	 
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
    	 
    	if( mysqli_num_rows( $res ) > 0 ) {
    		while( $row = mysqli_fetch_assoc( $res ) ) {
    			$data[] = $row;
    		}
    		
    		$split	= array_chunk( $data, ( $limit / 2 ) );    		
    		$data	= array();
    		
    		foreach( $split[0] AS $key => $value ) {
    			if( isset( $split[1][$key] ) ) {
    				$split[0][$key]['flip'] = $split[1][$key];    				
    			} else {
    				$split[0][$key]['flip'] = array();
    			}   				
    		}    		    	
    		
    		$data = $split[0];
  		    		    
    		return $data;
    
    	} else {
    		return array();
    	}
    }     

    public function fetchRandomCompHtml( $userId, $limit = 14 )
    {    	    	
    	$data = $this->fetchRandomMediaByUserId( (int)$userId, (int)$limit );
    	if( !empty( $data ) ) {
    		    		
    		$response	= '';
    		$i			= 0;
    		
			foreach ( $data AS $key => $value ) {
				$i++;
				$response .= '<div class="compPhoto compPhoto'.$i;
				$rand = rand(0, 10);
				if ($rand >= 5) {
					$response .= ' compFlipped';
				}
				$response .= '">';
				$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFrontside" target="_blank" href="';
				$response .= BASEURL.'/p/'.$value['uuid'].'">';
				
				if( $value['media_type'] == 'video' ) {
					// $response .= '<div class="tVideo">';					
				}
				
				$response .= '<div alt="" src="';
				if( $i == 3 ) {
					$response .= $value['mid_url_path']; 
				} else {
					$response .= $value['thumb_url_path']; 
				}
				
				$response .= '" style="';
				if( $i == 3 ) {
					$response .= 'background-image: url('.$value['mid_url_path'].');';
				} else {
					$response .= 'background-image: url('.$value['thumb_url_path'].'); ';
				}
							
				$response .= ' width: 100%; height: 100%;" class="Image iLoaded"></div>';
				
				if( $value['media_type'] == 'video' ) {
					// $response .= '<div class="tVideoIndicator"></div>';
					// $response .= '</div>';
				}
								
				$response .= '<b class="compPhotoShadow"></b>';
				$response .= '</a>';
				if( !empty( $value['flip'] ) ) {
					$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFlipside" target="_blank" ';
					$response .= 'href="'.BASEURL.'/p/'.$value['flip']['uuid'].'">';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideo">';
					}
										
					$response .= '<div alt="" src="';
					if( $i == 3 ) {
						$response .= $value['flip']['mid_url_path']; 
					} else {
						$response .= $value['flip']['thumb_url_path']; 
					}
					
					$response .= '" style="';
					
					if( $i == 3 ) {
						$response .= 'background-image: url('.$value['flip']['mid_url_path'].'); '; 
					} else {
						$response .= 'background-image: url('.$value['flip']['thumb_url_path'].'); '; 
					} 
					
					$response .= 'width: 100%; height: 100%;" class="Image iLoaded"></div>';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideoIndicator"></div>';
						// $response .= '</div>';
					}
										
					$response .= '<b class="compPhotoShadow"></b>';
					$response .= '</a>';
				} else {
					$response .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" data-timestamp="'.$value['upload_date'].'" data-image="'.$value['thumb_url_path'].'" data-mediaid="'.$value['id'].'" class="displayModal noBlockUI compFlipside" target="_blank" href="';
					$response .= BASEURL.'/p/'.$value['uuid'].'">';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideo">';
					}
										
					$response .= '<div alt="" src="';
					
					if( $i == 3 ) {
						$response .= $value['mid_url_path']; 
					} else {
						$response .= $value['thumb_url_path']; 
					}
					 
					$response .= '" style="';
					if( $i == 3 ) {
						$response .= 'background-image: url('.$value['mid_url_path'].') '; 
					} else {
						$response .= 'background-image: url('.$value['thumb_url_path'].') '; 
					}
					
					$response .= 'width: 100%; height: 100%;" class="Image iLoaded"></div>';
					
					if( $value['media_type'] == 'video' ) {
						// $response .= '<div class="tVideoIndicator"></div>';
						// $response .= '</div>';
					}
										
					$response .= '<b class="compPhotoShadow"></b>';
					$response .= '</a>';
				}

				$response .= '</div>';					
			}

			return $response;
		}    			
    }
    
    public function fetchAllMedia( $limit = null, $offset = null, $orderBy = 'upload_date', $sortOrder = 'DESC' )
    {
    	if( is_null( $limit ) ) {
    		$limit = 60;
    	}
    	
    	if( is_null( $offset ) ) {
    		$offset = 0;
    	}    	
    	    	
    	$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
    	$sql   .= "ORDER BY `".mysqli_real_escape_string( $this->db, $orderBy )."` ".mysqli_real_escape_string( $this->db, $sortOrder )." ";
    	$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$offset ).", ".mysqli_real_escape_string( $this->db, (int)$limit );
    	 
    	$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).'<br>'.$sql );
    	 
    	if( mysqli_num_rows( $res ) > 0 ) {
    		while( $row = mysqli_fetch_assoc( $res ) ) {
    			$User	= new User;
    			$row['owner_name']	= $User->fetchUsernameById( $row['owner_id'] );
    			$data[] = $row;
    		}
    
    		return $data;
    
    	} else {
    		return array();
    	}
    }  

	public function fetchMedia( $page, $limit = SITE_ADMIN_PAGINATION_ITEMS_PER_PAGE, $sortBy = 'upload_date', $sortOrder = 'DESC' )
	{
		$count = $this->fetchTotalMediaCount();

		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
			
		if ($page > $totalPages) {
			$page = $totalPages;			
		}
			
		$offset	= ( $limit * $page ) - $limit;
			
		$sql	= "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "ORDER BY ".mysqli_real_escape_string( $this->db, $sortBy )." ".mysqli_real_escape_string( $this->db, $sortOrder )." ";
		$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$offset ).", ".mysqli_real_escape_string( $this->db, (int)$limit );
		
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		$gridData				= array();
		$gridData['page']		= $page;
		$gridData['total']		= $totalPages;
		$gridData['records']	= $count;
		
		while( $row = mysqli_fetch_assoc( $res ) ) {
			$User	= new User;
			$row['owner_name']	= $User->fetchUsernameById( $row['owner_id'] );			
			$gridData['rows'][] = $row;
		}
			
		return $gridData;		
	}

	public function fetchPagedMediaByUserId( $returnHtml = false, $userId, $page, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT, $sortBy = 'upload_date', $sortOrder = 'DESC' )
	{
		$count = $this->fetchMediaCountByUserId( (int)$userId );
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
			
		if ($page > $totalPages) {
			$page = $totalPages;
		}
			
		$offset	= ( $limit * $page ) - $limit;
			
		$sql	= "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$userId )."' ";		
		$sql   .= "ORDER BY ".mysqli_real_escape_string( $this->db, $sortBy )." ".mysqli_real_escape_string( $this->db, $sortOrder )." ";
		$sql   .= "LIMIT ".mysqli_real_escape_string( $this->db, (int)$offset ).", ".mysqli_real_escape_string( $this->db, (int)$limit );
	
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\n".$sql );
			
		$gridData				= array();
		$gridData['page']		= $page;
		$gridData['total']		= $totalPages;
		$gridData['records']	= $count;
	
		while( $row = mysqli_fetch_assoc( $res ) ) {
			$User	= new User;
			$row['owner_name']	= $User->fetchUsernameById( $row['owner_id'] );
			$gridData['rows'][] = $row;
		}
		
		if( $returnHtml ) {
			$gridData['html'] = $this->fetchHtmlForUserMediaGrid( $gridData['rows'] );			
		}
			
		return $gridData;
	}

	public function fetchHtmlForUserMediaGrid( $data ) 
	{
		if( !empty( $data ) ) {
			$month	= array();
			$monthI	= 0;
			
			$html = '';
			
			foreach( $data AS $key => $value ) {
				$thisMonth = date( 'F', $value['upload_date'] ); 
				$monthI++; 
				$month[$thisMonth][] = $monthI;

				$html .= '<li class="photo">';
				$html .= '<div class="photo-wrapper">';
				
				if( count( $month[$thisMonth] ) == 1 ) {
					$html .= '<h3><span>'.$thisMonth.'</span>';
					$html .= '<span> </span>';
					$html .= '<span>'.date( 'Y', $value['upload_date'] ).'</span>';
					$html .= '</h3>';
				}

				$html .= '<a class="bg noBlockUI" target="_blank" href="'.BASEURL.'/p/'.$value['uuid'].'"></a>';
				$html .= '<time class="photo-date">';
				$html .= '<span>';
				$html .= '<span></span>';
				$html .= '<span>'.date( 'd', $value['upload_date'] ).'</span>';
				$html .= '<span> </span>';
				$html .= '<span>'.$thisMonth.'</span>';
				$html .= '<span> </span>';
				$html .= '<span>'.date( 'Y', $value['upload_date'] ).'</span>';
				$html .= '<span></span>';
				$html .= '</span>';
				$html .= '</time>';
				$html .= '<a data-timestampiso8601="'.date( 'c', $value['upload_date'] ).'" ';
				$html .= 'data-timestamp="'.$value['upload_date'].'" ';
				$html .= 'data-mediaid="'.$value['id'].'" ';
				$html .= 'data-image="'.$value['url_path'].'" ';
				$html .= 'class="displayModal noBlockUI" target="_blank" ';
				$html .= 'href="'.BASEURL.'/p/'.$value['uuid'].'">';
				$html .= '<div src="'.$value['thumb_url_path'].'" class="Image iLoaded iWithTransition" ';
				$html .= 'style="background-image: url('.$value['thumb_url_path'].');"></div>';
				$html .= '<div class="photoShadow"></div>';
				$html .= '</a>';
				$html .= '<ul class="photo-stats">';
				$html .= '<li class="stat-likes">';
				$html .= '<b>492</b>';
				$html .= '</li>';
				$html .= '<li class="stat-comments">';
				$html .= '<b>2</b>';
				$html .= '</li>';
				$html .= '</ul>';
				$html .= '</div>';        			
				$html .= '</li>';			
			}

			return $html;
		}	
	}

	public function fetchTotalPagesAndMediaCount( $limit = SITE_ADMIN_PAGINATION_ITEMS_PER_PAGE )
	{
		$count = $this->fetchTotalMediaCount();
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}

		$data				= array();		
		$data['totalPages'] = $totalPages;
		$data['count']		= $count;
		
		return $data;
	}
	
	public function fetchTotalPagesAndMediaCountByUserId( $userId, $limit = SITE_DEFAULT_MEDIA_FETCH_LIMIT )
	{
		$count = $this->fetchMediaCountByUserId( (int)$userId );
	
		if( $count > 0 ) {
			$totalPages = ceil( $count / $limit );
		} else {
			$totalPages = 0;
		}
	
		$data				= array();
		$data['totalPages'] = $totalPages;
		$data['count']		= $count;
	
		return $data;
	}	

	public function fetchDataForMediaModal( $mediaId )
	{
		$mediaId = (int)$mediaId;
		
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, $mediaId )."' ";
		$sql   .= "LIMIT 1";
		
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );

			$data['comments']			= $this->_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']			= $this->_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
			$data['like_data']			= $this->_Likes->fetchAllLikesBySubjectId( $mediaId, 'media' );
			$data['next_media_item']	= $this->fetchDataForNextMediaId( $mediaId, $data['owner_id'] );
			$data['prev_media_item']	= $this->fetchDataForPreviousMediaId( $mediaId, $data['owner_id'] );
			
			return $data;
		
		} else {
			return array();
		}		
	}
	
	public function fetchDataForNextMediaId( $mediaId, $ownerId )
	{		
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` > '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$ownerId )."' ";
		$sql   .= "ORDER BY `id` ASC ";
		$sql   .= "LIMIT 1";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			$data				= mysqli_fetch_assoc( $res );
			$data['comments']	= $this->_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']	= $this->_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
						
			return $data;
	
		} else {
			return array();
		}
	}

	public function fetchDataForPreviousMediaId( $mediaId, $ownerId )
	{
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` < '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";
		$sql   .= "AND `owner_id` = '".mysqli_real_escape_string( $this->db, (int)$ownerId )."' ";
		$sql   .= "ORDER BY `id` DESC ";
		$sql   .= "LIMIT 1";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			$data				= mysqli_fetch_assoc( $res );
			$data['comments']	= $this->_Media_Comments->fetchCommentsByMediaId( $mediaId );
			$data['has_liked']	= $this->_Likes->fetchLikeByUserId( $mediaId, $_SESSION['user']['id'], 'media' );
			
			return $data;
	
		} else {
			return array();
		}
	}

	public function fetchMediaBase64ById( $mediaId, $path )
	{
		$allowedPaths = array( 'thumb', 'mid', 'file' );
		
		if( !in_array( $path, $allowedPaths ) ) {
			return;			
		}
		
		$sql    = "SELECT `".mysqli_real_escape_string( $this->db, $path )."_path`, ";
		$sql   .= "`mime_type` ";		
		$sql   .= "FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( $this->db, (int)$mediaId )."' ";		
		$sql   .= "LIMIT 1";
	
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
	
		if( mysqli_num_rows( $res ) > 0 ) {
			$data = mysqli_fetch_assoc( $res );

			$base64			= 'data:'.$data['mime_type'].';base64,'.base64_encode( file_get_contents( $data[$path.'_path'] ) );			
			$contentLength	= strlen( $base64 ); 
									
			header('Content-Length: '.$contentLength);
			
			return $base64; 
		}
	}	
	 
    // END OF THIS CLASS
}