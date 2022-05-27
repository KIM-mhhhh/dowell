<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
		//리스트 기본 값 초기화
		function init(){
			$('#listTbody').empty();
		}
		
		//검색해서 재고 가져오기
		$('#searchBtn').click(function(event){
			if($('#prt_keyword').val().trim().length<=0){
				alert('매장을 입력하세요.');
				return false;
			}else{
				var prt_keyword = $('#prt_keyword').val();
				var prd_keyword = $('#prd_keyword').val();
				var output ="";
				$.ajax({
					type:'post',
					data:{prt_keyword:prt_keyword,prd_keyword:prd_keyword},
					url: '${pageContext.request.contextPath}/sale/searchStock.do',
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.count<=0){
							output+="<tr><td colspan='5'>검색 결과가 존재하지 않습니다.</td></tr>";
						}else if(param.count>0){
							$(param.stockList).each(function(index,item) {
								output += '<tr class="checkTr">';
								output +='<td><input type="checkbox" id="checkBox'+index+'"></td>';
	 							output +='<td>'+item.prd_cd+'</td>';
								output +='<td>'+item.prd_nm+'</td>';
								output += '<td id="stock'+index+'">'+item.ivco_qty+'</td>'; 
								output += '<td>'+item.prd_csmr_upr+'</td>';
								output += '</tr>';
/* 
								if($('#stock'+index).val()=='0'){
									$('#checkBox'+index).prop('disabled',true);
								} */
							}); 
						}else{
							alert('네트워크 오류 발생');
						}
						init();
						$('#listTbody').append(output);
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});		//ajax끝
				//submit이벤트 삭제
				event.preventDefault();
			}	
		});				//재고 검색 이벤트 끝
		
		
	});
</script>
</head>
<body>
<h3>매장재고조회</h3>
<div class="searchBox">
	<form>
		<ul>
			<li>
				<label>매장</label>
				<input type="text" id="prt_keyword">
			</li>
			<li>
				<label>상품(코드+명)</label>
				<input type="text" id="prd_keyword">
			</li>
		</ul>
		<div>
			<button id="searchBtn">검색</button>
		</div>
	</form>
</div>

<div id="stockList">
	<table id="stockTable">
		<thead>
			<tr>
				<th>선택</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>재고수량</th>
				<th>소비자가</th>
			</tr>
		</thead>
		<tbody id="listTbody">
			
		</tbody>
	</table>
</div>

<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="button" id="submitBtn" value="적용">
</div>
</body>
</html>