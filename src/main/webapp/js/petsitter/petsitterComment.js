listComment();

$("#sendCommentBtn").click(function() {
	const boardId = $("#detailIdText").text().trim();
	const content = $("#commentTextArea").val();
	const data = { boardId, content };

	$.ajax("/petsitterComment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function() {
			listComment();
		}
	})
})

function listComment() {
	const detailId = $("#detailIdText").text().trim();
	$.ajax("/petsitterComment/list?detailId=" + detailId, {
		method: "get", // 생략 가능
		success: function(comments) {
			// console.log(data);
			$("#commentListContainer").empty();
			for (const comment of comments) {
				// console.log(comment);
				$("#commentListContainer").append(`
					<div>
					<button 
							id="commentDeleteBtn${comment.id}" 
							class="commentDeleteButton" 
							data-comment-id="${comment.id}">삭제</button>
						${comment.content} 
						: ${comment.memberId} 
						: ${comment.inserted}
					</div>
				`);
			}
			$(".commentDeleteButton").click(function() {
				const commentId = $(this).attr("data-comment-id");
				$.ajax("/comment/id/" + commentId, {
					method: "delete"
				});
			})
		}
	});

}