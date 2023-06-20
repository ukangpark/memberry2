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
<title>Insert title here</title>
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
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${host }" var="host">
					<tr>
						<td>
							<a href="/petsitter/hostMyPage?id=${host.id }">${host.hostName }</a>
						</td>
						<td>${host.id }(${host.memberId })</td>
						<td>${host.phone }</td>
						<td>${host.detail eq 'true' ? '등록' : '미등록' }</td>
						<td>${host.inserted }</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

		<!-- 페이지네이션  -->
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


	<my:bottom></my:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>