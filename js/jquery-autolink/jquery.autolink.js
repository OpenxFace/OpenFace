/**
 * jQuery AutoLink
 *
 * @link	https://github.com/MarQuisKnox/jQuery.AutoLink
 * @license	MIT <http://en.wikipedia.org/wiki/MIT_License>
 *
 * @copyright	2013 - 2015 Andreas Savvides et al
 * @copyright	2014 - 2015 MarQuis Knox
 */

(function($) {

    'use strict';

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
                urls: true,
                linkTo: 'local',
                target: '_self',
                scheme: '//'
            },
            extendedOptions = $.extend(defaultOptions, options),
            elContent = $el.html(),

            // @link	http://snipplr.com/view/68530/regular-expression-for-matching-urls-with-or-without-https
            urlRegEx = /(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?((\?|\/)(.*))?/gi,
            matches;

        // Linkifying URLs
        if ( extendedOptions.urls ) {
            matches = elContent.match( urlRegEx );
            if ( matches ) {
                elContent = _linkifyUrls( matches, $el, extendedOptions );
            }
        }

        // Linkify Mentions
        if ( extendedOptions.mentions ) {
            if( _isMention( elContent ) ) {
                elContent = _linkifyMentions( elContent, links[extendedOptions.linkTo].baseUrl, $el, extendedOptions );
            }
        }

        // Linkify Hashtags
        if ( extendedOptions.hashtags ) {
            elContent = _linkifyHashtags( elContent, links[extendedOptions.linkTo], $el );
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
        $.each( matches, function( index, value ) {

            // check if embed
            var isEmbed = _isEmbed( value );

            // check for scheme
            var scheme = ( _hasScheme( value ) ) ? '' : linkObj.scheme;

            if ( !isEmbed && $el.find('a[href="' + scheme + this + '"]').length === 0 ) {
                elContent = elContent.replace( this, '<a class="linkified" href="' + scheme + this + '" target="'+ linkObj.target +'">' + this + '</a>' );
            }

        });

        return elContent;
    }

    function _isMention( string )
    {
        var regEx		= /@(\w+)/ig;
        var isMention	= string.match( regEx );

        if( isMention ) {
            return true;
        }

        return false;
    }

    function _getMentions( string )
    {
        var regEx		= /@(\w+)/ig;
        var mentions	= string.match( regEx );

        if( mentions ) {
            return mentions;
        }

        return null;
    }

    // Find any mentions (e.g. @andreassavvides) and turn them into links that
    // refer to the appropriate social profile (e.g. twitter or instagram).
    function _linkifyMentions( text, baseUrl, element, options ) {
        if( !element.hasClass('parsed') && !element.hasClass('autoLinked') ) {
            // get mentions
            var mentions = _getMentions( text );

            // if mentions
            if( mentions ) {
                $.each( mentions, function( index, value ) {
                    // replace @ sign
                    var link = value.replace('@', '');

                    // replacement text
                    var replacement = '<a class="linkified" href="' + baseUrl + link + '" target="'+ options.target +'">'+ value +'</a>';

                    // new content
                    var newContent = str_replace( value, replacement, element.html() );

                    // replace in the element
                    element.html( newContent );
                });
            }
        }
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

        if ( element.find('a[href="' + this + '"]').length === 0 ) {
            return text.replace(/(^|\s|\(|>)#((\w|[\u00A1-\uFFFF])+)/g, "$1<a class='linkified' href='" + links.baseUrl + links.hashtagSearchUrl + "$2' target='"+ links.target +"'>#$2</a>");
        }
    }

}(jQuery));