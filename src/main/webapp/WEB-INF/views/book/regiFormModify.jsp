<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약 변경</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="/js/semantic/semantic.min.js"></script>
</head>
<body>

<div class="container-lg">

<div style="margin:100px 300px 300px 300px; border: 8px double lightblue;">
	<form class="ui form" style="margin:100px 100px 100px 100px">
		<h2 class="ui dividing header" style = "text-align:center">${book.petName }(이)의 예약 변경 신청</h2>
		<br>
		<form method="post">
		<input type="hidden" name="num" value="${book.num }"/>
		<div class="field">
		<h4 class="ui header">이름</h4>
			<div class="field">

				<input type="text" name="petName" value="${book.petName }" />

			</div>
		</div>
		<div class="field">
			<h4 class="ui header">생년월일</h4>
				<input type="text" name="birth" value="${pet.birth }">
		</div>



		<div class="ui form">

			<div class="inline fields">
				<label for="weight">몸무게</label>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="price" tabindex="0" class="hidden" value="30,000"> <label>소형견 ( 7kg 미만 )</label>
					</div>
				</div>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="price" tabindex="0" class="hidden"> <label>중형견 ( 7 ~ 14.9kg)</label>
					</div>
				</div>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="price" tabindex="0" class="hidden"> <label>대형견 ( 15kg 이상 )</label>
					</div>
				</div>
			</div>
		</div>


			<h4 class="ui header">품종</h4>
			<div class="field">

				<input type="text" name="booking[품종]">

			</div>
			
			
			<h4 class="ui header">성별</h4>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:1090px">
  		<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
  		<label class="btn btn-outline-secondary" for="btnradio1">여자</label>
  		<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
  		<label class="btn btn-outline-secondary" for="btnradio2">남자</label>
		</div>


	
			<h4 class="ui header">중성화</h4>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:1090px">
  		<input type="radio" class="btn-check" name="btnradio1" id="btnradio3" autocomplete="off" checked>
  		<label class="btn btn-outline-secondary" for="btnradio3">네</label>

  		<input type="radio" class="btn-check" name="btnradio1" id="btnradio4" autocomplete="off">
  		<label class="btn btn-outline-secondary" for="btnradio4">아니오</label>
  		</div>
			
			
			


			<h4 class="ui header">배변훈련(배변패드)</h4>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:1090px">
  		<input type="radio" class="btn-check" name="btnradio2" id="btnradio5" autocomplete="off" checked>
  		<label class="btn btn-outline-secondary" for="btnradio5">잘해요</label>
  		<input type="radio" class="btn-check" name="btnradio2" id="btnradio6" autocomplete="off">
  		<label class="btn btn-outline-secondary" for="btnradio6">미숙해요</label>
  		<input type="radio" class="btn-check" name="btnradio2" id="btnradio7" autocomplete="off">
  		<label class="btn btn-outline-secondary" for="btnradio7">실외배변</label>
		</div>
			
	


			<h4 class="ui header">자주 다니는 동물병원 이름과 위치(동)</h4>
			<div class="field">

				<input type="text" name="booking[동물병원]">

			</div>


			<h4 class="ui header">전하고 싶은 말</h4>
			<div class="field">

				<textarea rows="2" placeholder="특이사항, 주의사항 등등 자유롭게 적어주세요"></textarea>
			</div>



<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  예약 변경 신청하기
</button>
</div>
		</form>
		</div>

	<script>
		$('.ui.radio.checkbox').checkbox();
	</script>
	
</body>
</html>