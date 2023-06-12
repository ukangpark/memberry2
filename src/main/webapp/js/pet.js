$("#petCheckbox").click(function() {
	const petId = $("#petId").val();
	const petPhoto = $("#petPhoto").val();
	const data = { petId: petId };
	//const thumbnailSrc = $("#imageByPet").attr("src");
	//console.log(thumbnailSrc);
	$.ajax("/thumbnail" + "/" + petId + "/" + petPhoto, {
		type: "post",
		contentType: "application/json",
		data: JSON.stringify(data)

		//success: function(data) {
			//document.getElementById('nav-image').setAttribute("src", thumbnailSrc);
		//}
	})
})