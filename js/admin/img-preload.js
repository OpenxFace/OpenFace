$.imgpreload([ DEFAULT_PRELOADER_IMAGE, 
               BASEURL + '/images/preloader/168.gif' ], {
	each: function() {
        // this = dom image object
        // check for success with: $(this).data('loaded')
        // callback executes on every image load
    },
    all: function() {
        // this = array of dom image objects
        // check for success with: $(this[i]).data('loaded')
        // callback executes when all images are loaded
    }
});