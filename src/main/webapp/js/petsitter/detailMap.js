
// 호스트 주소 가져옴 -> 변수에 담아줌 
var si = $("#mapSi").text().trim();
var gu = $("#mapGu").text().trim();
var dong = $("#mapDong").text().trim();
var address = si + " " + gu + " " + dong;

console.log(address);

// 주소-좌표간 변환 서비스 객체 생성
var geocoder = new kakao.maps.services.Geocoder();

// 위도와 경도의 변수 선언 (기본값은 지도의 중심 좌표)
var lat = 37.58172878042;
var lng = 126.96920900565;

var callback = function(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		lat = result[0].y;
		lng = result[0].x;
		console.log("라인21 : " + lat + ", " + lng);

		// 좌표를 사용하여 지도 및 원을 생성하는 작업을 수행한다
		createMapWithCircle(lat, lng);
	}
};

geocoder.addressSearch(address, callback); // 주소 정보에 해당하는 좌표값을 요청함 

function createMapWithCircle(lat, lng) {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level: 3, // 지도의 확대 레벨
			mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
		};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
	map.setZoomable(false);

	// 커스텀 오버레이를 생성하고 지도에 표시한다
	var customOverlay = new kakao.maps.CustomOverlay({
		map: map,
		content: '<div style="padding:0 5px;background:#fff;">호스트 위치</div>',
		position: new kakao.maps.LatLng(lat, lng), // 커스텀 오버레이를 표시할 좌표
		xAnchor: 4.6, // 컨텐츠의 x 위치
		yAnchor: 7.7 // 컨텐츠의 y 위치
	});

	// 지도에 원을 표시한다
	var circle = new kakao.maps.Circle({
		map: map, // 원을 표시할 지도 객체
		center: new kakao.maps.LatLng(lat, lng), // 지도의 중심 좌표
		radius: 130, // 원의 반지름 (단위: m)
		fillColor: '#00a0e9', // 채움 색
		fillOpacity: 0.5, // 채움 불투명도
		strokeWeight: 2, // 선의 두께
		strokeColor: '#00a0e9', // 선 색
		strokeOpacity: 1, // 선 투명도 
		strokeStyle: 'solid' // 선 스타일
	});
}
