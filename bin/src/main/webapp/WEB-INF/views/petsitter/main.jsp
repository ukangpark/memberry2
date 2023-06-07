<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mainPage</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">

<style>
#img {
	margin: 0px 0px 0px 0px;
}

#cards {
	margin: 0px 0px 0px 90px;
}

#button{
	position:relative;
	text-align: right;
	margin: 0px 130px 20px 0px;
}
</style>

</head>
<body>

	<my:navBar current="main" />
	<my:alert></my:alert>

	<div class="ui center aligned container" id="container">

		<img src="/img/MemberyLogo.png" alt="" id="img" />
		
		<div id="button">
		<button class="ui right labeled icon button" onclick="location.href='/petsitter/list'">
			<i class="right arrow icon"></i> 전체보기
		</button>
		</div>

		<div class="ui link cards" id="cards">
			<div class="ui cards" items="${host }" var="host">
				<c:forEach items="${host }" var="host" end="2">
					<div class="ui card inblock">
						<div class="ui slide masked reveal image">
							<a href="/petsitter/detail"><img src="/img/petplanet1.png" class="visible content"> </a>
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
							<a class="inblock"> <i class="comment icon"></i> 댓글 개수 표시
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

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>
</body>
</html>