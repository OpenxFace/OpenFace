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
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     Priceless PHP Base
*/

$(document).ready(function() {	
	// START:	remove address bar on mobile
	if( typeof IS_MOBILE !== 'undefined' ) {
		if( parseInt( IS_MOBILE == 1 ) ) {
			window.scrollTo(0, 1);	
		}		
	}
	// END:		remove address bar on mobile
	
	// the 'About' box...
	$('#linkAbout').click(function(event) {
		var text	= '<strong>BizLogic</strong> is a software development firm.';
		text		= text + '<br>This is our base framework.';
		text		= text + '<br><br>&copy 2013 - ' + new Date().getFullYear();
		text		= text + ' BizLogic';
		text		= text + '<br><a href="http://bizlogicdev.com" target="_blank">http://bizlogicdev.com</a>';
		
		bootbox.alert(text, function() {
			// ...
		});			

	});	
	
	$('#linkLogout').click(function(event) {
		event.preventDefault();
		
		bootbox.dialog({
			message: 'Are you sure that you want to logout?',
			title: '<i class="fa fa-exclamation-triangle"></i> Logout Confirmation',
			buttons: {
				'confirm': {
					label: '<i class="fa fa-times-circle"></i> ' + translate('logout'),
					className: 'btn-primary',
					callback: function() {
						$.blockUI();
						window.location.assign( BASEURL + '/logout' );
					}
				},
				'cancel': {
					label: '<i class="fa fa-times"></i> ' + translate('cancel'),
					className: 'btn-default',
					callback: function() {}
				}
			},
			onShow: function( bootboxObj ) {
				$.unblockUI();				
			}
		});
	});	
	
	// http://www.scorchsoft.com/blog/youtube-z-index-embed-iframe-fix/
	$('iframe').each(function() {
		var url = $(this).attr('src');
		if( url.match(/youtube/g) ) {
			var search = '?';

			if( url.indexOf('?') != -1 ) {
				var search = '&';
			}
	        
			$(this).attr( 'src', url + search + 'wmode=transparent' );						
		} 					
    });
	
	$('#deleteOwnAvatar').live('click', function(event) {
		event.stopImmediatePropagation();
		event.preventDefault();

		// http://blog.nemikor.com/category/jquery-ui/jquery-ui-dialog/
		var $dialog = $('<div></div>')
						.html('Are you sure that you want to delete your avatar?')
						.dialog({
							title: '<i class="icon-warning-sign"></i> Delete Your Avatar?',
							minWidth: 600,
							minHeight: 200,
							modal: true,
							position: { 
								my: 'center top', 
								at: 'center top', 
								of: $('#profileEdit')
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
										url: BASEURL + '/ajax',
										data: { 
											method: 'avatar-delete-own', 				
											userId: CURRENT_USER['id'] 
										},
										complete: function( jqXHR, textStatus ) {
											
										},
										success: function( response, textStatus, jqXHRresponse ) {				
											if( response.status == 'OK' ) {
												$('.ui-dialog-content').dialog('close');
												$('#myAvatar').attr('src', response.url);
												
								                setTimeout(function() {
													$('#avatarContainer').height( $('#myAvatar').height() + 23 );
													$('#avatarContainer').width( $('#myAvatar').width() );
													
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
	
	$('#profileEdit').submit(function(event) {
		$.blockUI();
	});		
	
	$('.addMore').click(function(event) {
		var id		= $(this).data('id');
		var name	= $('#' + id).attr('name');
		var type	= $('#' + id).prop('tagName');
		var newItem = $('#' + id).clone();
						
		// find the last element like this
		var $target = $(type +'[name^="'+ name +'"]:last');
		
		// generate new ID
		var newId	= 'clone-'+ rand();
		
		// add spacing
		newItem.css({
			'margin-top': '5px'
		});	
		
		// change attribute; clear value; add to DOM
		newItem.attr('id', newId ).val('').insertAfter( $target );
		
		// animate
		$('#' + newId).animate({ 
			backgroundColor: '#fcf8e3' 
		}, 'slow', function() {
			$(this).css({
				'background-color': ''
			})
		});			
		
		// show the removal element
		$('i.' + id).show();
	});
	
	$('.removeMore').live('click', function(event) {
		var id		= $(this).data('id');
		var name	= $('#' + id).attr('name');
		var type	= $('#' + id).prop('tagName');
						
		// find the last element like this
		var $target = $(type +'[name^="'+ name +'"]:last');
		
		// animate
		$target.animate({ 
			backgroundColor: '#f2dede' 
		}, 'slow', function() {
			$(this).remove()
		});
		
		var targetCount = $(type +'[name^="'+ name +'"]').length;
		if( targetCount == 1 ) {
			$(this).hide();
		}
	});	
			
	$('.changeLang').live('click', function(event) {
		// close the menu on mobile
		$('.navbar-collapse').removeClass('in');
		
		var langId = parseInt( $(this).data('id') );
		if( langId <= 0 ) {
			return false;	
		}
		
		$.blockUI({ 
			baseZ: 16777271, 
			message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' 
		});
		
		$.ajax({
			type: 'POST',
			url: BASEURL + '/users/ajax',
			data: { 
				method: 'changeLang',
				langId: langId
			},
			complete: function( jqXHR, textStatus ) {
				// ..
			},
			success: function( response, textStatus, jqXHRresponse ) {
				if( response.status == 'OK' ) {
					window.location.reload();					
				} else {
					$.unblockUI();
				}
			},
			error: function(  jqXHR, textStatus, errorThrown ) {
				// ...
			},		
			dataType: 'json'
		});			
	});
	
	$('.changeTheme').live('click', function(event) {
		// close the menu on mobile
		$('.navbar-collapse').removeClass('in');
		
		var theme		= $(this).data('name');
		var bootstrap	= $(this).data('bootstrap');
		
		if( theme.length > 0 ) {
			$.blockUI({
				overlayCSS:  { 
			        backgroundColor: '#000', 
			        opacity:         0.9, 
			        cursor:          'wait' 
			    } 							
			});	
			
			if( bootstrap ) {
				switch( theme ) {
					case 'bootstrap-with-theme':
						$('#themeCSS').attr('href', BASEURL + '/css/bootstrap/themes/bootstrap/bootstrap.min.css');
						$('head').append('<link id="themeBootstrap" href="'+ BASEURL +'/css/bootstrap/themes/bootstrap/bootstrap-theme.min.css" type="text/css" rel="stylesheet" />');
					
						break;
					 
					default:
						$('#themeBootstrap').remove();
						$('#themeCSS').attr('href', BASEURL + '/css/bootstrap/themes/' + theme + '/bootstrap.min.css');	
				}						
			} else {
				switch( theme ) {
					case 'uw-clone':
					case 'uw-clone-v2':
						$.blockUI({ 
							baseZ: 2014, 
							message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' 
						});
						
						$.cookie('theme', theme, { 
							expires: 7300, 
							path: '/' 
						});
														
						window.location.reload();
														
						break;
						 						 
					default:
						$('.navbar').addClass('ui-widget-header').removeClass('navbar-default');
						$('#themeBootstrap').remove();
						$('#themeCSS').attr('href', BASEURL + '/css/jquery-ui/themes/' + theme + '/jquery-ui.css');	
				}						
			}  

			// change link name
			$('#linkThemeCurrent').data('name', theme).html( ucfirst( theme ) );
			
			// set cookie
			$.cookie('theme', theme, { 
				expires: 7300, 
				path: '/',
				onSet: function( result ) {					
					if( result.length > 0 ) {
						window.location.reload();
					}
				}
			});			
		}												
	});
	
	$('.backToTop').click(function(event) {
		event.preventDefault();
		
		if( IS_MOBILE != 1 ) {
			$.blockUI();
		}
		
		scrollToTop();		
	});
			
	$('.blockUI-trigger').live('click', function(event) {
		if( typeof USE_BLOCKUI === 'undefined' ) {
			return;
		} else if ( USE_BLOCKUI != 1 ) {
			return;
		}
		
		if( $(this).attr('href') == '#' ) {
			return;
		}		
		
		$.blockUI({ 
			message: '<img border="0" src="' + DEFAULT_PRELOADER_IMAGE + '" />', 
			// styles for the overlay 
	    	overlayCSS:  { 
	    		backgroundColor: '#000000', 
	    		opacity:         0.6, 
	    		cursor:          'wait' 
	    	} 		
		});
	});
	
	$('a').live('click', function(event) {
		if( typeof USE_BLOCKUI === 'undefined' ) {
			return;
		} else if ( USE_BLOCKUI != 1 ) {
			return;
		}
		
		if( $(this).hasClass('blockUI-trigger') ) {
			return;
		}
		
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
		
		var href = $(this).attr('href');
		if( typeof href !== 'undefined' ) {
			if( href.match(/javascript/) ) {
				return;
			}	
		}
		
		var elementClass = $(this).attr('class');
		if( typeof elementClass !== 'undefined' ) {
			elementClass = explode( ' ', elementClass );			
		}
		
		var excludedClass = [
		    'dropdown-toggle', 
		    'fg-button', 
		    'noBlockUI', 
		    'Button', 
		    'close', 
		    'glyphicons'
		];
						
		// START:	check class
		if( typeof elementClass !== 'undefined' ) {
			var intersect	= new Array();			
			intersect		= array_intersect( excludedClass, elementClass );
			
			if( !empty( intersect ) ) {
				return;
			}			
		}
		// END:		check class
		
		// START:	check id
		var excludedId = [
		    'recaptcha_reload_btn', 
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
		
		$.blockUI({ 
			message: '<img border="0" src="' + DEFAULT_PRELOADER_IMAGE + '" />', 
			overlayCSS: { 
				backgroundColor: '#000000' 
			}
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
	
	$('#themeSelect').change(function() {
		var value = trim( $(this).val() );
		if( value.length > 0 ) {
			var id = $('#themeSelect').find('option:selected').data('id');
			$.blockUI({ baseZ: 2014, message: '<img border="0" src="' + BASEURL + '/images/preloader/168.gif">' });
			$.ajax({
				type: 'POST',
				url: BASEURL + '/users/ajax',
				data: { 
					method: 'changeTheme',
					id: id,
					theme: value
				},
				complete: function( jqXHR, textStatus ) {
				},
				success: function( response, textStatus, jqXHRresponse ) {
					if( response.status == 'OK' ) {
						$.cookie('theme', value, { expires: 1460, path: '/' });
						window.location.reload();					
					} else {
						$.unblockUI();
					}
				},
				error: function(  jqXHR, textStatus, errorThrown ) {
				},		
				dataType: 'json'
			});				
		}
	});
	
	$('#btnLogin').live('click', function(event) {
		event.preventDefault();
		var username = trim( $('#username').val() );
		var password = trim( $('#password').val() );
		if( username.length <= 0 || password.length <= 0 ) {
			$('#username').addClass('error');
			$('#password').addClass('error');
			$('.lblCustom').addClass('error');
			return false;
		}
		
		$.blockUI();
		$('#loginPassword').val( sha1( password ) );
		
		$.ajax({
			type: 'POST',
			url: BASEURL + '/ajax',
			data: { method: 'user-login',
					username: $('#username').val(),
					password: $('#loginPassword').val()
			},
			complete: function( jqXHR, textStatus ) {
				// ...
			},
			success: function( response, textStatus, jqXHRresponse ) {
				if( response.status == 'OK' ) {
					if( response.data == 'LOGIN_OK' ) {	
						$('#login-errors').html('').hide();
						$('#username').removeClass('error');
						$('#password').removeClass('error');
						$('.lblCustom').removeClass('error');
						window.location.reload();
					} else {
						$.unblockUI();
						$('#login-errors').html('<i class="icon-warning-sign"></i> Login error').show();
						$('#username').addClass('error');
						$('#password').addClass('error');
						$('.lblCustom').addClass('error');						
					}
				} else {
					$.unblockUI();
					$('#login-errors').html('<i class="icon-warning-sign"></i> Login error').show();
					$('#username').addClass('error');
					$('#password').addClass('error');
					$('.lblCustom').addClass('error');
				}
			},
			error: function(  jqXHR, textStatus, errorThrown ) {
				$.unblockUI();
			},		
			dataType: 'json'
		});		
	});	
	
});