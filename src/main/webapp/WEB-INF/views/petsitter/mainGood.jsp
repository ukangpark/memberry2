<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mainPage</title>

<my:top></my:top>

<style>

#img {
	width: 600px;
	margin: 50px 0px 0px 0px;
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

		<img src="/images/memberyLogo.png"  alt="" id="img" />
		
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
							<a class="inblock"> <span> <i class="comments icon"></i> 후기 ${host.commentCount }개 </span>
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

	<my:bottom></my:bottom>

</body>
</html>