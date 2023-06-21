<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세페이지 추가하기</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<my:navBar></my:navBar>
	<my:logo></my:logo>
	<br>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<form id="addDetailForm" class="ui big form" method="post" action="/petsitter/addDetail">
					<h1 class="ui dividing header">상세페이지 등록하기</h1>
					<div class="field">
						<label for="title">제목</label>
						<input id="title" type="text" name="title" placeholder="제목을 입력해주세요.">
					</div>
					<div class="field">
						<label for="body">소개글</label>
						<textarea id="body" type="text" name="body" rows="20" placeholder="소개글을 입력해주세요."></textarea>
					</div>
					<input type="hidden" name="hostId" value="${host.id }">
					<input type="hidden" name="memberId" value="${member.id }">
				</form>
			</div>

			<!-- 버튼 -->
			<div class="extra content">
				<div class="ui two buttons">
					<a href="/petsitter/hostMyPage" class="ui basic red button">뒤로 돌아가기</a>
					<button form="addDetailForm" type="submit" class="ui basic green button">집사진 등록하기</button>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
	<script src="/js/semantic/semantic.min.js"></script>
</body>
</html>