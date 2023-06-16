listComment();

function listComment() {
	const detailId = $("#detailIdText").text().trim();
	console.log(detailId); //check
	$.ajax("/petsitterComment/list?detailId=" + detailId, {
		method: "get",
		success: function(petsitterComments) {
			console.log(petsitterComments); //check
			$("#commentListContainer").empty();
			for (const petsitterComment of petsitterComments) {
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
						<a class="reply">Reply</a>
					</div>
				</div>
				<br>
				`)
			}

		}

	});
};

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
	});
}) 