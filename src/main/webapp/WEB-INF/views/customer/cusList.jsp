<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/cusList.css" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//리스트 기본 값 초기화
		function init(){
			$('#mTbody').empty();
		}
		//매장 검색 팝업
		$('#searchMarket').click(function(){
			window.open('${pageContext.request.contextPath}/market/marketShow.do','market','width=500,height=600');
		});
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//신규회원 등록 팝업
		$('#cusInsert').click(function(){
			window.open('${pageContext.request.contextPath}/customer/cusRegist.do','market','width=700,height=900');
		});
		//회원 수정 이력 팝업
	 	$(document).on('click','.recBtn',function(){
			var cust_no = $(this).parent().eq(0).find('span').text();
			window.open('${pageContext.request.contextPath}/customer/showRecord.do?cust_no='+cust_no,'record','width=900,height=700');
		}); 
		//회원 상세정보 이동
		$(document).on('click','.detBtn',function(){
			 var cust_no = $(this).parent().parent().find('#cusNo>span').text(); 
			location.href="${pageContext.request.contextPath}/customer/showCustomer.do?cust_no="+cust_no
		});
		
		//달력 기본값
		$('#to').val(new Date().toISOString().substring(0, 10));
		var now = new Date();	// 현재 날짜 및 시간
		/* var before = new Date(now.setDate(now.getDate() - 7));	// 일주일 전 */
		$('#from').val(new Date(now.setDate(now.getDate() - 7)).toISOString().substring(0, 10));
		
		//전체 검색결과 ajax로 보내고 목록 받아오기
		$('#submitCus').click(function(event){

			var count;
			var output ="";
			var prt_cd = $('input[name="prt_cd"]').val().trim();
			var prt_nm = $('input[name="prt_nm"]').val().trim();
			var cust_no = $('input[name="sCust_no"]').val().trim();
			var cust_nm = $('input[name="sCust_nm"]').val().trim();
			var cust_ss_cd =$('input[name="cust_ss_cd"]:checked').val();
			var from = $('input[name="from"]').val().replace(/\-/g,'');
			var to = $('input[name="to"]').val().replace(/\-/g,'');
			
			if(from>to){																//from의 숫자가 to보다 큰 경우 제출 안됨.
				alert('선택하신 날짜가 범위에 맞지 않습니다.');
				return false;
			}
			    
			$.ajax({																	//ajax로 검색값 보낸 후 list 가져온다. 
				type:'post',
				data:{prt_cd:prt_cd, prt_nm:prt_nm,cust_no:cust_no,cust_nm:cust_nm, cust_ss_cd:cust_ss_cd,from:from,to:to }, 	
				url: '${pageContext.request.contextPath}/customer/mainCustomer.do', 
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					count = param.count;
					if(count<=0){																		
						output+="<tr><td colspan='8'>검색 결과가 존재하지 않습니다.</td></tr>";
					}else if(count>0){																			//list 결과값이 있는 경우 table에 append해서 적용.
						$(param.list).each(function(index,item) {
							output += '<tr>';
							output +="<td id='cusNo'><span>"+item.cust_no+"</span><input type='button' class='recBtn' value='변경이력'></td>";
						//	output +="<td id='cusNo'><span id='cusNo"+index+"'>"+item.cust_no+"</span><input type='button' class='recBtn' value='변경이력' onclick='recordPopupOpen("+index+")'></td>";
							output +='<td id="cusNm"><span>'+item.cust_nm+'</span><input type="button" class="detBtn" value="상세"></td>';
							output += '<td><span>'+item.mbl_no+'</span></td>';
							output += '<td>'+item.cust_ss_cd+'</td>';
							output += '<td>'+item.js_dt+'</td>';
							output += '<td id="regM">'+item.prt_nm+'</td>';
							output += '<td id="regP">'+item.fst_user_id+'/'+item.user_nm+'</td>';
							output += '<td>'+item.sLst_upd_dt+'</td>';
							output += '</tr>';
					});
				}else{
					alert(error)
				}
					init();
					$('#mTbody').append(output);
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});//ajax 끝
			event.preventDefault();

		});		//click이벤트 끝 
		
		//테이블 mouseover, mouseout 효과
		$(document).on('mouseover','#mainTable tr',function(){
			$(this).css('backgroundColor', '#ebf2fc');
		});
		$(document).on('mouseout','#mainTable tr',function(){
			$(this).css('backgroundColor', 'white');
		});
		
		//캘린더 날짜 제한
	 	$('#from').click(function(){								//from값이 최대값을 to 값으로
			var originTo = $('#to').val();
			$(this).attr('max', originTo);
		});
		$('#to').click(function(){									//to값에 최소값을 from으로
			var fromD = $('#from').val();
			var originto = $(this).val();
			$(this).attr('min', fromD);
		
		}); 
			
		//캘린더 정규식
 	 	function checkValidDate(value) {										//캘린더 정규식. 날짜 가져와서 적용.
			var result = true;
			try {
			    var date = value.split("-");
			    var y = parseInt(date[0], 10),
			        m = parseInt(date[1], 10),
			        d = parseInt(date[2], 10);
			    
	   			var dateRegex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
	   				 result = dateRegex.test(d+'-'+m+'-'+y);
				} catch (err) {
					result = false;
				}    
			    return result;
		};  
	
		
		$('#from').keydown(function(key){
			if (key.keyCode == 13) {		//엔터키를 누르면
				//날짜 정규식
				var date = $('input[name="from"]').val();
				if(checkValidDate(date)){
					
				}else{													//정규식에 맞지 않는 경우
					alert('유효하지 않음');
					return false;
				}
            }

		}) ;
		
		//매장명으로 엔터쳐서 넣기
/* 		$('#prt_nm').keydown(function(key){
			if (key.keyCode == 13) {											//엔터키를 누르면
				if($(this).val().trim().length>0){								//빈칸이 아니면 검색해서 매장 가져온다.
					
					alert($(this).val());
					 $.ajax({
						type:'post',
						data:{prt_nm:$('#prt_nm').val()}, 	
						url: '${pageContext.request.contextPath}/market/enterMarket.do', 
						dataType:'json',
						contentType:'application/x-www-form-urlencoded; charset=UTF-8',
						cache:false,
						timeout:30000,
						success:function(param){
							
						},
						error:function(request,status,error) {
		                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});			//ajax끝 
				}else{
					alert('매장명을 입력하세요.');
				}
		
            }

		}) ; */
		
	});							//document 끝
	

	
	
	//index 사용해서 아이디 줘서 대상 찾기. (나중에 해보기)
	/* function recordPopupOpen(index){
		var cust_no = $('#cusNo'+index).text();
		window.open('${pageContext.request.contextPath}/customer/showRecord.do?cust_no='+cust_no,'record','width=900,height=700');
	} */
	
</script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div id='wrapper'>
<div class="side">
	<jsp:include page="/WEB-INF/views/common/side.jsp"/>
</div>
<div class="align-right">
	<ul id="gnb">
	<c:if test="${! empty id}">
		<li>${name }님</li>
		<li><a href="${pageContext.request.contextPath}/user/logout.do">로그아웃</a></li>
	</c:if>	
	</ul>
</div>
<div class="body">
<h4>고객조회 <img alt="새로고침" src="${pageContext.request.contextPath}/images/reload.png" onclick="window.location.reload()"></h4>

<div>
	<form method="post" id="mainForm">
		<ul class="fullSearch">
			<li>
				<label for="prt_cd">매장</label>
				<c:if test="${prt_dt_cd eq '2'}">
					<input type="text" id="prt_cd" name="prt_cd" value="${market.prt_cd }">
				</c:if>
				<c:if test="${prt_dt_cd eq '1'}">
					<input type="text" id="prt_cd" name="prt_cd">
				</c:if>
					<img id="searchMarket" class="searchIcon" alt="매장조회" src="${pageContext.request.contextPath}/images/search.png" >
				<c:if test="${prt_dt_cd eq '2'}">
					<input type="text" id="prt_nm" name="prt_nm"  value="${market.prt_nm }">
				</c:if>
				<c:if test="${prt_dt_cd eq '1'}">
					<input type="text" id="prt_nm" name="prt_nm" >
				</c:if>
			</li>
			<li>
				<label for="cust_no">고객</label>
				<input type="text" id="sCust_no" name="sCust_no">
					<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
				<input type="text" id="sCust_nm" name="sCust_nm">
			</li>
			<li>
				<label>*고객상태</label>
				<input type="radio" name="cust_ss_cd" value="0" checked> 전체
				<c:forEach var="code" items="${codeList }">
					<input type="radio" name="cust_ss_cd" value="${code.DTL_CD }"> ${code.DTL_CD_NM }
				</c:forEach>
			</li>
			<li>
				<label>*가입일자</label>
				<input type="date" name="from" id="from" >
				<input type="date" name="to" id="to" >
			</li>
		</ul>
		<div class="submitBtn">
			<button id="submitCus" type="button" ><span class="material-icons">search</span></button>
		</div>
	</form>
</div>
<c:if test="${prt_dt_cd eq '2'}">
<div class="btn">
<input type="button" id="cusInsert" value="신규등록">
</div>
</c:if>
<div id="mainList">
	<table id="mainTable">
		<thead>
		<tr>
			<th>고객번호</th>
			<th>고객이름</th>
			<th>휴대폰번호</th>
			<th>고객상태</th>
			<th>가입일자</th>
			<th>가입매장</th>
			<th>등록자</th>
			<th>수정일자</th>
		</tr>
		</thead>
		<tbody id="mTbody">
			<c:if test="${count<=0 }">
				<tr>
					<td colspan='8'>검색 결과가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="customer" items="${custList}">
			<tr>
				<td id="cusNo"><span>${customer.cust_no}</span><input type="button" class="recBtn" value="변경이력"></td>
				<td id="cusNm"><span>${customer.cust_nm}</span><input type="button" class="detBtn" value="상세"></td>
				<td>${customer.mbl_no}</td>
				<td>${customer.cust_ss_cd}</td>
				<td>${customer.js_dt}</td>
				<td id="regM">${customer.prt_nm}</td>
				<td id="regP">${customer.fst_user_id}/${customer.user_nm}</td>
				<td>${customer.sLst_upd_dt}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>

</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>