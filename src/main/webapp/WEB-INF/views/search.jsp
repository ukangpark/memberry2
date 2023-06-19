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

	<div id="header">
		<img id="memberyLogo" src="/images/memberyLogo.png" alt="Membery logo" onclick="location.href='home'" style="cursor: pointer">
	</div>

	<div class="ui center aligned container" style="margin-top: 20px">
		<div class="ui big fluid action input">
			<input type="text" placeholder="Search...">
			<select class="ui compact selection dropdown" id="search-dropdown">
				<option value="all">피드</option>
				<option value="products">펫시터</option>
			</select>
			<div class="ui button">
				<i class="search large icon"></i>
			</div>
		</div>
	</div>


	<!-- 검색한 피드 찾기 -->

	<my:bottom />
	<script>
		$('#search-dropdown').dropdown({
			direction : 'auto'
		});
	</script>
</body>
</html>