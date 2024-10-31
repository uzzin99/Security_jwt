<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<script>
$().ready(function() {
	
	$("#sendForm select[name=SEARCH_SEQ]").val("${param.SEARCH_SEQ}");
	$("#sendForm [name=SEARCH_FLD]").val("${param.SEARCH_FLD}");
	$("#sendForm [name=SEARCH]").val("${param.SEARCH}");
	
	if("${BOARDSITE_NO}" == "2" && "${BOARD_SEQ}" == "515" && "${empty param.SEARCH_SEQ}" == "true" && "${SITE_NO}" == "4"){
		$("#sendForm select[name=SEARCH_SEQ]").val("285");
	} ///????
	
    fn_list();
    
    $(document).on("click",".btn_search",function(){
    	$("#sendForm input:hidden[name=pageNo]").val("1");
    	fn_list();
    });
    
    ui.Accordion.init();

	$(document).on("click",".AccordionBtn",function(){
		ui.Accordion.click(this);
	});
	
});

function fn_list() {

	if($("#sendForm input:hidden[name=pageNo]").val() == ""){
		$("#sendForm input:hidden[name=pageNo]").val("1");
	}
	
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BBSViewFaqList.do",
        data : $("#sendForm").serialize(),
        dataType : "json",
        success : function(data) {
            fn_comm_setList("#tbody", data, "#listTemplate", "#noListTemplate", "#rowCount", ".pagination");
            
            $("#tbody dd > p").each(function(){
                var result = $(this).text();
                $(this).html(result);
            });
        }
    });
}

function linkPage(pageNo){
    $("#sendForm [name='pageNo']").val(pageNo);
    fn_list();
}

function fn_faq_q(obj){
    var Obj = $(obj);
    var idno = $(obj).data("idno");
	var link_yn = $(obj).data("url");
    var flag = $(obj).hasClass("on");
	var file_chk = $(obj).closest(".AccordionBase > li").find(".AccordionBtn").hasClass("chk");
	
    if(!flag&&!file_chk){
	    // 읽기 권한 체크
	    if(link_yn=="Y")
	   	{
    		window.open($("#url"+idno).val(),'_blank');
	   	}
	    else
    	{
	    	fn_comm_ajax({
		        url : "/ajaxf/FR_BBS_SVC/BoardFaqPassCheck.do",
		        data : $("#sendForm").serialize(),
		        dataType : "json",
		        success : function(data) {
		            if(data == 1){
		                alert("권한이 없습니다.");
		                fn_list();
		            }else{
		            	$("#sendForm [name=BBS_SEQ]").val(idno);
		                fn_comm_ajax({
		                    url : "/ajaxf/FR_BBS_SVC/BoardFaqFileList.do",
		                    data : $("#sendForm").serialize(),
		                    dataType : "json",
		                    success : function(data) {
		                    	if(data.length > 0){
		                    		$(Obj).closest(".AccordionBase > li").find(".AccordionFileArea").empty();
			                        for(var i=0; i<data.length; i++){
			                        	var liObj = '<a class="ad_FileDown title="다운로드" href="#;" data-boardseq="'+data[i].BOARD_SEQ+'" data-siteno="'+data[i].SITE_NO+'" data-bbsseq="'+data[i].BBS_SEQ+'" data-fileseq="'+data[i].FILE_SEQ +'"  onclick="fileDown(this);"><span>'+data[i].FILE_ORG_NM+'</span></a>'; //'<button tyep="button" class="btn_preview">미리보기</button></p>';
			                            $(liObj).appendTo($(Obj).closest(".AccordionBase > li").find(".AccordionFileArea"));
			                        }
			                        $(Obj).closest(".AccordionBase > li").find(".AccordionBtn").addClass("chk");
			                        $(Obj).closest(".AccordionBase > li").find(".AccordionFileArea").show();
			                        
		                    	}else{
		                    		$(Obj).closest(".AccordionBase > li").find(".AccordionBtn").addClass("chk");
		                    		$(Obj).closest(".AccordionBase > li").find(".AccordionFileArea").hide();
		                    	}
		                    }
		                });
		            }
		        }
		    });
    	}
	}
	
	return false;
}

function fileDown_BACK(obj){
    var encname = $(obj).data("encname");
    var filename = $(obj).data("filename");
    location.href="/ajax/FR_SVC/FileDownload.do?FILE_ORG_NM="+encodeURIComponent(filename)+"&FILE_NM="+encodeURIComponent(encname);
}

function fileDown(obj){
    location.href="/ajaxfile/FR_SVC/FileDown.do?GBN=X01&BOARD_SEQ="+$(obj).data("boardseq")+"&SITE_NO="+$(obj).data("siteno")+"&BBS_SEQ="+$(obj).data("bbsseq")+"&FILE_SEQ="+$(obj).data("fileseq");
}

function searchEnterkey() {
    if (window.event.keyCode == 13) {
    	$("button.btn_search").trigger("click");
    }
}

</script>
<!-- board -->
<div class="boardCommon">
<div class="board_area">
	<div class="BBS_option <c:if test="${boardConf.USE_CATEGORY_YN eq 'Y' && empty BOARD_CATEGORY_NO}">sel02</c:if>">
		<p class="listNum">총<b id="rowCount">0</b>건</p>
		<form id="sendForm" method="post">
			<input type="hidden" name="pageNo" value="${param.pageNo}"/>
            <input type="hidden" name="MENU_ID" value="${param.MENU_ID}"/>
            <input type="hidden" name="CONTENTS_NO" value="${param.CONTENTS_NO}"/>
            <input type="hidden" name="SITE_NO" value="${BOARDSITE_NO }"/>
            <input type="hidden" name="BOARD_SEQ" value="${BOARD_SEQ }"/>
            <input type="hidden" name="BBS_SEQ" />
            <c:if test="${not empty BOARD_CATEGORY_NO}">
            <input type="hidden" name="SEARCH_SEQ" value="${BOARD_CATEGORY_NO }"/>
            </c:if>
            <input type="text" style="display: none;" title="검색용"/>
            
            <!-- 검색 -->
			<fieldset class="searchBox">
				<legend>검색영역</legend>
				<c:if test="${boardConf.USE_CATEGORY_YN eq 'Y' && empty BOARD_CATEGORY_NO}">
				<select name="SEARCH_SEQ" class="inp_s" title="검색옵션 선택">
					<option value="">전체</option>
					<c:forEach var="list" items="${boardCateList}" varStatus="status">
					<option value="${list.CATE_SEQ }">${list.CATEGORY_NM }</option>
					</c:forEach>
				</select>
				</c:if>
				<select name="SEARCH_FLD" class="inp_s" title="검색옵션 선택">
					<option value="">전체</option>
					<option value="SUBJECT">제목</option>
					<option value="CONTENTS">내용</option>
				</select>
				<div class="search">
					<input type="text" name="SEARCH" class="inputBase" placeholder="검색어를 입력해 주세요." title="검색어 입력" onkeyup="searchEnterkey();" />
					<button class="btn_search" type="button">검색</button>
				</div>
			</fieldset>
		</form>
	</div>

	<div class="bbs_list">
		<ul id="tbody" class="AccordionBase"></ul>
		<script id="noListTemplate" type="text/x-jquery-tmpl">
            <div class="typeNoArticle">
				<p class="no_article">등록된 게시물이 없습니다.</p>
			</div>
        </script>
        <script id="listTemplate" type="text/x-jquery-tmpl">
			<li data-idno="{%= BBS_SEQ %}" data-url="{%= LINK_URL_YN %}" onclick="fn_faq_q(this);">
				<input type="hidden" id="url{%= BBS_SEQ %}" value="{%= LINK_URL %}"/>
					<button type="button" class="AccordionBtn">
						<span style="max-width: calc(100% - 30px);">{%= SUBJECT%}</span>
						{%if NEW_YN == 'Y' %}<i class="ico_new new"><span class="hidden">새글</span></i>{%/if%}
					</button>
					<div class="AccordionCont">
						<div class="AccordionTextArea">
							<p class="txtBody2">{%html CONTENTS %}</p>
						</div>
						<div class="AccordionFileArea" style="display:none">
						</div>
					</div>
			</li>
            </script>
	</div>
	<div class="pagination"></div>
</div>
</div>
