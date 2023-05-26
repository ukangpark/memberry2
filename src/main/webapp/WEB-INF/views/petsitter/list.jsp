<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="/js/semantic/semantic.min.js"></script>
</head>
<body>
	<div class="container-lg">
		<h1>펫시터 목록</h1>



		<div class="ui selection dropdown">
			<input type="hidden" name="city"> <i class="dropdown icon"></i>
			<div class="default text">시</div>
			<div class="menu">
				<div class="item" data-value="1">서울시</div>
				<div class="item" data-value="0">경기도</div>
			</div>
		</div>
		
		<div class="ui selection dropdown">
			<input type="hidden" name="city2"> <i class="dropdown icon"></i>
			<div class="default text">구</div>
			<div class="menu">
				<div class="item" data-value="1">강남구</div>
				<div class="item" data-value="0">강동구</div>
				<div class="item" data-value="0">강북구</div>
				<div class="item" data-value="0">강서구</div>
				<div class="item" data-value="0">관악구</div>
				<div class="item" data-value="0">광진구</div>
				<div class="item" data-value="0">구로구</div>
				<div class="item" data-value="0">금천구</div>
				<div class="item" data-value="0">노원구</div>
				<div class="item" data-value="0">도봉구</div>
				<div class="item" data-value="0">동대문구</div>
				<div class="item" data-value="0">동작구</div>
				<div class="item" data-value="0">마포구</div>
				<div class="item" data-value="0">서대문구</div>
				<div class="item" data-value="0">서초구</div>
				<div class="item" data-value="0">성동구</div>
				<div class="item" data-value="0">성북구</div>
				<div class="item" data-value="0">송파구</div>
				<div class="item" data-value="0">양천구</div>
				<div class="item" data-value="0">영등포구</div>
				<div class="item" data-value="0">용산구</div>
				<div class="item" data-value="0">은평구</div>
				<div class="item" data-value="0">종로구</div>
				<div class="item" data-value="0">중구</div>
				<div class="item" data-value="0">중랑구</div>
				
			</div>
		</div>
		
		
		<div class="ui selection dropdown">
			<input type="hidden" name="city"> <i class="dropdown icon"></i>
			<div class="default text">동</div>
			<div class="menu">
				<div class="item" data-value="1">서울시</div>
				<div class="item" data-value="0">경기도</div>
			</div>
		</div>



		<table class="table">
			<thead>
				<tr>
					<th>펫시터</th>
					<th>맡기는 곳</th>
					<th>연락처</th>
					<th>사진</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${petsitterList }" var="host">
					<tr>
						<td>${host.hostName }</td>
						<td>${host.address }</td>
						<td>${host.phone }</td>
						<td>${host.photo }</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>

	</div>

	<script>
		$('.ui.dropdown').dropdown();
		</script> 

	
</body>
</html>