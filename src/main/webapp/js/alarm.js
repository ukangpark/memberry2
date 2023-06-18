listAlarm();

function listAlarm() {
	const memberId = $("#memberId").text().trim();
	$.ajax("/alarm/list?id=" + memberId, {
		method: "get",
		success: function(alarms) {
			$("#alarmListContainer").empty();
			for(const alarm of alarms) {
				$("#alarmListContainer").append(`
		
				<c:if test="${alarm.notiType == 'comment'}">
				<a href="/feedId/${alarm.feedId}" class="list-group-item d-flex justify-content-between align-items-start" 
				data-alarm-id="${alarm.id}" >
				<div class="d-flex w-100 justify-content-between">
					<i class="fa-solid fa-comments"></i>
					<div style="font-weight: bold">${alarm.nickName}님이 회원님의 피드에 댓글을 달았습니다  :  ${alarm.content} </div>
					<small class="text-body-secondary">${alarm.inserted}</small>
				</div>
				</a></c:if>
				
				
				<c:if test="${alarm.notiType == 'like'}">
				<a href="/feedId/${alarm.feedId}" class="list-group-item justify-content-between align-items-start" 
					data-alarm-id="${alarm.id}">
				<div class="d-flex w-100 justify-content-between">
					<i class="fa-solid fa-bone"></i>
					<div style="font-weight: bold">${alarm.nickName}님이 회원님의 피드를 좋아합니다. </div>
					<small class="text-body-secondary">${alarm.inserted}</small>
				</div>
				</a></c:if>
				
				`);
			}
		}
	});
	$(".list-group-item").click(function(){
		const id = $(this).attr("data-alarm-id");
		$.ajax("/alarm/check/" + id, {
			success: function() {
				listAlarm();
			}
		})
	})
}




