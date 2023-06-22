$("#addTag").click(function() {
	const feedId = $("#feedId").val();
	const tagInput = $("#tagInput").val();
	$("#tagInput").val('');
	tagList();
	function tagList() {
		$.ajax("/tag/list/" + feedId + "/" + tagInput, {
			success: function(tag) {
				$(".tagsContainer").empty();
				for (const tags of tag) {
					$(".tagsContainer").append(`
					<span class="ui tag blue tiny label" style="margin: 2px 6px 2px 6px">${tags.keyword} <i class="icon mini close"></i></span>
					`)
				}
			}
		});
	}
});

// 엔터 시, add tag버튼 실행
$("#tagInput").on("keyup", function(event) {
	if (event.keyCode === 13) { // Enter 키의 keyCode는 13
		$("#addTag").click(); // Add Tag 버튼 클릭 이벤트를 실행
	}
});

// 태그 삭제 코드
$(document).on("click", ".icon.mini.close", function() {
	const feedId = $("#feedId").val();
	const tagLabel = $(this).closest(".ui.tag.blue.tiny.label");
	const tagKeyword = tagLabel.text().trim();
	const data = { keyword: tagKeyword }
	// 서버로 태그 삭제 요청 보내기
	$.ajax("/tag/delete/" + feedId + "/" + tagKeyword, {
		method: "POST",
		data: JSON.stringify(data),

		success: function(response) {
			// 서버에서 삭제 요청이 성공적으로 처리되었을 경우 UI에서 태그 제거
			tagLabel.remove();
		}
	})
})
