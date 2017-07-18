/**
 * jQuery AutoLink
 *
 * @link	https://github.com/MarQuisKnox/jQuery.AutoLink
 * @license	MIT <http://en.wikipedia.org/wiki/MIT_License>
 *
 * @copyright	2013 - 2015 Andreas Savvides et al
 * @copyright	2014 - 2017 MarQuis Knox
 */

(function($) {

    'use strict';

    var HASHTAG_REGEX   = /(^|\s|\(|>)#([a-zA-Z0-9-.]+)/g;
    var URL_REGEX       = /(<a href=")?(?:(^|[ ]|\n|<br(\s+\/)?>))(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?((\?|\/)(.*))?/gi;
    var MENTION_REGEX   = /(?:(^|[ ]|\n|<br(\s+\/)?>))\B@([a-zA-Z0-9-.]+)/ig;
    var EMAIL_REGEX     = /(?:^|[ ]|\n|<br(\s+\/)>)([a-zA-Z0-9._\-!#$%&'*+-\/=?^_`{|}~"\\]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/ig;

    $.fn.autolink = function(options) {
        return this.each( function() {
            var $el			= $(this);
            var linkifiedContent	= _linkify( $el, options );

            $el.html( linkifiedContent );
        });
    };

    function _linkify( $el, options ) {
        var links = {
                local: {
                    baseUrl: '//' + window.location.host + '/',
                    hashtagSearchUrl: 'search/',
                    target: '_self',
                    scheme: '//'
                },
                twitter: {
                    baseUrl: "https://twitter.com/",
                    hashtagSearchUrl: "search?q=",
                    target: '_blank',
                    scheme: 'https://'
                },
                instagram: {
                    baseUrl: "http://instagram.com/",
                    hashtagSearchUrl: "explore/tags/",
                    target: '_blank',
                    scheme: 'http://'
                },
                github: {
                    baseUrl: "https://github.com/",
                    hashtagSearchUrl: null,
                    target: '_blank',
                    scheme: 'https://'
                }
            },
            defaultOptions = {
                mentions: true,
                hashtags: false,
                emails: true,
                urls: true,
                linkTo: 'local',
                target: '_self',
                scheme: '//'
            },
            extendedOptions = $.extend( defaultOptions, options ),
            elContent       = $el.html(),
            matches;

        // Linkify Hashtags
        if ( extendedOptions.hashtags ) {
            elContent = _linkifyHashtags( elContent, links[extendedOptions.linkTo], $el );
        }

        // Linkifying URLs
        if ( extendedOptions.urls ) {
            matches = elContent.match( URL_REGEX );

            if ( matches ) {
                elContent = _linkifyUrls( matches, $el, extendedOptions );
            }
        }

        // Linkify e-mails
        if ( extendedOptions.emails ) {
            if( _isEmail( elContent ) ) {
                elContent = _linkifyEmails( elContent, $el, extendedOptions );
            }
        }

        // Linkify Mentions
        if ( extendedOptions.mentions ) {
            if( _isMention( elContent ) ) {
                elContent = _linkifyMentions( elContent, links[extendedOptions.linkTo].baseUrl, $el, extendedOptions );
            }
        }

        return elContent;
    }

    function _hasScheme( url ) {
        var regEx = /ed2k|ftp|http|https|news|nntp/;
        if( url.match( regEx ) ) {
            return true;
        }

        return false;
    }

    function _isEmbed( url ) {

        // check for Dailymotion embed
        var isDailymotionEmbed	= url.match( /dailymotion\.com\/embed/ig );
        isDailymotionEmbed		= ( isDailymotionEmbed !== null ) ? true : false;

        if( isDailymotionEmbed ) {
            return true;
        }

        // check for SoundCloud embed
        var isSoundCloudEmbed	= url.match( /w\.soundcloud\.com\/player|api\.soundcloud\.com/ig );
        isSoundCloudEmbed		= ( isSoundCloudEmbed !== null ) ? true : false;

        if( isSoundCloudEmbed ) {
            return true;
        }

        // check for Vimeo embed
        var isVimeoEmbed = url.match( /player\.vimeo\.com\/video/ig );
        isVimeoEmbed = ( isVimeoEmbed !== null ) ? true : false;

        if( isVimeoEmbed ) {
            return true;
        }

        var isVevoEmbed = url.match( /cache\.vevo\.com/ig );
        if( isVevoEmbed ) {
            return true;
        }

        // check for YouTube embed
        var isYouTubeEmbed	= url.match( /youtube\.com\/embed|youtube\-nocookie\.com\/embed/ig );
        isYouTubeEmbed		= ( isYouTubeEmbed !== null ) ? true : false;

        if( isYouTubeEmbed ) {
            return true;
        }

        return false;

    }

    function _linkifyUrls( matches, $el, linkObj )
    {
        var elContent = $el.html();
        matches = array_unique( matches );

        $.each( matches, function( index, value ) {

            // check if embed
            var isEmbed = _isEmbed( value );

            // check for scheme
            var scheme = ( _hasScheme( value ) ) ? '' : linkObj.scheme;

            // trim
            var text = value.trim();

            // remove certain chars
            text = text.replace( '<br>', '' );

            if ( !isEmbed && value.length > 0 ) {
                elContent = elContent.split( new RegExp( value ) ).join( '<a class="linkified" href="' + scheme + text + '" target="'+ linkObj.target +'">'+ value +'</a>' );
            }

        });

        return elContent;
    }

    function _isEmail( string )
    {
        var isEmail = string.match( EMAIL_REGEX );

        if( isEmail ) {
            return true;
        }

        return false;
    }

    function _getEmails( string )
    {
        var emails = string.match( EMAIL_REGEX );

        if( emails ) {
            return emails;
        }

        return null;
    }

    function _isMention( string )
    {
        var isMention = string.match( MENTION_REGEX );

        if( isMention ) {
            return true;
        }

        return false;
    }

    function _getMentions( string )
    {
        var mentions = string.match( MENTION_REGEX );

        if( mentions ) {
            return mentions;
        }

        return null;
    }

    // Find any mentions (e.g. @andreassavvides) and turn them into links that
    // refer to the appropriate social profile (e.g. twitter or instagram).
    function _linkifyMentions( text, baseUrl, element, options ) {
        var newContent = text;

        if( !element.hasClass('parsed') && !element.hasClass('autoLinked') && !element.hasClass('linkified') ) {
            // get mentions
            var mentions = _getMentions( text );

            // if mentions
            if( mentions ) {
                $.each( mentions, function( index, value ) {
                    // trim
                    var trimmedText = value.trim();

                    // replace @ sign
                    var link = trimmedText.replace('@', '');

                    // replace breaks
                    link = link.replace('<br>', '');

                    // replacement text
                    var replacement = '<a class="linkified" href="' + baseUrl + link + '" target="'+ options.target +'">'+ value +'</a>';

                    // new content
                    newContent = newContent.replaceAllByRegex( MENTION_REGEX, replacement, element.html() );
                });
            }
        }

        return newContent;
    }

    function _linkifyEmails( text, element, options ) {
        var newContent = text;

        if( !element.hasClass('parsed') && !element.hasClass('autoLinked') && !element.hasClass('linkified') ) {
            var emails = _getEmails( text );

            if( emails ) {
                $.each( emails, function( index, value ) {
                    // trim
                    var trimmedText = value.trim();

                    // replace breaks
                    var link = trimmedText.replace('<br>', '');

                    // replacement text
                    var replacement = '<a class="linkified" href="mailto:' + link + '" target="'+ options.target +'">'+ value +'</a>';

                    // new content
                    newContent = newContent.replaceAllByRegex( EMAIL_REGEX, replacement, element.html() );
                });
            }
        }

        return newContent;
    }

    // Find any hashtags (e.g. #linkyrocks) and turn them into links that refer
    // to the appropriate social profile.
    function _linkifyHashtags( text, links, element ) {

        if( typeof text === 'undefined' ) {
            return;
        }

        // If there is no search URL for a hashtag, there isn't much we can do
        if ( links.hashtagSearchUrl === null ) {
            return text;
        }

        //if ( !element.hasClass('linkified') && element.find('a[href="' + this + '"]').length === 0 ) {
        return text.replace( HASHTAG_REGEX, "$1<a class='linkified' href='" + links.baseUrl + links.hashtagSearchUrl + "$2' target='"+ links.target +"'>#$2</a>");
        //}
    }

    function array_unique (inputArr) {
        var key = ''
        var tmpArr2 = {}
        var val = ''
        var _arraySearch = function (needle, haystack) {
            var fkey = ''
            for (fkey in haystack) {
                if (haystack.hasOwnProperty(fkey)) {
                    if ((haystack[fkey] + '') === (needle + '')) {
                        return fkey
                    }
                }
            }
            return false
        }
        for (key in inputArr) {
            if (inputArr.hasOwnProperty(key)) {
                val = inputArr[key]
                if (_arraySearch(val, tmpArr2) === false) {
                    tmpArr2[key] = val
                }
            }
        }
        return tmpArr2
    }

    function array_walk (array, funcname, userdata) {
        var key, value, ini

        if (!array || typeof array !== 'object') {
            return false
        }
        if (typeof array === 'object' && array.change_key_case) {
            // Duck-type check for our own array()-created PHPJS_Array
            if (arguments.length > 2) {
                return array.walk(funcname, userdata)
            } else {
                return array.walk(funcname)
            }
        }

        try {
            if (typeof funcname === 'function') {
                for (key in array) {
                    if (arguments.length > 2) {
                        funcname(array[key], key, userdata)
                    } else {
                        funcname(array[key], key)
                    }
                }
            } else if (typeof funcname === 'string') {
                this.php_js = this.php_js || {}
                this.php_js.ini = this.php_js.ini || {}
                ini = this.php_js.ini['phpjs.no-eval']
                if (ini && (
                        parseInt(ini.local_value, 10) !== 0 && (!ini.local_value.toLowerCase || ini.local_value.toLowerCase() !==
                        'off')
                    )) {
                    if (arguments.length > 2) {
                        for (key in array) {
                            this.window[funcname](array[key], key, userdata)
                        }
                    } else {
                        for (key in array) {
                            this.window[funcname](array[key], key)
                        }
                    }
                } else {
                    if (arguments.length > 2) {
                        for (key in array) {
                            eval(funcname + '(array[key], key, userdata)')
                        }
                    } else {
                        for (key in array) {
                            eval(funcname + '(array[key], key)')
                        }
                    }
                }
            } else if (funcname && typeof funcname === 'object' && funcname.length === 2) {
                var obj = funcname[0],
                    func = funcname[1]
                if (arguments.length > 2) {
                    for (key in array) {
                        obj[func](array[key], key, userdata)
                    }
                } else {
                    for (key in array) {
                        obj[func](array[key], key)
                    }
                }
            } else {
                return false
            }
        } catch (e) {
            return false
        }

        return true;
    }

    function trim (str, charlist) {
        var whitespace = [
            ' ',
            '\n',
            '\r',
            '\t',
            '\f',
            '\x0b',
            '\xa0',
            '\u2000',
            '\u2001',
            '\u2002',
            '\u2003',
            '\u2004',
            '\u2005',
            '\u2006',
            '\u2007',
            '\u2008',
            '\u2009',
            '\u200a',
            '\u200b',
            '\u2028',
            '\u2029',
            '\u3000'
        ].join('')
        var l = 0
        var i = 0
        str += ''
        if (charlist) {
            whitespace = (charlist + '').replace(/([[\]().?/*{}+$^:])/g, '$1')
        }
        l = str.length
        for (i = 0; i < l; i++) {
            if (whitespace.indexOf(str.charAt(i)) === -1) {
                str = str.substring(i)
                break
            }
        }
        l = str.length
        for (i = l - 1; i >= 0; i--) {
            if (whitespace.indexOf(str.charAt(i)) === -1) {
                str = str.substring(0, i + 1)
                break
            }
        }
        return whitespace.indexOf(str.charAt(0)) === -1 ? str : ''
    }

    function preg_quote (str, delimiter) {
        return String(str)
            .replace(new RegExp('[.\\\\+*?\\[\\^\\]$(){}=!<>|:\\' + (delimiter || '') + '-]', 'g'), '\\$&')
    }

    String.prototype.replaceAllByRegex = function(search, replacement) {
        var target = this;
        return target.replace(new RegExp(search, 'g'), replacement);
    };

    String.prototype.replaceAll = function(search, replacement) {
        var target = this;
        return target.split(search).join(replacement);
    };

}(jQuery));