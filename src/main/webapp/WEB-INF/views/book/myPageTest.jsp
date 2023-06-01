<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지 테스트용</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="semantic/dist/semantic.min.js"></script>
</head>
<body>
	<div class="container-lg">
	
	   <i class="fa-duotone fa-paw" style="--fa-primary-color: #ffd6e2; --fa-secondary-color: #a6969b;"></i>
		<h3>
		예약목록
		</h3>
		<i class="fa-duotone fa-paw" style="--fa-primary-color: #ffd6e2; --fa-secondary-color: #a6969b;"></i>
		
		<table class="table">
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
						<a href="/petsitter/detail?id=${book.id }">
						${book.hostName }
						</a>
						</td>
						<td>
						<button type="button" class="btn btn-warning">${book.accepted }</button>
						</td>
						<td>
						<button type="button" class="btn btn-secondary" onclick="location.href='/book/regiFormModify'">변경</button>
						<button type="button" class="btn btn-danger" >삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


</body>
</html>