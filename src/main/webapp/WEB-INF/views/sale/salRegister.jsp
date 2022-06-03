<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

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
			   day = "0" + day;
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
			+ "<td><input type='text' class='prd_cd' num='"+seq+"'  name='prd_cd' id='prd_cd"+seq+"'><img id='stockBtn' num='"+seq+"' class='searchIcon stockBtn' alt='재고검색' src='${pageContext.request.contextPath}/images/search.png'></td>"
			+ "<td><input type='text' name='prd_nm' id='prd_nm"+seq+"'></td>"
			+ "<td><input type='text' name='ivco_qty' id='ivco_qty"+seq+"'></td>"
			+ "<td><input type='text' name='sal_qty' class='sal_qty' num='"+seq+"' id='sal_qty"+seq+"'></td>"
			+ "<td><input type='text' name='prd_csmr_upr' id='prd_csmr_upr"+seq+"'></td>"
			+ "<td><input type='text' name='sal_amt' id='sal_amt"+seq+"'></td></tr>"
			)
		});
		//행 삭제
		$('#minusRow').click(function(){
			if($('#salTbody tr').length<2){
				return false;
			}
			$('#salTbody tr:last').remove();
		});
		//상품코드를 입력하고 엔터치면 ajax로 정보 불러와서 해당 행에 입력>> 미래테그로.
		$(document).on('keydown','.prd_cd',function(key){
			if (key.keyCode == 13) {		//엔터키를 누르면
				var prd_keyword = $(this).val();
				var prt_keyword = $('#prt_cd').val();
				var num = $(this).attr('num');
//				alert(prd_keyword + "/" + prt_keyword);
				$.ajax({
					type:'post',
					data:{prt_keyword:prt_keyword,prd_keyword:prd_keyword},
					url: '${pageContext.request.contextPath}/sale/searchStock.do',
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.count<=0){
							alert('검색 결과가 존재하지 않습니다.');
						}else if(param.count==1){
							if(param.stockList[0].ivco_qty <=0){
								alert('재고가 없습니다.');
								$('#prd_cd'+num).val('').focus();
							}else if(param.stockList[0].prd_csmr_upr <=0){
								alert('소비자단가가 없습니다.');
								$('#prd_cd'+num).val('').focus();
							}else if(param.stockList[0].prd_ss_cd == 'C'){
								alert('상품상태가 정상이 아닙니다.');
								$('#prd_cd'+num).val('').focus();
							}else{
								$('#prd_nm'+num).val(param.stockList[0].prd_nm);
								$('#ivco_qty'+num).val(param.stockList[0].ivco_qty);
								$('#prd_csmr_upr'+num).val(param.stockList[0].prd_csmr_upr);
							}
						}else{
							var output='';
							$(param.stockList).each(function(index,item) {
								output += '<tr class="checkTr">';
								output +='<td><input type="checkbox" class="checkBox '+item.prd_ss_cd+'" num="'+index+'" id="checkBox'+index+'"></td>';
	 							output +='<td class="prd_cd" id="prd_cd'+index+'">'+item.prd_cd+'</td>';
								output +='<td class="prd_nm" id="prd_nm'+index+'">'+item.prd_nm+'</td>';
								output +='<td id="stock'+index+'" num="'+index+'" class="stock">'+item.ivco_qty+'</td>'; 
								output +='<td class="prd_csmr_upr" num="'+index+'" id="prd_csmr_upr'+index+'">'+item.prd_csmr_upr+'</td>';
								output +='</tr>';	
							});
							
							//팝업창 오픈
							var option = 'width=650, height=500, top=50, left=50, location=no';
							var openPrdPop = window.open('${pageContext.request.contextPath}/sale/openStock.do?num='+num+'', 'stockpopup', option);      
							      
							openPrdPop.onload = function(){
								openPrdPop.document.getElementById("prd_keyword").value = $('#prd_cd'+num).val();
/* 							  var tbody =  openPrdPop.document.getElementById("listTbody");
							  tbody.innerHTML+=output; */
							  openPrdPop.document.getElementById("searchBtn").classList.add("putBtn");
							  

							}
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});		//ajax끝

            }
		}) ;
		//판매금액 계산
		$(document).on('change','.sal_qty',function(){
			var sal_qty = $(this).val();
			var num = $(this).attr('num');
			var prd_csmr_upr = $('#prd_csmr_upr'+num).val();
			var cost = sal_qty * prd_csmr_upr;
			$('#sal_amt'+num).val(cost);
		});
		
		//test
 		$('#submitBtn').click(function(e){
 			$('#crd_no').val($('#crd_no1').val()+$('#crd_no2').val()+$('#crd_no3').val()+$('#crd_no4').val());
 			
 			var arr = [];
			  $('#regTable tr').each(function() {
				  var form = $('#registerForm').clone();
				  var tmp = $(this).closest('tr').clone();
			    if ( $(this).find('input[type=checkbox]').is(':checked') ) {
			      var tmp = $(this).clone();
			      form.append(tmp);
			      var formData = form.serializeObject();
			      arr.push(JSON.stringify(formData));
			      form.empty();
			    }
			    
			});
			  console.log(arr);
			  
 			  $.ajax({
					url: "${pageContext.request.contextPath}/sale/registerSale.do",
					type: "post",
					traditional: true,	// ajax 배열 넘기기 옵션!
 					/* contentType:"application/json; charset=UTF-8", */  
					data:{arr:arr},
					dataType: "json",
					success: function (data) {
						if(data.result=='success'){
							alert('성공!');
						}else{
							alet('실패!');
						}
					},
					error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); 	//ajax끝
			  e.preventDefault();
			  
			 
		}); 	  
		
	});
</script>
</head>
<body>
<h4>고객판매수금등록</h4>
<form id="registerForm" action="${pageContext.request.contextPath}/sale/registerSale.do" method="post">
<div class="searchBox">
		<input type="hidden" id="prt_cd" value="${prt_cd}">
		<ul>
			<li>
				<label for="sal_dt">판매일자</label>
				<input type="date" name="sal_dt" id="sal_dt" readonly >
			</li>
			<li>
				<label>판매구분</label>
				<select name="sal_tp_cd" id="sal_tp_cd">
					<option disabled value="0">전체</option>
					<option value="1"  selected>판매</option>
				</select>
			</li>
			<li>
				<label>고객번호</label>
				<input type="text" name="cust_no" id="cust_no">
				<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
				<input type="text" name="cust_nm" id="cust_nm">
			</li>
		</ul>
	
</div>
<h5>결제금액</h5>
<div id="costBox">
	<ul>
		<li>
			<label>현금</label>
			<input type="text" name="csh_stlm_amt" id="csh_stlm_amt">
		</li>
		<li>
			<label>카드금액</label>
			<input type="text" name="crd_stlm_amt" id="crd_stlm_amt">
		</li>
		<li>
			<label>유효일자</label>
			<input type="text" name="vld_ym" id="vld_ym">
		</li>
		<li>
			<label>카드회사</label>
			<input type="text" name="crd_co_cd" id="crd_co_cd">
		</li>
		<li>
			<label>카드번호</label>
			<input type="hidden" name="crd_no" id="crd_no">
			<input type="text" id="crd_no1">
			<input type="text" id="crd_no2">
			<input type="text" id="crd_no3">
			<input type="text" id="crd_no4">
		</li>
	</ul>
</div>
</form>
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
				<td><input type="text" name="prd_cd" num="1" class="prd_cd" id="prd_cd1"><img id="stockBtn" num="1" class="searchIcon stockBtn" alt="재고검색" src="${pageContext.request.contextPath}/images/search.png"></td>
				<td><input type="text" name="prd_nm" id="prd_nm1"></td>
				<td><input type="text" name="ivco_qty" id="ivco_qty1"></td>
				<td><input type="text" name="sal_qty" id="sal_qty1" num="1" class="sal_qty"></td>
				<td><input type="text" name="prd_csmr_upr" id="prd_csmr_upr1"></td>
				<td><input type="text" name="sal_amt" id="sal_amt1"></td>
			</tr>
		</tbody>
		<tr id="sumTr">
				<td colspan="5">합계</td>
				<td id="qtySum">판매수량합계</td>
				<td></td>
				<td id="costSum">판매금액 함계</td>
			</tr>
	</table>
	
</div>
<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="button" id="checkBtn" value="test">
	<input type="submit" id="submitBtn" value="적용">
</div>

</body>
</html>