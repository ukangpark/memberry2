$("#followBtn").click(function() {
	const followBtn = $(this);
	const feedOwner = $("#userName").val();
	const memberId = $("#auth").val();
	const data = {
		feedOwner: feedOwner,
		memberId: memberId
	};
	$.ajax("/follow/" + feedOwner, {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function(data) {

			if (data.follow) {
				document.getElementById("followBtn").className = "ui blue basic button";
				followBtn.html(`<h3><i class="fa-solid fa-user-check"></i> 팔로잉</h3>`);
				followerIncrease();
				//followingIncrease();
			} else {
				//console.log(data.follow);
				document.getElementById("followBtn").className = "ui basic button";
				followBtn.html(`<h3><i class="fa-solid fa-user"></i> 팔로우</h3>`);
				followerDecrease();
				//followingDecrease();
			}

			//팔로우 수 업데이트(증가)
			function followerIncrease() {
				var count = parseInt($(".followerCount").text().trim());
				//console.log(count);
				count = count + 1;
				//console.log(count);
				$(".followerCount").text(count);
			}

			//팔로우 수 업데이트(감소)
			function followerDecrease() {
				var count = parseInt($(".followerCount").text().trim());
				//console.log(count);
				count = count - 1;
				//console.log(count);
				$(".followerCount").text(count);
			}

		}

	})
})

//팔로워 모달
//console.log(data);
$("#followerBtn").click(function() {
	const feedOwner = $("#userName").val();
	console.log(feedOwner);
	followList();
	function followList() {
		$.ajax("/follower/list/" + feedOwner, {
			success: function(follower) {
				console.log(follower);
				$("#followerListContainer").empty();
				for (const followers of follower) {
					$("#followerListContainer").append(`
						<div class="item">
							<a href="/feed/myFeed/${followers.memberId}">	
								<img class="ui middle aligned tiny inline image" style="width:50px; height:50px" src=${followers.profileImage != null ? "https://lilysbucket0503.s3.ap-northeast-2.amazonaws.com/membery/pet" + followers.profileImage : "/images/paw.png"}>
								<span style="font-size: 12pt; font-weight: bold; color: black;"> ${followers.memberId}</span>
							</a>
						</div>
					`);
				}
			}
		})
	}
})