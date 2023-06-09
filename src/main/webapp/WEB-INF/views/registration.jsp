<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<my:top></my:top>

<style>

#imagePreview {
	position: relative;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.border {
	position: absolute;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	border-style: solid;
	border: 1px;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.defaultImage {
	position: relative;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.defaultImage>img {
	width: 100%;
	height: 100%;
}

.preview {
	display: none;
	width: 100%;
	height: 100%;
}

#addBtn {
	position: absolute;
	top: 30%;
	left: 56%;
}

#tag {
	position: absolute;
}
</style>

</head>
<body>

	<my:navBar current="registration"></my:navBar>
	<my:alert></my:alert>

	<!-- 상단 공백 -->
	<div style="margin-bottom: 15px"></div>

	<!-- form -->
	<form class="ui form" method="post" enctype="multipart/form-data">

		<!-- 상단 컨테이너 (프로필사진, addBtn) -->
		<div class="ui container" id="imagePreview">
			<img class="preview" src="">
			<div class="defaultImage">
				<img alt="" src="images/paw.png">
				<div class="border"></div>
			</div>
		</div>
		<label for="fileInput" class="big circular ui icon button" id="addBtn"><i class="large plus icon"></i></label>
		<input style="display: none" type="file" id="fileInput" name="file" accept="image/*" />

		<!-- 하단 컨테이너 -->
		<div class="ui grid container">

			<!-- 왼쪽 컨테이너 항목들 -->
			<div class="eight wide column">
				<div class="ui left aligned container" id="leftContainer">

					<div class="field">
						<input type="text" name="id" style="display: none">
					</div>

					<div class="field">
						<input type="text" name="memberId" value="${auth.getName() }" style="display: none">
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label" id="mustInput">이름</div>
							<i class="mini red circle icon" id="tag"></i>
							<input type="text" name="petName" value="${registration.petName }">
						</div>
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label">품종</div>
							<input type="text" name="type" value="${registration.type }">
						</div>
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label" id="mustInput">몸무게</div>
							<i class="mini red circle icon" id="tag"></i>
							<div class="ui fluid selection dropdown" id="select1">
								<input type="hidden" name="weight" value="${registration.weight }">
								<div class="default text">몸무게를 선택 해 주세요.</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="small">작은친구 ( 7kg 미만 )</div>
									<div class="item" data-value="medium">중간친구 ( 7 ~ 14.9kg)</div>
									<div class="item" data-value="large">큰친구 ( 15kg 이상 )</div>
								</div>
							</div>
						</div>
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label">생년월일</div>
							<input type="date" name="birth" value="${registration.birth }">
						</div>
					</div>
				</div>
			</div>

			<!-- 오른쪽 컨테이너 항목들 -->
			<div class="eight wide column">
				<div class="ui right aligned container" id="rightContainer">
					<div class="ui fluid labeled big input mt-5">
						<div class="ui label" id="mustInput">함께한날</div>
						<i class="mini red circle icon" id="tag"></i>
						<input type="date" name="together" value="${registration.together }">
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label" id="mustInput">성별</div>
							<i class="mini red circle icon" id="tag"></i>
							<div class="ui fluid selection dropdown" id="select2">
								<input type="hidden" name="gender" value="${registration.gender }">
								<div class="default text">성별을 선택 해 주세요.</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="male">남아</div>
									<div class="item" data-value="female">여아</div>
								</div>
							</div>
						</div>
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label" id="mustInput">중성화 유무</div>
							<i class="mini red circle icon" id="tag"></i>
							<div class="ui fluid selection dropdown" id="select3">
								<input type="hidden" name="neutered" value="${registration.neutered }">
								<div class="default text">중성화 유무를 선택 해 주세요.</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="yes">했어요</div>
									<div class="item" data-value="no">안했어요</div>
								</div>
							</div>
						</div>
					</div>

					<div class="field">
						<div class="ui fluid labeled big input mt-5">
							<div class="ui label">반려동물 등록 번호</div>
							<input type="text" name="registrationNum" value="${registration.registrationNum }">
						</div>
					</div>

					<div class="mt-4">
						<button class="ui large button" type="submit">등록하기</button>
					</div>
				</div>
			</div>
		</div>

	</form>


<my:bottom></my:bottom>


	<script>
		/* 항목들 드롭다운 */
		$('#select1').dropdown();
		$('#select2').dropdown();
		$('#select3').dropdown();

		/* 첨부파일 이미지 변경 */
		const fileInput = document.getElementById("fileInput");
		const previewContainer = document.getElementById("imagePreview");
		const previewImage = previewContainer.querySelector(".preview");
		const previewDefaultImage = previewContainer
				.querySelector(".defaultImage");

		fileInput.addEventListener("change", function() {
			const file = this.files[0];
			//console.log(file);

			if (file) {
				const reader = new FileReader();

				previewDefaultImage.style.display = "none";
				previewImage.style.display = "block";

				reader.addEventListener("load", function() {
					previewImage.setAttribute("src", this.result);
				});

				reader.readAsDataURL(file);
			}

		})

		/* 엔터키 치면 전송되는 것 방지 */
		$('input[type="text"]').keydown(function() {
			if (event.keyCode == 13) {
				event.preventDefault();
			}
			;

		})
	</script>
</body>
</html>