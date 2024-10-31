<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
<jsp:include page="./IncHeaderM.jsp"/>
<script>
var gnbDep1 = 0;
var gnbDep2 = 0;
var gnbDep3 = 0;
</script>
<script src="common.js"></script>
<script>
    history.scrollRestoration = "manual";

    $(function(){
        setTimeout(function(){
            $('.mVisual').addClass('firstAni')
        },50);

        $(window).scroll(function(){
            cont_loc=$(window).scrollTop();
            var winH = $(window).innerHeight();
            var winBtmH = cont_loc + winH;
            
            var btmList1 = $ ('.mNotice').offset().top;

            if (cont_loc  + 400) {
                $('.mNotice').addClass('ani')
            }
        });
    });
    
    function fn_link_boardlist(tabGbn){
    	console.log("33333");
    	var tempcd = $("section.mNoticeCont."+tabGbn).find("div.contTab.on").data("tempcd");
    	var basesiteno = $("section.mNoticeCont."+tabGbn).find("div.contTab.on").data("basesiteno");
    	var configcd = $("section.mNoticeCont."+tabGbn).find("div.contTab.on").data("configcd");
    	var configseq = $("section.mNoticeCont."+tabGbn).find("div.contTab.on").data("configseq");
    	var subseq = $("section.mNoticeCont."+tabGbn).find("div.contTab.on").data("subseq");
    	location.href="${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BL&TEMP_CODE="+tempcd+"&BASE_SITE_NO="+basesiteno+"&BASE_SITE_NO="+basesiteno+"&CONFIG_CD="+configcd+"&CONFIG_SEQ="+configseq+"&SUB_SEQ="+subseq;    			
    }
</script>
<script>

$(document).on('click', '.tabList li a', function() {
	var tabId = $(this).attr("data-tabid");
	
	if (tabId.match("mNotice_tab1_") || tabId.match("mNotice_tab3_") || tabId.match("mNotice_tab4_")) {
		ui.Tab.init();
	}else if(tabId.match("mNotice_tab2_")) {
		main.mQNA();
		ui.Tab.init();
	}
});
$(document).ready(function() {
	sendAjaxRequest('/mainApi/getMainItem', 'GET', null,
		function(data) {
	    	// 성공 시 처리
	    	if(data.mainConfigC1430_1) $(".mV_tit h2").html(data.mainConfigC1430_1.BG_TEXT); 
			
			<!-- 아이콘배너 -->
            if(data.mainConfigSubC1402_1) {
                var itemsHtml = "";
                $.each(data.mainConfigSubC1402_1, function(index, list) {
                    itemsHtml += '<div class="item">';
                    itemsHtml += '<a href="' + list.LINK_URL + '" target="' + list.WINDOW_YN + '" style="background-image:url(attach/' + list.PC_FILE_NM_SAVED + ')">';
                    itemsHtml += '<span>' + list.TEXT1 + '</span>';
                    itemsHtml += '</a>';
                    itemsHtml += '</div>';
                });
                $(".mIcoBnr").html(itemsHtml);
            }
            <!-- 아이콘배너 -->
			
            <!-- 텍스트배너1 -->
			if(data.mainConfigC1432_1) {
				$(".vBanner .bnrOverBx h3").html(data.mainConfigC1432_1.SUB_TITLE);
				
				if(data.mainConfigSubC1432_1){
					const list = data.mainConfigSubC1432_1[0];
					$(".vBanner .bnrOverBx .bnr_bx1").css("background-image","url(/attach/" + list.PC_FILE_NM_SAVED + ")");
					
					var itemsHtml = '<ul>';
					itemsHtml += '<li><b>' + list.TEXT1 + '</b><br><span>' + list.TEXT2 + '</span></li>';
					itemsHtml += '<li><b>' + list.TEXT3 + '</b><br><span>' + list.TEXT4 + '</span></li>';
					itemsHtml += '<li><b>' + list.TEXT5 + '</b><br><span>' + list.TEXT6 + '</span></li>';
					itemsHtml += '</ul>';
					$(".vBanner .bnrOverBx .bnr_bx1 .contBx ul").html(itemsHtml);
					
					var overItemsHtml = '<li><a href="' + list.LINK_URL +'" target="' + list.WINDOW_YN + '"><span>' + list.BTN_TEXT1 + '</span></a></li>';
					overItemsHtml += '<li><a href="' + list.LINK_URL2 +'" target="' + list.WINDOW_YN2 + '"><span>' + list.BTN_TEXT2 + '</span></a></li>';
					$(".vBanner .bnrOverBx .overBx ul").html(overItemsHtml);
					
				}
			}
			<!-- 텍스트배너1 -->
			
			<!-- 텍스트배너2 -->
			if(data.mainConfigC1433_1) {
				$(".vBanner .bnr_bx2 h3").html(data.mainConfigC1433_1.SUB_TITLE);
				
				if(data.mainConfigSubC1433_1){
					const list = data.mainConfigSubC1433_1[0];
					
					$(".vBanner .bnr_bx2").css("background-image","url(/attach/" + list.PC_FILE_NM_SAVED + ")");
					
					var $element = $('.bnr_bx2 .link_arrow');
					
					addText(list.TEXT1, list.TEXT2, list.LINK_URL, list.WINDOW_YN, $element);
					addText(list.TEXT3, list.TEXT4, list.LINK_URL2, list.WINDOW_YN2, $element);
					addText(list.TEXT5, list.TEXT6, list.LINK_URL3, list.WINDOW_YN3, $element);
				}
			}
			<!-- //텍스트배너2 -->
			
			<!-- 텍스트배너3 -->
			//텍스트 배너 3
			if(data.mainConfigC1433_2) {
				$(".vBanner .bnr_bx3 h3").html(data.mainConfigC1433_2.SUB_TITLE);
				
				if(data.mainConfigSubC1433_2){
					const list = data.mainConfigSubC1433_2[0];
					
					$(".vBanner .bnr_bx3").css("background-image","url(/attach/" + list.PC_FILE_NM_SAVED + ")");
					
					var $element = $('.bnr_bx3 .link_arrow');
					
					addText(list.TEXT1, list.TEXT2, list.LINK_URL, list.WINDOW_YN, $element);
					addText(list.TEXT3, list.TEXT4, list.LINK_URL2, list.WINDOW_YN2, $element);
					addText(list.TEXT5, list.TEXT6, list.LINK_URL3, list.WINDOW_YN3, $element);
				}
			}
			<!-- 텍스트배너3 -->
			
			<!-- 텍스트배너4 -->
			if(data.mainConfigC1433_2) {
				$(".vBanner .bnr_bx4 h3").html(data.mainConfigC1433_3.SUB_TITLE);
				
				if(data.mainConfigSubC1433_3){
					const list = data.mainConfigSubC1433_3[0];
					
					$(".vBanner .bnr_bx4").css("background-image","url(/attach/" + list.PC_FILE_NM_SAVED + ")");
					
					var $element = $('.bnr_bx4 .link_arrow');
					
					addText(list.TEXT1, list.TEXT2, list.LINK_URL, list.WINDOW_YN, $element);
					addText(list.TEXT3, list.TEXT4, list.LINK_URL2, list.WINDOW_YN2, $element);
					addText(list.TEXT5, list.TEXT6, list.LINK_URL3, list.WINDOW_YN3, $element);
				}
			}
			<!-- //텍스트배너4 -->
			
			<!-- 퀵배너 -->
			if(data.mainConfigSubC1431_1) {
				const list = data.mainConfigSubC1431_1[0];
				
				<!-- tel_txt -->
				$(".tel_txt").html('<p>' + list.TEXT1 + '<br><b class="c_point">' + list.TEXT2 + '</b></p>');
				<!-- //tel_txt -->
				
				<!-- tel_img -->
				$link = $('<a></a>').attr('href', list.LINK_URL).attr('target', list.WINDOW_YN).attr('title', list.WINDOW_YN == '_blank' ? '새창열림' : '');
				$link.append('<img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=' + list.TEMP_CODE + '&CONFIG_CD=' + list.CONFIG_CD + '&CONFIG_SEQ=' + list.CONFIG_SEQ + '&SITE_NO=' + list.SITE_NO + '&SUB_SEQ=' + list.SUB_SEQ + '" alt="' + list.SUB_TEXT + '">')
				$(".mQuick .mTel_btn .tel_img").append($link);
				<!-- tel_img -->
			}
			
			if(data.mainConfigSubC1402_2) {
				<!-- quick_inner -->
				var itemsHtml = "";
				$.each(data.mainConfigSubC1402_2, function(index, list) {
                    itemsHtml += '<li>';
                    itemsHtml += '<a href="' + list.LINK_URL + '" target="' + list.WINDOW_YN + '" style="background-image:url(attach/' + list.PC_FILE_NM_SAVED + ')">';
                    itemsHtml += '<span>' + list.TEXT1 + '</span>';
                    itemsHtml += '</a>';
                    itemsHtml += '</li>';
                });
				$(".quick_inner ul").append(itemsHtml);
				<!-- //quick_inner -->
			}
			<!-- //퀵배너 -->

			<!-- //mFix_call -->
			if(data.mainConfigSubC1435_1) {
				const list = data.mainConfigSubC1435_1[0];
				var itemsHtml = '';
				itemsHtml += '<a href="/cms/CMN_CON/MainLink.do?GBN=BL&TEMP_CODE=' + list.TEMP_CODE + '&BASE_SITE_NO=' + list.SITE_NO + '&CONFIG_CD=' + list.CONFIG_CD +'&CONFIG_SEQ=' + list.CONFIG_SEQ + '&SUB_SEQ=' + list.SUB_SEQ + '" target="_blank" class="mShingu">'
				itemsHtml += '<span>' + list.TEXT1 + '</span>';
				itemsHtml += '</a>';
				
				$(".mFix_call").html(itemsHtml);
			}
			<!-- //mFix_call -->
			
			<!-- 공지사항 -->
			if(data.mainConfigC1406_1) {
				$(".mNotice .tab1 .tit_bx h3").html(data.mainConfigC1406_1.SUB_TITLE);
				$(".mNotice .tab1 .tit_bx p").html(data.mainConfigC1406_1.BG_TEXT);
				
				<!-- VIEW MORE -->
				$(".mNotice .tab1 .cont_inner .left a").attr("target", data.mainConfigC1406_1.WINDOW_YN);
				<!-- //VIEW MORE -->
				
				if(data.mainConfigSubC1406_1){
					$.each(data.mainConfigSubC1406_1, function(index, list) {
						var limit_cnt = 5;
	                	var item_v_cnt = 0;
	                	
	                	var contItems = "";
	                	
	                	<!-- 탭 만들기 -->
	                	index = index+1;
	                    var itemsHtml = tabList(index,list.TEXT1,"mNotice_tab1_");
	                	$(".mNotice .tab1 .cont_inner .pageTabBase .tabList").append(itemsHtml);
	                	<!-- //탭 만들기 -->
	                	
	                	<!-- contTab 만들기 -->
	                    if (index > 1){
	                        var clonedElement = $("#mNotice_tab1_1").clone();
	                        clonedElement.attr("id", "mNotice_tab1_" + index);
	                        $(".tab1 .contTab_Group").append(clonedElement);
	                    }
	                    <!-- contTab 만들기 -->
	                    
	                    <!-- contTab 내용 넣기 -->
	                    //탭내용리스트 (공지사항일경우)
	                    $.each(data.bbsItemsC1406_1[list.ORD_NO-1].SUB_TOP, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab1(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
	                    	}
                     	});	
	                    
	                    //탭내용리스트 (공지사항이 아닐경우)
	                    $.each(data.bbsItemsC1406_1[list.ORD_NO-1].SUB, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab1(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
							}
						});
						$("#mNotice_tab1_"+index+" #noticeTableId").html(contItems);
						<!-- contTab 내용 넣기 -->
	                });
					$("#mNotice_tab1_1").addClass("on");
				}
			}
			<!-- //공지사항 -->
			
			<!-- 입학Qna -->
			if(data.mainConfigC1406_2) {
				$(".mNotice .tab2 .tit_bx h3").html(data.mainConfigC1406_2.SUB_TITLE);
				$(".mNotice .tab2 .tit_bx p").html(data.mainConfigC1406_2.BG_TEXT);
				
				<!-- VIEW MORE -->
				$(".mNotice .tab2 .admission_etc a").attr("target", data.mainConfigC1406_2.WINDOW_YN);
				<!-- //VIEW MORE -->
				
				if(data.mainConfigSubC1406_2){
	                $.each(data.mainConfigSubC1406_2, function(index, list) {
	                	var limit_cnt = 5;
	                	var item_v_cnt = 0;
	                	
	                	var contItems = "";
	                	
	                	<!-- 탭 만들기 -->
	                	index = index+1;
	                    var itemsHtml = tabList(index,list.TEXT1,"mNotice_tab2_");
	                	$(".mNotice .tab2 .cont_inner .pageTabBase .tabList").append(itemsHtml);
	                	<!-- //탭 만들기 -->
	                	
	                	<!-- contTab 만들기 -->
	                    if (index > 1){
	                        var clonedElement = $("#mNotice_tab2_1").clone();
	                        clonedElement.attr("id", "mNotice_tab2_" + index);
	                        $(".tab2 .contTab_Group").append(clonedElement);
	                    }
	                    <!-- //contTab 만들기 -->
	                    
	                    <!-- contTab 내용 넣기 -->
	                    //탭내용리스트 (공지사항일경우)
	                    $.each(data.bbsItemsC1406_2[list.ORD_NO-1].SUB_TOP, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab2(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
	                    	}
                     	});	
	                    
	                    //탭내용리스트 (공지사항이 아닐경우)
	                    $.each(data.bbsItemsC1406_2[list.ORD_NO-1].SUB, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab2(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
							}
						});
						$("#mNotice_tab2_"+index+" .swiper-wrapper").html(contItems);
						<!-- //contTab 내용 넣기 -->
						
	                	
	                });
					$("#mNotice_tab2_1").addClass("on");
				}
			}
			<!-- //입학Qna -->
			
			
			<!-- 학과소개 -->
			if(data.mainConfigC1434_1) {
				$(".mNotice .tab3 .tit_bx h3").html(data.mainConfigC1434_1.SUB_TITLE);
				$(".mNotice .tab3 .tit_bx p").html(data.mainConfigC1434_1.BG_TEXT);
				
				if(data.mainConfigSubC1434_1){
	                $.each(data.mainConfigSubC1434_1, function(index, list) {
	                	
	                	<!-- 탭 만들기 -->
	                	index = index+1;
	                    var itemsHtml = tabList(index,list.TEXT1,"mNotice_tab3_");
	                	$(".mNotice .tab3 .cont_inner .pageTabBase .tabList").append(itemsHtml);
	                	<!-- //탭 만들기 -->
						
	                	<!-- contTab 만들기 -->
	                    if (index > 1){
	                        var clonedElement = $("#mNotice_tab3_1").clone();
	                        clonedElement.attr("id", "mNotice_tab3_" + index);
	                        $(".tab3 .contTab_Group").append(clonedElement);
	                    }
	                    <!-- //contTab 만들기 -->
	                    
	                    <!-- 학부 백그라운드 이미지, 학부이름 넣기 -->
	                    var bgImg = '';
	                    bgImg += '<div class="bgImg">';
	                    bgImg += '<img src="/attach/' + list.PC_FILE_NM_SAVED + '" alt="' + list.SUB_TEXT + '">';
	                    bgImg += '</div>';
	                    $("#mNotice_tab3_"+index+ " .mDept").html(bgImg);
	                    
	                    var bgDeptNm = '';
	                    bgDeptNm += '<h4>' + list.TEXT1 + '</h4>';
	                    $("#mNotice_tab3_"+index+ " .mDept").append(bgDeptNm);
	                    <!-- //학부 백그라운드 이미지, 학부이름 넣기 -->
	                    
	                    <!-- 학과 버튼 넣기 -->
	                    var $element = $("#mNotice_tab3_"+index+ " .mDept");
	                    var $ul = $('<ul class="btnList"></ul>');
	                    $.each(data.deptItemsC1434_1, function(index, list0) {
	                    	if(list.SUB_SEQ == list0.SUB_SEQ){
								var $li = $('<li></li>');
								$li.append('<a href="#none" class="btn_dept lineWhite"><span>' + list0.TEXT + '</a></span>');
								$ul.append($li);
	                    	}
                     	});
						$element.append($ul);
						<!-- //학과 버튼 넣기 -->
	                    
	                });
					$("#mNotice_tab3_1").addClass("on");
				}
			}
			<!-- //학과소개 -->
			
			<!-- 자주묻는질문 -->
			if(data.mainConfigC1406_3) {
				$(".mNotice .tab4 .tit_bx h3").html(data.mainConfigC1406_3.SUB_TITLE);
				$(".mNotice .tab4 .tit_bx p").html(data.mainConfigC1406_3.BG_TEXT);
				
				<!-- VIEW MORE -->
				$(".mNotice .tab4 .cont_inner .left a").attr("target", data.mainConfigC1406_3.WINDOW_YN);
				<!-- //VIEW MORE -->
				
				if(data.mainConfigSubC1406_3){
	                $.each(data.mainConfigSubC1406_3, function(index, list) {
	                	var limit_cnt = 5;
	                	var item_v_cnt = 0;
	                	
	                	var contItems = "";
	                	
	                	<!-- 탭 만들기 -->
	                	index = index+1;
	                    var itemsHtml = tabList(index,list.TEXT1,"mNotice_tab4_");
	                	$(".mNotice .tab4 .pageTabBase .tabList").append(itemsHtml);
	                	<!-- //탭 만들기 -->
	                	
	                	<!-- contTab 만들기 -->
	                    if (index > 1){
	                        var clonedElement = $("#mNotice_tab4_1").clone();
	                        clonedElement.attr("id", "mNotice_tab4_" + index);
	                        $(".tab4 .contTab_Group").append(clonedElement);
	                    }
	                    <!-- //contTab 만들기 -->
	                    
	                    <!-- contTab 내용 넣기 -->
	                  	//탭내용리스트 (공지사항일경우)
	                    $.each(data.bbsItemsC1406_3[list.ORD_NO-1].SUB_TOP, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab3(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
	                    	}
                     	});	
	                    
	                    //탭내용리스트 (공지사항이 아닐경우)
	                    $.each(data.bbsItemsC1406_3[list.ORD_NO-1].SUB, function(index, list0) {
							if(item_v_cnt < limit_cnt){
								contItems =  contItemsTab3(list0,contItems);
		                    	item_v_cnt = item_v_cnt+1;
							}
						});
						$("#mNotice_tab4_"+index+" .listLink").html(contItems);
						<!-- //contTab 내용 넣기 -->
						
	                	
	                });
					$("#mNotice_tab4_1").addClass("on");
				}
			}
			<!-- //자주묻는질문 -->
			
			<!-- 홍보영상 -->
			if(data.mainConfigC1402_3) {
				$(".mNotice .tab5 .tit_bx h3").html(data.mainConfigC1402_3.SUB_TITLE);
				$(".mNotice .tab5 .tit_bx p").html(data.mainConfigC1402_3.BG_TEXT);
				
				<!-- VIEW MORE 링크 달기 -->
				$link = $('<a class="btn_arrow">View More</a>').attr('href', data.mainConfigC1402_3.LINK_URL).attr('target', data.mainConfigC1402_3.WINDOW_YN).attr('title', data.mainConfigC1402_3.WINDOW_YN == '_blank' ? '새창열림' : '');
				$(".mNotice .tab5 .admission_etc").html($link);
				<!-- //VIEW MORE 링크 달기 -->
				
				if(data.mainConfigSubC1402_3){
	                $.each(data.mainConfigSubC1402_3, function(index, list) {
	                    <!-- 내용 넣기 -->
	                    var videoItems = '';
	                    videoItems += '<div class="swiper-slide item">';
	                    videoItems += '<a href="' + list.LINK_URL + '" target="' + list.WINDOW_YN + '">';
	                    videoItems += '<div class="img_bx">';
	                    videoItems += '<img src="/attach/' + list.PC_FILE_NM_SAVED + '" alt="' + list.SUB_TEXT + '">';
	                    videoItems += '</div>';
	                    videoItems += '<h4>' + list.TEXT1 + '</h4>';
	                    videoItems += '</a>';
	                    videoItems += '</div>';
						$(".tab5 .cont_inner .mVideo .swiper-wrapper").append(videoItems);
						<!-- // 내용 넣기 -->
	                });
				}
			}
			<!-- //홍보영상 -->
		},
		function(error) {
			console.log("errrrrror");
		}
	);	
	
});

function addText(text1, text2, linkUrl, windowYn, $element) {
	if(text1 == null) text1 = "";
	if(text2 == null) text2 = "";
	
	if (linkUrl == null || linkUrl == '') { // 링크 URL이 없을 경우
		var $li = $('<li></li>');
		$li.append('<b>' + text1 + '</b><span>' + text2 + '</span>');
		$element.append($li);
	}else { // 링크 URL이 있을 경우
		var $li = $('<li></li>');
	    $link = $('<a></a>').attr('href', linkUrl).attr('target', windowYn).attr('title', windowYn == '_blank' ? '새창열림' : '');
	    $link.append('<b>' + text1 + '</b>');
	    $link.append('<span>' + text2 + '</span>');
	    $li.append($link);
	    $element.append($li);
	}
}

function tabList(index, text, classNm){
	var itemsHtml = "";
	
	itemsHtml += '<li role="presentation"';
    if (index == 1) {
        itemsHtml += ' class="on"';
    }
    itemsHtml += '><a href="#none" data-tabid="'+ classNm + index +'">'+text+'</a></li>';
    
    return itemsHtml;
}

function contItemsTab1(list0,itemListHtml){
	var linkUrl = '';
	
	if (list0.BOARD_TYPE === 'C0305') {
		linkUrl = list0.LINK_URL;
	} else {
		linkUrl = '${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=' + list0.TEMP_CODE + '...'; // 나머지 파라미터 생략
	}
	
	itemListHtml += '<tr>' 
		+ '  <td><a href="' + linkUrl + '" title="새창열림" target="_blank">' + list0.SUBJECT + '</a></td>' 
		+ '  <td class="date">' + list0.WRITE_DATE + '</td>' 
		+ '</tr>';
	return  itemListHtml;
}

function contItemsTab2(list0,itemListHtml){
	var linkUrl = '';
	
	if (list0.BOARD_TYPE === 'C0305') {
		linkUrl = list0.LINK_URL;
	} else {
		linkUrl = '${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=' + list0.TEMP_CODE + '...'; // 나머지 파라미터 생략
	}
	
	itemListHtml += '<div class="swiper-slide item admission_bx"><a href="' + linkUrl + '" title="새창열림" target="_blank"><h3>' + list0.SUBJECT + '</h3>' 
		+ '  <div class="bx_info"><ul><li>' + list0.WRITER_NM + '</li><li>' + list0.WRITE_DATE + '</li></ul><span class="case">답변대기</span>' 
		+ '</div></a></div>';
	return  itemListHtml;
}

function contItemsTab3(list0,itemListHtml){
	var linkUrl = '';
	
	if (list0.BOARD_TYPE === 'C0305') {
		linkUrl = list0.LINK_URL;
	} else {
		linkUrl = '${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=' + list0.TEMP_CODE + '...'; // 나머지 파라미터 생략
	}
	
	itemListHtml += '<li><a href="' + linkUrl + '" title="새창열림" target="_blank">' + list0.SUBJECT + '</a></li>' 
	return  itemListHtml;
}

</script>
<body class="typeIpsi typeMain">
	<jsp:include page="./IncTop.jsp"/>
	<jsp:include page="./IncTopSection.jsp"/>
	
	<div class="content">
	    <section class="mVisual">
	        <div class="mV_tit">
           		<h2></h2>
	        </div>
	        
	        <!-- mIcoBnr 시작 -->
	        <div class="mIcoBnr mIcoBnr7">
	        </div>
	        <!-- mIcoBnr 끝 -->
	
	        <!-- vBanner 시작 -->
	        <div class="vBanner">
               	<div class="bnrOverBx">                
	                <a class="bnr_bx bnr_bx1" href="#none">
	                    <div class="contBx">
	                        <span>01</span>
	                        <h3></h3>
	                        <ul class="link">
	                        </ul>
	                    </div>
	                </a>
	                <div class="overBx">
	                    <div class="mBtn">
	                        <button type="button" class="mBtn_close"><span class="scHdn">원서접수 닫기</span></button>
	                    </div>
	                    <h3></h3>
	                    <ul class="btnList">
	                    </ul>
	                </div>
	            </div>
	            
	            <div class="bnr_bx bnr_bx2">
	                <span></span>
	                <h3></h3>
	                <ul class="link link_arrow">
	                </ul>
	            </div>
	            
	            <div class="bnr_bx bnr_bx3">
	                <span></span>
	                <h3></h3>
	                <ul class="link link_arrow">
	                </ul>
	            </div>
			            
				<div class="bnr_bx bnr_bx4">
	                <span></span>
	                <h3></h3>
	                <ul class="link link_arrow">
	                </ul>
	            </div>
	        </div>
	        <!-- vBanner 끝 -->
	    </section>
	
	    <!-- mQuick 시작 -->
	    <div class="mQuick">
	        <div class="mTel_btn">
	            <div class="tel_txt">
	            </div>
	            <div class="tel_img">
	            </div>  
	        </div>
	        
	        <div class="quick_inner">
	            <div class="quickMobile">
	                <h3>Quick Menu</h3>
	
	                <div class="mBtn">
	                    <button type="button" class="mBtn_close"><span class="scHdn">메뉴 닫기</span></button>
	                </div>
	
	                <a class="tel_txt" href="#none"></a>
	            </div>
	            <ul></ul>			
	        </div>
	    </div>
	    <!-- mQuick 끝 -->

		<div class="mFix_call">
	    </div>
	
	    <div class="mNotice">
	        <!-- 공지사항 시작 -->
	        <section class="mNoticeCont tab tab1 tabGreen">
	            <div class="tit_bx">
	                <h3></h3>
	                <p></p>
	            </div>
	            <div class="cont_inner">
	                <div class="left">
	                    <a href="#none" onclick="fn_link_boardlist('tab1')" class="btn_arrow">View More</a>
	                </div>
	                <div class="right">
	                    <div class="pageTabBase" role="tabEl">
	                        <ul class="tabList" style="padding-left: 0px; padding-right: 0px;">
	                        </ul>
	                    </div>
	                    <div class="contTab_Group">
	                        <!-- 구분 -->
							<div id="mNotice_tab1_1" class="contTab">
	                            <div class="lineList_tb">
	                                <table>
	                                    <caption><p>공지사항</p></caption>
	                                    <colgroup>
	                                        <col>
	                                        <col style="width:100px">
	                                    </colgroup>
	                                    <tbody id="noticeTableId">
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
        	</section>     
	        <!-- 공지사항 끝 -->
	
	        <!-- 입학상담 시작 -->
	        <section class="mNoticeCont tab tab2 tabWhite">
	            <div class="tit_bx">
	                <h3></h3>
	                <p></p>
	            </div>
	            <div class="cont_inner cont_inner2">                
	                <div class="pageTabBase" role="tabEl">
	                    <ul class="tabList">
	                    </ul>
	                </div>
	    
	                <div class="contTab_Group">
	                    <div id="mNotice_tab2_1" class="contTab">
	                        <div class="sliderArea">
	                            <div class="swiper mNews">
	                                <div class="swiper-wrapper">
	                                </div>
	                            </div>
	
	                            <div class="admission_etc">
	                                <a href="#none" onclick="fn_link_boardlist('tab2')" class="btn_arrow">View More</a>
	
	                                <div class="swiper-pagination"></div>
	                                <div class="custom-pagination"></div>
	                            </div>
	                        </div>
	                    </div>
	
	                    
	                </div>
	            </div>
	        </section>
	        <!-- 입학상담 끝 -->
	
	        <!-- 학과소개 시작 -->
	        <section class="mNoticeCont tab tab3 tabWhite">
	            <div class="tit_bx">
	                <h3></h3>
	                <p></p>
	            </div>
	            <div class="cont_inner cont_inner2">
	                <div class="pageTabBase" role="tabEl" id="pageTab">
	                    <ul class="tabList">
	                    </ul>
	                </div>
	    
	                <div class="contTab_Group">
	                    
	                    <!-- 구분 -->
	                    <div id="mNotice_tab3_1" class="contTab">
	                        <div class="mDept">
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </section>
	        <!-- 학과소개 끝 -->
	        
	        <!-- 자주 묻는 질문 시작 -->
	        <section class="mNoticeCont tab tab4 tabWhite">
	            <div class="tit_bx">
	                <h3></h3>
	                <p></p>
	            </div>
	            <div class="cont_inner">
	                <div class="left">
	                    <a href="#none" onclick="fn_link_boardlist('tab4')" class="btn_arrow">View More</a>
	                </div>
	                <div class="right">
	                    <div class="pageTabBase" role="tabEl">
	                    	<ul class="tabList"></ul>
	                    </div>
	
	                    <div class="contTab_Group">
	                        <!-- 구분 -->
	                        <div id="mNotice_tab4_1" class="contTab">
	                        	<ul class="listLink"></ul>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </section>

	        <!-- 자주 묻는 질문 끝 -->
	    
	        <!-- 홍보영상 시작 -->
	        <section class="mNoticeCont tab tab5 tabGreen">
	            <div class="tit_bx">
	                <h3></h3>
	                <p></p>
	            </div>
	            <div class="cont_inner cont_inner2">
	                <div class="swiper mVideo">
	                    <div class="swiper-wrapper">
	                    </div>
	
	                    <div class="swiper-pagination"></div>
	                    <div class="custom-pagination"></div>
	                </div>
	
	                <div class="admission_etc">
<!--  	                    <a href="#none" class="btn_arrow">View More</a> -->
	                </div>          
	                
					<jsp:include page="./IncFooterM.jsp"/>
	            </div>
	
	        </section>

	        <c:forEach var="list" items="${footerLinkGroupInfo }" varStatus="status">
				<div class="pop_wrap" id="familySite${status.count}">
					<!-- popup layer(레이어) -->
					<section class="popLayout popLayer">
						<h1 class="popTit">${list.LINK_GROUP_NM }</h1>
				
						<div class="popConts">
						<!-- 팝업 내용 입력-->
							<div class="popInner limit">
								<div class="pop_familySite">
									<ul class="txtList dot">
									<c:forEach var="list2" items="${footerLinkInfo }" varStatus="status">
										<c:if test="${list.LINK_GROUP_CD eq list2.LINK_GROUP_CD }">
										<li><a href="${list2.URL }" title="<c:if test="${list2.SETVAL eq '_blank'}">새창열림</c:if>" target="${list2.SETVAL }">${list2.TEXT }</a></li>
										</c:if>
									</c:forEach>
									</ul>
								</div>
							</div>
							<!-- //팝업 내용 입력 -->
						</div>
				
						<button type="button" class="btn_popClose"><span class="scHdn">창닫기</span></button>
					</section>
					<!-- //popup layer(레이어) -->
				</div>
			</c:forEach>
	        <!-- 홍보영상 끝 -->
	    </div>
	
	</div>
	<a href="#none" id="btn_top" class="topBtn"><span class="hidden">상단바로가기</span></a>
	</div>
	<!-- //container -->
</body>
</html>