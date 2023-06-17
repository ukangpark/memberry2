$("#followBtn").click(function() {
	const followBtn = $(this);
	const feedId = $("#feedId").val();
	const memberId = $("#memberId").val();
	const data = { feedId: feedId, memberId: memberId };
	$.ajax("/follow", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function(data) {

			if (data.follow) {
				console.log(data.follow);
				document.getElementById("followBtn").className = "ui blue basic button";
				followBtn.html(`<h3><i class="fa-solid fa-user-check"></i> 팔로잉</h3>`);
			}
		}

	})
})