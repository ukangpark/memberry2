$("#liLink").click(function() {
	const id = $(this).attr("data-alarm-id");
	$.ajax("/alarm/check/" + id, {
		success: function() {
			$("#lilLnk").removeClass("active");
			listAlarm();
		}
	})
});





