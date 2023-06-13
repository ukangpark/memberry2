$("#petCheckbox").click(function() {
	const petId = $("#petId").val();
	const thumbnailSrc = $("#imageByPet").attr("src");
	//console.log(thumbnailSrc);

	console.log($(this).find("input[type=checkbox]")[0].checked);
	const checked = $(this).find("input[type=checkbox]")[0].checked;
	const data = { checked : checked };

	$.ajax("/thumbnail" + "/" + petId, {
		type: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function(data) {
			if (checked) {
				document.getElementById('nav-image').setAttribute("src", thumbnailSrc);
			} else {
				document.getElementById('nav-image').setAttribute("src", "/images/paw.png");
			}
		}
	})
})