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
#memberyLogo {
	width: 600px;
	margin: 50px 0px 0px 0px;
}

.googleLogo {
	width: 30px;
	height: 30px;
	margin: 10px;
}

.naverLogo {
	width: 32px;
	height: 32px;
	margin: 10px;
}
</style>
</head>
<body>
	<my:navBar current="login"></my:navBar>

	<div class="ui center aligned container" id="container">

		<div class="row justify-content-center">
			<div class="col-12 col-md-8 ">
				<img id="memberyLogo" src="/images/memberyLogo.png" alt="Membery logo">
				<h1 style="margin: 0px 0px 50px 0px;">로그인</h1>

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
									<button type="submit" class="ui secondary submit button">로그인</button>
									<hr />
									<div class="field">
										<h5>소셜 계정으로 로그인</h5>
										<a href="/oauth2/authorization/google"><img class="googleLogo" src="/images/googleLogo.png" alt="" /></a>
										<a href="/oauth2/authorization/naver"><img class="naverLogo" src="/images/naverLogo.png" alt="" /></a>
									</div>
								</div>
							</div>
							<div class="middle aligned column">
								<div class="ui big button">
									<i class="handshake outline icon"></i> <a href="/member/signup" style="color: black;">회원가입</a>
								</div>
							</div>
						</div>
						<div class="ui vertical divider">Or</div>
					</div>
				</form>

				<span> <c:if test="${error}">
						<p id="valid" class="alert alert-danger">${exception}</p>
					</c:if>
				</span>

			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
</body>
</html>