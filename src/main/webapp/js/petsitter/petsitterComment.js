listComment();

function listComment() {
	const detailId = $("#detailIdText").text().trim();

	$.ajax("/petsitterComment/list?detailId=" + detailId, {
		method: "get",
		success: function(petsitterComments) {
			$("#commentListContainer").empty();
			for (const petsitterComment of petsitterComments) {
				$("#commentListContainer").append(`
				<a class="avatar">
					<img src="${bucketUrl}/pet/${petsitterComment.defaultPetId}/${petsitterComment.photo}">
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

			//댓글 아래 있는 삭제 버튼을 누르면 
			$(".commentDeleteBtn").click(function() {
				const commentId = $(this).attr("comment-id");
				$("#commentDeleteModalBtn").attr("comment-id", commentId);
			});

			//댓글 아래 있는 수정 버튼을 누르면 
			$(".commentModifyBtn").click(function() {
				const commentId = $(this).attr("comment-id");

				// 해당 댓글의 내용을 조회함 
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
							console.log(body); //check 
							const data = { id: commentId, body: body };
							console.log(data);

							//댓글 수정 요청 
							$.ajax("/petsitterComment/modify", {
								method: "put",
								contentType: "application/json",
								data: JSON.stringify(data),
								success: function() {
									// 원래의 댓글 창으로 돌아옴 
									$("#commentInput").empty();
									$("#commentInput").append(`
										<div class="input-group mb-3" style="width: 880px;" id="commentInput">
											<input type="text" id="commentBodyArea" class="form-control right" placeholder="후기를 남겨주세요.">
											<button style="width:65px;" class="btn btn-outline-secondary" id="addCommentBtn">추가</button>
										</div>
										`)

									listComment();
								}
							})
						})

						//취소버튼을 누르면 입력창으로 돌아감 
						$("#cancleBtn").click(function() {
							$("#commentInput").empty();
							$("#commentInput").append(`
								<div class="input-group mb-3" style="width: 880px;" id="commentInput">
									<input type="text" id="commentBodyArea" class="form-control" placeholder="후기를 남겨주세요." >
									<button style="width:65px;" class="btn btn-outline-secondary" id="addCommentBtn">추가</button>
								</div>
							`);

							$("#addCommentBtn").click(function() {
								const detailId = $("#detailIdText").text().trim();
								const body = $("#commentBodyArea").val();
								const data = { detailId, body };


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
	console.log(detailId + ", " + body)

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



$(document).ready(function() {
	$('.ui.rating.star')
	  .rating({
	    initialRating: 0,
	    maxRating: 5,
	    onRate: function(rating) {
	        $("#starRating").val(rating);
	        
	        if(rating == 1) {
				$("#commentForStar").empty();
				$("#commentForStar").append(`
					<h3 class="ui header center aligned">
						별로예요..
					</h3>
				`)
			} else if(rating == 2) {
				$("#commentForStar").empty();
				$("#commentForStar").append(`
					<h3 class="ui header center aligned">
						그냥 그래요..
					</h3>
				`)
			} else if(rating == 3) {
				$("#commentForStar").empty();
				$("#commentForStar").append(`
					<h3 class="ui header center aligned">
						좋았어요!!
					</h3>
				`)
			} else if(rating == 4) {
				$("#commentForStar").empty();
				$("#commentForStar").append(`
					<h3 class="ui header center aligned">
						추천해요!!!
					</h3>
				`)
			} else if(rating == 5) {
				$("#commentForStar").empty();
				$("#commentForStar").append(`
					<h3 class="ui header center aligned">
						최고였어요!!🩷
					</h3>
				`)
			}
	    }
	  })
});






