<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
var gbn = '';

$().ready(function() {
	$("#pageTab").remove();
	
	fn_detail();
	
	/* youtube */
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	var player;
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('v_player', {
		events: {
			'onReady': onPlayerReady,
			'onStateChange': onPlayerStateChange
		}
		});
	};
	function onPlayerReady(event) {
		player.stopVideo();
	};

	var done = false;
	function onPlayerStateChange(event) {

	};
	function stopVideo() {
		player.stopVideo();
	};
	/* youtube */

	/* 동영상재생 */
	$("#youTube_play").on("click",function(e){
		$(this).hide();
		player.playVideo();
	});
	
	<c:if test="${boardConf.USE_COMMENT_YN eq 'Y'}">
		fn_comment_list();
	</c:if>

	$(".shareArea .btnC_share").click(function(){
		$(this).toggleClass('on');
		$(".shareArea .shareBox").toggle();
		shareBox_act();
	});

	$(".shareArea .shareBox li>a").click(function(){
		$(".shareArea .shareBox").toggle();
		shareBox_act();
	});

	$("div#dim").click(function(){
		$(this).removeClass("on");
		$(".shareArea .shareBox").toggle();
	});

	$(window).resize(function(){
		if($(".shareArea .shareBox").css('display') == 'block'){
			$(".shareArea .shareBox").toggle();
			shareBox_act()
		}
	});
	
	$(document).on("click",".btnC_like", function(){
		
		fn_comm_ajax({
            url : "/ajaxf/FR_BBS_SVC/BoardLike.do",
            data : $("#sendForm").serialize(),
            dataType : "json",
            success : function(data) {
                if(data == 1){
                	fn_detail();
                }else if(data == 3){
                	alert("로그인 후 좋아요 하실 수 있습니다.");
                }else{
                    alert("좋아요에 실패했습니다. 관리자에 문의하세요.");
                }
            }
        });
		return false;
	});
	
	$(document).on("click","button.btn_modi", function(){
		<c:if test="${boardItem.ANNO_YN eq 'Y' }">
		gbn = 'MODI';
// 		ifrSiteMapPop('PwdPop','${(not empty BASE_PATH && BASE_PATH != "")?"/":""}${BASE_PATH}/cms/FR_BBS_CON/PwdChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val());
		
		$("#contents").append('<iframe id="iframePop" class="pop_iframe" height="100%" scrolling="no" frameborder="0" title="[팝업] 확인번호 입력" src="/cms/FR_BBS_CON/NumChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val()+'"></iframe>');
		ui.LayerPop.iframe("#iframePop", "#pop_pwCheck", "400");
        return;
        </c:if>
        if($("#sendForm input:hidden[name=P_BBS_SEQ]").val() == ""){
        	$("#sendForm").attr("action", "BoardWrite.do");
    	    $("#sendForm").submit();
        }else{
        	var pBbsSeq = $("#sendForm input:hidden[name=P_BBS_SEQ]").val();
        	$("#sendForm").attr("action", "BoardReply.do");
    	    $("#sendForm").submit();
        }
	});
	$(document).on("click","button.btn_delete",function(){
		<c:if test="${boardItem.ANNO_YN eq 'Y' }">
		gbn = 'DEL';
// 		ifrSiteMapPop('PwdPop','${(not empty BASE_PATH && BASE_PATH != "")?"/":""}${BASE_PATH}/cms/FR_BBS_CON/PwdChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val());

		$("#contents").append('<iframe id="iframePop" class="pop_iframe" height="100%" scrolling="no" frameborder="0" title="[팝업] 확인번호 입력" src="/cms/FR_BBS_CON/NumChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val()+'"></iframe>');
		ui.LayerPop.iframe("#iframePop", "#pop_pwCheck", "400");
        return;
        </c:if>
        boardItemDel();
    });
	
	$(document).on("click",".btn_Area button.btn_list",function(){
		$("#sendForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_CON/index.do");
	    $("#sendForm").submit();
	});
	
	$(document).on("click","button.reply",function(){
    	
	    $("#sendForm input:hidden[name=P_BBS_SEQ]").val($("#sendForm input:hidden[name=BBS_SEQ]").val());
	    $("#sendForm input:hidden[name=BBS_SEQ]").val("");
	        
		$("#sendForm").attr("action", "BoardReply.do");
	    $("#sendForm").submit();
    });
	
	$(document).on("click",".btn_preview",function(){
		fn_comm_ajax({
	        url : "/ajaxf/CMN_SVC/PreviewFile.do",
	        data : $("#prvForm").serialize()+'&GBN=Y02&SITE_NO='+$(this).data("siteno")+'&BOARD_SEQ='+$(this).data("boardseq")+'&BBS_SEQ='+$(this).data("bbsseq")+'&FILE_SEQ='+$(this).data("fileseq"),
	        dataType : "json",
	        success : function(data) {
	        	if(data.result == '1'){
	        		window.open(data.previewUrl);
	        	}else{
	        		alert('미리보기에 실패했습니다. 관리자에게 문의하세요.');
	        	}
	        }
	    });
    });
	
	
	//*************** 댓글 Function **************//
	$(document).on("click",".btn .btn_upt", function(){
		$(".replyArea .list fieldset").remove();
		$(".replyArea .list p").show();
		$(this).parents("li").find("p").hide();
		$(".replyArea .list .btn").show();
		$(this).parents("li").find(".btn").hide();
		var modiTag = '<fieldset>';
		modiTag += '<legend>댓글 수정</legend>';
		modiTag += '<textarea class="inp_area" name="COMMENT_CONT" title="댓글 내용 수정창"></textarea>';
		modiTag += '<div class="btn"><button class="btn_txtCancel btn_cancel" type="button">취소</button><button class="btn_txtWrite btn_save" type="button">등록</button></div>';
		modiTag += '</fieldset>';
		
		$(modiTag).appendTo($(this).parents("li"));
		$(this).parents("li").find("textarea[name=COMMENT_CONT]").val($(this).parents("li").find("p").data("conts"));
	});
	
	$(document).on("click",".btn .btn_del", function(){
		
		if(!confirm("삭제하시겠습니까?")) {
	        return;
	    }
		var idno = $(this).parents("li").data("idno");
	    
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardCommentDel.do",
	        data : $("#commentForm").serialize()+"&COMMENT_SEQ="+idno,
	        dataType : "json",
	        success : function(data) {
	        	if(data == 1){
	        		$("#commentForm [name=pageNo]").val("1");
                    fn_comment_list();
                }else if(data == 2){
                    alert("세션이 만료되었습니다.");
                }else{
                    alert("삭제에 실패했습니다. 관리자에 문의하세요.");
                }
	        }
	    });
	});
	
	$(document).on("click",".btn .btn_save", function(){
		
	    if($(this).parent().parent().find("textarea").val().trim() == ""){
	        alert('댓글을 입력하세요.');
	        return;
	    }
	    var idno = $(this).parents("li").data("idno");
	    
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardCommentModi.do",
	        data : $("#commentForm").serialize()+"&COMMENT_SEQ="+idno,
	        dataType : "json",
	        success : function(data) {
	            if(data == 1){
	                fn_comment_list();
	            }else if(data == 2){
	                alert("세션이 만료되었습니다.");
	            }else{
	                alert("저장에 실패했습니다. 관리자에 문의하세요.");
	            }
	        }
	    });
	});
	
	$(document).on("click",".btn .btn_cancel", function(){
		$(".replyArea .list fieldset").remove();
		$(".replyArea .list p").show();
		$(".replyArea .list .btn").show();
	});
	//*************** 댓글 Function **************//
	
});

function fn_view(pwd){
	$("#sendForm [name=PWD]").val(pwd);
	if(gbn == 'MODI'){
		if($("#sendForm input:hidden[name=P_BBS_SEQ]").val() == ""){
        	$("#sendForm").attr("action", "BoardWrite.do");
    	    $("#sendForm").submit();
        }else{
        	var pBbsSeq = $("#sendForm input:hidden[name=P_BBS_SEQ]").val();
        	$("#sendForm").attr("action", "BoardReply.do");
    	    $("#sendForm").submit();
        }
	}else{
		boardItemDel();
	}
}

function fn_detail(){
    if($("#sendForm input:hidden[name=BBS_SEQ]").val() == ''){
        return;
    }
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardViewData.do",
        data : $("#sendForm").serialize()+"&CONTENTS_NO=${CONTENTS_NO}",
        dataType : "json",
        success : function(data) {
            
            $("#sendForm").fn_comm_setValue(data);
            $("div.shareArea .btnC_like span").text(data.RECOMMS);
            
            var headerTag = '';
            if(data.CATE_NM != null && data.CATE_NM != ''){
            	headerTag = '<span class="mark_categ">'+data.CATE_NM+'</span> ';
            }
//             headerTag += fn_util_htmlEncode(data.SUBJECT);
 			headerTag += '<div class="txtL"><p class="headLine3s">'+fn_util_htmlEncode(data.SUBJECT)+'</p></div>';
            if("${boardConf.USE_USERINFO_YN}" == "Y" || "${boardConf.USE_REG_DT_YN}" == "Y" || "${boardConf.USE_HITS_YN}" == "Y"){
	            headerTag += '<div class="txtInfo">';
	            if("${boardConf.USE_USERINFO_YN}" == "Y"){
	            	headerTag += '<span class="writer"><em class="name">작성자</em> <em class="data">'+data.WRITER_NM+'</em></span>';
	            }
	            if("${boardConf.USE_REG_DT_YN}" == "Y"){
	            	headerTag += '<span class="date"><em class="name">등록일</em> <em class="data">'+data.WRITE_DT+'</em></span>';
	            }
	            if("${boardConf.USE_HITS_YN}" == "Y"){
	            	headerTag += '<span class="view"><em class="name">조회수</em> <em class="data">'+data.HITS+'</em></span>';
	            }
	            headerTag += '</div>';
			}
            
            $("div.BBSlist_v dt").html(headerTag);
            
            $("head meta[name=title]").attr("content",fn_util_htmlEncode(data.SUBJECT));
            
            if(data.CONTS_GBN == 'B0102'){
            	if(data.VALUE1 != null) $("span.teacher").text(data.VALUE1);
            	else $("span.teacher").remove();
            	if(data.VALUE2 != null) $("span.time").text(data.VALUE2);
            	else $("span.time").remove();
            	if(data.VALUE3 != null){
            		$(".movie_caption .txt > p").html(data.VALUE3.replace(/\n/g,"<br/>"));
            	}else{
            		$(".movie_caption").remove();
            	}
            	
            	var video_cont = '';
            	video_cont += '<iframe width="100%" height="435" src="'+data.VIDEO_URL+'" frameborder="0" allow="autoplay; encrypted-media" title="'+data.SUBJECT+'" allowfullscreen></iframe>';
            	//$(video_cont).appendTo($(".movie"));
            	$(".movie").html(video_cont);
            	
            	$(".view_movie .movie_caption .txt").mCustomScrollbar();
            }
            
            var conts = '';
            if(data.CONTENTS != null && data.CONTENTS.indexOf("<") == 0){
                conts = $(data.CONTENTS).text();
            }else{
                conts = data.CONTENTS;
            }
            $("head meta[name=description]").attr("content",conts);
            
            $("div.view_txt").html(data.CONTENTS);
        }
    });
}

function boardItemDel(){
	if(!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardItemDel.do",
        data : $("#sendForm").serialize(),
        dataType : "json",
        success : function(data) {
            if(data == 1){
                $("#sendForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_CON/index.do");
        	    $("#sendForm").submit();
            }else if(data == 9){
            	alert("삭제권한이 없습니다.");
            }else{
                alert("삭제에 실패했습니다. 관리자에 문의하세요.");
            }
        }
    });
}

function textareaBytes(obj){
	var text = $(obj).val();
	$(obj).parents("fieldset").find("span").text(getTextBytes(text));
}

function getTextBytes(str){
	var len = 0;
	for(var i =0; i< str.length; i++){
		if(escape(str.charAt(i)).length == 6){
			len++;
		}
		len++;
	}
	return len;
}

function fn_comment_list(){
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardCommentListData.do",
        data : $("#commentForm").serialize(),
        dataType : "json",
        success : function(data) {
            fn_comm_setList("#tbody", data, "#listTemplate", "#noListTemplate", ".replyArea .num", ".pagination");
            
            if($("#commentForm .list li").length > 0){
            	$("#tbody").show();
            	$(".pagination").show();
            }else{
            	$("#tbody").hide();
            	$(".pagination").hide();
            }
            
            $("#commentForm .list li").each(function(){
            	var org = $(this).find("p").text();
            	$(this).find("p").html(org.replace(/\n/g,"<br/>"));
        	});
        }
    });
}

function fn_comment_save(){
    //validation check
    if($("#commentForm textarea[name=CONTENTS]").val().trim() == ""){
        alert('댓글을 입력하세요.');
        return;
    }
    
    if(!confirm("저장하시겠습니까?")) {
        return;
    }
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardCommentSave.do",
        data : $("#commentForm").serialize(),
        dataType : "json",
        success : function(data) {
            if(data == 1){
                $("#commentForm textarea[name=CONTENTS]").val("");
                fn_comment_list();
            }else if(data == 2){
            	alert("세션이 만료되었습니다.");
            }else{
                alert("저장에 실패했습니다. 관리자에 문의하세요.");
            }
        }
    });
}

function linkPage(pageNo){
    $("#commentForm [name='pageNo']").val(pageNo);
    fn_comment_list();
}

function fileDown(obj){
    location.href="/ajaxfile/FR_SVC/FileDown.do?GBN=X01&BOARD_SEQ="+$(obj).data("boardseq")+"&SITE_NO="+$(obj).data("siteno")+"&BBS_SEQ="+$(obj).data("bbsseq")+"&FILE_SEQ="+$(obj).data("fileseq");
}

function prev(){
	$("#sendForm input:hidden[name=BBS_SEQ]").val($("#sendForm input:hidden[name=PREV_IDX]").val());
	$("#sendForm").attr("action", "BoardView.do");
    $("#sendForm").submit();
}

function next(){
	$("#sendForm input:hidden[name=BBS_SEQ]").val($("#sendForm input:hidden[name=NEXT_IDX]").val());
	$("#sendForm").attr("action", "BoardView.do");
    $("#sendForm").submit();
}

function shareBox_act(){
	if($("#dim").attr("class") == "on"){
		$("#dim").removeClass("on");
	}else{
		$("#dim").addClass("on");
	}
}

function shareSns(sns){
	var snsTitle = '';
	var snsItems = new Array();
	var winOpt = new Array();
	var snsUrl = "${DOMAIN}${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardView.do?MENU_ID=${param.MENU_ID}";
	snsUrl += '&CONTENTS_NO=${param.CONTENTS_NO}';
	snsUrl += '&SITE_NO=${param.SITE_NO}';
	snsUrl += '&BOARD_SEQ=${param.BOARD_SEQ}';
	snsUrl += '&BBS_SEQ=${param.BBS_SEQ}';
	snsUrl += '&P_BBS_SEQ=${param.P_BBS_SEQ}';
	snsUrl += '&SLFLAG=Y';
	
	snsItems['facebook'] = "http://www.facebook.com/share.php?t="+encodeURIComponent(snsTitle) + "&u=" + encodeURIComponent(snsUrl);
	snsItems['twitter'] = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(snsTitle + "\n" + snsUrl);
	snsItems['band'] = "http://www.band.us/plugin/share?body="+encodeURIComponent(snsUrl)+"&route="+encodeURIComponent(snsUrl);
	snsItems['kakao'] = "https://story.kakao.com/share?url="+encodeURIComponent(snsUrl);
	snsItems['google'] = "https://plus.google.com/share?url="+encodeURIComponent(snsUrl)+"&t=" + encodeURIComponent(snsTitle);
	snsItems['blog'] = "http://blog.naver.com/openapi/share?url=" + encodeURIComponent(snsUrl) + "&title=" + encodeURIComponent(snsTitle);
	snsItems['pinterest'] = "http://www.pinterest.com/pin/create/button/?url=" + encodeURIComponent(snsUrl) + "&description=" + encodeURIComponent(snsTitle);
	snsItems['tumblr'] = "https://www.tumblr.com/widgets/share/tool?posttype=link&canonicalUrl=" + encodeURIComponent(snsUrl) + "&title=" + encodeURIComponent(snsTitle);
	
	winOpt['facebook'] = "width=600, height=500";
	winOpt['twitter'] = "width=600, height=500";
	winOpt['band'] = "width=500, height=500, resizable=yes";
	winOpt['kakao'] = "width=500, height=500, resizable=yes";
	winOpt['google'] = "width=500, height=500, resizable=yes";
	winOpt['blog'] = "width=500, height=500, resizable=yes";
	winOpt['pinterest'] = "width=700, height=700, resizable=yes";
	winOpt['tumblr'] = "width=700, height=700, resizable=yes";
	
	var win = window.open(snsItems[sns], sns, winOpt[sns]);
	if (win) {
        win.focus();
    }
}


</script>
<!-- board -->
<div class="boardCommon">
<div class="board_area">
	<form id="sendForm" method="post">
	    <input type="hidden" name="MENU_ID" id="MENU_ID" value="${param.MENU_ID}"/>
	    <input type="hidden" name="CONTENTS_NO" value="${param.CONTENTS_NO}"/>
	    <input type="hidden" name="SITE_NO" value="${param.SITE_NO}"/>
	    <input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ}"/>
	    <input type="hidden" name="BBS_SEQ" value="${param.BBS_SEQ}"/>
	    <input type="hidden" name="P_BBS_SEQ" value="${param.P_BBS_SEQ}"/>
	    <input type="hidden" name="CATE_SEQ"/>
		<input type="hidden" name="PWD" />
	    <input type="hidden" name="pageNo" id="pageNo" value="${param.pageNo}"/>
	    <input type="hidden" name="SEARCH_SEQ" value="${param.SEARCH_SEQ}"/>
	    <input type="hidden" name="SEARCH_FLD" value="${param.SEARCH_FLD}"/>
	    <input type="hidden" name="SEARCH" value="${param.SEARCH}"/>
	    <input type="hidden" name="PREV_IDX" value="${boardSideList.PREV_IDX}"/>
	    <input type="hidden" name="NEXT_IDX" value="${boardSideList.NEXT_IDX}"/>
	</form>
	<div class="BBSlist_v BBSgallery">
		<dl>
			<!-- 게시판 타이틀 -->
			<dt class="likeTitle"></dt>
			<!-- //게시판 타이틀 -->
			
			<!-- 게시판 컨텐츠 -->
			<dd>
				<c:if test="${boardItem.CONTS_GBN eq 'B0102' }">
					<div class="view_movie">
						<div class="movie"></div>
						<div class="movie_caption">
							<div class="txt">
<!-- 								<strong>학과소개영상</strong> -->
								<p></p>
							</div>
						</div>
					</div>
				</c:if>
				<div class="view_txt"></div>
				<c:if test="${not empty boardFileList }" >
				<div class="fileArea">
				<c:forEach var="list" items="${boardFileList }">
					<p>
						<a href="#;" title="다운로드" data-boardseq="${list.BOARD_SEQ}" data-siteno="${list.SITE_NO }" data-bbsseq="${list.BBS_SEQ }" data-fileseq="${list.FILE_SEQ }" onclick="fileDown(this);" >${list.FILE_ORG_NM }</a>
	                 	<%-- <button type="button" class="btn_preview" data-boardseq="${list.BOARD_SEQ}" data-siteno="${list.SITE_NO }" data-bbsseq="${list.BBS_SEQ }" data-fileseq="${list.FILE_SEQ }">미리보기</button> --%>
	                 </p>
				</c:forEach>
				</div>
				</c:if>
			</dd>
			<!-- //게시판 컨텐츠 -->
		</dl>
		
		<!-- 공유 -->
		<div class="shareArea">
			<div class="btnArea">
			<c:if test="${boardConf.USE_LIKE_YN eq 'Y' }" >
				<button type="button" class="btnC_like"><span>0</span></button>
			</c:if>
			<c:if test="${boardConf.USE_SNS_YN eq 'Y' }" >
				<button type="button" class="btnC_share"><span>공유하기</span></button>
			</c:if>
			</div>

			<div class="shareBox">
				<ul>
					<li><a href="#;" class="sns_facebook" title="새창열림" onclick="shareSns('facebook');">페이스북</a></li>
	                <li><a href="#;" class="sns_band" title="새창열림" onclick="shareSns('band');">네이버밴드</a></li>
	                <li><a href="#;" class="sns_twitter" title="새창열림" onclick="shareSns('twitter');">트위터</a></li>
	                <li><a href="#;" class="sns_blog" title="새창열림" onclick="shareSns('blog');">네이버블로그</a></li>
	                <li><a href="#;" class="sns_googlePlus" title="새창열림" onclick="shareSns('google');">구글+</a></li>
	                <li><a href="#;" class="sns_tumblr" title="새창열림" onclick="shareSns('tumblr');">텀블러</a></li>
	                <li><a href="#;" class="sns_kakaoStory" title="새창열림" onclick="shareSns('kakao');">카카오스토리</a></li>
	                <li><a href="#;" class="sns_pinterest" title="새창열림" onclick="shareSns('pinterest')">핀터레스트</a></li>
				</ul>
			</div>
		</div>
		<!-- //공유 -->
	</div>

	<div class="btn_Area btn_Area_R">
	<c:if test="${boardItem.WRITER_YN eq 'Y' || boardItem.ANNO_YN eq 'Y' }">
		<button type="button" class="baseBtn lineBlack large btn_modi"><span class="base">수정</span></button>
		<button type="button" class="baseBtn lineBlack large btn_delete"><span class="base">삭제</span></button>
	</c:if>
		<button type="button" class="baseBtn large black btn_list"><span class="base">목록</span></button>
	</div>

	<c:if test="${boardConf.USE_COMMENT_YN eq 'Y'}">
	<form id="commentForm" method="post">
		<input type="hidden" name="pageNo" id="pageNo1" value="1"/>
	    <input type="hidden" name="MENU_ID" value="${param.MENU_ID}"/>
	    <input type="hidden" name="SITE_NO" value="${param.SITE_NO}"/>
	    <input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ}"/>
	    <input type="hidden" name="BBS_SEQ" value="${param.BBS_SEQ}"/>
	<!--댓글-->
	<section class="replyArea">
		<div class="tit">
			<h1>댓글</h1>
			<span class="num">0</span>
		</div>
		<ul class="list">
			<!-- 쓰기 -->
			<c:if test="${AUTH_COMMENT_PASS}">
			<li>
				<div class="write">
					<fieldset>
						<legend>댓글 입력</legend>
						<textarea class="inp_area" name="CONTENTS" placeholder="댓글을 입력해 주세요." title="댓글 입력창"></textarea>
						<div class="btn">
							<button class="btn_txtWrite" type="button" onclick="fn_comment_save();">등록</button>
						</div>
					</fieldset>
				</div>
			</li>
			</c:if>
			<!-- //쓰기 -->
		</ul>
		<ul class="list" id="tbody"></ul>
		<script id="noListTemplate" type="text/x-jquery-tmpl"></script>
	    <script id="listTemplate" type="text/x-jquery-tmpl">
			<li data-idno="{%= COMMENT_SEQ %}">
				<div class="txtInfo">
					<span class="writer">{%= WRITER_NM %}</span>
					<span class="date">{%= REG_DT %}</span>
				</div>
				<p data-conts="{%= CONTENTS %}">{%= CONTENTS %}</p>
            {%if WRITER_YN == 'Y' %}
				<div class="btn">
					<button type="button" class="btnC_s btn_upt"><span>수정</span></button>
					<button type="button" class="btnC_s btn_del"><span>삭제</span></button>
				</div>
            {%/if%}
			</li>
        </script>
		<div class="pagination"></div>
	</section>
	<!--/댓글-->
	</form>
	</c:if>

	<c:if test="${not empty boardSideList && boardConf.USE_PREVNEXT_YN eq 'Y'}">
    
    <!-- 이전글/다음글 -->
    <div class="prevNnext">
	    <ul>
	        <li class="prev">
	            <strong>이전글</strong>
	        <c:choose>
	            <c:when test="${empty boardSideList.PREV_IDX || boardSideList.PREV_IDX eq '0'}">
	                <p class="no_article">이전글이 없습니다.</p>
	            </c:when>
	            <c:when test="${boardSideList.PREV_SECRET_YN eq 'Y' }">
	            	<p class="article">
	            		<c:if test="${!empty boardSideList.PREV_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.PREV_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="alert('비밀글 입니다.');" title="이전 비밀글"><c:out value="${boardSideList.PREV_SUBJECT}"/></a>
					</p>
	            </c:when>
	            <c:otherwise>
	                <p class="article">
	            		<c:if test="${!empty boardSideList.PREV_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.PREV_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="prev();" title="이전글"><c:out value="${boardSideList.PREV_SUBJECT}"/></a>
					</p>
	            </c:otherwise>
	        </c:choose>
	        </li>
	        <li class="next">
	            <strong>다음글</strong>
	        <c:choose>
	            <c:when test="${empty boardSideList.NEXT_IDX || boardSideList.NEXT_IDX eq '0'}">
	                <p class="no_article">다음글이 없습니다.</p>
	            </c:when>
	            <c:when test="${boardSideList.NEXT_SECRET_YN eq 'Y' }">
	            	<p class="article">
	            		<c:if test="${!empty boardSideList.NEXT_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.NEXT_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="alert('비밀글 입니다.');" title="다음 비밀글"><c:out value="${boardSideList.NEXT_SUBJECT}"/></a>
					</p>
	            </c:when>
	            <c:otherwise>
	            	<p class="article">
	            		<c:if test="${!empty boardSideList.NEXT_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.NEXT_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="next();" title="다음글"><c:out value="${boardSideList.NEXT_SUBJECT}"/></a>
					</p>
	            </c:otherwise>
	        </c:choose>
	        </li>
	    </ul>
    </div>
    <!-- //이전글/다음글 -->
    
    </c:if>

</div>
<!-- //board -->
<form id="prvForm" target="_blank"></form>