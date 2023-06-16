$("#followBtn").click(function() {
	// 게시물 번호 request body에 추가
	const feedId = $("#data-feed-id").val();
	console.log(feedId);
	const data = { feedId };
	$.ajax("/follow", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data)

		/*success : function(data) {
			if (data.like) {
				//꽉찬 하트
				$("#likeIcon").html(`<i class="fa-solid fa-heart"></i>`);
				
			} else {
				//빈 하트
				$("#likeIcon").html(`<i class="fa-regular fa-heart"></i>`);
			}
			$("#likeNumber").text(data.count);
		}*/

	})
})