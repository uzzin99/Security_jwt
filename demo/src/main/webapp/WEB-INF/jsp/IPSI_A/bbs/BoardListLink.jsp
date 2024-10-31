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
        	if("${boardConf.SHOWTYPE}" == "B0303"){
        		$(".BBSgallery").show();
        		$(".BBSlist").hide();
        		fn_comm_setList("#tbody2", data, "#listTemplate${boardConf.SHOWTYPE}", "#noListTemplate2", "#rowCount", ".pagination");
               	$("#tbody2 li .txt_s").each(function(){
					var result = $(this).text();
					$(this).html(result);
				});
        	}else{
        		$(".BBSlist").show();
        		$(".BBSgallery").hide();
        		fn_comm_setList(".BBSlist #tbody", data, "#listTemplate${boardConf.SHOWTYPE}", "#noListTemplate1", "#rowCount", ".pagination");
        		if(data.list.length == 0) $("td.typeNoArticle").attr("colspan",$(".BBSlist thead th").length);
        	}
        }
    });
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

	<!-- 리스트 -->
	<table class="BBSlist board_table default_table<c:if test="${boardConf.SHOWTYPE eq 'B0301'}"> link_table</c:if><c:if test="${boardConf.SHOWTYPE eq 'B0302'}"> BBSphoto photo_table</c:if>">
		<caption>${MENU_NM} - 번호 <c:if test="${boardConf.USE_CATEGORY_YN eq 'Y'}">,구분</c:if><c:if test="${boardConf.SHOWTYPE eq 'B0302'}">,이미지</c:if>,제목<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}">,작성자</c:if><c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}">,등록일</c:if><c:if test="${boardConf.USE_HITS_YN eq 'Y'}">,조회수</c:if>를 확인하실 수 있는 표</caption>
		<colgroup>
			<col /><col />
			<c:if test="${boardConf.SHOWTYPE eq 'B0302'}"><col /></c:if>
			<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><col /></c:if>
			<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><col /></c:if>
			<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><col /></c:if>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="headNum">번호</th>
				<c:if test="${boardConf.SHOWTYPE eq 'B0302'}"><th scope="col" class="headPhoto">이미지</th></c:if>
				<th scope="col" class="headTxt">제목</th>
				<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><th scope="col" class="headWriter">작성자</th></c:if>
				<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><th scope="col" class="headDate">등록일</th></c:if>
				<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><th scope="col" class="headView">조회수</th></c:if>
			</tr>
		</thead>
		<tbody id="tbody"></tbody>
			<script id="noListTemplate1" type="text/x-jquery-tmpl">
                <tr class="noArticle">
                	<td colspan="6" class="typeNoArticle">
						<p class="no_article">등록된 게시물이 없습니다.</p>
					</td>
                </tr>
            </script>
			<script id="listTemplateB0301" type="text/x-jquery-tmpl">
                <tr class="{%if TOP_YN == 'Y' %}typeNoti{%/if%} {%if CATE_SEQ != '' %}typeCateg{%/if%}">
                    {%if TOP_YN == 'Y' %}<td><span>공지</span></td>{%/if%}
                    {%if TOP_YN == 'N' %}<td class="tbodyNum"><span>{%= RNUM_DESC%}</span></td>{%/if%}
                    <td class="txtL tbodyTitle" title="{%= SUBJECT%}">
                    <a href="{%= LINK_URL %}" target="_blank" title="새창열림">{%= SUBJECT%}</a>
                    {%if NEW_YN == 'Y' %}<span alt="새글" class="ico_new">[새글]</span>{%/if%}
                    </td>
					<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><td class="tbodyWriter" data-cell-header="작성자 : " title="{%= WRITER_NM %}"><span class="writer">{%= WRITER_NM %}</span></td></c:if>
                	<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><td class="tbodyDate" data-cell-header="등록일 : "><span class="date">{%= WRITE_DATE %}</span></td></c:if>
					<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><td class="tbodyView" data-cell-header="조회수 : "><span class="view">{%= HITS %}</span></td></c:if>
                </tr>
            </script>
			<script id="listTemplateB0302" type="text/x-jquery-tmpl">
                <tr class="{%if TOP_YN == 'Y' %}typeNoti{%/if%} {%if CATE_SEQ != '' %}typeCateg{%/if%}">
                    {%if TOP_YN == 'Y' %}<td><span>공지</span></td>{%/if%}
                    {%if TOP_YN == 'N' %}<td class="tbodyNum"><span>{%= RNUM_DESC%}</span></td>{%/if%}
					<td class="photo"><a href="{%= LINK_URL %}" target="_blank" title="새창열림"><img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X02&SITE_NO={%= SITE_NO %}&BOARD_SEQ={%= BOARD_SEQ %}&BBS_SEQ={%= BBS_SEQ %}" alt="{%= SUBJECT %}" /></a></td>
                    <td class="txtL tbodyTitle" title="{%= SUBJECT%}">
                    <a href="{%= LINK_URL %}" target="_blank" title="새창열림">{%= SUBJECT%}</a>
                    {%if NEW_YN == 'Y' %}<span alt="새글" class="ico_new">[새글]</span>{%/if%}
                    </td>
				<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><td class="tbodyWriter" data-cell-header="작성자 : " title="{%= WRITER_NM %}"><span class="writer">{%= WRITER_NM %}</span></td></c:if>
                <c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><td class="tbodyDate" data-cell-header="등록일 : "><span class="date">{%= WRITE_DATE %}</span></td></c:if>
				<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><td class="tbodyView" data-cell-header="조회수 : "><span class="view">{%= HITS %}</span></td></c:if>
                </tr>
            </script>
	</table>
	<div class="BBSgallery rowDtl link_gallery">
		<ul id="tbody2"></ul>
		<script id="noListTemplate2" type="text/x-jquery-tmpl">
			<li class="typeNoArticle">
				<p class="no_article">등록된 게시물이 없습니다.</p>
			</li>
		</script>
		<script id="listTemplateB0303" type="text/x-jquery-tmpl">
			<li>
				<div class="photo">
					<a href="{%= LINK_URL %}" target="_blank" title="새창열림"><img src="/ajaxfile/CMN_SVC/FileView.do?GBN=X02&SITE_NO={%= SITE_NO %}&BOARD_SEQ={%= BOARD_SEQ %}&BBS_SEQ={%= BBS_SEQ %}" alt="{%= SUBJECT %}" /></a>
				</div>
				<div class="txtL infoArea">
					<a href="{%= LINK_URL %}" target="_blank" title="새창열림" class="noticeTitle">
						<p>{%= SUBJECT%}</p>
					</a>
				<!--{%if NEW_YN == 'Y' %}<span alt="새글" class="ico_new">[새글]</span>{%/if%}-->
					<div class="noticeInfo">
						<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><span class="writer">{%= WRITER_NM %}</span></c:if>
                		<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><span class="date">{%= WRITE_DATE %}</span></c:if>
						<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><span class="view">조회수 {%= HITS %}</span></c:if>
					</div>
				</div>
			</li>
		</script>
	</div>
	<!-- //리스트 -->
	<div class="pagination"></div>
</div>
</div>
<!-- //board -->