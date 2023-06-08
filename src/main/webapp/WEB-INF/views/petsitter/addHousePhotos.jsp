<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>호스트 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>

</head>
<body>

	<my:navBar></my:navBar>
	<br>
	<div class="ui centered equal width grid">
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
							<button style="margin-top: 20px;" id="addPhotoBtn" class="ui  primary button" type="button">사진 추가하기</button>
						</h2>
					</div>

					<!-- 사진1 -->
					<div class="field">
						<div class="ui aligned container" style="position: relative;" id="imgContainer">
							<img class="ui centered large bordered rounded image" src="/images/defaultHome.jpeg" id="preview1">
							<div class="ui left pointing dropdown icon circular button inverted" id="right" style="position: absolute; top: 0.5lh; left: 38lh;">
								<i class="paw icon large "></i>
								<div class="menu">
									<div class="item">
										<div class="ui blue empty circular label"></div>
										<label for="housePhoto1"> 등록하기 </label>
									</div>
									<div class="item">
										<div class="ui red empty circular label"></div>
										삭제하기
									</div>
								</div>
							</div>
							<input style="display: none;" onchange="readURL(this);" class="form-control" id="housePhoto1" type="file" name="housePhotos" accept="image/*" multiple />
							<br>
						</div>
					</div>
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

	<script>
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview1').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				document.getElementById('preview1').src = "";
			}
		}

		$('#addPhotoBtn').click(function() {

		})

		$('#right').dropdown({
			direction : 'right'
		});
	</script>
</body>
</html>