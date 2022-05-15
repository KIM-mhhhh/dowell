<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
고객명:
${customerVO.cust_nm }
/
직업코드:
${customerVO.poc_cd }
/
생일:
${customerVO.brdy_dt }
/
성별:
${customerVO.sex_cd }
/
우편수령코드:
${customerVO.psmt_grc_cd }
/
주소:
${customerVO.addr }
/
상세주소:
${customerVO.addr_dtl }
/
결혼기념일:
${customerVO.mrrg_dt }
/
양음력 구분:
${customerVO.scal_yn}
/
이메일:
${customerVO.email}
/
핸드폰 번호:
${customerVO.mbl_no}
/
가입매장:
${customerVO.jn_prt_cd}
/
이메일 여부:
${customerVO.email_rcv_yn }
/
sms 여부:
${customerVO.sms_rcv_yn }
/
dm여부:
${customerVO.dm_rcv_yn }
/
수정자:
${customerVO.lst_upd_id}
/
변경 : 
${customerVO.chg}
/
전 : 
${customerVO.before}
/
후:
${customerVO.after}
</body>
</html>