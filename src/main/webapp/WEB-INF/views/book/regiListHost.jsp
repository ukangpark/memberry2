<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약요청 목록(펫시터)</title>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<d:top />

</head>
<body>

<script>
    // 클릭된 버튼의 id를 사용하여 원하는 동작 수행
function handleButtonClick(event) {
    var clickedButtonId = event.target.id;
    var num = clickedButtonId.split("_")[1];
    $.ajax("/book/accept", {
		method:"post",
		contentType: "application/json",
		data: JSON.stringify(num),
		success: function(){
			location.reload();
		}
	})
  }
</script>

<d:navBar current="regiListHost" />

	<div class="container-lg">
	
	   
	   
		<h2 style="margin-top: 60px; margin-bottom: 0px; text-align:center;">
		<i class="fa fa-solid fa-paw"></i>
		예약요청 목록 
		<i class="fa fa-solid fa-paw"></i>
		</h2>
		
		<table class="table" style="margin-top:75px;">
			<thead>
				<tr>
					<th>pet 이름 </th>
					<th>체크인 날짜</th>
					<th>체크아웃 날짜</th>
					<th>보호자 이름</th>
					<th>예약 상태</th>
					<th>승인 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bookList }" var="book">
					<tr>
						<input type="hidden" id="num" value="${book.num }" />
						<td>
						<a href="/book/num/${book.num }">
						${book.petName }
						</a>
						</td>
						<td>${book.checkIn }</td>
						<td>${book.checkOut }</td>
						<td>
						${book.memberId }
						</td>
						<td>
						<button type="button" class="btn btn-warning">
						<c:if test="${book.accepted == 0}">승인대기</c:if>
						<c:if test="${book.accepted == 1}">예약확정</c:if>
						</button>
						</td>
						<td>
						<c:if test = "${book.accepted == 0 }">
						<button id="acceptBtn_${book.num }" type="button" class="btn btn-secondary" onclick="handleButtonClick(event)">승인</button>
						<button type="button" class="btn btn-danger" >거절</button>
						</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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
						<c:url value="" var="pageLink">
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

<d:bottom></d:bottom>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>