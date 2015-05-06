/**
 * Priceless PHP Base
 * Custom JavaScript for Facebook
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Monday, June 09, 2014, 05:23 PM GMT+1
 * @modified    $Date: 2014-05-04 16:36:58 -0700 (Sun, 04 May 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: facebook.js 40 2014-05-04 23:36:58Z hire@bizlogicdev.com $
 *
 * @category    JavaScript; Facebook
 * @package     Priceless PHP Base
*/

function facebook_login()
{
	FB.login(function(response) {
		FB.Event.subscribe('auth.authResponseChange', auth_response_change_callback);
		FB.Event.subscribe('auth.statusChange', auth_status_change_callback);
		
		facebook_callback_login( response );
	}, {scope: 'public_profile,email'});	
}

function facebook_get_login_status()
{
	FB.getLoginStatus(function(response) {
		facebook_callback_login( response );
	});	
}

function facebook_callback_login(response) 
{
	$.unblockUI();
	facebook_callback_info( response );

    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus()
    
    switch( response.status ) {
    	case 'connected':
    		// Logged into your app and Facebook
    		facebook_get_user_info();
    		
    		break;
    		
    	case 'not_authorized':
    		// The person is logged into Facebook, but not your app
    		$('#dropdown-user').html('');
    		
    		break;
    		
    	default:
    		// The person is not logged into Facebook, so we're not sure if
    		// they are logged into this app or not
    		$('#dropdown-user').html('');
    }
}

function facebook_callback_info(response) 
{
	SOCIAL_LOGIN = response;
}

function facebook_get_user_info() 
{
	FB.api('/me', function(response) {
		if( !empty( response ) ) {
			facebook_callback_info( response );
			$('#dropdown-user').html( response.email );
			$('#tabFederated-content').html( '<div class="alert alert-success"><i class="fa fa-check"></i> Logged in via Facebook</div>' );
			
			disable_neighboring_tabs( $('.nav-tabs') );
			response.network = 'facebook';
			
			$.ajax({
				type: 'POST',
				url: BASEURL + '/users/ajax',
				data: { 
					method: 'userLoginExternal',
					data: response
				},
				complete: function( jqXHR, textStatus ) {
					// ...
				},
				success: function( response, textStatus, jqXHRresponse ) {
					$.unblockUI();
					if( response.status == 'OK' ) {
						window.location.reload();		
					} else {
						$('#frmErrors').html('<div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> '+ translate('authentication_failure') +'</div>')
						$.unblockUI();
					}
				},
				error: function(  jqXHR, textStatus, errorThrown ) {
					$.unblockUI();
				},		
				dataType: 'json'
			});			
		}
	});
}

function facebook_logout()
{
	FB.logout(function(response) {
		facebook_callback_info( response ); 
	});	
}

var auth_response_change_callback = function(response) {
	  console.log('auth_response_change_callback');
	  console.log(response);
}

var auth_status_change_callback = function(response) {
	console.log('auth_status_change_callback: ' + response.status);
	switch( response.status ) {
		case 'unknown':
			$.blockUI();
			
			$('#dropdown-user').html('');
			$('#tabFederated-content').html('<div class="alert alert-danger"><i class="fa fa-times-circle"></i> Logged out</div>');
			
			window.location.reload();
			
			break;
	}
}