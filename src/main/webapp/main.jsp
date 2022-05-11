<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script type="text/javascript">
 $(document).ready(function(){
		//로그인 submit할 때 textbox가 빈칸이면 submit되지 않게
	 $('#submitBtn').click(function(){
		 if($('#id').val().trim().length<=0){
			 alert('아이디를 입력하세요');
			 $('#id').focus();
				$('#id').val('');
				return false;
		 }else if($('#password').val().length<=0){
				alert('비밀번호를 입력하세요.');
				$('#password').focus();
				$('#password').val('');
				return false;
			}
	 });
 });
 
</script>
</head>
<body>
	<!-- 헤더 -->
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div>
	<!-- 본문 -->
<div>
	<div id="loginForm">
		<form action="loginSubmit.do" method="post" id="loginForm">
		<div class="icon">
			<span class="material-icons" id="logIcon">account_circle</span>
		</div>	
				<ul>
					<li>
						<input type="text" id="id" name="id" placeholder="아이디">
					</li>
					<li>
						<input type="password" id="password" name="password" placeholder="비밀번호">
					</li>
				</ul>
				<div>
					<input type="submit" id="submitBtn" value="로그인">
				</div>
		</form>
		</div>
</div>
</div>
	<!-- 푸터 -->
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>