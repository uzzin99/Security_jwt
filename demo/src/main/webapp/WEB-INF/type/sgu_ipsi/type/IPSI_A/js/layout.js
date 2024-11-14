$(window).on('load', function () {
	typeLayout.init();

	// allVideo popup
    $('.btn_topSitemap').click(function(){
        $('#siteMap').addClass('on');
    });

    $('#siteMap .btn_popClose').click(function(){
        $('#siteMap').removeClass('on')
    });
});

var $win = $(window);
//타입별 레이아웃
var typeLayout = {
	val: {
		gnbBrakePoint: 1040,						//레이아웃 타입별 PC에서 모바일 전환 하는 해상도
		typeKeyNav: "",								//키보드이동 모바일 상태변수
		conts_loc: $(window).scrollTop(),			//scrolltop
	},
	init: function () {
		typeLayout.layoutSet();
		typeLayout.gnb.init();
		typeLayout.lnb();
		typeLayout.snb();
		typeLayout.touchDim();
		typeLayout.scrollbars();
		typeLayout.contentTabs();
		typeLayout.tabScroll.init();
	},
	//공통 셋팅
	layoutSet: function () {
		/*** GNB ***/
		/*gnb*/
		var gnbCrt0 = $("#gnb>li:nth-child(" + (gnbDep1) + ")>a");
		var gnbCrt1 = $("#gnb>li:nth-child(" + (gnbDep1) + ")>a");
		var gnbCrt2 = $("#gnb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>a");
		var gnbCrt3 = $("#gnb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>ul>li:nth-child(" + (gnbDep3) + ")>a");

		var lnbCrt1 = $("#lnb>li:nth-child(" + (gnbDep1) + ")>a");
		var lnbCrt2 = $("#lnb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>a");
		var lnbCrt3 = $("#lnb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>ul>li:nth-child(" + (gnbDep3) + ")>a");

		var snbCrt1 = $("#snb>li:nth-child(" + (gnbDep1) + ")>a");
		var snbCrt2 = $("#snb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>a");
		var snbCrt3 = $("#snb>li:nth-child(" + (gnbDep1) + ")>ul>li:nth-child(" + (gnbDep2) + ")>ul>li:nth-child(" + (gnbDep3) + ")>a");


		if (gnbCrt0) gnbCrt0.addClass("on");
		if (gnbCrt1) gnbCrt1.addClass("on");
		if (gnbCrt2) gnbCrt2.addClass("on");
		if (gnbCrt3) gnbCrt3.addClass("on");

		if (snbCrt1) snbCrt1.parent().addClass("on");
		if (snbCrt2) snbCrt2.parent().addClass("on");
		if (snbCrt3) snbCrt3.parent().addClass("on");

		if (lnbCrt1) lnbCrt1.parent().addClass("on");
		if (lnbCrt2) lnbCrt2.parent().addClass("on");
		if (lnbCrt3) lnbCrt3.parent().addClass("on");

		/*** snbOn ***/
		$(".sVisualArea,.dVisualArea").addClass("init");

		/*snb*/
		/*snb*/
		$("#snb_nav").each(function () {
			if("N" == snbCrt1 || "N" == snbCrt2 || "N" == snbCrt3){
				return
			}

			if(gnbDep1 != 0) { $(this).addClass("depth1");	}
			if(gnbDep2 != 0) { $(this).addClass("depth2");	}
			if(gnbDep3 != 0) { $(this).addClass("depth3");	}
			
			var snbBtn1 = $('<button type="button" class="dep1">' + snbCrt1.text() + '</button>');
			var snbBtn2 = $('<button type="button" class="dep2">' + snbCrt2.text() + '</button>');
			var snbBtn3 = $('<button type="button" class="dep3">' + snbCrt3.text() + '</button>');

			snbBtn1.insertBefore($("#snb_nav #snb"));

			if (gnbDep2 == 0) {
				$("#snb_nav>div>button:nth-of-type(1)").addClass("on");
			} else if (gnbDep3 == 0) {
				snbBtn2.insertAfter($("#snb_nav>div>button:nth-of-type(1)"));
				$("#snb_nav>div>button:nth-of-type(2)").addClass("on");
			} else {
				snbBtn2.insertAfter($("#snb_nav>div>button:nth-of-type(1)"));
				snbBtn3.insertAfter($("#snb_nav>div>button:nth-of-type(2)"));
				$("#snb_nav>div>button:nth-of-type(3)").addClass("on");
			}

			if ($("#snb>li.on").hasClass('childMain') && gnbDep2 == 0) {
				snbBtn2.insertAfter($("#snb_nav>div>button:nth-of-type(1)"));
				$("#snb_nav>div>button:nth-of-type(2)").addClass("on").text("선택");
			}
			if ($("#snb>li>ul>li.on").hasClass('childMain') && gnbDep3 == 0) {
				snbBtn2.insertAfter($("#snb_nav>div>button:nth-of-type(1)"));
				snbBtn3.insertAfter($("#snb_nav>div>button:nth-of-type(2)"));
				$("#snb_nav>div>button:nth-of-type(3)").addClass("on").text("선택");
			}
		});
		//snb 접근성
		ui.accessibility.SNB.init();

		

		

		/*** Footer ***/
		/* 탑버튼 */
		var conts_loc = $(window).scrollTop();
		// if (conts_loc + $(window).innerHeight() > $("#footer").offset().top) {
		// 	$(".mQuick").addClass('bottom');
		// 	$(".mQuick").css({
		// 		"position": "absolute",
		// 	});
		// } else {
		// 	$(".mQuick").removeClass('bottom');
		// 	$(".mQuick").css({
		// 		"position": "fixed",
		// 	});
		// }

		if (conts_loc > 50) {
			$('.topBtn').addClass('typeTop');
		} else {
			$('.topBtn').removeClass('typeTop');
		}

		$("#btn_top").click(function () {
			if ($(this).hasClass('typeTop')) {
				$("html, body").stop().animate({
					scrollTop: 0
				}, 150);
			} else {
				$("html, body").stop().animate({
					scrollTop: $(document).height()
				}, 150);
			}
		});

		sticky();
		function sticky(){
			if(window.innerWidth <= typeLayout.val.gnbBrakePoint){
				if(ui.lockBody.val.mobileBodyLock == "N"){	
					if($(window).scrollTop() > 60){
						$("body").addClass('stickyFix');
					}else{
						$("body").removeClass('stickyFix');
					}

					if($(window).scrollTop() > 220){
						$("body").addClass("snbSticky")
					} else{
						$("body").removeClass("snbSticky")
					}
				}
			}else{
				if($(window).scrollTop() > 400){
					$("body").addClass('snbSticky');
				}else{
					$("body").removeClass('snbSticky');
				}
			}
		}

		

		//scroll
		$(window).scroll(function () {			
			

			if (typeLayout.val.conts_loc > 50) {
				$('.topBtn').addClass('typeTop');
			} else {
				$('.topBtn').removeClass('typeTop');
			}

			sticky();
		});

		//모바일 GNB 스크롤시 높이게산처리
		$("header>nav #gnb").scroll(function () {
			mobileGnb();
		});

		function mobileGnb() {
			if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
				$("header>nav #gnb").css({
					"height": window.innerHeight - $("header .top_util").innerHeight()
				});
			} else {
				$("header>nav #gnb").css({
					"height": ""
				});
			}
		}

		// dropLink
		$('.btn_dropDown').click(function () {
			if ($(this).hasClass('on')) {
				$(this).removeClass('on');
				$(this).attr('title', '고객지원 하위메뉴 닫힘')
			} else {
				$(this).addClass('on');
				$(this).attr('title', '고객지원 하위메뉴 열림')
			}
		})


		// Footer Select
		$(".f_site .btn_fSite").click(function () {
            $(this).siblings(".siteBox").toggle();
        });

        // Footer Select 옵션 클릭 시 선택된 텍스트로 버튼 텍스트 변경 및 옵션 숨기기
        $(".siteBox>ul>li button").click(function () {
            var selectedText = $(this).text();
            var selectedURL = $(this).attr('data-url');

            $(this).parents('.siteBox').siblings(".f_site .btn_fSite").text(selectedText);
            $(this).parents('.siteBox').siblings(".btn_fSite_go").attr('href',selectedURL)
            $(this).parents('.siteBox').hide();
        });

		var mobileChange = "";
		
		

		//resize
		if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
			$("header>nav").attr("aria-hidden", true);
			mobileChange = "MOBIE";
		} else {
			mobileChange = "PC";
		}

		$(window).bind('resize', function () {
			childMain();
			sticky();

			if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
				mobileChange = "MOBIE";
				$("header>nav").attr("aria-hidden", true);
			} else {
				if (mobileChange == "MOBIE") {
					$("#snb_nav>div>button").removeClass("active");
					$("#snb").slideUp(50);
					$("#dim").removeClass('on').css('top', '');
					$("header>nav").attr("aria-hidden", false);
					$("header>nav #gnb ul.menuM").removeAttr("style");

					typeLayout.gnb.mBtnClose();

					$("body").removeClass("stickyFix");
				}

				mobileChange = "PC"
			}
		});

		function childMain(){
			if(window.innerWidth > typeLayout.val.gnbBrakePoint){
				if($("#snb>li.on").hasClass('childMain') && gnbDep2 == 0){
					$("#snb_nav>div>button:nth-of-type(2)").addClass("on");
				}
				if($("#snb>li>ul>li.on").hasClass('childMain') && gnbDep3 == 0){
					$("#snb_nav>div>button:nth-of-type(3)").addClass("on");
				}
			}else{
				$("#snb_nav>div>button").removeClass("on");
				if(gnbDep2 == 0) {
					$("#snb_nav>div>button:nth-of-type(1)").addClass("on");
				}else if(gnbDep3 == 0){
					$("#snb_nav>div>button:nth-of-type(2)").addClass("on");
				}else{
					$("#snb_nav>div>button:nth-of-type(3)").addClass("on");
				}
			}
		}

		
	},
	//GNB 이벤트
	gnb: {
		init: function () {
			$(window).resize(function(){
				device();
			});
		
			function device() {
				if(window.innerWidth > 1040){
					$('body').removeClass("mobile tablet").addClass("web");
				}
				else if(window.innerWidth > 768 && window.innerWidth < 1041){
					$('body').removeClass("web mobile").addClass("tablet");
				}
				else {
					$('body').removeClass("web tablet").addClass("mobile");
				};
			};
			device();

			//PC GNB 이벤트
			$("#gnb>li>a").mouseover(function () {
				if (window.innerWidth > typeLayout.val.gnbBrakePoint) {
					//초기화
					$("body").removeClass("gnbDim");
					$("#header").removeClass("gnbOn");
					$("#gnb>li").removeClass('over');
					$("#gnb>li, #gnb>li>.gnbTit, #gnb>li>.menuM").removeClass('act');

					$("#header").css("height", "");
					$(".gnbTit").css("height", "");
					$("#header .menuM").css({ "height": "", "padding-bottom": "" });
					$("header>nav #gnb ul.menuS").removeAttr("style");

					//실행
					$("#header").addClass("gnbOn");
					$("#gnb_dim").addClass("on");
					$("body").addClass("gnbDim");

					$(this).parent('li').addClass('act');
					$(this).parent('li').addClass('over');
					$(this).siblings().addClass('act');
					$(this).siblings().addClass('over');


					if ($(this).parent('li').hasClass('child')) {
						$(this).siblings('.menuM').height($(this).siblings('.menuM').innerHeight());
						$("#header").height($(this).siblings('.menuM').height() + 120);
					} else {
						$("#header").removeAttr('style');
						$("#gnb_dim").removeClass("on");
					}
				}
			});

			$("#gnb .menuM").mouseover(function () {
				if (window.innerWidth > typeLayout.val.gnbBrakePoint) {
					//초기화
					$(".menuM").on("mouseenter", function() {
						// 해당하는 부모 li에 over 클래스 추가
						$(this).parent("li").addClass("over");
					}).on("mouseleave", function() {
						// 해당하는 부모 li에 over 클래스 제거
						$("#gnb>li").removeClass('over');
					});
				}
			});

			$("#gnb .menuM").mouseleave(function () {
				if (window.innerWidth > typeLayout.val.gnbBrakePoint) {
					//초기화
					$("#gnb>li").removeClass('over');
				}
			});

			$("#header").mouseleave(function () {
				if (window.innerWidth > typeLayout.val.gnbBrakePoint) {
					$("body").removeClass("gnbDim");
					$("#header").removeClass("gnbOn").removeAttr('style');
					$("#gnb_dim").removeClass("on");
					$("#gnb>li").removeClass('act');
					$("#gnb>li").removeClass('over');
					$("#gnb, #gnb .gnbTit, #gnb .menuM").removeClass('act').removeAttr('style');
				}
			});
			/**************************************************************************/

			/*mobile*/
			$("header .mBtn_topMenu").click(function () {
				if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
					//초기화
					$("body").removeAttr('style');
					$("header>nav #gnb").removeAttr('style');
					$("header>nav #gnb ul.menuM>li").removeClass('act');
					$("header>nav #gnb>li>a.on").parent('li').addClass('act');
					$("#gnb>li").removeClass('over');
					$("header>nav #gnb ul.menuM>li.on").addClass('act');
					$("header>nav #gnb ul.menuM>li>a").removeAttr("style");

					//실행
					ui.lockBody.lock();

					$("#gnb_dim").addClass('on');
					$("#header").addClass('gnbOn');
					$("header>nav #gnb").css({
						"height": window.innerHeight - $("header .top_util").innerHeight()
					});

					//개별 접근성 코드
					ui.accessibility.focusloop("header>nav");
				}
			});

			/*mobile menu*/
			$("#btn_menu").click(function(){
				if($("body").hasClass("web")) {
					//web
				} else {
					//m
					$("body").addClass("gnbOn");
					if(gnbDep1 == 0) {
						$("header nav #gnb>li:nth-child(1)>a").addClass("on");
					}
					return false;
				}
			});
			$("header #gnb>li.child>a").click(function(){
				if($("body").hasClass("web")) {
				} else {
					//m
					$(this).addClass("on").next("div").fadeIn(0);
					$("header #gnb>li.child>a").not(this).removeClass("on").next("div").fadeOut(0);
					return false;
				}
			});
			$("header #gnb div>ul>li.child>a").click(function(){
				if($("body").hasClass("web")) {
				} else {
					//m
					$(this).parents("li").addClass("on").next("ul").fadeIn(0);
					$("header #gnb div>ul>li.child>a").not(this).parents("li").removeClass("on").next("ul").fadeOut(0);
					return false;
				}
			});


			// 1뎁스 클릭 이벤트
			$("header>nav #gnb>li>a").click(function (event) {
				if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
					$(this).parent('li').addClass('act').next('ul').show();
					$("header>nav #gnb>li>a").not(this).parent('li').removeClass("act").next("ul").hide();
					// if ($(this).parent('li').hasClass('child')) {
					// 	if (!$(this).parent('li').hasClass('act')) {
					// 		$("header>nav #gnb ul.menuM").hide();
					// 		$("header>nav #gnb>li, header>nav #gnb li").removeClass('act');

					// 		$(this).parent('li').addClass('act');
					// 		$(this).siblings('.menuM').show();
					// 		return false;
					// 	} else {
					// 		$("header>nav #gnb ul.menuM").hide();
					// 		$("header>nav #gnb>li, header>nav #gnb li").removeClass('act');
					// 		return false;
					// 	}
					// }
				}
			});

			//2뎁스 클릭 이벤트
			$("header>nav #gnb ul.menuM>li>a:first-of-type").click(function (event) {
				if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
					if ($(this).parent('li').hasClass('child')) {
						if (!$(this).parent('li').hasClass('act')) {
							$("header>nav #gnb ul.menuM>li").removeClass('act');
							$("header>nav #gnb ul.menuS").slideUp(200);

							$(this).parent('li').addClass('act');
							$(this).siblings('ul').slideDown(200);
							return false;
						} else {
							$("header>nav #gnb ul.menuM>li").removeClass('act');
							$("header>nav #gnb ul.menuS").slideUp(200)
							return false;
						}
					} else {
						return true;
					}
				}
			});

			//메뉴 닫기
			$("header .mBtn .mBtn_close").click(function () {
				typeLayout.gnb.mBtnClose();
			});


			// dropLink
			$('.dropLink').click(function () {
				if ($(this).hasClass('on')) {
					$(this).removeClass('on');
					$(this).attr('title', '고객지원 하위메뉴 닫힘')
				} else {
					$(this).addClass('on');
					$(this).attr('title', '고객지원 하위메뉴 열림')
				}
			});
			/*********************************/
		},
		//모바일 GNB 닫기
		mBtnClose: function () {
			ui.lockBody.unlock();

			$("#gnb_dim").removeClass('on');
			$("#header").removeClass('gnbOn');
			$("header>nav #gnb li").removeClass('act');

			//개별 접근성 코드
			ui.accessibility.focusloopClose();
			if (window.innerWidth <= typeLayout.val.gnbBrakePoint) {
				$("header>nav").attr("aria-hidden", true);
			}
		}



		

	},
	lnb: function () {
		$('#lnb_nav #lnb .menuM>li.on').addClass('act');
		
		// 1뎁스 클릭 이벤트
		$("#lnb_nav #lnb .menuM>li>a").click(function (event) {
			if (window.innerWidth > typeLayout.val.gnbBrakePoint) {
				if ($(this).parent('li').hasClass('child')) {
					if (!$(this).parent('li').hasClass('act')) {
						$("#lnb_nav #lnb ul.menuS").slideUp(200);
						$("#lnb_nav #lnb>li, #lnb_nav #lnb li").removeClass('act');

						$(this).parent('li').addClass('act');
						$(this).siblings('.menuS').slideDown(200);
						return false;
					} else {
						$("#lnb_nav #lnb ul.menuS").slideUp(200);
						$("#lnb_nav #lnb>li, #lnb_nav #lnb li").removeClass('act');
						return false;
					}
				}
			}
		});

	},
	snb : function(){
		$("#snb_nav>div>button").click(function(){
			$("#snb_nav").removeClass("active1 active2 active3");
			if($(this).index() == 1) {
				$("#snb_nav").addClass("active1");
			}else if(($(this).index() == 2)){
				$("#snb_nav").addClass("active2");
			}else{
				$("#snb_nav").addClass("active3");
			}
	
			$("#snb_nav .snb_area>.btn_share").toggleClass("on");


			if(window.innerWidth <= typeLayout.val.gnbBrakePoint){
				if($('.snbInnerArea').hasClass('on')){
					$('.snbInnerArea').removeClass('on')
				}else{
					$('.snbInnerArea').addClass('on')
				}
			}
	
			if($(this).hasClass("active")) {
				$(this).removeClass("active");
				$("#snb").slideUp(50);
				//$("#dim").removeClass('on').css('top','');
				//$(".sVisual").css("z-index","");
				//ui.accessibility.focusloopClose();
			}else{
				$("#snb_nav>div>button").removeClass("active");
				$(this).addClass("active");

				if(window.innerWidth <= typeLayout.val.gnbBrakePoint){
					$("#snb").slideDown(100).css({"width" : "", "left" : ""});
					//$("#dim").addClass('on').css('top','0px');
					//$(".sVisual").css("z-index","902");
					$("#snb_nav #snb").css("max-height",($(window).innerHeight() - 111) * 0.9+"px");
				} else {
					$("#snb").slideDown(100).css({"width" : $(this).outerWidth() , "left" : $(this).position().left });

					//ui.accessibility.focusloop("#snb");
					//console.log($(this))
				}
			}
	
			if($("#snb_nav").hasClass("active1")) {
				if($(this).hasClass("active")){
					$(this).attr("title","1레벨메뉴 확장됨");
				}else{
					$(this).attr("title","1레벨메뉴 축소됨");
				}
			}
			if($("#snb_nav").hasClass("active2")) {
				if($(this).hasClass("active")){
					$(this).attr("title","2레벨메뉴 확장됨");
				}else{
					$(this).attr("title","2레벨메뉴 축소됨");
				}
			}
			if($("#snb_nav").hasClass("active3")) {
				if($(this).hasClass("active")){
					$(this).attr("title","3레벨메뉴 확장됨");
				}else{
					$(this).attr("title","3레벨메뉴 축소됨");
				}
			}
		});
	

		// // Resize 시 닫힘
		// $(window).bind('resize', function () {
		// 	if ($('#snb_nav .snb_area>button').hasClass('active')) {
		// 		$('#snb_nav .snb_area>button').removeClass('active');
		// 		$('#dim').removeClass('on')
		// 		$('#snb').hide();
		// 		$('#snb').css('width', '')
		// 		$('#snb').css('left', '')
		// 	}
		// });
	},
	touchDim : function(){
		//가로 스크롤바 체크
		$.fn.hasHorizontalScrollBar = function() {
			return this.get(0) ? Math.ceil(this.get(0).scrollWidth) > Math.ceil(this.innerWidth()) : false;
		}

		//테이블 가로 스크롤 발생시 터치 보조 딤 생성
		$(".contTable").each(function(index){
			//console.log($(this).hasHorizontalScrollBar())
			if($(this).hasHorizontalScrollBar() == true){
				var touchHtml = '<div class="tableTouchArea"><button type="button" class="tableScrollTouch"><span class="hidden">터치하면 테이블 스크롤 할 수 있습니다.</span></button></div>';
				if($(this).find(".tableTouchArea").length != "1"){
					$(this).append(touchHtml);
					$(".contTable .tableTouchArea, .contTable .tableScrollTouch").on("click", function(e){
						$(this).parents(".contTable").find(".tableTouchArea").hide();
					});
				}
			} else{
				$(this).find(".tableTouchArea").remove();
			}
		});

		//테이블 가로 스크롤 발생시 터치 보조 딤 생성
		$(".limitX").each(function(index){
			//console.log($(this).hasHorizontalScrollBar());
			if($(this).hasHorizontalScrollBar() == true){
				var touchHtml = '<div class="tableTouchArea"><button type="button" class="tableScrollTouch"><span class="hidden">터치하면 스크롤 할 수 있습니다.</span></button></div>';
				if($(this).find(".tableTouchArea").length != "1"){
					$(this).append(touchHtml);
					$(".limitX .tableTouchArea, .limitX .tableScrollTouch").on("click", function(e){
						$(this).parents(".limitX").find(".tableTouchArea").hide();
					});
				}
			} else{
				$(this).find(".tableTouchArea").remove();
			}
		});

		$(".contTable, .limitX").on("scroll", function(e){
			$(this).find(".tableTouchArea").hide();
		});
	
	},
    scrollbars : function(){
        $(window).on("load", function(){
            $("#siteMap .popInner").mCustomScrollbar();
        });
		$("#siteMap .popInner").mCustomScrollbar();
    },
	contentTabs : function(){
		$(function(){
			// 탭 스크롤
			const $tabContainer = $('.typeIpsi #pageTab');
			const $tabList = $('.typeIpsi .tabList');
			const $tabs = $('.typeIpsi .tabList li');

			if ($('#pageTab').length === 0) {
				return false;
			}

			var scrollTab = undefined;

			function checkScrollButtons() {
				// 탭에 on 클래스가 있는 경우, 해당 탭의 위치를 찾기
				var $currentTab = $('#pageTab>ul>li.on');
				var myScrollPos;

				if ($currentTab.length > 0) {
					myScrollPos = $currentTab.position().left + $currentTab.outerWidth(true) / 2 - $tabList.width() / 2;
				} else {
					// on 클래스가 없는 경우, 디폴트 위치 설정
					myScrollPos = 0; // 또는 다른 기본 위치 설정
				}

				const scrollLeftButton = '<button class="scroll-button scroll-left"><img src="/sgu_ipsi/type/IPSI_A/img/layout/arr_swiperPrev.svg" alt="이전 슬라이드 보기"><span>이전 슬라이드 보기</span></button>';
				const scrollRightButton = '<button class="scroll-button scroll-right"><img src="/sgu_ipsi/type/IPSI_A/img/layout/arr_swiperNext.svg" alt="다음 슬라이드 보기"><span>다음 슬라이드 보기</span></button>';

				$('.scroll-button').remove();

				if ($tabList[0].scrollWidth > $tabList.innerWidth()) {
					$tabContainer.append(scrollLeftButton).append(scrollRightButton);
					$tabContainer.addClass("scrollOn");
					$tabList.css({'padding-left': '36px', 'padding-right': '36px'});

					// 초기 로딩 시에는 스크롤 위치를 조정
					$("#pageTab>ul").scrollLeft(myScrollPos + 36);

					$('.scroll-left').off('click').on('click', function() {
						const scrollAmount = $tabs.first().outerWidth(true);
						$tabList.animate({scrollLeft: '-=' + scrollAmount}, 400); 
					});

					$('.scroll-right').off('click').on('click', function() {
						const scrollAmount = $tabs.first().outerWidth(true); 
						$tabList.animate({scrollLeft: '+=' + scrollAmount}, 400); 
					});
				} else {
					$tabContainer.removeClass("scrollOn");
					$tabList.css({'padding-left': '0px', 'padding-right': '0px'});
					$("#pageTab>ul").scrollLeft(myScrollPos);
				}
			}

			// 초기 호출
			checkScrollButtons();

			// 리사이징 시 호출
			$(window).on('resize', function() {
				checkScrollButtons();
			});

			// 탭 클릭 시 호출 240805 수정
			$('#pageTab[role="tabE1"] li>a').on('click', function() {
				// 클릭한 탭으로 스크롤 이동
				var $targetTab = $(this).parent();
				var scrollPos = $targetTab.position().left + $targetTab.outerWidth(true) / 2 - $tabList.width() / 2;
				$("#pageTab>ul").animate({scrollLeft: scrollPos}, 400);
			
				checkScrollButtons();
			});
				
		});
	},
	tabScroll  : {
		init : function(){
			typeLayout.tabScroll.flexMain();
		},		
		flexMain : function(){
			
			// function tabScrollLoc() {				
			// 	if (scrollTab == undefined) {
			// 		var myScrollPos = $('#pageTab>ul>li.on').position().left + $('#pageTab>ul>li.on').outerWidth(true) / 2 - $('#pageTab>ul').width() / 2;

			// 		if (window.innerWidth <= 1040) {
			// 			if($('#pageTab').hasClass('scrollOn')){
			// 				$("#pageTab .tabList").css({'padding-left':'36px','padding-right':'36px'});
			// 				myScrollPos += 36;  // 추가된 여백만큼 스크롤 위치 조정
			// 			} else {
			// 				$("#pageTab .tabList").css({'padding-left':'0px','padding-right':'0px'});
			// 			}
			// 		} else {
			// 			$("#pageTab .tabList").css({'padding-left':'0px','padding-right':'0px'});
			// 		}

			// 		// 처음 로딩 시에도 스크롤 위치 설정
			// 		$("#pageTab>ul").scrollLeft(myScrollPos);
			// 	}
			// }

			// // 초기 호출
			// tabScrollLoc();

			// // 리사이징 시 호출
			// $(window).on('resize', function() {
			// 	tabScrollLoc();
			// });

			// // 탭 클릭 시 호출
			// $('#pageTab[role="tabEl"] li>a').click(function() {
			// 	tabScrollLoc();
			// });
			


		},
	},
}
