<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberList</title>
<my:top></my:top>

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

<my:top></my:top>

</head>
<body>

	<my:navBar></my:navBar>

	<div class="ui center aligned container" id="container">

		<div class="row justify-content-center">
			<div style="margin: 30px;">
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

		<!-- 이전 버튼 -->
		<c:if test="${pageInfo.currentPageNum ne 1 }">
			<c:url value="/member/list" var="pageLink">
				<c:param name="page" value="${pageInfo.currentPageNum - 1 }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item" href="${pageLink }"> prev </a>
			</div>
		</c:if>

		<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
			<c:url value="/member/list" var="pageLink">
				<c:param name="page" value="${pageNum }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }"> ${pageNum } </a>
			</div>
		</c:forEach>

		<!-- 다음 버튼 -->
		<c:if test="${pageInfo.currentPageNum ne pageInfo.lastPageNum }">
			<c:url value="/member/list" var="pageLink">
				<c:param name="page" value="${pageInfo.currentPageNum + 1 }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item" href="${pageLink }"> next </a>
			</div>
		</c:if>
	</div>

	<my:bottom></my:bottom>

</body>
</html>