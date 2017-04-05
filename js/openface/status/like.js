/**
 * OpenFace
 * Liking
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Saturday, June 27, 2015, 12:37 PM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready(function() {
	
	// Status Liking
	$(document).on('click', '.linkLike', function(event) {
		event.preventDefault();
		
		var statusId	= $(this).data('id');
		var statusUUID	= $(this).data('uuid');
		var ME			= $(this);
		
		if( typeof statusUUID !== 'undefined' ) {	
			// START:	Visual Cue
			
			var randId = rand();
			
			// the data
			var data = [{
				id: randId
			}];
			
			// template
			var template	= $.templates('#templateNotifyHtml');
			var htmlOutput	= $.trim( template.render( data ) );

			Q.when(
				// render
				$('#userReaction-' + statusId).append( htmlOutput )
			).then(function( result ) {
				// hide the clicked element
				ME.hide();				
			}).then(function( result ) {
				// START:	AJAX Request
				$.ajax({
					type: 'POST',
					url: BASEURL + '/status/ajax',
					data: { 
						method: 'like', 				
						parent_uuid: statusUUID
					},
					complete: function( jqXHR, textStatus ) {
						// ...
					},
					success: function( response, textStatus, jqXHRresponse ) {				
						if( response.status == 'OK' ) {
							// show the like block
							$('#likeBlock-' + statusId).show();
							
							// visual cue
							$('#notifyHtml-' + randId).remove();
							
							// change the URL's text
							ME.text( translate('unlike') );
							
							// change the URL's class
							ME.removeClass('linkLike');
							ME.addClass('linkUnlike');
							
							// display the URL
							ME.show();
							
							// unblock the interface
							$.unblockUI();
						} else {
							// visual cue
							$('#notifyHtml-' + randId).remove();
							ME.show();
							
							// display error dialog
							display_error_dialog( translate('error_occurred'), '<i class="fa fa-warning"></i> ' + translate('error') );
							
							// unblock the interface
							$.unblockUI();
						}								
					},
					error: function( jqXHR, textStatus, errorThrown ) {
						// visual cue
						$('#notifyHtml-' + randId).remove();
						ME.show();
						
						// display error dialog
						display_error_dialog( errorThrown, '<i class="fa fa-warning"></i> ' + translate('error') );
						
						// unblock the interface
						$.unblockUI();
					},		
					dataType: 'json'
				});			
				// END:		AJAX Request								
			});			
			
			// END:		Visual cue
			
		}

		return false;
	});
	
});