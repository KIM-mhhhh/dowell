<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
		//반품 처리
		$('#refundBtn').click(function(){
			var yn = confirm("등록하시겠습니까?");
				if(yn==false){
					return false;
				}else{
					alert('등록!');
				}
		});
	});
</script>
</head>
<body>
<h3>판매상세조회</h3>
<div id="infoBox">
	<span>매장 :${saleVO.prt_cd}  / 고객번호 : ${saleVO.cust_no } ${saleVO.cust_nm } </span>
	<span><Br>판매수량 :  ${saleVO.tot_sal_qty }  / 판매금액 : ${saleVO.tot_sal_amt }   / 현금 : ${saleVO.csh_stlm_amt }   / 카드 : ${saleVO.crd_stlm_amt }  </span>
</div>
<div id="salDetList">
	
	<Table id="salDetTable">
	
		<thead>
		<tr>
			<th>번호</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>판매수량</th>
			<th>공급가</th>
			<th>부가세</th>
			<th>판매금액</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var="sale" items="${saleList}">
					<tr>
						<td>${sale.sal_seq}</td>
						<td>${sale.prd_cd}</td>
						<td>${sale.prd_nm}</td>
						<td>${sale.sal_qty}</td>
						<td>${sale.sal_vos_amt}</td>
						<td>${sale.sal_vat_amt}</td>
						<td>${sale.sal_amt}</td>
					
					</tr>
			</c:forEach>
		</tbody>
	</Table>
</div>

<div id="resultBtn">
<%-- 	<form action="${pageContext.request.contextPath}/sale/returnSale.do" method="post">
	<c:forEach var="sale" items="${saleVO}">
		<input type="hidden" name="prt_cd" value="${saleVO.prt_cd}">
	</c:forEach> --%>
	<input type="button" id="closeBtn" value="닫기">
	<c:if test="${saleVO.sal_tp_cd eq 'SAL' }">
		<input type="submit" id="refundBtn" value="반품">
	</c:if>
<!-- 	</form> -->
</div>
</body>
</html>