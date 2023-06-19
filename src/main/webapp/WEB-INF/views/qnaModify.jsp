<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnAModify</title>
<my:top />
</head>
<body>
	<my:navBar current="qnaModify"></my:navBar>
	<my:alert></my:alert>
	<div class="container-lg">
		<h1>${qna.id }QnA수정</h1>
		<form method="post">
			<div>
				제목: <input type="text" name="title" value="${qna.title }" />
			</div>
			<div>
				본문 :
				<textarea name="body">${qna.body }</textarea>
			</div>
			<div>
				작성자 : <input type="text" name="writer" value="${qna.writer }" />
			</div>
			<div>
				작성일시 : <input type="text" value="${qna.inserted }" />
			</div>
			<input type="submit" value="수정" />
	</form>
	</div>
	<my:bottom />
</body>
</html>