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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
	

	.warapper {
		height: 100vh;
		width: 100%;
		
		
	
	}
	.wrapper h1 {
		text-align: center;
	}
	.inputField > input {
		color:black;
		padding-left: 15px;
		width: 600px;
		height: 40px;
		border: solid 2px;
		font-size: 15px;
		border-radius: 5px;
		outline: none;
		
	}
	.inputField button {
		width: 50px;
		height: 100%;
		border: none;
		background: rbg(6, 6, 6);
		cursor: pointer;
	}
	.toDoList li {
		width: 650px;
		list-style: none;
		line-height: 40px;
		position: relative;
		margin-bottom: 9px;
		text-indent: 15px;
		background: rgb(241, 242, 241);
		border-radius: 3px;
		font-weight: 400;
		cursor: pointer;
	}
	.wrapper .footer {
		font-weight: 600;
		text-indent: 15px;
		display: flex;
		width:  100%;
		margin-top: 30px;
		justify-content: right;
	}
</style>
</head>
<body>

<my:navBar></my:navBar>

<div class="wrapper">
		<h1>ToDoList</h1>
		<div class="inputField">
	
			<input type="text" name="toDo" id="addList" placeholder="할 일 추가"/>
			<button type="button" id="addBtn" onclick="addTodo()"><i class="fa-solid fa-plus"></i></button>
		
		</div>
		<div>
			<ul id="addTodo" class="toDoList">
				
				<li><div id="result"></div></li>
				
			</ul>
		</div>
		<div class="footer">
			<button type="button" id="allClear" onclick="allClearList()">모두 삭제</button>
		</div>
	</div>





    
 


	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	<script src="/js/schedule.js"></script> 
</body>
</html>