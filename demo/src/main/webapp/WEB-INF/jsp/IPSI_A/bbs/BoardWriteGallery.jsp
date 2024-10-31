<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')" var="fileExt" />
<script>
$().ready(function() {
	if("${boardConf.BOARD_TYPE}"=="C0302")
	{
    	$("tr.tr_video").hide();
    	$("tr.tr_video input, tr.tr_video textarea").prop("disabled",true);
    	$("[name=CONTS_GBN]").val("B0101");
	}
	else if("${boardConf.BOARD_TYPE}"=="C0308")
	{
		$("#IMG_FILE>th>span").hide();
    	$("tr.tr_video").show();
    	$("tr.tr_video input, tr.tr_video textarea").prop("disabled",false);
    	$("[name=CONTS_GBN]").val("B0102");
	}
	
	$("#pageTab").remove();
	
	$(document).on('click', '.toggleBtn', function(e) {
		e.preventDefault();
    });
	
	$(document).on('change', 'select[name=EMAIL_GBN]', function() {
		$("input:text[name=EMAIL2]").val($(this).val());
    });
	$(document).on('click', 'button.btn_fileAdd', function() {
		var fileGbn = $(this).parents("tr").attr("id");
		
		if(fileGbn == "ATTACH_FILE" && Number("${boardConf.FILE_LIMIT}") <= $("tr.w_addFile_m td.fileArea .formInput").length){
			alert("최대 ${boardConf.FILE_LIMIT}개 까지 첨부할수 있습니다.");
			return;
		}
		
		var fileObj = '<div class="formInput file"><div class="fileAdd">'
		+'<input type="text" name="FILE_NM" class="inputBase" readonly="readonly" title="첨부파일'+($("tr.w_addFile_m td.fileArea .formInput").length+1)+'" value="파일선택"/>'
		+'<label class="baseBtn medium"><span class="base">찾아보기</span>'
		+'<input type="file" name="'+fileGbn+'_OBJNEW" onchange="changeFile(this);" title="첨부파일 찾아보기'+($("tr.w_addFile_m td.fileArea .formInput").length+1)+'" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>">'
		+'</lable></div><div class="fileCont">'
		+'<button type="button" class="controlBtn plus btn_fileAdd"><span class="hidden">파일추가</span></button>'
		+'<button type="button" class="controlBtn reset btn_fileDel"><span class="hidden">파일삭제</span></button>'
		+'</div></div>';
        
		$(fileObj).appendTo($("tr#"+fileGbn+" td.fileArea .fildArea"));
    });
	
	$(document).on('click', 'button.btn_fileDel', function() {
		var fileGbn = $(this).parents("tr").attr("id");
		if($("tr#"+fileGbn+" td.fileArea .formInput").length <= 1) {
			
			$(this).closest(".formInput").remove();
			
			fileAreaObj = '<div class="formInput file"><div class="fileAdd">';
			fileAreaObj += '<input type="text" name="FILE_NM" class="inputBase" readonly="readonly" title="첨부파일" value="파일선택" style="caret-color: transparent;"/>';
			fileAreaObj += '<label class="baseBtn medium"><span class="base">찾아보기</span>';
			fileAreaObj += '<input type="file" name="ATTACH_FILE_OBJNEW" onchange="changeFile(this);" title="첨부파일 찾아보기" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>"/>';
			fileAreaObj += '</label></div>';
			fileAreaObj += '<div class="fileCont">';
			fileAreaObj += '<button type="button" class="controlBtn plus btn_fileAdd"><span class="hidden">파일추가</span></button>';
			fileAreaObj += '<button type="button" class="controlBtn reset btn_fileDel"><span class="hidden">파일삭제</span></button>';
			fileAreaObj += '</div></div>';
			
			$(fileAreaObj).appendTo($(".fildArea"));
		}else {
			$(this).closest(".formInput").remove();
		}
    });
	
	$(document).on("click","button.btn_cancel",function(){
		$("#listForm").attr("action", "${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_CON/index.do");
	    $("#listForm").submit();
	});
	
	$(document).on('click', 'button.goSave', function() {
		//validation check
		if("${boardConf.USE_CATEGORY_YN}" == "Y"){
	    	if($(".toggleBtn").val() == "" ){
	    		alert("구분을 선택하세요.");
                return;
            }
	    	$("[name=CATE_SEQ]").val($(".toggleBtn").val());
        }
		
		if($("#sendForm [name=PASSWD]").val() == ""){
               alert('확인번호를 입력하세요.');
               $("#sendForm [name=PASSWD]").focus();
               return;
           }
		
		if($("#sendForm input:text[name=WRITER_NM]").val() == ""){
	        alert('작성자를 입력하세요.');
	        $("#sendForm input:text[name=WRITER_NM]").focus();
	        return;
	    }
	    
	    if($("#sendForm input:text[name=SUBJECT]").val().trim() == ""){
	        alert('제목을 입력하세요.');
	        $("#sendForm input:text[name=SUBJECT]").focus();
	        return;
	    }
	    
	    if($("textarea[name=CONTENTS]").val().trim() == ""){
            alert("내용을 입력하세요.");
            return;
        }
	    
		if("${boardConf.BOARD_TYPE}"=="C0308"){
			if($("#sendForm [name=VIDEO_URL]").val() == ""){
				alert("URL을 입력하세요.");
				return;
			}
		}
		
	    if( "${boardConf.BOARD_TYPE}" == "C0302"){
	    	if($("#sendForm input:text[id=IMGFILE]").val() == "" ){
	    		alert("썸네일이미지를 입력하세요.");
                return;
            }
	    }
	    
	    if(!confirm("저장하시겠습니까?")) {
	        return;
	    }
	    
	    fn_comm_ajax({
	        url : "/ajaxf/FR_BBS_SVC/BoardQnaDetailSave.do",
	        ajaxFormName : 'sendForm',
	        async : false,
	        dataType : "json",
	        success : function(data) {
	            if(data == 1){
	                alert("저장되었습니다.");
	                location.href="${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_CON/index.do?MENU_ID=${param.MENU_ID}&CONTENTS_NO=${CONTENTS_NO}&SEARCH_SEQ=${param.SEARCH_SEQ}&SEARCH_FLD=${param.SEARCH_FLD}&SEARCH=" + encodeURI("${param.SEARCH}");//encodeURI(encodeURIComponent("${param.SEARCH}"));
	            }else if(data == 2){
	            	alert("권한이 없습니다.");
	            	location.href="${(not empty BASE_PATH && BASE_PATH != '')?'/':''}${BASE_PATH}/cms/FR_CON/index.do?MENU_ID=${param.MENU_ID}&CONTENTS_NO=${CONTENTS_NO}&SEARCH_SEQ=${param.SEARCH_SEQ}&SEARCH_FLD=${param.SEARCH_FLD}&SEARCH=" + encodeURI("${param.SEARCH}");//encodeURI(encodeURIComponent("${param.SEARCH}"));
	            }else if(data == 3){
	            	alert("불량단어가 포함되어 있습니다.");
	            }else if(data == 4){
	            	alert("첨부파일 용량이 너무 큽니다.");
	            }else if(data == 5){
	            	alert("등록할 수 없는 파일입니다.");
	            }else{
	                alert("저장에 실패했습니다. 관리자에 문의하세요.");
	            }
	        }
	    });
    });
	
	fn_detail();
	
});

function fn_detail(){
    if($("#sendForm input:hidden[name=BBS_SEQ]").val() == ''){
        return;
    }
    
    fn_comm_ajax({
        url : "/ajaxf/FR_BBS_SVC/BoardViewData.do",
        data : $("#sendForm").serialize(),
        
        dataType : "json",
        success : function(data) {
            
            $("#sendForm").fn_comm_setValue(data);
            
			if($("#sendForm .toggleBtn").length > 0) {
				$("#sendForm .toggleBtn > span").html(data.CATE_NM);
				$("#sendForm .toggleBtn").val(data.CATE_SEQ);
			}
            
            var emailArr = "";
            if ( data.EMAIL != null && data.EMAIL != '' ) {
            	emailArr = data.EMAIL.split('@');
            	
	            if(emailArr.length == 2){
		            $("#sendForm input:text[name=EMAIL1]").val(emailArr[0]);
		            $("#sendForm input:text[name=EMAIL2]").val(emailArr[1]);
	            }
            } else {
            	$("#sendForm input:text[name=EMAIL1]").val("");
	            $("#sendForm input:text[name=EMAIL2]").val("");
            }
            
            if("${boardConf.BOARD_TYPE}" == "C0302"){
            	$("#CN").val(data.CONTENTS);
                CrossEditor.SetBodyValue(data.CONTENTS);
            }else{
            	$("#sendForm textarea[name=CONTENTS]").val(data.CONTENTS);
            }
        }
    });
}

function changeFile(obj){
    var fileName = $(obj).val();
    fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
    fileName = fileName.substring(fileName.lastIndexOf("/")+1);
    
    var fileExt = "${fileExt}".replace(/\s+/g, '').split(",");
    var ext = fileName.split('.').pop().toLowerCase();
    if($.inArray("."+ext, fileExt) == -1) {
	     alert('등록 할수 없는 파일입니다.');
	     return;
	}
    
    if(fileName != "") {
        var $parent = $(obj).parent().parent();
        $parent.find("[name='FILE_NM']").val(fileName);
        $parent.find("[name='FILE_NM']").attr('title',fileName);
    }
}

function captchaCB(){
	$("#sendForm input:hidden[name=captchaYn]").val("Y");
}
function captchaEXCB(){
	$("#sendForm input:hidden[name=captchaYn]").val("N");
}

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

</script>
<div class="boardCommon">
<div class="board_area">
<form id="listForm" method="post">
	<input type="hidden" name="MENU_ID" id="MENU_ID" value="${param.MENU_ID}"/>
    <input type="hidden" name="CONTENTS_NO" value="${param.CONTENTS_NO}"/>
    <input type="hidden" name="SITE_NO" value="${param.SITE_NO}"/>
    <input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ}"/>
    <input type="hidden" name="BBS_SEQ" value="${param.BBS_SEQ}"/>
    <input type="hidden" name="SEARCH_SEQ" value="${param.SEARCH_SEQ}"/>
    <input type="hidden" name="SEARCH_FLD" value="${param.SEARCH_FLD}"/>
    <input type="hidden" name="SEARCH" value="${param.SEARCH}"/>
    <input type="hidden" name="pageNo" id="pageNo" value="${param.pageNo}"/>
</form>
<form id="sendForm" method="post">
    <input type="hidden" name="MENU_ID" id="MENU_ID" value="${param.MENU_ID}"/>
    <input type="hidden" name="CONTENTS_NO" value="${param.CONTENTS_NO}"/>
    <input type="hidden" name="SITE_NO" value="${param.SITE_NO}"/>
    <input type="hidden" name="BOARD_SEQ" value="${param.BOARD_SEQ}"/>
    <input type="hidden" name="BBS_SEQ" value="${param.BBS_SEQ}"/>
    <input type="hidden" name="SEARCH_SEQ" value="${param.SEARCH_SEQ}"/>
    <input type="hidden" name="SEARCH_FLD" value="${param.SEARCH_FLD}"/>
    <input type="hidden" name="SEARCH" value="${param.SEARCH}"/>
    <input type="hidden" name="pageNo" id="pageNo" value="${param.pageNo}"/>
    <input type="hidden" name="CONTS_GBN"/>
    <input type="hidden" name="captchaYn" value="N"/>
    
    <div class="applyTable qna_write_table">
	    <p class="list_guide"><span class="mark_need">[필수]</span> 필수 입력항목 입니다.</p>
	    <div class="lineTop_tbArea">
			<table class="lineTop_tbL2">
				<!-- 구성 항목에 맞게 caption 내용 수정 필요 -->
				<caption><p>${MENU_NM} 게시판 글쓰기 - 공개여부, 확인번호, 작성자, 제목, 내용<c:if test="${boardConf.USE_ATTACH_YN eq 'Y' }">, 첨부파일</c:if>을 작성하실 수 있는 표</p></caption>
				<colgroup>
					<col width="200px">
					<col >
					<col width="200px" >
					<col >
				</colgroup>
				<tbody>
				<c:if test="${ boardConf.USE_CATEGORY_YN eq 'Y' }">
					<tr>
						<th scope="row"><span class="mark_need">[필수]</span> 구분</th>
						<td colspan="3" class="txtL">
							<div class="selectBase admis_i" data-id="select">
								<input type="hidden" name="CATE_SEQ"/>
								<button class="toggleBtn" value="<c:if test="${not empty BOARD_CATEGORY_NO }">${BOARD_CATEGORY_NO }</c:if>">
									<c:choose>
										<c:when test="${not empty BOARD_CATEGORY_NO }">
											<c:forEach var="list" items="${boardCateList }">
												<c:if test="${BOARD_CATEGORY_NO eq list.CATE_SEQ }">
													<span class="base">${list.CATEGORY_NM }</span>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<span class="base">선택</span>
										</c:otherwise>
									</c:choose>
								</button>
								<div class="option">
									<c:forEach var="list" items="${boardCateList }">
										<button type="button" value="${list.CATE_SEQ }"><span class="base">${list.CATEGORY_NM }</span></button>
									</c:forEach>
								</div>
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<th scope="row"><span class="mark_need">[필수]</span> 확인번호</th>
					<td colspan="3" class="txtL">
						<input class="inputBase admis_i" type="password" maxlength="4" title="확인번호 입력" name="PASSWD" autocomplete="off" oninput="maxLengthCheck(this)" data-constr="num">
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="mark_need">[필수]</span> 작성자</th>
					<td colspan="3" class="txtL">
						<input class="inputBase admis_i" type="text" title="작성자 입력" name="WRITER_NM" maxlength="20" oninput="maxLengthBlankCheck(this)" data-constr="">
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="mark_need">[필수]</span> 제목</th>
					<td colspan="3" class="txtL">
						<input class="inputBase" type="text" title="제목 입력" name="SUBJECT" maxlength="80" oninput="maxLengthCheck(this)">
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="mark_need"></span> 내용</th>
					<td colspan="3" class="txtL"> 
						<textarea name="CONTENTS" rows="7" class="inputTextarea" title="내용을 입력해주세요"></textarea>
					</td>
				</tr>
				
				<tr class="tr_video">
					<th scope="row"><span class="mark_need">[필수]</span> URL</th>
					<td colspan="3" class="txtL">
						<input type="text" class="inputBase" name="VIDEO_URL" maxlength="80" title="동영상 URL"/>
					</td>
				</tr>
				
				<tr class="tr_video w_txt">
					<th scope="row"><span class="mark_need"></span> 자막</th>
					<td colspan="3" class="txtL">
						<textarea class="inputTextarea" name="VALUE3" class="inp_t" title="자막 입력창" rows="7"></textarea>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="mark_need" title="필수 입력 항목 표시"></span> 썸네일</th>
					<td colspan="3" class="txtL fileArea">
					<fieldset class="fildArea">
						<legend class="hidden">첨부파일 영역</legend>
						<c:if test="${empty boardImgFileList }">
							<div class="formInput file">
									<div class="fileAdd">
									<input type="text" name="FILE_NM" id="IMGFILE" class="inputBase" readonly="readonly" title="첨부파일" value="파일선택"/>
									<label class="baseBtn medium">
										<span class="base">찾아보기</span>
										<input type="file" name="IMG_FILE_OBJNEW" onchange="changeFile(this);" title="첨부파일 찾아보기" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>"/>
									</label>
								</div>
							</div>
						</c:if>
						<c:forEach var="list" items="${boardImgFileList }" varStatus="status">
							<div class="formInput file">
								<div class="fileAdd">
									<input type="hidden" name="FILE_SEQ" value="${list.FILE_SEQ }"/>
									<input type="text" name="FILE_NM" class="inputBase" readonly="readonly" value="${list.FILE_ORG_NM }" title="파일 이름 : ${list.FILE_ORG_NM }"/>
									
									<label class="baseBtn medium">
										<span class="base">찾아보기</span>
										<input type="file" name="IMG_FILE_OBJ${list.FILE_SEQ }" onchange="changeFile(this);" title="첨부파일 찾아보기" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>"/>
									</label>
								</div>
							</div>
						</c:forEach>
					</fieldset>
					</td>
				</tr>
				<c:if test="${boardConf.USE_ATTACH_YN eq 'Y' }">
					<tr class="w_addFile_m" id="ATTACH_FILE">
						<th scope="row"><span></span> 첨부파일</th>
						<td colspan="3" class="txtL fileArea">
							<fieldset class="fildArea">
								<legend class="hidden">첨부파일 영역</legend>
								<c:if test="${empty boardFileList }">
									<div class="formInput file">
										<div class="fileAdd">
											<input type="text" name="FILE_NM" class="inputBase" readonly="readonly" title="첨부파일" value="파일선택"/>
											<label class="baseBtn medium">
												<span class="base">찾아보기</span>
												<input type="file" name="ATTACH_FILE_OBJNEW" onchange="changeFile(this);" title="첨부파일 찾아보기" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>"/>
											</label>
										</div>
										<div class="fileCont">
											<button type="button" class="controlBtn plus btn_fileAdd"><span class="hidden">파일추가</span></button>
											<button type="button" class="controlBtn reset btn_fileDel"><span class="hidden">파일삭제</span></button>
										</div>
									</div>
								</c:if>
								<c:forEach var="list" items="${boardFileList}" varStatus="status">
									<div class="formInput file">
										<div class="fileAdd">
											<input type="hidden" name="FILE_SEQ" value="${list.FILE_SEQ }"/>
											<input type="text" name="FILE_NM" class="inputBase" readonly="readonly" title="파일 이름 : ${list.FILE_ORG_NM }" readonly="readonly" value="${list.FILE_ORG_NM }"/>
											<label class="baseBtn medium">
												<span class="base">찾아보기</span>
												<input type="file" name="ATTACH_FILE_OBJ${list.FILE_SEQ }" onchange="changeFile(this);" title="첨부파일 찾아보기${status.count}" accept="<spring:eval expression="@fileProperties.getProperty('Globals.PERMIT.EXT')"></spring:eval>"/>
											</label>
										</div>
										<div class="fileCont">
											<button type="button" class="controlBtn plus btn_fileAdd"><span class="hidden">파일추가</span></button>
											<button type="button" class="controlBtn reset btn_fileDel"><span class="hidden">파일삭제</span></button>
										</div>
									</div>
								</c:forEach>
							</fieldset>
						</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</form>
<!-- 버튼영역 -->
<div class="btn_Area btn_Area_R">
	<button type="button" class="baseBtn large goSave"><span class="base">저장</span></button>
	<button type="button" class="baseBtn lineBlack large btn_cancel"><span class="base">취소</span></button>
</div>
<!-- //버튼영역 -->
</div>
</div>
<!-- //board -->