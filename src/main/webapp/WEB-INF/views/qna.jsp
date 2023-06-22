<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnAList</title>
<my:top />
<style>
#img {
	width: 600px;
}

.searchBar {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	margin-top: 20px;
	margin-bottom: 30px;
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
	margin-left: 15px;
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
	margin: 0px 10px;
}

#plusButton {
	height: 47px;
}

table {
	min-width: 800px;
}

tr, th {
	text-align: center;
}

#pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 10px auto;
}
</style>

</head>
<body>

	<my:navBar current="qna"></my:navBar>
	<my:alert></my:alert>
	<div class="ui aligned container-lg">
		<a href="/qna"><img class="ui centered medium circular image" src="/images/QnALogo.png" id="img"></a>


		<div class="searchBar">
				<button id="plusButton" class="ui right labeled icon button" onclick="location.href='/qna/add'" style="width: 180px;">
					<i class="right arrow icon"></i> 문의글 작성 OR
				</button>
			<form action="qna" class="d-flex" role="search">
				<input value="${param.search }" name="search" class="form-control me-2" type="search" placeholder="작성하기 전에 다른 이용자의 질문을 확인해보세요" aria-label="Search" id="input-box">
				<button id="searchBtn" class="ui button" type="submit" style="width: 55px; text-align: center;">
					<i class="fa-solid i1 fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
		
		<div class="tableSet">
			<table class="ui single line table" style="width: 1300px;">
				<colgroup>
					<col width="5%" />
					<col width="55%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>no.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성시간</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach items="${qnaList}" var="qna">
						<tr>
							<td>${qna.id }</td>
							<td><a href="/qna/id/${qna.id }">${qna.title }</a></td>
							<td>${qna.writer }</td>
							<td>${qna.inserted }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	</div>

	<!-- pagination -->
	<div class="container-lg" id="pagination">

		<!-- 이전 버튼 -->
		<c:if test="${pageInfo.currentPageNum ne 1 }">
			<c:url value="/qna" var="pageLink">
				<c:param name="page" value="${pageInfo.currentPageNum - 1 }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item" href="${pageLink }"> prev </a>
			</div>
		</c:if>

		<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
			<c:url value="/qna" var="pageLink">
				<c:param name="page" value="${pageNum }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }"> ${pageNum } </a>
			</div>
		</c:forEach>

		<!-- 다음 버튼 -->
		<c:if test="${pageInfo.currentPageNum ne pageInfo.lastPageNum }">
			<c:url value="/qna" var="pageLink">
				<c:param name="page" value="${pageInfo.currentPageNum + 1 }" />
			</c:url>
			<div class="ui pagination menu">
				<a class="item" href="${pageLink }"> next </a>
			</div>
		</c:if>
	</div>

	<my:bottom />
</body>
</html>