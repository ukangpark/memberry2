<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">
</head>
<body>

	<my:navBar />

	<div class="container-lg">
		<div class="col-12 col-md-8 col-lg-6">
		<h1>새로운 스토리를 추가해보세요!</h1>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		
		<form method="post" enctype="multipart/form-data" id="addForm">
			<!-- 이미지 파일 업로드 -->
			<div>
				사진을 등록해보세요! <br />
				 <input type="file" multiple name="files" accept="image/*" />
			</div>
			<br />
			<div>
				제목을 입력하세요  <input type="text" name="title" value="${feed.title }"/>
				</div>
			<br />	
			<div>
				내용을 입력하세요  <textarea name="content">${feed.content }</textarea>
			</div>
			<br />
			<div>
				작성자  <input type="text" name="writer" value="${feed.writer }"/>
			</div>
			<br />
			<div>
				장소를 태그하세요  <input type="text" name="location" value="${feed.location }"/>
			</div>
			<br />
		</form>
		<button type="submit" form="addForm" id="addButton">추가하기</button>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>

</body>
</html>