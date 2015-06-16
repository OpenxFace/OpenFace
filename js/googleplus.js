/**
 * Priceless PHP Base
 * Custom JavaScript for Google+
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2014 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http:/7pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Tuesday, June 10, 2014, 06:25 AM GMT+1
 * @modified    $Date: 2014-05-04 16:36:58 -0700 (Sun, 04 May 2014) $ $Author$
 * @version     $Id$
 *
 * @category    JavaScript; Google+
 * @package     Priceless PHP Base
*/

function googleplus_callback_onload()
{
	// Set your API KEY
    gapi.client.setApiKey('AIzaSyBOmm94E4zi8DbZwkZqpRsTiDEPuBsaxxY'); 
    // Load Google + API
    gapi.client.load('plus', 'v1',function(){});
}

function googleplus_callback_info( data )
{
	SOCIAL_LOGIN = data;
}

function googleplus_callback_login( response )
{
	SOCIAL_LOGIN = response;
	if( response.status.signed_in ) {
		// user is logged in 
		googleplus_get_user();
		
		$('#dropdown-user').html( response.email );
		$('#tabFederated-content').html( '<div class="alert alert-success"><i class="fa fa-check"></i> Logged in via Google+' );
		
		disable_neighboring_tabs( $('.nav-tabs') );	
		googleplus_login_local();
	}
}

function googleplus_login()
{
	var params = {
	    'clientid': '938184452007-iurmtue3fate3bpaptv8m3v923ko6dnv.apps.googleusercontent.com', //You need to set client id
	    'cookiepolicy': 'single_host_origin',
	    // callback function
	    'callback': 'googleplus_callback_login',
	    'approvalprompt':'force',
	    'scope': 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.profile.emails.read'
	};
	
	gapi.auth.signIn( params );
}

function googleplus_logout()
{
    gapi.auth.signOut();
}

function googleplus_get_user()
{
	var request = gapi.client.plus.people.get({
		'userId': 'me'
	});
	
	request.execute(function (resp) {
		SOCIAL_LOGIN = resp;
		googleplus_callback_info( resp );
		
		var email = '';
		if( resp['emails'] ) {
			for( i = 0; i < resp['emails'].length; i++ ) {
				if(resp['emails'][i]['type'] == 'account') {
					email = resp['emails'][i]['value'];
			     }
			}
		}
	});	
}

function googleplus_login_local()
{
	var request = gapi.client.plus.people.get({
		'userId': 'me'
	});
	
	request.execute(function( response ) {
		SOCIAL_LOGIN = response;
		googleplus_callback_info( response );
		
		var email = [];
		if( response['emails'].length > 0 ) {
			for( i = 0; i < response['emails'].length; i++ ) {
				if( response['emails'][i]['type'] == 'account' ) {
					email.push( response['emails'][i]['value'] );
				}
			}
			
			response.email = email[0];
		}
		
		response.network		= 'google-plus';
		response['username']	= response['displayName'];
		response['avatar']		= response['image']['url'];
		
		$.blockUI();
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
				if( response.status == 'OK' ) {
					$.blockUI();
					window.location.reload();		
				} else {
					$.unblockUI();
				}
			},
			error: function(  jqXHR, textStatus, errorThrown ) {
				$.unblockUI();
			},		
			dataType: 'json'
		});
		
	});		
}