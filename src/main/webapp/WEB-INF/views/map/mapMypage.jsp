<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mapMypage</title>

<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<d:top />
</head>
<body>
<d:navBar current="mapMypage" />



<div class="container-lg">
	
	   
	   
		<h2 style="margin-top: 20px; margin-bottom: 0px; text-align:center;">
		<i class="fa fa-solid fa-paw"></i>
		찜 목록
		<i class="fa fa-solid fa-paw"></i>
		</h2>
		
		<table class="table" style="margin-top:50px;">
			<thead>
				<tr>
					<th>가게명 </th>
					<th>주소</th>
					<th>번호</th>
					<th>찜 취소</th>
					
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mapList }" var="map">
					<tr>
						<input type="hidden" id="id" value="${map.id }" />
						<td>
						<a href="${map.url }">
						${map.name }
						</a>
						</td>
						<td>${map.address }</td>
						<td>${map.phone }</td>
						<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
						취소하기
						</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 페이지네이션 -->
	<div class="container-lg">
		<div class="row">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">

					<!-- 이전 버튼 -->
					<c:if test="${pageInfo.currentPageNum ne 1 }">
						<c:url value="mapMypage" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">이전</a></li>
					</c:if>
					
					<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
						<c:url value="mapMypage" var="pageLink">
							<c:param name="page" value="${pageNum}" />
						</c:url>
						<li class="page-item"><a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }">${pageNum}</a></li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
						<c:url value="mapMypage" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${pageLink }">다음</a>
						</li>
						</c:if>
						
				</ul>
			</nav>
		</div>
	</div>
	
	
	
	
	

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">찜 취소</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       확인 버튼을 누르면 해당 장소의 찜하기가 취소 됩니다.
       <br /> 찜 취소 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger">확인</button>
      </div>
    </div>
  </div>
</div>
	
	
	
	
	<div id="map" style="width:100%;height:600px;"></div>


	<d:bottom></d:bottom>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey }&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 마커 이미지
var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png'; // 마커이미지의 주소입니다
var imageSize = new kakao.maps.Size(20, 30); // 마커이미지의 크기입니다
//var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
//var markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

// 찜 장소 주소가져옴
var placeList = '${mapList}';
var addressRegex = /address=([^,]+)/g;  // 정규식 패턴
var addressMatch = placeList.match(addressRegex);
var addresses = addressMatch.map(function(address) {
  return address.replace('address=', '');
});
// 찜 장소 이름 가져옴
var nameRegex = /name=([^,]+)/g;  // 정규식 패턴
var nameMatch = placeList.match(nameRegex);
var names = nameMatch.map(function(name) {
  return name.replace('name=', '');
});

for (var i = 0; i < addresses.length; i++){
	var placeAddress = addresses[i];
	var placeName = names[i];
	
	processPlace(placeAddress,placeName);
}

function processPlace(placeAddress,placeName){
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(placeAddress, function(result, status) {
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image: markerImage
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+placeName+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	        
	    } 
	}); 
}

</script>
</body>
</html>