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

table {
	min-width: 800px;
}

tr, th {
	text-align: center;
}
</style>

</head>
<body>

	<my:navBar current="qna"></my:navBar>
	<my:alert></my:alert>
	<div class="ui aligned container-lg">
		<img class="ui centered medium circular image" src="/images/QnALogo.png" id="img">
		<button class="ui basic button">
			<a href="/qna/add">QnA 작성</a>
		</button>
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
	<my:bottom />
</body>
</html>