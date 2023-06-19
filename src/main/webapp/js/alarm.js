listAlarm();

function listAlarm() {
	const memberId = $("#memberId").text().trim();
	$.ajax("/alarm/list?id=" + memberId, {
		method: "get",
		success: function(alarms) {
			$("#alarmListContainer").empty();
			for(const alarm of alarms) {
				$("#alarmListContainer").append(
				
				($(alarm.notiType == 'comment') 
				?
				 `<a href="/feedId/${alarm.feedId}" id="lilLnk" class="list-group-item d-flex justify-content-between align-items-start" 
				data-alarm-id="${alarm.id}" >
				<div class="d-flex w-100 justify-content-between">
					<i class="fa-solid fa-comments"></i>
					<div id="aLi" style="font-weight: bold"> ${alarm.nickName}님이 회원님의 피드에 댓글을 달았습니다  :  ${alarm.content} </div>
					<small class="text-body-secondary">${alarm.inserted}</small>
				</div>
				 <span id="alarmBg" class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
				</a>`
				 :
				  `<a href="/feedId/${alarm.feedId}"  id="lilLnk"  class="list-group-item justify-content-between align-items-start" 
					data-alarm-id="${alarm.id}">
				<div class="d-flex w-100 justify-content-between">
					<i class="fa-solid fa-bone"></i>
					<div id="aLi" style="font-weight: bold">${alarm.nickName}님이 회원님의 피드를 좋아합니다. </div>
					<small class="text-body-secondary">${alarm.inserted}</small>
				</div>
				<span id="alarmBg" class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">

				</a>`
				)
				);
			$("#lilLnk").click(function(){
				const id = $(this).attr("data-alarm-id");
				$.ajax("/alarm/check/" + id, {
					success: function() {
						console.log("알람 확인");
					}
				})
			});
			( $(alarm.isChecked) ? $("#alarmBg").addClass("d-none") : '');
			}
		}
	});
}




