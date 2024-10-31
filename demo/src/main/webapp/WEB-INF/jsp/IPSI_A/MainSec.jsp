<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="./headerM.jsp"/>
<!-- <script src="/js/waypoints.min.js"></script> -->
<!-- <script src="/js/jquery.counterup.min.js"></script> -->
<script>
var gnbDep1 = 0;
var gnbDep2 = 0;
var gnbDep3 = 0;
</script>

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
</script>
</head>
<body class="typeIpsi typeMain">
	<jsp:include page="./IncTop.jsp"/>
	<jsp:include page="./IncTopSection.jsp"/>
	
	<div class="content">
	    <section class="mVisual">
	        <div class="mV_tit">
	            <c:if test="${not empty mainConfigC1430_1 }">
            		<h2>${mainConfigC1430_1.BG_TEXT}</h2>
            	</c:if>
	        </div>
	        
	        <!-- mIcoBnr 시작 -->
	        <div class="mIcoBnr mIcoBnr7"><!--  최대 8개까지 mIcoBnr2~mIcoBnr8 추가 -->
	            <!-- 구분 -->
	            <c:if test="${not empty mainConfigSubC1402_1 }">
					<c:forEach var="list" items="${mainConfigSubC1402_1}">
			            <div class="item">
			                <a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
			                    <span>${list.TEXT1}</span>
			                </a>
			            </div>
		            </c:forEach>
	            </c:if>
	        </div>
	        <!-- mIcoBnr 끝 -->
	
	        <!-- vBanner 시작 -->
	        <div class="vBanner">
           		<c:if test="${not empty mainConfigC1432_1}">
                    <c:if test="${not empty mainConfigSubC1432_1}">
                    <c:set var="list" value="${mainConfigSubC1432_1[0]}"/>
			            <div class="bnrOverBx">
			            	<a class="bnr_bx bnr_bx1" href="#none" onclick="return false;" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
			                    <div class="contBx">
			                        <span>01</span>
			                        <h3>${mainConfigC1432_1.SUB_TITLE}</h3>
				                        <ul class="link">
				                            <li><b>${list.TEXT1} </b><br><span>${list.TEXT2}</span></li>
				                            <li><b>${list.TEXT3} </b><br><span>${list.TEXT4}</span></li>
				                            <li><b>${list.TEXT5} </b><br><span>${list.TEXT6}</span></li>                    
				                        </ul>
			                    </div>
							</a>
			                <div class="overBx">
			                    <div class="mBtn">
			                        <button type="button" class="mBtn_close"><span class="scHdn">원서접수 닫기</span></button>
			                    </div>
			                    <h3>${mainConfigC1432_1.SUB_TITLE}</h3>
			                    <ul class="btnList">
			                        <li><a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>"><span>${list.BTN_TEXT1}</span></a></li>
			                        <li><a href="${list.LINK_URL2}" target="${list.WINDOW_YN2}" title="<c:if test="${list.WINDOW_YN2 eq '_blank'}">새창열림</c:if>"><span>${list.BTN_TEXT2}</span></a></li>
			                    </ul>
			                </div>
			            </div>
		            </c:if>
               	</c:if>
	            <c:if test="${not empty mainConfigC1433_1}">
	            	<c:if test="${not empty mainConfigSubC1433_1}">
	            	<c:set var="list" value="${mainConfigSubC1433_1[0]}"/>
			            <div class="bnr_bx bnr_bx2" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
			                <span>02</span>
			                <h3>${mainConfigC1433_1.SUB_TITLE }</h3>
			                <ul class="link link_arrow">
			                	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL eq null or list.LINK_URL eq ''}"><b>${list.TEXT1}</b><span>${list.TEXT2}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT1}</b>
					                    		<span>${list.TEXT2}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL2 eq null or list.LINK_URL2 eq ''}"><b>${list.TEXT3}</b><span>${list.TEXT4}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL2}" target="${list.WINDOW_YN2}" title="<c:if test="${list.WINDOW_YN2 eq '_blank'}">새창열림</c:if>">
				                    			<b>${list.TEXT3}</b>
				                    			<span>${list.TEXT4}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL3 eq null or list.LINK_URL3 eq ''}"><b>${list.TEXT5}</b><span>${list.TEXT6}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL3}" target="${list.WINDOW_YN3}" title="<c:if test="${list.WINDOW_YN3 eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT5}</b>
					                    		<span>${list.TEXT6}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>     
			                </ul>
			            </div>
		            </c:if>
	            </c:if>
	            <c:if test="${not empty mainConfigC1433_2}">
	            	<c:if test="${not empty mainConfigSubC1433_2}">
	            	<c:set var="list" value="${mainConfigSubC1433_2[0]}"/>
			            <div class="bnr_bx bnr_bx3" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
			                <span>03</span>
			                <h3>${mainConfigC1433_2.SUB_TITLE }</h3>
			                <ul class="link link_arrow">
			                    <li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL eq null or list.LINK_URL eq ''}"><b>${list.TEXT1}</b><span>${list.TEXT2}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT1}</b>
					                    		<span>${list.TEXT2}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL2 eq null or list.LINK_URL2 eq ''}"><b>${list.TEXT3}</b><span>${list.TEXT4}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL2}" target="${list.WINDOW_YN2}" title="<c:if test="${list.WINDOW_YN2 eq '_blank'}">새창열림</c:if>">
				                    			<b>${list.TEXT3}</b>
				                    			<span>${list.TEXT4}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL3 eq null or list.LINK_URL3 eq ''}"><b>${list.TEXT5}</b><span>${list.TEXT6}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL3}" target="${list.WINDOW_YN3}" title="<c:if test="${list.WINDOW_YN3 eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT5}</b>
					                    		<span>${list.TEXT6}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>   
			                </ul>
			            </div>
		            </c:if>
	            </c:if>
	            <c:if test="${not empty mainConfigC1433_3}">
	            	<c:if test="${not empty mainConfigSubC1433_3}">
	            	<c:set var="list" value="${mainConfigSubC1433_3[0]}"/>
			            <div class="bnr_bx bnr_bx4" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
			                <span>04</span>
			                <h3>${mainConfigC1433_3.SUB_TITLE }</h3>
			                <ul class="link link_arrow">
			                   	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL eq null or list.LINK_URL eq ''}"><b>${list.TEXT1}</b><span>${list.TEXT2}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT1}</b>
					                    		<span>${list.TEXT2}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL2 eq null or list.LINK_URL2 eq ''}"><b>${list.TEXT3}</b><span>${list.TEXT4}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL2}" target="${list.WINDOW_YN2}" title="<c:if test="${list.WINDOW_YN2 eq '_blank'}">새창열림</c:if>">
				                    			<b>${list.TEXT3}</b>
				                    			<span>${list.TEXT4}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li>
		                    	<li>
			                    	<c:choose>
				                    	<c:when test="${list.LINK_URL3 eq null or list.LINK_URL3 eq ''}"><b>${list.TEXT5}</b><span>${list.TEXT6}</span></c:when>
				                    	<c:otherwise>
				                    		<a href="${list.LINK_URL3}" target="${list.WINDOW_YN3}" title="<c:if test="${list.WINDOW_YN3 eq '_blank'}">새창열림</c:if>">
					                    		<b>${list.TEXT5}</b>
					                    		<span>${list.TEXT6}</span>
				                    		</a>
				                    	</c:otherwise>
			                    	</c:choose>
		                    	</li> 
			                </ul>
			            </div>
					</c:if>
				</c:if>
	        </div>
	        <!-- vBanner 끝 -->
	    </section>
	
	    <!-- mQuick 시작 -->
	    <div class="mQuick">
	        <div class="mTel_btn">
	        	<c:if test="${not empty mainConfigSubC1431_1 }">
	        		<c:set var="list" value="${mainConfigSubC1431_1[0]}"/>
		            <div class="tel_txt">
		                <p>${list.TEXT1}<br><b class="c_point">${list.TEXT2}</b></p>                        
		            </div>
		            <div class="tel_img">
			            <a href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>">
			                <img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ}" alt="${list.SUB_TEXT}">
			            </a>
		            </div>
	            </c:if>
	        </div>
	        
	        <div class="quick_inner">
	            <div class="quickMobile">
	                <h3>Quick Menu</h3>
	
	                <div class="mBtn">
	                    <button type="button" class="mBtn_close"><span class="scHdn">메뉴 닫기</span></button>
	                </div>
					<c:if test="${not empty mainConfigSubC1431_1[0] }">
		                <a class="tel_txt" href="${list.LINK_URL}" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>">
		                	<p>${mainConfigSubC1431_1[0].TEXT1}<br><b class="c_point">${mainConfigSubC1431_1[0].TEXT2}</b></p>
		                </a>
	                </c:if>
	            </div>
	            <c:if test="${not empty mainConfigSubC1402_2 }">
		            <ul>
		            	<c:forEach var="list" items="${mainConfigSubC1402_2 }">
		                <li>
		                    <a href="${list.LINK_URL }" target="${list.WINDOW_YN}" title="<c:if test="${list.WINDOW_YN eq '_blank'}">새창열림</c:if>" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ})">
		                        <span>${list.TEXT1 }</span>
		                    </a>
		                </li>
		                </c:forEach>
		            </ul>	
	            </c:if>		
	        </div>
	    </div>
	    <!-- mQuick 끝 -->

		<c:set var="list" value="${mainConfigSubC1435_1[0]}"/>
		<c:if test="${not empty list}">
	    <div class="mFix_call">
	        <a href="/cms/CMN_CON/MainLink.do?GBN=CM&TEMP_CODE=${list.TEMP_CODE}&BASE_SITE_NO=${list.SITE_NO}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SUB_SEQ=${list.SUB_SEQ}" target="_blank" class="mShingu">
	        	<span>${list.TEXT1 }</span>
			</a>
	    </div>
	    </c:if>
	
	    <div class="mNotice">
	        <!-- 공지사항 시작 -->
	        <section class="mNoticeCont tab tab1 tabGreen">
	        	<c:if test="${not empty mainConfigC1406_1}">
		            <div class="tit_bx">
		                <h3>${mainConfigC1406_1.SUB_TITLE}</h3>
		                <p>${mainConfigC1406_1.BG_TEXT}</p>
		            </div>
		            <div class="cont_inner">
		                <div class="left">
		                    <a href="${mainConfigC1406_1.LINK_URL }" target="${mainConfigC1406_1.WINDOW_YN}" title="<c:if test="${mainConfigC1406_1.WINDOW_YN eq '_blank'}">새창열림</c:if>" class="btn_arrow">View More</a>
		                </div>
		                <div class="right">
	                    	<c:if test="${not empty mainConfigSubC1406_1}">
			                    <div class="pageTabBase" role="tabEl">
			                        <ul class="tabList">
			                        	<c:forEach var="list" items="${mainConfigSubC1406_1}" varStatus="status">
				                            <li <c:if test="${status.first }"> class="on"</c:if>><a href="#none" data-tabID="mNotice_tab1_${status.count}" onclick="return false;">${list.TEXT1}</a></li>
			                            </c:forEach>
			                        </ul>
			                    </div>
			                    <div class="contTab_Group">
			                        <!-- 구분 -->
			                        <c:forEach var="list" items="${mainConfigSubC1406_1}" varStatus="status">
				                        <div id="mNotice_tab1_${status.count}" class="contTab <c:if test="${status.first }"> on</c:if>">
				                            <div class="lineList_tb">
				                            	<c:choose>
					                            	<c:when test="${fn:length(bbsItemsC1406_1[list.ORD_NO-1].SUB)>0}">
						                                <table>
						                                    <caption><p>공지사항</p></caption>
						                                    <colgroup>
						                                        <!-- col태그 단위는 %, px 혼용 사용 / subject와 date는 고정값 -->
						                                        <col/>
						                                        <col style="width:100px">
						                                    </colgroup>
						                                    <tbody>
																<c:forEach var="list0" items="${bbsItemsC1406_1[list.ORD_NO-1].SUB}" varStatus="status0">
																<tr>
																	<c:choose>
																		<c:when test="${list0.BOARD_TYPE eq 'C0305'}">
																			<td><a href="${list0.LINK_URL}" title="새창열림" target="_blank">${list0.SUBJECT}</a></td>
																		</c:when>
																		<c:otherwise>
																			<td><a href="${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=${list0.TEMP_CODE}&BASE_SITE_NO=${list0.BASE_SITE_NO}&CONFIG_CD=${list0.CONFIG_CD}&CONFIG_SEQ=${list0.CONFIG_SEQ}&SUB_SEQ=${list0.SUB_SEQ}&SITE_NO=${list0.SITE_NO}&BOARD_SEQ=${list0.BOARD_SEQ}&BBS_SEQ=${list0.BBS_SEQ}" title="상세 이동">${list0.SUBJECT}</a></td>
																		</c:otherwise>
																	</c:choose>
																	<td class="date">${list0.WRITE_DATE}</td>
																</tr>
																</c:forEach>
						                                    </tbody>
						                                </table>
						                            </c:when>
						                            <c:otherwise>
							                            <div class="no_articleArea lineList_tb">
							                                <p class="no_article">등록된 게시물이 없습니다.</p>
							                            </div>
													</c:otherwise>
				                                </c:choose>
											</div>
				                        </div>
			                        </c:forEach>
			                    </div>
		                    </c:if>
		                </div>
		            </div>
	            </c:if>
	        </section>      
	        <!-- 공지사항 끝 -->
	
	        <!-- 입학상담 시작 -->
	        <section class="mNoticeCont tab tab2 tabWhite">
	        	<c:if test="${not empty mainConfigC1406_2}">
		            <div class="tit_bx">
		            	<h3>${mainConfigC1406_2.SUB_TITLE}</h3>
		                <p>${mainConfigC1406_2.BG_TEXT}</p>
		            </div>
		            <div class="cont_inner cont_inner2">
		            	<c:if test="${not empty mainConfigSubC1406_2}">                
			                <div class="pageTabBase" role="tabEl">
			                    <ul class="tabList">
			                    	<c:forEach var="list" items="${mainConfigSubC1406_2}" varStatus="status">
			                            <li <c:if test="${status.first }"> class="on"</c:if>><a href="#none" data-tabID="mNotice_tab2_${status.count}" onclick="return false;">${list.TEXT1}</a></li>
		                            </c:forEach>
			                    </ul>
			                </div>
			                <div class="contTab_Group">
			                	<c:forEach var="list" items="${mainConfigSubC1406_2}" varStatus="status">
			                		<div id="mNotice_tab2_${status.count}" class="contTab <c:if test="${status.first }"> on</c:if>">
				                        <div class="sliderArea">
				                            <div class="swiper mNews">
				                                <div class="swiper-wrapper">
				                                    <!-- 구분 -->
				                                    <c:choose>
				                                    	<c:when test="${fn:length(bbsItemsC1406_2[list.ORD_NO-1].SUB)>0}">
					                                    	<c:forEach var="list0" items="${bbsItemsC1406_2[list.ORD_NO-1].SUB}" varStatus="status0">
							                                    <div class="swiper-slide item admission_bx">
							                                        <a href="${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=${list0.TEMP_CODE}&BASE_SITE_NO=${list0.BASE_SITE_NO}&CONFIG_CD=${list0.CONFIG_CD}&CONFIG_SEQ=${list0.CONFIG_SEQ}&SUB_SEQ=${list0.SUB_SEQ}&SITE_NO=${list0.SITE_NO}&BOARD_SEQ=${list0.BOARD_SEQ}&BBS_SEQ=${list0.BBS_SEQ}" title="상세 이동">
							                                            <h3>${list0.SUBJECT}</h3>
							                                            <div class="bx_info">
							                                                <ul>
							                                                    <li>${list0.WRITER_NM}</li>
							                                                    <li>${list0.WRITE_DATE}</li>
							                                                </ul>
							                                                <c:choose>
							                                                	<c:when test="${list0.REPLY_CNT == 0}">
							                                                		<span class="case">답변대기</span>
							                                                	</c:when>
							                                                	<c:otherwise>
							                                                		<span class="case complete">답변완료</span>
																				</c:otherwise>
							                                                </c:choose>
							                                            </div>
							                                        </a>
							                                    </div>
						                                    </c:forEach>
					                                    </c:when>
				                                    </c:choose>
				                                </div>
				                            </div>
				                            <div class="admission_etc">
				                                <a href="${mainConfigC1406_2.LINK_URL }" target="${mainConfigC1406_2.WINDOW_YN}" title="<c:if test="${mainConfigC1406_2.WINDOW_YN eq '_blank'}">새창열림</c:if>" class="btn_arrow">View More</a>
				
				                                <div class="swiper-pagination"></div>
				                                <div class="custom-pagination"></div>
				                            </div>
				                        </div>
				                    </div>
			                    </c:forEach>
			                </div>
		                </c:if>
		            </div>
	            </c:if>
	        </section>
	        <!-- 입학상담 끝 -->
	
	        <!-- 학과소개 시작 -->
	        <section class="mNoticeCont tab tab3 tabWhite">
	        	<c:if test="${not empty mainConfigC1434_1}">
	            <div class="tit_bx">
	                <h3>${mainConfigC1434_1.SUB_TITLE}</h3>
	                <p>${mainConfigC1434_1.BG_TEXT}</p>
	            </div>
	            <div class="cont_inner cont_inner2">
	            	<c:if test="${not empty mainConfigSubC1434_1}">    
	                <div class="pageTabBase" role="tabEl" id="pageTab">
	                    <ul class="tabList">
	                    	<c:forEach var="list" items="${mainConfigSubC1434_1}" varStatus="status">
	                    		<li class="item <c:if test="${status.first }">on</c:if>"><a href="#none" data-tabid="mNotice_tab3_${status.count}" onclick="return false;">${list.TEXT1}</a></li>
	                        </c:forEach>
	                    </ul>
	                </div>
	                </c:if>
	    
	                <div class="contTab_Group">
                    	<!-- 구분 -->
                        <c:forEach var="list" items="${mainConfigSubC1434_1}" varStatus="status">
                        	<div id="mNotice_tab3_${status.count}" class="contTab<c:if test="${status.first }"> on</c:if>">
                             <div class="mDept">
                                 <div class="bgImg">
                                 	<img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ}" alt="${list.SUB_TEXT}">
                                 </div>
                                 <h4>${list.TEXT1}</h4>
                                 <ul class="btnList">
                                 	<c:forEach var="list0" items="${deptItemsC1434_1}" varStatus="status">
                                 		<c:if test="${list.SUB_SEQ eq list0.SUB_SEQ}">   
                                      	<li><a href="${list0.LINK_URL }" target="${list0.WINDOW_YN}" title="<c:if test="${list0.WINDOW_YN eq '_blank'}">새창열림</c:if>" class="btn_dept lineWhite"><span>${list0.TEXT}</span></a></li>
                                     	</c:if>
                                     </c:forEach>
                                 </ul>
                             </div>
                         </div>
                        </c:forEach>
                    </div>
	            </div>
	            </c:if>
	        </section>
	        <!-- 학과소개 끝 -->
	        
	        <!-- 자주 묻는 질문 시작 -->
	        <section class="mNoticeCont tab tab4 tabWhite">
	        	<c:if test="${not empty mainConfigC1406_3}">
		            <div class="tit_bx">
		            	<h3>${mainConfigC1406_3.SUB_TITLE}</h3>
		                <p>${mainConfigC1406_3.BG_TEXT}</p>
		            </div>
		            <div class="cont_inner">
		                <div class="left">
		                    <a href="${mainConfigC1406_3.LINK_URL }" target="${mainConfigC1406_3.WINDOW_YN}" title="<c:if test="${mainConfigC1406_3.WINDOW_YN eq '_blank'}">새창열림</c:if>" class="btn_arrow">View More</a>
		                </div>
		                <div class="right">
			                <c:if test="${not empty mainConfigSubC1406_3}">
			                    <div class="pageTabBase" role="tabEl">
			                        <ul class="tabList">
			                        	<c:forEach var="list" items="${mainConfigSubC1406_3}" varStatus="status">
			                        		<li <c:if test="${status.first }"> class="on"</c:if>><a href="#none" data-tabID="mNotice_tab4_${status.count}" onclick="return false;">${list.TEXT1}</a></li>
			                        	</c:forEach>
			                        </ul>
			                    </div>
			
			                    <div class="contTab_Group">
			                        <!-- 구분 -->
			                        <c:forEach var="list" items="${mainConfigSubC1406_3}" varStatus="status">
				                        <div id="mNotice_tab4_${status.count}" class="contTab <c:if test="${status.first }"> on</c:if>">
				                        	<c:choose>
				                        		<c:when test="${fn:length(bbsItemsC1406_3[list.ORD_NO-1].SUB)>0}">
						                            <ul class="listLink">
						                            	<c:forEach var="list0" items="${bbsItemsC1406_3[list.ORD_NO-1].SUB}" varStatus="status0">
						                            		<c:choose>
						                            		<c:when test="${list0.BOARD_TYPE eq 'C0305'}">
						                            			<li><a href="${list0.LINK_URL}" title="새창열림" target="_blank">${list0.SUBJECT}</a></li>
						                            		</c:when>
						                            		<c:otherwise>
						                            			<li><a href="${BASE_PATH}/cms/CMN_CON/MainLink.do?GBN=BA&TEMP_CODE=${list0.TEMP_CODE}&BASE_SITE_NO=${list0.BASE_SITE_NO}&CONFIG_CD=${list0.CONFIG_CD}&CONFIG_SEQ=${list0.CONFIG_SEQ}&SUB_SEQ=${list0.SUB_SEQ}&SITE_NO=${list0.SITE_NO}&BOARD_SEQ=${list0.BOARD_SEQ}&BBS_SEQ=${list0.BBS_SEQ}" title="상세 이동">${list0.SUBJECT}</a></li>
						                            		</c:otherwise>
						                            		</c:choose>
						                            	</c:forEach>
						                            </ul>
				                        		</c:when>
				                        		<c:otherwise>
						                        	<div class="no_articleArea">
						                                <p class="no_article">조회된 자료가 없습니다.</p>
						                            </div>
					                       		</c:otherwise>
				                        	</c:choose>
				                        </div>
			                        </c:forEach>
			                    </div>
		                    </c:if>
		                </div>
		            </div>
	            </c:if>
	        </section>
	        <!-- 자주 묻는 질문 끝 -->
	    
	        <!-- 홍보영상 시작 -->
	        <section class="mNoticeCont tab tab5 tabGreen">
	        	<c:if test="${not empty mainConfigC1402_3}">
	            <div class="tit_bx">
	            	<h3>${mainConfigC1402_3.SUB_TITLE}</h3>
		            <p>${mainConfigC1402_3.BG_TEXT}</p>
	            </div>
	            <div class="cont_inner cont_inner2">
	            	<c:if test="${not empty mainConfigC1402_3}">
	                <div class="swiper mVideo">
	                    <div class="swiper-wrapper">
	                    	<c:forEach var="list" items="${mainConfigSubC1402_3}" varStatus="status">
	                        <!-- 구분 -->
	                        <div class="swiper-slide item">
	                        	<a href="${list.LINK_URL }" target="${list.WINDOW_YN}" title="<c:if test="${mainConfigC1406_2.list eq '_blank'}">새창열림</c:if>">
	                                <div class="img_bx">
	                                	<img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X04&TEMP_CODE=${list.TEMP_CODE}&CONFIG_CD=${list.CONFIG_CD}&CONFIG_SEQ=${list.CONFIG_SEQ}&SITE_NO=${list.SITE_NO}&SUB_SEQ=${list.SUB_SEQ}" alt="${list.SUB_TEXT}">
	                                </div>
	                                <h4>${list.TEXT1 }</h4>
	                            </a>
	                        </div>
	                        </c:forEach>
	                    </div>
	
	                    <div class="swiper-pagination"></div>
	                    <div class="custom-pagination"></div>
	                </div>
	                </c:if>
	
	                <div class="admission_etc">
	                	<a href="${mainConfigC1402_3.LINK_URL }" target="${mainConfigC1402_3.WINDOW_YN}" title="<c:if test="${mainConfigC1402_3.WINDOW_YN eq '_blank'}">새창열림</c:if>" class="btn_arrow">View More</a>
	                </div>          
	                
	                
	                <jsp:include page="./footerM.jsp"/>
	            </div>
				</c:if>
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
</body>
</html>