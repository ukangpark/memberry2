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
<!-- bxslider -->
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
#memberyLogo {
	width: 600px;
	margin: 20px 0px 0px 0px;
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

/* slick slider */
/*post slider*/
.post-slider {
	width: 100%;
	margin: 0px auto;
	position: relative;
}

.post-slider .silder-title {
	text-align: left;
	margin: 30px auto;
}

.post-slider .next {
	position: fixed;
	top: 50%;
	right: 30px;
	font-size: 2em;
	color: gray;
	cursor: pointer;
}

.post-slider .prev {
	position: fixed;
	top: 50%;
	left: 30px;
	font-size: 2em;
	color: gray;
	cursor: pointer;
}

.post-slider .post-wrapper {
	width: 100%;
	height: 350px;
	margin: 0px auto;
	overflow: hidden;
	padding: 10px 0px 10px 0px;
}

.post-slider .post-wrapper .post {
	width: 300px;
	height: 300px;
	margin: 0px 10px;
	display: inline-block;
	background: white;
	border-radius: 5px;
}

.post-slider .post-wrapper .post .post-info {
	font-size: 15px;
	height: 30%;
	padding-left: 10px;
}

.post-slider .post-wrapper .post .slider-image {
	width: 100%;
	height: 175px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}
/* slick slider */

/* 
.ui.cards {
	flex-wrap: wrap;
}

#cards {
	margin: -150px 0px 0px 30px;
}

#cardSet {
	margin: 0px 20px;
}
 */

/* 슬라이더 
.slider img {
	display: block;
	width: 350px;
	margin: auto
}
*/
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
				<h2 class="silder-title"> 인기 펫시터를 만나보세요 </h2>
				<i class="fas fa-chevron-left prev"></i>
				<i class="fas fa-chevron-right next"></i>
				<div class="post-wrapper">
					<div class="post">
						<img src="/images/petplanet1.png" class="slider-image">
						<div class="post-info">
							<h4>
								<a href="#" class="post-subject">Lorem ipsu eiusmod tempor incididunt ut </a>
							</h4>
							<i class="far fa-user" style="height: 10%;">Awa Melvine</i>
						</div>
					</div>
					<div class="post">
						<img src="/images/petplanet1.png" class="slider-image">
						<div class="post-info">
							<h4>
								<a href="#"> Commodo odio aenean sed </a>
							</h4>
							<i class="far fa-user" style="height: 10%;">Awa Melvine</i>
						</div>
					</div>
					<div class="post">
						<img src="/images/petplanet1.png" class="slider-image">
						<div class="post-info">
							<h4>
								<a href="#">Quis hendrerit dolor magna eget est lorem ipsum dolor sit. </a>
							</h4>
							<i class="far fa-user" style="height: 10%;">Awa Melvine</i>
						</div>
					</div>
					<div class="post">
						<img src="/images/petplanet1.png" class="slider-image">
						<div class="post-info">
							<h4>
								<a href="#">Elit at imperdiet dui accumsan sit.</a>
							</h4>
							<i class="far fa-user" style="height: 10%;">Awa Melvine</i>
						</div>
					</div>
				</div>
			</div>
			<!--post slider-->
		</div>

		<script src="/js/main.js"></script>

		<my:bottom></my:bottom>
</body>
</html>