<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<my:navBar></my:navBar>
	<br>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<form id="modifyDetailForm" class="ui big form" method="post" action="/petsitter/modifyHousePhotos" enctype="multipart/form-data">
					<h1 class="ui dividing header">집사진 수정하기</h1>
					<div>대표 사진</div>
					<c:choose>
						<c:when test="${detail.cover eq null or detail.cover eq '' }">
							<img style="position: relative;" class="ui centered large bordered rounded image" id="preview" src="/images/defaultHome.jpeg">
							<div class="ui teal ribbon label" style="position: absolute; top: 90px; left: 118px;">대표 사진</div>
						</c:when>
						<c:otherwise>
							<img style="position: relative;" class="ui centered large bordered rounded image " src="${bucketUrl }/cover/${detail.id }/${detail.cover }" id="preview">
							<div class="ui teal ribbon label" style="position: absolute; top: 90px; left: 118px;">대표 사진</div>
						</c:otherwise>
					</c:choose>
					<label for="addCover">
						<i class="plus icon large button" style="position: absolute; top: 3.1lh; left: 20.1lh;"></i>
					</label>
					<div class="field">
						<input id="addCover" type="file" name="addCover" onchange="readURL(this);">
					</div>
					<hr>
					<div class="field">
						<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" varStatus="status">
							<label for="housePhoto${status.index }">
								<img style="width: 100px;" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
							</label>
							<input type="checkbox" name="removePhotos" value="${hostHousePhoto.housePhoto }" id="housePhoto${status.index }">
						</c:forEach>
					</div>
					<div class="field">
						<label for="housePhotos">새로운 집사진 등록</label>
						<input id="housePhotos" type="file" name="addPhotos" multiple>
					</div>
					<div class="field d-none">
						<input type="text" name="hostId" value="${host.id }">
					</div>
					<div class="field d-none">
						<input type="text" name="id" value="${detail.id }">
					</div>
				</form>
			</div>
			<!-- 버튼 -->
			<div class="extra content">
				<div class="ui two buttons">
					<a href="/petsitter/modifyDetail?hostId=${host.id }" class="ui blue basic button">뒤로가기</a>
					<button class="ui basic green button" data-bs-toggle="modal" data-bs-target="#modifyDetailModal">수정하기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 수정 모달 -->
	<div class="modal fade" id="modifyDetailModal" tabindex="-1" aria-labelledby="modifyDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="modifyDetailModalLabel">상세페이지</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">상세페이지를 수정하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<button type="submit" form="modifyDetailForm" class="btn btn-primary">수정하기</button>
				</div>
			</div>
		</div>
	</div>
	<my:bottom></my:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="/js/semantic/semantic.min.js"></script>
	<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}
	</script>
</body>
</html>