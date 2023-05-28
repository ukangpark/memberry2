<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<h1>수정 폼</h1>
	<div class="ui centered equal width grid">
		<div class="eight wide column">
			<div class="ui segment">
				<div class="content">
					<img class="left floated ui image" style="width: 50px;" src="https://kr.seaicons.com/wp-content/uploads/2015/06/person-icon.png">
					<h1>${host.hostName }님정보입니다.</h1>
					<div>
						<form action="/petsitter/hostModify" class="ui big form" id="checkForm" method="post">
							<div class="field">
								<label>전화번호</label>
								<input type="text" name="phone" value="${host.phone }" disabled>
							</div>
							<div class="field">
								<label>주민번호</label>
								<input type="text" name="idNumber" value="${host.idNumber }" disabled>
							</div>
							<div class="field">
								<label>주소</label>
								<div class="equal width fields">
									<div class="field">
										<input type="text" name="si" value="${host.si }시" disabled>
									</div>
									<div class="field">
										<input type="text" name="gu" value="${host.gu }구" disabled>
									</div>
									<div class="field">
										<input type="text" name="dong" value="${host.dong }동" disabled>
									</div>
								</div>
							</div>
							<div class="field">
								<label>상세주소</label>
								<input type="text" name="address" value="${host.address }" disabled>
							</div>
							<div class="field">
								<div class="equal width fields">
									<div class="field">
										<label>주거형태</label>
										<input type="text" name="houseType" value="${host.houseType }" disabled>
									</div>
									<div class="field">
										<label>반려동물</label>
										<input type="text" name="pet" value="${host.pet }" disabled>
									</div>
									<div class="field">
										<label>반려동물 크기</label>
										<input type="text" name="species" value="${host.species }" disabled>
									</div>
								</div>
								<div class="field">
									<label>펫시터 경험</label>
									<input type="text" name="experience" value="${host.experience }" disabled>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>