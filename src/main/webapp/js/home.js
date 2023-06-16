home();

function home() {
	$('.slider').bxSlider();
};

	


// 댓글 js
//$(".btnTriggerModal").click(function() {
	const feedId = $("#feedId").text().trim();
	const profileSrc = $("#profile").attr("src");
	listComment();
	function listComment() {

		$.ajax("comment/list?myFeed=" + feedId, {
			method: "get",
			success: function(comments) {
				$("#commentListContainer").empty();
				for (const comment of comments) {
					const editButtons = `
						<button 
								id="commentDeleteBtn${comment.id}" 
								class="commentDeleteButton btn btn-danger-link"
								data-comment-id="${comment.id}">
									<i class="fa-regular fa-trash-can" style="color:red;"></i>
								</button>
						 <button
								id="commentUpdateBtn${comment.id}"
								class="commentUpdateButton btn btn-secondary-link"
								data-comment-id="${comment.id}">
									<i class="fa-regular fa-pen-to-square" style="color:blue;"></i>
								</button>
					`;

					$("#commentListContainer").append(`
						<li class="list-group-item d-flex justify-content-between align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold d-flex align-items-center"> 
							<div>
								<img class="ui avatar image" style="border: solid 1px" src = ${comment.profileImage != null ? "https://lilysbucket0503.s3.ap-northeast-2.amazonaws.com/membery/pet" + comment.profileImage : "/images/paw.png"}>  
							</div >

					<div> ${comment.nickName}</div>
							</div >
					<div style="white-space: pre-wrap;">${comment.content}</div>
						</div >
					<div>
						<span class="badge bg-secondary rounded-pill">${comment.inserted}</span>
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
						complete: function(jqXHR) {
							listComment();
							$(".toast-body").text(jqXHR.responseJSON.message);
							toast.show();
						}
					})
				});

				$(".commentUpdateButton").click(function() {
					$("#updateCommentContainer").removeClass("d-none");
					const id = $(this).attr("data-comment-id");
					$.ajax("/comment/id/" + id, {
						//수정폼에 기존 값 가져오기
						success: function(data) {
							$("#commentUpdateIdInput").val(data.id);
							$("#commentUpdateTextArea").val(data.content);

						}
					})
				});

			}
		})
	}

	
	// (최종) 수정 버튼 클릭시
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
				$("#commentUpdateTextArea").val("");
				$("#updateCommentContainer").addClass("d-none");
			}
		})
	})



//})

//댓글 등록 버튼 클릭시
$("#sendCommentBtn").click(function() {
	//const feedId = $("#feedId").text().trim();
	const content = $("#commentTextArea").val();
	const data = { feedId, content };
	console.log(data);
	$.ajax("/comment/add", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		complete: function(jqXHR) {
			listComment();
			console.log(feedId);
			//완료 시 메세지 토스트에 보이기
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
			// 댓글 등록 후 입력 창 비우기
			$("#commentTextArea").val("");
		}
	});
})
