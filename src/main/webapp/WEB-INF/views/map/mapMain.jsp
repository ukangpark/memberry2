<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title> 함께 가개</title>


<d:top></d:top>

<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey }&libraries=services"></script>
<link rel = "stylesheet" href="/css/mapMain.css" />

<style>
#header {
	display: flex;
	justify-content: center;
	
} 


#함께가개Logo {
	width: 350px;
}
</style>



</head>
<body>
	
	<d:navBar current="mapMain" />
	
	<h1 style="margin-bottom:30px;">
	<div id="header">
		<img id="함께가개Logo" src="/images/함께가개Logo.png" alt="함께가개 logo">
	</div> 
	
	</h1>
	
	
	<!-- <button style= "float : right"  class="ui basic button" onclick="location.href='/map/mapMypage'">
  <i class="icon star"></i>
	  즐겨찾기
	</button> -->

	<div id="container">
		<div id="navbar" class="ui compact vertical labeled icon menu">
			<a class="item" id="restaurant" onclick="searchRest('restaurant','서울 애견동반식당')">
				<i class="utensils icon"></i>
				식당 
			</a>
			<a class="item" id="cafe" onclick="searchRest('cafe','서울 애견카페')">
				<i class="coffee icon"></i>
				카페 
			</a>
			<a class="item" id="hospital" onclick="searchRest('hospital','서울 동물병원')">
				<i class="hospital icon"></i>
				병원 
			</a>
			<a class="item" id="hotel" onclick="searchRest('hotel','서울 애견동반호텔')">
				<i class="building icon" ></i>
				호텔
			</a>
			<a class="item" id="camping" onclick="searchRest('camping','애견캠핑장')">
				<i class="paw icon" ></i>
				캠핑장
			</a>
			<a class="item" id="like" onclick="location.href='/map/mapMypage'">
				<i class="heart icon"></i>
				찜 목록
			</a>
		</div>
		
		
		<div class="map_wrap">
		<div id="map"></div>
     <%-- <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div> --%>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="서울 애견동반식당" id="keyword" size="15"> 
                    <button type="button" class="btn btn-primary btn-sm">검색하기</button>
                   <!--  <button type="submit">검색하기</button>  -->
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
	<div>
	
	
	<script>
/* 	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 */

//마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
    markers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
contentNode.className = 'placeinfo_wrap';
//커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
//지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
//엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
function addEventHandle(target, type, callback) {
    if (target.addEventListener) {
        target.addEventListener(type, callback);
    } else {
        target.attachEvent('on' + type, callback);
    }
}
    // 커스텀 오버레이 컨텐츠를 설정합니다
placeOverlay.setContent(contentNode); 

    //마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

var map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
    
 	// 커스텀 오버레이를 숨깁니다 
    placeOverlay.setMap(null);

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        //displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        /* (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name); */
        
     	// 마커와 검색결과 항목을 클릭 했을 때
        // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
        (function(marker, place) {
            kakao.maps.event.addListener(marker, 'click', function() {
                displayPlaceInfo(place);
            });
        })(marker, places[i]);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

//클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
function displayPlaceInfo (place) {
    var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

    if (place.road_address_name) {
        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
    }  else {
        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
    }                
   
    content += '    <span class="tel">' + place.phone + '</span>' + 
                '</div>' + 
                '<div class="after"></div>';

    contentNode.innerHTML = content;
    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
    placeOverlay.setMap(map);  
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5 id="placeName_'+(index+1)+'">' + places.place_name + 
                '</h5>' + 
                '<input type="hidden" id="placeUrl" value="' + places.place_url + '" />';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray" id="placeAddress_'+(index+1)+'">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span id="placeAddress_'+(index+1)+'">' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel" id="placePhone_'+(index+1)+'">' + places.phone  + '</span>' +
      '<input type="button"  class="btn btn-outline-danger"  value="찜하기♥" onclick="javascript:addPlace('+(index+1)+')"/>' + 
      			
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}



// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}


// 사이드바 버튼 누를때 리스트 뜨게 함수 설정 
function searchRest(menuId, param){
	
	placeOverlay.setMap(null);
	
	// 장소검색 객체를 통해 키워드로 장소검색을 요청
    ps.keywordSearch( param, placesSearchCB); 
    document.getElementById('keyword').value = param;
        
    var divElement = document.getElementById("navbar");
    var anchorTags = divElement.querySelectorAll("a");

    for (var i = 0; i < anchorTags.length; i++) {
      anchorTags[i].style.backgroundColor = "";
    }
    document.getElementById(menuId).style.backgroundColor = "lightgray";
}

function addPlace(num){
	var placeName = document.getElementById("placeName_"+num).innerHTML;
	var placeAddress = document.getElementById("placeAddress_"+num).innerHTML;
	var placePhone = document.getElementById("placePhone_"+num).innerHTML;
	var placeUrl = $("#placeUrl").val();
	
	$.ajax("/map/addPlace", {
		method:"post",
		contentType: "application/json",
		data: JSON.stringify({
			"name" : placeName,
			"address" : placeAddress,
			"phone" : placePhone,
			"url" : placeUrl
		}),
		success: function(data){
			alert(data);
		}
	})
}
	</script>
	

<d:bottom />
	<script src="js/semantic/semantic.min.js"></script>

</body>
</html>