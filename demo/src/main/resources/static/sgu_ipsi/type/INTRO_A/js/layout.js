$(function(){
	ui.init();
});

var ui = {
	init : function() {
		//ui.select.init();		//selectBox
		//ui.swiper.init();
		ui.LayerPop.init();
		ui.Tab.init();
		//ui.Accordion.init();
		ui.contentSet();
		ui.share();
		
		ui.accessibility.GNB();
	},
	contentSet : function(){

		//네이버 앱으로 진입시 top버튼 삭제
		var userAg = navigator.userAgent;
		if(userAg.indexOf("NAVER") == "-1"){
			//alert("네이버 앱이 아닙니다")
		} else{
			$(".topBtn").remove();
			$("body").addClass("naverApp");
		}

		//아이콘 텍스트 박스 .iconEtcArea 우측 버튼 영역만큼 셋팅
		if ($(window).width() >= 1040) {
			$(".iconEtcArea").each(function(e){
				if($(this).find(".etcArea").length != 0){
					var AreaPadding = $(this).find(".etcArea").width() + 60;
					$(this).css("padding-right", AreaPadding+"px");
				}
			});
		}

		//도트리스트 타이틀 설정시
		$(".txtList.subTitSet>li").each(function(e){
			if($(this).find(".txtDotTit").length != 0){
				var leftPadding = $(this).find(".txtDotTit").innerWidth() + 15;
				$(this).css("padding-left", leftPadding+"px");
			}
		});

		$(window).bind('resize load', function () {
			if ($(window).width() >= 1040) {
				//console.log("PC")
			} else {
				//console.log("모바일")
				$(".iconEtcArea").removeAttr("style");
			}

			//도트리스트 타이틀 설정시
			$(".txtList.subTitSet>li").each(function(e){
				if($(this).find(".txtDotTit").length != 0){
					var leftPadding = $(this).find(".txtDotTit").innerWidth() + 15;
					$(this).css("padding-left", leftPadding+"px");
				}
			});

			ui.touchDim();
		});

		//언어선택
		$(".btn_language").on("click", function(e){
			if($(this).next(".listBox").is(":visible") == false){
				$(this).attr("title","언어선택 확장됨").next(".listBox").slideDown(100);
			} else{
				$(this).attr("title","언어선택").next(".listBox").slideUp(100);
			}
		});


		//원서접수 선택
		$(".bnrOverBx .recruit_bx").click(function(){
            if($(this).parent().is("on") == false){
                $(this).parent().addClass("on");
            }else{
                $(this).parent().removeClass("on");
            }
        });

        $(".overBx .mBtn_close").click(function(){
            $(".bnrOverBx").removeClass("on");
        });
	},
	//swiper
	swiper : {
		init : function(){
			ui.swiper.flexble();
		},
		flexble : function(){
			if($('[data-id=swiperFlexble]').length == 0){return false}
			
			var ww = $(window).width();
			var swiperFlexble = undefined;
			
			$(window).on('load resize', function () {
				ww = $(window).width();
				initSwiper();
			});

			function initSwiper() {
				if (ww <= 1040 && swiperFlexble == undefined) {
					var swiperOption = {
						slidesPerView: "auto",
						freeMode: true,
					}
					swiperFlexble = new Swiper('[data-id=swiperFlexble]', swiperOption);
				} else if (ww >= 1040 && swiperFlexble != undefined) {
					swiperFlexble.destroy();
					swiperFlexble = undefined;
				}
			}
		},
	},
	Tab : {
		init : function() {
			$("body *").each(function(e){
				if($(this).attr("role") == "tabEl"){
					$(this).find("li").each(function(e){
						if($(this).is(":visible") == true){
							$(this).attr("role", "presentation");	

							if($(window).width() < 768){
								$(this).find("a").attr("role", "tab");
							}
						}	
						if($(this).hasClass("on")){
							$(this).find("a").attr({"aria-selected": true, "title":"선택됨"});
						}else{
							$(this).find("a").attr("aria-selected", false);
							$(this).find("a").removeAttr("title");
						}
					});

					$(this).find("ul a").on("click", function(e){
						ui.Tab.click(this);
					});
				}
			});
		},
		click :function(target){
			$(target).parents("[role=tabEl]").find("li").removeClass("on").find("a").attr("aria-selected", false).removeAttr("title");
			$(target).parents("li").addClass("on").find("a").attr({"aria-selected": true, "title":"선택됨"});

			//초기화활 탭 ID 추출
			var hideID = [];
			$(target).parents("[role=tabEl]").find("a").each(function(e){
				hideID.push($(this).attr("data-tabID"));
			});
			for(i=0;i<hideID.length;i++){
				$("#" + hideID[i]).removeClass("on");
			}
			$("#"+$(target).attr("data-tabID")).addClass("on");
		},
	},
	contAutoHeight : function(target, point){
		//테블릿, 모바일 분기점 디폴트
		var tabletPoint = "1024",
			mobilePoint = "768";

		if(point[0][1] != undefined){tabletPoint = point[0][1]}
		if(point[1][1] != undefined){mobilePoint = point[1][1]}

		// console.log(tabletPoint);
		// console.log(mobilePoint);

        $(window).bind('load resize', function () {
			//pc
            if(window.innerWidth >= tabletPoint){
                ui.contAutoSetion(target, point[0][0]);
            } 
			//테블릿
            else if(window.innerWidth >= mobilePoint){
                ui.contAutoSetion(target, point[1][0]);
            } 
			//모바일
            else{
				if(point[2][0] == 1){
					//console.log("1개");
					$(target).removeAttr("style");
				}
				else{
					ui.contAutoSetion(target, point[2][0]);
				}
            }
        });
	},
	contAutoSetion : function(target, length){
		$(target).removeAttr("style");
        var listLine = $(target).length;
        var arry = [];
        for (i = 0; i < listLine; i++) {
            var p_list = $(target).eq(i).innerHeight();
            arry.push(p_list);
        }
        for (i = 0; i < listLine; i++) {
            if (i < length * 1) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(0, length)));
            }
            else if (i < length * 2) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length, length * 2)));
            }
            else if (i < length * 3) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 2, length * 3)));
            }
            else if (i < length * 4) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 3, length * 4)));
            }
            else if (i < length * 5) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 4, length * 5)));
            }
            else if (i < length * 6) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 5, length * 6)));
            }
            else if (i < length * 7) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 6, length * 7)));
            }
            else if (i < length * 8) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 7, length * 8)));
            }
            else if (i < length * 9) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 8, length * 9)));
            }
            else if (i < length * 10) {
                $(target).eq(i).css("height", Math.max.apply(null, arry.slice(length * 9, length * 10)));
            }
        }
	},
	share : function(){
		$(".typeSub .pageUtil>.btn_share").on("click", function(e){
			$(".typeSub .pageUtil .shareArea").show();
			ui.accessibility.focusloop(".shareArea");

			if($(window).width() <= 768 ){
				$("#dim").addClass("on");
			}
		});

		$(".typeSub .pageUtil .shareArea .shareClosed").on("click", function(e){
			$(".typeSub .pageUtil .shareArea").hide();
			$(".typeSub .pageUtil>.btn_share").focus();
			// $("#dim").removeClass("on");
			if(!$('#snb_nav .snb_area>button.on').hasClass('active')){
				console.log('hi')
				$("#dim").removeClass("on").removeAttr("style");
			};
			ui.accessibility.focusloopClose();
		});

		$(window).bind('resize', function () {
			if($(".typeSub .pageUtil .shareArea").is(":visible") == true){
				$(".typeSub .pageUtil .shareArea .shareClosed").trigger("click");
			}
        });
	},
	//접근성 개별 코드
	accessibility : {
		//레이어 영역내 포커스 루프 이벤트
		focusloop : function(area){

			//console.log(event);
			if(event != undefined){
				$(event.currentTarget).attr("data-retrunFocus","Y");
			} else {
				$("#skip_menu").attr("data-retrunFocus","Y").attr("tabindex","0");
			}

			//첫뻔재, 마지막 타겟 셋팅시 예외상태 추가
			var TargetState = "[data-hidden=hidden], [style*='display:none'], [style*='display: none'], [style*='display :none'], [style*='display : none']";

			//첫번째, 마지막 포커스 셋팅 전 css로 display:none 처리 되어있는 타겟 분리
			$(area).find("a, button, input, select").not(TargetState).each(function(e){
				if($(this).is(":visible") == false){
					$(this).attr("data-hidden","hidden");
				}
			});
			
			//팝업 내에 첫번째, 마지막 타겟 지정
			$(area).find("a, button, input, select").not(TargetState).first().attr("data-pop-focus","first");
			$(area).find("a, button, input, select").not(TargetState).last().attr("data-pop-focus","last");
			
			
			$("body *").not(area).not(area + " *").attr({
				"aria-hidden" : true,
				"data-hidden" : "hidden"
			});
			
			//html 깊이 구해서 aria-hidden 처리 삭제
			var targetHtml = $(area);
			var endClass = targetHtml.parent().prop('tagName');
			
			for(var i = 0; i<20; i++){
				if(endClass != "BODY"){
					targetHtml.removeAttr('data-hidden').removeAttr('aria-hidden');

					targetHtml = targetHtml.parent();
					endClass = targetHtml.parent().prop('tagName');
					//console.log(endClass)
					targetHtml.removeAttr('data-hidden').removeAttr('aria-hidden');
				}
				else {
					break
				}
			}

			//팝업내 버튼이 없을경우 팝업영역을 첫번째 포커스로 잡음
			// if($(area).find("[data-pop-focus=first]").length == "0"){
			// 	$(area).attr({"tabindex" : "0", "data-pop-focus":"first"});	
			// 	$(area).focus();
			// } else{
			// 	$(area).find('[data-pop-focus=first]').focus();
			// }
			$(area).attr({"tabindex" : "0", "data-pop-focus":"first"});	
			$(area).focus();

			//접근성 : 첫번째탭에서 shift + tab 경우 마지막버튼으로 (팝업내 포커스 루프)
			$(area).find("[data-pop-focus=first]").on("keydown", function(e){
				if(e.shiftKey == true && e.which == 9){
					$(area).find("[data-pop-focus=last]").focus();
					return false;
				}
			});
			
			//접근성 : 마지막탭에서 tab 경우 첫번째 버튼 (팝업내 포커스 루프)
			$(area).find("[data-pop-focus=last]").on("keydown", function(e){
				if(e.shiftKey == false && e.which == 9){
					$(area).find("[data-pop-focus=first]").focus();
					return false;
				}
			});
		},
		focusloopClose : function(){
			$("[data-retrunFocus=Y]").focus();
			$("[data-hidden=hidden]").removeAttr("data-hidden").removeAttr("aria-hidden");
			$("body *").removeAttr("data-retrunFocus");
		},
		//GNB 키보드 운용
		GNB : function() {
			var TargetState = "[style*='display:none'], [style*='display: none'], [style*='display :none'], [style*='display : none']";
			
			//GNB ON
			$("#header nav>ul>li>a").on('focusin', function(e){
				$(this).trigger('mouseover');
			});

			//GNB OFF
			$("header>nav #gnb>li").not(TargetState).last().on('focusout', function(e){
				if(!$(this).hasClass("child")){
					$(this).trigger('mouseleave');	
				}	
			});
			
			$("header>nav #gnb>li").not(TargetState).last().find(".menuM>li").not(TargetState).last().find(".menuS>li").not(TargetState).last().on('focusout', function(e){
				$(this).trigger('mouseleave');
			});
			
			$("header>nav #gnb>li").not(TargetState).last().find(".menuM>li").not(TargetState).last().on('focusout', function(e){
				if(!$(this).hasClass("child")){
					$(this).trigger('mouseleave');
				}
			});
			
			$("header>nav #gnb>li>a").on('keydown', function(e){				
				if (e.shiftKey == true && e.which == 9) {
					var TargetParentIndex = $(this).parent("li").index()-1;
					if(!$("header>nav #gnb>li").eq(TargetParentIndex).find("li").not(TargetState).last().hasClass("child")){
						setTimeout(function() {
							$("header>nav #gnb>li").eq(TargetParentIndex).find("li").not(TargetState).last().find("a").focus();
						}, 1); 
					} else{
						setTimeout(function() {
							$("header>nav #gnb>li").eq(TargetParentIndex).find("li").not(TargetState).last().find(".menuS li").not(TargetState).last().find("a").focus();
						}, 1);
					}
				}
			});
		}
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
	
	}
}















