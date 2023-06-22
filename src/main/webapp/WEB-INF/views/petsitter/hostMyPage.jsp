<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>호스트 마이페이지</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<my:navBar></my:navBar>
	<my:alert></my:alert>
	<my:logo></my:logo>
	<br>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<div class="content">
					<c:choose>
						<c:when test="${host.profile eq null or host.profile eq '' }">
							<img class="ui medium bordered centered circular image " src="/images/paw.png">
						</c:when>
						<c:otherwise>
							<img class="ui medium bordered centered circular image " src="${bucketUrl }/hostProfile/${host.id }/${host.profile }">
						</c:otherwise>
					</c:choose>
					<h1 class="ui center aligned header"><span style="color: #FF9999;">${host.hostName }</span>님 정보입니다.</h1>
					<div>
						<form class="ui big form" id="checkForm">
							<div class="field">
								<label>전화번호</label>
								<input type="text" name="phone" value="${host.phone }" readonly>
							</div>
							<div class="field">
								<label>생년월일</label>
								<input type="text" name="idNumber" value="${host.idNumber }" readonly>
							</div>
							<div class="field">
								<label>주소</label>
								<div class="equal width fields">
									<div class="field">
										<input type="text" name="si" value="${host.si }" readonly>
									</div>
									<div class="field">
										<input type="text" name="gu" value="${host.gu }" readonly>
									</div>
									<div class="field">
										<input type="text" name="dong" value="${host.dong }" readonly>
									</div>
								</div>
							</div>
							<div class="field">
								<label>상세주소</label>
								<input type="text" name="address" value="${host.address }" disabled>
							</div>
							<div class="field">
								<div class="equal width fields">
									<div class="field">
										<label>주거형태</label>
										<input type="text" name="houseType" value="${host.houseType }" disabled>
									</div>
									<div class="field">
										<label>반려동물</label>
										<input type="text" name="pet" value="${host.pet }" disabled>
									</div>
									<div class="field">
										<label>반려동물 크기</label>
										<input type="text" name="species" value="${host.species }" disabled>
									</div>
								</div>
								<div class="field">
									<label>펫시터 경험</label>
									<input type="text" name="experience" value="${host.experience }" disabled>
								</div>
								<div class="field">
									<div class="ui mini transparent input">
										<c:if test="${detail.id ne null }" var="status">
											<a class="ui basic huge label" href="/book/list/host">예약 확인</a>
											<a class="ui basic huge label" href="/petsitter/detail?id=${host.id }">상세페이지 보기</a>
											<input type="text" value="${status ? '등록된 상세페이지가 있습니다.' : '등록된 상세페이지가 없습니다.' }" disabled>
										</c:if>
											<input type="text" value="${detail.id eq null ? '등록된 상세페이지가 없습니다.' : '' }" disabled>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="extra content">
				<div class="ui three buttons">
					<button data-bs-toggle="modal" data-bs-target="#deleteModal" class="ui red basic button">삭제하기</button>
					<button data-bs-toggle="modal" data-bs-target="#checkModal" class="ui blue basic button">상세페이지 ${detail.id eq null ? '등록하기' : '수정 및 삭제하기' }</button>
					<a href="/petsitter/hostModify?id=${host.id }" class="ui green basic button">나의 정보 수정하기</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 상세페이지 등록/수정 모달 -->
	<div class="modal fade" id="checkModal" tabindex="-1" aria-labelledby="checkModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="checkModalLabel">상세페이지</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">${detail.id eq null ? '상세페이지를 등록하시겠습니까?' : '상세페이지를 수정 및 삭제하시겠습니까?' }</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<a href="/petsitter/${detail.id eq null ? 'addDetail' : 'modifyDetail' }" class="btn btn-primary">${detail.id eq null ? '등록하기' : '수정 및 삭제하기' }</a>
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
					<form action="/petsitter/hostDelete" method="post" id="deleteForm">
						<input type="hidden" name="hostId" value="${host.id }">
						<input class="form-control" type="password" name="password" id="passwordInput" placeholder="비밀번호를 입력해주세요.">
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>

</body>
</html>