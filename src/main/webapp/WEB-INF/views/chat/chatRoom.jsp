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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<my:top></my:top>
</head>
<style>

	

</style>
<body>
	<my:navBar current="chatRoom"></my:navBar>
	
	<my:alert></my:alert>

	<div id="chatContainer" class="d-flex">
		<div id="chatList" style="background-color: #EEEEEE; height: 100vh; width: 25vw;">
		
		</div>
		
		<div id="chatContent" style="background-color: #FFF2F2; height: 100vh; width: 75vw;">
			<!-- <div>
				<textarea id="chatInput" style="font-size: 20px; height: 50px; width: 70vw; border-radius: 1.5rem; margin: 92vh 0px 0px 20px; border-color: #EEEEEE;" type="text" placeholder="  메세지를 입력해 주세요." maxlength="100"></textarea>
			</div> -->
			
			<div class="ui action input" style="font-size: 20px; height: 50px; width: 70vw; margin: 92vh 0px 0px 20px; border-color: #EEEEEE;">
  				<input id="chatInput" style=" border-top-left-radius: 1.5rem; border-bottom-left-radius: 1.5rem;" type="text" placeholder="  메세지를 입력해 주세요." maxlength="100">
 				<button onclick="submitFunction();" class="ui action button" style="border-top-right-radius: 1.5rem; border-bottom-right-radius: 1.5rem;">
 				<i class="fa-solid fa-paper-plane"></i>
 				</button>
			</div>
		</div>
	</div>


<my:bottom></my:bottom>

	<script>
		$('.ui.modal').modal('show');
	</script>


</body>
</html>