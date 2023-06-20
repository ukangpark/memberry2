$("#addTag").click(function() {
	const tagInput = $("#tagInput").val();
	console.log(tagInput);
	tagList();
	function tagList() {
		$.ajax("/tag/list/" + tagInput, {
			success: function(tag) {
				console.log(tag);
				$(".tagsContainer").empty();
				for (const tags of tag) {
					$(".tagsContainer").append(`
					<span class="ui tag blue tiny label" style="margin: 2px 6px 2px 6px">${tags.keyword}</span>
					`)
				}
			}
		});
	}
})