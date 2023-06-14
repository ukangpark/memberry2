//댓글 목록 
listComment();

//댓글 등록 버튼 클릭시
$("#sendCommentBtn").click(function() {
	const feedId = $("#feedIdText").text().trim();
	const content = $("#commentTextArea").val();
	const data = { feedId, content };

	$.ajax("/comment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listComment();
			//완료 시 메세지 토스트에 보이기
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
			// 댓글 등록 후 입력 창 비우기
			$("#commentTextArea").val("");
		}
	});
})
// 수정 버튼 클릭시
$("#updateCommentBtn").click(function() {
	const commentId = $("#commentUpdateIdInput").val();
	const content = $("#commentUpdateTextArea").val();
	const data = {
		id: commentId,
		content: content
	}
	$.ajax("/comment/update", {
		method: "put",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listComment();
			//완료 시 메세지 토스트에 보이기
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	})
})

function listComment() {
	const feedId = $("#feedIdText").text().trim();
	$.ajax("/comment/list?myFeed=" + feedId, {
		method: "get", 
		success: function(comments) {
			// console.log(data);
			$("#commentListContainer").empty();  //비우기
			for (const comment of comments) {
				const editButtons = `
					<button 
						id="commentDeleteBtn${comment.id}" 
						class="commentDeleteButton btn btn-danger-link"
						data-bs-toggle="modal"
						data-bs-target="#deleteCommentConfirmModal"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-trash-can" style="color:red;"></i>
						</button>
					<button
						id="commentUpdateBtn${comment.id}"
						class="commentUpdateButton btn btn-secondary-link"
						data-bs-toggle="modal" 
						data-bs-target="#commentUpdateModal"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-pen-to-square" style="color:blud;"></i>
						</button>
				`;

				
				$("#commentListContainer").append(`
					<li class="list-group-item d-flex justify-content-between align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold d-flex align-items-center" > 
							<div>
							<img class="ui avatar image" id="nav-image" src="https://lilysbucket0503.s3.ap-northeast-2.amazonaws.com/membery/pet${comment.profileImage}"> 
							</div>
							<div>
							${comment.nickName}
							</div>
							</div>
							<div style="white-space: pre-wrap;">${comment.content}</div>
						</div>
						<div>
							<span class="badge bg-secondary rounded-pill">${comment.inserted}</span>
							<div class="text-end mt-2">
								${comment.editable ? editButtons : ''}
							</div>
						</div>
						
					</li>
				`);
			};
			$(".commentUpdateButton").click(function() {
				const id = $(this).attr("data-comment-id");
				$.ajax("/comment/id/" + id, {
					success: function(data) {
						$("#commentUpdateIdInput").val(data.id);
						$("#commentUpdateTextArea").val(data.content);

					}
				})
			});

			$(".commentDeleteButton").click(function() {
				const commentId = $(this).attr("data-comment-id");
				$("#deleteCommentModalButton").attr("data-comment-id", commentId);
			});
		}
	});

}

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