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
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" />
</head>

<style>
		.pageName {
			height: 120px;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		
		.wrapper {
			display: flex;
			justify-content: space-around;
			align-items: center;
			min-height: 75vh;
			background-color: #EEEEEE;
			margin-right: 15%;
			margin-left: 15%;
			border-radius: 1.5rem;
			position: relative;
		}

		.bx-wrapper {
			flex-grow: 3;
			margin-left: 1rem;
		} 
		
		#content {
			flex-grow: 2; 
			margin-right: 10rem;
			margin-left: 10rem;
		}
		
		#drop {
			flex-grow: 0.5; 
			position: absolute; 
			float: right;
		}
	
		
</style>
<body style="background-color:#FFF2F2">

	<my:navBar />

	<div class="pageName">
		<h1>${feed.id }번 게시물</h1>
	</div>
		
	<div class="wrapper">
	
		<!-- 이미지 파일 출력 -->
			<ul class="bxslider">
				<c:forEach items="${feed.fileName }" var="fileName" >
					<li>
						<img class="ui medium rounded imager" src="${bucketUrl }/${feed.id }/${fileName }" alt="" />
					</li>
				</c:forEach>
			</ul>

	<div class="d-flex" style="height: 200px;">
  		<div class="vr"></div>
	</div>
			
		<!-- text content -->
		<div class="content">
			<div class="ui segment">
				제목 : ${feed.title }
			</div>
			<div class="ui segment" style="font-weight:600;">
				본문 : ${feed.content }
			</div>
			<div class="ui segment">
				작성자 : ${feed.writer }
			</div>
			<div class="ui segment">
				작성일시 : ${feed.inserted }
			</div>
			<div class="ui segment">
				장소 태그 : ${feed.location }
			</div>
		</div>
		
				<!-- Default dropend button -->
		<div class="drop">
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
			
			<!-- 삭제하기 기능 -->
			<div class="d-none">
				<form action="/remove" method="post" name="removeForm">
					<input type="text" name="id" value="${feed.id }"/>
				</form>
			</div> 
		
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
		  let slider = $('.bxslider').bxSlider({
			  slideWidth: 400
		  });
		});
	</script>
</body>
</html>