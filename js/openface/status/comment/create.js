/**
 * OpenFace
 * Comment Creation
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

$(document).ready( function() {
	
	// Status Commenting
	$(document).on('keypress', '.statusResponse', function( event ) {
		var keyCode = event.keyCode || event.which;
		if( keyCode == 13 ) {
			event.preventDefault();
			
			var text = $.trim( $(this).val() );
			if( text.length == 0 ) {
				return false;
			}
			
			var replyTo	= $(this).data('replyto');
			var parent	= $(this).data('parent');
			var ME		= $(this);
			
			if( typeof replyTo !== 'undefined' ) {
				// UUID
				var myUUID = uuid();
				
				// parent ID
				var parentId = ME.data('id');
				
				Q.when(
					// disable the element
					ME.prop('disabled', true)				
				).then(function( result ) {
					// START:	AJAX Request
					$.ajax({
						type: 'POST',
						url: BASEURL + '/status/ajax',
						data: { 
							method: 'comment', 	
							uuid: myUUID,
							reply_to: replyTo,
							parent_uuid: parent,
							text: text
						},
						complete: function( jqXHR, textStatus ) {
							// ...
						},
						success: function( response, textStatus, jqXHRresponse ) {				
							if( response.status == 'OK' ) {	
								// remove error cue
								ME.parent('.form-group').removeClass('has-error');
								
								// clear the input
								ME.val('');
								
								// re-enable the input element
								ME.prop('disabled', false);
								
								// author
								var author			= [];
								author.first_name	= base64_decode( CURRENT_USER.first_name );
								author.last_name	= base64_decode( CURRENT_USER.last_name );
								author.avatar_url	= base64_decode( CURRENT_USER.avatar_url );
								author.id			= base64_decode( CURRENT_USER.id );
								author.uuid			= base64_decode( CURRENT_USER.uuid );
								
								// the data
								var data = [{
									'id': response.data.id,
									'date': time(),
									'text': text,
									'author': author,
									'like_data': {},
									'uuid': myUUID,
									'text': text,
									'current_user': response.data.current_user,
									'owner': response.data.owner
								}];
								
								// template
								var template	= $.templates('#templateComment');
								var htmlOutput	= template.render( data );

								// render
								var commentCount = $('#statusContainer-' + parentId).find('.comment-container').length;
								if( commentCount > 0 ) {
									$('#statusContainer-' + parentId).find('.comment-container').last().after( htmlOutput );	
								} else {
									$('#frmStatusResponse-' + parentId).prepend( htmlOutput );									
								}

                                // Auto embed images
                                $('#commentText-' + response.data.id).autoimage();

                                // START:   Auto-link URLs
                                $('#commentText-' + response.data.id).autolink({
                                    mentions: true,
                                    hashtags: true,
                                    urls: true,
                                    linkTo: 'local'
                                });
                                // END:     Auto-link URLs

								// unblock the interface
								$.unblockUI();
							} else {
								// add error cue
								ME.parent('.form-group').addClass('has-error');
								
								// re-enable the input element
								ME.prop('disabled', false);
								
								// display error dialog
								display_error_dialog( translate('error_occurred'), '<i class="fa fa-warning"></i> ' + translate('error') );
								
								// unblock the interface
								$.unblockUI();
							}								
						},
						error: function( jqXHR, textStatus, errorThrown ) {
							// re-enable the input element
							ME.prop('disabled', false);
							
							// add error cue
							ME.parent('.form-group').addClass('has-error');
							
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
		}		
	});


    // Location Detection
    $(document).on('click', '#locationDetect', function( event ) {
        event.preventDefault();
        return false;
    });

    // Location Detection
    $(document).on('click', '#status-uploadImage', function( event ) {
        event.preventDefault();
		return false;
    });
	
});