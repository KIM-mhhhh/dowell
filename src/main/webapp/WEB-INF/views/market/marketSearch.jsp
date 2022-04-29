<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/popSearch.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function(){
		var prt_cd = "";
		var prt_nm = "";
		//중복체크 막기
		$(document).on('click','.checkbox',function(){
			if($(this).prop('checked')){
		    	  $('.checkbox').prop('checked',false);
		    	  $(this).prop('checked',true);
		    	prt_cd = $(this).parent().parent().find('td').find('span').eq(0).html();
		    	prt_nm = $(this).parent().parent().find('td').find('span').eq(1).html();
		      }
		});	
		//닫기 버튼
		$('#closeForm').click(function(){
			self.close();
		});
		 //팝업 내용 본문에 적용
		$('#resultBtn').click(function(){
			if(prt_cd ==""){
				alert('값을 선택하세요');
				return false;
			}else{
				$(opener.document).find('#prt_cd').val(prt_cd);
		 		 $(opener.document).find('#prt_nm').val(prt_nm);
					self.close();
			}
 		  
		  });  
		//더블클릭 시 본문에 반영하고 창 닫기
		$(document).on('dblclick','.checkTr',function(){
			var custNo = $(this).find('td').find('span').eq(0).html();
			var custNm = $(this).find('td').find('span').eq(1).html();
			$(opener.document).find('#prt_cd').val(custNo);
	 		 $(opener.document).find('#prt_nm').val(custNm);
				self.close();
		});
		
		//검색창 빈칸인 경우 작동 안되게.
	/* 	$('#submitCus').click(function(){
		 if($('#keyword').val().trim()==''){
			 alert('검색어를 입력하세요');
			 $('#keyword').focus();
				$('#keyword').val('');
				return false;
		 }
		}); */
		
		//팝업 내 검색 결과
		$('#submitCus').click(function(event){
			var keyword = $('#keyword').val().trim();
			if(keyword.length==0){
				alert('검색어를 입력하세요');
				$('#keyword').focus();
				$('#keyword').val('');
					return false;
			}
			var count;
			var output ="";
			$.ajax({
				type:'post',
				data:{keyword:keyword},
				url: '${pageContext.request.contextPath}/market/marketResult.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					count = param.marketCount;
					if(count<=0){
						output+="<div>검색 결과가 존재하지 않습니다.</div>";
					}else{
						output+='<table id="marketTable">';
						output+='<tr>';
						output+='<th>선택</th>';
						output+='<th>매장코드</th>';
						output+='<th>매장명</th>';
						output+='<th>매장상태</th>';
						output+='</tr>';
						$(param.market).each(function(index,item) {
							
							output += '<tr class="checkTr">';
							output +='<td><input type="checkbox" name="checkbox" class="checkbox"></td>';
							output +='<td><span>'+item.prt_cd+'</span></td>';
							output +='<td><span>'+item.prt_nm+'</span></td>';
							output += '<td>'+item.prt_ss_cd+'</td>';
							output += '</tr>';
					
					});
						output+='</table>';
					
				};
					init();
					$('.marketList').append(output);
					
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
			$('.marketList').empty();
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
<h4>매장조회</h4>
<div>
	<form action="marketResult.do" method="post" id="marketForm" >
		<div>
			<label for="market">매장</label>
			<input type="text" id="keyword" autofocus>
		</div>
		<div class="mkBtn">
			<button id="submitCus"><span class="material-icons">search</span></button>
		</div>
	</form>
</div>

<div class="marketList" >
	<table id="marketTable">
		<tr>
			<th>선택</th>
			<th>매장코드</th>
			<th>매장명</th>
			<th>매장상태</th>
		</tr>
		<%-- <c:forEach var="market" items="${marketList}">
		<tr class="checkTr">
			<td><input type="checkbox" name="checkbox" class="checkbox"></td>
			<td><span>${market.prt_cd }</span></td>
			<td><span>${market.prt_nm }</span></td>
			<td>${market.prt_ss_cd}</td>
		</tr>
		</c:forEach> --%>
	</table>
</div>

<div class="align-center">
	<input type="button" value="닫기" id="closeForm">
	<input type="button" value="적용" id="resultBtn">
</div>
</body>
</html>