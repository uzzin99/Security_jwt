<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<a href="#none" id="btn_top" class="topBtn"><span class="hidden">상단바로가기</span></a>
</div>
<!-- //container -->
<hr />

<!-- footer -->
<div id="footer">
	<footer>
		<div class="f_info">
			<ul class="fLink">
				<c:forEach var="list" items="${footerSiteInfo }" varStatus="status">
					<li>
						<a href="${list.URL }" target="${list.SETVAL }" title="<c:if test="${list.SETVAL eq '_blank'}">새창열림</c:if>">${list.TEXT }</a>
					</li>
				</c:forEach>			
			</ul>

			<address>
				${footerInfo.CONTENTS }
			</address>
			
			<div class="inpBox">
				<div class="fVR">
					<a href="https://vrcampus.shingu.ac.kr/" target="_blank" title="새창열림"><img src="/sgu_ipsi/type/IPSI_A/img/layout/img_footerVR.svg" alt="신구대학교 VR캠퍼스 체험"></a>
				</div>
				
				<div class="fSelect">
					<c:forEach var="list" items="${footerLinkGroupInfo }" varStatus="status">
							<c:if test="${not empty list.LINK_GROUP_NM }">
								<a href="#none" id="familySite${status.count}_Btn" class="inp_f sguIpsi_Site01">${list.LINK_GROUP_NM }</a>
							</c:if>
					</c:forEach>
					<script>
						$("#familySite1_Btn").on("click", function(e){
							ui.LayerPop.Show("#familySite1", "640");
						});
						$("#familySite2_Btn").on("click", function(e){
							ui.LayerPop.Show("#familySite2", "960");
						});
					</script>
				</div>
			</div>
		</div>
		
		<div class="f_etc">
			<p class="copyright">ⓒ 2024 SHINGU COLLEGE. ALL RIGHTS RESERVED.</p>

			<ul class="f_sns">
				<c:if test="${not empty footerSnsSiteInfo}">
					<c:forEach var="list" items="${footerSnsSiteInfo }" varStatus="status">
						<li>
							<a href="${list.URL }" target="${list.SETVAL }" class="${status.index==0?'f':'b'}" title="<c:if test="${list.SETVAL eq '_blank'}">새창열림</c:if>">
								<img src="/attach/${list.PC_FILE_NM_SAVED}" alt="${list.REP_TEXT}">
							</a>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>		
	</footer>
</div>
<!-- //footer -->

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


