/**
 * Priceless PHP Base
 * Custom JavaScript
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Friday, September 27, 2013, 20:37 GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: hire@bizlogicdev.com $
 * @version     $Id: custom.js 109 2014-10-13 09:46:37Z hire@bizlogicdev.com $
 *
 * @category    JavaScript
 * @package     Priceless PHP Base
*/

function display_error_dialog( text )
{
	if( typeof text === 'undefined' ) {
		var text = 'An error has occurred. <br>Contact Technical Support if this issue persists.';
	}
	
	// START:	Error Display	
	var html	= text;
	var $dialog = $('<div></div>')
	.html( html )
	.dialog({
		title: '<i class="icon-warning-sign"></i> ERROR',
		minWidth: percentOfWindowWidth( 50 ),
		minHeight: percentOfWindowHeight( 40 ),
		modal: true,
		autoOpen: true,
		zIndex: 2147483640,
		buttons: {
			 OK: function() {
				 $(this).dialog('close');
			 }
		},
		open: function() {
			// http://stackoverflow.com/questions/4103964/icons-in-jquery-ui-dialog-title
			$('.ui-dialog .ui-dialog-title .ui-icon').css({
				'float': 'left',
			    'margin-right': '4px'
			});
	        
	        $('.ui-dialog-buttonpane').
	        	find('button:contains("OK")').button({
	        		icons: {
	        			primary: 'ui-icon-circle-close'
	        		}
	        });				                
		}
	});				
	// END:		Error Display	
}

function bytesToSize(bytes) 
{
	var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
	if (bytes == 0) return '0 Bytes';
	
	var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
	return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
}

/**
 * Convert number of seconds into time object
 *
 * @param integer secs Number of seconds to convert
 * @return object
 */
function secondsToTime( secs, returnObj )
{
    var hours = Math.floor(secs / (60 * 60));
   
    var divisor_for_minutes = secs % (60 * 60);
    var minutes = Math.floor(divisor_for_minutes / 60);
 
    var divisor_for_seconds = divisor_for_minutes % 60;
    var seconds = Math.ceil(divisor_for_seconds);
   
    if( returnObj || returnObj === 'undefined' ) {
        var obj = {
                "hours": parseInt( hours ),
                "minutes": parseInt( minutes ),
                "seconds": parseInt( seconds )
            };
            
        return obj;    	
    } else {
    	var returnValue = '';
    	if( hours > 0 ) {
    		var hourString = ( hours != 1 ) ? ' hours ' : ' hour ';    		
    		returnValue = returnValue + hours + hourString; 
    	}
    	
    	if( minutes > 0 ) {
    		var minuteString = ( minutes != 1 ) ? ' minutes ' : ' minute ';
    		returnValue = returnValue + minutes + minuteString; 
    	}
    	
    	if( seconds > 0 ) {
    		var secondsString = ( seconds != 1 ) ? ' seconds ' : ' second ';    		
    		returnValue = returnValue + seconds + secondsString; 
    	}
    	
    	return returnValue;
    }
}

function getExt( filename )
{
	var fileExt = filename.split('.').pop().toLowerCase();
	return fileExt;
}

function getBasename( string )
{
	var basename = string.replace(/\\/g,'/').replace(/.*\//, '');
	return basename;
}

function nameIsVideo( filename )
{
	var videoTypes = [
        'avi', 
	    'divx',
	    'flv',
	    'm2ts',	    
	    'm2v', 
	    'm4v', 
	    'mp4',	     
	    'mpeg',  
	    'mpg',	    
	    'mov',
	    'vob'	    
    ];
	
	var fileExt = getExt( filename );

	if( in_array( fileExt, videoTypes ) ) {
		return true;
	}

	return false;
}

function typeIsVideo( type )
{
	var res = type.match(/video/ig);
	if( res.length > 0 ) {
		return true;
	}
}

function get_avatar_from_service(service, userid, size) 
{
	// this return the url that redirects to the according user image/avatar/profile picture
	// implemented services: google profiles, facebook, gravatar, twitter, tumblr, default fallback
	// for google use get_avatar_from_service('google', profile-name or user-id , size-in-px )
	// for facebook use get_avatar_from_service('facebook', vanity url or user-id , size-in-px or size-as-word )
	// for gravatar use get_avatar_from_service('gravatar', md5 hash email@adress, size-in-px )
	// for twitter use get_avatar_from_service('twitter', username, size-in-px or size-as-word )
	// for tumblr use get_avatar_from_service('tumblr', blog-url, size-in-px )
	// everything else will go to the fallback
	// google and gravatar scale the avatar to any site, others will guided to the next best version
	var url = '';
	 
	switch (service) {
	 
		case "google":
			// see http://googlesystem.blogspot.com/2011/03/unedited-google-profile-pictures.html (couldn't find a better link)
			// available sizes: all, google rescales for you
			url = "http://profiles.google.com/s2/photos/profile/" + userid + "?sz=" + size;
			break;
		 
		case "facebook":
			// see https://developers.facebook.com/docs/reference/api/
			// available sizes: square (50x50), small (50xH) , normal (100xH), large (200xH)
			var sizeparam = '';
			if (isNumber(size)) {
				if (size >= 200) {
					sizeparam = 'large'
				};
			
				if (size >= 100 && size < 200) {
					sizeparam = 'normal'
				};
			
				if (size >= 50 && size < 100) {
					sizeparam = 'small'
				};
				
				if (size < 50) {
					sizeparam = 'square'
				};
			} else {
				sizeparam = size;
			}
			
			url = "https://graph.facebook.com/" + userid + "/picture?type=" + sizeparam;
			
			break;
		 
		case "gravatar":
			// see http://en.gravatar.com/site/implement/images/
			// available sizes: all, gravatar rescales for you
			url = "http://www.gravatar.com/avatar/" + userid + "?s=" + size;
			
			break;
		 
		case "twitter":
			// see https://dev.twitter.com/docs/api/1/get/users/profile_image/%3Ascreen_name
			// available sizes: bigger (73x73), normal (48x48), mini (24x24), no param will give you full size
			var sizeparam = '';
			if (isNumber(size)) {
				if (size >= 73) {
					sizeparam = 'bigger'
				};
				
				if (size >= 48 && size < 73) {
					sizeparam = 'normal'
				};
				
				if (size < 48) {
					sizeparam = 'mini'
				};
			} else {
				sizeparam = size;
			}
			 
			url = "http://api.twitter.com/1/users/profile_image?screen_name=" + userid + "&size=" + sizeparam;
			
			break;
		 
		case "tumblr":
			// see http://www.tumblr.com/docs/en/api/v2#blog-avatar
			//TODO do something smarter with the ranges
			// available sizes: 16, 24, 30, 40, 48, 64, 96, 128, 512
			var sizeparam = '';
			if (size >= 512) {
				sizeparam = 512
			};
			
			if (size >= 128 && size < 512) {
				sizeparam = 128
			};
			
			if (size >= 96 && size < 128) {
				sizeparam = 96
			};
			
			if (size >= 64 && size < 96) {
				sizeparam = 64
			};
			
			if (size >= 48 && size < 64) {
				sizeparam = 48
			};
			
			if (size >= 40 && size < 48) {
				sizeparam = 40
			};
			
			if (size >= 30 && size < 40) {
				sizeparam = 30
			};
			
			if (size >= 24 && size < 30) {
				sizeparam = 24
			};
			
			if (size < 24) {
				sizeparam = 16
			};
			 
			url = "http://api.tumblr.com/v2/blog/" + userid + "/avatar/" + sizeparam;
		break;
		 
		default:
			// http://www.iconfinder.com/icondetails/23741/128/avatar_devil_evil_green_monster_vampire_icon
			// find your own
			url = "http://i.imgur.com/RLiDK.png"; // 48x48
	}
	 
	 
	return url;
}

function randomString( string_length ) 
{
	if( typeof string_length === 'undefined' ) {
		var string_length = 8;
	}
	
	var chars			= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
	var randomString	= '';
	
	for( var i = 0; i < string_length; i++ ) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomString += chars.substring(rnum,rnum+1);
	}
	
	return randomString;
}

function find_index(array, string) 
{
    var i = 0;
    for(i=0;i<array.length;i++) {
    	if(array[i]==string) break;
    }
    
    return array[i] == string ? i : -1;
}

function isNumber(n) 
{
	// see http://stackoverflow.com/questions/18082/validate-numbers-in-javascript-isnumeric
	return !isNaN(parseFloat(n)) && isFinite(n);
}

function getFormMetadata( formObject )
{
	var metadata	= new Array();	
	var objects		= formObject.find('input[data-metadata="1"]');
	
	if( objects.length > 0 ) {
		objects.each( function( index, value ) {
			var id		= $(this).attr('id');
			var myValue = trim( $(this).val() );
			var name	= $(this).attr('name');
			
			if( myValue.length > 0 ) {
				var subObject = {
				    name: name, 
				    value: myValue
				}
				
				metadata.push( subObject );
			}	
		});		
	}

	return metadata;
}

function changeYouTubeIframeWidth( percent )
{
	$('iframe').each(function() {
		var url = $(this).attr('src');
		if( url.match(/youtube/g) ) {	        
			$(this).css({
				'width': percent + '%'
			});						
		} 					
    });	
}

function is_object( string )
{
	var matches = string.match(/(<object.*?>.*?<\/object>)/gi);
	if( !is_null( matches ) ) {
		return true;
	}
	
	return false;
}

function strip_html_tags( string ) 
{
	var tagBody = '(?:[^"\'>]|"[^"]*"|\'[^\']*\')*';
	var tagOrComment = new RegExp(
	    '<(?:'
	    // Comment body.
	    + '!--(?:(?:-*[^->])*--+|-?)'
	    // Special "raw text" elements whose content should be elided.
	    + '|script\\b' + tagBody + '>[\\s\\S]*?</script\\s*'
	    + '|style\\b' + tagBody + '>[\\s\\S]*?</style\\s*'
	    // Regular name
	    + '|/?[a-z]'
	    + tagBody
	    + ')>',
	    'gi');
	  var oldHtml;
	  do {
	    oldHtml	= string;
	    string	= string.replace( tagOrComment, '' );
	  } while ( string !== oldHtml );
	  return string.replace(/</g, '&lt;');
}

function is_iframe( string )
{
	var matches = string.match(/(<iframe.*?>.*?<\/iframe>)/gi);
	if( !is_null( matches ) ) {
		return true;
	}
	
	return false;	
}

function disable_neighboring_tabs( element )
{
	element.find('li').not('.active').children('a').removeAttr('data-toggle');
	element.find('li').not('.active').addClass('disabled noBlockUI');	
}

function enable_neighboring_tabs( element )
{
	element.find('li').not('.active').children('a').attr('data-toggle', 'tab');
	element.find('li').not('.active').removeClass('disabled');	
}

function rumble( selector, duration )
{
	if( typeof duration === 'undefined' ) {
		var duration = 1000;
	} else {
		duration = parseInt( duration );
		duration = ( duration > 0 ) ? duration : 1000;
	}
	
	selector.jrumble({
		x: 4,
		y: 0,
		rotation: 0,
		speed: 30
	});
	selector.trigger('startRumble'); 
	setTimeout(function() { 
		selector.trigger('stopRumble'); 
	}, duration);	
}

function scrollToTop()
{
	if( IS_MOBILE == 1 ) {		
		window.scrollTo( 0, 0 );					
		$.unblockUI();
	} else {		
		$('html').animate({
		scrollTop: 0 
		}, 'slow', function() {
			
			// fallback
			window.scrollTo( 0, 0 );
			
			$.unblockUI();
		});			
	}
}

function scrollToElement( elementName )
{
	$('html, body').animate({
	    scrollTop: $('#' + elementName).offset().top
	}, 'slow');	
}

function percentOfDocumentHeight( percent )
{
	return ( ( $(document).height() / 100 ) * percent );	
}

function percentOfDocumentWidth( percent )
{
	return ( ( $(document).width() / 100 ) * percent );	
}

function checkDestinationPerms()
{
	var returnVal = null;
	
	$.ajax({
		type: 'POST',
		url: BASEURL + '/media/ajax',
		data: { method: 'checkDestinationPerms' },
		complete: function( jqXHR, textStatus ) {
			
		},
		success: function( response, textStatus, jqXHRresponse ) {
			
			if( response.status == 'OK' ) {
				returnVal = response.message;					
			}
			
			return returnVal;						
		},
		error: function(  jqXHR, textStatus, errorThrown ) {

		},		
		dataType: 'json'
	});	
}

function isValidEmailAddress(emailAddress) 
{
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
}

function fetchTranslation( string )
{
	if( typeof SITE_PHRASES === 'undefined' ) {
		return string;
	}
	
	var tempString = strtolower( string );
	
	if( array_key_exists( tempString, SITE_PHRASES ) ) {
		return SITE_PHRASES[tempString];
	}
	
	return string;
}

function translate( string )
{
	return fetchTranslation( string );
}

function generateRandomString( stringLen )
{
	var keylist		= '<>@!"\'=(){}$%&#+-.:,;_|?-\/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	var password	= '';

	if( typeof stringLen === 'undefined' ) {
		var stringLen = rand( 8, 25 );
	}
	
	for( i = 0; i < stringLen; i++ ) {
		password += keylist.charAt( Math.floor( Math.random() * keylist.length ) );		
	}
	
	password = trim( password );
	if( password.length < 8 ) {
		generateRandomString();
	} else {		
		return password;		
	}
}

function percentOfWindowHeight( percent )
{
	return ( ( $(window).height() / 100 ) * percent );	
}

function percentOfWindowWidth( percent )
{
	return ( ( $(window).width() / 100 ) * percent );	
}

function unixTimestampToDate(timestamp)
{
	var date = new Date( timestamp * 1000 );
	return date;
}

function display_error_dialog( text )
{
	if( typeof text === 'undefined' ) {
		var text = 'An error has occurred. <br>Contact Technical Support if this issue persists.';
	}
	
	// START:	Error Display	
	var html	= text;
	var $dialog = $('<div></div>')
	.html( html )
	.dialog({
		title: '<i class="fa fa-exclamation-triangle"></i> ERROR',
		minWidth: percentOfWindowWidth( 50 ),
		minHeight: percentOfWindowHeight( 40 ),
		modal: true,
		autoOpen: true,
		zIndex: 2147483640,
		buttons: {
			 OK: function() {
				 $(this).dialog('close');
			 }
		},
		open: function() {
			// http://stackoverflow.com/questions/4103964/icons-in-jquery-ui-dialog-title
			$('.ui-dialog .ui-dialog-title .ui-icon').css({
				'float': 'left',
			    'margin-right': '4px'
			});
	        
	        $('.ui-dialog-buttonpane').
	        	find('button:contains("OK")').button({
	        		icons: {
	        			primary: 'ui-icon-circle-close'
	        		}
	        });				                
		}
	});				
	// END:		Error Display	
}

function noHover() 
{
    return this.is(':hover') ? this.wait('mouseleave') : this;
}

// @link	http://www.plupload.com/examples/events#source
function plupload_log() 
{
    var str = '';

    plupload.each(arguments, function(arg) {
        var row = '';

        if (typeof(arg) != "string") {
            plupload.each(arg, function(value, key) {
                // Convert items in File objects to human readable form
                if (arg instanceof plupload.File) {
                    // Convert status to human readable
                    switch (value) {
                        case plupload.QUEUED:
                            value = 'QUEUED';
                            break;

                        case plupload.UPLOADING:
                            value = 'UPLOADING';
                            break;

                        case plupload.FAILED:
                            value = 'FAILED';
                            break;

                        case plupload.DONE:
                            value = 'DONE';
                            break;
                    }
                }

                if (typeof(value) != "function") {
                    row += (row ? ', ' : '') + key + '=' + value;
                }
            });

            str += row + " ";
        } else {
            str += arg + " ";
        }
    });
    
    console.info( str );
}

String.IsNullOrEmpty = function(value) {
	  var isNullOrEmpty = true;
	  if (value) {
	   if (typeof (value) == 'string') {
	    if (value.length > 0)
	     isNullOrEmpty = false;
	   }
	  }
	  
	  return isNullOrEmpty;
}

/**
 * Returns a random number between min (inclusive) and max (exclusive)
*/
function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
}

/**
 * Returns a random integer between min (inclusive) and max (inclusive)
 * Using Math.round() will give you a non-uniform distribution!
*/
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

Array.prototype.remove = function(value) {
    if (this.indexOf(value)!==-1) {
       this.splice(this.indexOf(value) );
       return true;
   } else {
      return false;
   };
} 

if(!Array.indexOf) { 
    Array.prototype.indexOf = function(obj){
        for(var i=0; i < this.length; i++){
            if(this[i]==obj){
                return i;
            }
        }
        return -1;
    };
}