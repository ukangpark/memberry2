<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<my:top></my:top>


<style>
.pageName {
	height: 120px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 75vh;
}

.back {
	min-height: 75vh;
	margin-right: 15%;
	margin-left: 15%;
	border-radius: 1.5rem;
}

#imgContainer {
	position: relative;
	flex-grow: 2;
}

#addBtn {
	position: absolute;
	top: 75%;
	left: 58%;
}

#content {
	flex-grow: 3;
	margin-right: 10rem;
	margin-left: 10rem;
}

#imagePreview {
	position: relative;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.defaultImage {
	position: relative;
	width: 300px;
	height: 300px;
	border-radius: 50%;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0px;
}

.defaultImage>img {
	width: 100%;
	height: 100%;
}

.preview {
	display: none;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body style="background-color: #FFF2F2">

	<my:navBar />
	<my:logo></my:logo>

	<div class="pageName">
		<h1>새로운 스토리를 추가해 보세요!</h1>
	</div>

	<div class="back" style="background-color: #EEEEEE">
		<form class="wrapper" method="post" enctype="multipart/form-data" id="addForm">

			<!--  로그인 id 불러오기 -->
			<div>
				<input type="text" name="memberId" value="${authentication.getName() }" style="display: none">
			</div>

			<!-- 이미지 파일 업로드 -->

			<div class="" id="imgContainer">
				<div id="imagePreview" class="ui container">
					<img class="preview" src="">
					<div class="defaultImage">
						<img src="/images/투명발바닥.png">
					</div>
				</div>

				<!-- <label for="fileInput" class="big circular ui icon button" id="addBtn"> <i class="large plus icon"></i></label> -->
				<input style="width: 300px; margin: 5% 0px 0px 10%" multiple class="form-control" type="file" id="fileInput" name="files" accept="image/*" required />
				<h3 style="text-align: center">사진을 등록해 보세요!</h3>
			</div>

			<br />


			<%-- 
         <!-- 이미지 파일 업로드 -->
         <div id="add">
            <div class="" id="imgContainer">
               <div id="imagePreview">
                  <div id="previewCircle" class="ui centered medium bordered circular image">
                  <img class="preview" >
                  </div>
                  <div class="defaultImage">   
                  <img class="ui centered medium bordered circular image" src="/images/투명발바닥.png">
                  </div> 
               </div>
               
               <label for="fileInput" class="big circular ui icon button" id="addBtn">
               <i class="large plus icon"></i></label> 
               <input multiple class="form-control" type="file" id="fileInput" name="files" accept="image/*" />
               <h3 style="text-align: center">사진을 등록해 보세요!</h3>
            </div>
         </div>
         <br />
         
         <!-- <div>
         사진을 추가해보세요! <br /> <input type="file" multiple name="files" accept="image/*" />
         </div> -->
      --%>

			<!-- text content -->
			<div id="content">

				<div class="ui fluid form">
					<div class="field">
						<label align="left" style="color: red; font-weight: bolder;">필수</label>
						<input placeholder="title" type="text" name="title" value="${feed.title }">
						<div class="ui pointing label">제목을 입력해 주세요!</div>
					</div>

					<div class="ui divider"></div>


					<label align="left" style="color: red; font-weight: bolder;">필수</label>
					<textarea placeholder="content" name="content">${feed.content }</textarea>
					<div class="ui pointing red basic label">내용을 입력해 주세요!</div>

					<!-- 태그입력 -->
					<div class="field">
						<div class="ui divider"></div>
						<label align="left" style="color: gray; font-weight: bolder;">태그를 추가 해 보세요:)</label>
						<%-- <input type="text" id="feedId" name="feedId" value="${feedId }" style="display: none;"> --%>
						<div class="ui right labeled left icon input">
							<i class="tags icon"></i>
							<input type="text" id="tagInput" placeholder="Enter tags">
							<a type="submit" class="ui tag label" id="addTag">Add Tag</a>
						</div>
						<div class="tagsContainer mt-2">
						
						</div>
					</div>

					<%-- <div class="ui divider"></div>

         <div class="ui form">
            <div class="location">
               <label></label> <input placeholder="장소를 태그하세요" type="text" name="location" value="${feed.location }" />
            </div>
         </div>
         <br /> --%>

					<div align="right">
						<button class="btn btn-secondary mt-3" type="submit" form="addForm" id="addButton">추가하기</button>
					</div>

				</div>
			</div>
		</form>
	</div>

	<my:bottom></my:bottom>
	<script src="/js/feed/tag.js"></script>

	<script>
		/* 엔터키 치면 전송되는 것 방지 */
		$('input[type="text"]').keydown(function() {
			if (event.keyCode == 13) {
				event.preventDefault();
			}
			;

		})

		/* 첨부파일 이미지 변경 */
		const fileInput = document.getElementById("fileInput");
		const previewContainer = document.getElementById("imagePreview");
		const previewImage = previewContainer.querySelector(".preview");
		const previewDefaultImage = previewContainer
				.querySelector(".defaultImage");

		fileInput.addEventListener("change", function() {
			const file = this.files[0];
			//console.log(file);

			if (file) {
				const reader = new FileReader();

				previewDefaultImage.style.display = "none";
				previewImage.style.display = "block";

				reader.addEventListener("load", function() {
					previewImage.setAttribute("src", this.result);
				});

				reader.readAsDataURL(file);
			}

		})
	</script>
</body>
</html>