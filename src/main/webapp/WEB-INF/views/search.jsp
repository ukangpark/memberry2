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
	margin-top: 40px;
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
	<form action="/search/text" class="ui form" style="margin: 20px 150px 20px 150px; justify-content: center;">
		<div class="ui massive icon fluid input">
			<input type="text" name="search" value="${param.search }" placeholder="Search...">
			<i class="search icon"></i>
		</div>
	</form>


	<div class="searchContainer" style="margin: 0px 150px 0px 150px">

		<c:forEach items="${search}" var="search">
			<a href="/feedId/${search.feedId}">
				<div class="item" style="position: relative;">
					<img id="imager" class="ui medium rounded imager" src="${bucketUrl }/feed/${search.feedId }/${search.fileName[0] }" alt="" />
					<c:if test="${search.fileName.size() gt 1 }">
						<i style="position: absolute; z-index: 9999; color: white" class="images outline large icon start-0"></i>
					</c:if>
				</div>
			</a>
		</c:forEach>
	</div>

	<my:bottom />
</body>
</html>