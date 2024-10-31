<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$().ready(function() {
	 
	$("#sendForm select[name=SEARCH_SEQ]").val("${param.SEARCH_SEQ}");
	$("#sendForm [name=SEARCH_FLD]").val("${param.SEARCH_FLD}");
	$("#sendForm [name=SEARCH]").val("${param.SEARCH}");
    fn_list();
    
    $(document).on("click",".btn_search",function(){
    	$("#sendForm input:hidden[name=pageNo]").val("1");
    	fn_list();
    });
    
    $(document).on("click","button.btn_reg",function(){
    	$("#sendForm input:hidden[name=BBS_SEQ]").val("");
    	$("#sendForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardWrite.do");
	    $("#sendForm").submit();
    });
    
});

function fn_list() {
	
	if($("#sendForm input:hidden[name=pageNo]").val() == ""){
		$("#sendForm input:hidden[name=pageNo]").val("1");
	}
	
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BBSViewGalleryList.do",
        data : $("#sendForm").serialize(),
        dataType : "json",
        success : function(data) {
        	if(data != null){
	        	for(var i=0; i<data.list.length; i++){
	        		if(data.list[i].CONTENTS.indexOf('<style>') > -1){
	        			var nTag = data.list[i].CONTENTS.substring(0,data.list[i].CONTENTS.indexOf('<style>'));
	        			nTag += data.list[i].CONTENTS.substring(data.list[i].CONTENTS.indexOf('</style>')+8,data.list[i].CONTENTS.length);
	        			data.list[i].CONTENTS = nTag;
	        		}
	        		data.list[i].CONTENTS = removeTag(data.list[i].CONTENTS);
	        	}
        	}
            fn_comm_setList("#tbody", data, "#listTemplate", "#noListTemplate", "#rowCount", ".pagination");
            
            if("${boardConf.SHOWTYPE}" == "B0302"){
            	$("#tbody li .txt_s").each(function(){
                    var result = $(this).text();
                    $(this).html(result);
                });
            }
        }
    });
}

function removeTag( html ) {
	return html.replace(/(<([^>]+)>)/gi, "");
}

function linkPage(pageNo){
    $("#sendForm [name='pageNo']").val(pageNo);
    fn_list();
}

function searchEnterkey() {
    if (window.event.keyCode == 13) {
    	$("button.btn_search").trigger("click");
    }
}

function viewPage(obj){
	
	if($(obj).parents("li").data("url")=="Y")
	{
		location.href = $("#url"+$(obj).parents("li").data("idno")).val();
	}
	else
	{
		
		$("#sendForm input:hidden[name=BBS_SEQ]").val($(obj).parents("li").data("idno"));
	   	$("#sendForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardView.do");
		$("#sendForm").submit();
	}
	
}

</script>
<!-- board -->
<div class="boardCommon">
<div class="board_area">
	<!-- 리스트 옵션 -->
	<div class="BBS_option <c:if test="${boardConf.USE_CATEGORY_YN eq 'Y'}">sel02</c:if>">
		<p class="listNum">총<b id="rowCount">0</b>건</p>

		<!-- 검색 -->
		<form id="sendForm" method="post">
			<input type="hidden" name="pageNo" id="pageNo" value="${param.pageNo}"/>
            <input type="hidden" name="pagePerCnt" value="${boardConf.PAGE_LEN }"/>
            <input type="hidden" name="MENU_ID" id="MENU_ID" value="${param.MENU_ID}"/>
            <input type="hidden" name="CONTENTS_NO" value="${param.CONTENTS_NO}"/>
            <input type="hidden" name="SITE_NO" value="${BOARDSITE_NO }"/>
            <input type="hidden" name="BOARD_SEQ" value="${BOARD_SEQ }"/>
            <input type="hidden" name="BBS_SEQ" />
            <c:if test="${not empty BOARD_CATEGORY_NO}">
            <input type="hidden" name="SEARCH_SEQ" value="${BOARD_CATEGORY_NO }"/>
            </c:if>
            <input type="hidden" name="PWD" />
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
					<option value="WRITER">작성자명</option>
				</select>
				<div class="search">
					<input type="text" name="SEARCH" class="inputBase" placeholder="검색어를 입력해 주세요." title="검색어 입력" onkeyup="searchEnterkey();" />
					<button class="btn_search" type="button">검색</button>
				</div>
			</fieldset>
		</form>
		<!-- //검색 -->
	</div>
	<!-- //리스트 옵션 -->
	<div class="BBSgallery <c:if test="${boardConf.SHOWTYPE eq 'B0302'}">BBSthumb Thumbnail</c:if><c:if test="${boardConf.SHOWTYPE ne 'B0302'}">rowDtl</c:if>">
		<ul id="tbody"></ul>
		<script id="noListTemplate" type="text/x-jquery-tmpl">
			<li class="typeNoArticle">
				<p class="no_article">등록된 게시물이 없습니다.</p>
			</li>
		</script>
		<script id="listTemplate" type="text/x-jquery-tmpl">
			<li data-idno="{%= BBS_SEQ%}" data-html="{%= HTML_YN %}" data-url="{%= LINK_URL_YN %}">
				<input type="hidden" id="url{%= BBS_SEQ%}" value="{%= LINK_URL%}"/>
				<div class="photo <c:if test="${boardConf.SHOWTYPE eq 'B0302'}">ThumbnailArea</c:if>">
				{%if HTML_YN == 'Y' %}<a href="{%= VIDEO_URL %}" target="_blank" {%if CONTS_GBN == 'B0102' %} class="btn_play"{%/if%} title="새창열림">{%/if%}
				{%if HTML_YN != 'Y' %}<a href="#;" {%if CONTS_GBN == 'B0102' %} class="btn_play"{%/if%} onclick="viewPage(this);" title="상세이동">{%/if%}
						<img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X02&SITE_NO={%= SITE_NO %}&BOARD_SEQ={%= BOARD_SEQ %}&BBS_SEQ={%= BBS_SEQ %}" alt="{%= SUBJECT %}"/>
				</a>
				</div>
				<div class="infoArea">
					<c:if test="${boardConf.USE_CATEGORY_YN eq 'Y'}">
						<span class="cag">{%= CATEGORY_NM %}</span>
					</c:if>
					{%if HTML_YN == 'Y' %}<a href="{%= VIDEO_URL %}" target="_blank" title="새창열림">{%/if%}
					{%if HTML_YN != 'Y' %}<a href="#;" onclick="viewPage(this);" title="상세이동" class="noticeTitle">{%/if%}
						<p style="max-width: calc(100% - 116.031px);">{%= SUBJECT%}</p>
						<c:if test="${boardConf.USE_COMMENT_YN eq 'Y'}"><i class="ripple">{%if COMMENT_CNT > 0 %}[{%= COMMENT_CNT %}]{%/if%}</i></c:if>
						{%if NEW_YN == 'Y' %}<i class="ico_new new"><span class="hidden">새글</span></i>{%/if%}
						<!-- {%if SECRET_YN == 'Y' %}<span class="ico_lock" alt="비밀글" >[비밀글]</span>{%/if%} -->
					</a>
				<p class="txt_s noticeText">{%= CONTENTS %}</p>
				<div class="noticeInfo">
					<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><span class="writer">{%= WRITER_NM %}</span></c:if>
                	<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><span class="date">{%= WRITE_DATE %}</span></c:if>
					<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><span class="view">조회 {%= HITS %}</span></c:if>
				</div>
				</div>
			</li>
		</script>
	</div>
	<!-- //리스트 -->
	<div class="pagination"></div>
	
	<c:if test="${AUTH_WRITE_PASS}">
	<!-- 버튼영역 -->
	<div class="btn_Area paging_R btn_Area_R">
		<button type="button" class="baseBtn large btn_reg"><span class="base">등록</span></button>
	</div>
	<!-- //버튼영역 -->
	</c:if>
</div>
</div>
<!-- //board -->