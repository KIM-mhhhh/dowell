<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/side.css" type="text/css">
</head>
<body>
    <div class="left-side-bar">

		 <div class="status-ico">
            <span>▶</span>
        </div>
        <ul class="bigSide">
            <li>
                <a href="#">고객관리</a>
                <ul class="smallSide">
                    <li><a href="#">고객조회</a></li>
                    <li><a href="#">고객정보조회</a></li>
                    <li><a href="#">신규고객등록</a></li>
                </ul>
            </li>
            <li>
                <a href="#">매장관리</a>
                <ul class="smallSide">
                    <li><a href="#">매장조회</a></li>
                </ul>
            </li>
            <li>
                <a href="#">판매관리</a>
                <ul class="smallSide">
                    <li><a href="#">고객판매조회</a></li>
                    <li><a href="#">판매실적</a></li>
                </ul>
            </li>
            <li>
                <a href="#">주문관리</a>
                <ul class="smallSide">
                    <li><a href="#">주문등록</a></li>
                    <li><a href="#">주문진행조회</a></li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>