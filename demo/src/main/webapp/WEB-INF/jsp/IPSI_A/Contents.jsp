<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%
String jspPath = (String) request.getAttribute("jspPath");
if(jspPath == null) response.sendError(HttpServletResponse.SC_NOT_FOUND);
else request.getRequestDispatcher(jspPath+".jsp").include(request, response);
%>