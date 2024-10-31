<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="common.js"></script>
<script>
$(document).ready(function() {
	sendAjaxRequest('/mainApi/getFooterItem', 'GET', null,
		function(data) {
	    	// 성공 시 처리
			if(data.footerSiteInfo){
				$.each(data.footerSiteInfo, function(index, list) {
					$li = $('<li></li>');
					$link = $('<a>' + list.TEXT + '</a>').attr('href', list.URL).attr('target', list.SETVAL).attr('title', list.SETVAL == '_blank' ? '새창열림' : '');
					$li.append($link);
					$(".fLink").append($li);
				});
			}
			
			if(data.footerInfo){
				 $(".f_info address").append(data.footerInfo.CONTENTS);
			}
			
			if(data.footerLinkGroupInfo){
				$.each(data.footerLinkGroupInfo, function(index, list) {
					index += index;
					if(list.LINK_GROUP_NM != null){
						$(".fSelect").append('<a href="#none" id="familySite' + index + '_Btn" class="inp_f sguIpsi_Site01">' + list.LINK_GROUP_NM + '</a>');
					}
				});
			}
			
			if(data.footerSnsSiteInfo){
				$.each(data.footerSnsSiteInfo, function(index, list) {
					$li = $('<li></li>');
					$link = $('<a></a>').attr('href', list.URL).attr('target', list.SETVAL).attr('title', list.SETVAL == '_blank' ? '새창열림' : '').attr('class', index == 0 ? 'f' : 'b');
					$img = $('<img src="/attach/' + list.PC_FILE_NM_SAVED + '" alt="' + list.REP_TEXT + '">');
					
					$link.append($img);
					$li.append($link);
					$(".f_sns").append($li);
				});
				
			}
		},
		function(error) {
	    // 실패 시 처리
		}
	);
/* 	$.ajax({
		url: '/mainApi/getFooterItem',
		headers: {
	          'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
      	},
		type: 'GET',
		success: function(data) {
			if(data.footerSiteInfo){
				$.each(data.footerSiteInfo, function(index, list) {
					$li = $('<li></li>');
					$link = $('<a>' + list.TEXT + '</a>').attr('href', list.URL).attr('target', list.SETVAL).attr('title', list.SETVAL == '_blank' ? '새창열림' : '');
					$li.append($link);
					$(".fLink").append($li);
				});
			}
			
			if(data.footerInfo){
				 $(".f_info address").append(data.footerInfo.CONTENTS);
			}
			
			if(data.footerLinkGroupInfo){
				$.each(data.footerLinkGroupInfo, function(index, list) {
					index += index;
					if(list.LINK_GROUP_NM != null){
						$(".fSelect").append('<a href="#none" id="familySite' + index + '_Btn" class="inp_f sguIpsi_Site01">' + list.LINK_GROUP_NM + '</a>');
					}
				});
			}
			
			if(data.footerSnsSiteInfo){
				$.each(data.footerSnsSiteInfo, function(index, list) {
					$li = $('<li></li>');
					$link = $('<a></a>').attr('href', list.URL).attr('target', list.SETVAL).attr('title', list.SETVAL == '_blank' ? '새창열림' : '').attr('class', index == 0 ? 'f' : 'b');
					$img = $('<img src="/attach/' + list.PC_FILE_NM_SAVED + '" alt="' + list.REP_TEXT + '">');
					
					$link.append($img);
					$li.append($link);
					$(".f_sns").append($li);
				});
				
			}
			
		},error: function(error) {
			console.error('Error:', error);
			if (error.status === 401) {
				console.log("7888888");
			}
			
		}
	}); */
});
</script>
<hr />

<!-- footer -->
<div id="footer">
	<footer>
		<div class="f_info">
			<ul class="fLink">
			</ul>

			<address>
				${footerInfo.CONTENTS }
			</address>
			
			<div class="inpBox">
				<div class="fVR">
					<a href="https://vrcampus.shingu.ac.kr/" target="_blank" title="새창열림"><img src="/sgu_ipsi/type/IPSI_A/img/layout/img_footerVR.svg" alt="신구대학교 VR캠퍼스 체험"></a>
				</div>
				
				<div class="fSelect">
					<script>
						$("#familySite1_Btn").on("click", function(e){
							ui.LayerPop.Show("#familySite1", "640");
						});
						$("#familySite2_Btn").on("click", function(e){
							ui.LayerPop.Show("#familySite2", "960");
						});
					</script>
				</div>
			</div>
		</div>
		
		<div class="f_etc">
			<p class="copyright">ⓒ 2024 SHINGU COLLEGE. ALL RIGHTS RESERVED.</p>

			<ul class="f_sns">
			</ul>
		</div>		
	</footer>
</div>
<!-- //footer -->