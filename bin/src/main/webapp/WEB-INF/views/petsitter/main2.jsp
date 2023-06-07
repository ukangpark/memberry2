<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

</head>
<body>
	<my:navBar current="main"></my:navBar>
	<div class="container">
		<h1>Membery</h1>

		<div class="ui cards">
			<c:forEach items="${host }" var="host">
				<div class="ui card inblock">
					<div class="image">
						<img src="https://img.hani.co.kr/imgdb/original/2007/1227/68227042_20071227.jpg">
					</div>
					<div class="content">
						<a class="header">${host.hostName }</a>
						<div class="meta">
							<span class="date">${host.si }시 ${host.gu }구 ${host.dong }동</span>
						</div>
						<div class="description">경력 : ${host.experience }</div>
						<div class="description">반려견 : ${host.pet }</div>

					</div>
					<div class="extra content">
						<a class="inblock">
							<i class="comment icon"></i>
							댓글 개수 표시
						</a>
						<form class="right floated inblock" action="/petsitter/detail" id="idForm">
							<input class="d-none" type="text" name="id" value="${host.id }">
							<input class="ui primary button" type="submit" value="상세보기">
						</form>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>

</body>
</html>