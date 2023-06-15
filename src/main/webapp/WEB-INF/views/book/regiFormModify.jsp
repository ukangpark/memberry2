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
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<d:top />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
</head>


<body>

	<d:navBar current="regiFormModify" />

	<div class="container-lg">

		<div style="margin: 100px 300px 300px 300px; border: 8px double lightblue;">
			<form class="ui form" style="margin: 100px 100px 100px 100px" method="post" action="/book/modify/${book.num}">
				<!-- method="post" id="bookForm2" -->
				<input type="hidden" name="detailId" value="${book.detailId}" /> <input type="hidden" name="petId" value="${pet.id}" />

				<h2 class="ui dividing header" style="text-align: center">
					<i class="fa fa-solid fa-paw"></i> ${book.petName }(이)의 예약 변경 신청 <i class="fa fa-solid fa-paw"></i>
				</h2>
				<br> <input type="hidden" name="num" value="${book.num }" />
				<div class="field">
					<h4 class="ui header">이름</h4>
					<div class="field">

						<input type="text" name="petName" value="${book.petName }" disabled />

					</div>
				</div>
				<div class="field">
					<h4 class="ui header">생년월일</h4>
					<input type="text" name="birth" value="${pet.birth }" disabled />
				</div>



				<div class="ui form">

					<div class="inline fields">
						<label for="weight">몸무게</label>
						<div class="field">
							<div class="ui radio checkbox">
								<input type="radio" name="weight" tabindex="0" class="hidden" value="small" <c:if test="${pet.weight eq 'small' }"> checked</c:if> disabled /> <label>소형견 ( 7kg 미만 )</label>
							</div>
						</div>
						<div class="field">
							<div class="ui radio checkbox">
								<input type="radio" name="weight" tabindex="0" class="hidden" value="medium" <c:if test="${pet.weight eq 'medium' }"> checked</c:if> disabled /> <label>중형견 ( 7 ~ 14.9kg)</label>
							</div>
						</div>
						<div class="field">
							<div class="ui radio checkbox">
								<input type="radio" name="weight" tabindex="0" class="hidden" value="large" <c:if test="${pet.weight eq 'large' }"> checked</c:if> disabled /> <label>대형견 ( 15kg 이상 )</label>
							</div>
						</div>
					</div>
				</div>


				<h4 class="ui header">품종</h4>
				<div class="field">

					<input type="text" name="type" value="${pet.type }" disabled />

				</div>


				<h4 class="ui header">성별</h4>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" <c:if test="${pet.gender eq 'female' }"> checked</c:if> disabled /> <label class="btn btn-outline-secondary" for="btnradio1">여자</label> <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" <c:if test="${pet.gender eq 'male' }"> checked</c:if> disabled /> <label class="btn btn-outline-secondary" for="btnradio2">남자</label>
				</div>



				<h4 class="ui header">중성화</h4>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio1" id="btnradio3" autocomplete="off" <c:if test="${pet.neutered eq 'yes' }"> checked</c:if> disabled /> <label class="btn btn-outline-secondary" for="btnradio3">네</label> <input type="radio" class="btn-check" name="btnradio1" id="btnradio4" autocomplete="off" <c:if test="${pet.neutered eq 'no' }"> checked</c:if> disabled /> <label class="btn btn-outline-secondary" for="btnradio4">아니오</label>
				</div>





				<h4 class="ui header">배변훈련(배변패드)</h4>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" value="1" class="btn-check" name="pottyTraining" id="btnradio5" autocomplete="off" <c:if test="${book.pottyTraining eq '1' }"> checked</c:if> /> <label class="btn btn-outline-secondary" for="btnradio5">잘해요</label> <input type="radio" value="2" class="btn-check" name="pottyTraining" id="btnradio6" autocomplete="off" <c:if test="${book.pottyTraining eq '2' }"> checked</c:if> /> <label class="btn btn-outline-secondary" for="btnradio6">미숙해요</label> <input type="radio" value="3" class="btn-check" name="pottyTraining" id="btnradio7" autocomplete="off" <c:if test="${book.pottyTraining eq '3' }"> checked</c:if> /> <label class="btn btn-outline-secondary" for="btnradio7">실외배변</label>
				</div>




				<h4 class="ui header">자주 다니는 동물병원 이름과 위치(동)</h4>
				<div class="field">

					<input type="text" name="hospital" value="${book.hospital }">

				</div>


				<h4 class="ui header">전하고 싶은 말</h4>
				<div class="field">

					<textarea name="message" value="${book.message }" rows="4" placeholder="특이사항, 주의사항 등등 자유롭게 적어주세요">${book.message }</textarea>
				</div>



				<div style="display: flex; justify-content: flex-start;">
					<div class="field">
						<h4 class="ui header">체크인 날짜</h4>
						<input type="date" name="checkIn" id="checkIn" value="${book.checkIn }" onchange="javascript:fnCheckIn()">
					</div>

					<div class="field">
						<h4 class="ui header">체크아웃 날짜</h4>
						<input type="date" name="checkOut" id="checkOut" value="${book.checkOut }" onchange="javascript:fnCheckOut()">
					</div>
				</div>



				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">예약 변경 신청하기</button>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">예약변경 신청</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">확인버튼을 누르면 예약변경신청이 완료됩니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">확인</button>
					</div>
				</div>
			</div>
		</div>

			</form>
		</div>


	</div>

	<script>
		$('.ui.radio.checkbox').checkbox();

		//체크인 날짜 검사
		function fnCheckIn() {
			var checkInDate = $('#checkIn').val();
			var curDate = new Date();
			var formattedDate = moment(curDate).format('YYYY-MM-DD');
			console.log(formattedDate);
			if (checkInDate < formattedDate) {
				alert("현재 날짜 이후의 날짜를 선택해주세요.");
			}
		}

		//체크아웃 날짜 검사
		function fnCheckOut() {
			var checkOutDate = $('#checkOut').val();
			var checkInDate = $('#checkIn').val();
			if (checkOutDate < checkInDate) {
				alert("체크인 날짜보다 크거나 같은 날짜를 선택해주세요.");
			}
		}
	</script>

	<d:bottom></d:bottom>
</body>
</html>