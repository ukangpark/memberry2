main();

function main() {
	$('.slide_gallery').bxSlider({
		mode: 'horizontal',
		maxSlides: 4,
		minSlides: 1,
		moveSlides: 1,
		slideMargin: 1,
		slideWidth : 450,
		shrinkItems : true
	});
};