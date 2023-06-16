/*
main();
function main() {
	$('.page-wrapper').slick({
			slidesToShow: 3,
			slidesToScroll: 1,
			autoplay: true,
			autoplaySpeed: 2000,
			nextArrow: $('.next'),
			prevArrow: $('.prev'),
	});
};
*/

$(document).ready(function() {
	$('.slick-wrapper').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 1000,
		nextArrow: $('.next'),
		prevArrow: $('.prev'),
	});
});

