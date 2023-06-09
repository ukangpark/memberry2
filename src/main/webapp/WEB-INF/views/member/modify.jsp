<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberModify</title>

<style>
.container{
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>

<my:top></my:top>

</head>
<body>

	<my:navBar current="memberInfo"></my:navBar>

	<my:alert></my:alert>

	<div class="ui center aligned container" id="container">
	
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 ">
			
				<div style="margin:30px 0px 50px 0px;">
					<h1>회원정보수정</h1>
				</div>
				
				<form id="modifyForm" action="/member/modify" method="post">
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">아이디</div>  
						<input id="inputId" class="form-control" type="text" name="id" value="${member.id }" style="font-size: 18px; text-align: center;" readonly />
					</div>
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">이름</div>  
						<input id="inputName" class="form-control" type="text" name="name" value="${member.name }" style="font-size: 18px; text-align: center;" readonly />
					</div>
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">비밀번호</div>
						<input id="inputPassword" class="form-control" type="password" name="password" style="font-size: 18px; text-align: center;" value="" />
					</div>
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">닉네임</div>
						<input id="nickName" class="form-control" type="text" name="nickName" value="${member.nickName }" style="font-size: 18px; text-align: center;"/>
					</div>
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">이메일</div>
						<input class="form-control" type="email" name="email" value="${member.email }" style="font-size: 18px; text-align: center;"/>
					</div>
					<div class="ui fluid labeled big input mt-5">
					<div class="ui label">연락처</div>
						<input id="inputPhoneNumber" class="form-control" type="text" name="phoneNumber" value="${member.phoneNumber }" style="font-size: 18px; text-align: center;"/>
					</div>
					<button type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="ui secondary submit button" style="font-size:16px; margin:20px;">저장</button>
				</form>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<label for="inputOldPassword" class="form-label">암호 입력</label>
					<input form="modifyForm" id="inputOldPassword" class="form-control" type="text" name="oldPassword" />
				</div>
				<div class="modal-footer">
					<button type="button" class="ui button" data-bs-dismiss="modal">취소</button>
					<button type="submit" form="modifyForm" class="ui secondary button">저장</button>
				</div>
			</div>
		</div>
	</div>

<my:bottom></my:bottom>

</body>
</html>