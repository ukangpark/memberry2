$("#sendCommentBtn").click(function() {
	const feedId = $("#feedIdText").text().trim();
	const content = $("#commentTextArea").val();
	const data = {feedId, content};
	
	$.ajax("/comment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data)
	})
})