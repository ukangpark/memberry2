<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MemberInfo</title>
<style>
#buttons {
	margin: auto;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
</head>
<body>

	<my:navBar current="memberInfo"></my:navBar>

	<div style="margin-top: 50px; margin-bottom: 15px;"></div>
	<div class="ui aligned container" id="imgContainer">
		<img class="ui centered medium circular image" src="/img/MemberyLogo.png">
	</div>

	<div class="ui grid container" id="container">

		<div class="eight wide column">
			<div class="ui left aligned container" id="leftContainer">

				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">아이디</div>
					<input class="form-control" type="text" value="${member.id }" style="font-size: 18px; text-align: center;" readonly />
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">이름</div>
					<input class="form-control" type="text" value="${member.name }" style="font-size: 18px; text-align: center;" readonly />
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">별명</div>
					<input class="form-control" type="text" value="${member.nickName }" style="font-size: 18px; text-align: center;" readonly />
				</div>
			</div>
		</div>

		<div class="eight wide column">
			<div class="ui right aligned container" id="rightContainer">

				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">연락처</div>
					<input class="form-control" type="text" value="${member.phoneNumber }" style="font-size: 18px; text-align: center;" readonly />
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">이메일</div>
					<input class="form-control" type="email" value="${member.email }" style="font-size: 18px; text-align: center;" readonly />
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">비밀번호</div>
					<input class="form-control" type="password" value="${member.password }" style="font-size: 18px; text-align: center;" readonly />
				</div>
			</div>
		</div>

		<div id="buttons">
			<a class="btn btn-warning" href="/member/modify?id=${member.id }" style="margin: 20px; font-size: 18px;">수정</a>
			<button type="button" data-bs-toggle="modal" class="btn btn-danger" data-bs-target="#confirmModal" style="margin: 20px; font-size: 18px;">탈퇴</button>
		</div>
	</div>
	
	<!-- 탈퇴 확인 Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">탈퇴 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="removeForm" action="/member/remove" method="post">
						<input type="hidden" name="id" value="${member.id }" /> <label for="passwordInput1">암호</label> <input id="passwordInput1" type="password" name="password" class="form-control" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" form="removeForm" class="btn btn-danger">탈퇴</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>