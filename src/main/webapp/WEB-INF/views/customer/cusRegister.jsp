<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규고객등록</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var check = 0;			// 휴대폰번호 중복체크 확인. 0이면 확인 안하거나 중복. 1이면 확인. 중복 안됨. 
		//창 종료
		$('#closeForm').click(function(){
			self.close();
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
						alert('이미 가입된 번호입니다.');
					}else{
						alert('네트워크 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});	
			
		});
		
		//생년월일 미래 날짜 안됨
		
		//제출 시 체크 (고객명 2자 이상, 필수항목, 휴대폰 번호 중복)
		$('#regBtn').click(function(){
			if(check==0){
				alert('휴대폰 번호 중복 확인 해주세요.');
				return false;
			}
		});
		
	});	
</script>
</head>
<body>
<div>
	<h2>신규고객등록</h2>
	<h4>고객기본정보</h4>
	<form action="${pageContext.request.contextPath}/customer/registerSubmit.do" method="post" id="registerForm">
		<div class="infoBox">
			<ul>
				<li>
					<label for="cust_nm">고객명</label>
					<input type="text" id="cust_nm" name="cust_nm">
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
					<label for="brdy_dt">생년월일</label>
					<input type="date" id="brdy_dt">
				</li>
				<li>
					<label for="sex_cd">성별</label>
					<input type="radio" name="sex_cd" value="F" checked>여성
					<input type="radio" name="sex_cd" value="M">남성
				</li>
				<li>
					<label for="mbl_no">휴대폰번호</label>
					<input type="text" id="mbl_no1">
					<input type="text" id="mbl_no2">
					<input type="text" id="mbl_no3">
					<input type="button" value="확인" id="chMbl">
				</li>
				<li>
					<label for="scal_yn">생일</label>
					<input type="radio" name="scal_yn" value="0" checked>양력
					<input type="radio" name="scal_yn" value="1">음력
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
					<label for="mrrg_dt">결혼기념일</label>
					<input type="date" id="mrrg_dt">
				</li>
				<li>
					<label>매장</label>
					<input type="text" id="prt_cd" value="${prt_cd}">
					<input type="text" id="prt_nm" value="${prt_nm}">
				</li>
			</ul>
		</div>
		<div class="ynBox">
			<ul>
				<li>
					<label for="email_rcv_yn">이메일수신동의</label>
					<input type="radio" name="email_rcv_yn" value="Y">예
					<input type="radio" name="email_rcv_yn" value="N" checked>아니오
				</li>
					<li>
					<label for="sms_rcv_yn">SMS수신동의</label>
					<input type="radio" name="sms_rcv_yn" value="Y">예
					<input type="radio" name="sms_rcv_yn" value="N" checked>아니오
				</li>
					<li>
					<label for="dm_rcv_yn">DM수신동의</label>
					<input type="radio" name="dm_rcv_yn" value="Y">예
					<input type="radio" name="dm_rcv_yn" value="N" checked>아니오
				</li>
			</ul>
		</div>
		<div>
			<input type="button" id="closeForm" value="닫기">
			<input type="submit" id="regBtn" value="등록">
		</div>
	</form>
</div>
</body>
</html>