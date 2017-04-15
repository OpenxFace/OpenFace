/**
 * jQuery AutoImage
 *
 * @link        https://github.com/MarQuisKnox/jQuery.AutoImage
 * @license     MIT <http://en.wikipedia.org/wiki/MIT_License>
 * @since       Friday, April 14, 2017 / 18:42 GMT+1
 *
 * @copyright	2017 MarQuis Knox
 */

(function($) {

    'use strict';

    $.fn.autoimage = function( options ) {
        return this.each( function() {
            var $el         = $(this);
            var content     = _embed( $el, options );

            $el.html( content );
        });
    };

    function _embed( $el, options ) {
        var defaultOptions = {
            target: '_blank',
            scheme: '//',
            imgClass: 'img-responsive'
        },
        extendedOptions = $.extend( defaultOptions, options ),
        elContent       = $el.html(),

        // @link	http://snipplr.com/view/68530/regular-expression-for-matching-urls-with-or-without-https
        urlRegEx = /(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?((\?|\/)(.*))?/gi, matches;

        // embed images
        matches = elContent.match( urlRegEx );

        if ( matches ) {
            elContent = _embedImages( matches, $el, extendedOptions );
        }

        return elContent;
    }

    function _hasScheme( url ) {
        var regEx = /http|https/;

        if( url.match( regEx ) ) {
            return true;
        }

        return false;
    }

    function _isImage( url ) {
        var isImage	= (/\.(bmp|gif|jpg|jpeg|tiff|png)$/i).test( url );

        if( isImage ) {
            return true;
        }

        return false;
    }

    function _embedImages( matches, $el, linkObj )
    {
        var elContent = $el.html();

        $.each( matches, function( index, value ) {

            // check if it's an image
            var isImage = _isImage( value );

            // check for scheme
            var scheme = ( _hasScheme( value ) ) ? '' : linkObj.scheme;

            if ( isImage && $el.find('img[src="' + scheme + this + '"]').length === 0 ) {
                elContent = elContent.replace( this, '<a class="linkified" href="' + scheme + this + '" target="'+ linkObj.target +'"><img class="'+ linkObj.imgClass +'" src="' + this + '"></a>' );
            }

        });

        return elContent;
    }

}(jQuery));