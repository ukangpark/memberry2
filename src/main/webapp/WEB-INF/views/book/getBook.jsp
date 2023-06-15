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

<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">

<d:top />

</head>
<body>

	<d:navBar current="regiFormModify" />
	
	<div class="container-lg">
	<div style="margin: 100px 300px 300px 300px; border: 8px double lightblue;">
	<h1>${book.petName }의 예약내역</h1>
	<div>
		체크인 : ${book.checkIn }
	</div>
	<div>
		체크아웃 : ${book.checkOut }
	</div>
	<div>
		자주 다니는 동물병원 : <div>${book.hospital }</div>
	</div>
	<div>
		전하고 싶은 말 : <div>${book.message }</div>
	</div>
	
	</div>
	</div>

	
	<d:bottom></d:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>

</body>
</html>