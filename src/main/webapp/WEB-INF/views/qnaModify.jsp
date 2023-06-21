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
<title>QnAModify</title>
<my:top />
</head>
<body>
	<my:navBar current="qnaModify"></my:navBar>
	<my:alert></my:alert>
	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
			<a href="/qna"><img class="qna" src="/images/qnaDetailLogo.png" alt="" /></a>
				<div class="d-flex">
					<div class="no">
						<h1>${qna.writer }님의 질문 수정 페이지</h1>
					</div>
				</div>
				<form method="post">
					<input type="hidden" name="writer" value="${qna.writer }" />
					<div class="mb-3">
						<label for="titleInput" class="form-label">제목</label> <input class="form-control" id="titleInput" type="text" name="title" value="${qna.title }" />
					</div>
					<div class="mb-3">
						<label for="bodyTextarea" class="form-label">본문</label>
						<textarea class="form-control" id="bodyTextarea" rows="10" name="body">${qna.body }</textarea>
					</div>
					<div class="mb-3">
						<label for="" class="form-label">작성일시</label> <input class="form-control" type="text" value="${qna.inserted }" readonly />
					</div>
					<div class="mb-3">
						<input class="btn btn-secondary" type="submit" value="수정" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<my:bottom />
</body>
</html>