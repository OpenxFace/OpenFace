/**
 * OpenFace
 * Comment Deletion
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

	// START:	Comment Delete
	$( document ).on('click', '.commentDelete', function( event ) {
		event.preventDefault();
		
		var commentId	= $(this).data('id');
		var statusHtml	= $.trim( $('#commentText-' + commentId).html() );
		
		if( typeof commentId !== 'undefined' ) {
			var deletePrompt = translate('prompt_comment_deletion');
			
			bootbox.dialog({
			    message: deletePrompt + '<br><br>' + statusHtml,
			    title: '<i class="fa fa-warning"></i> ' + translate('prompt_comment_delete'),
			    buttons: {
			    	'confirm': {
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
									method: 'commentDelete', 				
									id: commentId 
								},
								complete: function( jqXHR, textStatus ) {
									// ...
								},
								success: function( response, textStatus, jqXHRresponse ) {				
									if( response.status == 'OK' ) {
										// remove the comment
						    			$('#commentContainer-' + commentId).remove();
										
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
		}

		return false;
	});	
	// END:		Comment Delete	
	
});