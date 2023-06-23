document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {

		// Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
		headerToolbar: {

			left: 'prevYear,prev, today',
			center: 'title',
			right: 'next, nextYear'

		},

		 initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정

        fixedWeekCount: false,

        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
           console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title = prompt('일정추가:');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay

            })
          }
          calendar.unselect()
        },
		events: {
			id: '123',
			title: '이벤1',
			start: '2023-06-13',
			end: '2023-06-14'
			
			
		}
	});
calendar.render();
getCalendar();
//calendar.getEvents();
	//var arr = getCalendar();
	//$.each(arr, function(index, item) {
		//calendar.addEvent(item);
		//console.log(item);
	//});
	//calendar.render();
//});
//Calendar DB데이터를 요청하는 함수
function getCalendar() {
	
	$.ajax("/fullCalendar/list", {
		//var arr = [{title: '펫시터 예약', start: '2023-06-25', end:'2023-06-27'}, {title: '미용맡기기', start: '2023-06-30', end: '2023-06-30'}, {title: '산책번개', start: '2023-06-02', end:'2023-06-02'}];

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
//$("#btnAddTest").click(function(){
 //var arr = getCalendarDataInDB();
 //$.each(arr, function(index, item){
  //calendar.addEvent( item );
 //});
 //calendar.render();
});

