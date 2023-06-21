<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>호스트 등록</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<style type="text/css">
#imgContainer {
	position: relative;
}

#addBtn {
	position: absolute;
	top: 230px;
	left: 440px;
}
</style>
</head>
<body>
	<my:navBar current="apply"></my:navBar>
	<my:logo></my:logo>
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
						<input id="hostName" type="text" name="hostName" value="${member.name }" readonly>
					</div>
					<div class="field">
						<label for="phone">전화번호</label>
						<input id="phone" type="text" name="phone" placeholder="예)01012341234">
					</div>
					<div class="field">
						<label for="idNumber">생년월일</label>
						<input id="idNumber" type="text" name="idNumber" placeholder="생년월일 6자리를 적어주세요.">
					</div>
					<div class="field">
						<label>주소</label>
						<my:address></my:address>
						
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
	<my:bottom></my:bottom>
	<script src="/js/petsitter/apply.js"></script>
	<script type="text/javascript">
		const options = {
			서울 : {
				강남구 : [ '압구정동', '논현1동', '논현2동', '청담동' ],
				강동구 : [ '둔촌1동', '둔촌2동', '상일동', '명일동' ],
			// 여기에 더 많은 구와 동 옵션 추가
			},
			부산 : {
				해운대구 : [ '중동', '반여1동', '반여2동', '반여3동' ],
				사하구 : [ '괴정1동', '괴정2동', '당리동', '하단동' ],
			// 여기에 더 많은 구와 동 옵션 추가
			}
		// 여기에 더 많은 시 추가
		};

		// select 요소에 대한 참조를 가져옵니다.
		const siSelect = document.getElementById('si');
		const guSelect = document.getElementById('gu');
		const dongSelect = document.getElementById('dong');

		// 시와 구 select 요소에 이벤트 리스너를 추가합니다.
		siSelect.addEventListener('change', populateGu);
		guSelect.addEventListener('change', populateDong);

		// 선택된 시에 따라 구 옵션을 채우는 함수입니다.
		function populateGu() {
			// 기존 옵션을 지웁니다.
			guSelect.innerHTML = '<option value="">선택하세요</option>';
			dongSelect.innerHTML = '<option value="">선택하세요</option>';

			// 선택된 시를 가져옵니다.
			const selectedSi = siSelect.value;

			// 선택된 시에 대한 옵션이 있는지 확인합니다.
			if (selectedSi && options[selectedSi]) {
				// 선택된 시의 구들을 가져옵니다.
				const gu = Object.keys(options[selectedSi]);

				// 구 옵션을 채웁니다.
				gu.forEach(function(gu) {
					const option = document.createElement('option');
					option.value = gu;
					option.textContent = gu;
					guSelect.appendChild(option);
				});
			}
		}

		// 선택된 구에 따라 동 옵션을 채우는 함수입니다.
		function populateDong() {
			// 기존 옵션을 지웁니다.
			dongSelect.innerHTML = '<option value="">선택하세요</option>';

			// 선택된 시와 구를 가져옵니다.
			const selectedSi = siSelect.value;
			const selectedGu = guSelect.value;

			// 선택된 시와 구에 대한 옵션이 있는지 확인합니다.
			if (selectedSi && selectedGu && options[selectedSi][selectedGu]) {
				// 선택된 시와 구에 대한 동들을 가져옵니다.
				const dong = options[selectedSi][selectedGu];

				// 동 옵션을 채웁니다.
				dong.forEach(function(dong) {
					const option = document.createElement('option');
					option.value = dong;
					option.textContent = dong;
					dongSelect.appendChild(option);
				});
			}
		}
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="/js/semantic/semantic.min.js"></script>
	<script src="/js/petsitter/address.js"></script>
</body>
</html>