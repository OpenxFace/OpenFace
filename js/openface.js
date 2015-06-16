/**
 * OpenFace
 * Custom JavaScript
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, June 16, 2013, 09:14 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready(function() {	
	
	// New Status button
	$('#btnNewStatus').click(function(event) {
		var formEl	= $('#frmNewStatus');
		var status	= $.trim( formEl.val() );
		var ME		= $(this);
		
		// disable the button
		ME.prop('disabled', true);
		
		// disable the form
		formEl.prop('disabled', true);
		
		if( status.length > 0 ) {
			// remove error cue
			formEl.parents('.form-group').removeClass('has-error');
			
			// AJAX REQ
			$.ajax({
				type: 'POST',
				url: BASEURL + '/status/ajax',
				data: { 
					method: 'add', 				
					status: status 
				},
				complete: function( jqXHR, textStatus ) {
					// ...
				},
				success: function( response, textStatus, jqXHRresponse ) {				
					if( response.status == 'OK' ) {
						// clear the value
						formEl.val('');	
						
						// re-enable the button
						ME.prop('disabled', false);
						
						// re-enable the form
						formEl.prop('disabled', false);
						
						// owner
						var owner			= [];
						owner.first_name	= base64_decode( CURRENT_USER.first_name );
						owner.last_name		= base64_decode( CURRENT_USER.last_name );
						owner.avatar_url	= base64_decode( CURRENT_USER.avatar_url );
						owner.id			= base64_decode( CURRENT_USER.id );
						owner.uuid			= base64_decode( CURRENT_USER.uuid );
						
						// the data
						var data = [{
							'date': time(),
							'status': status,
							'owner': owner 
						}];
						
						// template
						var template	= $.templates('#templateStatus');
						var htmlOutput	= template.render( data );

						// render
						$('#statusList').prepend( htmlOutput );
					} else {
						rumble( formEl );
						formEl.parents('.form-group').addClass('has-error');
						
						// re-enable the button
						ME.prop('disabled', false);
						
						// re-enable the form
						formEl.prop('disabled', false);
					}								
				},
				error: function( jqXHR, textStatus, errorThrown ) {
					rumble( formEl );
					formEl.parents('.form-group').addClass('has-error');
					
					// re-enable the button
					ME.prop('disabled', false);
					
					// re-enable the form
					formEl.prop('disabled', false);
				},		
				dataType: 'json'
			});				
		} else {
			rumble( formEl );
			formEl.parents('.form-group').addClass('has-error');
			
			// re-enable the button
			ME.prop('disabled', false);
			
			// re-enable the form
			formEl.prop('disabled', false);
		}
		
		return false;
	});	
	
});