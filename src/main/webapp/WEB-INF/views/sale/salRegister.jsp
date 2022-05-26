<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//매장 재고 팝업
		$('#stockBtn').click(function(){
			window.open('${pageContext.request.contextPath}/sale/openStock.do','sale','_blank','width=700,height=900');
		});
		
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
	});
</script>
</head>
<body>
<h4>고객판매수금등록</h4>
<div class="searchBox">
	<form>
		<ul>
			<li>
				<label for="sal_dt">판매일자</label>
				<input type="date" id="sal_dt_from">
				<input type="date" id="sal_dt_to">
			</li>
			<li>
				<label>판매구분</label>
				<select name="sal_tp_cd" id="sal_tp_cd">
					<option selected disabled value="0">전체</option>
					<option value="1">판매</option>
				</select>
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
<h5>결제금액</h5>
<div id="costBox">
	<ul>
		<li>
			<label>현금</label>
			<input type="text" id="csh_stlm_amt">
		</li>
		<li>
			<label>카드금액</label>
			<input type="text" id="crd_stlm_amt">
		</li>
		<li>
			<label>유효일자</label>
			<input type="text" id="vld_ym">
		</li>
		<li>
			<label>카드회사</label>
			<input type="text" id="crd_co_cd">
		</li>
		<li>
			<label>카드번호</label>
			<input type="hidden" id="crd_no">
			<input type="text" id="crd_no1">
			<input type="text" id="crd_no2">
			<input type="text" id="crd_no3">
			<input type="text" id="crd_no4">
		</li>
	</ul>
</div>
<div id="pmBtn">
	<input type="button" value="+">
	<input type="button" value="-">
</div>
<div id="regList">
	<table>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>상품코드<input type="button" id="stockBtn" value="찾기"></th>
				<th>상품명</th>
				<th>매장재고</th>
				<th>판매수량</th>
				<th>판매금액</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
</div>
<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="button" id="submitBtn" value="적용">
</div>
</body>
</html>