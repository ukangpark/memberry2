// 닉네임, 이메일, 연락처 중복 / 비밀번호 일치 여부를 저장하고 있는 변수
let checkNickName = true;
let checkEmail = true;
let checkPhoneNumber = true;
let checkPassword = true;

function enableSubmit() {
	if(checkNickName && checkEmail && checkPhoneNumber && checkPassword) {
		$("#modifySave").removeAttr("disabled");
	} else {
		$("#modifySave").attr("disabled", "");
	}
}

// input 닉네임에 keyup 이벤트 발생시
$("#inputNickName").keyup(function(){
	// 닉네임 중복확인 다시
	checkNickName = false;
	// 메세지 보이지 않게
	$("#availableNickNameMessage").addClass("d-none");
	$("#notAvailableNickNameMessage").addClass("d-none");
	
	// enableSubmit함수를 이용해서 submit버튼 비활성화
	enableSubmit();
})

// nickName 중복확인 버튼이 클릭되면
$("#checkNickNameBtn").click(function(){
	// userNickName이라는 변수에 inputNickName에 입력된 값 담기
	const userNickName = $("#inputNickName").val();
	// 입력한 닉네임과 ajax요청 보내서 결과에 따라 다른 메세지 보여주기
	$.ajax("/member/checkNickName/" + userNickName, {
		success: function(data){
			// {"available" : true}
			if (data.available) {
				// 사용 가능한 닉네임입니다.
				$("#availableNickNameMessage").removeClass("d-none");
				$("#notAvailableNickNameMessage").addClass("d-none");
				
				// 중복확인되었다는 표시
				checkNickName = true;
			} else {
				// 사용 불가능한 닉네임입니다.
				$("#notAvailableNickNameMessage").removeClass("d-none");
				$("#availableNickNameMessage").addClass("d-none");
				
				// 중복확인 안되었다는 표시
				checkNickName = false;
			}
		}, 
		complete: enableSubmit
	}) 
})

// input 이메일에 keyup 이벤트 발생시
$("#inputEmail").keyup(function(){
	// 이메일 중복확인 다시
	checkEmail = false;
	// 메세지 보이지 않도록
	$("#availableEmailMessage").addClass("d-none");
	$("#notAvailableEmailMessage").addClass("d-none");
	// 저장 버튼을 비활성화
	enableSubmit();
})

// email 중복확인 버튼이 클릭되면
$("#checkEmailBtn").click(function(){
	// input 이메일에 입력된 값을 변수에 담기
	const userEmail = $("#inputEmail").val();
	// 입력한 이메일값과 ajax 요청 보내서 결과에 따라 다른 메세지 보여주기
	$.ajax("/member/checkEmail/" + userEmail, {
		success: function(data){
			// {"available" : true}
			if(data.available){
				// 사용 가능한 이메일입니다.
				$("#availableEmailMessage").removeClass("d-none");
				$("#notAvailableEmailMessage").addClass("d-none");
				checkEmail = true;
			} else {
				// 사용 불가능한 이메일입니다.
				$("#notAvailableEmailMessage").removeClass("d-none");
				$("#availableEmailMessage").addClass("d-none");
				checkEmail = false;
			}
		},
		complete: enableSubmit
	})
})

// input 연락처에 keyup 이벤트 발생시
$("#inputPhoneNumberBtn").click(function(){
	checkPhoneNumber = false;
	$("#availablePhoneNumberMessage").addClass("d-none");
	$("#notAvailablePhoneNumberMessage").addClass("d-none");
	enableSubmit();
})

// phoneNumber 중복확인 버튼이 클릭되면
$("#checkPhoneNumberBtn").click(function(){
	const userPhoneNumber = $("#inputPhoneNumber").val();
	$.ajax("/member/checkPhoneNumber/" + userPhoneNumber, {
		success: function(data) {
			//{"available" : true}
			if(data.available){
				$("#availablePhoneNumberMessage").removeClass("d-none");
				$("#notAvailablePhoneNumberMessage").addClass("d-none");
				checkPhoneNumber = true;
			} else {
				$("#notAvailablePhoneNumberMessage").removeClass("d-none");
				$("#availablePhoneNumberMessage").addClass("d-none");
				checkPhoneNumber = false;
			}
		},
		complete: enableSubmit
	})
})

// 비밀번호, 비밀번호 확인 input에 keyup 이벤트가 발생하면
$("#inputPassword, #inputPasswordCheck").keyup(function() {

	const pw1 = $("#inputPassword").val();
	const pw2 = $("#inputPasswordCheck").val();

	// 비밀번호에 입력한 값과 비밀번호 확인에 입력한 값이 같으면
	if (pw1 === pw2) {

		// 저장 버튼 활성화
		$("#modifySave").removeClass("disabled");

		// 비밀번호가 일치한다는 메세지 출력
		$("#passwordCheckSuccess").removeClass("d-none");
		$("#passwordCheckFail").addClass("d-none");

	} else {
		// 저장 버튼 비활성화
		$("#modifySave").addClass("disabled");

		// 비밀번호가 일치하지 않는다는 메세지 출력
		$("#passwordCheckFail").removeClass("d-none");
		$("#passwordCheckSuccess").addClass("d-none");
	}
})