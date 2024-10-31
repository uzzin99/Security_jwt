<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(e){
});
function goSubmit() {
	var username  = $("[name=username]").val() ;
	var password  = $("[name=password]").val() ;
	
    $.ajax({
        type: "POST",
//         headers: {'Authorization': 'Bearer ${token}'},
        url: "/api/login.do",
        data: {username:username, password:password},
        async: false,
        dataType   : 'json',
        success: (response,data) => {
        	console.log(data);
            if(response) {
            	if (response.accessToken) {
                    // 로컬 스토리지에 Access Token 저장
            		localStorage.setItem("accessToken", response.accessToken);
            		localStorage.setItem("refreshToken", response.refreshToken);
                    // 로그인 성공 후 리다이렉션
                    window.location.href = "/main"; // 메인 페이지로 이동
                } else {
                    alert('Authorization token not found');
                }
            }else {
                alert("실패");
            }
        },
        error: (request, status, error) => {
            if(request.status == 403) {
                alert("접근 권한이 없습니다.");
                location.replace("/main");
            }else {
                alert("요청 실패");
                console.log(request.status);
                console.log(request.responseText);
                console.log(error);

            }
        }
    });
}
</script>
</head>
<body>
<P>아이디  <input type="text" class="inputBase" title="아이디를 입력해주세요" name="username" ></P>
<P>비밀번호  <input type="password" class="inputBase" title="비밀번호를 입력해주세요" name="password" ></P>
<button type="button" class="baseBtn" onclick="goSubmit();"><span class="base">로그인</span></button>
</body>
</html>