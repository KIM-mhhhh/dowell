<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/popSearch.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function(){
		var cust_no = "";
		var cust_nm = "";
		//중복체크 막기
		$(document).on('click','.checkbox',function(){
			if($(this).prop('checked')){
		    	  $('.checkbox').prop('checked',false);
		    	  $(this).prop('checked',true);
			    	cust_no = $(this).parent().parent().find('td').find('span').eq(0).html();
			    	cust_nm = $(this).parent().parent().find('td').find('span').eq(1).html();
		      }
		});	
		//창 종료
		$('#closeForm').click(function(){
			self.close();
		});
		
		//팝업 결과 본문에 반영
		$('#resultBtn').click(function(){
			if(cust_no==""){
				alert('값을 선택하세요');
				return false;
			}else{
				$(opener.document).find('#cust_no').val(cust_no);
		 		 $(opener.document).find('#cust_nm').val(cust_nm);
					self.close();
			}
			
 		  
		  });  
		//더블클릭 시 본문에 반영하고 창 닫기
		$(document).on('dblclick','.checkTr',function(){
			var custNo = $(this).find('td').find('span').eq(0).html();
			var custNm = $(this).find('td').find('span').eq(1).html();
			$(opener.document).find('#cust_no').val(custNo);
	 		 $(opener.document).find('#cust_nm').val(custNm);
				self.close();
		});
		//검색창 빈칸인 경우 작동 안되게.
		/* $('#submitCus').click(function(){
		 if($('#cust_nm').val().trim()=='' || $('#mbl_no').val().trim()==''){
			 alert('검색어를 입력하세요');
				return false;
		 };
		 if($('#cust_nm').val().length =1){
			 alert('이름을 두글자 이상 입력하세요');
			 $('#cust_nm').focus();
				return false;
		 };
		}); */
		
		//팝업 내 검색 결과
		$('#submitCus').click(function(event){
			
			var cust_nm = $('#cust_nm').val().trim();
			var mbl_no = $('#mbl_no').val().trim();
			
			if(cust_nm.length==0 && mbl_no.length==0){
				 alert('검색어를 입력하세요');
					return false;
			 };
			 if(cust_nm.length ==1){
				 alert('이름을 두글자 이상 입력하세요');
				 $('#cust_nm').focus();
					return false;
			 };
			
			var count;
			var output ="";
				output+='<table class="list">';
				output+='<tr>';
				output+='<th>선택</th>';
				output+='<th>고객번호</th>';
				output+='<th>고객명</th>';
				output+='<th>핸드폰번호</th>';
				output+='<th>고객상태</th>';
				output+='</tr>';
			$.ajax({
				type:'post',
				data:{cust_nm:cust_nm,mbl_no:mbl_no},
				url: '${pageContext.request.contextPath}/customer/customerResult.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					count = param.customerCount;
					if(count<=0){
						output+="<div>검색 결과가 존재하지 않습니다.</div>";
					}else{
						$(param.customer).each(function(index,item) {
							
							output += '<tr class="checkTr">';
							output +='<td><input type="checkbox" name="checkbox" class="checkbox"></td>';
							output +='<td><span>'+item.cust_no+'</span></td>';
							output +='<td><span>'+item.cust_nm+'</span></td>';
							output += '<td><span>'+item.mbl_no+'</span></td>';
							output += '<td>'+item.cust_ss_cd+'</td>';
							output += '</tr>';
					
					});
						output+='</table>';
					
				};
					init();
					$('.list').append(output);
					
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
			});				//ajax 끝	
			//submit이벤트 삭제
			event.preventDefault();
		});
									
		//리스트 기본 값 초기화
		function init(){
			$('.list').empty();
		}
		//테이블 mouseover
		$(document).on('mouseover','tr',function(){
			$(this).css('backgroundColor', '#ebf2fc');
		});
		$(document).on('mouseout','tr',function(){
			$(this).css('backgroundColor', 'white');
		});
		
	});
</script>
</head>
<body>
<h2>고객조회</h2>

<div>
	<form method="post" id="cusForm">
		<div>
			<input type="text" id="cust_nm" name="cust_nm" placeholder="고객명" >
			<input type="text" id="mbl_no" name="mbl_no" placeholder="핸드폰번호">
		</div>
		<div>
			<button id="submitCus"><span class="material-icons">search</span></button>
		</div>
	</form>
</div>

<div class="list">
	<table>
		<tr>
			<th>선택</th>
			<th>고객번호</th>
			<th>고객명</th>
			<th>핸드폰번호</th>
			<th>고객상태</th>
		</tr>
	<%-- 	<c:forEach var="customer" items="${custList }">
		<tr class="checkTr">
			<td><input type="checkbox" class="checkbox" name="checkbox"></td>
			<td><span>${customer.cust_no }</span></td>
			<td><span>${customer.cust_nm}</span></td>
			<td>${customer.mbl_no}</td>
			<td>${customer.cust_ss_cd}</td>
		</tr>
		</c:forEach> --%>
	</table>
</div>

<div class="align-center">
	<input type="button" value="닫기" id="closeForm">
	<input type="submit" value="적용" id="resultBtn">
</div>
</body>
</html>