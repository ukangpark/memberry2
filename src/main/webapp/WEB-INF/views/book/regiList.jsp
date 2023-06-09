<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약내역 (사용자)</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />


</head>
<body>
	 <d:navBar current="regiList" />  

	  
	<div class="container-lg">
	
		<h2 style="margin-top: 60px; margin-bottom: 0px; text-align:center;">
		<i class="fa fa-solid fa-paw"></i>
		예약내역
		<i class="fa fa-solid fa-paw"></i>
		</h2>
		
		<table class="table" style="margin-top:75px;">
			<thead>
				<tr>
					<th>pet 이름</th>
					<th>체크인 날짜</th>
					<th>체크아웃 날짜</th>
					<th>펫시터 이름</th>
					<th>예약 상태</th>
					<th>예약 변경</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bookList }" var="book">
					<tr>
						<td>
						<a href="/book/num/${book.num }">
						${book.petName }
						</a>
						</td>
						<td>${book.checkIn }</td>
						<td>${book.checkOut }</td>
						<td>
						<a href="/petsitter/detail?id=${book.detailId }">
						${book.hostName }
						</a>
						</td>
						<td>
						<button type="button" class="btn btn-warning">
						<c:if test="${book.accepted == 0}">요청중</c:if>
						<c:if test="${book.accepted == 1}">완료</c:if>
						</button>
						</td>
						<td>
						<c:if test = "${book.accepted == 0 }">
						<button type="button" class="btn btn-secondary" onclick="location.href='/book/modify/${book.num}'">변경</button>
						<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">삭제</button>
						</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-body">
      <br />
        확인을 누르시면 예약신청이 취소됩니다.
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-danger">확인</button>
      </div>
    </div>
  </div>
</div>



<div class="container-lg">
		<div class="row">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">

					<!-- 이전 버튼 -->
					<c:if test="${pageInfo.currentPageNum ne 1 }">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">이전</a></li>
					</c:if>
					
					<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageNum}" />
						</c:url>
						<li class="page-item"><a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }">${pageNum}</a></li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">다음</a>
						</li>
						</c:if>
						
				</ul>
			</nav>
		</div>
	</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
</body>
</html>