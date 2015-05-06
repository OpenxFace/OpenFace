/**
 * jNotice
 * Generate Visual Notification Cues
 *
 * @author      MarQuis Knox <opensource@marquisknox.com>
 * @copyright   2014 MarQuis Knox
 * @link        http://marquisknox.com
 * @license     Affero General Public License v3
 * @link		https://www.gnu.org/licenses/agpl.txt
 *
 * @since       Sunday, June 01, 2014, 08:46 PM GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     1.0
*/

(function ( $ ) {	
	$.fn.jNotice = function( options ) {
		// This is the easiest way to have default options.
		var settings = $.extend({
			// These are the defaults.
			color: '#000000',
			background: '',
	    	borderBottom: '',
	    	borderTop: '',
	    	borderLeft: '',
	    	borderRight: '',
	    	padding: '10px 20px 10px 45px',
	    	type: 'info'
		}, options );
	
		switch( settings.type ) {
			case 'alert':
				settings.background		= "#fff6bf url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAIsSURBVDjLpVNLSJQBEP7+h6uu62vLVAJDW1KQTMrINQ1vPQzq1GOpa9EppGOHLh0kCEKL7JBEhVCHihAsESyJiE4FWShGRmauu7KYiv6Pma+DGoFrBQ7MzGFmPr5vmDFIYj1mr1WYfrHPovA9VVOqbC7e/1rS9ZlrAVDYHig5WB0oPtBI0TNrUiC5yhP9jeF4X8NPcWfopoY48XT39PjjXeF0vWkZqOjd7LJYrmGasHPCCJbHwhS9/F8M4s8baid764Xi0Ilfp5voorpJfn2wwx/r3l77TwZUvR+qajXVn8PnvocYfXYH6k2ioOaCpaIdf11ivDcayyiMVudsOYqFb60gARJYHG9DbqQFmSVNjaO3K2NpAeK90ZCqtgcrjkP9aUCXp0moetDFEeRXnYCKXhm+uTW0CkBFu4JlxzZkFlbASz4CQGQVBFeEwZm8geyiMuRVntzsL3oXV+YMkvjRsydC1U+lhwZsWXgHb+oWVAEzIwvzyVlk5igsi7DymmHlHsFQR50rjl+981Jy1Fw6Gu0ObTtnU+cgs28AKgDiy+Awpj5OACBAhZ/qh2HOo6i+NeA73jUAML4/qWux8mt6NjW1w599CS9xb0mSEqQBEDAtwqALUmBaG5FV3oYPnTHMjAwetlWksyByaukxQg2wQ9FlccaK/OXA3/uAEUDp3rNIDQ1ctSk6kHh1/jRFoaL4M4snEMeD73gQx4M4PsT1IZ5AfYH68tZY7zv/ApRMY9mnuVMvAAAAAElFTkSuQmCC') 15px 15px no-repeat";			 
				settings.borderBottom	= '1px solid #ffd324';
				settings.borderLeft		= '1px solid #ffd324';
				settings.borderRight	= '1px solid #ffd324';
				settings.borderTop		= '1px solid #ffd324';
				
				break;
				
			case 'error':
				settings.background		= "#f2dede url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJdSURBVDjLpZP7S1NhGMf9W7YfogSJboSEUVCY8zJ31trcps6zTI9bLGJpjp1hmkGNxVz4Q6ildtXKXzJNbJRaRmrXoeWx8tJOTWptnrNryre5YCYuI3rh+8vL+/m8PA/PkwIg5X+y5mJWrxfOUBXm91QZM6UluUmthntHqplxUml2lciF6wrmdHriI0Wx3xw2hAediLwZRWRkCPzdDswaSvGqkGCfq8VEUsEyPF1O8Qu3O7A09RbRvjuIttsRbT6HHzebsDjcB4/JgFFlNv9MnkmsEszodIIY7Oaut2OJcSF68Qx8dgv8tmqEL1gQaaARtp5A+N4NzB0lMXxon/uxbI8gIYjB9HytGYuusfiPIQcN71kjgnW6VeFOkgh3XcHLvAwMSDPohOADdYQJdF1FtLMZPmslvhZJk2ahkgRvq4HHUoWHRDqTEDDl2mDkfheiDgt8pw340/EocuClCuFvboQzb0cwIZgki4KhzlaE6w0InipbVzBfqoK/qRH94i0rgokSFeO11iBkp8EdV8cfJo0yD75aE2ZNRvSJ0lZKcBXLaUYmQrCzDT6tDN5SyRqYlWeDLZAg0H4JQ+Jt6M3atNLE10VSwQsN4Z6r0CBwqzXesHmV+BeoyAUri8EyMfi2FowXS5dhd7doo2DVII0V5BAjigP89GEVAtda8b2ehodU4rNaAW+dGfzlFkyo89GTlcrHYCLpKD+V7yeeHNzLjkp24Uu1Ed6G8/F8qjqGRzlbl2H2dzjpMg1KdwsHxOlmJ7GTeZC/nesXbeZ6c9OYnuxUc3fmBuFft/Ff8xMd0s65SXIb/gAAAABJRU5ErkJggg==') 15px 15px no-repeat";			 
				settings.borderBottom	= '1px solid #f21010';
				settings.borderLeft		= '1px solid #f21010';
				settings.borderRight	= '1px solid #f21010';
				settings.borderTop		= '1px solid #f21010';
				
				break;				
		
			case 'success':
				settings.background		= "#cfc url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAKfSURBVDjLpZPrS1NhHMf9O3bOdmwDCWREIYKEUHsVJBI7mg3FvCxL09290jZj2EyLMnJexkgpLbPUanNOberU5taUMnHZUULMvelCtWF0sW/n7MVMEiN64AsPD8/n83uucQDi/id/DBT4Dolypw/qsz0pTMbj/WHpiDgsdSUyUmeiPt2+V7SrIM+bSss8ySGdR4abQQv6lrui6VxsRonrGCS9VEjSQ9E7CtiqdOZ4UuTqnBHO1X7YXl6Daa4yGq7vWO1D40wVDtj4kWQbn94myPGkCDPdSesczE2sCZShwl8CzcwZ6NiUs6n2nYX99T1cnKqA2EKui6+TwphA5k4yqMayopU5mANV3lNQTBdCMVUA9VQh3GuDMHiVcLCS3J4jSLhCGmKCjBEx0xlshjXYhApfMZRP5CyYD+UkG08+xt+4wLVQZA1tzxthm2tEfD3JxARH7QkbD1ZuozaggdZbxK5kAIsf5qGaKMTY2lAU/rH5HW3PLsEwUYy+YCcERmIjJpDcpzb6l7th9KtQ69fi09ePUej9l7cx2DJbD7UrG3r3afQHOyCo+V3QQzE35pvQvnAZukk5zL5qRL59jsKbPzdheXoBZc4saFhBS6AO7V4zqCpiawuptwQG+UAa7Ct3UT0hh9p9EnXT5Vh6t4C22QaUDh6HwnECOmcO7K+6kW49DKqS2DrEZCtfuI+9GrNHg4fMHVSO5kE7nAPVkAxKBxcOzsajpS4Yh4ohUPPWKTUh3PaQEptIOr6BiJjcZXCwktaAGfrRIpwblqOV3YKdhfXOIvBLeREWpnd8ynsaSJoyESFphwTtfjN6X1jRO2+FxWtCWksqBApeiFIR9K6fiTpPiigDoadqCEag5YUFKl6Yrciw0VOlhOivv/Ff8wtn0KzlebrUYwAAAABJRU5ErkJggg==') 15px 15px no-repeat";   
				settings.borderBottom	= '1px solid #3C6';
				settings.borderLeft		= '1px solid #3C6';
				settings.borderRight	= '1px solid #3C6';
				settings.borderTop		= '1px solid #3C6';
				
				break;
		
			default:
				settings.background		= "url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAMoSURBVHjaYvz//z8DJQAggFjQBYJn3lT+/e9P1P8//+J+/vot8ef/P4b/DP9eMDD8W/T3z79lhyqs7iKrBwggRmQXBMy4Hvzr1+/Jivz/Jc3kBRj42JjB4h+//2E4fPslw+VnX58zMP7PPdXovBamByCA4Ab4Tb8a/Ov774WuqlzcOtK8DE/f/mJ48fE7w99//xn4uZgZpPg5GG6/+cywfu/drwwsDPGnJviBDQEIILABvlMuK/3+/eewqwq3lLoEL8Op+x8Y/vz5zaAvL8jAAJQ/d/89AyMTI4O2JA/D4/efGTbsuv2M4f8/21Ozwu4BBBATyBSgn2MU+f5LaUjyMRy//Y7h1/dfDL9//mPwNZFk8DWVYvgNNOzXz18MV598YFAQ4WdQU+GT+v/9dwxIL0AAgQ349fdvrLmCMMP9F18Yfv/+DTTwL9DpfxjWHX/EsBaIf/3+xfDrzy+GL9+/Mzx4/YnBxkCegfHXr1iQXoAAAscC0EZpQV4WhtvPgU7/+5fh99/fQBf+Y4hxUGIAhdDx68/AfAYGRoYXbz8xqEnJMPz/+10apBcgAAnkdgIACIVQ23++BmiC/qJu9jiR4IegIv4FzDucZdzhoU3JRudS1bq1As4lT8tBeSKE5+EKICZIZPx9+vbrDwZhblZgLDGBDQMZAomh/0DNfxj+Ab32D+gVfm52hpefPjMwMv57CtIJEEAQA379WXzo6hMGeVFuYHoBOhXolEALBQZNOUEGLg5WhtxAfXDY/AFiRQl+hsOH74AMXgzSChBAkJT44/uS6zc+pytLCkiZqYkyHAEaturgTYbl+64x/Afa/h+cGv8zGKrLMjz48Inh3tXbz4C+WALSChBA8IRkmrwi+P/nHwu9gnS4lUR4GW48fM3w+t1nhn9//jEICXAxqMoKAzV/Ydi3Zv9XBkbW+FPry8AJCSCAUJKyafiCYIb/vyYra0tK2pgrMwjzsIHD4NXHHwyHjt1keHT19nNGRqbcU+vL4UkZIIAY0XOjWegM5f///0YBQzKO4d8PCSANDDBGYGZiWMTI8HvZyfXVKJkJIIAYKc3OAAEGAKg/gnuGVdP+AAAAAElFTkSuQmCC') no-repeat scroll 15px 15px #F8FAFC";
				settings.borderBottom	= '1px solid #B5D4FE';
				settings.borderLeft		= '1px solid #B5D4FE';
				settings.borderRight	= '1px solid #B5D4FE';
				settings.borderTop		= '1px solid #B5D4FE';
		}
		
		return this.css({
			'color': settings.color,
			'background': settings.background,
			'border-bottom': settings.borderBottom,
			'border-left': settings.borderLeft,
			'border-right': settings.borderRight,
			'border-top': settings.borderTop,
			'padding': settings.padding
		});
	};	
}( jQuery ));