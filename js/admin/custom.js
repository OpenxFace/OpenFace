$(document).ready(function() {
	var adminTemplateColor = $.cookie('adminTemplateColor');
	if( strlen( trim( adminTemplateColor ) ) ) {
		if( $('body').attr('data-theme') !== undefined ) {
			$('body').attr('class','').addClass( $('body').attr('data-theme') );
	    } else {
	    	$('body').attr('class', '');
	    }
		
		$('body').addClass('theme-' + adminTemplateColor ).attr('data-theme', 'theme-' + adminTemplateColor );
	}	
});