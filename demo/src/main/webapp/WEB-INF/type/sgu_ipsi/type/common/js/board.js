
$(window).on('load', function(){
	bbs.init();
});

var bbs = {
	init : function(){		
		bbs.layoutSet();
	},
	layoutSet : function(){
		//게시판 타이틀 아이콘별 최대 넓이값 셋팅
		$(".bbs_list .noticeTitle").each(function(){
			var overflowTextWidth = "";
			for(i=1; i <= $(this).find("i").length; i++){
				if($(this).find("i:nth-of-type("+i+")").is(":visible") == true){
					overflowTextWidth = Number(overflowTextWidth) + Number($(this).find("i:nth-of-type("+i+")").outerWidth(true));
				}
			}
			$(this).find("p").css("max-width", "calc(100% - "+overflowTextWidth+"px)");			
		});

		//좋아요가 있을경우
		if($(".lineList_v dl dt .viewLikeArea").length > 0){
			$(".lineList_v dl dt").addClass("likeTitle");
		}

		//페이징 숫자가 100단위로 갈경우
		if($(".numberPagination>.paging>li>button").eq(0).text().length > 2){
			$(".numberPagination").addClass("sm");
		}
		
	}
}