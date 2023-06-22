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
	grid-template-rows: masonry;
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
	border: 1px solid #cccccc;
	margin-bottom: 0px;
}

#upper {
	display: flex;
	margin: 0 auto;
	align-items: baseline;
	text-align: center;
	margin-left: 20%;
}

#addImageBox {
	height: 250px;
	position: relative;
	cursor: pointer;
	/* overflow: hidden; */
}

#addImageBox:hover #addImage {
	bottom: 60px;
}

#addImage {
	width: 100%;
	height: 100%;
	position: absolute;
	z-index: 1;
	-webkit-transition: all.5s ease;
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
	<my:logo></my:logo>
	<div class="titleContainer mb-3" id="myFeedTitle" style="justify-content: center;">
		<h1 style="text-align: center; color: #FF9999">${nickName }
			<span style="color: black"> 님의 피드</span>
		</h1>
	</div>

	<!-- 윗 부분 -->
	<div id="upper" class="upperContainer mb-5" >

		<div class="follower" id="followerBtn" style="margin: 0px 30px 0px 30px; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#followerModal">
			<h3>
				<input id="userName" name="userName" value="${userName }" style="display: none;">
				팔로워 <span class="followerCount">${fileList[0].followCount}</span>
			</h3>
		</div>

		<div class="following" id="followingBtn" style="margin: 0px 30px 0px 30px; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#followingModal">
			<h3>
				<input id="userName" name="userName" value="${userName }" style="display: none;">
				팔로잉 <span class="followingCount">${fileList[0].followingCount}</span>
			</h3>

		</div>

		<!-- 프로필 이미지 -->
		<div class="middleContainers" style="margin: 0px 30px 0px 30px">
			<c:if test="${logedInMember.profileImage ne null}">
				<img class="ui circular image" id="profilImage" src="${bucketUrl }/pet${profileImg}">
			</c:if>
			<c:if test="${logedInMember.profileImage eq null}">
				<img class="ui circular image" id="profilImage" src="/images/paw.png">
			</c:if>

			<div class="mt-3">
				<h5 style="margin: 0px">${petList.petName }(${petList.type })</h5>
				<h5 style="margin: 0px">
					<i class="heart icon"></i>${petList.diff.years}년 ${petList.diff.months}개월째 함께 하는 중 입니다<i class="heart icon"></i>
				</h5>
			</div>
		</div>

		<div class="follow" style="margin: 0px 30px 0px 30px">
			<input id="userName" name="userName" value="${userName }" style="display: none;">
			<input id="auth" name="auth" value="${authentication }" style="display: none;">
			<c:if test="${userName ne authentication }">
				<c:if test="${not fileList[0].followed }">
					<button class="ui basic button" id="followBtn">
						<h3>
							<i class="fa-solid fa-user"></i> 팔로우
						</h3>
					</button>
				</c:if>
				<c:if test="${fileList[0].followed }">
					<button class="ui blue basic button" id="followBtn">
						<h3>
							<i class="fa-solid fa-user-check"></i> 팔로잉
						</h3>
					</button>
				</c:if>
			</c:if>
		</div>

		<div class="messageBtn" style="margin: 0px 30px 0px 30px">
			<c:if test="${userName ne authentication }">
				<button class="ui basic button" id="messageBtn">
					<h3 onMouseover="this.style.color='#FFCC33';" onMouseout="this.style.color='gray';">
						<i class="fa-solid fa-bolt"></i> 산책번개
					</h3>
				</button>
			</c:if>
		</div>
	</div>

	<div class="container">

		<!-- 게시물 추가 이미지 -->
		<div id="addImageBox">
			<div id="addImage">
				<a href="/feed/feedAdd/${fileList[0].feedId }">
					<img style="height: 300px" src="/images/feedAddIcon.PNG" alt="" />
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
					<div id="followerListContainer"></div>
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
					<div id="followingListContainer"></div>
				</div>
			</div>
		</div>
	</div>

	<my:bottom></my:bottom>
	<script src="/js/feed/follow.js"></script>

	<script>
		$('.ui.modal').modal('show');
	</script>


</body>
</html>