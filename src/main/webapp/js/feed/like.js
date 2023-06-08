const toast = new bootstrap.Toast(document.querySelector("#liveToast"));

$("#likeIcon").click(function() {
	// 게시물 번호 request body에 추가
	const feedId = $("#feedIdText").text().trim();
	const data = {feedId};
	
	$.ajax("/like", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		
		success: function(data) {
			if (data.like) {
				$("#likeIcon").html(`<img src="/images/bone.png">`);
			} else {
				$("#likeIcon").html(`<img src="/images/olbone.png">`);
			}
		},
		error: function(jqXHR) {
			$(".toast-body").text(jqXHR.responseJSON.message);
			toast.show();
		},
	});
});