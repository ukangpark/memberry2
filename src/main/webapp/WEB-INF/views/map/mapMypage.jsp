<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mapMypage</title>

<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
<d:top />
</head>
<body>
<d:navBar current="mapMypage" />

<h1> 즐겨찾기 </h1>


<div class="ui pointing menu">
  <a class="item">
    찜 목록
  </a>
  <a class="item active">
    다녀온 곳
  </a>
  <a class="item">
    또 뭐가 있지
  </a>
  <div class="right menu">
    <div class="item">
      <div class="ui transparent icon input">
        <input type="text" placeholder="Search...">
        <i class="search link icon"></i>
      </div>
    </div>
  </div>
</div>
<div class="ui segment">
  <p>
  1.샘플
  <br>
  2.샘플
  <br>
  3.샘플
  

  
  </p>
</div>

	<d:bottom></d:bottom>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="semantic/dist/semantic.min.js"></script>
</body>
</html>