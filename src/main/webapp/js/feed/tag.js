$("#addTag").click(function() {
	const tagInput = $("#tagInput").val();
	//$("#tagInput").val('');

	$(".tagsContainer").append(`
   		<span class="ui tag blue tiny label" style="margin: 2px 6px 2px 6px">${tagInput} <i class="icon mini close"></i></span>
    `);
	//tagList();

});

// 엔터 시, add tag버튼 실행
/*$("#tagInput").on("keyup", function(event) {
	if (event.keyCode === 13) { // Enter 키의 keyCode는 13
		$("#addTag").click(); // Add Tag 버튼 클릭 이벤트를 실행
	}
});*/

// 태그 삭제 코드
$(document).on("click", ".icon.mini.close", function() {
	const tagLabel = $(this).closest(".ui.tag.blue.tiny.label");
	tagLabel.remove();
})
