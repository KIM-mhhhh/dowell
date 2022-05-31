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
		
		$('#prd_cd').focus();
		
		//오늘 날짜 구하는 함수
		var getToday = function(){
			var date = new Date();

			var year = date.getFullYear();
			var month = date.getMonth();
			month += 1;
			if (month <= 9){
				 month = "0" + month;
			}
			var day = date.getDate();
			if (day <= 9){
			   day = "0" + month;
			}
			var today = year + '-' + month + '-' + day;
					
			return today;
				} 
		//판매일자에 오늘의 날짜 고정
		$('#sal_dt').val(getToday());
		
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//매장 재고 팝업
		$(document).on('click','.stockBtn',function(){
		
			var num = $(this).attr('num');
			window.open('${pageContext.request.contextPath}/sale/openStock.do?num='+num+'','stock','_blank','width=700,height=900');
		});
		
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
		
		//행 추가
		$('#plusRow').click(function(){
			var seq = ($('#regTable >#salTbody tr').length)+1

			//새 행 추가
			$('#salTbody').append(
			"<tr><td><input type='checkbox' id='checkBox'></td>"
			+ "<td>"+seq+"</td>"
			+ "<td><input type='text' id='prd_cd"+seq+"'><img id='stockBtn' num='"+seq+"' class='searchIcon stockBtn' alt='재고검색' src='${pageContext.request.contextPath}/images/search.png'></td>"
			+ "<td id='prd_nm"+seq+"'></td>"
			+ "<td id='ivco_qty"+seq+"'></td>"
			+ "<td><input type='text' class='sal_qty' num='"+seq+"' id='sal_qty"+seq+"'></td>"
			+ "<td id='prd_csmr_upr"+seq+"'></td>"
			+ "<td id='cost"+seq+"'></td></tr>"
			)
		});
		//행 삭제
		$('#minusRow').click(function(){
			if($('#salTbody tr').length<2){
				return false;
			}
			$('#salTbody tr:last').remove();
		});
		//상품코드를 입력하고 엔터치면 정보 불러와서 해당 행에 입력>> 미래테그로.
		$('#prd_cd').keydown(function(key){
			if (key.keyCode == 13) {		//엔터키를 누르면
				var prd_cd = $(this).val();
				var prt_cd = $('#prt_cd').val();
				alert(prd_cd);
            }
		}) ;
		//판매금액 계산
		$(document).on('change','.sal_qty',function(){
			var sal_qty = $(this).val();
			var num = $(this).attr('num');
			var prd_csmr_upr = $('#prd_csmr_upr'+num).text();
			var cost = sal_qty * prd_csmr_upr;
			$('#cost'+num).text(cost);
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
				<input type="date" id="sal_dt" readonly >
			</li>
			<li>
				<label>판매구분</label>
				<select name="sal_tp_cd" id="sal_tp_cd">
					<option disabled value="0">전체</option>
					<option value="1" selected>판매</option>
				</select>
			</li>
			<li>
				<label>고객번호</label>
				<input type="text" id="cust_no">
				<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
				<input type="text" id="cust_nm">
			</li>
		</ul>
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
	<input type="button" id="plusRow" value="+">
	<input type="button" id="minusRow" value="-">
</div>
<div id="regList">
	<table id="regTable">
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>매장재고</th>
				<th>판매수량</th>
				<th>소비자단가</th>
				<th>판매금액</th>
			</tr>
		</thead>
		<tbody id="salTbody">
			<tr>
				<td><input type="checkbox" id="checkBox"></td>
				<td id="rowCount">1</td>
				<td><input type="text" id="prd_cd1"><img id="stockBtn" num="1" class="searchIcon stockBtn" alt="재고검색" src="${pageContext.request.contextPath}/images/search.png"></td>
				<td id="prd_nm1"></td>
				<td id="ivco_qty1"></td>
				<td><input type="text" id="sal_qty1" num="1" class="sal_qty"></td>
				<td id="prd_csmr_upr1"></td>
				<td id="cost1"></td>
			</tr>
		</tbody>
	</table>
	
</div>
<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="button" id="submitBtn" value="적용">
</div>
</body>
</html>