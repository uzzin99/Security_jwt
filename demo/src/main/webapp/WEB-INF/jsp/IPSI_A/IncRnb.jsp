<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$().ready(function() {
	$("#rnb > li").each(function(){
		if($(this).hasClass("child")) $(this).find(">a").attr("href","#;");
	});
});
</script>
<div class="side_conts">
	<h2 class="gnbTit"></h2>
    <nav id="rnb_nav"></nav>
    
    <c:if test="${not empty rnbInfo }">
    	<c:out value="${rnbInfo.CONTENTS }" escapeXml="false"/>
    </c:if>
</div>
    