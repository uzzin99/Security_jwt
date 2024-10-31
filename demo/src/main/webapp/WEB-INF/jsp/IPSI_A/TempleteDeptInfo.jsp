<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<jsp:include page="./IncHeaderS.jsp"/>
<link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/IPSI_A/css/type2.css" /><!-- type2 -->

<body class="typeIpsi typeDept">
    <jsp:include page="./IncTop.jsp"/>
	<jsp:include page="./IncTopSection.jsp"/>
	<div class="content" id="contents">
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
		<jsp:include page="./Contents.jsp"/>
	</div>
	<jsp:include page="./IncFooterS.jsp"/>
</body>
</html>