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
	<h1>집사진 등록</h1>
	<form action="/petsitter/addHousePhotos" method="post" enctype="multipart/form-data">
		<div class="field">
			<h2 class="ui center aligned icon header">
				<i class="circular camera retro icon"></i>
				집사진을 등록해 주세요!
				<div>
					<a id="inputPhotoBtn" class="ui  primary button" data-bs-toggle="modal" data-bs-target="#inputPhoto" data-bs-whatever="@mdo">사진 등록하기</a>
				</div>
				
				<input type="file" name="housePhotoes" multiple>
				<input type="number" name="hostId" value="${param.hostId }">
				<input type="submit" value="전송">
			</h2>
			<input class="d-none" id="housePhoto" type="file" name="housePhotoes" multiple>
		</div>
	</form>
	
		<!-- 사진 등록 모달 -->
<%-- 	<div class="modal fade" id="inputPhoto" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">집사진 등록하기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="" id="test" method="post" enctype="multipart/form-data">
						<div class="field">
							<input type="text" name="hostId" value="${param.hostId }">
							<input type="file" name="housePhotoes" multiple>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
					<button type="submit" class="btn btn-primary" form="test">등록하기</button>
				</div>
			</div>
		</div>
	</div> --%>
</body>
</html>