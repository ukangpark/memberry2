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
	border: 3px solid #E2E2E2;
	padding: 5px;
	margin-bottom: 50px;
}

#upper {
	display: flex;
	justify-content: center;
	align-items: baseline;
	width: 100%;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>

</head>
<body>

	<my:navBar current="myFeed"></my:navBar>
	<div style="margin-botton: 5px"></div>
	<div class="mb-5">
		<h1 style="text-align: center;">My Feed</h1>
	</div>
	
		<!-- 윗 부분 -->
		<div id="upper" class="ui aligned container mb-5" id="imgContainer">
			<button class="massive ui basic button" style="border: 2px solid #E2E2E2; border-radius: 0.5rem; margin-right:70px;">
				  <i class="fa-solid fa-user"></i>
				  팔로워
			</button>
			
			<button class="massive ui basic button" style="border: 2px solid #E2E2E2; border-radius: 0.5rem; margin-right:50px;">
				  <i class="fa-solid fa-user-check"></i>
				  팔로잉
			</button>
			
			<!-- 프로필 이미지 -->
			<div>
				<c:if test="${logedInMember.profileImage ne null}">
					<img class="ui circular image" id="profilImage" src="${bucketUrl }/pet${logedInMember.profileImage }"> 
				</c:if>
				<c:if test="${logedInMember.profileImage eq null}">
					<img class="ui circular image" id="profilImage" src="/images/paw.png">
				</c:if>	
				
				<div>
					<p>${fileList[4].petName }</p>
					<p>${fileList[5].type }</p>
					<p>${fileList[6].birth }</p>
				</div>
			</div>
			
				<button class="massive ui basic button" style="border: 2px solid #E2E2E2; border-radius: 0.5rem; margin-left:50px; margin-right:70px;">
				  <i class="fa-solid fa-paper-plane"></i>
				  메세지
			</button>
			
			<button class="massive ui basic button" style="border: 2px solid #E2E2E2; border-radius: 0.5rem;">
				  <i class="fa-solid fa-bolt"></i>
				  산책번개
			</button>
			
		</div>

	<div class="container">

		<a href="/feed/feedAdd">
			<img src="/images/feedAddIcon.PNG" alt="" />

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

	<my:bottom></my:bottom>

	<script>
		$('.ui.modal').modal('show');
	</script>


</body>
</html>