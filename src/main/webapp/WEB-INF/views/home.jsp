<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>

<style>

#linkCards {
	display: flex;
	justify-content: center;
	
}

 #header {
	display: flex;
	justify-content: center;
	
} 

#memberyLogo {
	width: 350px;
}


.wrapper {
	display: flex;
	justify-content: space-around;
	align-items: center;
	min-height: 100vh;
	margin-right: 10px;
	margin-left: 10px;
	border-radius: 1.5rem;
	position: relative;
}


#li-imager {
	width: 300px;
	height: 350px;
}

#imager {
	width: 100%;
	height: 100%;
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

.likeIcon img {
	width: 16px;
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
		<img id="memberyLogo" src="/images/memberyLogo.png" alt="Membery logo">
	</div> 
	

	<div class="wrapper">

		<div class="ui fluid container" id="container" style="z-index: 1">
			<div class="ui link cards" id="linkCards">
				<c:forEach items="${feedList}" var="feed">


					<div class="ui card" style="margin: 10px;" >
						<div class="content" >

							<!-- 이미지 파일 출력 -->
							<br />
							<a href="/feedId/${feed.id}" > 
								<ul class="slider" id="imgContainer">
									<c:forEach items="${feed.fileName }" var="fileName">
										<li id="li-imager" >
											<img id="imager" class="ui medium rounded imager" src="${bucketUrl }/feed/${feed.id }/${fileName }" alt="" />
										</li>
										
	
									</c:forEach>
								</ul>
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
               

							
							<!-- 좋아요 기능 구현 -->
							<span class="likeIcon" data-feed-id="${feed.id }" >
								<c:if test="${feed.liked }">
									<img src="/images/bone.png">
								</c:if>
								<c:if test="${not feed.liked }">
									<img src="/images/olbone.png">								
								</c:if>
							</span>
							<span class="likeNumber">
								${feed.likeCount } 
							</span> likes 
							
								<!-- Button trigger modal -->
								<button type="button" class="btn btn-secondary-link btnTriggerModal position-relative" id="commentIcon" data-bs-toggle="modal" data-bs-target="#commentModal" data-id="${feed.id }">
									<i class="fa-solid fa-comment"></i>
									<span id="commentCnt" class="position-absolute top-35 start-70 translate-middle badge rounded-pill bg-secondary" >
									${feed.commentCount }</span>
								</button>
								
								 <i class="paw icon"></i>


							</span> <span class="right floated">${feed.inserted}</span>
						</div>
					</div>


				</c:forEach>

			</div>
		</div>
	</div>


	<!-- 댓글 modal -->
	<div class="modal fade " id="commentModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content" style="position: relative; z-index: 10">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel"><i class="fa-solid fa-comments"></i> 댓글</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					
					 <sec:authorize access="isAuthenticated()">
						<div class="mb-3" id="addCommentContainer">
						
							<div class="input-group">
								<div class="form-floating">
									<textarea id="commentTextArea" class="form-control" style="height: 60px" placeholder="댓글을 남겨주세요"></textarea>
									<label for="floatingTextArea">댓글을 남겨주세요</label>
								</div>
								<button id="sendCommentBtn" class="btn btn-outline-primary">
									<i class="fa-regular fa-paper-plane"></i>
								</button>
							</div>
						</div>
					</sec:authorize>
					<div id="updateCommentContainer" class=d-none>
						<div class="input-group">
							<div class="form-floating">
							<input type="hidden" id="commentUpdateIdInput"/>
							<textarea id="commentUpdateTextArea"  class="form-control" style="height: 50px"></textarea>		
							<label for="floatingTextArea">댓글을 수정하세요</label>
							</div>
							<button id="updateCommentBtn" class="btn btn-outline-secondary">
								<i class="fa-regular fa-pen-to-square"></i>
							</button>
						</div>
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
	 
	<my:bottom></my:bottom>

	<script src="/js/feed/like.js"></script>
	
</body>
</html>