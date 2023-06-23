listQnAComment();

const toastElement = document.querySelector("#liveToast")
const toast = bootstrap.Toast.getOrCreateInstance(toastElement);
$("#qnaCommentBtn").click(function() {
	const qnaId = $("#qnaIdText").text().trim();
	const content = $("#qnaCommentTextArea").val();
	const data = { qnaId, content };

	$.ajax("/qnaComment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listQnAComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();

			$("#qnaCommentTextArea").val("");
		}
	});
})

$("#qnaCommentUpdateBtn").click(function() {
	const commentId = $("#commentUpdateIdInput").val();
	const content = $("#qnaCommentUpdateTextArea").val();
	const data = {
		id: commentId,
		content: content
	}
	$.ajax("/qnaComment/update", {
		method: "put",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listQnAComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	})
})

function listQnAComment() {
	const qnaId = $("#qnaIdText").text().trim();

	$.ajax("/qnaComment/list?qna=" + qnaId, {
		method: "get",
		success: function(qnaComments) {
			//console.log(data);
			$("#qnaCommentListContainer").empty();
			for (const qnaComment of qnaComments) {
				const editButtons = `
				<button
						id="qnaCommentUpdateBtn${qnaComment.id}"
						class="qnaCommentUpdateButton ui olive button"
						data-bs-toggle="modal" data-bs-target="#commentUpdateModal"
						qnaData-comment-id="${qnaComment.id}"> 수정 </button>
				<button 
						id="qnaCommentDeleteBtn${qnaComment.id}" 
						class="qnaCommentDeleteButton ui red button"
						data-bs-toggle="modal" data-bs-target="#deleteCommentConfirmModal"
						qnaData-comment-id="${qnaComment.id}"> 삭제 </button>
					
				`;
				//console.log(qnaComment);
				$("#qnaCommentListContainer").append(`
					<div class="item">
						<img class="ui avatar image" src="/images/commentLogo.png" alt="" />
							<div class="content">
								<a class="header">${qnaComment.memberId} </a>
								<div class="description">${qnaComment.content}
									<a class="ui tag label">${qnaComment.inserted} </a>
									<span>
										${qnaComment.editable ? editButtons : ''}
									</span>
								</div>
							</div>
						</div>
				`);
			};

			$(".qnaCommentUpdateButton").click(function() {
				const id = $(this).attr("qnaData-comment-id");
				$.ajax("/qnaComment/id/" + id, {
					success: function(data) {
						$("#commentUpdateIdInput").val(data.id);
						$("#qnaCommentUpdateTextArea").val(data.content);
					}
				})
			});


			$(".qnaCommentDeleteButton").click(function() {
				const qnaCommentId = $(this).attr("qnaData-comment-id");
				$("#deleteCommentModalButton").attr("qnaData-comment-id", qnaCommentId);
			});
		}
	});
}

$("#deleteCommentModalButton").click(function() {
	const qnaCommentId = $(this).attr("qnaData-comment-id");
	$.ajax("/qnaComment/id/" + qnaCommentId, {
		method: "delete",
		complete: function(jqXHR) {
			listQnAComment();
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		}
	});

})
