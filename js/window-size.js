$(document).ready(function(){
    var containerWindowSize = 'containerWindowSize';
    
    $('body').append('<div id="'+ containerWindowSize +'"></div>');
    
    $('#'+ containerWindowSize).css({
        'position': 'fixed',
        'left': '0',
        'bottom': '0',
        'background-color': 'black',
        'color': 'white',
        'padding': '5px',
        'font-size': 'x-large',
        'opacity': '0.4',
        'z-index': '2147483647'
    });
    
    getDimensions = function(){
        return $(window).width() + ' (' + $(document).width() + ') x ' + $(window).height() + ' (' + $(document).height() + ')';
    }
    
    $('#' + containerWindowSize).text( getDimensions() );
    
    $(window).on('resize', function() {
        $('#'+ containerWindowSize).text( getDimensions() );
    });
    
});