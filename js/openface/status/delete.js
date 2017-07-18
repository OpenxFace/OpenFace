/**
 * OpenFace
 * Status Deletion
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Saturday, June 27, 2015, 12:42 PM GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready(function() {

	// Status Deletion
	$(document).on('click', '.actionStatus', function( event ) {
		event.preventDefault();
		
		var statusId	= $(this).data('id');
		var statusHtml	= $.truncate( $.trim( $('#statusText-' + statusId).html() ) );
		
		// dialog
		bootbox.dialog({
			message: translate('prompt_message_deletion_confirmation') + '<div class="" style="margin-top: 10px;">' + statusHtml + '</div>',
			title: '<i class="fa fa-warning"></i> ' + translate('deletion_confirmation'),
			buttons: {
				'delete': {
					label: translate('delete'),
					className: 'btn-default',
					callback: function() {
						// block the interface
						$.blockUI();
						
						// AJAX REQ
						$.ajax({
							type: 'POST',
							url: BASEURL + '/status/ajax',
							data: { 
								method: 'delete', 				
								statusId: statusId 
							},
							complete: function( jqXHR, textStatus ) {
								// ...
							},
							success: function( response, textStatus, jqXHRresponse ) {				
								if( response.status == 'OK' ) {
									// remove the status
									$('#statusContainer-' + statusId).remove();
									
									// unblock the interface
									$.unblockUI();
								} else {
									// unblock the interface
									$.unblockUI();
								}								
							},
							error: function( jqXHR, textStatus, errorThrown ) {
								// unblock the interface
								$.unblockUI();
							},		
							dataType: 'json'
						});	
					}
				},
				'cancel': {
			      label: translate('cancel'),
			      className: 'btn-primary',
			      callback: function() {
			    	  // ...
			      }
			    }
			}
		});
		
		return false;
	});
	
});