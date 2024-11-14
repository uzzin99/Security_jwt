$(window).on('load', function(){
	ui.init();
	ui.touchDim();

	// if($(window).width() <= 1300){
	// 	ui.touchDim();
	// }

    //240213
    $(window).on('message', function(event) {
		// 수신한 메시지 확인
		var receivedMessage = event.originalEvent.data;
		
		// "unlockScroll" 메시지인지 확인
		if (receivedMessage === 'unlockScroll') {
		  // 스크롤 잠금 해제 작업 수행
		  ui.lockBody.unlock();
		}
	});
});

/*
function popClose() {
	$(document).on('click', '.btn_popClose', function() {
		// alert('open');
		$('.pop_wrap').removeClass('on');
		$('.pop_wrap').find(".focuseouthidden").remove();
		$("[data-retrunFocus=Y]").focus();

		$(parent.document.body).css('overflow','');

		// var select = $(parent.document.body);
		// console.log(select)
	});
};
*/

var ui = {
	init : function() {
		ui.select.init();		//selectBox
		ui.swiper.init();
		ui.LayerPop.init();
		ui.Tab.init();
		ui.Accordion.init();
		ui.contentSet();
		ui.share();
		ui.sideProgram();
		
		ui.accessibility.GNB();

	},
	contentSet : function(){
		//메인-검색
		$(".btn_totalSearch").click(function(){
			$(".top_search").fadeIn();
		});
		$(".btn_close").click(function(){
			$(".top_search").fadeOut();
		});

		//서브배너존
		$("header .top_util .btn_topBnrzone").click(function(){
			$(".mPopZone").addClass('firstOn');
			$(".mPopZone_dim").addClass('on');
		});

		//네이버 앱으로 진입시 top버튼 삭제
		var userAg = navigator.userAgent;
		if(userAg.indexOf("NAVER") == "-1"){
			//alert("네이버 앱이 아닙니다")
		} else{
			//alert("네이버 앱")
			$(".topBtn").remove();
		}

		//아이콘 텍스트 박스 .iconEtcArea 우측 버튼 영역만큼 셋팅
		if ($(window).width() >= 1040) {
			$(".iconEtcArea").each(function(e){
				if($(this).find(".etcArea").length != 0){
					var AreaPadding = $(this).find(".etcArea").width() + 80;
					$(this).css("padding-right", AreaPadding+"px");
				}
			});
		}
		
		//컨텐츠 버튼 우측 정렬 일경우
		if ($(window).width() >= 1040) {
			if($(".contBtn.right").length != 0){
				$(".contBtn.right").each(function(e){
					var contBtnPadding = $(this).innerWidth() + 40;
					$(this).parents(".division").css("padding-right", contBtnPadding +"px");
				});
			}
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
				$(".iconEtcArea").each(function(e){
					if($(this).find(".etcArea").length != 0){
						var AreaPadding = $(this).find(".etcArea").width() + 80;
						$(this).css("padding-right", AreaPadding+"px");
					}
				});

				if($(".contBtn.right").length != 0){
					$(".contBtn.right").each(function(e){
						var contBtnPadding = $(this).innerWidth() + 40;
						$(this).parents(".division").css("padding-right", contBtnPadding +"px");
					});
				}
			} else {
				//console.log("모바일")
				$(".iconEtcArea").removeAttr("style");

				if($(".contBtn.right").length != 0){
					$(".contBtn.right").each(function(e){
						$(this).parents(".division").removeAttr("style");
					});
				}
			}

			//도트리스트 타이틀 설정시
			$(".txtList.subTitSet>li").each(function(e){
				if($(this).find(".txtDotTit").length != 0){
					var leftPadding = $(this).find(".txtDotTit").innerWidth() + 15;
					$(this).css("padding-left", leftPadding+"px");
				}
			});

			//테이블 가로 스크롤 발생시 터치 보조 딤 생성
			ui.touchDim();
		});
		
		contTitPosCopy();
		function contTitPosCopy(){
			if($(".groupCont .contSection>dt .headBtn").length != "0"){
				//console.log($(".groupCont .contSection>dt .headBtn").length);
				$(".groupCont .contSection>dt .headBtn").each(function(index){
					$(this).parent("dt").next("dd").append("<p class='headBtn'></p>");
					$(this).clone(true).appendTo($(this).parent("dt").next("dd").find(".headBtn"));
					//$(this).parent("dt").next("dd").append("<p class='headBtn'>"+copyHtml+"</p>");
				});
			}
		}

		//등장모션 UI 적용
		if ($('article').length != "-1") {
			setTimeout(function(){
				$('article:not(.noAni)').addClass('fadeUp');
			})
		}

		if ($(".bottomContArea>dl").length != "-1") {
			$(".bottomContArea>dl>dt").each(function (index) {
				$(this).attr({
					"data-aos": "fade-up",
					"data-aos-duration": "1000",
					"data-aos-once": "true"
				});
			});
			$(".bottomContArea>dl>dd>.division").each(function (index) {
				$(this).attr({
					"data-aos": "fade-up",
					"data-aos-duration": "1000",
					"data-aos-once": "true",
					"data-aos-delay": "200"
				});
			});
		}

		if ($(".bottomContArea>.division").length != "-1") {
			$(".bottomContArea>.division").each(function (index) {
				$(this).attr({
					"data-aos": "fade-up",
					"data-aos-duration": "1000",
					"data-aos-once": "true"
				});
			});
		}

		if ($(".bottomContArea .contTab_Group .contTab>.division").length != "-1") {
			$(".bottomContArea .contTab_Group .contTab>.division").each(function (index) {
				$(this).attr({
					"data-aos": "fade-up",
					"data-aos-duration": "1000",
					"data-aos-once": "true"
				});
			});
		}
		AOS.init();
		
		var subNowScrollTop = Math.ceil($(window).scrollTop());
		
		fullImgActive();
		$(window).scroll(function () {
			subNowScrollTop = Math.ceil($(this).scrollTop());
			fullImgActive();
		});

		function fullImgActive(){
			$(".motionImg").each(function(){
				var position = $(this).offset().top - ($(window).innerHeight()) ;
				var scrollHeight = $(this).innerHeight();
				if(subNowScrollTop>position){
					if(!$(this).hasClass("active")){
						$(this).addClass("active");
					}
				}
			});
		}


		// 프린트 출력
		$(document).on("click", ".btn_print", function(){
			window.print();
		});
		
	},
	Accordion : {
		init : function(){
			$("body *").each(function(e){
				if($(this).hasClass("AccordionBase")){
					$(this).find("li").each(function(e){
						if($(this).hasClass("on")){
							$(this).find(".AccordionBtn").attr({"aria-expanded": true, "title":"확장됨"});
						}else{
							$(this).find(".AccordionBtn").attr("aria-expanded", false);
							$(this).find(".AccordionBtn").removeAttr("title");
						}
					});

					$(this).find(".AccordionBtn").on("click", function(e){
						ui.Accordion.click(this);
					});
				}
			});
		},
		click : function(target){
			if($(target).parents("li").hasClass("on")){
				$(target).parents("li").removeClass("on").find(".AccordionCont").slideUp(300);
				$(target).parents("li").find(".AccordionBtn").removeAttr("title").attr("aria-expanded", false);
			}else{
				$(target).parents("li").addClass("on").find(".AccordionCont").slideDown(300);
				$(target).parents("li").find(".AccordionBtn").attr({"aria-expanded": true, "title":"확장됨"});

				ui.touchDim();
			}
		},
	},
	LayerPop : {
		init : function(){
			$(".openLYpop").on("click",function(e){
				var popTarget = $(this).attr("data-LYID"),
				    popSize   = $(this).attr("data-LYsize");

				ui.LayerPop.Show(popTarget, popSize);
			});			
		},
		iframe : function(iframeID, PopID, PopSize){
			//console.log(event);
			if(event != undefined){
				$(event.currentTarget).attr("data-retrunFocus","Y");
			}
			$(iframeID).addClass("on");
			$(iframeID).on('load', function() {
				$(iframeID).contents().find(PopID).attr("data-iframeID", iframeID);
				$(iframeID)[0].contentWindow.ui.LayerPop.Show(PopID, PopSize);
				//스크롤 막기
				ui.lockBody.lock();
			});
			// 231212
			function lockPopLayout() {
				ui.lockBody.lock();
				var parentBody = window.parent.document.body;
				var parentHtml = window.parent.document.html;
				
				$(parentBody).css({
					height: "100%",
					overflow: "hidden"
				});

				$(parentHtml).css({
					height: "100%",
					overflow: "hidden"
				});

				// $(parentBody).find('#header, #container, #footer').css({
				// 	top: - (ui.lockBody.val.LockScrollTop)
				// });
			}
			
			lockPopLayout();
		},
		Show : function(PopID, PopSize, open_callbackfcn, open_Pram, closed_callbackfcn, closed_Pram){
			//닫기 실행시 포커스 리턴값 셋팅
			//console.log(event);
			if(event != undefined){
				$(event.currentTarget).attr("data-retrunFocus","Y");
			}

			//팝업실행
			//$(PopID).find(".popLayout").css("max-width", PopSize + "px");
			$(PopID).show();
			$(PopID).css("display", "flex");
			
			//팝업실행시 스크롤 막기(문제발생)
			ui.lockBody.lock();

			ui.LayerPop.centerAlign(PopID);

			//팝업 높이 최대값 설정
			ui.LayerPop.MaxHeight(PopID);

			//첫뻔재, 마지막 타겟 셋팅시 예외상태 추가
			var TargetState = "[data-hidden=hidden], [style*='display:none'], [style*='display: none'], [style*='display :none'], [style*='display : none']";

			//첫번째, 마지막 포커스 셋팅 전 css로 display:none 처리 되어있는 타겟 분리
			$(PopID).find("a, button, input, select").not(TargetState).each(function(e){
				if($(this).is(":visible") == false){
					$(this).attr("data-hidden","hidden");
				}
			});
			
			
			//팝업 내에 첫번째, 마지막 타겟 지정
			$(PopID).find("a, button, input, select").not(TargetState).first().attr("data-pop-focus","first");
			$(PopID).find("a, button, input, select").not(TargetState).last().attr("data-pop-focus","last");
			
			//팝업뒤 포커스 이동할 객제가 하나도 없을경우 브라우저 밖으로 포커스 이탈 방지를 위한 히든영역
			$(PopID).append("<div class='focuseouthidden' tabindex='0'></div>");

			//팝업내 버튼이 없을경우 팝업영역을 첫번째 포커스로 잡음
			if($(PopID).find("a, button, input, select").length == 1){
				$(PopID).find(".popLayout").attr({"tabindex" : "0", "data-pop-focus":"first"});	
			}

			$(PopID).find('[data-pop-focus=first]').focus();
			
			$("body *").not(PopID).not(PopID + " *").attr({
				"aria-hidden" : true,
				"data-hidden" : "hidden"
			});
			
			//html 깊이 구해서 aria-hidden 처리 삭제
			var targetHtml = $(PopID);
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

			//오픈 콜백
			if(open_callbackfcn != undefined){
				eval(open_callbackfcn)(open_Pram);
			}

			//팝업 닫기
			$(PopID).find('.btn_popClose').on("click",function(e){
				ui.LayerPop.Closed(PopID, closed_callbackfcn, closed_Pram);
				ui.lockBody.unlock();
			});

			//접근성 : 첫번째탭에서 shift + tab 경우 마지막버튼으로 (팝업내 포커스 루프)
			$(PopID).find("[data-pop-focus=first]").on("keydown", function(e){
				if(e.shiftKey == true && e.which == 9){
					$(PopID).find("[data-pop-focus=last]").focus();
					return false;
				}
			});
			
			//접근성 : 마지막탭에서 tab 경우 첫번째 버튼 (팝업내 포커스 루프)
			$(PopID).find("[data-pop-focus=last]").on("keydown", function(e){
				if(e.shiftKey == false && e.which == 9){
					$(PopID).find("[data-pop-focus=first]").focus();
					return false;
				}
			});
		},
		Closed : function(PopID, closed_callbackfcn, closed_Pram){
			$(PopID).hide();
			$(PopID).find(".focuseouthidden").remove();
			$("[data-retrunFocus=Y]").focus();
			ui.lockBody.unlock();
			
			// lockPopLayout();

			//아이프레임 닫기포커스
			if ( self !== top ) {
                // 부모 창으로 메시지 전송(240213)
                window.parent.postMessage('unlockScroll', '*');

				$("[data-retrunFocus=Y]", parent.document).focus().removeAttr("data-retrunFocus");
				$($(PopID).attr("data-iframeid"), parent.document).removeClass("on").remove();               
			}
			
			// $("[data-retrunFocus=Y]", parent.document).focus().removeAttr("data-retrunFocus");
			// $($(PopID).attr("data-iframeid"), parent.document).removeClass("on").remove();
			

			$("body *").removeAttr("data-retrunFocus");
			$("[data-hidden=hidden]").removeAttr("data-hidden").removeAttr("aria-hidden");

			$(".pop_wrap.addHtmlPop").remove();
			
			/* 닫기 콜백 */
			if(closed_callbackfcn != undefined){
				eval(closed_callbackfcn)(closed_Pram);
			}			
			
		},
		MaxHeight : function(PopID){
			var bottomHeight = $(PopID).find(".popBtnArea").innerHeight();
			if(bottomHeight == undefined){bottomHeight = 0}
			//팝업 높이 최대값 설정
			// $(PopID).find(".popInner").css({
			// 	"max-height": $(window).height() * 0.9 - $(PopID).find(".popTit").innerHeight() - bottomHeight
			// });
			//console.log(bottomHeight);
			//리사이즈 팝업 높이 최대값 설정
			// $(window).bind('resize load', function () {
			// 	$(PopID).find(".popInner").css({
			// 		"max-height": $(window).height() * 0.9 - $(PopID).find(".popTit").innerHeight() - bottomHeight
			// 	});
			// });
		},
		centerAlign : function(PopID){
			//팝업 센터정렬(transform 정렬할경우 흐릿하게 나오는 케이스 발생)
			// setTimeout(function(){
			// 	$(PopID).find(".popLayout").css({
			// 		"left" : "calc(50% - " + $(PopID).find(".popLayout").innerWidth() / 2 +"px)",
			// 		"top"  : "calc(50% - " + $(PopID).find(".popLayout").innerHeight() / 2 +"px)",
			// 		"opacity" : "1"
			// 	});
			// },100)
		
			//리사이즈
			// $(window).bind('resize load', function () {
			// 	$(PopID).find(".popLayout").css({
			// 		"left" : "calc(50% - " + $(PopID).find(".popLayout").innerWidth() / 2 +"px)",
			// 		"top"  : "calc(50% - " + $(PopID).find(".popLayout").innerHeight() / 2 +"px)"
			// 	})
			// });
		},
		draw : function(conthtml, title, size){
			var popID = "popupDraw" + Math.round( Math.random()*100 );
			var PopHtml = "";
			PopHtml += '<div class="pop_wrap addHtmlPop" id="'+popID+'">';
			PopHtml += '	<section class="popLayout popLayer">';
			PopHtml += '		<h1 class="popTit">'+title+'</h1>';
			PopHtml += '		<div class="popConts">';
			PopHtml += '			<div class="popInner limit">';
			PopHtml += $(conthtml).html();
			PopHtml += '			</div>';
			PopHtml += '		</div>';
			PopHtml += '		<button type="button" class="btn_popClose"><span class="hidden">창닫기</span></button>';
			PopHtml += '	</section>';
			PopHtml += '</div>';

			$("body").append(PopHtml);
			ui.LayerPop.Show('#'+popID, size);
		}
	},
	//swiper
	swiper : {
		init : function(){
			ui.swiper.flexble();
			ui.swiper.lineDivswiperFlexble();
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
		lineDivswiperFlexble : function(){
			if($('[data-id=lineDivswiperFlexble]').length == 0){return false}
			
			var ww = $(window).width();
			var swiperlineDivswiperFlexble = undefined;
			
			$(window).on('load resize', function () {
				ww = $(window).width();
				initSwiper();
			});

			function initSwiper() {
				if (swiperlineDivswiperFlexble == undefined) {
					var swiperOption = {
						slidesPerView: "auto",
						freeMode: true,
					}
					swiperlineDivswiperFlexble = new Swiper('[data-id=lineDivswiperFlexble]', swiperOption);
				}
			}
		},
	},
	//셀릭트박스
	select : {
		init : function(){
			$("[data-id=select]").each(function(e){
				$(this).find(".toggleBtn").attr("aria-expanded", false);
				$(this).find(".option").attr("role", "listbox");
				
				$(this).find(".option button").each(function(e){
					$(this).attr("role","option");
				})
				 
				$(this).find(".toggleBtn").on("click", function(e){
					ui.select.click.val(this);
				});

				$(this).find(".option>button").on("click", function(e){
					ui.select.click.option(this);
				});
			});

			$(document).on("click", function(e){
				if($(e.target).parents(".selectBase").hasClass("selectBase")){

				}else{
					ui.select.action.close(".selectBase>.toggleBtn");
				}
			});
		},
		click : {
			val : function(target){
				if($(target).parents(".selectBase").hasClass("on")){
					ui.select.action.close(target);
				}else{
					ui.select.action.open(target);
				}
			},
			option : function (target){
				var optionVal  = $(target).val(),		//선택된 옵션값
					optionName = $(target).html();		//선택된 텍스트
				$(target).parents(".selectBase").find(".toggleBtn").html(optionName).val(optionVal);

				ui.select.action.close(target);
			}
		},
		action : {
			open : function(target){
				var title = $(target).attr("title");
				if(title == undefined){title = "";}

				$(target).parents(".selectBase").addClass("on").find(".option").fadeIn(200);
				$(target).parents(".selectBase").find(".toggleBtn").attr({"aria-expanded": true});

				if($(target).parents(".contTable").hasClass("inputType")){
					$(target).parents(".inputType").addClass("open");
				}
			},
			close : function(target){
				var title = $(target).attr("title");
				$(target).parents(".selectBase").removeClass("on").find(".option").fadeOut(200);
				$(".inputType").removeClass("open").scrollLeft(0);

				if(title == undefined){
					$(target).parents(".selectBase").find(".toggleBtn").attr("aria-expanded", false);	
				}
				else{
					// $(target).parents(".selectBase").find(".toggleBtn").attr({"aria-expanded": false, "title": title.replace(" 확장됨", "")});
					$(target).parents(".selectBase").find(".toggleBtn").attr("aria-expanded", false);
				}
			}
		},
		setVal : function(target, val){
			var SelectOption = $(target).next(".option").find("button[value="+val+"]").html();
			if(SelectOption != undefined){
				$(target).html(SelectOption).val(val);	
			}
		}
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

				//버튼을 체크박스처럼 사용 할 경우
				if($(this).attr("role") == "tabCkEl"){
					$(this).find("li").each(function(e){
						if($(this).is(":visible") == true){
							$(this).attr("role", "presentation");	
							$(this).find("a").attr("role", "tab");
						}	

						if($(this).hasClass("on")){
							$(this).find("a").attr({"aria-selected": true, "title":"선택됨"});
						}else{
							$(this).find("a").attr("aria-selected", false);
							$(this).find("a").removeAttr("title");
						}
					});

					$(this).find("ul a").on("click", function(e){
						ui.Tab.clickCk(this);
					});
				}

				//버튼을 라디오버튼처럼 사용 할 경우
				if($(this).attr("role") == "tabRadioEl"){
					$(this).find("li").each(function(e){
						if($(this).is(":visible") == true){
							$(this).attr("role", "presentation");	
							$(this).find("a").attr("role", "tab");
						}	

						if($(this).hasClass("on")){
							$(this).find("a").attr({"aria-selected": true, "title":"선택됨"});
						}else{
							$(this).find("a").attr("aria-selected", false);
							$(this).find("a").removeAttr("title");
						}
					});

					$(this).find("ul a").on("click", function(e){
						ui.Tab.clickRadio(this);
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
				console.log("33333");
				hideID.push($(this).attr("data-tabID"));
			});
			for(i=0;i<hideID.length;i++){
				$("#" + hideID[i]).removeClass("on");
			}
			$("#"+$(target).attr("data-tabID")).addClass("on");
		},
		clickCk :function(target){
			if($(target).parents("li").hasClass("on")){
				$(target).parents("li").removeClass("on").find("a").attr("aria-selected", false).removeAttr("title");
			} else{
				$(target).parents("li").addClass("on").find("a").attr({"aria-selected": true, "title":"선택됨"});
			}
		},
		clickRadio :function(target){			
			if($(target).parents("li").hasClass("on")){
				$(target).parents("li").removeClass("on").find("a").attr("aria-selected", false).removeAttr("title");
			} else{
				$(target).parents("ul").find("li").removeClass("on").find("a").attr("aria-selected", false).removeAttr("title");
				$(target).parents("li").addClass("on").find("a").attr({"aria-selected": true, "title":"선택됨"});
			}
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
		$("[data-id=btn_share]").on("click", function(e){
			$(".typeSub .pageUtil .shareArea").show();
			ui.accessibility.focusloop(".shareArea");

			if($(window).width() <= 1040 ){
				$("#header").css("z-index","981");
				$(".typeSub .pageUtil .shareArea").addClass("on");
			}
		});

		$(".typeSub .pageUtil .shareArea .shareClosed").on("click", function(e){
			
			if($(window).width() <= 1040 ){
				$(".typeSub .pageUtil .shareArea").removeClass("on");
				setTimeout(function(){
					$(".typeSub .pageUtil .shareArea").hide();
					$("#header").css("z-index","");
				},300)
			} else{
				$(".typeSub .pageUtil .shareArea").hide();
			}
			ui.accessibility.focusloopClose();
		});

		// $(window).bind('resize', function () {
		// 	if($(".typeSub .pageUtil .shareArea").is(":visible") == true){
		// 		$(".typeSub .pageUtil .shareArea .shareClosed").trigger("click");
		// 	}
        // });
	},
	sideProgram : function(){
		$(".side_program .btn_program").click(function(){
			if($(this).hasClass('on')){
				$("#dim").removeClass("side");
				$(this).removeClass('on');
				$(this).attr("title","스케줄 축소됨");
				$(".sideProgramBox").removeClass('on');
				$(".sideProgramBox .list").css({
					"height": ""
				});
			}else{
				$("#dim").addClass("side");
				$(this).addClass('on');
				$(this).attr("title","스케줄 펼쳐짐");
				$(".sideProgramBox").addClass('on');

				sideProgramBox();
			}
		});
		$(".top_util .mBtn_program").click(function(){
			$(".side_program .btn_program").addClass('on');
			$(".sideProgramBox").addClass('on');

			sideProgramBox();
		});
		$(".sideProgramBox  .mBtn_close").click(function(){
			$(".side_program .btn_program").removeClass('on');
			$(".sideProgramBox").removeClass('on');
			$(".sideProgramBox .list").css({
				"height": ""
			});
		});

		$(".sideProgramBox .list").mCustomScrollbar();

		function sideProgramBox(){
			if(window.innerWidth >= 1041){
				$(".sideProgramBox .list").css({
					"height": window.innerHeight - 140
				});
			}else{
				$(".sideProgramBox .list").css({
					"height": window.innerHeight - 70
				});
			}
		};
		
		$(window).bind('load resize', function () {
			if(window.innerWidth >= 1041){
				$(".typeSub .sideProgramBox").removeClass('on');
				$(".typeSub #dim").removeClass('side');
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
				$("#skip_menu a").eq(0).attr("data-retrunFocus","Y");
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
			if($(area).find("[data-pop-focus=first]").length == "0"){
				$(area).attr({"tabindex" : "0", "data-pop-focus":"first"});	
				$(area).focus();
			} else{
				$(area).find('[data-pop-focus=first]').focus();
			}
			
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
		},
		SNB : {
			init : function(){
				//snb 포커스이벤트
				$("#snb_nav .snb_area > button").on("keydown", function (e) {
					var focusIndex = $(this).index();
					console.log(focusIndex)
					if (e.shiftKey == true && e.which == 9) {
						ui.accessibility.SNB.SNBfocusout();
					}

					else if (e.shiftKey == false && e.which == 9) {
						if($("#snb").css("display") == "block"){
							//1뎁스
							if(focusIndex == 1){
								setTimeout(function(){
									$("li[data-SnbfirstTargetD1=true] > a").focus();
								},0);
							}
							//2뎁스
							else if(focusIndex == 2){
								setTimeout(function(){
									$("li[data-SnbfirstTargetD2=true] > a").focus();
								},0);
							}
							//3뎁스
							else if(focusIndex == 3){
								setTimeout(function(){
									$("li[data-SnbfirstTargetD3=true] > a").focus();
								},0);
							}
							//4뎁스
							else if(focusIndex == 4){
								setTimeout(function(){
									$("li[data-SnbfirstTargetD4=true] > a").focus();
								},0);
							}
						}
					}
				});
				//SNB 첫번째 / 마지막 포커스 제어 이벤트
				ui.accessibility.SNB.firstFocuseout();
				ui.accessibility.SNB.lastFocuseout();
			},
			//SNB 첫번째 포커스 제어
			firstFocuseout : function(){
				//각 SNB중 CMS에서 display none 처리할경우 해당객체를 제외한 나머지 중 첫번째 타겟 셋팅
				//CMS 에서 display:none << 띄어쓰기가 브라우져 별로 상이해서 2개 타입 추가
				//1뎁스
				$("#snb_nav #snb > li").not("[style*='display:none']").not("[style*='display: none']").first().attr('data-SnbfirstTargetD1',"true");
				//2뎁스
				$("#snb_nav #snb li.on .menuM > li").not("[style*='display:none']").not("[style*='display: none']").first().attr('data-SnbfirstTargetD2',"true");
				//3뎁스
				$("#snb_nav #snb li.on .menuM li.on .menuS > li").not("[style*='display:none']").not("[style*='display: none']").first().attr('data-SnbfirstTargetD3',"true");
				//4뎁스
				$("#snb_nav #snb li.on .menuM li.on .menuS li.on .menuSS > li").first("[style*='display:none']").not("[style*='display: none']").last().attr('data-SnbfirstTargetD4',"true");

				//1뎁스 첫번째포커스 이벤트
				$("li[data-SnbfirstTargetD1=true] > a").on("keydown", function (e) {
					if (e.shiftKey == true && e.which == 9) {
						setTimeout(function () {
							$("#snb_nav .snb_area > button:nth-of-type(1)").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(1);
					}
				});

				//2뎁스 첫번째포커스 이벤트
				$("li[data-SnbfirstTargetD2=true] > a").on("keydown", function (e) {
					if (e.shiftKey == true && e.which == 9) {
						setTimeout(function () {
							$("#snb_nav .snb_area > button:nth-of-type(2)").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(2);
					}
				});

				//3뎁스 첫번째포커스 이벤트
				$("li[data-SnbfirstTargetD3=true] > a").on("keydown", function (e) {
					if (e.shiftKey == true && e.which == 9) {
						setTimeout(function () {
							$("#snb_nav .snb_area > button:nth-of-type(3)").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(3);
					}
				});

				//4뎁스 첫번째포커스 이벤트
				$("li[data-SnbfirstTargetD4=true] > a").on("keydown", function (e) {
					if (e.shiftKey == true && e.which == 9) {
						setTimeout(function () {
							$("#snb_nav .snb_area > button:nth-of-type(4)").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(4);
					}
				});
			},
			//SNB 마지막 포커스 셋팅 후 이벤트 제어
			lastFocuseout : function(){
				//각 SNB중 CMS에서 display none 처리할경우 해당객체를 제외한 나머지 중 마지막 타겟 셋팅
				//CMS 에서 display:none << 띄어쓰기가 브라우져 별로 상이해서 2개 타입 추가
				//1뎁스
				$("#snb_nav #snb > li").not("[style*='display:none']").not("[style*='display: none']").last().attr('data-SnbLastTargetD1',"true");
				//2뎁스
				$("#snb_nav #snb li.on .menuM > li").not("[style*='display:none']").not("[style*='display: none']").last().attr('data-SnbLastTargetD2',"true");
				//3뎁스
				$("#snb_nav #snb li.on .menuM li.on .menuS > li").not("[style*='display:none']").not("[style*='display: none']").last().attr('data-SnbLastTargetD3',"true");
				//4뎁스
				$("#snb_nav #snb li.on .menuM li.on .menuS li.on .menuSS > li").not("[style*='display:none']").not("[style*='display: none']").last().attr('data-SnbLastTargetD4',"true");

				//1뎁스 마지막포커스 이벤트
				$("li[data-SnbLastTargetD1=true] > a").on("keydown", function (e) {
					if (e.shiftKey == false && e.which == 9) {
						setTimeout(function () {
							$("#snb_nav .snb_area > button:nth-of-type(2)").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(1);
					}
				});

				//2뎁스 마지막포커스 이벤트
				$("li[data-SnbLastTargetD2=true] > a").on("keydown", function (e) {
					if (e.shiftKey == false && e.which == 9) {
						if($("#snb_nav .snb_area > button:nth-of-type(3)").index() == "-1"){
							setTimeout(function () {
								$(".typeSub .pageUtil>.btn_print").focus();
							}, 0);
						} else{
							setTimeout(function () {
								$("#snb_nav .snb_area > button:nth-of-type(3)").focus();
							}, 0);
						}
						ui.accessibility.SNB.SNBfocusout(2);
					}
				});

				//3뎁스 마지막포커스 이벤트
				$("li[data-SnbLastTargetD3=true] > a").on("keydown", function (e) {
					console.log(111);
					if (e.shiftKey == false && e.which == 9) {
						if($("#snb_nav .snb_area > button:nth-of-type(4)").index() == "-1"){
							setTimeout(function () {
								$(".typeSub .pageUtil>.btn_print").focus();
							}, 0);
						} else{
							setTimeout(function () {
								$("#snb_nav .snb_area > button:nth-of-type(4)").focus();
							}, 0);
						}
						ui.accessibility.SNB.SNBfocusout(3);
					}
				});

				//4뎁스 마지막포커스 이벤트
				$("li[data-SnbLastTargetD4=true] > a").on("keydown", function (e) {
					if (e.shiftKey == false && e.which == 9) {
						setTimeout(function () {
							$(".typeSub .pageUtil>.btn_print").focus();
						}, 0);
						ui.accessibility.SNB.SNBfocusout(4);
					}
				});

			},
			SNBfocusout : function(index){
				// $("#snb_nav .snb_area>button").removeClass("active");
				// $("#snb").slideUp(50);
				// $("#dim").removeClass('on').css('top','');
				// $(".sVisual").css("z-index","");

				$("#snb_nav .snb_area>button").eq(index-1).trigger("click");
			}
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
	
	},
	stepRows : function(target, item, point, pointItem){
		//지정포인트
		if(window.innerWidth >= point){
			$(target).removeClass("rowItem3 rowItem2");
			ui.contAutoSetion(""+target+">ul .item", item);
			//console.log(1);
		} 
		
		else if(window.innerWidth >= 768){
			if(pointItem == 3){
				$(target).addClass("rowItem3");
				ui.contAutoSetion(""+target+">ul .item", "3");
			}
			if(pointItem == 2){
				$(target).addClass("rowItem2");
				ui.contAutoSetion(""+target+">ul .item", "2");
			}
		} 
		//모바일
		else{
			$(target).removeClass("rowItem3 rowItem2");
			ui.contAutoSetion(""+target+">ul .item", "1");
			//console.log(3);
		}
	},
	//모바일 본문 스크롤 방지
	lockBody : {
		val : {
			mobileBodyLock : "N",						//모바일 body 스크롤 락 여부
			LockEl : 'html, body',						//scroll 타겟
			contWrap : '#header, #footer, #container',					//컨텐츠 영역
			LockScrollTop : "", 						//스크롤 락 시도시 현재 스크롤 값
		},
		//잠그기
		lock : function(){
			if(window.pageYOffset) {
				ui.lockBody.val.LockScrollTop = window.pageYOffset;
				$(ui.lockBody.val.contWrap).css({
					top: - (ui.lockBody.val.LockScrollTop)
				});
			}
			$(ui.lockBody.val.LockEl).css({
				height: "100%",
				overflow: "hidden"
			});

			ui.lockBody.val.mobileBodyLock = "Y";
		},
		//해지
		unlock : function(){
			$(ui.lockBody.val.LockEl).css({
				height: "",
				overflow: ""
			});

			$(ui.lockBody.val.contWrap).css({
				top: ""
			});

			window.scrollTo(0, ui.lockBody.val.LockScrollTop);
			window.setTimeout(function () {
				ui.lockBody.val.LockScrollTop = null;
			}, 0);

			ui.lockBody.val.mobileBodyLock = "N";
		}
	},
	//SNB PC 뎁스별 최대 넓이값 구하기
	snbDept : {
		init  : function(breakPoint){

			onePoint = "";
			if(window.innerWidth <= breakPoint){
				onePoint = "PC";
			} else{
				onePoint = "MOBIE";
			}

			ui.snbDept.set(breakPoint);
			$(window).bind('resize', function(){
				ui.snbDept.set(breakPoint);
			});
		},
		set : function(breakPoint){
			//SNB 각 뎁스별 최대 넓이 갑 구하기
			//+58은 ul의 padding 값 + 보더 양끝 2 더한 값 / 30은 앞에 58값과 버튼 좌 우 패딩 값을 - 한 나머지 값을 + 해줘야 가장 넓은 뎁스가 활성화 되었을때 텍스트가 잘리지 않음
			var margin = 58 + 30;
			if(window.innerWidth <= breakPoint){
				if(onePoint == "PC"){	
					onePoint = "MOBIE";
					$("#snb_nav .snb_area>button").removeAttr("style");
					//console.log("모바일");
				}
			}else{
				if(onePoint == "MOBIE"){
					//1뎁스 			
					$("#snb_nav").removeAttr("class").addClass("active1");
					$("#snb").show().css({"width":"auto","visibility":"hidden"});
					$("#snb_nav .snb_area>button.dep1").css("width", $("#snb>li.on").outerWidth() + margin+"px");

					//2뎁스
					$("#snb_nav").removeAttr("class").addClass("active2");
					$("#snb").show().css("width","auto");
				
					$("#snb_nav .snb_area>button.dep2").css("width", $("#snb>li.on>.menuM").outerWidth() + margin + "px");

					//3뎁스
					$("#snb_nav").removeAttr("class").addClass("active3");
					$("#snb").show().css("width","auto");
					$("#snb_nav .snb_area>button.dep3").css("width", $("#snb>li.on>.menuM>li.on>.menuS").outerWidth() + margin + "px");

					$("#snb_nav").removeAttr("class");
					$("#snb").hide().removeAttr("style");
					//console.log("PC");

					onePoint = "PC";
				}
				
			}
		}
	},
	//타겟, 반복등장여부, 반복일경우 반복할 객체 딜레이, 등장옵션(기본 페이드업)
	motionSet : function (target, loop, delay, option){
		var motion = "fade-up";
		if(option != undefined){
			motion = option;
		}

		if(loop == "Y"){
			var delay = Number(delay);

			$(target).each(function (index) {
				$(this).attr({
					"data-aos": motion,
					"data-aos-duration": "1000",
					"data-aos-once": "true",
					"data-aos-delay": delay,
				});
				delay = delay + 200;
			});
		}
		else{
			$(target).attr({
				"data-aos": motion,
				"data-aos-duration": "1000",
				"data-aos-once": "true",
				"data-aos-delay": delay,
			});
		}

		AOS.init();
	}
}















