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
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" />
</head>

<style>

.body {
	height:1000px;
}
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
	min-height: 100vh;
	background-color: #EEEEEE;
	margin-right: 10%;
	margin-left: 10%;
	border-radius: 1.5rem;
	position: relative;
}

.bx-wrapper {
	
	margin-left: 1.2rem;
}


#textContentt {
	/* flex-grow: 2;  */
	margin-right: 10rem;
	margin-left: 10rem;
}

#drop {
	/* flex-grow: 0.5;  */
	/* position: absolute;  */
	
}

#my-card {
	width: 100%;
	/* height: 80vh; */
}

#profilImage {
	border-radius: 50%;
	height: 50px;
	width: 50px;
}

#inserted {
	margin-top: 15px;
}

</style>
<body id="body" style="background-color: #FFF2F2">

	<my:navBar />
	
	<!-- toast 알람 -->
	<div class="toast-container top-0 start-50 translate-middle-x p-3">
		<div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body"></div>
				<button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<div class="pageName">
		<h1>${feed.id }번 게시물</h1>
	</div>

	<div class="wrapper">

		<div class="d-flex">
			<!-- card -->
			<div class="ui card" id="my-card">
				<div class="content"">
					<div id="inserted" class="right floated meta">${feed.inserted }</div>
					<img id="profilImage" class="ui avatar image" src="/images/또복이 (1).jpg"> 또복언니
				</div>
				<div class="content">
					<div class="right floated meta">
						<img class="ui avatar image" src="/images/scrap.png">
					</div>
				</div>

				<div class="content">
					<!-- 이미지 파일 출력 -->
					<br />
					<ul class="bxslider">
						<c:forEach items="${feed.fileName }" var="fileName">
							<li><img class="ui medium rounded imager" src="${bucketUrl }/${feed.id }/${fileName }" alt="" /></li>
						</c:forEach>
					</ul>
				</div>

				<div class="content" >
					
						<span class="likeIcon" data-feed-id="${feed.id }">
							<c:if test="${feed.liked }">
								<img src="/images/bone.png">
							</c:if>
							<c:if test="${not feed.liked }">
								<img src="/images/olbone.png">						
							</c:if>
						</span>
						<span class="likeNumber" style="font-weight: 300; font-size: large;">
							${feed.likeCount }
						</span> 
						<span style="font-weight: 300; font-size: large;">likes</span>
						
					<span class="left floated" style="margin-right: 200px; font-weight: 300; font-size: large;">
						<!-- <i class="comment icon"></i> --><img src="/images/chat.png"> 3 comments
					</span> 
				</div>
				<div class="extra content">
					<div class="ui large transparent right icon input">
						<input size=42 type="text" placeholder="Add Comment..."><img src="/images/comment.png">
					</div>
				</div>
			</div>

		</div>

		<div class="d-flex">



			<!-- text content -->
			<div class="textContent">
				<div class="ui segment" style="font-weight: 700;">제목 : ${feed.title }</div>
				<div class="ui segment" style="font-weight: 700;">본문 : ${feed.content }</div>
				<div class="ui segment" style="font-weight: 700;">장소 태그 : ${feed.location }</div>
			</div>

			<!-- 수정/삭제 버튼 드랍다운 -->
			<div class="drop">
				<button type="button" class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="fa-solid fa-ellipsis-vertical"></i>
				</button>

				<ul class="dropdown-menu">
					<!-- Dropdown menu links -->
					<div style="text-align: center">
						<a href="/modify/${feed.id }">수정하기</a>
					</div>
					<div style="text-align: center">
						<a href="#" onclick="javascript:document.removeForm.submit();">삭제하기</a>
					</div>
				</ul>

				<!-- 삭제하기 기능 -->
				<div class="d-none">
					<form action="/remove" method="post" name="removeForm">
						<input type="text" name="id" value="${feed.id }" />
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- wrapper div -->

<my:bottom></my:bottom>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			let slider = $('.bxslider').bxSlider({
				slideWidth : 400
			});
		});
	</script>
	
	<script src="/js/feed/like.js">
	
	</script>
</body>
</html>