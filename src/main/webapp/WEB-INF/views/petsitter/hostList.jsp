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
<title>호스트 리스트</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<my:navBar current="hostList"></my:navBar>
	<my:logo></my:logo>
	<div class="container" style="margin-top: 50px;">
		<h1>호스트 리스트</h1>
		<table class="ui fixed single line celled table">
			<thead>
				<tr>
					<th>이름</th>
					<th>아이디(회원아이디)</th>
					<th>전화번호</th>
					<th>상세페이지</th>
					<th>등록날짜</th>
					<th>호스트 정보 관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${host }" var="hostList" varStatus="status">
					<tr>
						<td>
							<a href="/petsitter/hostMyPage?hostId=${hostList.id }">${hostList.memberId }</a>
						</td>
						<td>
							${hostList.id } (${hostList.memberId })
						</td>
						<td>${hostList.phone }</td>
						<td>${hostList.detail eq 'true' ? '등록' : '미등록' }</td>
						<td>${hostList.inserted }</td>
						<td>
							<a href="/petsitter/hostModify?hostId=${hostList.id }" class="ui green basic button">수정</a>
							<button host-id="${hostList.id }" data-bs-toggle="modal" data-bs-target="#deleteModal" class="ui red basic button hostBtn">삭제</button>
						</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

		<!-- 페이지네이션  -->
		<div class="ui center aligned">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<!-- 이전 버튼 -->
					<c:if test="${leftPageNum > 1}">
						<c:url value="/petsitter/hostList" var="prevPageLink">
							<c:param name="page" value="${leftPageNum - 1}" />
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${prevPageLink}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>
					<c:forEach begin="${leftPageNum}" end="${rightPageNum}" var="pageNum">
						<c:url value="/petsitter/hostList" var="pageLink">
							<c:param name="page" value="${pageNum}" />
						</c:url>
						<li class="page-item">
							<a class="page-link ${pageNum == currentPageNum ? 'active' : ''}" href="${pageLink}">${pageNum}</a>
						</li>
					</c:forEach>
					<!-- 다음 버튼 -->
					<c:if test="${currentPageNum < lastPageNum}">
						<c:url value="/petsitter/hostList" var="nextPageLink">
							<c:param name="page" value="${rightPageNum + 1}" />
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${nextPageLink}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
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
						<input type="hidden" name="hostId" value="" id="hostIdInput">
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
	<script type="text/javascript">
	$(".hostBtn").click(function() {
		var hostId = $(this).attr("host-id");
		
		$("#hostIdInput").val(hostId);

		})
	</script>
</body>
</html>