<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객판매관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//매장 검색 팝업
		$('#searchMarket').click(function(){
			window.open('${pageContext.request.contextPath}/market/marketShow.do','market','width=500,height=600');
		});
		//고객판매수금등록 팝업
		$('#registBtn').click(function(){
			window.open('${pageContext.request.contextPath}/sale/registShow.do','sale','width=1000,height=600');
		});
		
		
	});
</script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div id='wrapper'>
	<h4>고객판매관리</h4>
	<div class="searchBox">
		<form>
			<ul>
				<li>
					<label for="sal_dt">판매일자</label>
					<input type="date" id="sal_dt_from">
					<input type="date" id="sal_dt_to">
				</li>
				<li>
					<label>매장</label>
					<input type="text" id="prt_cd" name="prt_cd">
					<img id="searchMarket" class="searchIcon" alt="매장조회" src="${pageContext.request.contextPath}/images/search.png" >
					<input type="text" id="prt_nm" name="prt_nm">
				</li>
				<li>
					<label>고객번호</label>
					<input type="text" id="cust_no">
					<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
					<input type="text" id="cust_nm">
				</li>
			</ul>
			<div>
				<input type="button" id="searchBtn">
			</div>
			
		</form>
	</div>
	<button id="registBtn">판매등록</button>
	<div id="saleList">
		<table>
			<thead>
				<tr>
					<th>판매일자</th>
					<th>고객번호</th>
					<th>고객명</th>
					<th>판매번호</th>
					<th>수량</th>
					<th>금액</th>
					<th>현금</th>
					<th>카드</th>
					<th>포인트</th>
					<th>등록자</th>
					<th>등록시간</th>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	
	</div>
</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>