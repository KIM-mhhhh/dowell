<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객정보조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
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
			    day = "0" + month;
			}
			var today = year + '-' + month + '-' + day;
			return today;
		}
		
/*  		if($(":radio[name='cust_ss_cd'][value='10']").is(':checked')){		//정상이면 중지만 가능하게
 			$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
			$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', true);
			$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', false);
		}
 		if($(":radio[name='cust_ss_cd'][value='80']").is(':checked')){		//중지면 해지만 가능하게
			$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', false);
			$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', false);
			$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', true);
		}
		if($(":radio[name='cust_ss_cd'][value='90']").is(':checked')){		//해지면 정상만 가능하게
			$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', false);
			$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
			$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', true);
		}  */
		
		//고객번호 검색 클릭시 고객검색 팝업
		$('#searchCust').click(function(){
			if($('#cust_no').val().length<=0){	//고객번호칸이 빈칸이면 고객검색 팝업 연다
				window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','market','width=700,height=900');
			}else{
				alert('ajax로 고객명 가져오기');
			}
		});
		
		//고객조회 검색시 정보 가져와서 반영
		$('#submitBtn').click(function(event){
			if($('#cust_no').val().length<=0){
				alert('고객번호를 입력하세요.');
				return false;
			}else{
				$('#infoForm')[0].reset();
				$.ajax({
					type:'post',
					data:{cust_no:$('#cust_no').val()}, 	
					url:'${pageContext.request.contextPath}/customer/getCustInfo.do', 
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						 
							$('#cust_nm').val(param.customer.cust_nm);
 							$('#brdy_dt').val(param.customer.brdy_dt);
							$('#mrrg_dt').val(param.customer.mrrg_dt);
							$('#addr').val(param.customer.addr);
							$('#addr_dtl').val(param.customer.addr_dtl);
							$('#mbl_no').val(param.customer.mbl_no);
							$('#fst_js_dt').val(param.customer.fst_js_dt);
							$('#js_dt').val(param.customer.js_dt);
							$('#cncl_cnts').val(param.customer.cncl_cnts);
							$('#stp_dt').val(param.customer.stp_dt);
							$('#cncl_dt').val(param.customer.cncl_dt); 
							$('input:radio[name =sex_cd]:input[value='+param.customer.sex_cd+']').attr("checked", true);
							$('input:radio[name =cust_ss_cd]:input[value='+param.customer.cust_ss_cd+']').attr("checked", true);
							$('input:radio[name =psmt_grc_cd]:input[value='+param.customer.psmt_grc_cd+']').prop("checked");
							$('input:radio[name =email_rcv_yn]:input[value='+param.customer.email_rcv_yn+']').prop("checked");
							$('input:radio[name =sms_rcv_yn]:input[value='+param.customer.sms_rcv_yn+']').prop("checked");
							$('input:radio[name =dm_rcv_yn]:input[value='+param.customer.dm_rcv_yn+']').prop("checked");

					},
					error:function(error){
						alert(error);
					}
				});	
			}
			event.preventDefault();
		});
		//휴대폰번호 중복 확인
		 $('#chMbl').click(function(){
			if($('#mbl_no1').val().length==0 || $('#mbl_no2').val().length==0 || $('#mbl_no3').val().length==0){
				alert('빈칸을 입력하세요.');
				return false;
			}
			var mbl_no = $('#mbl_no1').val() + $('#mbl_no2').val() + $('#mbl_no3').val();
			$.ajax({
				type:'post',
				data:{mbl_no:mbl_no}, 	
				url: '${pageContext.request.contextPath}/customer/checkMbl.do', 
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result=='NotDuplicated'){
						alert('사용가능한 번호입니다.');
						check=1;
					}else if(param.result=='Duplicated'){
						alert('동일한 번호가 있습니다. / '+ mbl_no);
					}else{
						alert('네트워크 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});		//ajax 끝
		});
		//해지버튼
 		$(":radio[name='cust_ss_cd'][value='90']").click(function(){
 			$('#cncl_cnts').attr("readonly",false);
 			$('#cncl_cnts').focus();
 			$('#cust_nm').val('해지고객');
 			$('#mbl_no1').val('000');
 			$('#mbl_no2').val('0000');
 			$('#mbl_no3').val('0000');
 			$('#cncl_dt').val(getToday())
 		});
		//중지버튼
		$(":radio[name='cust_ss_cd'][value='80']").click(function(){
 			$('#stp_dt').val(getToday());
 		});
 		//정상버튼
 		$(":radio[name='cust_ss_cd'][value='10']").click(function(){
 			$('#cncl_cnts').attr("readonly",true);
 			$('#cncl_cnts').val('');
 			$('#cust_nm').val('');
 			$('#mbl_no1').val('');
 			$('#mbl_no2').val('');
 			$('#mbl_no3').val('');
 			$('#cncl_dt').val('');
 			$('#stp_dt').val('');
 			$('#js_dt').val(getToday());
 		});

		//정보 변경 후 다른 고객 조회 시 변경된 내용 있다고 알리기
		
		//저장버튼 클릭 시 휴대폰번호 변경버튼 안눌렀으면 버튼확인하라고, 필수항목 검사. 창 띄우고 yes면 저장.
		$('#confBtn').click(function(){
			var yn = confirm("고객정보를 수정하시겠습니까?");
			alert(yn);
		});
		//닫기 버튼 누르면 다시 복귀
		 $('#closeBtn').click(function(){
			window.location.href="";
		}); 
		
		
	});
</script>
</head>
<body>
<h2>고객정보조회</h2>
<div class="searchBox">
<form method="post" id="searchForm">
	<label for="">고객번호</label>
	<input type="text" id="cust_no" value="${cust_no }" >
	<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
	<input type="text"  id="sCust_nm">
	<div class="submitBtn">
			<button id="submitBtn"><span class="material-icons">search</span></button>
	</div>
</form>
</div>

<div>
	<form action="" method="post" id="infoForm">
	<h4>고객기본정보</h4>
		<div class="infoBox">
			<ul>
				<li>
					<label for="cust_nm">고객명</label>
					<input type="text" id="cust_nm">
				</li>
				<li>
					<label for="brdy_dt">생년월일</label>
					<input type="date" id="brdy_dt">
				</li>
				<li>
					<label for="sex_cd">성별</label>
					<input type="radio" name="sex_cd" value="F" checked>여성
					<input type="radio" name="sex_cd" value="M">남성
				</li>
				<li>
					<label for="scal_yn">생일</label>
					<input type="radio" name="scal_yn" value="0" checked>양력
					<input type="radio" name="scal_yn" value="1">음력
				</li>
				<li>
					<label for="mrrg_dt">결혼기념일</label>
					<input type="date" id="mrrg_dt">
				</li>
				<li>
					<label for="poc_cd">직업코드</label>
					<select name="poc_cd">
						<c:forEach var="code" items="${codeList }">
							<option value="${code.DTL_CD }">${code.DTL_CD_NM }</option>
						</c:forEach>

					</select>
				</li>
				<li>
					<label for="mbl_no">휴대폰번호</label>
					<input type="text" id="mbl_no1">
					<input type="text" id="mbl_no2">
					<input type="text" id="mbl_no3">
					<input type="button" value="확인" id="chMbl">
				</li>
				<li>
					<label for="prt_cd">가입매장</label>
					<input type="text" id="prt_cd" >
					<input type="text" id="prt_nm" >
				</li>
				<li>
					<label for="psmt_grc_cd">우편물수령</label>
					<input type="radio" name="psmt_grc_cd" value="H" checked>자택
					<input type="radio" name="psmt_grc_cd" value="O">직장
				</li>
				<li>
					<label for="email">이메일</label>
					<input type="text" id="email1">
					<span>@</span>
					<input type="text" id="email2">
				</li>
				<li>
					<label for="addr">주소</label>
					<input type="text" id="addr">
					<input type="text" id="addr_dtl">
				</li>
				<li>
					<label>고객상태</label>
					<input type="radio" name="cust_ss_cd" value="10" checked> 정상
					<input type="radio" name="cust_ss_cd" value="80"> 중지
					<input type="radio" name="cust_ss_cd" value="90"> 해지
				</li>
				<li>
					<label for="fst_js_dt">최초가입일자</label>
					<input type="text" id="fst_js_dt">
				</li>
				<li>
					<label for="js_dt">가입일자</label>
					<input type="text" id="js_dt">
				</li>
				<li>
					<label for="cncl_cnts">해지사유</label>
					<input type="text" id="cncl_cnts" readonly>
				</li>
				<li>
					<label for="stp_dt">중지일자</label>
					<input type="text" id="stp_dt">
				</li>
				<li>
					<label for="cncl_dt">해지일자</label>
					<input type="text" id="cncl_dt">
				</li>
			</ul>
		</div>
		<h4>구매</h4>
		<div class="calBox">
			<ul>
				<li>
					<label for="">총구매금액</label>
					<input type="text" id="">
				</li>
				<li>
					<label for="">당월구매금액</label>
					<input type="text" id="">
				</li>
				<li>
					<label for="">최종구매일</label>
					<input type="text" id="">
				</li>
			</ul>
		</div>
		<h4>수신동의(통합)</h4>
		<div class="ynBox">
			<ul>
				<li>
					<label for="email_rcv_yn">이메일수신동의</label>
					<input type="radio" name="email_rcv_yn" value="Y" checked>예
					<input type="radio" name="email_rcv_yn" value="N">아니오
				</li>
				<li>
					<label for="sms_rcv_yn">SMS수신동의</label>
					<input type="radio" name="sms_rcv_yn" value="Y" checked>예
					<input type="radio" name="sms_rcv_yn" value="N">아니오
				</li>
				<li>
					<label for="dm_rcv_yn">DM수신동의</label>
					<input type="radio" name="dm_rcv_yn" value="Y" checked>예
					<input type="radio" name="dm_rcv_yn" value="N">아니오
				</li>
			</ul>
		</div>
		<div class="btn">
			<input type="button" id="closeBtn" value="닫기">
			<c:if test="${prt_dt_cd eq '2'}">
				<input type="button" id="confBtn" value="저장">
			</c:if>
		</div>
	</form>
</div>
</body>
</html>