<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" type="text/css">
</head>
<body>
<div>

<form action="loginSubmit.do" method="post" id="loginForm">
<h2 class="formTitle">로그인</h2>
	<ul>
		<li>
			<label for="id">아이디</label>
			<input type="text" id="id" name="id">
		</li>
		<li>
			<label for="password">비밀번호</label>
			<input type="text" id="password" name="password">
		</li>
	</ul>
	<div class="align-center">
		<input type="submit" value="로그인">
	</div>
</form>
</div>
</body>
</html>