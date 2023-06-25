let tagInputs = [];

function addTag() {
	const tagInput = $("#tagInput");
	const tagValue = tagInput.val().trim();
	tagInput.val('');

	if (tagValue !== '') {
		tagInputs.push(tagValue);

		$(".tagsContainer").append(`
			<span class="ui tag blue tiny label" style="margin: 2px 6px 2px 6px">${tagValue}<i class="icon mini close"></i></span>
		`);

		$("#addForm").append(`
			<input type="text" name="keyword" value="${tagValue}" style="display:none">
		`);
	}
}

$("#addTag").click(function() {
	addTag();
});

$("#tagInput").on("keyup", function(event) {
	if (event.keyCode === 13) {
		addTag();
	}
});

// 태그 삭제 코드
$(document).on("click", ".icon.mini.close", function() {
	const tagLabel = $(this).closest(".ui.tag.blue.tiny.label");
	const tagInputValue = tagLabel.text().trim();

	tagLabel.remove();
	$("input[name='keyword'][value='" + tagInputValue + "']").remove();
});
