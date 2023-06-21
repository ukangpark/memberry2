document.addEventListener('DOMContentLoaded', function() {
	var guSelect = document.getElementById("gu");
	var dongSelect = document.getElementById("dong");

	guSelect.addEventListener("change", selectDong);

	function selectDong() {
		// 기존의 행정동 옵션들 제거
		while (dongSelect.options.length > 0) {
			dongSelect.remove(0);
		}

		// 선택한 구에 따라 행정동 옵션 추가
		if (guSelect.value === "종로구") {
			var dongArray = [
				"청운동",
				"신교동",
				"궁정동"
				// 종로구의 다른 행정동들을 추가로 작성해주세요
			];
		} else if (guSelect.value === "중구") {
			var dongArray = [
				"소공동",
				"회현동",
				"명동"
				// 중구의 다른 행정동들을 추가로 작성해주세요
			];
		} else if (guSelect.value === "용산구") {
			var dongArray = [
				"청파동",
				"이태원동",
				"한남동"
				// 용산구의 다른 행정동들을 추가로 작성해주세요
			];
		}

		// 행정동 옵션들을 추가
		for (var i = 0; i < dongArray.length; i++) {
			var option = document.createElement("option");
			option.text = dongArray[i];
			dongSelect.add(option);
		}
	}
});
