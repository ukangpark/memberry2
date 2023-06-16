<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PetsitterMain</title>
<my:top></my:top>
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="/slick/slick-theme.css" />
<style>
#memberyLogo {
	width: 600px;
}

.searchBar {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}

#input-box {
	display: flex;
	width: 600px;
	padding: 6px 0px 6px 6px;
	border-radius: 5px;
	border: 2px solid #e2e2e2;
	height: 50px;
	text-align: center;
	font-size: 15px;
}

.input-box i {
	flex: 1;
}

.input-box input {
	flex: 7;
	border: none;
	outline: none;
}

#searchBtn {
	margin: 0px 6px;
}

#allButton {
	padding: 0px 6px;
}

.image {
	width: 353px;
	height: 200px;
	margin-bottom: 10px;
}

.imager {
	width: 100%;
	height: 100%;
}

/* slick slider */
/*post slider*/
.post-slider {
	width: 100%;
	margin: 0px auto;
	position: relative;
}

.post-slider .silder-title {
	text-align: left;
	margin: 30px 0px 5px 15px;
}

.post-slider .next {
	position: fixed;
	top: 70%;
	right: 100px;
	font-size: 2em;
	color: gray;
	cursor: pointer;
}

.post-slider .prev {
	position: fixed;
	top: 70%;
	left: 100px;
	font-size: 2em;
	color: gray;
	cursor: pointer;
}

.post-slider .post-wrapper {
	width: 100%;
	height: 500px;
	margin: 0px auto;
	overflow: hidden;
	padding: 10px 0px 10px 0px;
}

.post-slider .post-wrapper .ui link cards {
	width: 300px;
	height: 500px;
	margin: 0px 10px;
	display: inline-block;
	background: white;
	border-radius: 5px;
}

.post-slider .post-wrapper .ui link cards .post-info {
	font-size: 15px;
	height: 30%;
	padding-left: 10px;
}

.post-slider .post-wrapper .ui link cards .slider-image {
	width: 100%;
	height: 175px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

/* slick slider */
.ui.cards {
	flex-wrap: wrap;
}
  
.card {
	margin: 10px;
	height: 350px;
}

</style>
</head>
<body>

	<my:navBar current="main" />
	<my:alert></my:alert>

	<div class="ui center aligned container" id="container">

		<img id="memberyLogo" src="/images/petsitterLogo.png" alt="Membery logo">

		<div class="searchBar">
			<form action="list" class="d-flex" role="search">
				<input value="${param.search }" name="search" class="form-control me-2" type="search" placeholder="맡기고 싶은 지역을 검색해보세요" aria-label="Search" id="input-box">
				<button id="searchBtn" class="ui black button" type="submit" style="width: 50px; text-align: center;">
					<i class="fa-solid i1 fa-magnifying-glass"></i>
				</button>
				<!-- 전체보기 버튼 -->
				<button id="allButton" class="ui right labeled icon button" onclick="location.href='/petsitter/list'" style="width: 140px;">
					<i class="right arrow icon"></i> 전체보기
				</button>
			</form>
		</div>

		<div class="page-wrapper" style="position: relative;">
			<!--page slider -->
			<div class="post-slider">
				<div class="silder-title" style="font-size: 18px; font-weight: bold;"><i class="thumbs up outline icon"></i> 인기 펫시터를 만나보세요</div>
				<i class="fas fa-chevron-left prev"></i> <i class="fas fa-chevron-right next"></i>
				<div class="post-wrapper">
					<div class="slick-wrapper ui link cards" id="cards">
						<c:forEach items="${petsitterList }" var="host" end="9">
							<div class="card">
								<div class="image">
									<img class="imager" src="${bucketUrl }/${membery }cover/${host.detailId}/${host.cover}" alt="" />
								</div>
								<div class="content">
									<div class="header">${host.title }</div>
									<div class="meta">
										<a href="/petsitter/detail?id=${host.id }">${host.si } ${host.gu } ${host.dong }</a>
									</div>
									<div class="description">${host.houseType },${host.pet },${host.species }</div>
								</div>
								<div class="extra content">
									<span class="right floated"> 하루 40,000원~ </span> 
									<span> <i class="comments icon"></i> 후기 ${host.commentCount }개
										<form class="right floated inblock" action="/petsitter/detail" id="idForm">
											<input class="d-none" type="text" name="id" value="${host.id }"> <input class="ui secondary button" type="submit" value="상세보기">
										</form>
									</span>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!--post slider-->
		</div>
	</div>
	
	
	<my:bottom></my:bottom>
	<script type="text/javascript" src="/slick/slick.min.js"></script>
	<script src="/js/main.js"></script>
</body>
</html>