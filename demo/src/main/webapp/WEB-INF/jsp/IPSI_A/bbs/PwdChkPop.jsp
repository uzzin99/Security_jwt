<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="format-detection" content="telephone=no"><!-- 사파리 전화번호 인식 차단 -->

	<title>[팝업] 신구대학교</title>

	<link rel="shortcut icon" href="/sgu_ipsi/type/common/img/ico_favicon.ico" />
    <link rel="icon" type="image/png" href="/sgu_ipsi/type/common/img/ico_favicon.png" sizes="192x192" />
    
    <link rel="stylesheet" href="/sgu_ipsi/type/common/css/common.css"><!-- reset --><!-- reset -->
    
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/css/board.css" /><!-- board -->
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/css/kor.css" /><!-- 신구대 KOR.css -->
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/css/ipsi.css" /><!-- ipsi css -->
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/css/contentsA.css" /><!-- 개별 content css -->

    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/IPSI_A/css/layout.css" /><!-- layout -->

	<script type="text/javascript" src="/sgu_ipsi/type/common/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="/sgu_ipsi/type/common/js/jquery.easing.1.3.js"></script>

    <!-- swiper -->
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/js/swiper/swiper.css"/>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script type="text/javascript" src="/sgu_ipsi/type/common/js/swiper/swiper.js"></script>

    <!-- aos  -->
    <link rel="stylesheet" href="/sgu_ipsi/type/common/css/aos.css"/>
    <script src="/sgu_ipsi/type/common/js/aos.js"></script>
    
    <!-- Gsap -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.6.0/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.6.0/ScrollTrigger.min.js"></script>    

    <!-- scrollbar -->
    <link rel="stylesheet" type="text/css" href="/sgu_ipsi/type/common/js/mCustomScrollbar/jquery.mCustomScrollbar.css"/>
    <script type="text/javascript" src="/sgu_ipsi/type/common/js/mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
    

    <script type="text/javascript" src="/sgu_ipsi/type/common/js/layout.js"></script><!-- 공통_layout -->
    <script type="text/javascript" src="/sgu_ipsi/type/common/js/board.js"></script><!-- board -->
    
	<script src="/js/comm_fr.js"></script>
	<script src="/js/util.js"></script>
	<script src="/js/jquery.tmpl.js"></script>
	
</head>
<script>
$().ready(function(){
	/* 190313 추가 */
	$("#pop_pwCheck .popConts .popInner fieldset").find('input').first().focus();

	$(".pop_wrap .popLayout .btn_popClose").keydown(function(e){
		var v_keyCode = event.keyCode || event.which;
		if(v_keyCode == 9){
			if(event.shiftKey){
				$('#pop_pwCheck .black').first().focus();
			} else {
				$("#pop_pwCheck .popConts .popInner fieldset").find('.inputBase').first().focus();
				return false;
			} 
		} else if(e.keyCode == 13){
			$(parent.document).find('#contents .board_area .btnArea button.btn_modi').focus();
			parent.ifrPopClose('PwdPop');
			return false;
		}
	});

	$("#pop_pwCheck .popConts .popInner fieldset .inputBase").keydown(function(e){
		var v_keyCode = event.keyCode || event.which;
		if(v_keyCode == 9){
			if(event.shiftKey){
				$(".pop_wrap .popLayout").find('.btn_popClose').first().focus();
				return false;
			}
		} else if(v_keyCode == 13){
			chkPwd();
		}
	});
	/* 190313 추가끝 */
	$('#pop_pwCheck .black').keydown(function(e){
		var v_keyCode = event.keyCode || event.which;
		if(v_keyCode == 9){
			if(event.shiftKey){
				$("#pop_pwCheck .popConts .popInner fieldset").find('input').first().focus();
				return false;
			} else {
				$(".pop_wrap .popLayout").find('.btn_popClose').first().focus();
			}
		}
		
	});
});


function chkPwd(){
	fn_comm_ajax({
		url : "/ajaxf/FR_BBS_SVC/BBSPwdCheck.do",
		data : $("#sendForm").serialize(),
		dataType : "json",
		success : function(data) {
        	if(data == 1){
         		parent.fn_view($("#pop_pwCheck [name=PWD]").val());
			}else{
	        	alert("확인번호가 맞지 않습니다.");
				$("#pop_pwCheck [name=PWD]").val('');
			}
		}
	});
}

function searchEnterkey() {
    if (window.event.keyCode == 13) {
    	chkPwd();
    }
}

</script>
<body class="typeIpsi">
<form id="sendForm">
	<input type="hidden" name="SITE_NO" value="${param.SITE_NO }"/>
	<input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ }"/>
	<input type="hidden" name="BBS_SEQ" value="${param.BBS_SEQ }"/>
	<input type="text" style="display: none;" title="검색용"/>
	<!-- popup -->
	<div class="pop_wrap" id="pop_pwCheck">
		<section class="popLayout popLayer">
			<h1 class="popTit">확인번호 입력</h1>
			
			<div class="popConts">
				<div class="popInner limit">
					<!-- 팝업 내용 입력-->
					<p class="txt mB15">확인번호를 입력해 주세요.</p>

					<fieldset>
						<legend>확인번호 입력 영역</legend>
						<input class="inputBase" type="password" title="확인번호를 입력하세요." placeholder="확인번호" name="PWD"/>
					</fieldset>
					<!-- //팝업 내용 입력 -->
				</div>
				<ul class="pop_btnArea">
					<li><a href="#none" class="baseBtn medium black" onclick="chkPwd();"><span class="base">확인</span></a></li>
					<li><a href="#none" class="baseBtn medium line btn_popClose"><span class="base">닫기</span></a></li>
				</ul>
			</div>
			<button type="button" class="btn_popClose"><span class="hidden">창닫기</span></button>
		</section>
	</div> 
	<!-- popup -->
</form>
</body>
</html>
