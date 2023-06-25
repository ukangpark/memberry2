<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>전체보기</title>

<d:top></d:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">

<style>
h1 {
	text-align: center;
	/* 왜안댕.. */
	font-family: fantasy;
}

#petsitterListLogo {
	width: 500px;
}

#image{
	position:relative;
	width:290px;
	height:200px;
}

#imager{
	position:absolute;
	width:100%;
	height:100%;
}

</style>

</head>
<body>
	<d:navBar current="list" />


	<div class="container-lg">
	<h1 style="margin-bottom:0px;">
		<a href="/petsitter/main">
			<img id="petsitterListLogo" src="/images/petsitterListLogo.png" alt="List logo">
		</a>
	</h1>

		<form action="list" class="d-flex" role="search">
			<input value="${param.search }" name="search" class="form-control me-2" type="search" placeholder="맡기고 싶은 지역을 검색해보세요" aria-label="Search">
			<button class="btn btn-outline-success" type="submit" style="width: 80px">검색</button>
		</form>

		
		<hr />

		
		<div class="ui link cards">
			<c:forEach items="${petsitterList }" var="host">
				<div class="card">
				
					<div id="image">
					<a href="/petsitter/detail?id=${host.id }">
						<img src="${bucketUrl }/${membery }cover/${host.detailId}/${host.cover}" alt="" id="imager" />
						</a>
					</div>
					<div class="content">
						<div class="header">${host.title }</div>
						<div class="meta">
							<a href="/petsitter/detail?id=${host.id }">${host.si } ${host.gu } ${host.dong }</a>
						</div>
						<div class="description">${host.houseType }, ${host.pet }, ${host.species }</div>
					</div>
					<div class="extra content">
						<span class="right floated"> 하루 40,000원~ </span> <span> <i class="comments icon"></i> 후기 ${host.commentCount }개
						</span>
					</div>
				</div>

			</c:forEach>
		</div>


		<br /> <br />

		<div class="container-lg">
			<div class="row">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">

						<!-- 이전 버튼 -->
						<c:if test="${pageInfo.currentPageNum ne 1 }">
							<c:url value="list" var="pageLink">
								<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
								<c:if test="${not empty param.search }">
									<c:param name="search" value="${param.search }" />
								</c:if>
								<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
							</c:url>
							<li class="page-item"><a class="page-link" href="${pageLink }">이전</a></li>
						</c:if>

						<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
							<c:url value="list" var="pageLink">
								<c:param name="page" value="${pageNum}" />
								<c:if test="${not empty param.search }">
									<c:param name="search" value="${param.search }" />
								</c:if>
							</c:url>
							<li class="page-item"><a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }">${pageNum}</a></li>
						</c:forEach>

						<!-- 다음 버튼 -->
						<c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
							<c:url value="list" var="pageLink">
								<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
								<c:if test="${not empty param.search }">
									<c:param name="search" value="${param.search }" />
								</c:if>
								<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
							</c:url>
							<li class="page-item"><a class="page-link" href="${pageLink }">다음</a></li>
						</c:if>

					</ul>
				</nav>
			</div>
		</div>



		<d:bottom></d:bottom>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script src="/js/semantic/semantic.min.js"></script>
</body>
</html>