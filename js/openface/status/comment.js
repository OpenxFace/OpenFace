/**
 * OpenFace
 * Commenting
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Saturday, June 27, 2015, 12:35 PM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready(function() {
	
	// Status Comment Focus
	$(document).on('click', '.linkComment', function( event ) {
		event.preventDefault();
		var statusId = $(this).data('id');
		
		if( typeof statusId !== 'undefined' ) {
			$('#inputStatusResponse-' + statusId).focus();	
		}

		return false;
	});
	
});