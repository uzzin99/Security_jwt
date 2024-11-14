$(function(){
    // main visual
    main.init();

    // allVideo popup
    $('.btn_allVideo').click(function(){
        $('#allVideo').addClass('on');
    });

    $('#allVideo .btn_popClose').click(function(){
        $('#allVideo').removeClass('on')
    });
});

$(window).bind('resize', function(){
    // main visual
    main.init();

    // scrollbars
    main.scrollbars();

});

var main = {
    init : function (){
        main.mVisual();
        main.scrollbars();
        main.screenHeight();

		//유튜브 API 셋팅
		var tag = document.createElement('script');
			tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
			firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		window.onYouTubeIframeAPIReady = function(){
			Youtube.init();
		}
    },
    mVisual : function(){


        if($(".mVisual .swiper-slide").length > 1){
            var iThumbs = new Swiper(".promoA_thumbs", {        
                //direction: "vertical",    
                watchSlidesProgress: true, 
                watchOverflow: true,
                watchSlidesVisibility: true,
                slideToClickedSlide: true,
                observer: true,
                observeParents: true,
                freeMode : true,
                breakpoints: {                    
                    1040: {
                        direction: "horizontal",
                        //slidesPerView: "auto",
                        //loopedSlides: "auto",
                        slidesPerView: 2.5,
                        loopedSlides: 2.5,
                        spaceBetween: 10,
                        //freeMode: true,
                    },
                    768:{
                        direction: "horizontal",
                        //slidesPerView: "auto",
                        //loopedSlides: "auto",
                        slidesPerView: 1.5,
                        loopedSlides: 1.5,
                        spaceBetween: 10,
                        //freeMode: true,
                    }
                },
                on: {
                    slideChangeTransitionStart: function () {
                        // loop true일 경우 realIndex
                        // loop false일 경우 activeIndex
                        const activeIndex  = iThumbs.activeIndex ;
                        mVisual.slideTo(activeIndex );
                    }
                }
            });

            var mVisual = new Swiper(".mVisual", {
                effect: "fade",     
                pagination: {
                    el: ".mVisual .swiper_control .swiper_pagi",
                    clickable: true,
                },
                //spped:100,    
                watchOverflow: true,
                watchSlidesVisibility: true,
                watchSlidesProgress: true,
                //slideToClickedSlide: true,
                preventInteractionOnTransition: true,
                observer: true, 
                observeParents: true,
                //freeMode : true,                
                a11y: {
                    prevSlideMessage: "Previous slide",
                    nextSlideMessage: "Next slide",
                },   
                thumbs: {
                    swiper: iThumbs,
                },                
                on: {
                    init: function () {
                        //첫뻔재 영상 재생
                        //Youtube.data.mVisualplayers[0].playVideo();

                        /*setTimeout(function(){    
                            $(".mVisual .swiper-slide").attr({"tabindex":"-1","aria-hidden" : true});
                            $(".mVisual .swiper-slide.swiper-slide-active").attr({"tabindex" : "0","aria-hidden" : false});

                            $(".mBottomVideo .iframe_area").attr({"tabindex":"-1","aria-hidden" : true}); 
                        },300);*/
                    },
                    realIndexChange: function () {
                        //전체 정지 후 해당 인덱스만 재생
                        Youtube.data.mVisualplayers.forEach(function (el) {
                            //console.log(el[0])
                            if(el[0] != undefined){
                                el[0].stopVideo();
                            }
                        });

                        var r_idx = mVisual.activeIndex;
                        var slide = mVisual.slides[r_idx];
                        
                        for(var i=0;i<Youtube.data.mVisualplayers.length;i++){
                            //console.log(Youtube.data.mVisualplayers[i][1]);
                            //console.log($(Youtube.data.mVisualplayers[i].i).attr("id"))
                            if(Youtube.data.mVisualplayers[i][1] == $(slide).find(".iframe_area").attr("id")){
                                
                                Youtube.data.mVisualplayers[i][0].playVideo();
                                return false;
                            }
                        }

                        // setTimeout(function(){    
                        //     $(".mVisual .swiper-slide").attr({"tabindex":"-1","aria-hidden" : true});
                        //     $(".mVisual .swiper-slide.swiper-slide-active").attr({"tabindex" : "0","aria-hidden" : false});
                        // },300);

                    },
                    slideChangeTransitionEnd: function () {
                        const activeIndex = mVisual.activeIndex;
                        iThumbs.slideTo(activeIndex);
                    }
                },
                breakpoints: {
                    1040: {
                        //loopedSlides: "auto",
                        loopedSlides: 2.5,
                        mousewheel: false,
                        //touchRatio: 0,
                    },
                    768:{
                        //loopedSlides: "auto",
                        loopedSlides: 1.5,
                        mousewheel: false,
                        //touchRatio: 0,
                    }
                }
            });
            

            
            

            $(".mVisualControl .stop").on("click", function(e){
                if($(this).hasClass("play")){
                    $(this).removeClass("play").find("span").html("정지");
                    mVisual.autoplay.start();
                } 
                else{
                    $(this).addClass("play").find("span").html("재생");
                    mVisual.autoplay.stop();
                }
            });

            // if(mVisualAutoPlay == "N"){
            //     mVisual.autoplay.stop();
            //     $(".mVisualControl .stop").addClass("play").find("span").html("재생");
            // }
        } else{
            $(".mVisual .swiper-slide").addClass("swiper-slide-active");
            $(".mVisualControl").hide();
        }
    },
    scrollbars : function(){
        $(window).on("load", function(){
            $("#allVideo .popInner").mCustomScrollbar();
        });
        $("#allVideo .popInner").mCustomScrollbar();
    },
    screenHeight : function(){
        function setScreenSize() {
            let vh = window.innerHeight * 0.01;
            
            document.documentElement.style.setProperty('--vh', `${vh}px`);
        }
            
        setScreenSize();

        window.addEventListener('resize', () => setScreenSize());

    }
}

//유튜브 재생 관련 스크립트
var Youtube = {
	data : {
        //mVisualPlay      : false,
		mVisualplayers   : new Array(),		//메인 비쥬얼 동영상 플레이 목록
		mNewsListplayers : new Array(),		//대학소식 동영상 플레이 목록
		mBottomplayers   : new Array(),		//대학소식 동영상 플레이 목록
	},
    //유튜브 재생 준비되면 실행
    init : function(){
		//메인 비쥬얼 슬라이드 유튜브
		Youtube.mVisualVideoReady();
    },
	//유튜브 플레이어 ID값 랜덤 설정
    PlayerIDSet : function(){
        return "yt_player_"+Math.floor(Math.random() * 10000);
    },
	//메인 비쥬얼 슬라이드영역 유튜브
	 mVisualVideoReady : function(){		 
		$(".mVisual").find(".iframe_area").each(function(e){
			var ifrid = Youtube.PlayerIDSet();	  //아이프레임 랜덤 ID생성
			var ifrsrc = $(this).data("videoid"); //재생영상 ID값 추출
			$(this).attr("id", ifrid);
			Youtube.VideoSet(ifrid, ifrsrc, "Youtube.data.mVisualplayers");
		}); 
	},	
	//유튜브 플레이어 설정
	VideoSet : function(id, src, target) {
		var curplayer = Youtube.createPlayer(id, src);
		eval(target).push([curplayer, id]);
	},
	//유튜브 플레이어 생성 API
	createPlayer : function(id, src) {
		return new YT.Player(id, {
			videoId: src,
			playerVars: {
				showinfo: 0,
				controls: 0,
			},
			events: {
				'onReady': Youtube.onPlayerReady,               // 플레이어 로드가 완료되고 API 호출을 받을 준비가 될 때마다 실행
				'onStateChange': Youtube.onPlayerStateChange    // 플레이어의 상태가 변경될 때마다 실행
			}
		});
	},
	onPlayerReady : function(event){
        event.target.mute();
        //최초진입시 첫번째 영상이 있을경우
        if($(".mVisual .swiper-slide-active").find(".iframe_area").length == 1){
            setTimeout(function(e){
                for(var i=0;i<Youtube.data.mVisualplayers.length;i++){
                    if(Youtube.data.mVisualplayers[i][1] == $(".mVisual .swiper-slide-active").find(".iframe_area").attr("id")){
                        Youtube.data.mVisualplayers[i][0].playVideo();
                        return false;
                    }
                }
            }, 1000) ;
        }
    },
    onPlayerStateChange : function(event){
        var playerState = event.data == YT.PlayerState.ENDED ? '종료됨' :
						  event.data == YT.PlayerState.PLAYING ? '재생 중' :
						  event.data == YT.PlayerState.PAUSED ? '일시중지 됨' :
						  event.data == YT.PlayerState.BUFFERING ? '버퍼링 중' :
						  event.data == YT.PlayerState.CUED ? '재생준비 완료됨' :
						  event.data == -1 ? '시작되지 않음' : '예외';

        var embedCode = event.target.getVideoEmbedCode();
        var videoIDSrc = $(embedCode).attr("src"); 
        var videoID = videoIDSrc.substring(videoIDSrc.indexOf("embed/")+6);
        var playerID = $("[data-videoid="+videoID+"]").attr("id");


        if(event.data == YT.PlayerState.PAUSED){
            if($("#"+playerID).hasClass("mB")){
                event.target.seekTo(0);
                $("#"+playerID).prevAll(".thumbnail").show();
            }
        }
    
        if(event.data == YT.PlayerState.ENDED){
            //메인 비쥬얼
            if($("#"+playerID).hasClass("mV")){
                event.target.seekTo(0);
            } 
        }
    },
}
