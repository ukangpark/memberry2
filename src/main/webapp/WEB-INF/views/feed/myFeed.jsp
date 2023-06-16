<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<style>
.container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	grid-template-rows: masonry; /* this will do the magic */
	grid-gap: 10px;
	margin-left: 5%;
	margin-right: 5%;
}

img {
	width: 100%;
	border-radius: 10%;
}

#profilImage {
	height: 300px;
	width: 300px;
	border: 3px solid #cccccc;
	padding: 5px;
	margin-bottom: 0px;
}

#upper {
	display: flex;
	justify-content: center;
	align-items: baseline;
	text-align: center;
}

#addImageBox {
	position: relative;
	cursor: pointer;
	overflow:hidden;
	
}

#addImageBox:hover #addImage {
	bottom: 60px;
}

#addImage {
	width: 100%;
	height: 100%;
	position: absolute;
	z-index: 1;
	-webkit-transition:all.5s ease;
	transition: all.5s.ease;
	bottom: 0px;
	overflow: hidden;
}

#addImageDes {
	width: 100%;
	height: 50px;
    padding: 10px;
    position: absolute;
    bottom: 0px;
    text-align: center;
    color: white;
}

#addImageBox:hover #addImageDes {
	color: #C0C0C0;
	font-weight: bold;
	font-size: large;
}

</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>

</head>
<body>

	<my:navBar current="myFeed"></my:navBar>
	<div class="ui container mb-3" id="myFeedTitle">
		<h1 style="text-align: center;">My Feed</h1>
	</div>

	<!-- 윗 부분 -->
	<div id="upper" class="ui container mb-5">

		<div class="follower" style="margin: 0px 30px 0px 30px; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#followerModal">
			<h3>팔로워 00명</h3>
		</div>

		<div class="following" style="margin: 0px 30px 0px 30px; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#followingModal">
			<h3>팔로잉 00명</h3>
		</div>

		<!-- 프로필 이미지 -->
		<div class="middleContainer" style="margin: 0px 30px 0px 30px">
			<c:if test="${logedInMember.profileImage ne null}">
				<img class="ui circular image" id="profilImage" src="${bucketUrl }/pet${proileImg}">
			</c:if>
			<c:if test="${logedInMember.profileImage eq null}">
				<img class="ui circular image" id="profilImage" src="/images/paw.png">
			</c:if>

			<div>
				<p>${petList.petName }</p>
				<p>${petList.type }</p>
				<p>
					<i class="heart icon"></i>${petList.diff.years}년 ${petList.diff.months}개월째 함께 하는 중 입니다<i class="heart icon"></i>
				</p>
			</div>
		</div>

		<div class="follow" style="margin: 0px 30px 0px 30px">
			<button class="ui basic button" id="followBtn">
				<h3>
					<i class="fa-solid fa-user"></i> 팔로우
				</h3>
			</button>

			<c:if test="">
				<button class="ui basic button">
					<h3>
						<i class="fa-solid fa-user-check"></i> 팔로잉
					</h3>
				</button>
			</c:if>
		</div>

		<div class="messageBtn" style="margin: 0px 30px 0px 30px">
			<button class="ui basic button" id="messageBtn">
				<h3 onMouseover="this.style.color='#FFCC33';" onMouseout="this.style.color='gray';">
					<i class="fa-solid fa-bolt"></i> 산책번개
				</h3>
			</button>
		</div>

	</div>

	<div class="container">

		<!-- 게시물 추가 이미지 -->
		<div id="addImageBox"> 
			<div id="addImage">
				<a href="/feed/feedAdd">
					<img src="/images/feedAddIcon.PNG" alt="" />
				</a>
			</div>
			<div id="addImageDes">피드를 추가해 보세요!</div>
		</div>

		<c:forEach items="${fileList }" var="file">

			<div class=item>
				<a href="/feedId/${file.feedId }">

					<img src="${bucketUrl }/feed/${file.feedId }/${file.fileName }" alt="" />

				</a>
			</div>

		</c:forEach>

	</div>


	<c:if test="${param.remove eq 'remove' }">
		<script>
			alert("게시물이 삭제 되었습니다!")
		</script>
	</c:if>


	<!-- 팔로워 모달 -->
	<div class="modal fade" id="followerModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">팔로워</h3>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<c:if test="${logedInMember.profileImage ne null}">
						<img class="ui middle aligned tiny inline image" id="nav-image" src="${bucketUrl }/pet${logedInMember.profileImage }">
						<span style="font-size: 15pt; font-weight: bold;">${logedInMember.nickName }</span>
					</c:if>
					<c:if test="${logedInMember.profileImage eq null}">
						<img class="ui tiny image" id="nav-image" src="/images/paw.png">${logedInMember.nickName } 
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- 팔로잉 모달 -->
	<div class="modal fade" id="followingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">팔로잉</h3>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<c:if test="${logedInMember.profileImage ne null}">
						<img class="ui middle aligned tiny inline image" id="nav-image" src="${bucketUrl }/pet${logedInMember.profileImage }">
						<span style="font-size: 15pt; font-weight: bold;">${logedInMember.nickName }</span>
					</c:if>
					<c:if test="${logedInMember.profileImage eq null}">
						<img class="ui tiny image" id="nav-image" src="/images/paw.png">${logedInMember.nickName } 
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>

	<script>
		$('.ui.modal').modal('show');
	</script>


</body>
</html>