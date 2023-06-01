<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css">
<style>
#header {
	text-align: center;
	margin: 40px 0;
}
</style>


</head>
<body>

	<my:navBar current="home" />
	<div id="header">
		<h2>header</h2>
	</div>
	<div style="position: fixed; bottom: 5px; right: 5px;">
		<a href="#header"><i class="fa-solid fa-circle-arrow-up fa-3x"></i></a>
	</div>

	<div class="ui center aligned container" id="container" style="background-color: #e2e2e2;">
		<div class="ui link cards">
			<div class="card">
				<div class="image">
					<img src="/images/loki.jpeg">
				</div>
				<div class="content">
					<div class="header">로키</div>
					<div class="meta">
						<a>멋째이 로키</a>
					</div>
					<div class="description">오늘 로키는 멋째이 선구리를 썼다.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/cat.jpeg">
				</div>
				<div class="content">
					<div class="header">Molly</div>
					<div class="meta">
						<span class="date">Coworker</span>
					</div>
					<div class="description">Molly is a personal assistant living in Paris.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/yj.JPG">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/cat2.jpeg">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/js.JPG">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/yj2.JPG">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/js2.JPG">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>
			<div class="card">
				<div class="image">
					<img src="/images/dog5.jpeg">
				</div>
				<div class="content">
					<div class="header">Elyse</div>
					<div class="meta">
						<a>Coworker</a>
					</div>
					<div class="description">Elyse is a copywriter working in New York.</div>
				</div>
				<div class="extra content">
					<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp; <i class="comment icon"></i>
					</span> <span class="right floated">2023.06.01 </span>
				</div>
			</div>

			<c:forEach items="${feedList}" var="feed">
				<div class="card">
					<div class="image">
						<img src="/images/dog5.jpeg"> </a>
					</div>
					<div class="content">
						<div class="header">${feed.title}</div>
						<div class="meta">
							<a>${feed.writer}</a>
						</div>
						<div class="description">${feed.content}</div>
					</div>
					<div class="extra content">
						<span class="left floated"> <i class="heart outline like icon"></i>17 likes <i class="paw icon"></i> <a href="comment"> <i class="comment icon"></i>
						</a>
						</span> <span class="right floated">${feed.inserted}</span>
					</div>
				</div>
			</c:forEach>

			<c:forEach items="${feedList}" var="feed">
				<div class="card" style="margin: 40px;">
					<div class="image">
						<a href="feedId/${feed.id}"> <%--  <c:forEach items="${feed.fileName }" var="fileName"> 
								<img src="${bucketUrl }/${feed.id }/${fileName }" alt="" width="100%"; height="auto";/>
						 	</c:forEach>  --%>
						</a>
					</div>
					<div class="content">
						<div class="header">${feed.title}</div>
						<div class="meta">
							<!--이름누르면 해당 멤버의 마이피드로 이동 -->
							<a>${feed.writer}</a>
						</div>
						<div class="description">${feed.content}</div>
					</div>
					<div class="extra content">
						<span class="left floated"> <i class="heart outline like icon"></i>17 likes &nbsp; <i class="paw icon"></i>&nbsp;&nbsp;
					 <a href="comment"> 
						 <a href="comment/feedId/${feed.id}"> 
							<i class="comment icon"></i>
						</a>   

						</span> <span class="right floated">${feed.inserted}</span>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js"></script>
</body>
</html>