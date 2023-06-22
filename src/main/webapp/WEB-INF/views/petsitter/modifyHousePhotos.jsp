<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세페이지 수정하기</title>

<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style type="text/css">
#preview {
	position: relative;
}

#coverLabel {
	position: absolute;
	top: 110px;
	left: 220px;
}

#plus {
	position: absolute;
	top: 100px;
	left: 650px;
}

#imgContainer {
	height: 300%;
}

#imgContainer:empty:before {
	content: attr(data-placeholder);
	color: #999;
	font-size: .9em;
}
</style>
</head>
<body>
	<my:navBar></my:navBar>
	<my:logo></my:logo>
	<br>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<form id="modifyDetailForm" class="ui big form" method="post" action="/petsitter/modifyHousePhotos" enctype="multipart/form-data">
					<h1 class="ui dividing header">집사진 수정하기</h1>
					<h1 class="ui header center aligned">
						<div class="sub header ">대표 사진을 수정할 수 있습니다.</div>
					</h1>
					<c:choose>
						<c:when test="${detail.cover eq null or detail.cover eq '' }">
							<img style="position: relative;" class="ui centered large bordered rounded image" id="preview" src="/images/defaultHome.jpeg">
							<div class="ui teal ribbon label" style="position: absolute; top: 90px; left: 118px;">대표 사진</div>
						</c:when>
						<c:otherwise>
							<div class="image-container">
								<img class="ui centered large bordered rounded image " src="${bucketUrl }/cover/${detail.id }/${detail.cover }" id="preview">
								<div class="ui teal ribbon label" id="coverLabel">대표 사진</div>
							</div>
						</c:otherwise>
					</c:choose>
					<label for="addCover">
						<i class="plus icon large button" id="plus"></i>
					</label>
					<div class="field">
						<input id="addCover" type="file" name="addCover" onchange="readURL(this);" class="d-none">
					</div>
					<hr>
					<!-- 기존 집 사진 삭제 -->
					<div class="field">
						<h1 class="ui header center aligned" style="margin-bottom: 30px; margin-top: 10px;">
							<div class="sub header">기존 집 사진을 삭제하려면 선택해주세요.</div>
						</h1>
						<div class="ui two column grid">
							<c:forEach items="${hostHousePhoto }" var="hostHousePhoto" varStatus="status">
								<label for="housePhoto${status.index }">
									<img style="width: 300px;" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
								</label>
								<input type="checkbox" name="removePhotos" value="${hostHousePhoto.housePhoto }" id="housePhoto${status.index }">
							</c:forEach>
						</div>
					</div>
					<br>
					<hr>
					<!-- 새로운 집사진 등록 -->
					<h1 class="ui header center aligned" style="margin-bottom: 30px; margin-top: 10px;">
						<div class="sub header">
							<label for="housePhotos">새로운 집사진을 등록하려면 사진을 선택해주세요.</label>
						</div>
					</h1>
					<div class="field">
						<input id="housePhotos" type="file" name="addPhotos" multiple>
					</div>

					<!-- 이미지 미리보기 -->
					<div style="position: relative;" id="imagePreview" class="field">
						<div id="imgContainer" class="field ui aligned container segment" data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하세요. 대표 사진은 위 더하기 버튼을 눌러주세요.'></div>
						<br>
						<div class="ui teal right ribbon label" style="bottom: 125px;">상세 사진</div>
					</div>
					<input type="hidden" name="hostId" value="${host.id }">
					<input type="hidden" name="id" value="${detail.id }">
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
	<script src="/js/petsitter/addHousePhoto.js"></script>
</body>
</html>