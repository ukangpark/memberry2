
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

#nav-container {
	position: relative;
	z-index: 100;
}

.up {
	position: relative;
	z-index: 100;
}

#profile>img {
	margin: auto;
}
</style>


<div class="ui fluid right aligned container" id="nav-container">
	<div class="ui position-fixed top-0 end-0">
		<div class="ui dropdown" id="navBar">
			<h4 id="profile">

				<sec:authorize access="isAuthenticated()">
					<c:if test="${sessionScope.logedInMember.profileImage ne null}">
						<img class="ui tiny image btn-primary position-relative"" id="nav-image" src="${bucketUrl }/pet${sessionScope.logedInMember.profileImage }">
						<span class="position-absolute top-20 start-0 ht rounded-circle"><i class="fa-solid fa-bell" style="color:red;"></i></span></img>
  						 
						${sessionScope.logedInMember.nickName }
					
					</c:if>
					<c:if test="${sessionScope.logedInMember.profileImage eq null}">
						<img class="ui tiny image" id="nav-image" src="/images/paw.png">${sessionScope.logedInMember.nickName } 
					</c:if>

				</sec:authorize>
				<sec:authorize access="not isAuthenticated()">
					<img class="ui tiny image" id="nav-image" src="/images/paw.png">membery 
				</sec:authorize>
			</h4>

			<div class="ui vertical menu">
				<div class="item">
					<div class="ui input">
						<input type="text" placeholder="Search...">
					</div>
				</div>

				<a class="${current eq 'home' ? 'active' : '' } item" href="/home"> 홈피드</a>


				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="name" var="userId"/>
					<a class="${current eq 'myFeed' ? 'active' : '' } item" href="/feed/myFeed/${userId }"> 마이피드 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'fullCalendar' ? 'active' : '' } item" href="/fullCalendar"> 스케줄달력 </a>
				</sec:authorize>


				<a class="${current eq 'mapMain' ? 'active' : '' } item" href="/map/mapMain"> 함께가개 </a>
				<div>
					<div onclick="location.href='/petsitter/main'" class="${current eq 'petsitterMain' ? 'active' : '' } link item">
						펫시터
						<div class="menu">
							<a class="${current eq 'main' ? 'active' : '' } item" href="/petsitter/main">펫시터홈</a>

							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'apply' ? 'active' : '' } item" href="/petsitter/apply">펫시터지원</a>
							</sec:authorize>

							<!-- 사용자 예약내역 -->
							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'regiList' ? 'active' : '' } item" href="/book/list">예약신청내역</a>
							</sec:authorize>
							<!-- 호스트가 보는 예약내역-->
							<sec:authorize access="hasAuthority('host')">
								<a class="${current eq 'regiListHost' ? 'active' : '' } item" href="/book/list/host">예약요청내역</a>
							</sec:authorize>
							<sec:authorize access="hasAuthority('host')">
								<a class="${current eq 'hostMyPage' ? 'active' : '' } item" href="/petsitter/hostMyPage">호스트 마이페이지</a>
							</sec:authorize>

							<!-- 관리자 권한으로 변경해야함 -->
							<sec:authorize access="hasAuthority('admin')">
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
					<a class="${current eq 'chatRoom' ? 'active' : '' } item" href="/chat/chatRoom"> 메세지 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'memberInfo' ? 'active' : '' } item" href="/member/info?id=<sec:authentication property="name" /> "> 마이페이지 </a>
				</sec:authorize>

				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'login' ? 'active' : '' } item" href="/member/login"> 로그인 </a>
				</sec:authorize>

				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'signup' ? 'active' : '' } item" href="/member/signup"> 회원가입 </a>
				</sec:authorize>

				<sec:authorize access="hasAuthority('admin')">
					<a class="${current eq 'list' ? 'active' : '' } item" href="/member/list"> 회원목록 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'logout' ? 'active' : '' } item" href="/member/logout"> 로그아웃 </a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'alarm' ? 'active' : '' } item" href="/alarm"> 알림 <span class="badge text-bg-danger">${logedInMember.alarmCount }</span> </a>
				</sec:authorize>
						


			</div>
		</div>
	</div>
</div>

<div class="up" style="position: fixed; bottom: 10px; right: 10px;">
	<i style="cursor: pointer" class="fa-solid fa-circle-chevron-up fa-2x"></i>
</div>

