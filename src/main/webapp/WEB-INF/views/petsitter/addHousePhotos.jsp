<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>호스트 등록</title>

<my:top></my:top>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<my:bottom></my:bottom>
<script src="/js/semantic/semantic.min.js"></script>
<style>
#imgContainer {
	height: 300px;
}

#imgContainer:empty:before {
	content: attr(data-placeholder);
	color: #999;
	font-size: .9em;
}
</style>
</head>
<body>

	<%-- <my:navBar></my:navBar> --%>
	<br>
	<div class="ui centered equal width grid" id="fullDiv">
		<div class="eight wide column">
			<div class="ui segment">
				<form id="addDetailForm" action="/petsitter/addHousePhotos" class="ui big form" method="post" enctype="multipart/form-data">
					<h1 class="ui dividing header">집사진 등록하기</h1>
					<input type="text" name="hostId" value="${param.hostId }" class="d-none">
					<div class="field">
						<h2 class="ui center aligned icon header">
							<i class="circular camera retro icon"></i>
							집사진을 등록해주세요!
							<br>
							<!-- 	<label for="housePhoto1">
								<button style="margin-top: 20px;" id="addPhotoBtn" class="ui  primary button" type="button">사진 추가하기</button>
							</label> -->
						</h2>
					</div>
					<div class="field">
						<input class="form-control" id="housePhoto1" type="file" name="housePhotos" accept="image/*" multiple placeholder="대표 사진을 선택해주세요."/>
					</div>
					<!-- 이미지 미리보기  -->
					<div id="imagePreview" class="field">
						<input class="form-control" type="file" id="housePhoto" multiple="multiple" />
						<br>
						<div id="imgContainer" class="field ui aligned container segment" data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
					</div>


					<!-- 사진1 -->
					<!-- <div class="field" id="imgContainer">
						<div class="ui aligned container" style="position: relative;" id="imgContainer">
							<img class="ui centered large bordered rounded image" src="/images/defaultHome.jpeg" id="preview1">
							<label for="housePhoto1">
								<i class="bars icon large button" style="position: absolute; top: 0.5lh; left: 20.1lh;"></i>
							</label>
						</div>
					</div> -->
				</form>
			</div>
			<!-- 버튼 -->
			<div class="extra content">
				<div class="ui two buttons">
					<a href="/petsitter/addDetail?hostId=${param.hostId }" class="ui basic red button">뒤로 돌아가기</a>
					<button form="addDetailForm" class="ui basic green button" data-bs-toggle="modal" data-bs-target="#addDetailModal">등록하기</button>
				</div>
			</div>

		</div>
	</div>

	<!-- 등록 모달 -->
	<div class="modal fade" id="addDetailModal" tabindex="-1" aria-labelledby="addDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="addDetailModalLabel">상세페이지</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">상세페이지를 등록하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<button type="submit" form="addDetailForm" class="btn btn-primary">등록하기</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/petsitter/addHousePhoto.js"></script>
</body>
</html>