//댓글 리스트 불러오기
function listComment() {
	const feedId = $("#feedIdText").text().trim();
	$.ajax("/comment/list?feed=", feedId, {
		success: function(comments) {
			$("commentListContainer").empty();
			for(const comment of comments) {
				$("commentListContainer").append(
					<div>
						<button
						id="commentDeleteBtn${comment.id}"
						class="commentDeleteButton"
						data-comment-id="${comment.id}">삭제
						</button>
						: ${comment.content}
						: ${comment.memberId}
						: ${comment.inserted}
					</div>
				);
			};
			$(".commentDeleteButton").click(function() {
				const commentId = $(this).attr("data-comment-id");
				$.ajax("/comment/id/" + commentId, {
					method: "delete"
				});
			})
		}
	})
}



$("#sendCommentBtn").click(function() {
	const feedId = $("#feedIdText").text().trim();
	const content = $("#commentTextArea").val();
	const data = {feedId, content};
	
	$.ajax("/comment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function() {
			listComment();
		}
	})
})