$(document).ready(function() {				
	$.blockUI.defaults.message = DEFAULT_PRELOADER_IMAGE;
	$.blockUI.defaults.baseZ = 50000;
	$.blockUI.defaults.css = { 
        padding: 0,
        margin: 0,
        width: '30%',
        top: '40%',
        left: '35%',
        textAlign: 'center',
        cursor: 'wait'
    };

	$.blockUI.defaults.overlayCSS = { 
		backgroundColor: '#FFFFFF', 
		opacity:         0.6, 
		cursor:          'wait'
	};
});