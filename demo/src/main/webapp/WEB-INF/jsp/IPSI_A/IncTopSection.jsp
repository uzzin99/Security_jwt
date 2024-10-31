<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.5/handlebars.js"></script>
<script>
var gnbDep1 = 0;
var gnbDep2 = 0;
var gnbDep3 = 0;
var gnbDep4 = 0;

function setHref(obj, org){
	if($(obj).find("> div").length > 0){
		if($(obj).find("> div> ul > li").length > 0){
			if($(obj).find(">a").data("sub")=="Y"){
				$(org).find(">a").attr("href",$(obj).find("> div> ul > li:eq(0) > a").attr("href"));
				$(org).find(">a").attr("target",$(obj).find("> div> ul > li:eq(0) > a").attr("target"));
			}else{
				$(org).find(">a").attr("href",$(org).find(">a").attr("href"));
			}
			setHref($(obj).find("> div> ul > li:eq(0)"),org);
		}
	}else{
		if($(obj).find("> ul > li").length > 0){
			if($(obj).find(">a").data("sub")=="Y"){
				$(org).find(">a").attr("href",$(obj).find("> ul > li:eq(0) > a").attr("href"));
				$(org).find(">a").attr("target",$(obj).find("> ul > li:eq(0) > a").attr("target"));
			}else{
				$(org).find(">a").attr("href",$(org).find(">a").attr("href"));
			}
			setHref($(obj).find("> ul > li:eq(0)"),org);
		}
	}
}

function setSnbHref(obj, org){
	var v_menuno = ($(obj).data("menuno"));
	var v_sub = ($(obj).data("sub"));
	
	if($("ul#gnb li."+v_menuno+" > div").length > 0){
		if($("ul#gnb li."+v_menuno+" > div > ul > li").length > 0){
			if(v_sub=="Y"){
				$(org).find(">a").attr("href",$("ul#gnb li."+v_menuno+" > div > ul > li:eq(0) > a").attr("href"));
				$(org).find(">a").attr("target",$("ul#gnb li."+v_menuno+" > div > ul > li:eq(0) > a").attr("target"));
			}else{
				$(org).find(">a").attr("href",$(org).find(">a").attr("href"));
			}
			setHref($("ul#gnb li."+v_menuno+" > div > ul > li:eq(0)"),org);
		}
	}else{
		if($("ul#gnb li."+v_menuno+" > ul > li").length > 0){
			if(v_sub=="Y"){
				$(org).find(">a").attr("href",$("ul#gnb li."+v_menuno+" > ul > li:eq(0) > a").attr("href"));
				$(org).find(">a").attr("target",$("ul#gnb li."+v_menuno+" > ul > li:eq(0) > a").attr("target"));
			}else{
				$(org).find(">a").attr("href",$(org).find(">a").attr("href"));
			}
			setHref($("ul#gnb li."+v_menuno+" > ul > li:eq(0)"),org);
		}
	}
}


function login(){
	$("#loginForm").attr("action","https://login.shingu.ac.kr");
	$("#loginForm").submit();
}

$(function(){
	$(document).on("click", "ul#gnb li, ul#rnb li:not(ul#rnb>li.child), #sitemap_gnb li", function(){
		setHref($(this),$(this));
	});
	$(document).on("click", "nav#snb_nav li", function(){
		setSnbHref($(this),$(this));
	});
});
</script>
<script src="common.js"></script>
<script>
$(document).ready(function() {
	sendAjaxRequest('/mainApi/menu', 'GET', null,
		function(data) {
	    // 성공 시 처리
	    const menuItems = processMenuData(data.SUB);
		const siteMapItems = processSiteMapData(data.SUB);
		  
		$("#gnb").append(menuItems); //메뉴
		$("#sitemap_gnb").append(siteMapItems); //사이트맵
		}
	);
	
// 	$.ajax({
// 	  url: '/mainApi/menu',
// 	  headers: {
//           'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
//       },
// 	  type: 'GET',
// 	  success: function(data) {
// 		  const menuItems = processMenuData(data.SUB);
// 		  const siteMapItems = processSiteMapData(data.SUB);
		  
// 		  $("#gnb").append(menuItems); //메뉴
// 		  $("#sitemap_gnb").append(siteMapItems); //사이트맵
// 	  },
// 	  error: function(error) {
// 	    console.error('Error:', error);
// 	  }
// 	});
});

function processMenuData(menuData, level = 1) {
	let menuItems = '';

	menuData.forEach(item => {
		if(item.SUB != null) menuItems += '<li class="child '+item.MENU_NO+'">'; //child가 있을경우
		else menuItems += '<li class="'+item.MENU_NO+'">'; //child가 없을경우
		
        menuItems += '<a href="'+item.REAL_URL+'" data-sub="'+item.LINK_SUB_YN+'" target="'+item.SETVAL+'">'+item.MENU_NM+'</a>';
        if (item.SUB) {
            const className = level === 1 ? 'menuM' : 'menuS';
            menuItems += '<ul class="'+className+'" data-tit="'+item.MENU_NM+'">';
            menuItems += processMenuData(item.SUB, level + 1);
            menuItems += '</ul>';
        }
        menuItems += '</li>';
    });

    return menuItems;
}

function processSiteMapData(menuData, level = 1) {
	let siteMapItems = '';

	menuData.forEach(item => {
		siteMapItems += '<li>'
		siteMapItems += '<a href="'+item.REAL_URL+'" data-sub="'+item.LINK_SUB_YN+'" target="'+item.SETVAL+'">'+item.MENU_NM+'</a>';
		
		if(level == 1) siteMapItems += '<div>'; //레벨 1일 경우만 div 추가
		
        if (item.SUB) {
        	siteMapItems += '<ul>'
       		siteMapItems += processSiteMapData(item.SUB, level + 1);
        	siteMapItems += '</ul>'
        }
        
        if(level == 1) siteMapItems += '</div>'; //레벨 1일 경우만 div 추가
        
        siteMapItems += '</li>';
    });

    return siteMapItems;
}
</script>
<div id="header">
	<header>
        <h1 class="logo">
            <a href="#none">
				<img src="sgu_ipsi/type/IPSI_A/img/layout/IPSI_logo.svg" alt="신구대학교 입학안내">
				<span>
					<img src="sgu_ipsi/type/IPSI_A/img/layout/IPSI_logo.png" alt="신구대학교 입학안내">
				</span>
            </a>
        </h1>

        <!-- 모바일용 버튼-->
        <button type="button" class="mBtn_topMenu"><span class="scHdn">MENU</span></button>
        <!-- //모바일용 버튼-->
		
		<nav>
			<ul id="gnb"></ul>
		</nav>

            <!-- top_util -->
            <div class="top_util">
                <a href="#none" class="btn_topSitemap"><span>전체메뉴</span></a>	
                <a href="#none" class="util_logo"><img src="/sgu_ipsi/type/IPSI_A/img/layout/IPSI_logo_white.svg" alt="신구대학교" /></a>			
			</div>
			
			<!-- 모바일용 닫기 -->
			<div class="mBtn">
				<button type="button" class="mBtn_close"><span class="scHdn">메뉴 닫기</span></button>
			</div>
		</nav>
	</header>
</div>
<div id="container">
	<!-- siteMap -->
    <div class="pop_wrap" id="siteMap">
        <section class="popLayout typeBtm">
            <div class="popTop">
                <button type="button" class="btn_popClose btn_close"><span>창닫기</span></button>
            </div>            

            <div class="popConts">
                <!-- 팝업 내용 입력-->
                <div class="popInner" tabindex="0">
                    <div class="popCont">
                        <ul id="sitemap_gnb">
						</ul>
                    </div>
                </div>
                <!-- //팝업 내용 입력 -->
            </div>
        </section>
    </div>
    <!-- //siteMap -->

