<?php
/**
 * Priceless PHP Base
 * RSS Controller
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Sunday, September 14, 2014, 08:13 PM GMT+1
 * @modified    $Date: 2014-10-11 15:02:37 +0200 (Sat, 11 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: RssController.php 68 2014-10-11 13:02:37Z hire@bizlogicdev.com $
 *
 * @category    Controllers
 * @package     Priceless PHP Base
*/

class RssController extends Zend_Controller_Action
{
	private $_requestObj;
	private $_requestUri;
	private $_Media;
	
    public function __call( $method, $args ) {}

    public function init()
    {
    	header('Content-Type: text/xml; charset=utf-8');    	
    	$this->_helper->viewRenderer->setNoRender( true );
    	
    	$this->_Media = new Media;   	
    	    	
        $this->_requestObj	= $this->getRequest();
        $this->_requestUri	= $this->_requestObj->getRequestUri();
        
        $action = $this->getRequest()->getParam('action');                
    }

    public function indexAction() 
    {
    	$articles = $this->_Media->getActive( 0, 7 );
    	if( !empty( $articles ) ) {
    		$rss = array();
    		foreach( $articles AS $key => $value ) {
    			$articles[$key]['author']	= $value['owner_name'];
    			$rss[$key]['title']			= $value['title'];    			
    			$rss[$key]['description']	= '<img src="'.$value['thumb_url'].'" border="0"><br>'.$value['description'];
    			$rss[$key]['link']			= BASEURL.'/watch/'.$value['key'];
    			$rss[$key]['lastUpdate']	= $value['date_added'];
    			$rss[$key]['published']		= $value['date_added'];
    		}    	
    	}
    	
        $feedData = array(
            'title'			=> SITE_NAME.' - Most Recent Videos',
            'description'	=> SITE_RSS_DESCRIPTION,
            'link'			=> BASEURL,
            'charset'		=> 'utf8',
            'entries'		=> $rss
        );
        
        // create our feed object and import the data
        $feed = Zend_Feed::importArray( $feedData, 'rss' );
         
        // echo the contents of the XML document
        echo $feed->send();
    }
}