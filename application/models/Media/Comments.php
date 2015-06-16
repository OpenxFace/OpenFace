<?php
/**
 * BizLogic Base Framework
 * Media Comments Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Monday, September 16, 2013, 10:23 PM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Comments.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 */

class Media_Comments extends Db
{    
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'media_comments';        
        parent::__construct( $this->tableName );
    }
    
	public function deleteOwnCommentById( $commentId )
	{
		$sql	= "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `id` = '".mysqli_real_escape_string( (int)$commentId )."' ";
		$sql   .= "AND `commenter_id` = '".mysqli_real_escape_string( (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1 ";
		
		$res	= mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		return mysqli_affected_rows( $this->db );
	}	
	
	public function addCommentToMedia( $mediaId, $commenterId, $commentText )
	{	
		$filter			= new Zend_Filter_StripTags();		
		$commentText	= $filter->filter( $commentText );		
		
		$sql    = "INSERT INTO `".mysqli_real_escape_string( $this->db, $this->tableName )."` ( ";
		$sql   .= "`media_id`, `commenter_id`, `comment`, `date` ";
		$sql   .= " ) VALUES ( ";
		$sql   .= " '".mysqli_real_escape_string( (int)$mediaId )."', ";
		$sql   .= " '".mysqli_real_escape_string( (int)$commenterId )."', ";
		$sql   .= " '".mysqli_real_escape_string( $commentText )."', ";
		$sql   .= " '".mysqli_real_escape_string( time() )."' ";
		$sql   .= " ); ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\nSQL:\n\n".$sql );

		$data					= array();
		$data['id'] 			= mysqli_insert_id( $this->db );
		$data['affected_rows']	= mysqli_affected_rows( $this->db );
		
		return $data;		
	}
	
	public function fetchCommentsByMediaId( $mediaId, $offset = 0, $limit = SITE_COMMENT_FETCH_LIMIT, $sortOrder = 'ASC', $sortBy = 'date' )
	{
		$limit	= ( (int)$limit == 0 ) ? $this->fetchCommentCountByMediaId( $mediaId ) : $limit;
		
		$sql    = "SELECT * FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `media_id` = '".mysqli_real_escape_string( (int)$mediaId )."' ";
		$sql   .= "ORDER BY ".mysqli_real_escape_string( $sortBy )." ";
		$sql   .= "LIMIT ".mysqli_real_escape_string( (int)$offset ).", ".mysqli_real_escape_string( (int)$limit );
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\nSQL:\n\n".$sql );	
		$data	= array();
		
		if( mysqli_num_rows( $res ) > 0 ) {
			
			$i					= 0;			
			$User	= new User;
			
			if( SITE_CENSOR_REPLACEMENT_TYPE == 'image' ) {
				$censor = '<img border="0" src="'.SITE_CENSOR_REPLACEMENT.'">';
			} else {
				$censor = SITE_CENSOR_REPLACEMENT;
			}			
			
			while( $row = mysqli_fetch_assoc( $res ) ) {				
				$userData = $User->fetchUserDetailsById( $row['commenter_id'] );
				
				if( SITE_ALLOW_URL_IN_COMMENT != 1 ) {										
					$urls = detectAllUrls( $row['comment'] );
					if( !empty( $urls ) ) {
						foreach( $urls AS $key => $value ) {							
							$row['comment'] = str_replace( $value, $censor, $row['comment'] );							
						}
					}					
				} else if( SITE_ALLOW_URL_IN_COMMENT == 1 AND SITE_PARSE_URL_IN_COMMENT == 1 ) {										
					$urls = detectAllUrls( $row['comment'] );
					if( !empty( $urls ) ) {
						foreach( $urls AS $key => $value ) {
							$row['comment'] = str_replace( $value, '<a href="http://'.$value.'" target="_blank">'.$value.'</a>', $row['comment'] );	
						}	
					}
				}
				
				$data[$i]					= $row;
				$data[$i]['commenter_name']	= $userData['username'];
				$data[$i]['avatar_url']		= $userData['avatar_url'];
				
				$i++;					
			}
		}

		return $data;		
	}

	public function fetchCommentCountByMediaId( $mediaId )
	{
		$sql    = "SELECT COUNT(*) AS `total_count` FROM `".mysqli_real_escape_string( $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `media_id` = '".mysqli_real_escape_string( (int)$mediaId )."' ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db )."\nSQL:\n\n".$sql );		
		$data	= mysqli_fetch_assoc( $res );
		
		return $data['total_count'];		
	}
	 
    // END OF THIS CLASS
}