listComment();

function listComment() {
	const detailId = $("#detailIdText").text().trim();
	console.log(detailId); //check
	
	$.ajax("/petsitterComment/list?detailId=" + detailId, {
		method: "get",
		success: function(petsitterComments) {
			console.log(petsitterComments); //check
			$("#commentListContainer").empty();
			for(const petsitterComment of petsitterComments) {
				console.log(petsitterComment); //check
				$("#commentListContainer").append(`
				<a class="avatar">
					<img src="/images/paw.png">
				</a>
				<div class="content">
					<a class="author">${petsitterComment.memberId}</a>
					<div class="metadata">
						<span class="date">${petsitterComment.inserted}</span>
					</div>
					<div class="text">${petsitterComment.body}</div>
					<div class="actions">
						<a id="commentDeleteBtn${petsitterComment.id}" 
							class="commentDeleteBtn" class="btn btn-primary" 
							data-bs-toggle="modal" 
							data-bs-target="#deleteCommentModal"
							comment-id="${petsitterComment.id}">
						삭제
						</a>
						<a id="comment-modify-btn${petsitterComment.id}" 
							class="commentModifyBtn" 
							comment-id="${petsitterComment.id}">
						수정
						</a>
					</div>
				</div>
				<br>
				`)
			}
			
			$(".commentDeleteBtn").click(function() {
				const commentId = $(this).attr("comment-id");
				$("#commentDeleteModalBtn").attr("comment-id", commentId);
			});
			
			$(".commentModifyBtn").click(function() {
				const commentId = $(this).attr("comment-id");
				$.ajax("/petsitterComment/get/" + commentId, {
					success: function(comment) {
						// 버튼을 바꿈
						$("#commentInput").empty();
						$("#commentInput").append(`
							<div class="input-group">
								<input id="commentModifyInput" type="text" class="form-control">
								<button id="modifyBtn" style="width:65px;" class="btn btn-outline-primary" type="button">수정</button>
								<button id="cancleBtn" style="width:65px;" class="btn btn-outline-danger" type="button">취소</button>
							</div>
						`)
						
						//기존의 후기 내용을 넣어줌
						$("#commentModifyInput").val(comment.body);
						
						//수정버튼을 누르면
						$("#modifyBtn").click(function() {
							const body = $("#commentModifyInput").val();
							console.log(body);
							const data = { id: commentId, body: body };
							$.ajax("/petsitterComment/modify", {
								method: "put",
								contentType: "application/json",
								data: JSON.stringify(data),
								complete: function(jqXHR) {
									listComment();
								}
							})
						})
						
						//취소버튼을 누르면 
						$("#cancleBtn").click(function(){
							$("#commentInput").empty();
							$("#commentInput").append(`
								<div class="input-group mb-3" style="width: 880px;" id="commentInput">
									<input id="commentModifyInput" type="text" id="commentBodyArea" class="form-control" placeholder="후기를 남겨주세요." >
									<button style="width:65px;" class="btn btn-outline-secondary" id="addCommentBtn">추가</button>
								</div>
							`);
						})
					}
				})
			})
		}
	})	
}


$("#addCommentBtn").click(function() {
	const detailId = $("#detailIdText").text().trim();
	const body = $("#commentBodyArea").val();
	const data = { detailId, body };
	
	console.log(data); //check
	
	$.ajax("/petsitterComment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listComment();
			//$(".toast-body").text(jqXHR.responseJSON.message);
			//toast.show();

			$("#commentBodyArea").val("");
		}
	})
})

$("#commentDeleteModalBtn").click(function() {
	const commentId = $(this).attr("comment-id");
	$.ajax("/petsitterComment/delete/" + commentId, {
		method: "delete",
		complete: function() {
			listComment();

		}
	})
})









