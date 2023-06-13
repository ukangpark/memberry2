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

<my:top></my:top>

<style>
#buttons {
	margin: auto;
}

#img{
	width : 400px;
}
</style>
</head>
<body>

	<my:navBar current="memberInfo"></my:navBar>
	<my:alert></my:alert>

	<div style="margin-top: 100px; margin-bottom: 50px;">
		<div class="ui aligned container" id="imgContainer">
			<img class="ui centered medium circular image" src="/img/MemberyLogo.png" id="img">
		</div>
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
			<a class="ui secondary button" href="/member/modify?id=${member.id }" style="margin: 20px; font-size: 16px;">수정</a>
			<button type="button" data-bs-toggle="modal" class="ui red button" data-bs-target="#confirmModal" style="margin: 20px; font-size: 16px;">탈퇴</button>
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
						<input type="hidden" name="id" value="${member.id }" /> <label for="passwordInput1">비밀번호 입력</label> 
						<input id="passwordInput1" type="password" name="password" class="form-control" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="ui button" data-bs-dismiss="modal">취소</button>
					<button type="submit" form="removeForm" class="ui red button">탈퇴</button>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
	
</body>
</html>