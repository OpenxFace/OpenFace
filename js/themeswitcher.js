/* jQuery plugin themeswitcher
---------------------------------------------------------------------*/
$.fn.themeswitcher = function(settings) {
	var options = jQuery.extend({
		loadTheme: null,
		selectText: 'Theme',
		cssId: 'theme-url',
		localCssPath: null,
		localThemes: new Array(),
		useGoogleCDN: false,
		useSelectBoxIt: false,
		width: 150,
		height: 200,
		buttonPreText: 'Theme: ',
		closeOnSelect: true,
		buttonHeight: 14,
		cookieName: 'jquery-ui-theme',
		onOpen: function(){},
		onClose: function(){},
		onSelect: function(){},
		onSelectComplete: function(){},
		cookieExpires: 365,
		cookiePath: '/',		
		cookieOnSet: function(){},
		appendThemes: function() {}
	}, settings);
	
	var googleCdnThemes					= new Array();		
	googleCdnThemes['base']				= 'Base'; 
	googleCdnThemes['black-tie']		= 'Black Tie';
	googleCdnThemes['blitzer']			= 'Blitzer';
	googleCdnThemes['cupertino']		= 'Cupertino';
	googleCdnThemes['dark-hive']		= 'Dark Hive';
	googleCdnThemes['dot-luv']			= 'Dot Luv';
	googleCdnThemes['eggplant']			= 'Eggplant';
	googleCdnThemes['excite-bike']		= 'Excite Bike';
	googleCdnThemes['flick']			= 'Flick';
	googleCdnThemes['hot-sneaks']		= 'Hot Sneaks';
	googleCdnThemes['humanity']			= 'Humanity';
	googleCdnThemes['le-frog']			= 'Le Frog';
	googleCdnThemes['mint-choc']		= 'Mint Choc';
	googleCdnThemes['overcast']			= 'Overcast';
	googleCdnThemes['pepper-grinder']	= 'Pepper Grinder';
	googleCdnThemes['redmond']			= 'Redmond';
	googleCdnThemes['smoothness']		= 'Smoothness';
	googleCdnThemes['south-street']		= 'South Street';
	googleCdnThemes['start']			= 'Start';
	googleCdnThemes['swanky-purse']		= 'Swanky Purse';
	googleCdnThemes['trontastic']		= 'Trontastic';
	googleCdnThemes['ui-darkness']		= 'UI Darkness';
	googleCdnThemes['ui-lightness']		= 'UI Lightness';
	googleCdnThemes['vader']			= 'Vader';
	
	// START:	sort the array alphabetically
	var ALL_THEMES = new Array();
	
	for(key in options.localThemes) {
		ALL_THEMES[key] = options.localThemes[key];			 
	}	
	
	if( options.useGoogleCDN ) {
		for(key in googleCdnThemes) {
			// remove existing theme from global array
			if( array_key_exists( key, ALL_THEMES ) ) {
				ALL_THEMES.splice( key, 1 );	
			}
			
			// remove existing theme from the local array
			if( array_key_exists( key, options.localThemes ) ) {
				options.localThemes.splice( key, 1 );	
			}		 
		}
	}
	
	ALL_THEMES.sort();
	// END:		sort the array alphabetically	
	
	if( $.cookie(options.cookieName) || options.loadTheme ) {
		var themeName = $.cookie(options.cookieName) || options.loadTheme;
	}
	
	var optionValueText = '';
	
	// START:	create select menu
	for(key in ALL_THEMES) {
		var selected = '';
		if( key == themeName ) {
			selected = 'selected="selected"';
		}
		optionValueText = optionValueText + '<option value="'+key+'"' + selected + '>'+ALL_THEMES[key]+'</option>';			 
	}
	// END:		create select menu
	
	var switcherpane = $('<select class="jquery-ui" autocomplete="off"><option value="">'+options.selectText+'</option>'+optionValueText+'</select>');

	//show/hide panel functions
	$.fn.spShow = function(){ options.onOpen(); }
	$.fn.spHide = function(){ options.onClose(); }
	
		
	/* Theme Loading
	---------------------------------------------------------------------*/
	switcherpane.change(function() {		
		var themeDisplayName	= $(this).text();
		var themeName			= $(this).val();
		
		if( !strlen( trim( themeName ) ) ) {
			return false;
		}
		
		updateCSS( themeName );
		
		$.cookie(options.cookieName, themeName, { expires: options.cookieExpires, path: options.cookiePath, onSet: options.cookieOnSet });		
		if(options.onSelect){ options.onSelect(); }
		if(options.onSelectComplete){ options.onSelectComplete(); }		
		if(options.closeOnSelect && switcherpane.is(':visible')){ switcherpane.spHide(); }
		options.appendThemes(switcherpane);
		
		return false;
	});
	
	//function to append a new theme stylesheet with the new style changes
	function updateCSS(locStr) {
		if( options.useGoogleCDN ) {
			if( !array_key_exists( locStr, options.localThemes ) ) {
	    		$('#'+options.cssId).attr('href', '//ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/'+locStr+'/jquery-ui.css');
			} else if ( !array_key_exists( locStr, BOOTSTRAP_THEMES ) ) {
	    		$('#'+options.cssId).attr('href', options.localCssPath + '/' + locStr + '/jquery-ui.css');				
			} else {
				$('#'+options.cssId).attr('href', BASEURL + '/css/bootstrap/themes/' + locStr + '/bootrap.min.css');				
			}
		} else {
			if ( !array_key_exists( locStr, BOOTSTRAP_THEMES ) ) {			
				$('#'+options.cssId).attr('href', BASEURL + '/css/bootstrap/themes/' + locStr + '/bootrap.min.css');
			} else {
			$('#'+options.cssId).attr('href', options.localCssPath + '/' + locStr + '/jquery-ui.css');			
			}			
		}
		
		if( options.useSelectBoxIt ) {
			if( locStr != 'instagram' ) {			
				$('select').selectBoxIt({
				    // Uses the jQueryUI theme for the drop down
				    theme: 'jqueryui'
				});			
			}
		}
	}	

	$(this).append(switcherpane);
	
	if( options.useSelectBoxIt ) {
		if( $.cookie(options.cookieName) != 'instagram' && options.loadTheme != 'instagram' ) {
			$('select.jquery-ui').selectBoxIt({
			    theme: 'jqueryui'
			});	
		}
	}
	
	if( $.cookie(options.cookieName) || options.loadTheme ) {
		var themeName = $.cookie(options.cookieName) || options.loadTheme;
	}

	return this;
	
	// @link
	function removeTheme(themeName) 
	{
		$(this).find('[value="'+themeName+'"]').remove();
	} 	
};

function trim (str, charlist) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   improved by: mdsjack (http://www.mdsjack.bo.it)
	  // +   improved by: Alexander Ermolaev (http://snippets.dzone.com/user/AlexanderErmolaev)
	  // +      input by: Erkekjetter
	  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +      input by: DxGx
	  // +   improved by: Steven Levithan (http://blog.stevenlevithan.com)
	  // +    tweaked by: Jack
	  // +   bugfixed by: Onno Marsman
	  // *     example 1: trim('    Kevin van Zonneveld    ');
	  // *     returns 1: 'Kevin van Zonneveld'
	  // *     example 2: trim('Hello World', 'Hdle');
	  // *     returns 2: 'o Wor'
	  // *     example 3: trim(16, 1);
	  // *     returns 3: 6
	  var whitespace, l = 0,
	    i = 0;
	  str += '';

	  if (!charlist) {
	    // default list
	    whitespace = " \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000";
	  } else {
	    // preg_quote custom list
	    charlist += '';
	    whitespace = charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1');
	  }

	  l = str.length;
	  for (i = 0; i < l; i++) {
	    if (whitespace.indexOf(str.charAt(i)) === -1) {
	      str = str.substring(i);
	      break;
	    }
	  }

	  l = str.length;
	  for (i = l - 1; i >= 0; i--) {
	    if (whitespace.indexOf(str.charAt(i)) === -1) {
	      str = str.substring(0, i + 1);
	      break;
	    }
	  }

	  return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

function strlen (string) {
	  // http://kevin.vanzonneveld.net
	  // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   improved by: Sakimori
	  // +      input by: Kirk Strobeck
	  // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // +   bugfixed by: Onno Marsman
	  // +    revised by: Brett Zamir (http://brett-zamir.me)
	  // %        note 1: May look like overkill, but in order to be truly faithful to handling all Unicode
	  // %        note 1: characters and to this function in PHP which does not count the number of bytes
	  // %        note 1: but counts the number of characters, something like this is really necessary.
	  // *     example 1: strlen('Kevin van Zonneveld');
	  // *     returns 1: 19
	  // *     example 2: strlen('A\ud87e\udc04Z');
	  // *     returns 2: 3
	  var str = string + '';
	  var i = 0,
	    chr = '',
	    lgth = 0;
	
	  if (!this.php_js || !this.php_js.ini || !this.php_js.ini['unicode.semantics'] || this.php_js.ini['unicode.semantics'].local_value.toLowerCase() !== 'on') {
	    return string.length;
	  }
	
	  var getWholeChar = function (str, i) {
	    var code = str.charCodeAt(i);
	    var next = '',
	  prev = '';
	if (0xD800 <= code && code <= 0xDBFF) { // High surrogate (could change last hex to 0xDB7F to treat high private surrogates as single characters)
	  if (str.length <= (i + 1)) {
	    throw 'High surrogate without following low surrogate';
	  }
	  next = str.charCodeAt(i + 1);
	  if (0xDC00 > next || next > 0xDFFF) {
	    throw 'High surrogate without following low surrogate';
	  }
	  return str.charAt(i) + str.charAt(i + 1);
	} else if (0xDC00 <= code && code <= 0xDFFF) { // Low surrogate
	  if (i === 0) {
	    throw 'Low surrogate without preceding high surrogate';
	  }
	  prev = str.charCodeAt(i - 1);
	  if (0xD800 > prev || prev > 0xDBFF) { //(could change last hex to 0xDB7F to treat high private surrogates as single characters)
	    throw 'Low surrogate without preceding high surrogate';
	  }
	  return false; // We can pass over low surrogates now as the second component in a pair which we have already processed
	    }
	    return str.charAt(i);
	  };
	
	  for (i = 0, lgth = 0; i < str.length; i++) {
	    if ((chr = getWholeChar(str, i)) === false) {
	      continue;
	    } // Adapt this line at the top of any loop, passing in the whole string and the current iteration and returning a variable to represent the individual character; purpose is to treat the first part of a surrogate pair as the whole character and then ignore the second part
	    lgth++;
	  }
	  return lgth;
}