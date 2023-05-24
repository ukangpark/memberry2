
// 버튼
const addBtn = document.getElementById('addBtn');
//할 일 입력
let addList = document.getElementById('addList');
let result = document.getElementById('result');

//할 일 추가 시
function addTodo() {
	if(addList.value == false) {
		alert("내용을 입력하세요.");
	} else {
		let list = document.createElement("li");
		let del = document.createElement("button");
		list.innerHTML = addList.value;
		result.appendChild(list);
		list.appendChild(del);
		del.innerText = "X";
		del.style.border = "none";
		del.style.float = "right";
		del.style.right = "17px";
		del.style.marginTop = "10px";
		del.style.cursor = "pointer";
		del.addEventListener("click", deleteList);
		del.style.positoin = "relative";
		
		addList.value = "";
		addList.focus();
		list.addEventListener("clcik", function() {
			list.style.textDecoration = "line-through";
			
		})
	}
}
//할 일 목록 삭제 시
function deleteList(e) {
	let removeOne = e.target.parentElement;
	removeOne.remove();
}

