
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>schedule</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />



<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	height: 100vh;
	width: 100%;
}

.header {
	text-align: center;
}
.calendarWrapper {
	width: 80%;
	float: center;
	margin: auto;
	margin-top: 30px;
}
.toDo {
	margin: auto;
	float: right;
	
}

/* --달력 코드 복붙------------------------------------------------------- */
/* btn css */
.clickBtn {
  width: 70px;
  height: 35px;
  border-radius: 10%;
  font-size: 15px;
  font-weight: 700;
  border: none;

  background: #e2e2e2;

  margin-right: 30px;
}

/* header */
header {
  border-bottom: 1px solid grey; 
  display: flex;
  padding: 10px;
  height: 7%;
  box-sizing: border-box;
}
header > h1 {
  display: inline-block;
  height: 100%;
  flex-grow: 1;
}
.fa-calendar-check {color: grey; margin-right: 2%; vertical-align: middle;}

header > h1 > span {color: #a7a7a7; font-size: 24px; font-weight: 400; vertical-align: bottom;}

.calendar_title { margin: 0 auto; flex-grow: 1;}
.calendar_title .prev , .next{
  width: 30px;
  height: 100%;
  cursor: pointer;
  border: none;
  font-size: 20px;
  font-weight: 700;
  outline: none;

  color: #5c5c5c;
  border-radius: 10%;
  font-weight: 600;

}
.calendar_title .current-year-month {
  font-size: 24px;
  font-weight: 500;
  vertical-align: middle;
  color: black;
  display: inline-block;
  margin: 0 20px;
  font-weight: 600;
}

/* content left */
.content-left {
  float: left;
  box-sizing: border-box;
  width: 20%;
  
}
.left-main {margin-top: 20%;}
.left-main .main-wrap {
  text-align: center;
  font-weight: 600;
}
.left-main .main-wrap .main-day {
  padding: 10% 0;
  font-size: 30px;
  color: black;
}
.left-main .main-wrap .main-date {
  margin: 10% 0;
  font-size: 80px;

  color: #585858;
}
.left-main .todo-wrap {padding: 20% 0 10% 10%;}
.left-main .todo-wrap .todo-title {
  font-size: 40px;
  font-weight: 600;
  margin-bottom: 10%;
  color: grey;
}

.left-main .todo-wrap .input-form .input-box {
  width: 90%;
  height: 50px;
  font-size: 20px;
  border: 0;

  border-bottom: 2px dashed black;

  margin-bottom: 30px;
  outline-style: none;
}
/* content right */
.content-right {
  float: right;
  box-sizing: border-box;
  width: 80%;
  border: solid;
}
.content-right .day-of-week {
  background: #e2e2e2;
  width: 100%;
  height: 100%;
}
.content-right .day-of-week .dayHeader {
  display: inline-block;
  width: calc(100% / 7.5);
  height: 100%;
  text-align: center;
  padding: 1%;
  box-sizing: border-box;
  font-weight: 600;
  font-size: 18px;
}
.content-right .day-of-week .dayHeader.sun {color: #f02f2f;}
.content-right .day-of-week .dayHeader.sat {color: #2208e7;}

/* calendar body  */
#weekly > div {
  box-sizing: border-box;
  text-align: center;
  width: calc(100% / 7);
  height: 130px;
  display: inline-block;
  border-bottom: 1px solid #e4e4e4;
  vertical-align: top;
  padding: 1%;
  color: black;
  overflow-y: auto;
}
#weekly > div.active {
  background: #e4e4e4;
}
#weekly > div + div{
  border-left: 1px solid #e4e4e4;
}
.calendar-body #weekly > div:first-child {border-left: 1px solid #e4e4e4;}
.calendar-body #weekly > div:last-child {border-right: 1px solid #e4e4e4;}

/* todoList */
.todoList {
  margin-top: 10%;
  font-size: 20px;
}
.todoList > li {position: relative;}
.todoList > li > span{
  white-space: nowrap;
  width: 70%;
  overflow: hidden;
  display: block;
  text-overflow: ellipsis;
}
.todoList > li+li {
  margin-top: 5%;
}
.todoList > li > .del-data{
  position: absolute;
  top: 0; right: 5%;
  width: 20%;
  height: 25px;
  background: none;
  border: none;
  font-size: 0px;
}
.todoList > li > .del-data::after, .todoList > li > .del-data::before{
  content: '';
  position: absolute;
  top:0; left: 50%;
  display: block;
  width: 4px;
  height: 18px;

  background: grey;

}
.todoList > li > .del-data::after, .closed::after {transform: rotate(45deg);}
.todoList > li > .del-data::before, .closed::before{transform: rotate(-45deg);}
.showList {
  display: none;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);

  background: #e2e2e2;

  width: 400px;
  height: 300px;
  z-index: 1;
  border-radius: 20px;
  overflow: hidden;

}
.closed {
  position: absolute;
  top: 5%; right: 5%; 
  width: 40px; 
  height: 40px;
  font-size: 0;
  background: none;
  border: none;
}
.closed::after, .closed::before {
  content: '';
  position: absolute;
  top: 14%; right: 44%;
  width: 3px;
  height: 25px;
  background: #fff;
}
.listText {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  word-break:break-all;
  width: 70%;
  font-size: 20px;
  color: #fff;
}
.createDate {
  position: absolute;
  bottom: 7%;
  right: 7%;
  font-size: 20px;
  color: #e4e4e4;
}
.bgblack {
  display: none;
  background: #acacac;
  opacity: 0.6;
  position: absolute;
  left: 0; right: 0; top: 0; bottom: 0;
}

/* ---reset--- */

a {text-decoration:none;}

table {border-collapse: collapse}
h1, h2, h3, h4, h5, h6, div, p, dl, dt, dd, ul, ol, li, form, fieldset, blockquote, address, table, thead, tbody, tfoot, tr, td, caption {
	margin:0;
	padding:0;
}
img { vertical-align: top;}

</style>

</head>
<body>
	<div class="header">

		<h1>Calendar</h1>
	</div>
	<!------------------------------------------------------------------------>


	<div class="calendarWrapper">
		<header>
			<h1>
				<i class="far fa-calendar-check"></i> <span>캘린더</span>
			</h1>
			<div class="calendar_title">
				<button class="prev">&#60;</button>
				<span class="current-year-month"></span>

				<button class="next">&#62;</button>				
			</div>
			<div>
				<a href="toDoList"><h3>ToDoList</h3></a>

			</div>
		</header>
		<section class="content-left">
			<div class="left-main">
				<div class="main-wrap">
					<div class="main-day"></div>
					<div class="main-date"></div>
				</div>
				<div class="todo-wrap">

					<div class="todo-title">일정</div>
					<form class="input-form">
						<input type="text" placeholder="일정을 작성하세요!!" class="input-box" />

						<button type="submit" class="input-btn clickBtn">추가</button>
					</form>
					<ul class="todoList"></ul>
					<div class="showList">
						<span class="listText"></span> <span class="createDate"></span>

						<button class="closed">닫기</button>

					</div>
					<div class="bgblack"></div>
				</div>
			</div>
		</section>
		<section class="content-right">
			<div class="day-of-week">
				<div class="dayHeader sun">Sun</div>
				<div class="dayHeader">Mon</div>
				<div class="dayHeader">Tue</div>
				<div class="dayHeader">Wed</div>
				<div class="dayHeader">Thu</div>
				<div class="dayHeader">Fri</div>
				<div class="dayHeader sat">Sat</div>
			</div>
			<div class="calendar-body"></div>
		</section>

	</div>


	


	


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
		integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>


	<script src="/js/schedule.js"></script>
</body>
</html>