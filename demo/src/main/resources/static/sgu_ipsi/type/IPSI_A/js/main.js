$(function(){
    main.init();

    gsap.registerPlugin(ScrollTrigger);

    gsap.from(".typeMain", {
        scrollTrigger: {
            trigger: ".firstAni",
            start: "top bottom",
            once: true,
            end: "bottom 0",
            toggleClass: "ani",
        },
    });
});

var main = {
    val: {
        gnbBrakePoint: 1040,						//레이아웃 타입별 PC에서 모바일 전환 하는 해상도
		conts_loc: $(window).scrollTop(), //scrolltop
	},
    init: function () {
        //main.mIcoBnr();
        main.mService();
        main.mScrollTab();
        main.mQNA();
        main.mDept();
        main.mSlider();

    },
    mQNA : function(){        
        function createQnaSwiper(tabIndex) {
            var swiperOption = {
                slidesPerView: "4",
                spaceBetween: 32,
                observer: true,
                observeParents: true,
                pagination: {
                    el: `#mNotice_tab2_${tabIndex} .swiper-pagination`,
                    clickable: true,
                },
                breakpoints: {
                    1040: {
                        slidesPerView: "1",
                        spaceBetween: 10,
                    },
                },
            };
            
            var mainQna = new Swiper(`#mNotice_tab2_${tabIndex} .mNews`, swiperOption);
        
            var pagingSwiper = new Swiper(`#mNotice_tab2_${tabIndex} .mNews`, {
                slidesPerView: "4",
                spaceBetween: 32,
                observer: true,
                observeParents: true,
                pagination: {
                    el: `#mNotice_tab2_${tabIndex} .custom-pagination`,
                    type: "fraction",
                },
                breakpoints: {
                    1040: {
                        slidesPerView: "1",
                        spaceBetween: 10,
                    },
                }
            });
        
            if (mainQna.controller && pagingSwiper) {
                mainQna.controller.control = pagingSwiper;
            }
        }
        
        function qnaSwiper() {
            for (var i = 1; i <= 5; i++) {
                createQnaSwiper(i);
            }
        }
        
        qnaSwiper();
        
    },
    mDept : function(){        
        // var mainDept = undefined;

        // function deptSwiper() {
            
        //     if (mainDept == undefined) {
        //         //var totalIndex 	= $(".deptSwiper").find(".item").length;
        //         var loopType = false;
        //         //var loopType = true;
                
        //         var mainDept = new Swiper('.deptSwiper', {
        //             slidesPerView:1,
        //             spaceBetween:0,
        //             mousewheel: false,
        //             observer:true,
        //             observeParents:true,
        //             loop:loopType, 
        //             pagination: {
        //                 el: '.deptSwiper .swiper-pagination',
        //                 clickable: true,
        //             },
        //             on: {
        //                 slideChange: function() {
        //                     // 슬라이드 변경 시 탭 활성화
        //                     var activeIndex = this.activeIndex;
        //                     $('.tab3 .tabList .item').removeClass('on').eq(activeIndex).addClass('on');
        //                 }
        //             }
        //         });

        //         var deptPagingSwiper = new Swiper('.deptSwiper', {
        //             slidesPerView:1,
        //             spaceBetween:0,
        //             observer:true,
        //             observeParents:true,
        //             pagination: {
        //                 el: '.deptSwiper .custom-pagination',
        //                 type: "fraction",
        //             },
        //             on: {
        //                 slideChange: function() {
        //                     // 슬라이드 변경 시 탭 활성화
        //                     var activeIndex = this.activeIndex;
        //                     $('.tab3 .tabList .item').removeClass('on').eq(activeIndex).addClass('on');
        //                 }
        //             }
        //         });

        //         // 탭 클릭 시 해당 슬라이드로 이동
        //         $('.tab3 .tabList .item a').on('click', function(e) {
        //             e.preventDefault();
        //             var tabIndex = $(this).parent().index();
        //             mainDept.slideTo(tabIndex);
        //             $('.tab3 .tabList .item').removeClass('on').eq(tabIndex).addClass('on');
        //         });

        //         mainDept.controller.control = deptPagingSwiper;
        //         deptPagingSwiper.controller.control = mainDept;


        //     }else if (mainDept != undefined) {
        //         mainDept.destroy();
        //         mainDept = undefined;
        //     }
        // };

        // deptSwiper();
        
    },
    mSlider : function(){
        var mVideoSlider = undefined;
        
        function videoSwiper() {
            if (mVideoSlider == undefined) {
                $(".mVideo").each(function(index){
                    var totalIndex 	= $(".mVideo").find(".item").length;
                    var loopType = false;
                    //var loopType = true;
                    
                    if(totalIndex < 4){
                        loopType = false;
                        $(".mVideo").find('.swiper-pagination').hide();                
                        $(".mVideo").find('.custom-pagination').hide();
                    }
    
                    const mVideoSlider = new Swiper('.mVideo', {
                        slidesPerView: 4,
                        spaceBetween:32,
                        observer:true,
                        observeParents:true,
                        loop:loopType, 
                        pagination: {
                            el: '.mVideo .swiper-pagination',
                            clickable: true,
                        },
                        breakpoints: {
                            1040: {
                                slidesPerView: 1,
                                spaceBetween:10,
                            },
                        },
                    });
    
                    const videoPagingSwiper = new Swiper('.mVideo', {
                        slidesPerView: 4,
                        spaceBetween:32,
                        observer: true,
                        observeParents: true,
                        pagination: {
                            el: '.mVideo .custom-pagination',
                            type: "fraction",
                        },
                        breakpoints: {
                            1040: {
                                slidesPerView: 1,
                                spaceBetween:10,
                            },
                        },
                    });
    
                    mVideoSlider.controller.control = videoPagingSwiper;
                    videoPagingSwiper.controller.control = mVideoSlider;
                });
            }else if (mVideoSlider != undefined) {
                mVideoSlider.destroy();
                mVideoSlider = undefined;
            }
        }; 
        
        videoSwiper();    
        
    },
    mService : function(){
        $(".bnrOverBx .bnr_bx").click(function(){
            if($(this).parent().hasClass("on")){
                $(this).parent().removeClass("on");
            }else{
                $(this).parent().addClass("on");
            }
        });

        $(".overBx .mBtn_close").click(function(){
            $(".bnrOverBx").removeClass("on");
        });
    },
    

    mScrollTab : function(){        
        var windowWidth = $(window).width();

        function mQuickMenu() {
            if (windowWidth <= 1040) {
                // mobile
                $(".mQuick").addClass("mobile");

                $(".mTel_btn").off("click").on("click", function() {
                    if ($(".mQuick").hasClass("active")) {
                        // Remove active classes
                        $(".mQuick").removeClass("active");
                        $("#dim").removeClass("on");
                    } else {
                        // Add active classes
                        $(".mQuick").addClass("active");
                        $("#dim").addClass("on");
                    }
                });

                $(".mQuick .mBtn_close").off("click").on("click", function(){
                    $(".mQuick").removeClass("active");
                    $("#dim").removeClass("on");
                });

            } else {
                // pc
                $(".mQuick").removeClass("mobile active");
                $("#dim").removeClass("on");
                $(".mTel_btn").off("click").on("click", function() {
                    window.location.href = $(".tel_img a").attr("href");
                });
            }            
        }

        function mQuickScroll(){
            main.val.conts_loc = $(window).scrollTop();
            if (main.val.conts_loc + $(window).innerHeight() > $("#footer").offset().top) {
                $(".mQuick, .mFix_call").addClass('bottom');
            } else {
                $(".mQuick,.mFix_call").removeClass('bottom');
            }
        }

        function updateLinkStatus() {
            if (windowWidth <= 1040) {
                $('.mTel_btn a').each(function() {
                    $(this).data('href', $(this).attr('href')).removeAttr('href');
                });
            } else {
                $('.mTel_btn a').each(function() {
                    $(this).attr('href', $(this).data('href'));
                });
            }
        }

        $(document).ready(function() {
            mQuickMenu();
            mQuickScroll();
            updateLinkStatus();

            // resize
            $(window).on('resize', function() {
                windowWidth = $(window).width();
                updateLinkStatus();
                mQuickMenu();
            });

            // scroll
            $(window).scroll(function() {
                mQuickScroll();
            });
        });

    },
}

