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
						id="qnaCommentDeleteBtn${qnaComment.id}" 
						class="qnaCommentDeleteButton"
						qnaData-comment-id="${qnaComment.id}"> 삭제 </button>
					: 
					<button
						id="qnaCommentUpdateBtn${qnaComment.id}"
						class="qnaCommentUpdateButton"
						qnaData-comment-id="${qnaComment.id}"> 수정 </button>
				`;
				//console.log(qnaComment);
				$("#qnaCommentListContainer").append(`
					<div class="item">
						<img class="ui avatar image" src="/images/logo.png" alt="" />
							<div class="content">
								<a class="header">${qnaComment.memberId} </a>
								<div class="description">${qnaComment.content}
									<a class="ui tag label">${qnaComment.inserted} </a>
									<span>
										${qnaComment.editable ? editButtons : ''}
									</span>
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
				$.ajax("/qnaComment/id/" + qnaCommentId, {
					method: "delete",
					complete: function(jqXHR) {
						listQnAComment();
						$(".toast-body").text(jqXHR.responseJSON.message);
						toast.show();
					}
				});
			})
		}
	});
}

