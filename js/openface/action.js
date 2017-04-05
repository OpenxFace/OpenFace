/**
 * action.js
 *
 * @author      MarQuis Knox <hire@marquisknox.com>
 * @copyright   2015 MarQuis Knox
 * @link        http://marquisknox.com
 * @link		https://github.com/MarQuisKnox/action.js
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Saturday, June 27, 2015, 22:53 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     action.js
*/

(function ( $ ) {
	
    $.fn.action = function( options ) { 
        // default options
        var settings = $.extend({
            // These are the defaults
            callback: function() {}
        }, options );
 
        // return the result
        if( callback ) {
        	callback();
        }
    };
 
}( jQuery ));