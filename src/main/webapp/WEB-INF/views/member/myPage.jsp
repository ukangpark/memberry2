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
#leftContainer {
	width: 300px;
	padding: 0px;
	margin: 0px;
}

label {
	font-weight: bold;
}

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
	align-items: center;
	justify-content: center;
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
	justify-content: center;
}

#secondColumn, #thirdColumn {
	border: 1px;
	border-style: solid;
	border-color: #cccccc;
	padding: 0px;
}
</style>

</head>
<body>
	<my:navBar current="myPage"></my:navBar>

	<!-- security test -->
	<%-- <sec:authentication property="principal" /> --%>

	<!-- 상단 공백 -->
	<div style="margin-bottom: 5px"></div>

	<!-- 제목 -->
	<div class="ui center aligned container mb-5" id="title">
		<h1>마이페이지</h1>
	</div>


	<!-- 컨테이너 -->
	<div class="eight wide column">
		<div class="ui left aligned container" id="leftContainer">
			<!-- 프로필 -->
			<div class="profile">
				<img src="">
				<div class="border"></div>
			</div>
			<!-- 공개/비공개 -->
			<div class="ui toggle checkbox mt-5">
				<input type="checkbox" tabindex="0" class="hidden">
				<label>피드 공개 여부</label>
			</div>
			<br>
			<!-- 회원탈퇴 -->
			<button class="ui red button mt-5" id="removeMember">회원탈퇴</button>
		</div>

		<div class="ui right aligned container" id="rightContainer">
			<div class="field">
				<h2>함께가기 스크랩</h2>

				<h2>펫시터 스크랩</h2>
			</div>
		</div>
	</div>


	<my:bottom />

	<script>
		$('.ui.checkbox').checkbox();
	</script>
</body>
</html>