<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세페이지</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="/css/detail.css" />

</head>
<body>
	<my:navBar></my:navBar>
	<my:alert></my:alert>
	<my:logo></my:logo>
	<br>
	<br>
	<!-- 호스트의 집사진 -->
	<div id="imgBox" class="container">
		<button type="button" class="ui icon button inverted " id="entireBtn" data-bs-toggle="modal" data-bs-target="#housePhotosModal">
			<i class="fa-solid fa-plus"></i>
		</button>
		<div class="ui billboard">
			<!-- 대표 사진 -->
			<div id="coverImgBox" class="ui images left floated">
				<label for="entireBtn">
					<img id="coverImg" class="rounded" src="${bucketUrl }/cover/${detail.id }/${detail.cover }">
				</label>
			</div>
			<!-- 상세 사진 -->
			<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" begin="1" end="2">
				<div class="ui image right floated housePhotosBox">
					<label for="entireBtn">
						<img class="rounded housePhotos" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
					</label>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 호스트 간략 정보 -->
	<div class="container" style="width: 900px">
		<h3 class="ui dividing header">
			Detail
			<span class="" id="detailIdText">${detail.id }</span>
		</h3>
		<div class="ui items">
			<div class="item">
				<div class="image">
					<c:choose>
						<c:when test="${host.profile eq null or host.profile eq '' }">
							<!-- 프로필 사진 없음 -->
							<img style="width: 150px; height: 150px;" alt="기본 사진" src="/images/paw.png">
						</c:when>
						<c:otherwise>
							<!-- 프로필 사진 있음  -->
							<img style="width: 150px; height: 150px;" src="${bucketUrl }/hostProfile/${host.id }/${host.profile }">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="content">
					<sec:authentication property="name" var="userId" />
					<c:choose>
						<c:when test="${userId eq host.memberId }">
							<a class="ui right floated inverted blue button" href="/book/list/host">예약 확인</a>
							<a data-bs-toggle="modal" data-bs-target="#deleteModal" class="ui right floated inverted red button">삭제</a>
							<a data-bs-toggle="modal" data-bs-target="#checkModal" class="ui right floated inverted green button">수정</a>
						</c:when>
						<c:when test="${userId ne host.memberId }">
							<sec:authorize access="isAuthenticated()">
								<button class="ui right floated inverted green button" data-bs-toggle="modal" data-bs-target="#exampleModal">예약</button>
							</sec:authorize>
						</c:when>
					</c:choose>
					<a class="header">${host.hostName }</a>
					<div class="meta">
						<span>주소 : ${host.si }시 ${host.gu }구 ${host.dong }동</span>
						<br>
						<span>번호 : ${host.phone }</span>
					</div>
					<div class="description">
						<p>한 줄 소개 : ${detail.title }</p>
					</div>
					<div class="extra">#매일 산책 가능 #샤워 가능 #간식 있음</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 본문 -->
	<div class="container" style="width: 900px; margin-top: 25px;">
		<div class="ui text container">
			<p>${detail.body }</p>
		</div>



		<!-- 예약 모달 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">반려동물을 선택해주세요</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="/book/regiForm/${detail.id}" id="bookForm" method="post">
							<c:forEach items="${pet }" var="pet">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="petId" id="flexRadioDefault1" value="${pet.id }">
									<label class="form-check-label" for="flexRadioDefault1"> ${pet.petName } </label>
								</div>
							</c:forEach>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary" form="bookForm">예약하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 후기 -->
	<div class="container" style="width: 900px; margin-top: 25px;">
		<div class="ui comments">
			<h3 class="ui dividing header" style="width: 880px;">Comments</h3>
			<div class="comment" style="width: 880px;" id="commentListContainer">
				<!-- 후기 리스트 -->
			</div>
			<!-- 후기 등록 버튼 -->
			<!-- 예약했던 상세페이지이고 예약 완료상태이면 후기 추가버튼이 활성화 -->
			<c:set var="foundMatch" value="false" />

			<c:forEach items="${book}" var="book">
				<c:if test="${!foundMatch && userId eq book.memberId && book.accepted == 2}">
					<div class="input-group mb-3" style="width: 880px;" id="commentInput">
						<button onclick="addCommentBtn()" style="width: 80px;" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#addCommentModal">후기 추가</button>
					</div>
					<c:set var="foundMatch" value="true" />
				</c:if>
			</c:forEach>
		</div>
	</div>

	<br>
	<br>
	<!-- 후기 추가 모달 -->
	<div class="modal fade" id="addCommentModal" tabindex="-1" aria-labelledby="addCommentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="addCommentModalLabel">후기 작성</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h3 class="ui header center aligned">
						펫시터
						<strong class="ui pink header">${host.hostName }님</strong>
						의 서비스는 만족하셨나요?
					</h3>
					<br>
					<div class="commentForStar" id="addCommentStar" data-rating="0"></div>
					<br>
					<div class="ui grid" id="starContainer">
						<div class="row">
							<div class="center aligned column">
								<div class="ui star massive rating"></div>
							</div>
						</div>
					</div>
					<br>
					<input type="hidden" name="star" class="starRating" id="addStarRating">
					<textarea id="commentBodyArea" class="form-control" placeholder="후기를 남겨주세요." rows="10" name="body"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="addCommentModalBtn" data-bs-dismiss="modal">후기 남기기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 후기 삭제 모달 -->
	<div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-labelledby="#deleteCommentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="deleteCommentModalLabel"></h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">후기를 삭제하시겠습까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="commentDeleteModalBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 후기 수정 모달 -->
	<div class="modal fade" id="modifyCommentModal" tabindex="-1" aria-labelledby="#modifyCommentModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="modifyCommentModalLabel">후기 작성</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h3 class="ui header center aligned">후기를 수정하시겠습니까?</h3>
					<br>
					<div id="commentForAddStar"></div>
					<br>
					<div class="ui grid" id="starContainerModify">
						<div class="row">
							<div class="center aligned column">
								<div class="ui star massive rating" id="modifyStar"></div>
							</div>
						</div>
					</div>
					<br>
					<input type="hidden" name="star" class="starRating" id="starRatingModify">
					<textarea id="commentBodyAreaModify" class="form-control" placeholder="후기를 남겨주세요." rows="10" name="body"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="commentModifyModalBtn" data-bs-dismiss="modal">후기 수정하기</button>
				</div>
			</div>
		</div>
	</div>



	<!-- 집사진 모달  -->
	<div class="modal fade" id="housePhotosModal" tabindex="-1" aria-labelledby="housePhotosModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="housePhotosModalLabel">전체 보기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- 사진들 -->
					<div id="carouselExampleIndicators" class="carousel slide">
						<div class="carousel-indicators">
							<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" varStatus="status">
								<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status }" class="active" aria-current="true" aria-label="Slide ${status }"></button>
							</c:forEach>
						</div>
						<div class="carousel-inner modalPhoto">
							<div class="carousel-item active">
								<img src="${bucketUrl }/cover/${detail.id }/${detail.cover }" class="d-block w-100 housePhotos">
							</div>
							<c:forEach items="${hostHousePhoto }" var="hostHousePhoto">
								<div class="carousel-item">
									<img class="rounded housePhotos" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
								</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 상세페이지 수정 모달 -->
	<div class="modal fade" id="checkModal" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="checkModalLabel">상세페이지</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">상세페이지를 수정하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<a href="/petsitter/modifyDetail" class="btn btn-primary">수정하기</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 삭제하기 모달 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="deleteModalLabel">삭제 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						호스트 등록 정보를 정말 삭제하시겠습니까?
						<br>
						삭제를 확인하려면 비밀번호를 입력해주세요.
					</div>
					<!-- 삭제하기 정보 -->
					<form action="/petsitter/deleteDetail" method="post" id="deleteForm">
						<input type="hidden" name="hostId" value="${host.id }">
						<input class="form-control" type="text" name="password" id="passwordInput" placeholder="비밀번호를 입력해주세요.">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<button type="submit" class="btn btn-danger" form="deleteForm">삭제하기</button>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
	<script src="/js/petsitter/petsitterComment.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript">
		function openModal() {
			document.getElementById("myModal").style.display = "block";
		}

		var bucketUrl = '${bucketUrl}';
	</script>

	<script src="/js/semantic/semantic.min.js"></script>
</body>
</html>