$("#addTag").click(function() {
	const feedId = $("#feedId").val();
	const tagInput = $("#tagInput").val();
	console.log(tagInput);
	$("#tagInput").val('');
	tagList();
	function tagList() {
		$.ajax("/tag/list/" + feedId + "/" + tagInput, {
			success: function(tag) {
				console.log(tag);
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

$("#tagInput").on("keyup", function(event) {
    if (event.keyCode === 13) { // Enter 키의 keyCode는 13
        $("#addTag").click(); // Add Tag 버튼 클릭 이벤트를 실행
    }
});

$(document).on("click", ".icon.mini.close", function() {
    $(this).closest(".ui.tag.blue.tiny.label").remove();
});