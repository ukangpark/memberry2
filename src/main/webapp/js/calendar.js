
getCalendar();

//Calendar DB데이터를 요청하는 함수
function getCalendar() {
	
	$.ajax("/fullCalendar/list", {
		method: "get",
		//contentType: "application/json",
		//dataType : "json",
		//async: false, 
		success: function(schedules) {
			$(".scheduleInfo").empty();
			for(const schedule of schedules) {
				$(".scheduleInfo").append(`
					<li>${schedule.title}</li>
				`);
			}
		}
		//,
		//error: function(){
	 		//alert("에러");
 		//}	
 	});
 //return arr;
}