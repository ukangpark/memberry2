// 아이디, 닉네임, 이메일, 연락처 중복 / 비밀번호 일치 여부를 저장하고 있는 변수
let checkId = false;
let checkNickName = false;
let checkEmail = false;
let checkPhoneNumber = false;
let checkPassword = false;

function enableSubmit(){
	if(checkId && checkNickName && checkEmail && checkPhoneNumber && checkPassword){
		$("#signupSubmit").removeAttr("disabled");
	} else {
		$("#signupSubmit").attr("disabled", "");
	}
}

// input 아이디에 keyup 이벤트 발생시
$("#inputId").keyup(function(){
	// 아이디 중복확인 다시
	checkId = false;
	$("#availableIdMessage").addClass("d-none");
	$("#notAvailableIdMessage").addClass("d-none");
	
	// submit 버튼 비활성화
	enableSubmit();
})

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
				checkId = true;
			} else {
				// 사용 불가능하다는 메세지 출력
				$("#notAvailableIdMessage").removeClass("d-none");
				$("#availableIdMessage").addClass("d-none");
				checkId = false;
			}
		},
		complete: enableSubmit
	})
})

// input 닉네임에 keyup 이벤트 발생시
$("#inputNickName").keyup(function(){
	// 닉네임 중복확인 다시
	checkNickName = false;
	$("#availableNickNameMessage").addClass("d-none");
	$("#notAvailableNickNameMessage").addClass("d-none");
	
	// submit 버튼 비활성화
	enableSubmit();
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
				checkNickName = true;
			}else{
				$("#notAvailableNickNameMessage").removeClass("d-none");
				$("#availableNickNameMessage").addClass("d-none");
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
	$("#availableEmailMessage").addClass("d-none");
	$("#notAvailableEmailMessage").addClass("d-none");
	
	// submit 버튼 비활성화
	enableSubmit();
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
				checkEmail = true;
			} else {
				$("#notAvailableEmailMessage").removeClass("d-none");
				$("#availableEmailMessage").addClass("d-none");
				checkEmail = false;
			}
		},
		complete: enableSubmit
	})
})

// input 연락처에 keyup 이벤트 발생시
$("#inputPhoneNumber").keyup(function(){
	// 연락처 중복확인 다시
	checkId = false;
	$("#availablePhoneNumberMessage").addClass("d-none");
	$("#notAvailablePhoneNumberMessage").addClass("d-none");
	
	// submit 버튼 비활성화
	enableSubmit();
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
		// submit 버튼 활성화 
		$("#signupSubmit").removeClass("disabled");

		// 비밀번호가 일치한다는 메세지 출력
		$("#passwordCheckSuccess").removeClass("d-none");
		$("#passwordCheckFail").addClass("d-none");
		checkPassword = true;
	} else {
		// 그렇지 않으면 submit 버튼 비활성화 
		$("#signupSubmit").addClass("disabled");

		//비밀번호가 일치하지 않는다는 메세지 출력
		$("#passwordCheckFail").removeClass("d-none");
		$("#passwordCheckSuccess").addClass("d-none");
		checkPassword = false;
	}
	enableSubmit();
})
