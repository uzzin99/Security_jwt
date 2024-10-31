<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<script>
$().ready(function() {

	$("#sendForm select[name=SEARCH_SEQ]").val("${param.SEARCH_SEQ}");
	$("#sendForm [name=SEARCH_FLD]").val("${param.SEARCH_FLD}");
	$("#sendForm [name=SEARCH]").val(decodeURI("${param.SEARCH}"));
	
    fn_list();
    
    $(document).on("click",".btn_search",function(){
    	$("#sendForm input:hidden[name=pageNo]").val("1");
    	fn_list();
    });
    
    $(document).on("click","button.btn_reg",function(){
    	$("#sendForm input:hidden[name=BBS_SEQ]").val("");
		location.href = "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardWrite.do?"+$("#sendForm").serialize();
    });
    
    $(document).on("click","td.txtL > a",function(){
    	var bbs_seq = $(this).data("idno");
    	var link_yn = $(this).data("url");
    	var url = $(this).attr("href");
    	
    	$(this).attr("href","#;");
    	
    	$("#sendForm input:hidden[name=BBS_SEQ]").val(bbs_seq);
        fn_comm_ajax({
            url : "/ajaxf/FR_BBS_SVC/BBSChecking.do",
            data : $("#sendForm").serialize(),
            dataType : "json",
            success : function(data) {
                if(data == 0){
                    alert("비밀글입니다.");
                }else if(data == 1){

                	if(link_yn=="Y")
               		{
               			location.href=url;
               		}
                	else
               		{
                	    location.href = "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardView.do?"+encodeURI($("#sendForm").serialize());
               		}
                	
                }else if(data == 2){
                	alert("권한이 없습니다.");
                }else {
                	ifrPop('PwdPop','${(not empty BASE_PATH && BASE_PATH != "")?"/":""}${BASE_PATH}/cms/FR_BBS_CON/PwdChkPop.do?SITE_NO='+$("#sendForm [name=SITE_NO]").val()+'&BOARD_SEQ='+$("#sendForm [name=BOARD_SEQ]").val()+'&BBS_SEQ='+$("#sendForm [name=BBS_SEQ]").val());
                    return;
                }
            }
        });
    });
    
});

function fn_view(pwd){
	$("#sendForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_BBS_CON/BoardView.do");
	$("#sendForm [name=PWD]").val(pwd);
    $("#sendForm").submit();
}

function fn_list() {
	
	if($("#sendForm input:hidden[name=pageNo]").val() == ""){
		$("#sendForm input:hidden[name=pageNo]").val("1");
	}
	
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BBSViewList.do",
        data : $("#sendForm").serialize(),
        dataType : "json",
        success : function(data) {
            fn_comm_setList("#tbody", data, "#listTemplate", "#noListTemplate", "#rowCount", ".pagination");
            if($("#tbody .typeNoArticle").length > 0){
            	$("#tbody .typeNoArticle").prop("colspan", $(".BBSlist thead th").length);
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
	<div class="BBS_option <c:if test="${boardConf.USE_CATEGORY_YN eq 'Y' && empty BOARD_CATEGORY_NO}">sel02</c:if>">
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
					<!-- <option value="SC">제목+내용</option> -->
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
	<table class="BBSlist board_table default_table">
		<caption>일반게시판</caption>
		<colgroup>
			<col />
			<col />
			<c:if test="${boardConf.USE_ATTACH_YN eq 'Y'}"><col /></c:if>
			<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><col /></c:if>
			<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><col /></c:if>
			<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><col /></c:if>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="headNum">번호</th>
				<th scope="col" class="headTxt">제목</th>
				<c:if test="${boardConf.USE_ATTACH_YN eq 'Y'}"><th scope="col" class="headFile">첨부파일</th></c:if>
				<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><th scope="col" class="headWriter">작성자</th></c:if>
				<c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><th scope="col" class="headDate">등록일</th></c:if>
				<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><th scope="col" class="headView">조회수</th></c:if>
			</tr>
		</thead>
		<tbody id="tbody"></tbody>
			<script id="noListTemplate" type="text/x-jquery-tmpl">
                <tr>
                	<td colspan="6" class="typeNoArticle">
						<p class="no_article">등록된 게시물이 없습니다.</p>
					</td>
                </tr>
            </script>
			<!--
				### tr에 추가되는 class ###
				*공지 추가 : typeNoti
				*항목 추가 : typeCateg
				*아이콘 추가 : typeIco
				*첨부파일 추가 : typeFile
				*답변 추가 : typeAns
			 -->
			<script id="listTemplate" type="text/x-jquery-tmpl">
                <tr class="{%if TOP_YN == 'Y' %}typeNoti{%/if%} {%if SECRET_YN == 'Y'|| NEW_YN == 'Y'%}typeIco{%/if%} {%if LVL > 1 %}typeReply{%/if%} {%if CATE_SEQ != '' %}typeCateg{%/if%} {%if FILE_CNT > 0 %}typeFile{%/if%} {%if NEW_YN == 'Y' %}typeIco{%/if%}">
                    {%if TOP_YN == 'Y' %}<td class="tbodyNum"><span>공지</span></td>{%/if%}
                    {%if TOP_YN == 'N' %}<td class="tbodyCateg"><span>{%= RNUM_DESC%}</span></td>{%/if%}
                    <td class="txtL tbodyTitle" title="{%= SUBJECT%}">
                        <a href="{%= LINK_URL%}" data-idno="{%= BBS_SEQ%}" data-url="{%= LINK_URL_YN%}" title="상세이동">{%= SUBJECT%}</a>
                    {%if SECRET_YN == 'Y' %}<span class="ico_lock" alt="비밀글" >[비밀글]</span>{%/if%}
                    {%if NEW_YN == 'Y' %}<span alt="새글" class="ico_new">[새글]</span>{%/if%}
				<c:if test="${boardConf.USE_COMMENT_YN eq 'Y'}">	
                    {%if COMMENT_CNT > 0 %}<span class="answer">[{%= COMMENT_CNT %}]</span>{%/if%}
				</c:if>
                    </td>
                <c:if test="${boardConf.USE_ATTACH_YN eq 'Y' }">
                    <td class="tbodyFile" title="첨부파일">
                        <div class="hasArea">
                        {%if FILE_CNT > 0 %}
                            <div class="hasfile" style="cursor:default;">첨부파일</div>
                            <span class="hasfileNum"><span>{%= FILE_CNT %}</span></span>
                        {%/if%}
                        </div>
                    </td>
                </c:if>
				<c:if test="${boardConf.USE_USERINFO_YN eq 'Y'}"><td class="tbodyWriter" data-cell-header="작성자 : " title="{%= WRITER_NM %}"><span class="writer">{%= WRITER_NM %}</span></td></c:if>
                <c:if test="${boardConf.USE_REG_DT_YN eq 'Y'}"><td class="tbodyDate" data-cell-header="등록일 : "><span class="date">{%= WRITE_DATE %}</span></td></c:if>
				<c:if test="${boardConf.USE_HITS_YN eq 'Y'}"><td class="tbodyView" data-cell-header="조회수 : "><span class="view">{%= HITS %}</span></td></c:if>
                </tr>
            </script>
	</table>
	
	<!-- //리스트 -->
	<div class="pagination"></div>
	
	<c:if test="${AUTH_WRITE_PASS}">
	<!-- 버튼영역 -->
	<div class="btn_Area paging_R btn_Area_R">
		<button type="button" class="baseBtn large btn_reg"><span class="base">문의하기</span></button>
	</div>
	<!-- //버튼영역 -->
	</c:if>
	
</div>
</div>
<!-- //board -->