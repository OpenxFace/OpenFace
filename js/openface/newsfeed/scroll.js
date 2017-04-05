/**
 * OpenFace
 * Newsfeed — Infinite Scroll
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2015 BizLogic
 * @link        http://bizlogicdev.com
 * @link		http://openface.org
 * @license     GNU Affero General Public License v3
 *
 * @since  	    Sunday, January 31, 2015, 19:35 GMT+1
 * @modified    $Date$ $Author$
 * @version     $Id$
 *
 * @category    JavaScript
 * @package     OpenFace
*/

$(document).ready( function() {
	
	$(document).on('scrollstop', function() {
	    var docHeight		= $(document).height();
	    var scrollPos		= $(document).scrollTop();
	    var offset			= ( docHeight - scrollPos );
	    var halfOfDocHeight	= percentOfDocumentHeight( 50 );

	    if( ( offset >= halfOfDocHeight ) || ( offset < halfOfDocHeight ) ) {
	    	if( DISPLAYED_MEDIA_COUNT < TOTAL_MEDIA_COUNT ) {
		        if( !AJAX_REQ ) {								        
			        AJAX_REQ = true;

			        // show loading indicator
			        $('#indicator-loading').show();
			        								        
		        	$.ajax({
		        		type: 'POST',
		        		url: BASEURL + '/status/ajax',
		        		data: {  
			        		method: 'fetchPublicTimeline',
			        		offset: DISPLAYED_MEDIA_COUNT
						},
						complete: function( jqXHR, textStatus ) {
						    // ...	
						},
		        		success: function( response ) {
			        		if( response.status == 'OK' ) {
			        			if( response.data.count > 0 ) {
				        		    DISPLAYED_MEDIA_COUNT = ( DISPLAYED_MEDIA_COUNT + response.data.count );

				        		    var data        = response.data.data; 
                                    var template	= $.templates('#templateStatus'); 
                                    var html		= template.render( data );  

                                    // add content                                                
                                    Q.when(
                                    	$('#statusList').append( html ) 
                                    ).then(
                                        function( result ) {
                                            // START:   Auto-link URLs
                                            $('.statusText').linky({
                                                mentions: true,
                                                hashtags: true,
                                                urls: true,
                                                linkTo: 'local'
                                            });                
                                            // END:     Auto-link URLs                                        	
                                        }
                                    ).then(
    	                                function( result ) {
											if( DISPLAYED_MEDIA_COUNT < TOTAL_MEDIA_COUNT ) {
												AJAX_REQ = false;
											} else {
												$('#indicator-finished').show()
											}		    	    	    	                                
    	                                }
    	                            );
	                            	    				        									        		    									        			
			        			} else {
			        				$('#indicator-finished').show();	
			        			}								        												        										        			
				        				
						        $('#indicator-loading').hide();					        		
			        		} else {
			        			$('#indicator-loading').hide();
			        		}					        		
		        		},
						error: function( jqXHR, textStatus, errorThrown ) {
						    // ...
						},
		        		dataType: 'json'
					});								        
		        }					    						    	
	    	}
	    } 
    });	
	
});