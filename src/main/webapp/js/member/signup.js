// id 중복확인 버튼이 클릭되면
$("#checkIdBtn").click(function() {
	const userid = $("#inputId").val();
	// 입력한 ID와 ajax 요청 보내서 결과에 따라 다른 메세지 보여주기`
	$.ajax("/member/checkId/" + userid, {
		success: function(data) {
			// `{"available" : true}`
			if (data.available) {
				// 사용 가능하다는 메세지 출력
				$("#availableIdMessage").removeClass("d-none");
				$("#notAvailableIdMessage").addClass("d-none");
			} else {
				// 사용 불가능하다는 메세지 출력
				$("#notAvailableIdMessage").removeClass("d-none");
				$("#availableIdMessage").addClass("d-none");
			}
		}
	})

})

// nickName 중복확인 버튼이 클릭되면
$("#checkNickNameBtn").click(function(){
	const usernickname = $("#inputNickName").val();
	//입력한 nickname과 ajax요청 보내서 결과에 따라 다른 메세지 보여주기
	$.ajax("/member/checkNickName/" + usernickname, {
		success: function(data){
			//`{"available" : true}`
			if(data.available){
				$("#availableNickNameMessage").removeClass("d-none");
				$("#notAvailableNickNameMessage").addClass("d-none");
			}else{
				$("#notAvailableNickNameMessage").removeClass("d-none");
				$("#availableNickNameMessage").addClass("d-none");
			}
		}
	})
})

// email 중복확인 버튼이 클릭되면
$("#checkEmailBtn").click(function(){
	const useremail = $("#inputEmail").val();
	//입력한 email과 ajax 요청 보내서 결과에 따라 다른 메세지 보여주기
	$.ajax("/member/checkEmail/" + useremail, {
		success: function(data){
			//`{"available" : true}`
			if(data.available){
				$("#availableEmailMessage").removeClass("d-none");
				$("#notAvailableEmailMessage").addClass("d-none");
			} else {
				$("#notAvailableEmailMessage").removeClass("d-none");
				$("#availableEmailMessage").addClass("d-none");
			}
		}
	})
})

// 연락처 중복확인 버튼이 클릭되면
$("#checkPhoneNumberBtn").click(function(){
	const userphonenumber = $("#inputPhoneNumber").val();
	//입력한 연락처와 ajax 요청 보내서 결과에 따라 다른 메세지 보여주기
	$.ajax("/member/checkPhoneNumber/" + userphonenumber, {
		success: function(data){
			//`{"available" : true}`
			if(data.available){
				$("#availablePhoneNumberMessage").removeClass("d-none");
				$("#notAvailablePhoneNumberMessage").addClass("d-none");
			} else {
				$("#notAvailablePhoneNumberMessage").removeClass("d-none");
				$("#availablePhoneNumberMessage").addClass("d-none");
			}
		}
	})
})

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
