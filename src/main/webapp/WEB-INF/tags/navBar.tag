
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

		<!-- search -->

		<div class="searchBtn"
			style="cursor: pointer; display: flex; float: left; margin: 30px 10px 0px 0px; align-items: center; align-content: center; text-align: center; justify-content: center;">

			<a href="/search"><i style="color: black;"
				class="search big icon"></i></a>

		</div>

		<!-- alarm -->
		<sec:authorize access="isAuthenticated()">
		
			<div class="alarmBtn ui scrolling dropdown"
				style="display: flex; float: left; margin: 30px 10px 0px 0px; align-items: center; align-content: center; text-align: center; justify-content: center;">
				 <i class="bell big icon position-relative">  
				<c:if test="${sessionScope.logedInMember.alarmCount > 0 }">
						<span
							class="position-absolute top-20 start-5 translate-middle p-1 bg-danger border border-light rounded-circle"
							style="font-size: 0.3em; font-weight: bold; color: white;">${sessionScope.logedInMember.alarmCount}</span>
					</c:if>
				</i>

				<div class="ui vertical menu" id="alarmContainer" style="margin-top: 10px;">
					<div class="item">
						<ul class="list-group" id="alarmListContainer">
							<c:forEach items="${sessionScope.alarms }" var="alarm">
								<!-- 피드댓글 알림 -->
								<c:if test="${alarm.notiType eq 'comment' }">
									 <a href="/feedId/${alarm.feedId}" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> <i
										class="fa-solid fa-comments" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
											${alarm.notiBody}
										</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a> 
									
								</c:if>
								<!-- 피드 좋아요 알림 -->
								<c:if test="${alarm.notiType eq 'like' }">
									 <a href="/feedId/${alarm.feedId}" 
										class="list-group-item " data-alarm-id="${alarm.id}" onclick="alarmCheck(${alarm.id});"> <i
										class="fa-solid fa-bone" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										${alarm.notiBody}
										</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a> 
								</c:if>
								<!-- 팔로우 알림 -->
								<c:if test="${alarm.notiType eq 'follow' }">
									<a href="/feed/myFeed/${alarm.causedMemberId}" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-user" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
								<!-- 예약 요청 알림 -->
								<c:if test="${alarm.notiType eq 'bookRegi' }">
									<a href="/book/list/host" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-paw" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
								<!-- 예약 승인 알림 -->
								<c:if test="${alarm.notiType eq 'bookAccept' }">
									<a href="/book/list" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-paw" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
								<!-- 예약 거절 알림 -->
								<c:if test="${alarm.notiType eq 'bookReject' }">
									<a href="/book/list" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-paw" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
								<!-- 상세페이지 후기 알림 -->
								<c:if test="${alarm.notiType eq 'petsitterComment' }">
									<a href="/petsitter/detail?id=${alarm.feedId}" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-comments" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
								<!-- qna 알림 -->
								<c:if test="${alarm.notiType eq 'qna' }">
									<a href="/qna/id/${alarm.feedId}" 
										class="list-group-item "  onclick="alarmCheck(${alarm.id});"> 
										<i class="fa-solid fa-magnifying-glass" style="color: #a0a0a0"></i>
										<div id="aLi" style="font-weight: bold; <c:if test="${alarm.isChecked eq 'true' }">color: #a0a0a0</c:if>">
										 ${alarm.notiBody}</div>
										<small class="text-body-secondary">${alarm.inserted}</small>
									</a>
								</c:if>
						
							</c:forEach>

						</ul>

					</div>
				</div>

			</div>
		</sec:authorize>


		<div class="ui dropdown" id="navBar"
			style="display: flex; float: right; align-items: center; align-content: center; text-align: center; justify-content: center;">
			<h4 id="profile">

				<sec:authorize access="isAuthenticated()">
					<c:if test="${sessionScope.logedInMember.profileImage ne null}">
						<img class="ui tiny image btn-primary position-relative"
							id="nav-image"
							src="${bucketUrl }/pet${sessionScope.logedInMember.profileImage }">
						</img>
  						 
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

				<a class="${current eq 'home' ? 'active' : '' } item" href="/home">
					홈피드</a>

				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="name" var="userId" />
					<a class="${current eq 'myFeed' ? 'active' : '' } item"
						href="/feed/myFeed/${userId }"> 마이피드 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'fullCalendar' ? 'active' : '' } item"
						href="/fullCalendar"> 스케줄달력 </a>
				</sec:authorize>


				<a class="${current eq 'mapMain' ? 'active' : '' } item"
					href="/map/mapMain"> 함께가개 </a>
				<div>
					<div onclick="location.href='/petsitter/main'"
						class="${current eq 'petsitterMain' ? 'active' : '' } link item">
						펫시터
						<div class="menu">
							<a class="${current eq 'main' ? 'active' : '' } item"
								href="/petsitter/main">펫시터홈</a>

							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'apply' ? 'active' : '' } item"
									href="/petsitter/apply">펫시터지원</a>
							</sec:authorize>

							<!-- 사용자 예약내역 -->
							<sec:authorize access="isAuthenticated()">
								<a class="${current eq 'regiList' ? 'active' : '' } item"
									href="/book/list">예약신청내역</a>
							</sec:authorize>
							<!-- 호스트가 보는 예약내역-->
							<sec:authorize access="hasAuthority('host')">
								<a class="${current eq 'regiListHost' ? 'active' : '' } item"
									href="/book/list/host">예약요청내역</a>
							</sec:authorize>
							<sec:authorize access="hasAuthority('host')">
								<a class="${current eq 'hostMyPage' ? 'active' : '' } item"
									href="/petsitter/hostMyPage">호스트 마이페이지</a>
							</sec:authorize>

							<sec:authorize access="hasAuthority('admin')">
								<a class="${current eq 'hostList' ? 'active' : '' } item"
									href="/petsitter/hostList">호스트 리스트</a>
							</sec:authorize>
						</div>
					</div>
				</div>


				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'registration' ? 'active' : '' } item"
						href="/registration"> 반려동물등록 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'petList' ? 'active' : '' } item"
						href="/myPets/petList"> 나의반려동물 </a>
				</sec:authorize>

				<%-- <sec:authorize access="isAuthenticated()">
					<a class="${current eq 'chat' ? 'active' : '' } item"
						href="/chat/chat"> 메세지 </a>
				</sec:authorize> --%>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'chatRoom' ? 'active' : '' } item"
						href="/chat/chatRoom"> 메세지 목록 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<a class="${current eq 'memberInfo' ? 'active' : '' } item"
						href="/member/info?id=<sec:authentication property="name" /> ">
						마이페이지 </a>
				</sec:authorize>

				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'login' ? 'active' : '' } item"
						href="/member/login"> 로그인 </a>
				</sec:authorize>

				<sec:authorize access="isAnonymous()">
					<a class="${current eq 'signup' ? 'active' : '' } item"
						href="/member/signup"> 회원가입 </a>
				</sec:authorize>

				<a class="${current eq 'qna' ? 'active' : '' } item" href="/qna">
					질문과답변 </a>

				<sec:authorize access="hasAuthority('admin')">
					<a class="${current eq 'list' ? 'active' : '' } item"
						href="/member/list"> 회원목록 </a>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">

					<a class="${current eq 'logout' ? 'active' : '' } item"
						href="/member/logout"> 로그아웃 </a>
				</sec:authorize>


			</div>
		</div>
	</div>
</div>

<div class="up" style="position: fixed; bottom: 10px; right: 10px;">
	<i style="cursor: pointer" class="fa-solid fa-circle-chevron-up fa-2x"></i>
</div>

<script>
function alarmCheck(alarmId) {
	console.log(alarmId);
	$.ajax("/alarm/check?id=" + alarmId, {
		method: "get",
		success: function() {
			console.log("알림 확인");
		}
	})
}
</script>


