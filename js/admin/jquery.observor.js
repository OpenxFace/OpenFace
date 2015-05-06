/**
 * Priceless PHP Base
 * jQuery Observor
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Wednesday, July 10, 2013, 20:18 GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: jquery.observor.js 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    JavaScript
 * @package     Priceless PHP Base
*/

$(document).ready(function() {	
	$('#adminAddUser').submit(function( event ) {
		event.preventDefault();
		
		var valid	= formIsValid('adminAddUser');
		var errors	= getFormErrors('adminAddUser');
		
		// blockUI
		$.blockUI({ baseZ: 2014, message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' });	
		if( valid ) {
			$.ajax({
				type: 'POST',
				url: BASEURL + '/admin/ajax',
				data: { 
					method: 'addUser',
					data: $('#adminAddUser').formParams()
				},
				complete: function( jqXHR, textStatus ) {
					// ...
				},
				success: function( response, textStatus, jqXHRresponse ) {
					if( response.status == 'OK' ) {
						window.location.assign( BASEURL + '/admin/profile/edit/' + response.userid );					
					} else {
						// unblock
						$.unblockUI();
						
						var $dialog = $('<div></div>')
						.html( SITE_PHRASES[strtolower( response.error )] )
						.dialog({
							autoOpen: true,
							title: '<i class="icon-warning-sign"></i> An Error has Occurred',
							modal: true,
							minWidth: 500,
							buttons: {
								'OK': function() {
									$(this).dialog('close');
								}
							}							
						});					
					}
				},
				error: function(  jqXHR, textStatus, errorThrown ) {
					// ...
				},		
				dataType: 'json'
			});	
		} else {
			$.unblockUI();
			var errorSize = errors.length;
			if( errorSize > 0 ) {
			    $('html, body').animate({
			        scrollTop: $('#' + errors[0] ).offset().top - 10
			    }, 'slow');				
			}			
		}
	});
	$('#dropdown-langChange').on('click', function(event) {
		var langId = $(this).data('langid');
		if( strlen( trim( langId ) ) ) {
			langId = parseInt( langId );	
		} else {
			return false;			
		}
		
		$.blockUI({ baseZ: 2014, message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' });
		$.ajax({
			type: 'POST',
			url: BASEURL + '/users/ajax',
			data: { method: 'changeLang',
					langId: langId
			},
			complete: function( jqXHR, textStatus ) {
				
			},
			success: function( response, textStatus, jqXHRresponse ) {
				if( response.status == 'OK' ) {
					window.location.reload();					
				} else {
					$.unblockUI();
				}
			},
			error: function(  jqXHR, textStatus, errorThrown ) {

			},		
			dataType: 'json'
		});
	});
	
	$('#adminDeleteAvatar').live('click', function(event) {
		event.stopImmediatePropagation();
		event.preventDefault();
		var userId = $(this).data('userid');
		// http://blog.nemikor.com/category/jquery-ui/jquery-ui-dialog/
		var $dialog = $('<div></div>')
						.html('Are you sure that you want to delete this avatar?')
						.dialog({
							title: '<i class="icon-warning-sign"></i> Delete this Avatar?',
							minWidth: 600,
							minHeight: 200,
							modal: true,
							position: { 
								my: 'center top', 
								at: 'center top', 
								of: $('.box-title')
							},
							buttons: {
								'Yes': function() {
			                		$('#avatarContainer').block({ 
			                			message: null, 
										overlayCSS:  { 
											backgroundColor: '#FFFFFF', 
											opacity:         0.6, 
											cursor:          'wait' 
  	    							  	}
			                		});
			                		$('#avatarContainer').spin();
									$.ajax({
										type: 'POST',
										url: BASEURL + '/admin/ajax',
										data: { 
											method: 'admin-delete-avatar', 				
											userId: userId 
										},
										complete: function( jqXHR, textStatus ) {
										},
										success: function( response, textStatus, jqXHRresponse ) {				
											if( response.status == 'OK' ) {
												$('.ui-dialog-content').dialog('close');
												$('#userAvatar').attr('src', response.url);
								                setTimeout(function() {
													$('#avatarContainer').height( $('#userAvatar').height() + 23 );
													$('#avatarContainer').width( $('#userAvatar').width() );
								                	$('#avatarDeleteContainer').hide();
								                	$('#avatarContainer').unblock();
									                $('#avatarContainer').spin(false);
								              	}, 2000);													
											} else {
							                	$('#avatarContainer').unblock();
								                $('#avatarContainer').spin(false);												
												$('.ui-dialog-content').dialog('close');		
											}								
										},
										error: function(  jqXHR, textStatus, errorThrown ) {
										},		
										dataType: 'json'
									});	
								 },
								 Cancel: function() {
									 $(this).dialog('close');
								 }
							},
							open: function() {
								// http://stackoverflow.com/questions/4103964/icons-in-jquery-ui-dialog-title
								$('.ui-dialog .ui-dialog-title .ui-icon').css({
									'float': 'left',
								    'margin-right': '4px'
								});
								// http://stackoverflow.com/a/3393526
				                $('.ui-dialog-buttonpane').
				                    find('button:contains("Cancel")').button({
				                    	icons: {
				                    		primary: 'ui-icon-cancel'
				                    	}
				                });
				                $('.ui-dialog-buttonpane').
			                    	find('button:contains("Yes")').button({
			                    		icons: {
			                    			primary: 'ui-icon-check'
			                    		}
			                    });				                
							}
						});
		$dialog.dialog('open');
	});	
	// START:	tab persistence
	// @link	http://stackoverflow.com/a/10524697
	$('a[data-toggle="tab"]').on('shown', function (e) {
		//save the latest tab; use cookies if you like 'em better:
		localStorage.setItem('lastTab', $(e.target).attr('id'));
	});

	// go to the latest tab, if it exists:
	var lastTab = localStorage.getItem('lastTab');
	if (lastTab) {
		$('#'+lastTab).tab('show');
	}	
	// END:		tab persistence
	
	$('.windowReload').on('click', function(event) {
		window.location.reload();
	});
	
	$('.blockUI-trigger, a:not(".noBlockUI")').on('click', function(event) {	
		var target = $(this).attr('target');
		if( typeof target !== 'undefined' ) {
			if( target == '_blank' || target == 'new' ) {
				return;				
			}
		}
		
		var toggle = $(this).data('toggle');
		if( typeof toggle !== 'undefined' ) {
			return;
		}
		
		var elementClass = $(this).attr('class');
		if( typeof elementClass !== 'undefined' ) {
			elementClass = explode( ',', elementClass );
			
			$.each(elementClass, function( index, value ) {
				if( preg_match( '/disabled/', value ) ) {
					return;
				}
			});				
			
			if( in_array( 'blockUI-trigger', elementClass ) ) {
				$.blockUI({ message: '<img border="0" src="' + DEFAULT_PRELOADER_IMAGE + '" />', 
					overlayCSS: { backgroundColor: '#000000' }
				});
				
				return;
			}
		}
		
		var excludedClass = ['dropdown-toggle', 
		                     'fg-button', 
		                     'noBlockUI', 
		                     'Button', 
		                     'close', 
		                     'glyphicons'
		];
						
		// START:	check class
		if( typeof elementClass !== 'undefined' ) {
			var intersect	= new Array();			
			elementClass	= explode( ',', elementClass );
			intersect		= array_intersect( excludedClass, elementClass );
			
			if( !empty( intersect ) ) {
				return;
			}				
		}
		// END:		check class
		
		// START:	check id
		var excludedId = ['recaptcha_reload_btn', 
		                  'recaptcha_switch_audio_btn', 
		                  'recaptcha_switch_img_btn',
		                  'recaptcha_whatsthis_btn'
		];
		
		var elementId = $(this).attr('id');
		if( typeof elementId !== 'undefined' ) {						
			if( in_array( elementId, excludedId ) ) {
				return;
			}			
		}		
		// END:		check id
		
		// START:	check href
		var href = $(this).attr('href');
		if( typeof href !== 'undefined' ) {
			if( href == '#' ) {
				return;
			}
		}
		// END:		check href
		
		$.blockUI({ message: '<img border="0" src="' + DEFAULT_PRELOADER_IMAGE + '" />', 
					overlayCSS: { backgroundColor: '#000000' }
		});
	});
	
	$('#langSelect').change(function() {
		var langId = $(this).val();
		if( strlen( trim( langId ) ) ) {
			langId = parseInt( langId );	
		} else {
			return false;			
		}
		
		$.blockUI({ baseZ: 2014, message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' });
		$.ajax({
			type: 'POST',
			url: BASEURL + '/users/ajax',
			data: { method: 'changeLang',
					langId: langId
			},
			complete: function( jqXHR, textStatus ) {
				
			},
			success: function( response, textStatus, jqXHRresponse ) {
				if( response.status == 'OK' ) {
					window.location.reload();					
				} else {
					$.unblockUI();
				}
			},
			error: function(  jqXHR, textStatus, errorThrown ) {

			},		
			dataType: 'json'
		});	
	});	
	
	$('#frmAdminLogin').submit(function( event ) {
		var password = trim( $('#passwordHolder').val() );
		if( strlen( password ) ) {
			$.blockUI();
			event.preventDefault();								
			$.ajax({
				type: 'POST',
				url: BASEURL + '/admin/ajax',
				data: { method: 'login',
						username: $('#username').val(),
						password: sha1( password )
				},
				complete: function( jqXHR, textStatus ) {
					
				},
				success: function( response, textStatus, jqXHRresponse ) {
					if( response.status == 'LOGIN_OK' ) {
						$('#loginErrorMessage').html('');
						$('#loginError').hide();
						window.location.reload();					
					} else {
						$('#loginErrorMessage').html( SITE_PHRASES['invalid_password_or_username'] );
						$('#loginError').show();
						$.unblockUI();
					}
				},
				error: function(  jqXHR, textStatus, errorThrown ) {

				},		
				dataType: 'json'
			});	
		}
	});
	
	$('.cbCheckAllFiles').on('click', function(event) {
	     var checkedStatus = this.checked;
		$('.cbDataTables').prop('checked', checkedStatus);
	});
	
	$('.adminFileDelete').live('click', function(event) {
		var targetId = $(this).data('id');
		bootbox.confirm('Are you sure that you want to delete this upload?', function(result) {
			if( result ) {
				$.blockUI();
				$.ajax({
					'dataType': 'json',
					'type': 'POST',
					'url': BASEURL + '/admin/ajax',
					'data': {id: targetId, method: 'admin-deleteFile'},
					'complete': function() {

					},
					'success': function() {
						window.location.reload();
					}	
		        });				
			}
		}); 
	});
	
});