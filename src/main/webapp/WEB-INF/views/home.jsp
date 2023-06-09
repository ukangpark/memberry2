<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>

<style>



 #header {
	text-align: center;
	margin: 40px 0;
	display: flex;
	justify-content: center;
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
		<h2>Membery</h2>
	</div> 
	

	<div class="wrapper" style="margin-top: 50px;">

		<div class="ui center aligned container" id="container" style="z-index: 1">
			<div class="ui link cards">
				<c:forEach items="${feedList}" var="feed">


					<div class="ui card" style="margin: 30px;" >
						<div class="content" >

							<!-- 이미지 파일 출력 -->
							<br />
							<ul class="slider" id="imgContainer">
								<c:forEach items="${feed.fileName }" var="fileName">
									<li>
										<a href="/feedId/${feed.id}"> 
										<img class="ui medium rounded imager" src="${bucketUrl }/${feed.id }/${fileName }" alt="" />
									</a>
									</li>
									

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
								<button type="button" class="btn btn-secondary-link" data-bs-toggle="modal" data-bs-target="#commentModal">
									<i class="fa-solid fa-comment"></i>${feed.commentCount }
								</button> <i class="paw icon"></i>


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
					<h1 class="modal-title fs-5" id="exampleModalLabel">댓글</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h3>
						<i class="fa-solid fa-comments"></i>
						
					</h3>
					<sec:authorize access="isAuthenticated()">
						<div class="mb-3" id="addCommentContainer">
						
							<div class="input-group">
								<div class="form-floating">
									<textarea id="commentTextArea" class="form-control" style="height: 97px" placeholder="댓글을 남겨주세요"></textarea>
									<label for="floatingTextArea">댓글을 남겨주세요</label>
								</div>
								<button id="sendCommentBtn" class="btn btn-outline-primary">
									<i class="fa-regular fa-paper-plane"></i>
								</button>
							</div>
						</div>
					</sec:authorize>
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

<!-- 댓글 삭제 모달 -->
<div class="modal fade" id="deleteCommentConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 삭제 확인</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button id="deleteCommentModalButton" type="submit" class="btn btn-danger">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- 댓글 수정 모달 -->
<div class="modal fade" id="commentUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" >댓글 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div id="updateCommentContaier">
      		<input type="hidden" id="commentUpdateIdInput" />
      		<textarea id="commentUpdateTextArea" class="form-control"></textarea>
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary">수정</button>
      </div>
    </div>
  </div>
</div>


	 <script src="/js/home.js"></script>  
	 <script src="/js/comment.js"></script>
	 


	<my:bottom></my:bottom>



	<script src="/js/feed/like.js"></script>
</body>
</html>