<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<jsp:include page="./IncHeaderS.jsp"/>

<body class="typeIpsi typeSub">
    <jsp:include page="./IncTop.jsp"/>
	<jsp:include page="./IncTopSection.jsp"/>
		<div class="content" id="contents">
		<jsp:include page="./IncSnb.jsp"/>
			<script>
			var gnbDep1 = 0;
			var gnbDep2 = 0;
			var gnbDep3 = 0;
			<c:if test="${not empty snbMenuMap.snbMenu_1_Lvl }">
				gnbDep1 = ${snbMenuMap.snbMenu_1_Lvl};
			</c:if>
			<c:if test="${not empty snbMenuMap.snbMenu_2_Lvl }">
				gnbDep2 = ${snbMenuMap.snbMenu_2_Lvl};
			</c:if>
			<c:if test="${not empty snbMenuMap.snbMenu_3_Lvl }">
				gnbDep3 = ${snbMenuMap.snbMenu_3_Lvl};
			</c:if>
			</script>
			<h2 class="tit_h1">${MENU_NM}</h2>
			<c:if test="${TAB_YN eq 'Y' }">
				<div id="pageTab" class="pageTabBase">
					<ul class="tabList tab<c:out value="${fn:length(tabList)}" />">
						<c:forEach var="list" items="${tabList }" >
							<li <c:if test="${CONTENTS_NO eq list.CONTENTS_NO }"> title="선택됨" class="on"</c:if>>
								<c:if test="${list.CONT_TYPE ne 'C0203' && list.CONT_TYPE ne 'C0204' && list.CONT_TYPE ne 'C0205' }">
									<a href="/cms/FR_CON/index.do?MENU_ID=${param.MENU_ID}&CONTENTS_NO=${list.CONTENTS_NO }">${list.CONTENTS_TITLE }</a>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
			<article>
	            <jsp:include page="./Contents.jsp"/>
			</article>
		</div>
		<jsp:include page="./IncFooterS.jsp"/>
</body>
</html>