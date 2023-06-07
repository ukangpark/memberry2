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
		<h1>${feed.id }번 게시물</h1>
		
		
		<!-- 이미지 파일 출력 -->
		<div class="mb-3">
			<c:forEach items="${feed.fileName }" var="fileName" >
				<div class="mb-3">
					<img class="img-thumnail img-fluid" src="${bucketUrl }/${feed.id }/${fileName }" alt="" />
				</div>
			</c:forEach>
		</div>
		
		
		<!-- Default dropend button -->
		<!-- <div class="d-flex flex-row-reverse mt-3"> -->
			<div class="btn-group dropend">
			  <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			    <i class="fa-solid fa-ellipsis-vertical"></i>
			  </button>
			  <ul class="dropdown-menu">
			    <!-- Dropdown menu links -->
			    <div style="text-align:center">
			    	<a href="/modify/${feed.id }">수정하기</a>
			    </div>
			    <div style="text-align:center">
			    	<a href="#" onclick="javascript:document.removeForm.submit();">삭제하기</a>
			    </div> 
			  </ul>
			</div>
			
			<div class="d-none">
				<form action="/remove" method="post" name="removeForm">
					<input type="text" name="id" value="${feed.id }"/>
				</form>
			</div> 
			
		
		<div>
			제목 : ${feed.title }
		</div>
		<div>
			본문 : ${feed.content }
		</div>
		<div>
			작성자 : ${feed.writer }
		</div>
		<div>
			작성일시 : ${feed.inserted }
		</div>
		<div>
			장소 태그 : ${feed.location }
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>

</body>
</html>