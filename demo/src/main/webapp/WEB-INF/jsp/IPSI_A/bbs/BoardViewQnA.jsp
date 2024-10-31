<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
var gbn = '';

$().ready(function() {
	$("#pageTab").remove();
	
	fn_detail();
	<c:if test="${boardConf.USE_REPLY_YN eq 'Y'}">
		fn_reply_list();
	</c:if>
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
// 		ifrSiteMapPop('PwdPop','/cms/FR_BBS_CON/NumChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val());
		
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
		console.log("4444");
		gbn = 'DEL';
// 		ifrSiteMapPop('PwdPop','/cms/FR_BBS_CON/NumChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val());
        $("#contents").append('<iframe id="iframePop" class="pop_iframe" height="100%" scrolling="no" frameborder="0" title="[팝업] 확인번호 입력" src="/cms/FR_BBS_CON/NumChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val()+'"></iframe>');
		ui.LayerPop.iframe("#iframePop", "#pop_pwCheck", "400");
        return;
        </c:if>
        boardItemDel();
    });
	
	$(document).on("click",".btn_list",function(){
		$("#sendForm").attr("action", "/cms/FR_CON/index.do");
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
	
	//*************** 답글 Function **************//
	$(document).on('click', 'button.btn_fileAdd', function() {
		
		if(Number("${boardConf.FILE_LIMIT}") > 0 && Number("${boardConf.FILE_LIMIT}") <= $(this).parents("table").find(".fileArea div").length){
			alert("최대 ${boardConf.FILE_LIMIT}개 까지 첨부할수 있습니다.");
			return;
		}
		var fileObj = '<div><input type="text" name="FILE_NM" class="inp_t" readonly="readonly" title="파일명"/><span class="btn_rec_gray">찾아보기<input type="file" name="FILE_OBJNEW" onchange="changeFile(this);"></span>'
		+'<button type="button" class="btn_fileAdd" type="button">추가</button><button type="button" class="btn_fileRe" type="button">새로고침</button><button type="button" class="btn_fileDel" type="button">삭제</button></div>';
        
		$(fileObj).appendTo($(this).parents("table").find(".fileArea"));
    });
	$(document).on('click', 'button.btn_fileDel', function() {
		if($(this).parents("table").find(".fileArea div").length <= 1) {
			$(this).parents("table").find(".fileArea div input:hidden[name=FILE_SEQ]").remove();
			$(this).parents("table").find(".fileArea div input:text[name=FILE_NM]").val("");
			$(this).parents("table").find(".fileArea div input:file").attr("name","FILE_OBJNEW");
		} else {
			$(this).closest("div").remove();
		}
    });
	
	$(document).on("click",".btn .rep_upt", function(){
		
		$(".replyArea .list .txtInfo .btn").show();
		$(".replyArea .list .txt_v").show();
		$(".replyArea .list .BBSlist_w").remove();
		$(".replyArea .list .btnArea").remove();
		$(this).parents("li").find(".btn").hide();
		$(this).parents("li").find(".txt_v").hide();
		
		var tblObj = '<table class="BBSlist_w">';
		tblObj += '<caption>작성자, 작성날짜, 제목, 내용, 첨부파일, 댓글을 확인 할 수 있는 표</caption>';
		tblObj += '<colgroup><col /><col /><col /><col /></colgroup>';
		tblObj += '<tbody>';
		tblObj += '<tr class="w_txt">';
		tblObj += '<th scope="row"><span class="mark_need"></span> 내용</th>';
		tblObj += '<td colspan="3">';
		tblObj += '<textarea name="REPLY_CONT" class="inp_area" rows="10" title="답글 수정창"></textarea>';
		tblObj += '</td>';
		tblObj += '</tr>';
		tblObj += '<tr class="w_addFile_m">';
		tblObj += '<th scope="row">첨부파일</th>';
		tblObj += '<td colspan="3" class="fileArea">';
		
		var fileDivObj = $(this).parents("li").find(".txt_v .fileArea");
		if($(fileDivObj).find("p").length > 0){
			$(fileDivObj).find("p").each(function(){
				tblObj += '<div><input type="hidden" name="FILE_SEQ" value="'+$(this).find("a").data("fileseq")+'"/>';
				tblObj += '<input type="text" name="FILE_NM" class="inp_t" title="파일명" readonly="readonly" value="'+$(this).find("a").text()+'" /><span class="btn_rec_gray">찾아보기<input type="file" name="FILE_OBJ'+$(this).find("a").data("fileseq")+'" onchange="changeFile(this);"/></span>';
				tblObj += '<button type="button" class="btn_fileAdd">추가</button>';
				tblObj += '<button type="button" class="btn_fileRe">새로고침</button>';
				tblObj += '<button type="button" class="btn_fileDel">삭제</button>';
				tblObj += '</div>';
			});
		}else{
			tblObj += '<div>';
			tblObj += '<input type="text" name="FILE_NM" class="inp_t" title="파일명" readonly="readonly" /><span class="btn_rec_gray">찾아보기<input type="file" name="FILE_OBJNEW" onchange="changeFile(this);"/></span>';
			tblObj += '<button type="button" class="btn_fileAdd">추가</button>';
			tblObj += '<button type="button" class="btn_fileRe">새로고침</button>';
			tblObj += '<button type="button" class="btn_fileDel">삭제</button>';
			tblObj += '</div>';
		}
		
		tblObj += '</td>';
		tblObj += '</tr>';
		tblObj += '</tbody>';
		tblObj += '</table>';
		tblObj += '<div class="btnArea">';
		tblObj += '<button class="btn_txtWrite rep_save" type="button"><span>등록</span></button>';
		tblObj += '<button class="btn_txtCancel rep_cancel" type="button"><span>취소</span></button>';
		tblObj += '</div>';
		
		$(tblObj).appendTo($(this).parents("li"));
		$(this).parents("li").find("textarea[name=REPLY_CONT]").val($(this).parents("li").find(".view_txt").data("cont"));
	});
	
	$(document).on("click",".btn .rep_del", function(){
		if(!confirm("삭제하시겠습니까?")) {
	        return;
	    }
		
		$("#replyForm input:hidden[name=BBS_SEQ]").val($(this).parents("li").data("idno"));
	    
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardQnaReplyDel.do",
	        data : $("#replyForm").serialize(),
	        dataType : "json",
	        success : function(data) {
	        	if(data == 1){
                    fn_reply_list();
                }else if(data == 2){
                    alert("세션이 만료되었습니다.");
                }else{
                    alert("삭제에 실패했습니다. 관리자에 문의하세요.");
                }
	        	$("#replyForm input:hidden[name=BBS_SEQ]").val("");
	        }
	    });
	});
	
	$(document).on("click",".btnArea .rep_save", function(){
		
	    if($(this).parents("li").find("textarea").val().trim() == ""){
	        alert('답글을 입력하세요.');
	        return;
	    }
		
	    $("#replyForm input:hidden[name=BBS_SEQ]").val($(this).parents("li").data("idno"));
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardQnaReplyModi.do",
	        ajaxFormName : 'replyForm',
	        dataType : "json",
	        success : function(data) {
	            if(data == 1){
	                fn_reply_list();
	            }else if(data == 2){
	                alert("세션이 만료되었습니다.");
	            }else{
	                alert("저장에 실패했습니다. 관리자에 문의하세요.");
	            }
	        }
	    });
	});
	
	$(document).on("click",".btnArea .rep_cancel", function(){
		$(".replyArea .list .txtInfo .btn").show();
		$(".replyArea .list .txt_v").show();
		$(".replyArea .list .BBSlist_w").remove();
		$(".replyArea .list .btnArea").remove();
	});
	
	$(document).on("click",".replyArea .rep_reg", function(){
		
		if($(".replyArea textarea[name=CONTENTS]").val().trim() == ""){
	        alert('답글을 입력하세요.');
	        return;
	    }
	    
	    if(!confirm("저장하시겠습니까?")) {
	        return;
	    }
	    
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardQnaReplySave.do",
	        ajaxFormName : 'replyRegForm',
	        dataType : "json",
	        success : function(data) {
	            if(data == 1){
	                $(".replyArea textarea[name=CONTENTS]").val("");
	                $(".replyArea #repFileNm").val("");
	                $(".replyArea #repFileObj").remove();
	                $('<input type="file" name="FILE_OBJNEW" onchange="changeFile(this);" id="repFileObj"/>').appendTo($(".replyArea #repFileNm").next());
	                fn_reply_list();
	            }else if(data == 2){
	            	alert("세션이 만료되었습니다.");
	            }else{
	                alert("저장에 실패했습니다. 관리자에 문의하세요.");
	            }
	        }
	    });
	});
	//*************** 답글 Function **************//
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
            
            $("head meta[name=title]").attr("content",data.SUBJECT);
            
            var conts = '';
            if(data.CONTENTS != null && data.CONTENTS.indexOf("<") == 0){
                conts = $(data.CONTENTS).text();
            }else{
                conts = data.CONTENTS;
            }
            $("head meta[name=description]").attr("content",conts);
            
            if(/<[a-z][\s\S]*>/i.test(data.CONTENTS)) //에디터 작성글(html)인지 체크
            {
                $(".BBSlist_v div.view_txt").html(data.CONTENTS);
            }
            else
           	{
                $(".BBSlist_v div.view_txt").html(data.CONTENTS.replace(/\n/g,"<br/>"));
           	}
            
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
                $("#sendForm").attr("action", "/cms/FR_CON/index.do");
        	    $("#sendForm").submit();
            }else if(data == 9){
            	alert("삭제권한이 없습니다.");
            }else{
                alert("삭제에 실패했습니다. 관리자에 문의하세요.");
            }
        }
    });
}

function changeFile(obj){
    var fileName = $(obj).val();
    fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
    fileName = fileName.substring(fileName.lastIndexOf("/")+1);
    
    if(fileName != "") {
        var $parent = $(obj).parent().parent();
        $parent.find("[name='FILE_NM']").val(fileName);
    }
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

function fn_reply_list(){
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardReplyListData.do",
        data : $("#replyForm").serialize(),
        dataType : "json",
        success : function(data) {
        	$("#tbody2").empty();
        	if(data != null){
        		for(var i=0; i<data.length; i++){
        			var liObj = '<li data-idno="'+data[i].BBS_SEQ+'">';
        			liObj += '<div class="txtInfo">';
        			liObj += '<span class="writer">'+data[i].WRITER_NM+'</span>';
        			liObj += '<span class="date">'+data[i].REG_DT+'</span>';
        			/* if(data[i].WRITER_YN == 'Y'){
        				liObj += '<div class="btn">';
        				liObj += '<button type="button" class="btnC_s rep_upt"><span>수정</span></button>';
        				liObj += '<button type="button" class="btnC_s rep_del"><span>삭제</span></button>';
        				liObj += '</div>';
        			} */
        			liObj += '</div>';
        			liObj += '<p class="view_txt" data-cont="'+data[i].CONTENTS+'">'+data[i].CONTENTS+'</p>';
        			if(data[i].FILE_CNT > 0){
	        			liObj += '<div class="fileArea"></div>';
        			}
        			liObj += '</div>';
        			liObj += '</li>';
        			
        			$(liObj).appendTo($("#tbody2"));
        		}
        		
        		$("#tbody2 li .fileArea").each(function(){
        			fn_reply_file_list($(this));
        		});
        		
        		
        		$("#tbody2 li").each(function(){
        			var org = $(this).find(".view_txt").text();
        			$(this).find(".view_txt").html(org.replace(/\n/g,"<br/>"));
        		});
        	}else{
        		
        	}
            $(".replyArea .num").text(data.length);
        }
    });
}

function fn_reply_file_list(obj){
	
	$("#replyForm [name=BBS_SEQ]").val($(obj).parents("li").data("idno"));
	fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardReplyFileListData.do",
        data : $("#replyForm").serialize(),
        dataType : "json",
        success : function(data) {
        	for(var i=0; i<data.length; i++){
        		var pObj = '<p>';
        		pObj += '<a href="#;" title="다운로드" data-boardseq="'+data[i].BOARD_SEQ+'" data-siteno="'+data[i].SITE_NO+'" data-bbsseq="'+data[i].BBS_SEQ+'" data-fileseq="'+data[i].FILE_SEQ+'" onclick="fileDown(this);">'+data[i].FILE_ORG_NM+'</a>';
        		/* pObj += '<button type="button" class="btn_preview" data-boardseq="'+data[i].BOARD_SEQ+'" data-siteno="'+data[i].SITE_NO+'" data-bbsseq="'+data[i].BBS_SEQ+'" data-fileseq="'+data[i].FILE_SEQ+'">미리보기</button>'; */
        		pObj += '</p>';
        		$(pObj).appendTo($(obj));
        	}
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
	var snsUrl = '${DOMAIN}/cms/FR_BBS_CON/BoardView.do?MENU_ID=${param.MENU_ID}';
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
<div class="board_area"> <!-- typeQna -->
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
	<div class="BBSlist_v">
		<dl>
			<!-- 게시판 타이틀 -->
			<dt class="likeTitle"></dt>
			<!-- //게시판 타이틀 -->
			
			<!-- 게시판 컨텐츠 -->
			<dd>
				<div class="view_txt"></div>
				<c:if test="${not empty boardFileList }" >
				<div class="fileArea">
				<c:forEach var="list" items="${boardFileList }">
					<p>
						<a href="#;" title="다운로드" data-boardseq="${list.BOARD_SEQ}" data-siteno="${list.SITE_NO }" data-bbsseq="${list.BBS_SEQ }" data-fileseq="${list.FILE_SEQ }" onclick="fileDown(this);">${list.FILE_ORG_NM }</a>
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

	<!-- 버튼영역 -->
	<div class="btn_Area btn_Area_R">
<%-- 		<c:if test="${boardConf.USE_REPLY_YN eq 'Y' && AUTH_REPLY_PASS && boardItem.REPLY_BBS_YN eq 'N' }">
			<button type="button" class="btnC btnWhite btn_reply"><span>답글</span></button>
		</c:if> --%>
		<c:if test="${boardItem.WRITER_YN eq 'Y' || boardItem.ANNO_YN eq 'Y' }">
			<button type="button" class="baseBtn lineBlack large btn_modi"><span class="base">수정</span></button>
			<button type="button" class="baseBtn lineBlack large btn_delete"><span class="base">삭제</span></button>
		</c:if>
		<button type="button" class="baseBtn large black btn_list"><span class="base">목록</span></button>
	</div>
	<!-- //버튼영역 -->
	
	<c:if test="${boardConf.USE_REPLY_YN eq 'Y'}">
	<!--답글-->
	<section class="replyArea replayFile">
		<div class="tit">
			<h1>답글</h1>
		</div>
		<form id="replyForm" method="post">
		<input type="hidden" name="pageNo" id="pageNo1" value="1"/>
	    <input type="hidden" name="MENU_ID" value="${param.MENU_ID}"/>
	    <input type="hidden" name="SITE_NO" value="${param.SITE_NO}"/>
	    <input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ}"/>
	    <input type="hidden" name="P_BBS_SEQ" value="${param.BBS_SEQ}"/>
	    <input type="hidden" name="BBS_SEQ"/>
		<ul class="list" id="tbody2"></ul>
		</form>
	</section>
	<!--/답글-->
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
						<a href="#;" onclick="alert('비밀글 입니다.');" title="이전 비밀글">${boardSideList.PREV_SUBJECT }</a>
					</p>
	            </c:when>
	            <c:otherwise>
	                <p class="article">
	            		<c:if test="${!empty boardSideList.PREV_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.PREV_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="prev();" title="이전 글">${boardSideList.PREV_SUBJECT }</a>
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
						<a href="#;" onclick="alert('비밀글 입니다.');" title="다음 비밀글">${boardSideList.NEXT_SUBJECT }</a>
					</p>
	            </c:when>
	            <c:otherwise>
	            	<p class="article">
	            		<c:if test="${!empty boardSideList.NEXT_CATEGORY_NM}">
							<span class="mark_categ">[${boardSideList.NEXT_CATEGORY_NM}]</span>
	            		</c:if>
						<a href="#;" onclick="next();" title="다음글">${boardSideList.NEXT_SUBJECT }</a>
					</p>
	            </c:otherwise>
	        </c:choose>
	        </li>
	    </ul>
    </div>
    <!-- //이전글/다음글 -->
    
    </c:if>
</div>
</div>
<!-- //board -->
<form id="prvForm" target="_blank"></form>