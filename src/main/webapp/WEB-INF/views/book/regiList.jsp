<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약내역 (사용자)</title>
<link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">

<d:top />
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<script type="text/javascript">
// 여기부터 결제기능관련 코드
/* function requestPay() {
	var IMP = window.IMP; // 생략 가능
	IMP.init("imp67575345"); // 본인 가맹점 코드
	console.log("func");
    // IMP.request_pay(param, callback) 결제창 호출
    IMP.request_pay({ // param
        pg: "kakaopay.TC0ONETIME", 
       //  pg: "KG이니시스 인증.MIIiasTest", 
        pay_method: "card",
        merchant_uid: "ORD20180131-0000011",
        name: "membery_펫시터",
        amount: 40000,
        buyer_email: "gildong@gmail.com",
        buyer_name: "홍길동",
        buyer_tel: "010-4242-4242",
        buyer_addr: "서울특별시 강남구 신사동",
        buyer_postcode: "01181"
    }, function (rsp) { // callback
       //  if (rsp.success) { 
            // 결제 성공 시 로직,
            console.log("success");
       //  } else { 
            // 결제 실패 시 로직,
        // } 
    });
  } */
  
  
   	function payment(pg_provider, mode, payment_method, money){
	  
	  IMP.init("imp67575345"); // 본인 가맹점 코드
	  var pg_mid;
	  
	  if(pg_provider =='inicis'){
		  if(mode=='test'){
		  	pg_mid = 'html5_inicis.INIPayTest';
		  }else{
			  pg_mid = 'html5_inicis.MOI123123'
		  }
	  }else if(pg_provider=='kcp'){
		  if(mode=='test'){
			  pg_mid = 'kcp.MIIiasTest';
		  }else{
			  pg_mid = 'kcp.IOfds34';
		  }
	  }
	 // alert(pg_mid);
	  
	  //step 3
	  const data = {
			  pg: 'nice',
			  pay_method: payment_method,
			  merchant_uid: "ORD20180131-0000021",
			  name: "membery_펫시터",
			  amount: money,
		      buyer_email: "gildong@gmail.com",
		      buyer_name: "홍길동",
		      buyer_tel: "010-4242-4242"
	  };
	  
	  IMP.request_pay(data, response => {
		 // alert('callback!: '+JSON.stringify(response));
	  
		  //step 4
		  jQuery.ajax({
			  url:"/payment/callback_receive",
			  method: "POST",
			  headers: {"Content-Type" : "application/json"},
			  data: JSON.stringify(response)
		  }).done(function (data) {
			  // step 6
		//  alert("please, Check your payment result page");
		  	})
		  });
	  }
	  
  

  
  
  
</script>
</head>
<body>
	<d:navBar current="regiList" />


	<c:if test="${not empty message }">
		<div class="container-lg">
			<div class="alert alert-warning alert-dismissible fade show" role="alert">
				${message }
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</c:if>


	<div class="container-lg">

		<h2 style="margin-top: 60px; margin-bottom: 0px; text-align: center;">
			<i class="fa fa-solid fa-paw"></i>
			예약내역
			<i class="fa fa-solid fa-paw"></i>
		</h2>

		<table class="table" style="margin-top: 75px;">
			<thead>
				<tr>
					<th>pet 이름</th>
					<th>체크인 날짜</th>
					<th>체크아웃 날짜</th>
					<th>펫시터 이름</th>
					<th>예약 상태</th>
					<th>예약 변경 / 결제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bookList }" var="book">
					<form action="/book/remove/${book.num }" method="post" id="removeForm_${book.num }">

					<tr>
						<td>
						<a href="/book/num/${book.num }">
						${book.petName }
						</a>
						</td>
						<td>${book.checkIn }</td>
						<td>${book.checkOut }</td>
						<td>
						<a href="/petsitter/detail?id=${book.hostId }">
						${book.hostName }
						</a>
						</td>
						<td>
						
						<c:if test="${book.accepted == 0}">
						<button type="button" class="btn btn-warning">요청중</button>
						</c:if>
						<c:if test="${book.accepted == 1}">
						<button type="button" class="btn btn-warning">결제대기</button>
						</c:if>
						<c:if test="${book.accepted == 2}">
						<button type="button" class="btn btn-warning">완료</button>
						</c:if>
						<c:if test="${book.accepted == 3}">
						<div class="ui button" data-tooltip="${book.rejectMessage }" data-position="top center">
						 예약거절
						</div>
						</c:if>
						</td>
						
						<td>
						<c:if test = "${book.accepted == 0 }">
						<button type="button" class="btn btn-secondary" onclick="location.href='/book/modify/${book.num}'">변경</button>
						<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="openModal('${book.num }')">삭제</button>
						</c:if>
						<c:if test = "${book.accepted == 1 }">
						<button type="button" class="btn btn-primary" id="payBtn" onclick="payment('kcp','test', 'card','${book.money}')">결제</button>
						</c:if>
						</td>
					</tr>
					<input type="hidden" name="num" value="${book.num }"/>
					</form>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<br />
					확인을 누르시면 예약신청이 취소됩니다.

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-danger">확인</button>
				</div>
			</div>
		</div>
	</div>






	<div class="container-lg">
		<div class="row">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">

					<!-- 이전 버튼 -->
					<c:if test="${pageInfo.currentPageNum ne 1 }">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum - 1}" />
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }">이전</a>
						</li>
					</c:if>

					<c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageNum}" />
						</c:url>
						<li class="page-item">
							<a class="page-link ${pageNum eq pageInfo.currentPageNum ? 'active' : '' }" href="${pageLink }">${pageNum}</a>
						</li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
						<c:url value="list" var="pageLink">
							<c:param name="page" value="${pageInfo.currentPageNum + 1}" />
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }">다음</a>
						</li>
					</c:if>

				</ul>
			</nav>
		</div>
	</div>









	<d:bottom></d:bottom>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
function openModal(num) {
	var submitButton = document.querySelector("#exampleModal button[type='submit']");
	submitButton.setAttribute("form", "removeForm_" + num);
  }

/* $(document).ready(function(){
	$("#payBtn").click(function(){
		requestPay();
	})
}) */


</script>
</body>
</html>