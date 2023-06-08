listComment();

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
						<button
						id="commentUpdateBtn${comment.id}"
						class="commentUpdateButton"
						data-comment-id="${comment.id}">수정
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
					method: "delete",
					complete: function() {
						listComment();
					}
				});
			})
			$(".commentUpdateButton").click(function() {
				const id = $(this).attr("data-comment-id");
				$.ajax("/comment/id/" + id, {
					success: function(data) {
						$("#commentUpdateIdInput").val(date.id)
						$("#commentUpdateTextArea").val(data.content);
					}
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
$("#commentUpdateBtn").click(function() {
	const commentId = $("#commentUpdateInput").val();
	const content = $("#commentUpdateTextArea").val();
	
	const data = {
		id : commentId,
		content : content
	}
	$.ajax("/comment/update", {
		method: "put",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	})
})