// 비밀번호, 비밀번호 확인 input에 keyup 이벤트가 발생하면
$("#inputPassword, #inputPasswordCheck").keyup(function() {

	const pw1 = $("#inputPassword").val();
	const pw2 = $("#inputPasswordCheck").val();

	// 비밀번호에 입력한 값과 비밀번호 확인에 입력한 값이 같으면
	if (pw1 === pw2) {
		// submit 버튼 활성화 
		$("#signupSubmit").removeClass("disabled");

		// 비밀번호가 일치한다는 메세지 출력
		$("#passwordCheckSuccess").removeClass("d-none");
		$("#passwordCheckFail").addClass("d-none");
	} else {
		// 그렇지 않으면 submit 버튼 비활성화 
		$("#signupSubmit").addClass("disabled");

		//비밀번호가 일치하지 않는다는 메세지 출력
		$("#passwordCheckFail").removeClass("d-none");
		$("#passwordCheckSuccess").addClass("d-none");
	}

})

