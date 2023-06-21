document.addEventListener('DOMContentLoaded', function() {
	var siSelect = document.getElementById("si");
	var guSelect = document.getElementById("gu");
	var dongSelect = document.getElementById("dong");

	siSelect.addEventListener("change", selectGu);
	guSelect.addEventListener("change", selectDong);

	function selectGu() {
		// 기존의 구 옵션들 제거
		while (guSelect.options.length > 0) {
			guSelect.remove(0);
		}

		// 선택한 시에 따라 구 옵션 추가
		if (siSelect.value === "서울시") {
			var guArray = [
				"종로구",
				"중구",
				"용산구",
				"성동구",
				"광진구",
				"동대문구",
				"중랑구",
				"성북구",
				"강북구",
				"도봉구",
				"노원구",
				"은평구",
				"서대문구",
				"마포구",
				"양천구",
				"강서구",
				"구로구",
				"금천구",
				"영등포구",
				"동작구",
				"관악구",
				"서초구",
				"강남구",
				"송파구",
				"강동구"
			];
		} else if (siSelect.value === "부산시") {
			var guArray = [
				"중구",
				"서구",
				"동구",
				"영도구",
				"부산진구",
				"동래구",
				"남구",
				"북구",
				"해운대구",
				"사하구",
				"금정구",
				"강서구",
				"연제구",
				"수영구",
				"사상구",
				"기장군"
			];

		}


		// 구 옵션들을 추가
		for (var i = 0; i < guArray.length; i++) {
			var option = document.createElement("option");
			option.text = guArray[i];
			option.value = guArray[i];
			guSelect.add(option);
		}
	}

	function selectDong() {
		// 기존의 행정동 옵션들 제거
		while (dongSelect.options.length > 0) {
			dongSelect.remove(0);
		}

		// 선택한 구에 따라 행정동 옵션 추가
		if (guSelect.value === "종로구") {
			var dongArray = [
				"청운효자동",
				"사직동",
				"삼청동",
				"부암동",
				"평창동",
				"무악동",
				"교남동",
				"가회동",
				"종로1.2.3.4가동",
				"종로5.6가동",
				"이화동",
				"혜화동",
				"창신1동",
				"창신2동",
				"창신3동",
				"숭인1동",
				"숭인2동",
				"월계1동",
				"월계2동",
				"월계3동",
				"공릉1동",
				"공릉2동",
				"하계1동",
				"하계2동",
				"중계본동",
				"중계1동",
				"중계2.3동",
				"상계1동",
				"상계2동",
				"상계3.4동",
				"상계5동",
				"상계6.7동",
				"상계8동",
				"상계9동",
				"상계10동"
				// 종로구의 다른 행정동들을 추가로 작성해주세요
			];
		} else if (guSelect.value === "중구") {
			var dongArray = [
				"소공동",
				"회현동",
				"명동",
				"필동",
				"장충동",
				"광희동",
				"을지로동",
				"신당동",
				"다산동",
				"약수동",
				"청구동",
				"신당5동",
				"동화동",
				"황학동",
				"중림동",
				"후암동",
				"용산2가동",
				"남대문로4가동",
				"남대문로5가동",
				"남산2동"
				// 중구의 다른 행정동들을 추가로 작성해주세요
			];
		} else if (guSelect.value === "용산구") {
			var dongArray = [
				"후암동",
				"용산2가동",
				"남영동",
				"청파동",
				"원효로1동",
				"원효로2동",
				"효창동",
				"용문동",
				"한강로동",
				"이촌1동",
				"이촌2동",
				"이태원1동",
				"이태원2동",
				"한남동",
				"서빙고동",
				"보광동",
				"동자동",
				"청암동",
				"용산3가동",
				"용산4가동",
				"용산5가동",
				"용산6가동",
				"원효로3동",
				"원효로4동",
				"이촌동",
				"주성동",
				"용산동"
				// 용산구의 다른 행정동들을 추가로 작성해주세요
			];
		}

		// 행정동 옵션들을 추가
		for (var i = 0; i < dongArray.length; i++) {
			var option = document.createElement("option");
			option.text = dongArray[i];
			option.value = dongArray[i];
			dongSelect.add(option);
		}
	}
});
