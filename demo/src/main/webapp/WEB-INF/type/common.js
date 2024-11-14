$(window).on('load', function(){

});

function sendAjaxRequest(url, method, data, successCallback, errorCallback) {
  $.ajax({
      url: url,
      type: method,
	  beforeSend: function (xhr) {
          xhr.setRequestHeader("Authorization","Bearer " + localStorage.getItem('accessToken'));//header추가
      },
      data: data,
      success: successCallback,
      error: function(error) {
	  		console.error('Error:', error);
	  		if (error.status == 401) {
	  			return $.ajax({
	  				url: '/apiToken/refresh', // 리프레시 토큰 발급 엔드포인트
	  				type: 'POST',
	  				headers: {
	  					'Authorization': 'Bearer ' + localStorage.getItem('refreshToken')
	  				},
	  				success: function(data) {
	  					// 새로운 액세스 토큰 저장
	  					localStorage.setItem('accessToken', data.token);
	  					return data.token;
	  				},
	  				error: function(error) {
	  					console.error('토큰 갱신 실패:', error);
	  					// 에러 처리 (예: 로그아웃, 알림 등)
	  				}
	  			});
	  		}
	  	}
  });
}