<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
	});
</script>
</head>
<body>
<h3>판매상세조회</h3>
<div id="infoBox">

</div>
<div id="salList">
	<Table>
		<tr>
			<th>번호</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>판매수량</th>
			<th>판매금액</th>
		</tr>
		<tr>
			<td></td>
		</tr>
	</Table>
</div>

<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="button" id="submitBtn" value="반품">
</div>
</body>
</html>