<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="format-detection" content="telephone=no"><!-- 사파리 전화번호 인식 차단 -->

    <!-- <title>신구대학교</title> -->
    <title>${SITE_TITLE } ${META_DESC }</title>
    
    <link rel="shortcut icon" href="sgu_ipsi/type/common/img/ico_favicon.ico" />
    <link rel="icon" type="image/png" href="sgu_ipsi/type/common/img/ico_favicon.png" sizes="192x192" />
    
    <link rel="stylesheet" href="sgu_ipsi/type/common/css/common.css"><!-- reset --><!-- reset -->

    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/common/css/kor.css" /><!-- 신구대 KOR.css -->
    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/common/css/ipsi.css" /><!-- ipsi css -->
    
    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/IPSI_A/css/layout.css" /><!-- layout -->
    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/IPSI_A/css/main.css" /> <!-- main (Main 전용) -->
    
    <script type="text/javascript" src="sgu_ipsi/type/common/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="sgu_ipsi/type/common/js/jquery.easing.1.3.js"></script>

    <!-- swiper -->
    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/common/js/swiper/swiper.css"/>
    <script type="text/javascript" src="sgu_ipsi/type/common/js/swiper/swiper.js"></script>

    <!-- aos  -->
    <link rel="stylesheet" href="sgu_ipsi/type/common/css/aos.css"/>
    <script src="sgu_ipsi/type/common/js/aos.js"></script>
    
    <!-- Gsap -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.6.0/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.6.0/ScrollTrigger.min.js"></script>    

    <!-- scrollbar -->
    <link rel="stylesheet" type="text/css" href="sgu_ipsi/type/common/js/mCustomScrollbar/jquery.mCustomScrollbar.css"/>
    <script type="text/javascript" src="sgu_ipsi/type/common/js/mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
    
    <script type="text/javascript" src="sgu_ipsi/type/common/js/layout.js"></script><!-- 공통_layout -->
    <script type="text/javascript" src="sgu_ipsi/type/IPSI_A/js/layout.js"></script><!-- 개별 layout -->
    <script type="text/javascript" src="sgu_ipsi/type/IPSI_A/js/main.js"></script><!-- 개별 layout (Main 전용) -->
    
    <!-- 카카오 추적 시작 -->
	﻿<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/kas/static/kp.js"></script>
	<script type="text/javascript">
	kakaoPixel('5862460418549396025').pageView();
	</script>
	<!-- 카카오 추적 끝 -->

	﻿<!-- 메타픽셀 추적 시작 Meta Pixel Code -->
	<script>
	!function(f,b,e,v,n,t,s)
	{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
	n.callMethod.apply(n,arguments):n.queue.push(arguments)};
	if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
	n.queue=[];t=b.createElement(e);t.async=!0;
	t.src=v;s=b.getElementsByTagName(e)[0];
	s.parentNode.insertBefore(t,s)}(window, document,'script',
	'https://connect.facebook.net/en_US/fbevents.js');
	fbq('init', '2189072841465205');
	fbq('track', 'PageView');
	</script>
	<noscript><img height="1" width="1" style="display:none"
	src="https://www.facebook.com/tr?id=2189072841465205&ev=PageView&noscript=1"
	/></noscript>
	<!-- 메타픽셀 추적 끝 End Meta Pixel Code -->
    
	<!-- 구글 추적 시작 -->
	﻿<!-- Google tag (gtag.js) -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=AW-705927921"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'AW-705927921');
	</script>
	 <!-- 구글 추적 끝 -->
    
</head>

