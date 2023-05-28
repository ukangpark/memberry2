<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<!-- 호스트의 집사진 -->
	<div class="container">
		<h1>펫시터 상세페이지</h1>
		<div class="ui grid" style="height: 300px; margin-bottom: 25px;">
			<div class="ten wide column teal">
				<h1>집사진</h1>
			</div>
			<div class="six wide column blue">
				<h1>집사진</h1>
			</div>
		</div>
	</div>
	<!-- 호스트 간략 정보 -->
	<div class="container" style="width: 800px">
		<h3 class="ui dividing header">Detail</h3>
		<div class="ui items">
			<div class="item">
				<div class="image">
					<img src="https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg">
				</div>
				<div class="content">
					<a class="header">${host.hostName } (${host.id })</a>
					<div class="meta">
						<span>주소 : ${host.si }시 ${host.gu }구 ${host.dong }동</span>
						<br>
						<span>번호 : ${host.phone }</span>
						<br>
						<span>날짜 : ${host.inserted }</span>
					</div>
					<div class="description">
						<p>한 줄 소개 : ${detail.oneline }</p>
					</div>
					<div class="extra">#매일 산책 가능 #샤워 가능 #간식 있음</div>
				</div>

				<!-- 달력 -->
				<div class="content ui input">
					<label for="calendarIcon">
						<i class="calendar alternate outline icon"></i>
					</label>
					<input id="calendarIcon" style="width: 200px;" type="text" name="daterange" value="01/01/2018 - 01/15/2018" />
				</div>
			</div>
		</div>
	</div>

	<!-- 본문 -->
	<div class="container" style="width: 800px; margin-top: 25px;">
		<div class="ui text container">
			<p>본문 : ${detail.body }</p>
		</div>
		<div>
			<button class="ui right floated inverted red button">예약</button>
		</div>
	</div>

	<!-- 후기 -->
	<div class="container" style="width: 800px; margin: 25px auto 50px;">
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
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