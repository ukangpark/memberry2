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
.profileContainer {
	display: flex;
	align-items: center;
	justify-content: center;
}

.profile {
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

img {
	width: 100%;
	height: 100%;
}

.myPetsBorder {
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

.item {
	align-items: center;
	justify-content: center;
}

label {
	text-align: left;
}
</style>

</head>
<body>

	<my:navBar></my:navBar>
	<my:logo></my:logo>
	<my:alert></my:alert>

	<!-- 상단 공백 -->
	<div style="margin-bottom: 5px"></div>

	<!-- 상단 프로필 컨테이너 -->
	<div class="profileContainer">
		<div class="profile">
			<img id="imageByPet" src="${bucketUrl }/pet/${pet.id }/${pet.photo}">
			<div class="myPetsBorder"></div>
		</div>
	</div>

	<!-- 상단 헤더 컨테이너 -->
	<div class="ui center aligned container mt-2">
		<div class="ui huge header">${pet.petName }</div>
		<!-- 프로필등록 버튼 -->
		<div class="inline field">
			<div class="ui toggle checkbox" id="petCheckbox">
				<c:if test="${pet.defaultPetId eq '' || pet.defaultPetId ne pet.id}">
					<input type="checkbox" name="thumbnail">
				</c:if>
				<c:if test="${pet.defaultPetId eq pet.id}">
					<input type="checkbox" name="thumbnail" checked>
				</c:if>
				<!-- navBar연동을 위한 코드 -->
				<input id="petId" type="text" name="id" value="${pet.id }" readonly style="display: none;">
				<input id="petPhoto" type="text" name="photo" value="${pet.photo }" readonly style="display: none;">
				<label>프로필로 등록</label>
			</div>
		</div>
	</div>

	<!-- form -->
	<form class="ui form">


		<!-- 하단 컨테이너 -->
		<div class="ui grid container">

			<!-- 왼쪽 컨테이너 항목들 -->
			<div class="eight wide column">
				<div class="ui left aligned container mt-3" id="leftContainer">
					<div class="field">
						<label>품종</label>
						<input type="text" name="type" value="${pet.type }" readonly>
					</div>
					<div class="field mt-5">
						<label>몸무게</label>
						<input type="text" name="weight" value="${pet.weight eq 'small' ? '작은친구 ( 7kg 미만 )' : pet.weight eq 'medium' ? '중간친구 ( 7 ~ 14.9kg)' : '큰친구 ( 15kg 이상 )' }" readonly>
					</div>
					<div class="field mt-5">
						<label>생년월일</label>
						<input type="date" name="birth" value="${pet.birth }" readonly>
					</div>
					<div class="field mt-5">
						<label>함께한날</label>
						<input type="date" name="together" value="${pet.together }" readonly>
					</div>
				</div>
			</div>

			<!-- 오른쪽 컨테이너 항목들 -->
			<div class="eight wide column">
				<div class="ui right aligned container mt-3" id="rightContainer">
					<div class="field">
						<label>성별</label>
						<input type="text" name="gender" value="${pet.gender eq 'male' ? '남아' : '여아'}" readonly>
					</div>
					<div class="field mt-5">
						<label>중성화 유무</label>
						<input type="text" name="neutered" value="${pet.neutered eq 'yes' ? '했어요' : '안했어요'}" readonly>
					</div>
					<div class="field mt-5">
						<label>반려동물 등록 번호</label>
						<input type="text" name="registrationNum" value="${pet.registrationNum}" readonly>
					</div>
				</div>
				<div style="margin-top: 65px">
					<div class="ui toggle right floated large button" style="background-color: #cc6666" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제하기</div>
					<div class="ui toggle right floated large button" style="background-color: #6699cc" onclick="location.href='/petModify/${pet.id}'">수정하기</div>
					<div class="ui right floated large button" style="background-color: #cccccc" onclick="location.href='/myPets/petList'">목록보기</div>
				</div>
			</div>

		</div>
	</form>

	<!-- 삭제하기위해 해당 registration id 가져오기 -->
	<div class="d-none">
		<form action="/petRemove" method="post" id="removeForm">
			<input type="text" name="id" value="${pet.id }" />
		</form>
	</div>

	<!-- 해당펫정보 삭제 모달 -->
	<div class="modal fade" id="deleteConfirmModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">삭제 하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-danger" form="removeForm">삭제</button>
				</div>
			</div>
		</div>
	</div>


	<my:bottom></my:bottom>
	<script>
		$('.ui.checkbox').checkbox();
	</script>
	<script src="/js/pet.js"></script>
</body>
</html>