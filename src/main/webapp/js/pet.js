$("#petCheckbox").click(function() {
	const petId = $("#petId").val();
	const data = { petId: petId };
	const thumbnailSrc = $("#imageByPet").attr("src");
	//console.log(thumbnailSrc);
	$.ajax("/thumbnail", {
		type: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function() {
			document.getElementById('nav-image').setAttribute("src", thumbnailSrc);
		}
	})
})