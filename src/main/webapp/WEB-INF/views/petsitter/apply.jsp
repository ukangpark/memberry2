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
<style type="text/css">
#imgContainer {
	position: relative;
}

#addBtn {
	position: absolute;
	top: 230px;
	left: 540px;
}
</style>
</head>
<body>
	<my:navBar current="apply"></my:navBar>
	<br>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<form id="applyForm" class="ui big form" method="post" action="/petsitter/apply" enctype="multipart/form-data">
					<h1>호스트 등록</h1>
					<div class="ui aligned container" id="imgContainer">
						<img class="ui centered medium bordered circular image" src="/images/paw.png" id="preview">
						<label for="file" class="big circular ui icon button" id="addBtn">
							<i class="large plus icon"></i>
						</label>
						<input style="display: none;" onchange="readURL(this);" class="form-control" type="file" id="file" name="file" accept="image/*" />
					</div>
					<div class="field">
						<label for="hostName">이름</label>
						<input id="hostName" type="text" name="hostName" placeholder="이름을 입력해주세요.">
					</div>
					<div class="field">
						<label for="phone">전화번호</label>
						<input id="phone" type="text" name="phone" placeholder="예)01012341234">
					</div>
					<div class="field">
						<label for="idNumber">주민번호</label>
						<input id="idNumber" type="text" name="idNumber" placeholder="-를 빼고 입력해주세요.">
					</div>
					<div class="field">
						<label>주소</label>
						<div class="equal width fields">
							<div class="field">
								<select class="ui fluid search dropdown" name="si" id="si">
									<option value="서울시">서울시</option>
									<option value="부산시">부산시</option>
									<option value="대구시">대구시</option>
									<option value="인천시">인천시</option>
								</select>
							</div>
							<div class="field">
								<select class="ui fluid search dropdown" name="gu" id="gu">
									<option value="종로구">종로구</option>
									<option value="강서구">강서구</option>
									<option value="마포구">마포구</option>
								</select>
							</div>
							<div class="field">
								<select class="ui fluid search dropdown" name="dong" id="dong">
									<option value="내발산동">내발산동</option>
									<option value="염창동">염창동</option>
									<option value="화곡동">화곡동</option>
								</select>
							</div>
						</div>
					</div>
					<div class="field">
						<label for="address">상세 주소</label>
						<input id="address" type="text" name="address">
					</div>
					<div class="field">
						<div class="equal width fields">
							<div class="field">
								<label for="houseType">거주지 형태 </label>
								<select class="ui fluid search dropdown" name="houseType" id="houseType">
									<option value="10평 이하">10평 이하</option>
									<option value="11 - 20평 이하">11 - 20평 이하</option>
									<option value="21 - 30평 이하">21 - 30평 이하</option>
									<option value="31평 이상">31평 이상</option>
								</select>
							</div>
							<div class="field">
								<label for="pet">반려 경험 유무</label>
								<select class="ui fluid search dropdown" name="pet" id="pet">
									<option value="있음">있음</option>
									<option value="없음">없음</option>
								</select>
							</div>
							<div class="field">
								<label for="species">반려견 크기</label>
								<select class="ui fluid search dropdown" name="species" id="species">
									<option value="소형견">소형견</option>
									<option value="중형견">중형견</option>
									<option value="대형견">대형견</option>
								</select>
							</div>
						</div>
					</div>
					<div class="field">
						<label for="experience">펫시터 활동 경력</label>
						<select class="ui fluid search dropdown" name="experience" id="experience">
							<option value="과거에 활동했지만, 현재는 활동하지 않음">과거에 활동했지만, 현재는 활동하지 않음</option>
							<option value="현재도 활동하고 있음">현재도 활동하고 있음</option>
							<option value="펫시터로 활동을 해본 적이 없음">펫시터로 활동을 해본 적이 없음</option>
						</select>
					</div>
				</form>
			</div>

			<!-- 버튼 -->
			<div class="extra content">
				<div class="ui two buttons">
					<button class="ui basic red button">뒤로 돌아가기</button>
					<button class="ui basic green button" data-bs-toggle="modal" data-bs-target="#applyCheckModal">등록하기</button>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="applyCheckModal" tabindex="-1" aria-labelledby="applyCheckModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="applyCheckModalLabel">지원 등록</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">호스트 지원 등록을 하시겠습니까?</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary" form="applyForm">등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$('.ui.dropdown').dropdown();

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