<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규고객등록</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//창 종료
		$('#closeForm').click(function(){
			self.close();
		});
		
		//휴대폰번호 중복 확인
		
		//고객명 2자 이상
		
		//생년월일 미래 날짜 안됨
		
		//
		
		
	});	
</script>
</head>
<body>
<div>
	<h2>신규고객등록</h2>
	<h4>고객기본정보</h4>
	<form>
		<div class="infoBox">
			<ul>
				<li>
					<label for="cust_nm">고객명</label>
					<input type="text" id="cust_nm">
				</li>
				<li>
					<label for="poc_cd">직업코드</label>
					<select name="poc_cd">
						<option value="10">학생</option>
						<option value="20">회사원</option>
						<option value="30">공무원</option>
						<option value="40">전문직</option>
						<option value="50">군인</option>
						<option value="60">주부</option>
						<option value="90">연예인</option>
						<option value="99">기타</option>
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
					<button id="chMbl">확인</button>
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
					<label for="prt_cd">매장</label>
					<input type="text" id="prt_cd">
					<input type="text" id="prt_nm">
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
			<input type="button" id="" value="등록">
		</div>
	</form>
</div>
</body>
</html>