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
<script type="text/javascript">

	$(document).ready(function(){
		//반품인 경우 빨간색 처리
		$('.RTN').css('color','red');
		
		//리스트 기본 값 초기화
		function init(){
			$('#saleTbody').empty();
		}
		
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
		
		//상세페이지 이동
		$(document).on('click','.detBtn',function(){
			window.open('${pageContext.request.contextPath}/sale/saleDetailPopup.do','sale','width=1000,height=600');
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
							output += '<tr>';
							output += '<td>'+item.sal_dt+'</td>';
							output += '<td>'+item.cust_no+'</td>';
							output += '<td>'+item.cust_nm+'</td>';
							output += '<td>'+item.sal_no+'<input type="button" class="detBtn" value="상세"></td>';
							output += '<td class="'+item.sal_tp_cd+'">'+item.tot_sal_qty+'</td>';
							output += '<td class="'+item.sal_tp_cd+'">'+item.tot_sal_amt+'</td>';
							output += '<td>'+item.csh_stlm_amt+'</td>';
							output += '<td>'+item.crd_stlm_amt+'</td>';
							output += '<td>'+item.pnt_stlm_amt+'</td>';
							output += '<td>'+item.fst_user_id+'</td>';
							output += '<td>'+item.sFst_reg_dt+'</td>';
							output += '</tr>';
					});
				}else{
					alert(error);
				}
					init();
					$('#saleTbody').append(output);
					$('.RTN').css('color','red');
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});//ajax 끝
			event.preventDefault();
			
			
		});
		
	});
</script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div id='wrapper'>
	<h3>고객판매관리</h3>
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
					<input type="text" id="prt_cd" name="prt_cd" value="${prt_cd }">
					<img id="searchMarket" class="searchIcon" alt="매장조회" src="${pageContext.request.contextPath}/images/search.png" >
					<input type="text" id="prt_nm" name="prt_nm" value="${prt_nm }">
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
	<div id="btnDiv">
		<button id="registBtn">판매등록</button>
	</div>
	<div id="saleList">
		<table id="saleTable">
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
			<tbody id="saleTbody">
				<c:if test="${count<=0 }">
					<tr>
						<td colspan='11'>검색 결과가 존재하지 않습니다.</td>
					</tr>
				</c:if>
					<c:forEach var="sale" items="${saleList}">
					<tr>
						<td>${sale.sal_dt}</td>
						<td>${sale.cust_no}</td>
						<td>${sale.cust_nm}</td>
						<td>${sale.sal_no}<input type="button" class="detBtn" value="상세"></td>
						<td class="${sale.sal_tp_cd}">${sale.tot_sal_qty}</td>
						<td class="${sale.sal_tp_cd}">${sale.tot_sal_amt}</td>
						<td>${sale.csh_stlm_amt}</td>
						<td>${sale.crd_stlm_amt}</td>
						<td>${sale.pnt_stlm_amt}</td>
						<td>${sale.fst_user_id}</td>
						<td>${sale.sFst_reg_dt}</td>
					</tr>
					</c:forEach>
			</tbody>
		</table>
	
	</div>
</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>