<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<style>
.qna {
	width: 350px;
	margin-left: 150px;
}
.no{
	margin:0px 0px 20px 0px;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<my:top />
</head>
<body>
	<my:navBar current="/qna/add" />
	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
			<a href="/qna"><img class="qna" src="/images/qnaDetailLogo.png" alt="" /></a>
				<div class="d-flex">
					<div class="no">
						<h1>질문 작성 페이지</h1>
					</div>
				</div>
				<form method="post">
					<div class="mb-3">
						<label for="titleInput" class="form-label">제목</label>
						<input id="titleInput" class="form-control" type="text" name="title" value="${qna.title }" />
					</div>
					<div class="mb-3">
						<label for="bodyTextarea" class="form-label">본문</label>
						<textarea rows="10" id="bodyTextarea" class="form-control" name="body">${qna.body }</textarea>
					</div>
					
					<div class="mb-3">
						<input class="btn btn-primary" type="submit" value="등록" />
					</div>
				</form>
			</div>
		</div>
	</div>
<my:bottom />
</body>
</html>