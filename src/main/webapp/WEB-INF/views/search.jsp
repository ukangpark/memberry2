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

	<form class="ui form" method="post" style="margin: 20px 200px 0px 200px; justify-content: center;">
		<div class="field">
			<div class="ui large fluid action input">
				<input type="text" name="search" placeholder="Search">
				<select class="ui compact selection dropdown" name="title" id="search-dropdown">
					<option value="Feed">피드</option>
					<option value="Petsitter">펫시터</option>
				</select>
				<button class="ui button" type="submit">
					<i class="search icon"></i>
				</button>
			</div>
		</div>
	</form>


	<!-- 검색한 피드 찾기 -->

	<my:bottom />
	<script>
		$('#search-dropdown').dropdown({
			direction : 'auto'
		});
	</script>
</body>
</html>