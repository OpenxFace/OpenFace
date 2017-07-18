/**
 * OpenFace
 * Direct Message Creation
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Sunday, July 16, 2017, 21:32 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready(function() {
	
	// create
	$('#btnDirectMessageSend').click( function( event ) {
		var formEl	= $('#frmDirectMessage');
		var text	= $.trim( formEl.val() );
		var ME		= $(this);
		var myUUID	= uuid();
		
		// disable the button
		ME.prop('disabled', true);
		
		// disable the form
		formEl.prop('disabled', true);
		
		if( text.length > 0 ) {
			// block the UI
			$.blockUI();

			// remove error cue
			formEl.parents('.form-group').removeClass('has-error');
			
			// AJAX REQ
			$.ajax({
				type: 'POST',
				url: BASEURL + '/dm/ajax',
				data: { 
					method: 'add', 				
					text: text,
					uuid: myUUID,
					to: $('#frmReceiver').val()
				},
				complete: function( jqXHR, textStatus ) {
					// ...
				},
				success: function( response, textStatus, jqXHRresponse ) {				
					if( response.status == 'OK' ) {
						window.location.reload();
					} else {
						// unblock the UI
						$.unblockUI();

						rumble( formEl );
						formEl.parents('.form-group').addClass('has-error');
						
						// re-enable the button
						ME.prop('disabled', false);
						
						// re-enable the form
						formEl.prop('disabled', false);
					}								
				},
				error: function( jqXHR, textStatus, errorThrown ) {
                    // unblock the UI
                    $.unblockUI();

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