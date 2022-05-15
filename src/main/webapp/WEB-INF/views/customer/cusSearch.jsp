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
		
		//리스트 기본 값 초기화
		function init(){
			$('#cTbody').empty();
		}
		
		//중복체크 막기
		$(document).on('click','.checkbox',function(){													
			if($(this).prop('checked')){																	//체크박스에 체크한 경우 전에 체크한 것은 풀리고 새로운것에 체크적용.
		    	  $('.checkbox').prop('checked',false);
		    	  $(this).prop('checked',true);
			    	cust_no = $(this).parent().parent().find('td').find('span').eq(0).text();				//변수에 체크한 값의 항목 할당.
			    	cust_nm = $(this).parent().parent().find('td').find('span').eq(1).text();
		      }
		});	
		//창 종료
		$('#closeForm').click(function(){
			self.close();
		});
		
		//팝업 결과 본문에 반영
		$('#resultBtn').click(function(){
			if(cust_no.length==0){															//체크하지 않은 경우 제출 안됨.
				alert('값을 선택하세요');
				return false;
			}else{																			//체크한 값을 본 페이지의 각 부분에 할당.
				$(opener.document).find('#cust_no').val(cust_no);
/* 		 		 $(opener.document).find('#cust_nm').val(cust_nm); */
		 		$(opener.document).find('#sCust_nm').val(cust_nm);
					self.close();
			}
			
 		  
		  });  
		//더블클릭 시 본문에 반영하고 창 닫기
		$(document).on('dblclick','.checkTr',function(){										//행 더블클릭 시  더블클릭한 행의 값 변수에 할당하고 본문에 적용
			var custNo = $(this).find('td').find('span').eq(0).text();
			var custNm = $(this).find('td').find('span').eq(1).text();
			$(opener.document).find('#cust_no').val(custNo);
/* 	 		 $(opener.document).find('#cust_nm').val(custNm); */
	 		$(opener.document).find('#sCust_nm').val(custNm);
				self.close();
		});

		//팝업 내 검색 결과
		$('#submitCus').click(function(event){
			
			var cust_nm = $('#cust_nm').val().trim();
			var mbl_no = $('#mbl_no').val().trim();
			
			if(cust_nm.length==0 && mbl_no.length==0){							//검색어가 입력되지 않은 경우
				 alert('검색어를 입력하세요');
					return false;
			 };
			 if(cust_nm.length ==1){											//이름은 두글자 이상 입력 제한
				 alert('이름을 두글자 이상 입력하세요');
				 $('#cust_nm').focus();
					return false;
			 };
			var output ="";
			$.ajax({																//비동기로 검색값 전송해서 list받아옴.
				type:'post',
				data:{cust_nm:cust_nm,mbl_no:mbl_no},
				url: '${pageContext.request.contextPath}/customer/customerResult.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					var count = param.customerCount;
					if(count<=0){
						output+="<tr><td colspan='5'>검색 결과가 존재하지 않습니다.</td></tr>";
					}else if(count>0){																//list가 존재하면 테이블에 결과 넣어줌.
						$(param.customer).each(function(index,item) {
							
							output += '<tr class="checkTr">';
							output +='<td><input type="checkbox" name="checkbox" class="checkbox"></td>';
							output +='<td><span>'+item.cust_no+'</span></td>';
							output +='<td><span>'+item.cust_nm+'</span></td>';
							output += '<td><span>'+item.mbl_no+'</span></td>';
							output += '<td>'+item.cust_ss_cd+'</td>';
							output += '</tr>';
					
					});
					
				}else{
					alert(param.error)
				}
					init();
					$('#cTbody').append(output);
					
			},
			error:function(){
				alert('네트워크 오류 발생');
			}	
			});				//ajax 끝	
			//submit이벤트 삭제
			event.preventDefault();
		});
									

		//테이블 mouseover
		$(document).on('mouseover','.checkTr',function(){
			$(this).css('backgroundColor', '#ebf2fc');
		});
		$(document).on('mouseout','.checkTr',function(){
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

<div class="cusList">
	<table id="cusTable">
		<thead>
		<tr>
			<th>선택</th>
			<th>고객번호</th>
			<th>고객명</th>
			<th>핸드폰번호</th>
			<th>고객상태</th>
		</tr>
		</thead>
		<tbody id="cTbody">
		</tbody>
	</table>
</div>

<div class="align-center">
	<input type="button" value="닫기" id="closeForm">
	<input type="submit" value="적용" id="resultBtn">
</div>
</body>
</html>