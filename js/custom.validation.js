/**
 * BizLogic Base Framework
 * Custom JavaScript
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2013 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://cosmicloaf.com
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Wednesday, September 30, 2013, 12:55 PM GMT+1
 * @modified    $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: custom.validation.js 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 *
 * @category    JavaScript
 * @package     BizLogic Framework
*/

/**
 * Determine if a form is valid
 * 
 * @param	string	formId
 * @return	boolean
*/
function formIsValid( formId )
{
	var errors		= new Array();	
	var required	= $('#' + formId).find('input[required], input[data-required="1"], textarea[required], textarea[data-required="1"], select[required], select[data-required="1"]');
	var dupes		= $('#' + formId).find('input[data-duplicate="1"], input[data-dupe="1"], textarea[data-duplicate="1"], textarea[data-dupe="1"], select[data-duplicate="1"], select[data-dupe="1"]');
	
	if( !empty( required ) ) {
		required.each( function( index, value ) {
			var id		= $(this).attr('id');
			var myValue = trim( $(this).val() );
			
			if( !strlen( myValue ) ) {
				$('#' + id).addClass('inputError');
				errors.push( id );
			} else {
				if( $(this).data('type') == 'email' ) {
					if( isValidEmailAddress( myValue ) ) {
						$('#' + id).removeClass('inputError');							
					} else {
						errors.push( id );
						$('#' + id).addClass('inputError');							
					}						
				}
				
				if( typeof $(this).data('rules') !== 'undefined' ) {
					var rules = $(this).data('rules');
					switch( rules ) {
						case 'alphaNumericAllowDash':
							if( !isAlphaNumericCustom( myValue ) ) {
								$('#' + id).addClass('inputError');
								errors.push( id );	
							}
							
							break;
					}
				}
				
				if( typeof $(this).data('duplicate') !== 'undefined' ) {
					var dupeId = $(this).data('duplicate');
										
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );							
						$('#' + id).addClass('inputError');
						$('#' + dupeId).addClass('inputError');
					} else {
						$('#' + id).removeClass('inputError');
						$('#' + dupeId).removeClass('inputError');						
					}
				} else if( typeof $(this).data('dupe') !== 'undefined' ) {
					var dupeId = $(this).data('dupe');
										
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );							
						$('#' + id).addClass('inputError');
						$('#' + dupeId).addClass('inputError');
					} else {
						$('#' + id).removeClass('inputError');
						$('#' + dupeId).removeClass('inputError');						
					}
				}
			}
			
			var type = strtolower( $('#' + id).prop('tagName') );
			switch( type ) {
				case 'select':
					$('#' + id).change(function() {
						var myValue = trim( $(this).val() );
						if( strlen( myValue ) ) {
							if( $(this).data('type') != 'email' ) {
								$('#' + id).removeClass('inputError');						
							} else {
								if( isValidEmailAddress( myValue ) ) {
									$('#' + id).removeClass('inputError');							
								} else {
									$('#' + id).addClass('inputError');							
								}
							}	
						} else {
							$('#' + id).addClass('inputError');					
						}						
					});
					
					break;
					
				default:
					$('#' + id).bind('keyup paste', function() {
						var myValue = trim( $(this).val() );
						if( strlen( myValue ) ) {
							if( $(this).data('type') != 'email' ) {
								$('#' + id).removeClass('inputError');						
							} else {
								if( isValidEmailAddress( myValue ) ) {
									$('#' + id).removeClass('inputError');							
								} else {
									$('#' + id).addClass('inputError');							
								}
							}	
						} else {
							$('#' + id).addClass('inputError');					
						}
					});						
			}
		
		});		
	}
	
	var errorSize = errors.length;
	if( errorSize > 0 ) {		
		$.each(errors, function( index, value ) {
			var element = $('#' + value);
			element.addClass('inputError');
		});
		
		return false;
	} else {
		required.each( function( index, value ) {
			var id = $(this).attr('id');
			$('#' + id).removeClass('inputError');
		});
		
		return true;		
	}	
}

function getFormErrors( formId )
{
	var errors		= new Array();	
	var required	= $('#' + formId).find('input[required], input[data-required="1"], textarea[required], textarea[data-required="1"], select[required], select[data-required="1"]');
	
	if( !empty( required ) ) {
		required.each( function( index, value ) {
			var id		= $(this).attr('id');
			var myValue = trim( $(this).val() );
			
			if( !strlen( myValue ) ) {
				errors.push( id );
			} else {
				if( $(this).data('type') == 'email' ) {
					if( !isValidEmailAddress( myValue ) ) {
						errors.push( id );							
					}				
				}
				
				if( typeof $(this).data('rules') !== 'undefined' ) {
					var rules = $(this).data('rules');
					switch( rules ) {
						case 'alphaNumericAllowDash':
							if( !isAlphaNumericCustom( myValue ) ) {
								errors.push( id );	
							}
							
							break;
					}
				}				
				
				if( typeof $(this).data('duplicate') !== 'undefined' ) {
					var dupeId = $(this).data('duplicate');
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );							
					}
				} else if( typeof $(this).data('dupe') !== 'undefined' ) {
					var dupeId = $(this).data('dupe');
					if( $(this).val() != $('#' + dupeId).val() ) {					
						errors.push( id );
						errors.push( dupeId );							
					}
				}
			}
		});		
	}
	
	return errors;
}

function isAlphaNumericCustom( string )
{
	return string.match( /^[_-a-zA-Z0-9]+$/ );	
}

function isAlphaNumeric( string )
{
	return string.match( /^[a-zA-Z0-9]+$/ );	
}