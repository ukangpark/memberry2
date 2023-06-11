<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세페이지</title>
<my:top></my:top>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="/js/semantic.min.js"></script>
</head>
<body>
	<my:navBar></my:navBar>

	<!-- 호스트의 집사진 -->
	<div class="container" style="width: 900px">
		<h1>펫시터 상세페이지</h1>
			<div class="ten wide column teal">
				<div>
					<h5>대표 사진</h5>
					<img style="width: 200px;" src="${bucketUrl }/cover/${detail.id }/${detail.cover }">
				</div>
				<div class="ui images">
					<c:forEach items="${hostHousePhoto }" var="hostHousePhoto">
						<img class="ui medium rounded image" src="${bucketUrl }/hostHousePhoto/${detail.id }/${hostHousePhoto.housePhoto }">
					</c:forEach>
				</div>
			</div>
		</div>
	<!-- 호스트 간략 정보 -->
	<div class="container" style="width: 900px">
		<h3 class="ui dividing header">Detail</h3>
		<div class="ui items">
			<div class="item">
				<div class="image">
					<c:choose>
						<c:when test="${host.profile eq null or host.profile eq '' }">
							<!-- 프로필 사진 없음 -->
							<img style="width: 150px; height: 150px;" alt="기본 사진" src="/images/paw.png">
						</c:when>
						<c:otherwise>
							<!-- 프로필 사진 있음  -->
							<img style="width: 150px; height: 150px;" src="${bucketUrl }/hostProfile/${host.id }/${host.profile }">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="content">
					<a class="header">${host.hostName }</a>
					<div class="meta">
						<span>주소 : ${host.si }시 ${host.gu }구 ${host.dong }동</span>
						<br>
						<span>번호 : ${host.phone }</span>
					</div>
					<div class="description">
						<p>한 줄 소개 : ${detail.title }</p>
					</div>
					<div class="extra">#매일 산책 가능 #샤워 가능 #간식 있음</div>
				</div>

				<!-- 달력 -->
				<div class="content ui input">
					<label for="calendarIcon">
						<i class="calendar alternate outline icon"></i>
					</label>
					<input id="calendarIcon" style="width: 200px;" type="text" name="daterange" value="01/01/2023 - 01/15/2023" />
				</div>
			</div>
		</div>
	</div>

	<!-- 본문 -->
	<div class="container" style="width: 900px; margin-top: 25px;">
		<div class="ui text container">
			<p>${detail.body }</p>
		</div>
		<div>
			<button class="ui right floated inverted red button" onclick="location.href='/book/regiForm/${host.id}'" >예약</button>
		</div>
	</div>

	<!-- 후기 -->
	<div class="container" style="width: 900px; margin: 25px auto 50px;">
		<div class="ui minimal comments">
			<h3 class="ui dividing header">Comments</h3>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Matt</a>
					<div class="metadata">
						<span class="date">Today at 5:42PM</span>
					</div>
					<div class="text">How artistic!</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
			</div>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Elliot Fu</a>
					<div class="metadata">
						<span class="date">Yesterday at 12:30AM</span>
					</div>
					<div class="text">
						<p>This has been very useful for my research. Thanks as well!</p>
					</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
				<div class="comments">
					<div class="comment">
						<a class="avatar">
							<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
						</a>
						<div class="content">
							<a class="author">Jenny Hess</a>
							<div class="metadata">
								<span class="date">Just now</span>
							</div>
							<div class="text">Elliot you are always so right :)</div>
							<div class="actions">
								<a class="reply">Reply</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="comment">
				<a class="avatar">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</a>
				<div class="content">
					<a class="author">Joe Henderson</a>
					<div class="metadata">
						<span class="date">5 days ago</span>
					</div>
					<div class="text">Dude, this is awesome. Thanks so much</div>
					<div class="actions">
						<a class="reply">Reply</a>
					</div>
				</div>
			</div>
			<form class="ui reply form">
				<div class="field">
					<textarea></textarea>
				</div>
				<div class="ui blue labeled submit icon button">
					<i class="icon edit"></i>
					Add Reply
				</div>
			</form>
		</div>
	</div>
	<my:bottom></my:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- 달력 -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script>
		$(function() {
			$('input[name="daterange"]').daterangepicker(
					{
						opens : 'left'
					},
					function(start, end, label) {
						console.log("A new date selection was made: "
								+ start.format('YYYY-MM-DD') + ' to '
								+ end.format('YYYY-MM-DD'));
					});
		});
	</script>
</body>
</html>