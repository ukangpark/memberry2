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
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">

<d:top />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>

<style>
h1{ text-align : center;
	/* 왜안댕.. */font-family:fantasy;
	
}

</style>

</head>
<body>
<d:navBar current="list" />


	<div class="container-lg">
		<a href = "list" style = "color:black">
		<br />
		<h1>
		<i class="fa fa-solid fa-paw"></i>
		펫시터 목록
		<i class="fa fa-solid fa-paw"></i>
		</h1>
		</a>
<br />
<br />

<br />
<br />

<form action="list" class="d-flex" role="search">
        <input value="${param.search }" name="search" class="form-control me-2" type="search" placeholder="맡기고 싶은 지역을 검색해보세요" aria-label="Search">
        <button class="btn btn-outline-success" type="submit" style="width:80px">검색</button>
      </form>

	<!-- <script>
		$('.ui.dropdown').dropdown();
	</script> -->

<hr />


	<div class="ui link cards" >
    <c:forEach items="${petsitterList }" var="host">
  <div class="card">
    <div class="image">
    	<img src="/home1.jpg" alt="" height="70" />
    </div>
    <div class="content">
      <div class="header">${host.title }</div>
      <div class="meta" >
        <a href="/petsitter/detail?id=${host.id }">${host.si } ${host.gu } ${host.dong }</a>
      </div>
      <div class="description">
        ${host.houseType }, ${host.pet }, ${host.species }
      </div>
    </div>
    <div class="extra content">
      <span class="right floated">
      
        하루 40,000원~
      </span>
      <span>
        <i class="comments icon"></i>
        후기  ${host.commentCount }개
      </span>
    </div>
  </div>
 
  </c:forEach>
</div>
	
	<br />
	<br />
	
	<div class="container-lg">
		<div class="row">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">

					<!-- 이전 버튼 -->
					<c:if test="${pageInfo.currentPageNum ne 1 }">
						<c:url value="list" var="pageLink">
						<c:param name="page" value="${pageNum}" />
							<c:if test ="${not empty param.search }">
							<c:param name="search" value="${param.search }" />
							</c:if>
							<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">이전</a></li>
					</c:if>

					<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageNum}" />
							<c:if test ="${not empty param.search }">
							<c:param name="search" value="${param.search }" />
							</c:if>
						</c:url>
						<li class="page-item"><a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }">${pageNum}</a></li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
						<c:url value="list" var="pageLink">
						<c:param name="page" value="${pageNum}" />
							<c:if test ="${not empty param.search }">
							<c:param name="search" value="${param.search }" />
							</c:if>
							<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">다음</a>
						</li>
						</c:if>
						
				</ul>
			</nav>
		</div>
	</div>
	

	<d:bottom></d:bottom>


</body>
</html>