<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
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
		addComm();
		//가격에 , 넣기
		function addComm(){
			$('.prd_csmr_upr').each(function(){
				var org = Number($(this).text());
//				alert($(this).text());
				$(this).text(org.toLocaleString());
			});
		}
		
		//체크박스 x
		function nonCheck(thing,value){
			
			thing.each(function(){
				if($(this).text()==value){
					var num=$(this).attr('num');
					$('#checkBox'+num).attr('disabled',true);
				}
			});
		}
		//재고목록 가져오기
		$('#searchBtn').click(function(event){
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
								
								if(item.prd_tp_cd == '20'){
									output +='';
								}else{
									output += '<tr class="checkTr">';
									output +='<td><input type="checkbox" class="checkBox '+item.prd_ss_cd+'" num="'+index+'" id="checkBox'+index+'"></td>';
		 							output +='<td class="prd_cd" id="prd_cd'+index+'">'+item.prd_cd+'</td>';
									output +='<td class="prd_nm" id="prd_nm'+index+'">'+item.prd_nm+'</td>';
									output +='<td class="stock" id="stock'+index+'" num="'+index+'" class="stock">'+item.ivco_qty+'</td>'; 
									output +='<td class="prd_csmr_upr" num="'+index+'" id="prd_csmr_upr'+index+'">'+item.prd_csmr_upr+'</td>';
									output +='</tr>';
								}
								
/* 								output += '<tr class="checkTr">';
								output +='<td><input type="checkbox" class="checkBox '+item.prd_ss_cd+'" num="'+index+'" id="checkBox'+index+'"></td>';
	 							output +='<td class="prd_cd" id="prd_cd'+index+'">'+item.prd_cd+'</td>';
								output +='<td class="prd_nm" id="prd_nm'+index+'">'+item.prd_nm+'</td>';
								output +='<td class="stock" id="stock'+index+'" num="'+index+'" class="stock">'+item.ivco_qty+'</td>'; 
								output +='<td class="prd_csmr_upr" num="'+index+'" id="prd_csmr_upr'+index+'">'+item.prd_csmr_upr+'</td>';
								output +='</tr>'; */
	
							}); 	
						}else{
							alert('네트워크 오류 발생');
						}
						init();
						$('#listTbody').append(output);
						//재고가 0인경우 체크박스 선택 불가능
						nonCheck($('.stock'),'0');
						//소비자가가 0 이면 선택 불가능
						nonCheck($('.prd_csmr_upr'),'0');
						$('.C').attr('disabled',true);
						$('.C').parent().parent().css('backgroundColor','#fcf5a2');
						addComm();
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});		//ajax끝
				//submit이벤트 삭제
				event.preventDefault();		
				

		});				//재고 검색 이벤트 끝		
		 //중복체크 막기
		$(document).on('click','.checkBox',function(){
			if($(this).prop('checked')){															//체크되어 있으면 다른 체크되어있던 것 풀리게
		    	  $('.checkBox').prop('checked',false);
		    	  $(this).prop('checked',true);
		       }
		});	

		if($('.putBtn')){
			$('#searchBtn').click();
		}


		//체크하고 적용 시 원문에 적용
		$('#submitBtn').click(function(){
			var num =  $(".checkBox:checked").attr('num');
			var prd_cd = $('#prd_cd'+num).text();
			var prd_nm = $('#prd_nm'+num).text();
			var ivco_qty = $('#stock'+num).text();
			var prd_csmr_upr = $('#prd_csmr_upr'+num).text();
			var rowNum = $('#rowNum').val();
//			alert(rowNum);
//			alert(prd_cd);
			if(prd_cd.length==0){											//체크하지않은 경우 적용 안됨.
				alert('값을 선택하세요');
				return false;
			}else{															//체크한 경우 본 페이지의 prt_cd와 prt_nm에 해당 값 넣고 닫음.
				var leng = $(opener.document).find('#regTable >#salTbody tr').length;
				for(var i=1;i<=leng;i++){
					if( $(opener.document).find('#prd_cd'+i).val() == prd_cd && (i!=rowNum)){
//						alert('중복선택:' + prd_cd + '/비교 :'+ $(opener.document).find('#prd_cd'+i).val());
						alert('이미 선택한 물품입니다.');
						return false;
					}
				}
//						alert('선택한것:' + prd_cd + '/비교 :'+ $(opener.document).find('#prd_cd'+i).val());
						$(opener.document).find('#prd_cd'+rowNum).val(prd_cd);
						$(opener.document).find('#prd_nm'+rowNum).val(prd_nm);
						$(opener.document).find('#ivco_qty'+rowNum).val(ivco_qty);
						$(opener.document).find('#sal_qty'+rowNum).val('');
						$(opener.document).find('#sal_amt'+rowNum).val('');
						$(opener.document).find('#prd_csmr_upr'+rowNum).val(prd_csmr_upr);
						$(opener.document).find('#checkBox'+rowNum).prop('checked',false);
						opener.parent.$.getSum();
							self.close();
					
				
			}
		  });
		
	});		//document 끝
</script>
</head>
<body>
<h3>매장재고조회</h3>
<div class="searBox">
	<form id="stockForm">
		<input type="hidden" id="rowNum" value="${num}">
		<input type="hidden" id="prt_cd" value="${prt_cd}">
		<div id="textDiv">
			<ul>
				<li>
					<label>매장</label>
					<input type="text" id="prt_keyword" readonly value="${prt_nm }">
				</li>
				<li>
					<label>상품(코드+명)</label>
					<input type="text" id="prd_keyword">
				</li>
			</ul>
		</div>
		<div id="stockBtnDiv">
			<button id="searchBtn"><span class="material-icons">search</span></button>
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