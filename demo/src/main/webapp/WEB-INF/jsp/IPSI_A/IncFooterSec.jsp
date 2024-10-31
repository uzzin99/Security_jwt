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
						<li><a href="${list.URL }" target="${list.SETVAL }" class="${status.index==0?'f':'b'}" title="<c:if test="${list.SETVAL eq '_blank'}">새창열림</c:if>"><img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X08_1&BASIC_SEQ=${list.BASIC_SEQ }&INFO_SEQ=${list.INFO_SEQ }" alt="${list.REP_TEXT }"/></a></li>
					</c:forEach>
				</c:if>
			</ul>
		</div>		
	</footer>
</div>
<!-- //footer -->


