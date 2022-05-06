<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객이력</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/popSearch.css" type="text/css">
<script type="text/javascript">
	window.onload = function(){
		var cloBtn = document.getElementById('closeForm');
			cloBtn.onclick = function(){
				self.close();
			}
	}
</script>
</head>
<body>
<div id="info">
<span>고객 ${cust_no}</span>
</div>
<div id="recList">
	<table id="recTable">
		<thead>
		<tr>
			<th>변경일자</th>
			<th>변경항목</th>
			<th>변경전</th>
			<th>변경후</th>
			<th>수정자</th>
			<th>수정일시</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var="record" items="${recordList}">
				<tr>
					<td>${record.chg_dt }</td>
					<td>${record.chg_cd }</td>
					<td>${record.chg_bf_cnt }</td>
					<td>${record.chg_aft_cnt }</td>
					<td>${record.lst_upd_id }/${record.user_nm }</td>
					<td>${record.lst_upd_dt }</td>
				</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
<div class="align-center">
	<input type="button" value="닫기" id="closeForm">
</div>
</body>
</html>