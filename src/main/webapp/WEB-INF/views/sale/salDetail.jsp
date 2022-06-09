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
		addComm();
		getSum();
		
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
		//반품 처리
		$('#refundBtn').click(function(){
			
			var yn = confirm("반품하시겠습니까?");
				if(yn==false){
					return false;
				}else{
					popComm();
				}
		});
		//가격에 , 넣기
		function addComm(){
			$('.vos').each(function(){
				var org = Number($(this).text());
				$(this).text(org.toLocaleString());
			});
			$('.vat').each(function(){
				var org = Number($(this).text());
				$(this).text(org.toLocaleString());
			});
			$('.amt').each(function(){
				var org = Number($(this).text());
				$(this).text(org.toLocaleString());
			});
			$('#csh_stlm_amt').val(Number($('#csh_stlm_amt').val()).toLocaleString());
			$('#crd_stlm_amt').val(Number($('#crd_stlm_amt').val()).toLocaleString());
			$('#tot_sal_amt').val(Number($('#tot_sal_amt').val()).toLocaleString());
		}
		
		//가격에 , 빼기
		function popComm(){
/* 			$('.vos').each(function(){
				var org = $(this).text().replace(/\,/g,'');
				$(this).text(org);
			});
			$('.vat').each(function(){
				var org = $(this).text().replace(/\,/g,'');
				$(this).text(org);
			});
			$('.amt').each(function(){
				var org = $(this).text().replace(/\,/g,'');
				$(this).text(org);
			}); */
			$('#csh_stlm_amt').val($('#csh_stlm_amt').val().replace(/\,/g,''));
			$('#crd_stlm_amt').val($('#crd_stlm_amt').val().replace(/\,/g,''));
			$('#tot_sal_amt').val($('#tot_sal_amt').val().replace(/\,/g,''));
		}
		
		//합계
		function getSum() {
			// 합계 계산
			var qtySum = 0;
			var amtSum = 0;
			var vosSum = 0;
			var vatSum = 0;

			//판매수량 합계
			$('.qty').each(function(){ //클래스가 cash인 항목의 갯수만큼 진행
				var num = $(this).attr('num');
				qtySum += Number($(this).text());	
			});	 
			$('#qtySum').text(qtySum);	
			//판매금액 합계
			$('.amt').each(function(){ 
				var num = $(this).attr('num');
				amtSum += Number($(this).text().replace(/\,/g,''));
			});	  
			$('#amtSum').text(amtSum.toLocaleString());				// ,넣어준다
			$('#qtySum').text(qtySum);	
			//공급가 합계
			$('.vos').each(function(){ 
				var num = $(this).attr('num');
				vosSum += Number($(this).text().replace(/\,/g,''));
			});	  
			$('#vosSum').text(vosSum.toLocaleString());				// ,넣어준다
			//부가세 합계
			$('.vat').each(function(){ 
				var num = $(this).attr('num');
				vatSum += Number($(this).text().replace(/\,/g,''));
			});	  
			$('#vatSum').text(vatSum.toLocaleString());				// ,넣어준다
		}	
	});
</script>
</head>
<body>
<h3>판매상세조회</h3>
<form id="infoForm" action = "${pageContext.request.contextPath}/sale/returnSale.do" method="post">
<div id="infoBox">
		<input type="hidden" name="sal_no" value="${saleVO.sal_no}">
		<input type="hidden" name="sal_dt" value="${saleVO.sal_dt}">
		<ul>
			<li>
				<label class="two">매장</label>
				<input type="text" name="prt_cd" value="${saleVO.prt_cd}" readonly>
				<input type="text" name="prt_nm" value="${saleVO.prt_nm}" readonly>
			</li>
			<li>
				<label>고객번호</label>
				<input type="text" name="cust_no" value="${saleVO.cust_no}" readonly>
				<input type="text" name="cust_nm" value="${saleVO.cust_nm}" readonly>
			</li>
			<li>
				<label>판매수량</label>
				<input type="text" name="tot_sal_qty" value="${saleVO.tot_sal_qty}" readonly>
			</li>
			<li>
				<label>판매금액</label>
				<input type="text" name="tot_sal_amt" id="tot_sal_amt" value="${saleVO.tot_sal_amt}" readonly>
			</li>
			<li>
				<label class="two">현금</label>
				<input type="text" name="csh_stlm_amt" id="csh_stlm_amt" value="${saleVO.csh_stlm_amt}" readonly>
			</li>
			<li>
				<label class="two">카드</label>
				<input type="text" name="crd_stlm_amt" id="crd_stlm_amt" value="${saleVO.crd_stlm_amt}" readonly>
			</li>
		</ul>
	
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
						<td class="qty">${sale.sal_qty}</td>
						<td class="vos">${sale.sal_vos_amt}</td>
						<td class="vat">${sale.sal_vat_amt}</td>
						<td class="amt">${sale.sal_amt}</td>
					
					</tr>
			</c:forEach>
		</tbody>
			<tr id="sumTr">
				<td colspan="3">합계</td>
				<td id="qtySum"></td>
				<td id="vosSum"></td>
				<td id="vatSum"></td>
				<td id="amtSum"></td>

				
			</tr>
	</Table>
</div>

<div id="resultBtn">
		<input type="button" id="closeBtn" value="닫기">
		<c:if test="${saleVO.sal_tp_cd eq 'SAL' and prt_dt_cd eq '2' and (saleVO.org_shop_cd eq '' or saleVO.org_shop_cd eq 'null')}">
			<input type="submit" id="refundBtn" value="반품">
		</c:if>
</div>
</form>
</body>
</html>