<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<my:top></my:top>

<style>
.profile {
	position: relative;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

img {
	width: 100%;
	height: 100%;
}

.border {
	position: absolute;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	border-style: solid;
	border: 1px;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.item {
	align-items: center;
	justify-content: center;
}
</style>

</head>
<body>

	<my:navBar current="petList"></my:navBar>
	<my:alert></my:alert>

	<!-- security test -->
	<%-- <sec:authentication property="principal" /> --%>

	<!-- 상단 공백 -->
	<div style="margin-bottom: 5px"></div>

	<!-- 제목 -->
	<div class="ui center aligned container mb-5" id="title">
		<h1>나의 반려동물</h1>
	</div>

	<!-- 내 반려동물 리스트 -->
	<div class="ui center aligned container">
		<div class="ui link divided items">
			<c:forEach items="${petsList }" var="petsList">
				<div class="item" onclick="location.href='/id/${petsList.id }'">
					<div class="profile">
						<img src="${bucketUrl }/${petsList.id }/${petsList.photo}">
						<div class="border"></div>
					</div>
					<div class="content">
						<div class="ui huge header">${petsList.petName }</div>
						<div class="description">
							<p>${petsList.type }</p>
							<p>${petsList.birth }</p>
							<p style="display: none">${petsList.memberId}</p>

							<p>
								<i class="heart icon"></i>${petsList.diff.years}년 ${petsList.diff.months}개월째 함께 하는 중 입니다<i class="heart icon"></i>
							</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="ui center aligned container">
			<button class="ui large button" onclick="location.href='/registration'">추가하기</button>
		</div>
	</div>

	<my:bottom></my:bottom>

</body>
</html>