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

.searchContainer {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	grid-template-rows: masonry;
	grid-gap: 10px;
	margin-left: 5%;
	margin-right: 5%;
}

#imager {
	width: 100%;
	border-radius: 10%;
}
</style>

</head>
<body>

	<my:navBar></my:navBar>

	<!-- 상단로고 -->
	<div id="header">
		<img id="memberyLogo" src="/images/memberyLogo.png" alt="Membery logo" onclick="location.href='/home'" style="cursor: pointer">
	</div>

	<!-- 검색창 -->
	<form action="/search/text" class="ui form" style="margin: 20px 300px 20px 300px; justify-content: center;">
		<div class="ui big icon fluid input">
			<input type="text" name="search" value="${param.search }" placeholder="Search...">
			<i class="search icon"></i>
		</div>
	</form>

	<div class="searchContainer">
		<%-- <a href="/feedId/${search.feedId}"> --%>
		<c:forEach items="${search}" var="search">
			<div class=item>
				<img id="imager" class="ui medium rounded imager" src="${bucketUrl }/feed/${search.feedId }/${search.fileName }" alt="" />
			</div>
		</c:forEach>
		<!-- </a> -->
	</div>

	<my:bottom />
</body>
</html>