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

<my:top></my:top>

</head>
<body>
	<div class="container-lg">
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
	
	<my:bottom></my:bottom>
	
</body>
</html>