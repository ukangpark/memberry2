<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="jakarta.tags.core"%>
	<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Insert title here</title>

<my:top></my:top>
<style>
.header {
	display: flex;
	justify-content: center;
	margin-bottom: 50px;
	margin-top: 30px;
}

</style>
</head>
<body>
	<my:navBar></my:navBar>
	
	<div class="header" style="text-align: center;">
		<h2> <span id="memberId">${logedInMember.id }</span>
		<i class="fa-solid fa-bell"></i> 알림</h2>
	</div>

	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
				<c:forEach items="${alarms }" var="alarm">
				<div>${alarm }</div>				
				</c:forEach>

			</div>
		</div>
	</div>



<my:bottom></my:bottom>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="/js/alarm.js"></script>
</body>
</html>