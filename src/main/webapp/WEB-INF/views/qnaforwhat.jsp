<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<style>
.qna {
	width: 350px;
	margin-left: 150px;
}

.no {
	margin: 0px 0px 20px 0px;
}

.item{
	border-style: solid;
	border-color: #e8e8e8;
	border-radius: 7px;
	margin: 10px 0px 10px 0px;
}

</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnAForWhat</title>
<my:top />
</head>
<body>
	<my:navBar current="qnaForWhat"></my:navBar>
	<my:alert></my:alert>

	<!-- toast -->
	<div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
		<div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body"></div>
				<button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
				<a href="/qna"><img class="qna" src="/images/qnaDetailLogo.png" alt="" /></a>
				<div class="d-flex">
					<div class="no">
						<h1>
							<span id="qnaWriter">${qna.writer }</span> 님의 질문 <span class="" id="qnaIdText" style="visibility: hidden;">${qna.id }</span>
						</h1>
					</div>
				</div>
				<div class="mb-3">
					<label for="" class="form-label">제목</label> <input type="text" class="form-control" value="${qna.title }" readonly />
				</div>
				<div class="mb-3">
					<label for="" class="form-label">본문</label>
					<textarea class="form-control" readonly rows="10">${qna.body }</textarea>
				</div>
				<div class="mb-3">
					<label for="" class="form-label">작성자</label> <input type="text" class="form-control" value="${qna.writer }" readonly />
				</div>
				<div class="mb-3">
					<label for="" class="form-label">작성일시</label> <input type="text" readonly class="form-control" value="${qna.inserted }" />
				</div>
				<sec:authorize access="hasAuthority('admin') or (isAuthenticated() and (authentication.name eq #qna.writer))">
					<div style="margin-bottom: 10px">
						<div class="ui toggle right floated large button" style="background-color: #cc6666" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제하기</div>
						<div class="ui toggle right floated large button" style="background-color: #6699cc" onclick="location.href='/qna/modify/${qna.id }'">수정하기</div>
						<div class="ui right floated large button" style="background-color: #cccccc" onclick="location.href='/qna'">목록보기</div>
					</div>
				</sec:authorize>

				<div id="commentContainer">
					<sec:authorize access="hasAuthority('admin')">
						<div id="addQnACommentContainer">

							<div class="input-group">
								<div class="form-floating">
									<textarea style="height: 50px;" placeholder="관리자의 답변" class="form-control" id="qnaCommentTextArea"></textarea>
									<label for="floatingTextarea">관리자의 답변</label>
								</div>
								<button class="btn btn-outline-primary" id="qnaCommentBtn">
									<i class="check icon"></i>
								</button>
							</div>
						</div>
					</sec:authorize>

					<div class="ui list" id="qnaCommentListContainer">
						<!--<img class="image" src="/images/logo.png" alt="" />  -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<sec:authorize access="hasAuthority('admin') or (isAuthenticated() and (authentication.name eq #qna.writer))">


		<div class="d-none">
			<form action="/qna/remove" method="post" id="removeForm">
				<input type="text" name="id" value="${qna.id }" />
			</form>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">삭제 하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="ui black button" data-bs-dismiss="modal">닫기</button>
						<button type="submit" class="ui red button" form="removeForm">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</sec:authorize>

	<!-- 댓글 수정 -->
	<sec:authorize access="hasAuthority('admin')">
	<div class="modal fade" id="commentUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">댓글 수정</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div id="commentUpdateContainer">
							<input type="hidden" id="commentUpdateIdInput" />
							<textarea class="form-control" id="qnaCommentUpdateTextArea"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="ui button" data-bs-dismiss="modal">취소</button>
						<button type="button" class="ui olive button" id="qnaCommentUpdateBtn" data-bs-dismiss="modal">수정</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 댓글 삭제 -->
		<div class="modal fade" id="deleteCommentConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">댓글 삭제 확인</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">삭제 하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="ui black button" data-bs-dismiss="modal">닫기</button>
						<button id="deleteCommentModalButton" data-bs-dismiss="modal" type="submit" class="ui red button">삭제</button>
					</div>
				</div>
			</div>
		</div>
		
	</sec:authorize>
		
	<my:bottom />
	<script src="/js/qna/qnaComment.js"></script>
</body>
</html>