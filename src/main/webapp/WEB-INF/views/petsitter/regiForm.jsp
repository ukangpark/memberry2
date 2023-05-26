<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약 신청 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
</head>
<body>


	<form class="ui form">
		<h4 class="ui dividing header">예약 신청서</h4>
		<div class="field">
			<label>이름</label>
			<div class="field">

				<input type="text" name="booking[이름]">

			</div>
		</div>
		<div class="field">
			<label>생년월일</label>
			<div class="two fields">
				<div class="field">
					<select class="ui fluid dropdown">
						<option value="">년도</option>
						<option value="00">2000</option>
						<option value="01">2001</option>
						<option value="02">2002</option>
						<option value="03">2003</option>
						<option value="04">2004</option>
						<option value="05">2005</option>
						<option value="06">2006</option>
						<option value="07">2007</option>
						<option value="08">2008</option>
						<option value="09">2009</option>
						<option value="10">2010</option>
						<option value="11">2011</option>
						<option value="12">2012</option>
						<option value="13">2013</option>
						<option value="14">2014</option>
						<option value="15">2015</option>
						<option value="16">2016</option>
						<option value="17">2017</option>
						<option value="18">2018</option>
						<option value="19">2019</option>
						<option value="20">2020</option>
						<option value="21">2021</option>
						<option value="22">2022</option>
						<option value="23">2023</option>

					</select>
				</div>
				<div class="field">
					<select class="ui fluid dropdown">
						<option value="">월</option>
						<option value="1">1월</option>
						<option value="2">2월</option>
						<option value="3">3월</option>
						<option value="4">4월</option>
						<option value="5">5월</option>
						<option value="6">6월</option>
						<option value="7">7월</option>
						<option value="8">8월</option>
						<option value="9">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
					</select>
				</div>
			</div>
		</div>



		<div class="ui form">

			<div class="inline fields">
				<label for="weight">몸무게</label>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="weight" checked="" tabindex="0" class="hidden"> <label>소형견 ( 7kg 미만 )</label>
					</div>
				</div>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="weight" tabindex="0" class="hidden"> <label>중형견 ( 7 ~ 14.9kg)</label>
					</div>
				</div>
				<div class="field">
					<div class="ui radio checkbox">
						<input type="radio" name="fruit" tabindex="0" class="hidden"> <label>대형견 ( 15kg 이상 )</label>
					</div>
				</div>
			</div>
		</div>

		<div>

			<label>품종</label>
			<div class="field">

				<input type="text" name="booking[품종]">

			</div>


			<label>성별</label>
			<div class="ui two item menu">

				<a class="item">여자</a> <a class="item">남자</a>
			</div>

			<label>중성화</label>
			<div class="ui two item menu">

				<a class="item">네</a> <a class="item">아니오</a>
			</div>

			<label>배변훈련(배변패드)</label>
			<div class="ui three item menu">

				<a class="item">잘해요</a> <a class="item">미숙해요</a> <a class="item">실외배변</a>
			</div>


			<label>자주 다니는 동물병원 이름과 위치(동)</label>
			<div class="field">

				<input type="text" name="booking[동물병원]">

			</div>








			<h4 class="ui dividing header">전하고 싶은 말</h4>
			<div class="field">

				<textarea rows="2" placeholder="특이사항, 주의사항 등등 자유롭게 적어주세요"></textarea>
			</div>

			<div class="ui button" tabindex="0">예약 신청하기</div>
	</form>



	<script>
		$('.ui.radio.checkbox').checkbox();
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>