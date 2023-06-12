<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>LogIn</title>

<my:top></my:top>

<style>
img {
	width: 400px;
	margin: 100px 0px 30px 0px;
}
</style>
</head>
<body>
	<my:navBar current="login"></my:navBar>

	<div class="ui center aligned container" id="container">

		<div class="row justify-content-center">
			<div class="col-12 col-md-8 ">
				<img src="/img/MemberyLogo.png" alt="Membery logo">
				<h1 style="margin: 30px 0px 50px 0px;">로그인</h1>
				<form method="post">
					<div class="ui stacked segment">
						<div class="ui two column very relaxed stackable grid">
							<div class="column">
								<div class="ui form">
									<div class="field">
										<div class="ui left icon input">
											<i class="user icon"></i> <input type="text" name="username" placeholder="아이디" />
										</div>
									</div>
									<div class="field">
										<div class="ui left icon input">
											<i class="lock icon"></i> <input type="password" name="password" placeholder="비밀번호" />
										</div>
									</div>
									<button type="submit" class="ui secondary submit button"> 로그인 </button>
								</div>
							</div>
							<div class="middle aligned column">
								<div class="ui big button">
									<i class="handshake outline icon"></i> <a href="/member/signup" style="color:black;">회원가입</a>
								</div>
							</div>
						</div>
						<div class="ui vertical divider">Or</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<my:bottom></my:bottom>
</body>
</html>