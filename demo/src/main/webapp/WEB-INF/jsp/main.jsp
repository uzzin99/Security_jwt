<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
	    url: "http://127.0.0.1:8080/api/info",
	    type: "GET",
	    dataType: "json",
	    success: function(data) {
	        $.each(data, function(index, user) {
	        	console.log(user);
	            $('#userList').append('<li>' + user.user_ID + '</li>');
	        });
	    }
	});
//     const accessToken = localStorage.getItem("accessToken");
//     if (accessToken) {
//         // 토큰을 이용한 요청 예시
//         $.ajax({
//             type: "GET",
//             url: "/protectedResource",
//             headers: {
//                 "Authorization": "Bearer " + accessToken
//             },
//             success: (data) => {
//                 // 보호된 자원에 대한 응답 처리
//             }
//         });
//     } else {
//         alert("로그인이 필요합니다.");
//         // 로그인 페이지로 이동하거나 다른 처리
//     }
});
</script>
</head>
<body>
<h1 style="text-align:center">hello Main Page</h1>
<ul id="userList">
</ul>
</body>
</html>