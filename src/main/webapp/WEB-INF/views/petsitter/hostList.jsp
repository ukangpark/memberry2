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
	<div class="container">
		<h1>호스트 리스트</h1>
		<table class="ui fixed single line celled table">
			<thead>
				<tr>
					<th>Name</th>
					<th>Id(memberId)</th>
					<th>phone</th>
					<th>detail</th>
					<th>profile</th>
				</tr>
			</thead>
			<tbody>
 				<c:forEach items="${host }" var="host">
					<tr>
						<td>
							<a href="/petsitter/hostMyPage?id=${host.id }">${host.hostName }</a>
						</td>
						<td>${host.id } (${host.memberId })</td>
						<td>${host.phone }</td>
						<td>${host.detail eq 'true' ? '등록' : '미등록' }</td>
						<td>${host.profile }</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</div>
	<my:bottom></my:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>