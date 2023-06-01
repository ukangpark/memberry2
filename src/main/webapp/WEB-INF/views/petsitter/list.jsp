<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>전체보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>
</head>
<body>



	<div class="container-lg">
		<h1>펫시터 목록</h1>
<hr />


<form action="list" class="d-flex" role="search">
        <input name="search" class="form-control me-2" type="search" placeholder="맡기고 싶은 지역을 검색하세요 (예. 서울시 서초구 반포동)" aria-label="Search">
        <button class="btn btn-outline-success" type="submit" style="width:80px">검색</button>
      </form>

	<!-- <script>
		$('.ui.dropdown').dropdown();
	</script> -->

<hr />


	<div class="ui link cards" >
    <c:forEach items="${petsitterList }" var="host">
  <div class="card">
    <div class="image">
    	<img src="/home1.jpg" alt="" height="70" />
    </div>
    <div class="content">
      <div class="header">${host.title }</div>
      <div class="meta" >
        <a href="/petsitter/detail?id=${host.id }">${host.si } ${host.gu } ${host.dong }</a>
      </div>
      <div class="description">
        펫시터 상세 설명
      </div>
    </div>
    <div class="extra content">
      <span class="right floated">
      
        하루 000원
      </span>
      <span>
        <i class="comments icon"></i>
        후기 몇개
      </span>
    </div>
  </div>
 
  </c:forEach>
</div>
	
	

	


</body>
</html>