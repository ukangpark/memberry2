<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bx slider</title>
<my:top></my:top>
<!-- bxslider -->
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
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
	padding: 6px;
	border-radius: 5px;
	border: 2px solid #e2e2e2;
	height: 50px;
}

.input-box i {
	flex: 1;
}

.input-box input {
	flex: 7;
	border: none;
	outline: none;
}

#button {
	position: relative;
	text-align: right;
	margin: 0px 0px 20px 0px;
}

/* 
button {
	margin-bottom: 15px;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
 */
.ui.cards {
	flex-wrap: wrap;
}

#cards {
	margin: -150px 0px 0px 30px;
}

#cardSet {
	margin: 0px 20px;
}

/* 슬라이더 */
.slider {
	position: relative;
	top: 200px;
}

.slider img {
	display: block;
	width: 350px;
	margin: auto
}

.bx-wrapper {
	position: relative;
}

.bx-controls-direction {
	font-size: 30px;
}

.bx-controls-direction a {
	position: absolute;
	display: block;
	width: 100px;
	height: 150px;
	overflow: hidden;
	transform: translateY(10%);
	color: #5a5a5a;
	font-weight: normal;
}

.bx-controls-direction .bx-prev {
	left: 0;
}

.bx-controls-direction .bx-next {
	right: 0;
}

.bx-controls-direction .bx-prev:before {
	content: "\e93d";
	font-family: 'xeicon';
}

.bx-controls-direction .bx-next:before {
	content: "\e940";
	font-family: 'xeicon';
}

.bx-pager {
	position: absolute;
	left: 0;
	bottom: -37px;
	width: 100%;
	text-align: center;
}

.bx-pager div {
	display: inline-block;
	padding: 0 5px;
}

.bx-pager div a {
	display: block;
	color: transparent;
	width: 24px;
	height: 3px;
	background: #999;
	font-size: 0;
}

.bx-pager div a.active {
	background: #000;
}
</style>
</head>
<body>

	<my:navBar current="main" />
	<my:alert></my:alert>

	<div class="ui center aligned container" id="container">

		<img id="memberyLogo" src="/images/petsitterRealLogo.png" alt="Membery logo">

		<div class="searchBar">
			<form action="list" class="d-flex" role="search">
				<input value="${param.search }" name="search" class="form-control me-2" type="search" 
				placeholder="맡기고 싶은 지역을 검색해보세요" aria-label="Search" id="input-box">
				<button class="ui black button" type="submit" style="width: 80px">
					<i class="fa-solid i1 fa-magnifying-glass"></i>
				</button>
				<!-- 전체보기 버튼 -->
				<button class="ui right labeled icon button" onclick="location.href='/petsitter/list'"
						style="width: 200px;">
					<i class="right arrow icon"></i> 전체보기
				</button>
		</div>

		<div class="slider">
			<div class="ui link cards" id="cards">
				<div class="ui cards" items="${host }" var="host" id="card">
					<c:forEach items="${host }" var="host">
						<div class="ui card inblock" id="cardSet">
							<div class="ui slide masked reveal image">
								<a href="/petsitter/detail"><img src="/images/petplanet1.png" class="visible content"> </a>
							</div>
							<div class="content">
								<a class="header">${host.hostName }</a>
								<div class="meta">
									<span class="date">${host.si }시 ${host.gu }구 ${host.dong }동</span>
								</div>
								<div class="description">경력 : ${host.experience }</div>
								<div class="description">반려견 : ${host.pet }</div>

							</div>
							<div class="extra content">
								<a class="inblock"> <span> <i class="comments icon"></i> 후기 ${host.commentCount }개
								</span>
								</a>
								<form class="right floated inblock" action="/petsitter/detail" id="idForm">
									<input class="d-none" type="text" name="id" value="${host.id }"> <input class="ui secondary button" type="submit" value="상세보기">
								</form>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<script src="/js/main.js"></script>

	<my:bottom></my:bottom>
</body>
</html>