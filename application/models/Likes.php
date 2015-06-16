<?php
/**
 * BizLogic Base Framework
 * Likes Model
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Sunday, September 15, 2013, 02:40 AM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Likes.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 */

class Likes extends Db
{
    public function __construct()
    {
        $this->tableName = DB_TABLE_PREFIX.'likes';
        parent::__construct( $this->tableName );
    }
        
	public function fetchAllLikesBySubjectId( $subjectId, $type )
	{		
		$sql    = "SELECT count(*) AS total FROM `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `subject_id` = '".mysqli_real_escape_string( $this->db, (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysqli_real_escape_string( $this->db, $type )."' ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		$likeData	= array();
		$users		= array();
		$data		= mysqli_fetch_assoc( $res );
		$totalLikes = $data['total'];
		
		$sql    = "SELECT u.username FROM `".DB_TABLE_PREFIX."users` u ";
		$sql   .= "INNER JOIN `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` l on u.id = l.liker_id ";
		$sql   .= "WHERE l.subject_id = '".mysqli_real_escape_string( $this->db, (int)$subjectId )."' ";
		$sql   .= "AND l.type = '".mysqli_real_escape_string( $this->db, $type )."' ";
		$sql   .= "ORDER BY RAND() ";
		$sql   .= "LIMIT 3 ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			$users = array();
			while( $row = mysqli_fetch_assoc( $res ) ) {
				$users[] = $row['username'];				
			}			
		}		
		
		$likeData['count'] = $totalLikes;
		$likeData['users'] = $users;

		return $likeData;
	}
	
	public function fetchLikeByUserId( $subjectId, $userId, $type )
	{
		$sql    = "SELECT `id` FROM `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `subject_id` = '".mysqli_real_escape_string( $this->db, (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysqli_real_escape_string( $this->db, $type )."' ";
		$sql   .= "AND `liker_id` = '".mysqli_real_escape_string( $this->db, $userId )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
		
		if( mysqli_num_rows( $res ) > 0 ) {
			return true;
		}
	
		return false;
	}
		
	public function likeSubjectById( $subjectId, $type )
	{		
		$sql    = "INSERT IGNORE INTO `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` ";
		$sql   .= " (`subject_id`, `liker_id`, `type`, `date`) ";
		$sql   .= " VALUES ('".mysqli_real_escape_string( $this->db, (int)$subjectId )."', ";
		$sql   .= " '".mysqli_real_escape_string( $this->db, (int)$_SESSION['user']['id'] )."', ";
		$sql   .= " '".mysqli_real_escape_string( $this->db, $type )."', ";
		$sql   .= " '".mysqli_real_escape_string( $this->db, time() )."' ); ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );

		return mysqli_affected_rows( $this->db );		
	}
	
	public function unLikeSubjectById( $subjectId, $type )
	{
		$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `subject_id` = '".mysqli_real_escape_string( $this->db, (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysqli_real_escape_string( $this->db, $type )."' ";
		$sql   .= "AND `liker_id` = '".mysqli_real_escape_string( $this->db, (int)$_SESSION['user']['id'] )."' ";
		$sql   .= "LIMIT 1";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		return mysqli_affected_rows( $this->db );	
	}

	public function removeAllLikesBySubjectId( $subjectId, $type )
	{
		$sql    = "DELETE FROM `".mysqli_real_escape_string( $this->db, $this->db, $this->tableName )."` ";
		$sql   .= "WHERE `subject_id` = '".mysqli_real_escape_string( $this->db, (int)$subjectId )."' ";
		$sql   .= "AND `type` = '".mysqli_real_escape_string( $this->db, $type )."' ";
			
		$res    = mysqli_query( $this->db, $sql ) OR die( mysqli_error( $this->db ).PHP_EOL."SQL: ".$sql.PHP_EOL."File: ".__FILE__.PHP_EOL."Line: ".__LINE__ );
			
		return mysqli_affected_rows( $this->db );
	}	
	 
    // END OF THIS CLASS
}