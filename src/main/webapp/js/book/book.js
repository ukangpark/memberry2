$("#acceptBtn").click(function(){
	const num = $("#num").val();
	
	$.ajax("/book/accept", {
		method:"post",
		contentType: "application/json",
		data: JSON.stringify(num),
		success: function(){
			location.reload();
		}
	})
})