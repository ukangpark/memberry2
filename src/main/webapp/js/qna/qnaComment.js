//$("#qnaCommentBtn").click(function() {
//	const memberId = $("#qnaWriter").text().trim();
	//const content = $("#qnaCommentTextArea").val();
//	const data = { memberId, content };
//	console.log("click");

//	$.ajax("/qnaComment/add", {
//		method: "post",
//		contentType: "application/json",
//		data: JSON.stringify(data)
//	});
//})


const qnaId = $("#qnaIdText").text().trim();

$.ajax("/qnaComment/list?qna=" + qnaId, {
	method: "get",
	success: function(qnaComments){
		//console.log(data);
		$("#qnaCommentListContainer").empty();
		for(const qnaComment of qnaComments){
			//console.log(qnaComment);
			$("#qnaCommentListContainer").append(`
				<div>
					${qnaComment.content} : ${qnaComment.memberId} : ${qnaComment.inserted}
				</div>
			`)
		}	
	}
});
