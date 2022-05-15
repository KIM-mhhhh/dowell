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
		 
		 
		//리스트 기본 값 초기화
		function init(){
			$('#mTbody').empty();
		}
		 
		 //중복체크 막기
		$(document).on('click','.checkbox',function(){
			if($(this).prop('checked')){															//체크되어 있으면 다른 체크되어있던 것 풀리게
		    	  $('.checkbox').prop('checked',false);
		    	  $(this).prop('checked',true);
				     	prt_cd = $(this).parent().parent().find('td').find('span').eq(0).text();	//체크된 항목의 prtcd와 prtnm 저장
				    	prt_nm = $(this).parent().parent().find('td').find('span').eq(1).text(); 
		       }
		});	
		//닫기 버튼
		$('#closeForm').click(function(){
			self.close();
		});
		 //팝업 내용 본문에 적용
		$('#resultBtn').click(function(){
			if(prt_cd.length==0){											//체크하지않은 경우 적용 안됨.
				alert('값을 선택하세요');
				return false;
			}else{															//체크한 경우 본 페이지의 prt_cd와 prt_nm에 해당 값 넣고 닫음.
				$(opener.document).find('#prt_cd').val(prt_cd);
				$(opener.document).find('#jn_prt_cd').val(prt_cd);
		 		 $(opener.document).find('#prt_nm').val(prt_nm);
					self.close();
			}
		  });  
		 
		//더블클릭 시 본문에 반영하고 창 닫기
		$(document).on('dblclick','.checkTr',function(){						//해당 행을 더블클릭하면 그 행의 값들을 변수에 할당하고 그 변수를 본 페이지에 적용.
			var prt_cd = $(this).find('td').find('span').eq(0).text();
			var prt_nm = $(this).find('td').find('span').eq(1).text();
			$(opener.document).find('#prt_cd').val(prt_cd);
			$(opener.document).find('#jn_prt_cd').val(prt_cd);
	 		 $(opener.document).find('#prt_nm').val(prt_nm);
				self.close();
		});
		
		//팝업 내 검색 결과
		$('#submitCus').click(function(event){													//제출버튼 클릭 시 
			var keyword = $('#keyword').val().trim();				
			if(keyword.length==0){																//값이 없으면 제출 안됨.
				alert('검색어를 입력하세요');
				$('#keyword').focus();
				$('#keyword').val('');
					return false;
			}
			var output ="";
			$.ajax({																					//비동기 ajax로 검색어를 보내고 해당하는 list를 받아옴.
				type:'post',
				data:{keyword:keyword},
				url: '${pageContext.request.contextPath}/market/marketResult.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){																//받아오는 게 성공하는 경우 table의 tbody에 적용
					var count = param.marketCount;
					if(count<=0){																	
						output+="<tr><td colspan='5'>검색 결과가 존재하지 않습니다.</td></tr>";
					}else if(count>0){
				 		$(param.market).each(function(index,item) {
							output += '<tr class="checkTr">';
							output +='<td><input type="checkbox" name="checkbox" class="checkbox"></td>';
 							output +='<td><span>'+item.prt_cd+'</span></td>';
							output +='<td><span>'+item.prt_nm+'</span></td>';
							output += '<td>'+item.prt_ss_cd+'</td>'; 
							output += '</tr>';
						}); 
					}else{
						alert(param.error);
					};
					init();
					$('#mTbody').append(output);		
				},
				error:function(){																			//가져오는 과정에서 오류 발생 시 창 띄움.
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
		<thead>
		<tr>
			<th>선택</th>
			<th>매장코드</th>
			<th>매장명</th>
			<th>매장상태</th>
		</tr>
		</thead>
		<tbody id="mTbody">
		</tbody>
	</table>
</div>

<div class="align-center">
	<input type="button" value="닫기" id="closeForm">
	<input type="button" value="적용" id="resultBtn">
</div>
</body>
</html>