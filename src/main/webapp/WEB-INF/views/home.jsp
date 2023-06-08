<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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

<style>

#header {
	text-align: center;
	margin: 40px 0;
	display: flex;
	justify-content: center;
}

#imgContainer {
	width: 300px;
	height: 350px;
}

#imgContainer>#img {
	width: 100%;
	height: 100%;
}

.wrapper {
	display: flex;
	justify-content: space-around;
	align-items: center;
	min-height: 100vh;
	margin-right: 10%;
	margin-left: 10%;
	border-radius: 1.5rem;
	position: relative;
}

.slider {
	text-align: center;
}

.bx-wrapper {
	position: relative;
}

.bx-controls-direction {
	font-size: 50px;
}

.bx-controls-direction a {
	position: absolute;
	top: 50%;
	display: block;
	width: 100px;
	height: 100px;
	overflow: hidden;
	transform: translateY(-50%);
	color: #5a5a5a;
}

.bx-controls-direction .bx-prev {
	left: 0;
}

.bx-controls-direction .bx-next {
	right: 0;
}

.bx-controls-direction .bx-prev:before {
	content: "\e93d";
	font-family: 'xeicon';
}

.bx-controls-direction .bx-next:before {
	content: "\e940";
	font-family: 'xeicon';
}

.bx-pager {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	text-align: center;
}

.bx-pager div {
	display: inline-block;
	padding: 0 3px;
}

.bx-pager div a {
	display: block;
	width: 3px;
	height: 3px;
	background-color: #999;
	font-size: 0;
	border-radius: 50px;;
	color: transparent;
}

.bx-pager div a.active {
	background-color: #000;
}

/* 댓글 모달 css */
.modal-title {
	font-weight: bold;
}



.modal-content {
	overflow-y: initial !important
}

.modal-body > #commentListContainer{
	height: 250px;
	overflow-y: auto;
}
</style>
<!-- bxslider -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

</head>
<body>

		<my:navBar current="home" />

<div class="toast-container position-fixed  top-0 start-50 translate-middle-x p-3">
	  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
	  <div class="d-flex">
	    <div class="toast-body"> </div>
	      <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		  </div>
	  </div>
	</div>

	<div id="header">
		<h2>Membery</h2>
	</div> 
	

	<div class="wrapper">

		<div class="ui center aligned container" id="container">
			<div class="ui link cards">
				<c:forEach items="${feedList}" var="feed">

					
				<!-- 좋아요 기능을 위한 id 값 불러오기 -->
				<span id="feedIdText" class="d-none">
					${feed.id }
				</span>
							
					<div class="ui card" style="margin: 30px;">
						<div class="content">
							<!-- 이미지 파일 출력 -->
							<br />
							<ul class="slider" id="imgContainer">
								<c:forEach items="${feed.fileName }" var="fileName">

									<li><a href="/feedId/${feed.id}"> <img id="img" class="ui medium rounded imager" src="${bucketUrl }/${feed.id }/${fileName }" alt="" />
									</a></li>

								</c:forEach>
							</ul>
						</div>
						<div class="content">
							<div class="header">${feed.title}</div>
							<div class="meta">
								<a>${feed.writer}</a>
							</div>
							<div class="description">${feed.content}</div>
						</div>
						<div class="extra content">
							<span class="left floated"> 
							
							<span id="likeIcon" >
								<img src="/images/olhomebone.png">
							</span>
							<span id="likeNumber">
								${feed.likeCount } 
							</span> likes 
								<!-- Button trigger modal -->
								<button type="button" class="btn btn-secondary-link" data-bs-toggle="modal" data-bs-target="#commentModal">
									<i class="fa-solid fa-comment"></i>
								</button> <i class="paw icon"></i>

							</span> <span class="right floated">${feed.inserted}</span>
						</div>
					</div>


				</c:forEach>

			</div>
		</div>
	</div>

	<!-- <i class="xi-angle-left-thin"></i>
	<i class="xi-angle-right-thin"></i> -->


	<%-- <div class="ui center aligned container" id="container"
		style="background-color: #e2e2e2;">
		<div class="ui link cards">
			


			<c:forEach items="${feedList}" var="feed">
				<div class="ui card" style="margin: 15px 40px;">
					<div class="ui slide masked reveal image" id="imgContainer">
						<a href="/feedId/${feed.id}">	
							<img id="image1" src="${bucketUrl }/${feed.id }/${feed.fileName[0] }" alt=""class="visible content" />
					 	 	<img id="image2" src="${bucketUrl }/${feed.id }/${feed.fileName[1] }" alt="" class="hidden content" />					
						</a>

					</div>
					<div class="content">
						<div class="header">${feed.title}</div>
						<div class="meta">
							<a>${feed.writer}</a>
						</div>
						<div class="description">${feed.content}</div>
					</div>
					<div class="extra content">
						<span class="left floated"> 
							<span id="likeIcon" >
								<img src="/images/olhomebone.png">
							</span>
							<span id="likeNummber">
								${feed.likeCount }
							</span>
							likes
							<!-- Button trigger modal -->
							<button type="button"  class="btn btn-secondary-link"
								data-bs-toggle="modal" data-bs-target="#commentModal">
								<i class="fa-solid fa-comment"></i>
							</button>
							<i class="paw icon"></i> 

						</span> <span class="right floated">${feed.inserted}</span>
					</div>
				</div>
			</c:forEach>

		</div>
	</div> --%>


	<!-- 댓글 modal -->
	<div class="modal fade " id="commentModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">댓글</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h3>
						<i class="fa-solid fa-comments"></i>
					</h3>
					<div class="input-group">
						<div class="form-floating">
							<textarea id="commentTextArea" class="form-control" style="height: 50px; margin-bottom: 20px;" placeholder="댓글을 남겨주세요"></textarea>
							<label for="floatingTextArea">댓글을 남겨주세요</label>
						</div>
						<button id="sendCommentBtn" class="btn btn-outline-primary" style="height: 50px;">
							<i class="fa-regular fa-paper-plane"></i>
						</button>
					</div>
					<div id="updateCommentContainer">
						<h6>수정</h6>
						<input type="hidden" id="commentUpdateInput"/>
						<textarea id="commentUpdateTextArea" ></textarea>
						<button id="updateCommentBtn">수정</button>
					</div>

					<ul class="list-group" id="commentListContainer">


					</ul>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>




	<script src="/js/home.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>

	<script src="/js/feed/like.js"></script>
</body>
</html>