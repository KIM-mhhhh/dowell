<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객판매관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		//반품인 경우 빨간색 처리
		$('.RTN').css('color','red');
		
		//본사는 매장 검색 가능. 매장인경우 불가능. 
		if(${prt_dt_cd} =='2'){
			$('.prt').attr('readonly',true).css('backgroundColor','#c9c9c9');
		}
		
		//리스트 기본 값 초기화
		function init(){
			$('#saleTbody').empty();
		}
		getSum();
		//합계
 		function getSum() {
			// 합계 계산
			var sum = 0;
			var cdSum = 0;
			var pntSum = 0;
			var qtySum = 0;
			var amtSum = 0;
			
			//구매수량 합계
			$('.qty').each(function(){ //클래스가 cash인 항목의 갯수만큼 진행
				var num = $(this).attr('num');
				if($('#sal_tp_cd'+num).text() == 'SAL'){
					qtySum += Number($(this).text());
				}else{
					qtySum -= Number($(this).text());
				}
			});	 
			$('#qtySum').text(qtySum);	
			
			//구매가격 합계
			$('.amt').each(function(){ 
				var num = $(this).attr('num');
				if($('#sal_tp_cd'+num).text() == 'SAL'){
					amtSum += Number($(this).text());
				}else{
					amtSum -= Number($(this).text());
				} 
			});	  
			$('#amtSum').text(amtSum.toLocaleString());				// ,넣어준다
			
			//현금결제액 합계
			$('.cash').each(function(){ 
				var num = $(this).attr('num');
				if($('#sal_tp_cd'+num).text() == 'SAL'){
					sum += Number($(this).text()); 
				}else{
					sum -= Number($(this).text()); 
				} 	
			});	  
			$('#cshSum').text(sum.toLocaleString());				// ,넣어준다
			
			//카드결제액 합계
			$('.card').each(function(){ 
				var num = $(this).attr('num');
				if($('#sal_tp_cd'+num).text() == 'SAL'){
					cdSum += Number($(this).text()); 
				}else{
					cdSum -= Number($(this).text());
				} 		 
			});	
			$('#crdSum').text(cdSum.toLocaleString());
			//포인트결제액 합계
			$('.pnt').each(function(){ 
				var num = $(this).attr('num');
				if($('#sal_tp_cd'+num).text() == 'SAL'){
					pntSum += Number($(this).text()); 
				}else{
					pntSum -= Number($(this).text()); 
				} 		
			});	
			$('#pntSum').text(pntSum.toLocaleString());
				  
		} 
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//매장 검색 팝업
		$('#searchMarket').click(function(){
			if(${prt_dt_cd} =='2'){					//매장인 경우 클릭 불가
				return false;
			}else{									//본사인 경우 가능. 팝업창 띄우기
				window.open('${pageContext.request.contextPath}/market/marketShow.do','market','width=500,height=600');
			}
		
		});
		//고객판매수금등록 팝업
		$('#registBtn').click(function(){
			window.open('${pageContext.request.contextPath}/sale/registShow.do','sale','width=1000,height=600');
		});
		
		//상세페이지 이동		
 		$(document).on('click','.detBtn',function(){
 			var num = $(this).attr('num');
 			
 			//이미 반품한 제품인지 체크
 			$('.RTN').each(function(){
 				var rNum = $(this).attr('num');
 				var org_shop = $('#org_shop_cd'+rNum).text();
 	 			var org_no = $('#org_sal_no'+rNum).text();
 	 			var org_dt = $('#org_sal_dt'+rNum).text();
 	 			
 	 			if(org_shop == $('#sPrt_cd'+num).text() ){
 	 				if(org_no == $('#sal_no'+num).text() ){
 						if(org_dt == $('#sal_dt'+num).text().replace(/\-/g,'')){
 							$('#org_shop_cd'+num).text('already');
 						}
 	 	 			}
 	 			} 
				
 			});
 			
 			var sal_dt = $('#saleTr'+num).children().eq(0).text().replace(/\-/g,'');
 			var cust_no = $('#saleTr'+num).children().eq(1).text();
 			var cust_nm = $('#saleTr'+num).children().eq(2).text();
 			var sal_no = $('#saleTr'+num).children().eq(3).text();
 			var tot_sal_qty = $('#saleTr'+num).children().eq(4).text();
 			var tot_sal_amt = $('#saleTr'+num).children().eq(5).text();
 			var csh_stlm_amt = $('#saleTr'+num).children().eq(6).text();
 			var crd_stlm_amt = $('#saleTr'+num).children().eq(7).text();
 			var pnt_Stlm_amt = $('#saleTr'+num).children().eq(8).text();
 			var prt_cd = $('#saleTr'+num).children().eq(11).text();
 			var sal_tp_cd = $('#saleTr'+num).children().eq(12).text();
 			var org_shop_cd = $('#saleTr'+num).children().eq(13).text();
 			
 			var info={
 				sal_dt:sal_dt,
 				cust_no:cust_no,
 				cust_nm:cust_nm,
 				sal_no:sal_no,
 				tot_sal_qty:tot_sal_qty,
 				tot_sal_amt:tot_sal_amt,
 				csh_stlm_amt:csh_stlm_amt,
 				crd_stlm_amt:crd_stlm_amt,
 				pnt_Stlm_amt:pnt_Stlm_amt,
 				prt_cd:prt_cd,
 				sal_tp_cd:sal_tp_cd,
 				org_shop_cd: org_shop_cd
 			}
 			
 			openPopulPost('${pageContext.request.contextPath}/sale/saleDetailPopup.do', info);	
		});
		
		//달력 기본값
		$('#to').val(new Date().toISOString().substring(0, 10));
		var now = new Date();	// 현재 날짜 및 시간
		$('#from').val(new Date(now.setDate(now.getDate() - 7)).toISOString().substring(0, 10));
		
		//검색해서 조건에 맞는 list가져오기
		$('#searchBtn').click(function(event){

			var count;
			var output ="";
			
			var prt_cd = $('#prt_cd').val().trim();
			var cust_no = $('#sCust_no').val().trim();
			var from = $('input[name="from"]').val().replace(/\-/g,'');
			var to = $('input[name="to"]').val().replace(/\-/g,'');
			if(from == '' || to == ''){
				alert('날짜를 선택하세요.');
				return false;
			}
			if(from>to){																//from의 숫자가 to보다 큰 경우 제출 안됨.
				alert('선택하신 날짜가 범위에 맞지 않습니다.');
				return false;
			}
			
			$.ajax({																	//ajax로 검색값 보낸 후 list 가져온다. 
				type:'post',
				data:{prt_cd:prt_cd,cust_no:cust_no,from:from,to:to }, 	
				url: '${pageContext.request.contextPath}/sale/searchSaleList.do', 
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					count = param.count;
					if(count<=0){																		
						output+="<tr><td colspan='11'>검색 결과가 존재하지 않습니다.</td></tr>";
					}else if(count>0){																			//list 결과값이 있는 경우 table에 append해서 적용.
						$(param.saleList).each(function(index,item) {
							output += '<tr id="saleTr'+index+1+'">';
							output += '<td id="sal_dt'+index+1+'">'+item.sal_dt+'</td>';
							output += '<td>'+item.cust_no+'</td>';
							output += '<td>'+item.cust_nm+'</td>';
							output += '<td id="sal_no'+index+1+'">'+item.sal_no+'<input type="button" class="detBtn" num="'+index+1+'" value="상세"></td>';
							output += '<td class="'+item.sal_tp_cd+' qty" num="'+index+1+'">'+item.tot_sal_qty+'</td>';
							output += '<td class="'+item.sal_tp_cd+' amt" num="'+index+1+'">'+item.tot_sal_amt+'</td>';
							output += '<td class="cash" num="'+index+1+'">'+item.csh_stlm_amt+'</td>';
							output += '<td class="card" num="'+index+1+'">'+item.crd_stlm_amt+'</td>';
							output += '<td class="pnt" num="'+index+1+'">'+item.pnt_stlm_amt+'</td>';
							output += '<td>'+item.user_nm+'</td>';
							output += '<td>'+item.sFst_reg_dt+'</td>';
							output += '<td style="display:none" id="sPrt_cd'+index+1+'" >'+item.prt_cd+'</td>';
							output += '<td style="display:none" id="sal_tp_cd'+index+1+'">'+item.sal_tp_cd+'</td>';
							output += '<td style="display:none" id="org_shop_cd'+index+1+'">'+item.org_shop_cd+'</td>';
							output += '<td style="display:none" id="org_sal_dt'+index+1+'">'+item.org_sal_dt+'</td>';
							output += '<td style="display:none" id="org_sal_no'+index+1+'">'+item.org_sal_no+'</td>';
							output += '</tr>';
					});
				}else{
					alert(error);
				}
					init();
					$('#saleTbody').append(output);
					$('.RTN').css('color','red');

					getSum();
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});//ajax 끝
			event.preventDefault();	
		});
	});		//document 끝
	
	//post로 popup 실행
	function openPopulPost(url, data) {
		
		window.open("", "sale", "directories=no,titlebar=no,toolbar=no,status=no,menubar=no, location=no,width=850, height=700, scrollbars=yes");

	    var form = document.createElement("form");
	    form.target = "sale";
	    form.method = "POST";
	    form.action = url;
	    form.style.display = "none";
	 
	    for (var key in data) {
	        var input = document.createElement("input");
	        input.type = "hidden";
	        input.name = key;
	        input.value = data[key];
	        form.appendChild(input);
	    }
	 
	    document.body.appendChild(form);
	    form.submit();
	    document.body.removeChild(form);
	}
</script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div id='wrapper'>
	<h3>고객판매관리<img alt="새로고침" src="${pageContext.request.contextPath}/images/reload.png" onclick="window.location.reload()"></h3>
	<div class="searchBox">
		<form>
			<ul>
				<li>
					<label for="sal_dt">판매일자</label>
					<input type="date" id="from" name="from">
					<input type="date" id="to" name="to">
				</li>
				<li>
					<label>매장</label>
					<input type="text" class="prt" id="prt_cd" name="prt_cd" value="${prt_cd }">
					<img id="searchMarket" class="searchIcon prt" alt="매장조회" src="${pageContext.request.contextPath}/images/search.png" >
					<input type="text" class="prt" id="prt_nm" name="prt_nm" value="${prt_nm }">
				</li>
				<li>
					<label>고객번호</label>
					<input type="text" id="sCust_no">
					<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
					<input type="text" id="sCust_nm">
				</li>
			</ul>
			<div>
				<button id="searchBtn"><span class="material-icons">search</span></button>
			</div>
			
		</form>
	</div>
<c:if test="${prt_dt_cd eq '2'}">	
	<div id="btnDiv">
		<button id="registBtn">판매등록</button>
	</div>
</c:if>
	<div id="saleList">
		<table id="saleTable">
			<thead>
				<tr>
					<th rowspan="2">판매일자</th>
					<th rowspan="2">고객번호</th>
					<th rowspan="2">고객명</th>
					<th rowspan="2">판매번호</th>
					<th colspan="2">판매</th>
					<th colspan="3">수금</th>
					<th rowspan="2">등록자</th>
					<th rowspan="2">등록시간</th>
				</tr>
				<tr>
					<th>수량</th>
					<th>금액</th>
					<th>현금</th>
					<th>카드</th>
					<th>포인트</th>
				</tr>
			</thead>
			<tbody id="saleTbody">
				<c:if test="${count<=0 }">
					<tr>
						<td colspan='11'>검색 결과가 존재하지 않습니다.</td>
					</tr>
				</c:if>
					<c:forEach var="sale" items="${saleList}" varStatus="status">
					<tr id="saleTr${status.index }">
						<td id="sal_dt${status.index }">${sale.sal_dt}</td>
						<td>${sale.cust_no}</td>
						<td>${sale.cust_nm}</td>
						<td id="sal_no${status.index }">${sale.sal_no}<input type="button" class="detBtn" num=${status.index } value="상세"></td>
						<td class="${sale.sal_tp_cd} qty" num=${status.index }>${sale.tot_sal_qty}</td>
						<td class="${sale.sal_tp_cd} amt" num=${status.index }>${sale.tot_sal_amt}</td>
						<td class="cash" num=${status.index }>${sale.csh_stlm_amt}</td>
						<td class="card" num=${status.index }>${sale.crd_stlm_amt}</td>
						<td class="pnt" num=${status.index }>${sale.pnt_stlm_amt}</td>
						<td>${sale.user_nm}</td>
						<td>${sale.sFst_reg_dt}</td>
						<td style="display:none" id="sPrt_cd${status.index }">${sale.prt_cd}</td>
						<td style="display:none" id="sal_tp_cd${status.index }">${sale.sal_tp_cd}</td>
						<td style="display:none" id="org_shop_cd${status.index }">${sale.org_shop_cd}</td>
						<td style="display:none" id="org_sal_dt${status.index }">${sale.org_sal_dt}</td>
						<td style="display:none" id="org_sal_no${status.index }">${sale.org_sal_no}</td>
					</tr>
					</c:forEach>
			</tbody>
			<tr id="sumTr">
				<td colspan="4">합계</td>
				<td id="qtySum"></td>
				<td id="amtSum"></td>
				<td id="cshSum"></td>
				<td id="crdSum"></td>
				<td id="pntSum"></td>
				<td colspan="2"></td>
				
			</tr>
		</table>
	</div>

</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>