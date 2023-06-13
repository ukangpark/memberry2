listComment();

//댓글 리스트 불러오기
function listComment() {
	const feedId = $("#feedIdText").text().trim();
	$.ajax("/comment/list?feed=", feedId, {
		success: function(comments) {
			$("commentListContainer").empty();
			for(const comment of comments) {
				const editButtons = `
						<button
						id="commentDeleteBtn${comment.id}"
						class="commentDeleteButton btn btn-danger"
						data-bs-toggle="modal"
						data-bs-target="#deleteCommentConfirmModal"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-trash-can"></i>
						</button>
						<button
						id="commentUpdateBtn${comment.id}"
						class="commentUpdateButton btn btn-secondary"
						data-bs-toggle="modal"
						data-bs-target="#commentUpdateModal"
						class="commentUpdateButton"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>
				`;		
				$("commentListContainer").append(`
				<li class="list-group item d-flex justify-content-between align-items-start">
					<div class="ms-2 me-auto">
						<div class="fw-bold"><i class="fa-solid fa-user></i>${comment.memberId}</div>
						<div style="white-space: pre-wrap;">${comment.content}</div>
					</div>
					<div>
						<span class="badge bg-secondary rounded-pill>${comment.inserted}</span>
						<div class="text-end mt-2">
							${comment.editable ? editButtons : ''}
						</div>
					</div>
				</li>
				`);
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
			$(".commentDeleteButton").click(function() {
				const commentId = $(this).attr("data-comment-id");
				$("#deleteCommentModalButton").attr("data-comment-id", commentId);
			});
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
			$("#commentTextArea").val("");
		},
		
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
$("#deleteCommentModalButton").click(function() {
	const commentId = $(this).attr("data-comment-id");
	$.ajax("/comment/id/" + commentId, {
		method: "delete",
		complete: function(jqXHR) {
			listComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	});
});
$("#deleteCommentModalButton").click(function() {
	const commentId = $(this).attr("data-comment-id");
	$.ajax("/comment/id/" + commentId, {
		method: "delete",
		complete: function(jqXHR) {
			listComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	});
});