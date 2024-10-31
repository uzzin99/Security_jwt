<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

$(function(){
    var clipboard = new ClipboardJS('.urlCopy>.urlCopyBtn', {
	    text: function() {
		  	return fn_getUrl();
	    }
	});
	clipboard.on('success', function(e) {
		alert("URL이 복사되었습니다.");
	});
	clipboard.on('error', function(e) {
		alert("URL복사에 실패했습니다.");
	}); 
	
	$("#copyUrl").val(fn_getUrl());
	
	$(document).on("click", ".btn_print", function(){
		window.print();
	});
});


function fn_getUrl(){
	var rtnUrl = ""; 
	var url = decodeURIComponent(location.href);
	url = decodeURIComponent(url).replace("#none;","");
	url = decodeURIComponent(url).replace("#none","");
  	url = decodeURIComponent(url).replace("#","");
  	url = decodeURIComponent(url).replace(";","");
	rtnUrl = url.replace("#;","");
	return rtnUrl;
  }
  

function shareSns(sns){
	var snsTitle = '';
	var snsItems = new Array();
	var winOpt = new Array();	
	var snsUrl = fn_getUrl();
	
	snsItems['facebook'] = "http://www.facebook.com/share.php?t="+encodeURIComponent(snsTitle) + "&u=" + encodeURIComponent(snsUrl);
	snsItems['twitter'] = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(snsTitle + "\n" + snsUrl);
	snsItems['kakao'] = "https://story.kakao.com/share?url="+encodeURIComponent(snsUrl);
	snsItems['blog'] = "https://blog.naver.com/openapi/share?url="+encodeURIComponent(snsUrl)+"&title="+encodeURIComponent(snsTitle);
	snsItems['band'] = "https://band.us/plugin/share?body="+encodeURIComponent(snsTitle)+"&route=" + encodeURIComponent(snsUrl);
	snsItems['tumblr'] = "https://www.tumblr.com/share/link?url=" + encodeURIComponent(snsUrl);
	snsItems['pinterest'] = "https://www.pinterest.com/pin/create/button/?url="+encodeURIComponent(snsUrl)+"&description="+encodeURIComponent(snsTitle);
	
	winOpt['facebook'] = "width=700, height=500, resizable=yes";
	winOpt['twitter'] = "width=700, height=500, resizable=yes";
	winOpt['kakao'] = "width=500, height=500, resizable=yes";
	winOpt['blog'] = "width=500, height=500, resizeable=yes";
	winOpt['band'] = "width=550, height=700, resizeable=yes";
	winOpt['tumblr'] = "width=600, height=600, resizeable=yes";
	winOpt['pinterest'] = "width=800, height=500, resizeable=yes";
	
	var win = window.open(snsItems[sns], sns, winOpt[sns]);
	if (win) {
       win.focus();
   }
}
	
</script>
<style>
#snb_nav>div.snb_area>button {
	display: none;
}
#snb_nav.depth1 .dep1, #snb_nav.depth2 .dep2, #snb_nav.depth3 .dep3, #snb_nav.depth4 .dep4 {
    display: inline-block;
}
</style>
<div class="sVisualArea">
	<div class="sVisual">
		<!-- 서브비주얼 -->
		<div class="sVisualImage" style="background-image:url(/ajaxfile/CMN_SVC/FileView.do?GBN=X03&SITE_NO=${SITE_NO}&MENU_NO=${snbMenuMap.snbMenu_1_No})"></div>
		<!-- 1뎁스 타이틀 -->
		<h2>${snbMenuMap.snbMenu_1_Nm}</h2>
	</div>
</div>

<div class="snbArea">
	<div class="snbInnerArea">
		<nav id="snb_nav">
			<div class="snb_area">
				<a href="/index.do" class="btn_home"><span class="hidden">HOME</span></a>
				<c:if test="${not empty snbMenuMap.snbMenu_1_No}">
					<ul id="snb">
						<c:forEach var="MENU_1" items="${menuMap.SUB }" >
							<li class="<c:if test="${not empty MENU_1.SUB }">child</c:if>" data-menuno="${MENU_1.MENU_NO}" data-sub="${MENU_1.LINK_SUB_YN}"><a href="${MENU_1.REAL_URL }" title="<c:if test="${MENU_1.SETVAL eq '_blank'}">새창열림</c:if>" target="${MENU_1.SETVAL }">${MENU_1.MENU_NM }</a>
								<c:if test="${not empty snbMenuMap.snbMenu_2_No}">
									<ul class="menuM" data-tit="${MENU_1.MENU_NM }">
										<c:forEach var="MENU_1" items="${menuMap.SUB }" >
											<c:forEach var="MENU_2" items="${MENU_1.SUB }" >
												<c:if test="${snbMenuMap.snbMenu_1_No eq MENU_2.P_MENU_NO}">
													<li class="<c:if test="${not empty MENU_2.SUB }">child</c:if>" data-menuno="${MENU_2.MENU_NO}" data-sub="${MENU_2.LINK_SUB_YN}"><a href="${MENU_2.REAL_URL }" title="<c:if test="${MENU_2.SETVAL eq '_blank'}">새창열림</c:if>" target="${MENU_2.SETVAL }">${MENU_2.MENU_NM }</a>
														<c:if test="${not empty snbMenuMap.snbMenu_3_No}">
															<ul class="menuS">
																<c:forEach var="MENU_1" items="${menuMap.SUB }" >
																	<c:forEach var="MENU_2" items="${MENU_1.SUB }" >
																		<c:forEach var="MENU_3" items="${MENU_2.SUB }" >
																			<c:if test="${snbMenuMap.snbMenu_2_No eq MENU_3.P_MENU_NO}">
																			<li data-menuno="${MENU_3.MENU_NO}" data-sub="${MENU_3.LINK_SUB_YN}"><a href="${MENU_3.REAL_URL }" title="<c:if test="${MENU_3.SETVAL eq '_blank'}">새창열림</c:if>" target="${MENU_3.SETVAL }">${MENU_3.MENU_NM }</a></li>
																			</c:if>
																		</c:forEach>
																	</c:forEach>
																</c:forEach>
															</ul>
														</c:if>
													</li>
												</c:if>
											</c:forEach>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</nav>

		<div class="pageUtil">
			<a href="#none" class="btn_print"><span>프린트</span></a>
			<a href="#none" class="btn_share" data-id="btn_share"><span>공유하기</span></a>

			<div class="shareArea">
				<div class="shareInnerBox">
					<b>공유하기</b>
					<ul class="snsList">
						<li>
							<a href="javascript:shareSns('facebook');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsFacebook.png" alt="">
								<span>페이스북</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('twitter');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsX.png" alt="">
								<span>엑스</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('kakao');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsKakaoStory.png" alt="">
								<span>카카오스토리</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('band');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsNaverBand.png" alt="">
								<span>네이버밴드</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('blog');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsNaverBlog.png" alt="">
								<span>네이버블로그</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('tumblr');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsTumbler.png" alt="">
								<span>텀블러</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareSns('pinterest');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsPinterest.png" alt="">
								<span>핀터레스트</span>
							</a>
						</li>
						<!-- <li>
							<a href="javascript:shareSns('facebook');">
								<img src="/sgu_ipsi/type/common/img/common/icon_snsGooglePlus.png" alt="">
								<span>구글+</span>
							</a>
						</li> -->
					</ul>
					<div class="urlCopy">
						<input type="text" id="copyUrl" class="inputBase" title="현재 url 정보">
						<button type="button" class="urlCopyBtn">URL 복사</button>
					</div>

					<button type="button" class="shareClosed"><span class="hidden">닫기</span></button>
				</div>
			</div>
		</div>
	</div>
</div>



