<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"%>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<my:top></my:top>

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>

<style>
 html, body {
  margin: 0;
  padding: 0;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}
 #header {
	display: flex;
	justify-content: center;
} 
#calendarWrapper {
	/* display: flex; */
	justify-content: space-around;
	/* align-items: center; */
	/* min-height: 100vh; */
	background-color: #EEEEEE;
	margin-right: 10%;
	margin-left: 10%;
	margin-top: 3%;
	border-radius: 1.5rem;
	/* position: relative; */
}

#calendar {
  max-width: 1100px;
  margin:30px auto;
  
}

.fc-daygrid  a{
	color: black;
}
/* 일요일 날짜 빨간색 */
.fc-day-sun a {
  color: red;
  text-decoration: none;
}

/* 토요일 날짜 파란색 */
.fc-day-sat a {
  color: blue;
  text-decoration: none;
}
</style>

</head>

<body style="padding:30px; background-color: #FFF2F2;" >
<my:navBar current="calendar"></my:navBar>
<my:logo></my:logo>
	<div id="header">
		<h1><span style="font-weight: bold"> 
		<span style="color: #FF9999">${logedInMember.nickName }</span>
		 캘린더</h1>
	
	</div>

	 <div id="calendarWrapper">
		<div id='calendar'></div>
	</div>   
  	
  	 <!-- <ul class="scheduleInfo">
  	
  	</ul> -->
  	


 <script src="/js/calendar.js"></script>
<my:bottom></my:bottom>

	 
</body>
</html>