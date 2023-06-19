<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnAForWhat</title>
<my:top />
</head>
<body>
	<my:navBar current="qnaForWhat"></my:navBar>
	<my:alert></my:alert>
	<div class="container-lg">
		<h1>QnA no.${qna.id }</h1>
		<div>제목 : ${qna.title }</div>
		<div>
			본문 :
			<div>${qna.body }</div>
		</div>
		<div>작성자 : ${qna.writer}</div>
		<div>작성일시 : ${qna.inserted }</div>
	</div>
	<div>
		<a class="ui secondary button" href="/qna/modify/${qna.id }"> 수정하기 </a>
	</div>





	<my:bottom />
</body>
</html>