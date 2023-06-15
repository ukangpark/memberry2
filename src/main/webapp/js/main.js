main();

function main() {
	$('.slide_gallery').bxSlider({
		mode: 'horizontal',
		maxSlides: 2,
		minSlides: 1,
		moveSlides: 1,
		slideMargin: 1,
		slideWidth : 450,
		shrinkItems : true
	});
};