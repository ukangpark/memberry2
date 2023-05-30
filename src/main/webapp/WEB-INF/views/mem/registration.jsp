<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">

<style>

#addBtn {
	position: absolute;
}
</style>

</head>
<body>

	<my:navBar current="registration"></my:navBar>

	<div style="margin-bottom: 15px"></div>
	<div class="ui aligned container" id="imgContainer">
		<img class="ui centered medium bordered circular image" src="images/발바닥.png">
	</div>
		<button class="circular ui icon button" id="addBtn">
			<i class="big corner plus icon"></i>
		</button>
	<div class="ui grid container">

		<div class="eight wide column">
			<div class="ui left aligned container" id="leftContainer">

				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">이름</div>
					<input type="text">
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">종류</div>
					<input type="text">
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">생년월일</div>
					<input type="date">
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">함께한날</div>
					<input type="date">
				</div>
			</div>
		</div>

		<div class="eight wide column">
			<div class="ui right aligned container" id="rightContainer">
				<div class="ui form">
					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label">성별</div>
							<div class="ui fluid selection dropdown">
								<input type="hidden" name="gender">
								<div class="default text">성별을 선택 해 주세요.</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="1">남아</div>
									<div class="item" data-value="0">여아</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ui form">
					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label">중성화 유무</div>
							<div class="ui fluid selection dropdown">
								<input type="hidden" name="gender">
								<div class="default text">중성화 유무를 선택 해 주세요.</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="1">했어요</div>
									<div class="item" data-value="0">안했어요</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ui fluid labeled big input mt-5">
					<div class="ui label">반려동물 등록 번호</div>
					<input type="text">
				</div>

			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>

	<script>
		$('.ui.dropdown').dropdown({
			direction : 'auto'
		});
	</script>
</body>
</html>