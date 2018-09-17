/***************************************************************************************************************
||||||||||||||||||||||||||||        CUSTOM SCRIPT FOR VENTURES                   |||||||||||||||||||||||||||||||
****************************************************************************************************************
||||||||||||||||||||||||||||              TABLE OF CONTENT                  ||||||||||||||||||||||||||||||||||||
****************************************************************************************************************
****************************************************************************************************************

01. Revolution slider
02. Sticky header
03. Prealoader
04. Language switcher
05. prettyPhoto
06. BrandCarousel
07. Testimonial carousel
08. ScrollToTop 
09. Cart Touch Spin
10. PriceFilter
11. Cart touch spin
12. Fancybox activator
13. ContactFormValidation
14. Scoll to target
15. PrettyPhoto

****************************************************************************************************************
||||||||||||||||||||||||||||            End TABLE OF CONTENT                ||||||||||||||||||||||||||||||||||||
****************************************************************************************************************/
"use strict";



//====Main menu===
function mainmenu() {
	//Submenu Dropdown Toggle
	if($('.main-menu li.dropdown ul').length){
		$('.main-menu li.dropdown').append('<div class="dropdown-btn"></div>');
		
		//Dropdown Button
		$('.main-menu li.dropdown .dropdown-btn').on('click', function() {
			$(this).prev('ul').slideToggle(500);
		});
	}
}



//===RevolutionSliderActiver===
function revolutionSliderActiver () {
	if ($('.rev_slider_wrapper #slider1').length) {
		$("#slider1").revolution({
			sliderType:"standard",
			sliderLayout:"auto",
			delay:5000,
            startwidth:1170,
		    startheight:780,
            
            navigationType:"bullet",
		    navigationArrows:"0",
		    navigationStyle:"preview3",

            dottedOverlay:'yes',
            
            hideTimerBar:"off",
            onHoverStop:"off",
			navigation: {
				arrows:{enable:true} 
			}, 
            gridwidth: [1170],
            gridheight: [780]
		});
	}; 
}



//===Language switcher===
function languageSwitcher() {

    if ($("#polyglot-language-options").length) {
        $('#polyglotLanguageSwitcher').polyglotLanguageSwitcher({
            effect: 'slide',
            animSpeed: 500,
            testMode: true,
            onChange: function(evt) {
                    alert("The selected language is: " + evt.selectedItem);
                }

        });
    };
}



//===Prettyphoto Lightbox===
function prettyPhoto() {
    $("a[data-rel^='prettyPhoto']").prettyPhoto({
        animation_speed:'normal',
        slideshow:3000,
        autoplay_slideshow: false,
        fullscreen: true,
        social_tools: false
    });
}


//===Header Sticky===
function stickyHeader() {
    if ($('.stricky').length) {
        var strickyScrollPos = 100;
        if ($(window).scrollTop() > strickyScrollPos) {
            $('.stricky').addClass('stricky-fixed');
            $('.scroll-to-top').fadeIn(1500);
        } else if ($(this).scrollTop() <= strickyScrollPos) {
            $('.stricky').removeClass('stricky-fixed');
            $('.scroll-to-top').fadeOut(1500);
        }
    };
}



//===Search box ===
function searchbox() {
	//Search Box Toggle
	if($('.seach-toggle').length){
		//Dropdown Button
		$('.seach-toggle').on('click', function() {
			$(this).toggleClass('active');
			$(this).next('.search-box').toggleClass('now-visible');
		});
	}
}



//  scoll to Top
function scrollToTop() {
    if ($('.scroll-to-target').length) {
        $(".scroll-to-target").on('click', function() {
            var target = $(this).attr('data-target');
            // animate
            $('html, body').animate({
                scrollTop: $(target).offset().top
            }, 1000);

        });
    }
}



// ===Prealoder===
function prealoader() {
    if($('.preloader').length){
        $('.preloader').delay(2000).fadeOut(500);
    }
}



//  Fact counter
function CounterNumberChanger () {
	var timer = $('.timer');
	if(timer.length) {
		timer.appear(function () {
			timer.countTo();
		})
	}

}



function customTabSingleService () {
    if ($('.tabmenu-box').length) {
        var tabWrap = $('.tab-content-box');
        var tabClicker = $('.tabmenu-box ul li');
        
        tabWrap.children('div').hide();
        tabWrap.children('div').eq(0).show();
        tabClicker.on('click', function() {
            var tabName = $(this).data('tab-name');
            tabClicker.removeClass('active');
            $(this).addClass('active');
            var id = '#'+ tabName;
            tabWrap.children('div').not(id).hide();
            tabWrap.children('div'+id).fadeIn('500');
            return false;
        });        
    }
}


//=== Thm scroll anim===
function thmScrollAnim() {
    if ($('.wow').length) {
        var wow = new WOW({
            mobile: false
        });
        wow.init();
    };
}


//  Price Filter
function priceFilter() {
    if ($('.price-ranger').length) {
        $('.price-ranger #slider-range').slider({
            range: true,
            min: 10,
            max: 200,
            values: [11, 99],
            slide: function(event, ui) {
                $('.price-ranger .ranger-min-max-block .min').val('$' + ui.values[0]);
                $('.price-ranger .ranger-min-max-block .max').val('$' + ui.values[1]);
            }
        });
        $('.price-ranger .ranger-min-max-block .min').val('$' + $('.price-ranger #slider-range').slider('values', 0));
        $('.price-ranger .ranger-min-max-block .max').val('$' + $('.price-ranger #slider-range').slider('values', 1));
    };
}


//Accordion Box
function accordion() {
    if($('.accordion-box').length){
        $(".accordion-box").on('click', '.accord-btn', function() {

            if($(this).hasClass('active')!==true){
            $('.accordion .accord-btn').removeClass('active');

            }

            if ($(this).next('.accord-content').is(':visible')){
                $(this).removeClass('active');
                $(this).next('.accord-content').slideUp(500);
            }else{
                $(this).addClass('active');
                $('.accordion .accord-content').slideUp(500);
                $(this).next('.accord-content').slideDown(500);	
            }
        });	
    }
}


// Cart Touch Spin
function cartTouchSpin() {
    if ($('.quantity-spinner').length) {
        $("input.quantity-spinner").TouchSpin({
            verticalbuttons: true
        });
    }
}


// Select menu 
function selectDropdown () {
  if($(".selectmenu").length) {
    $( ".selectmenu" ).selectmenu();
  };
}


// Date picker
function datepicker () {
    if ($('#datepicker').length) {
        $('#datepicker').datepicker();
    };
}


// Time picker
function timepicker () {
    $('input[name="time"]').ptTimeSelect();
}


//=== Tool tip ===
function tooltip () {
	if ($('.tool_tip').length) {
			$('.tool_tip').tooltip();
		};
	$
}


// ===Project===
function enableMasonry() {
    if($('.sortable-masonry').length){

        var winDow = $(window);
        // Needed variables
        var $container=$('.sortable-masonry .items-container');
        var $filter=$('.filter-btns');

        $container.isotope({
            filter:'*',
             masonry: {
                columnWidth : 2
             },
            animationOptions:{
                duration:500,
                easing:'linear'
            }
        });


        // Isotope Filter 
        $filter.find('li').on('click', function(){
            var selector = $(this).attr('data-filter');

            try {
                $container.isotope({ 
                    filter	: selector,
                    animationOptions: {
                        duration: 500,
                        easing	: 'linear',
                        queue	: false
                    }
                });
            } catch(err) {

            }
            return false;
        });


        winDow.on('resize', function(){
            var selector = $filter.find('li.active').attr('data-filter');

            $container.isotope({ 
                filter	: selector,
                animationOptions: {
                    duration: 500,
                    easing	: 'linear',
                    queue	: false
                }
            });
        });


        var filterItemA	= $('.filter-btns li');

        filterItemA.on('click', function(){
            var $this = $(this);
            if ( !$this.hasClass('active')) {
                filterItemA.removeClass('active');
                $this.addClass('active');
            }
        });
    }
}



// ===Project===
function projectMasonaryLayout() {
    if ($('.masonary-layout').length) {
        $('.masonary-layout').isotope({
            layoutMode: 'masonry'
        });
    }

    if ($('.post-filter').length) {
        $('.post-filter li').children('span').on('click', function() {
            var Self = $(this);
            var selector = Self.parent().attr('data-filter');
            $('.post-filter li').children('span').parent().removeClass('active');
            Self.parent().addClass('active');


            $('.filter-layout').isotope({
                filter: selector,
                animationOptions: {
                    duration: 500,
                    easing: 'linear',
                    queue: false
                }
            });
            return false;
        });
    }

    if ($('.post-filter.has-dynamic-filter-counter').length) {
        // var allItem = $('.single-filter-item').length;

        var activeFilterItem = $('.post-filter.has-dynamic-filter-counter').find('li');

        activeFilterItem.each(function() {
            var filterElement = $(this).data('filter');
            console.log(filterElement);
            var count = $('.gallery-content').find(filterElement).length;

            $(this).children('span').append('<span class="count"><b>' + count + '</b></span>');
        });
    };
}




//===Brand Carousel===
function brandCarousel () {
    if ($('.brand').length) {
        $('.brand').owlCarousel({
            dots: false,
            loop:true,
            margin: 30,
            nav:true,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:1
                },
                1100:{
                    items:2
                },
                1200:{
                    items:2
                }
            }
        });    		
    }
}



//===Blog Carousel===
function blogCarousel () {
    if ($('.blog-Carousel').length) {
        $('.blog-Carousel').owlCarousel({
            dots: true,
            loop:true,
            margin: 30,
            nav:false,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:2
                },
                1100:{
                    items:2
                },
                1200:{
                    items:2
                }
            }
        });    		
    }
}



//=== contact Info Carousel===
function contactInfoCarousel () {
    if ($('.contact-carousel').length) {
        $('.contact-carousel').owlCarousel({
            dots: true,
            loop:true,
            margin:20,
            nav:false,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:1
                },
                1100:{
                    items:1
                },
                1200:{
                    items:1
                }
            }
        });    		
    }
}



//=== Service Carousel ===
function serviceCarousel () {
    if ($('.service-carousel').length) {
        $('.service-carousel').owlCarousel({
            dots: true,
            loop:true,
            margin:30,
            nav:false,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:2
                },
                1024:{
                    items:2
                },
                1100:{
                    items:3
                },
                1200:{
                    items:3
                }
            }
        });    		
    }
}



//=== History Carousel ===
function historyCarousel () {
    if ($('.history-carousel').length) {
        $('.history-carousel').owlCarousel({
            dots: false,
            loop:true,
            margin:30,
            nav:true,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:1
                },
                1100:{
                    items:1
                },
                1200:{
                    items:2
                }
            }
        });    		
    }
}



//=== Team Carousel ===
function teamCarousel () {
    if ($('.team-carousel').length) {
        $('.team-carousel').owlCarousel({
            dots: true,
            loop:true,
            margin:30,
            nav:false,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:2
                },
                1024:{
                    items:2
                },
                1100:{
                    items:3
                },
                1200:{
                    items:3
                }
            }
        });    		
    }
}



//=== contact page Info Carousel===
function contactpageInfoCarousel () {
    if ($('.sidebar-testimonial').length) {
        $('.sidebar-testimonial').owlCarousel({
            dots: true,
            loop:true,
            margin:20,
            nav:false,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:1
                },
                1100:{
                    items:1
                },
                1200:{
                    items:1
                }
            }
        });    		
    }
}



//=== Contact Details Carousel ===
function contactdetailsCarousel () {
    if ($('.contact-details-carousel').length) {
        $('.contact-details-carousel').owlCarousel({
            dots: false,
            loop:true,
            margin:20,
            nav:true,
            navText: [
                '<i class="fa fa-angle-left"></i>',
                '<i class="fa fa-angle-right"></i>'
            ],
            autoplayHoverPause: false,
            autoplay: 6000,
            smartSpeed: 1000,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                800:{
                    items:1
                },
                1024:{
                    items:1
                },
                1100:{
                    items:1
                },
                1200:{
                    items:1
                }
            }
        });    		
    }
}


//Client Testimonial Carousel
function testimonialCarouselbox () {
	if ($('.client-testimonial-carousel').length && $('.client-thumbs-carousel').length) {

		var $sync3 = $(".client-testimonial-carousel"),
			$sync4 = $(".client-thumbs-carousel"),
			flag = true,
			duration = 500;

			$sync3
				.owlCarousel({
					loop:true,
					items: 1,
					margin: 0,
					nav: true,
					navText: [ '<span class="fa fa-angle-left"></span>', '<span class="right_arrow fa fa-angle-left"></span>' ],
					dots: false,
					autoplay: false,
					autoplayTimeout: 5000
				})
				.on('changed.owl.carousel', function (e) {
					if (!flag) {
						flag = false;
						$sync4.trigger('to.owl.carousel', [e.item.index, duration, true]);
						flag = false;
					}
				});

			$sync4
				.owlCarousel({
					loop:true,
					margin:10,
					items: 1,
					nav: false,
					navText: [ '<span class="icon icon-arrows"></span>', '<span class="icon right_arrow icon-arrows"></span>' ],
					dots: false,
					center: false,
					autoplay: false,
					autoplayTimeout: 5000,
					responsive: {
						0:{
				            items:1,
				            autoWidth: false
				        },
				        400:{
				            items:1,
				            autoWidth: false
				        },
				        600:{
				            items:1,
				            autoWidth: false
				        },
				        1000:{
				            items:1,
				            autoWidth: false
				        },
						1200:{
				            items:1,
				            autoWidth: false
				        }
				    },
				})
				
		.on('click', '.owl-item', function () {
			$sync3.trigger('to.owl.carousel', [$(this).index(), duration, true]);
		})
		.on('changed.owl.carousel', function (e) {
			if (!flag) {
				flag = true;		
				$sync3.trigger('to.owl.carousel', [e.item.index, duration, true]);
				flag = false;
			}
		});
	}

}





//Contact Form Validation
if($("#contact-form").length){
    $("#contact-form").validate({
        submitHandler: function(form) {
          var form_btn = $(form).find('button[type="submit"]');
          var form_result_div = '#form-result';
          $(form_result_div).remove();
          form_btn.before('<div id="form-result" class="alert alert-success" role="alert" style="display: none;"></div>');
          var form_btn_old_msg = form_btn.html();
          form_btn.html(form_btn.prop('disabled', true).data("loading-text"));
          $(form).ajaxSubmit({
            dataType:  'json',
            success: function(data) {
              if( data.status = 'true' ) {
                $(form).find('.form-control').val('');
              }
              form_btn.prop('disabled', false).html(form_btn_old_msg);
              $(form_result_div).html(data.message).fadeIn('slow');
              setTimeout(function(){ $(form_result_div).fadeOut('slow') }, 6000);
            }
          });
        }
    });
}



// Add Comment Form Validation
if($("#add-comment-form").length){
    $("#add-comment-form").validate({
        submitHandler: function(form) {
          var form_btn = $(form).find('button[type="submit"]');
          var form_result_div = '#form-result';
          $(form_result_div).remove();
          form_btn.before('<div id="form-result" class="alert alert-success" role="alert" style="display: none;"></div>');
          var form_btn_old_msg = form_btn.html();
          form_btn.html(form_btn.prop('disabled', true).data("loading-text"));
          $(form).ajaxSubmit({
            dataType:  'json',
            success: function(data) {
              if( data.status = 'true' ) {
                $(form).find('.form-control').val('');
              }
              form_btn.prop('disabled', false).html(form_btn_old_msg);
              $(form_result_div).html(data.message).fadeIn('slow');
              setTimeout(function(){ $(form_result_div).fadeOut('slow') }, 6000);
            }
          });
        }
    });
}


// Appoinment Form Validation
if($("#appoinment-form").length){
    $("#appoinment-form").validate({
        submitHandler: function(form) {
          var form_btn = $(form).find('button[type="submit"]');
          var form_result_div = '#form-result';
          $(form_result_div).remove();
          form_btn.before('<div id="form-result" class="alert alert-success" role="alert" style="display: none;"></div>');
          var form_btn_old_msg = form_btn.html();
          form_btn.html(form_btn.prop('disabled', true).data("loading-text"));
          $(form).ajaxSubmit({
            dataType:  'json',
            success: function(data) {
              if( data.status = 'true' ) {
                $(form).find('.form-control').val('');
              }
              form_btn.prop('disabled', false).html(form_btn_old_msg);
              $(form_result_div).html(data.message).fadeIn('slow');
              setTimeout(function(){ $(form_result_div).fadeOut('slow') }, 6000);
            }
          });
        }
    });
}



	


// Dom Ready Function
jQuery(document).on('ready', function () {
	(function ($) {
        // add your functions
        mainmenu ();
        revolutionSliderActiver ();
        languageSwitcher ();
        prettyPhoto ();
        searchbox ();
        scrollToTop ();
        CounterNumberChanger ();
        customTabSingleService ();
        thmScrollAnim ();
        priceFilter ();
        accordion ();
        cartTouchSpin ();
        selectDropdown ();
        datepicker ();
        timepicker ();
        tooltip ();
        projectMasonaryLayout ();
        
        
        brandCarousel ();
        blogCarousel ();
        serviceCarousel ();
        contactInfoCarousel ();
        historyCarousel ();
        teamCarousel ();
        contactpageInfoCarousel ();
        contactdetailsCarousel ();
        testimonialCarouselbox ();
   
 
	})(jQuery);
});



jQuery(window).on('scroll', function(){
	(function ($) {
	stickyHeader ()
    
	})(jQuery);
});



// Instance Of Fuction while Window Load event
jQuery(window).on('load', function() {
    (function($) {
        prealoader ();
        enableMasonry ();
        
    })(jQuery);
});