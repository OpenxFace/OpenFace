/**
 * Priceless PHP Base
 * Various JavaScript Functions
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @license     GNU Affero General Public License v3
 * @copyright	2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://pricelessphp.com
 *
 * @since       Wednesday, April 25, 2012 / 01:47 AM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Revision: 109 $
 *
 * @package     Priceless PHP Base
 * @category	JavaScript
*/

$('#logo').live('click', 
		function() {
			blockUIWithMessage( 'Loading...', 'Loading, please wait...' );	
			window.location = BASEURL; 
		}
);

function blockUIWithMessage( title, message, timeout )
{ 	
	title	= ( typeof title !== 'undefined' && strlen( title ) ) ? title : 'Loading...';
	message = ( typeof message !== 'undefined' && strlen( message ) ) ? message : 'Loading, please wait...';
	timeout	= ( typeof timeout !== 'undefined' && is_numeric( timeout ) ) ? timeout : 0;
	
	if( timeout > 0 ) {		
		$.blockUI({ 
			theme:		true, 
			title:    	title, 
			message:	message + '&nbsp;&nbsp;<img style="vertical-align: middle;" src="'+ BASEURL +'/img/loading.gif" border="0">',
			timeout:	timeout
		});	
	} else {
		$.blockUI({ 
			theme:		true, 
			title:    	title, 
			message:	message + '&nbsp;&nbsp;<img style="vertical-align: middle;" src="'+ BASEURL +'/img/loading.gif" border="0">'			
		});	
	}
}

function reloadPage()
{
	window.location.reload();
}