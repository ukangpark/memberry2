<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
body {
    display: flex;
    flex-wrap: nowrap;
    justify-content: center;
    background-color: #F5F5F5;
    min-height: 100%;
}

.todo-wrapper {
    justify-content: center;
    margin-top: 3rem;
    min-width: 600px;
}

.todo-title {
    padding: 2rem;
    text-align: center;
    color: #6E6E6E;
    font-size: 4rem;
}

.todo-box {
    background-color: white;
    border: 1px solid #ddd;
}

.todo-input-box {
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    height: 3rem;
    border-bottom: 1px solid #ddd;
    justify-content: flex-start;
    align-items: center;
}

button {
    background-color: transparent;
    border: 0;
}

.complete-all-btn {
    color: gray;
    min-width: none;
    min-height: none;
    width: 1.5rem;
    height: 1.5rem;
    margin: 0.5rem 0.5rem;
    border-radius: 50px;
    cursor: pointer;
    font-size: 1.2rem;
    
}

.complete-all-btn.checked {
    color: green
}

.todo-input {
    width: 80%;
    text-align: center;
    border: 0;
    outline: none;
    font-size: 1.3rem;
}

.todo-item {
    position: relative;
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    height: 3rem;
    border-bottom: 1px solid #ddd;
}

.todo-item:hover .delBtn {
    opacity: 1;
}

.checkbox {
    min-width: none;
    min-height: none;
    width: 1.5rem;
    height: 1.5rem;
    margin: 0.5rem 0.5rem;
    border-radius: 50px;
    border: 1px solid lightgray;
    cursor: pointer;
    text-align: center;
}

.todo-item.checked .checkbox{
    border: 2px solid darkgray;
    color: green;
}

.todo {
    font-size: 1.3rem;
    padding: 0 1rem;
    width: 80%;
}

.todo-item.checked .todo{
 font-style: italic;
 text-decoration: line-through;
 color: lightgray;
}

.delBtn {
    opacity: 1;
    width: 3rem;
    height: 3rem;
    font-size: 1.5rem;
    font-weight: lighter;
    cursor: pointer;
}

.todo-bottom {
    height: 3rem;
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 0 1rem;
}

.button-group{
    flex-direction: row;
    flex-wrap: nowrap;
}

.button-group button {
    border: 1px solid #eee;
    padding: 0.2rem 0.5rem;
    margin: 0 0.5rem;
    border-radius: 8px;
    cursor: pointer;
}

.button-group button.selected {
    border: 2px solid #585858;
    padding: 0.2rem 0.5rem;
    margin: 0 0.5rem;
    border-radius: 8px;
}

.clear-completed-btn:hover {
    font-style: italic;
    text-decoration: underline;
    cursor: pointer;
}

.edit-input {
    position: absolute;
    left: 0;
    top: 0;
    width: 590px;
    height: 2.8rem;
    margin: 0;
}

p.info {
    margin-top: 1.5rem;
    text-align: center;
    color: #ccc;
}
/* * {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
body {
	height: 100vh;
	width: 100%;
}
.wrapper {
	width: 80%;
	float: center;
	margin: auto;
} */


</style>

</head>
<body>

	<!-- <div class="wrapper">
		<h1>ToDoList</h1>
		<div class="inputField">
			<input type="text" name="toDo" id="addList" placeholder="할 일 추가" />
			<button type="button" id="addBtn" onclick="addTodo()">
				<i class="fa-solid fa-plus"></i>
			</button>
		</div>
		<div>
			<ul id="addTodo" class="toDoList">
				<li><div id="result"></div></li>
			</ul>
		</div>
		<div class="footer">
			<button class="btn btn-danger" type="button" id="allClear"
				onclick="allClearList()">모두 삭제</button>
		</div>
	</div> -->

<div class="todo-wrapper">
        <div class="todo-title">To do</div>
        <div class="todo-box">

            <div class="todo-input-box">
                <button class="complete-all-btn"><i class="fa-solid fa-check"></i></button>
                <input type="text" class="todo-input" placeholder="해야 할 일을 입력해주세요.">
            </div>
            
            <ul class="todo-list">
              
            </ul>
            <div class="todo-bottom">
                <div class="left-items">0개 남음</div>
                <div class="button-group">
                    <button class="show-all-btn selected" data-type="all">전체</button>
                    <button class="show-active-btn" data-type="active">진행중</button>
                    <button class="show-completed-btn" data-type="completed">완료</button>
                </div>
                <button class="clear-completed-btn">완료된 일 지우기</button>
            </div>
        </div>
        <p class='info'>더블클릭 시 수정 가능!</p>
       
    </div>

	<script src="/js/toDoList.js"></script>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
		integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>