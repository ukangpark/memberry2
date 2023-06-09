<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberList</title>

<style>
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 17px;
}

.size {
	width: 250px;
	min-width: 150px;
	max-width: 150px;
}

#pagination {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
</head>
<body>

	<my:navBar></my:navBar>

	<div class="ui center aligned container" id="container">

		<div class="row justify-content-center">
			<div style="margin: 85px;">
				<h1>회원 목록</h1>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th class="size">아이디</th>
						<th class="size">이름</th>
						<th class="size">비밀번호</th>
						<th class="size">별명</th>
						<th class="size">이메일</th>
						<th class="size">연락처</th>
						<th class="size">가입일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${memberList }" var="member">
						<tr>
							<td><c:url value="/member/info" var="memberInfoLink">
									<c:param name="id" value="${member.id }"></c:param>
								</c:url> <a href="${memberInfoLink }"> ${member.id } </a></td>
							<td>${member.name }</td>
							<td>${member.password }</td>
							<td>${member.nickName }</td>
							<td>${member.email }</td>
							<td>${member.phoneNumber }</td>
							<td>${member.inserted }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>


	<!-- pagination -->
	<div class="container-lg" id="pagination">
		<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
			<c:url value="/member/list" var="pageLink">
				<c:param name="page" value="${pageNum }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }"> ${pageNum } </a>
			</div>
		</c:forEach>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>