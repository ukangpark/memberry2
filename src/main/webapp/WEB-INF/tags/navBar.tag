
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>



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
	<div class="ui position-fixed top-0 end-0">
		<div class="ui dropdown">
			<h4 id="profile">

				<img class="ui tiny image" src="/images/genieLoki.jpeg">로키맘

			</h4>
			<div class="ui vertical menu">
				<div class="item">
					<div class="ui input">
						<input type="text" placeholder="Search...">
					</div>
				</div>

				<a class="${current eq 'home' ? 'active' : '' } item" href="/home"> 홈피드 </a>

				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'myFeed' ? 'active' : '' } item" href="/feed/myFeed"> 마이피드 </a>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'fullCalendar' ? 'active' : '' } item" href="/fullCalendar"> 스케줄달력 </a>
				</sec:authorize>
				

				<a class="${current eq 'mapMain' ? 'active' : '' } item" href="/map/mapMain"> 함께가기 </a>
				<div>
					<div onclick="location.href='/petsitter/main'" class="${current eq 'petsitterMain' ? 'active' : '' } link item">
						펫시터
						<div class="menu">
							<a class="${current eq 'main' ? 'active' : '' } item" href="/petsitter/main">펫시터홈</a>
							
							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'apply' ? 'active' : '' } item" href="/petsitter/apply">펫시터지원</a>
							</sec:authorize>
							
							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'hostMyPage' ? 'active' : '' } item" href="/petsitter/hostMyPage">호스트 마이페이지</a>
							</sec:authorize>
							
							<!-- 관리자 권한으로 변경해야함 -->
							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'hostList' ? 'active' : '' } item" href="/petsitter/hostList">호스트 리스트</a>
							</sec:authorize>
						</div>
					</div>
				</div>

				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'registration' ? 'active' : '' } item" href="/registration"> 반려동물등록 </a>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'petList' ? 'active' : '' } item" href="/myPets/petList"> 나의반려동물 </a>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'myPage' ? 'active' : '' } item" href="/member/myPage"> 마이페이지 </a>
				</sec:authorize>
				
				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'login' ? 'active' : '' } item" href="/member/login"> 로그인 </a>
				</sec:authorize>
				
				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'signup' ? 'active' : '' } item" href="/member/signup"> 회원가입 </a>
				</sec:authorize>
				
				<!-- 관리자 권한으로 변경해야함 -->
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'list' ? 'active' : '' } item" href="/member/list"> 회원목록 </a>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'logout' ? 'active' : '' } item" href="/member/logout"> 로그아웃 </a>
				</sec:authorize>
				

			</div>
		</div>
	</div>
</div>

<!-- 
<div>
	<sec:authentication property="principal"/>
</div>
 -->

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
 
 <div class="up" style="position: fixed; bottom: 10px; right: 10px; ">
		<i class="fa-solid fa-circle-chevron-up fa-2x"  ></i>
	</div>

<script>
	
	$(function(){
		$('.up').on('click',function(e){
			e.preventDefault();
			$('html,body').animate({scrollTop:0},1000);
		});
	});
</script>