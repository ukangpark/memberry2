<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>


<style>
#profile {
	text-align: center;
}

.ui.tiny.image {
	border-radius: 50%;
	height: 70px;
	width: 70px;

}

</style>

<div class="ui fluid right aligned container" id="container">
	<div class="ui fixed top sticky">
		<div class="ui dropdown" id="profile">
			<h4>
				<img class="ui tiny image" src="/images/genieLoki.jpeg">로키맘
			</h4>
			<div class="ui vertical menu">
				<div class="item">
					<div class="ui input">
						<input type="text" placeholder="Search...">
					</div>
				</div>
				<a class="${current eq 'home' ? 'active' : '' } item" href="/home" data-tab="tab-home"> 홈피드 </a>
				<a class="${current eq 'myFeed' ? 'active' : '' } item" href="/myFeed"> 마이피드 </a>
				<a class="${current eq 'schedule' ? 'active' : '' } item" href="/schedule" data-tab="tab-schedule"> 스케줄달력 </a>
				<!-- 함께가기 주소 업데이트 해야함 -->
				<a class="${current eq '' ? 'active' : '' } item" href="/"> 함께가기 </a>
				<div class="item">
					펫시터
					<div class="menu">
						<!-- 펫시터 주소bery랑 확인 필요 -->
						<a class="${current eq 'petsitterMain' ? 'active' : '' } item" href="/petsitterMain">펫시터홈</a>
						<a class="${current eq 'petsitter' ? 'active' : '' } item" href="/petsitter">펫시터지원</a>
					</div>
				</div>
				<a class="${current eq 'registration' ? 'active' : '' } item" href="/registration" data-tab="tab-registration"> 반려동물등록 </a>
				<a class="${current eq 'myPage' ? 'active' : '' } item" href="/myPage"> 마이페이지 </a>
				<a class="${current eq 'login' ? 'active' : '' } item" href="/login"> 로그인 </a>
				<a class="${current eq 'signup' ? 'active' : '' } item" href="/signup"> 회원가입 </a>
				<a class="${current eq 'logout' ? 'active' : '' } item" href="/logout"> 로그아웃 </a>
			</div>
		</div>
	</div>
</div>
<!-- 
<div class="d-flex flex-row-reverse mt-3"  >
	<div class="ui inline dropdown">
		<div class="text" id="profile">
			<img class="ui avatar image" src="/images/genieLoki.jpeg">로키맘
		</div>
			<div class="menu">
				<div class="item">
					<a href="/home">홈피드</a>
				</div>
				<div class="item">
					<a href="/myFeed">마이피드</a>
				</div>
				<div class="item">
					<a href="/schedule">스케줄달력</a>
				</div>
				<div class="item">
					<a href="">함께가기</a>
				</div>
				<div class="item">
					<i class="left dropdown icon"></i> 
					<span class="text">
						<a href="/petsitter/main">펫시터</a>
					</span>
					<div class="menu">
						<div class="item">
							<a href="">펫시터지원</a>
						</div>
					</div>
				</div>
				<div class="item">
					<a href="/registration">반려동물등록</a>
				</div>
				<div class="item">
					<a href="/mypage">마이페이지</a>
				</div>
				<div class="item">
					<a href="/login">로그인</a>
				</div>
				<div class="item">
					<a href="/signin">회원가입</a>
				</div>
				<div class="item">
					<a href="/logout">로그아웃</a>
				</div>
			</div>
	</div>
</div>
 -->
<script>
	$('.ui.sticky').sticky({
		offset: 10
	});
	$('.ui.dropdown').dropdown({
		direction : 'auto'
	});
</script>