<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"%>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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

#calendar {
  max-width: 1100px;
  margin: 40px auto;
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

<body style="padding:30px;">
<my:navBar current="calendar"></my:navBar>



	<div id='calendar'></div>
  


<script src="/js/calendar.js"></script>
<my:bottom></my:bottom>

	 
</body>
</html>