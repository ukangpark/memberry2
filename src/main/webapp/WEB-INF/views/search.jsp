<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<my:top />

<style>
#header {
	display: flex;
	justify-content: center;
}

#memberyLogo {
	width: 350px;
}
</style>

</head>
<body>

	<my:navBar></my:navBar>

	<!-- 상단로고 -->
	<div id="header">
		<img id="memberyLogo" src="/images/memberyLogo.png" alt="Membery logo" onclick="location.href='home'" style="cursor: pointer">
	</div>

	<!-- 검색창 -->
	<form action="/search/text" class="ui form" style="margin: 20px 300px 20px 300px; justify-content: center;">
		<div class="ui big icon fluid input">
			<input type="text" name="search" value="" placeholder="Search...">
			<i class="search icon"></i>
		</div>
	</form>

	<div class="searchImage">
		<a href="/feedId/${search.id}">
			<ul class="slider" id="imgContainer">
				<c:forEach items="${search.fileName }" var="fileName">
					<li id="li-imager"><img id="imager" class="ui medium rounded imager" src="${bucketUrl }/feed/${search.id }/${fileName }" alt="" /></li>
				</c:forEach>
			</ul>
		</a>
	</div>

	<my:bottom />
</body>
</html>