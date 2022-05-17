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
		var check = 1;						//휴대폰 중복 체크
		
		
		//라디오버튼 체크
		function intoInfo(name,value){
			$('input:radio[name ='+name+']:input[value='+value+']').prop("checked", true);
		}
		
		//값 로드 시 핸드폰 번호 할당.
	 	if($('#mbl_no').val().length==11){
			$('#mbl_no1').val($('#mbl_no').val().substring(0,3));
			$('#mbl_no2').val($('#mbl_no').val().substring(3,7));
			$('#mbl_no3').val($('#mbl_no').val().substring(7,12));
		}else if($('#mbl_no').val().length==10){
			$('#mbl_no1').val($('#mbl_no').val().substring(0,3));
			$('#mbl_no2').val($('#mbl_no').val().substring(3,6));
			$('#mbl_no3').val($('#mbl_no').val().substring(6,11));
		} 
		//값 로드 시 이메일 할당
		if($('#email').val().length !=0){
			$('#email1').val($('#email').val().substring(0,$('#email').val().indexOf('@')));
			$('#email2').val($('#email').val().substring($('#email').val().indexOf('@')+1,$('#email').val().length));
		}
		//값 로드시 radio버튼 할당
		$('#poc_cd').val(${customer.poc_cd }).prop("selected",true);
		//intoInfo("sex_cd",${customer.sex_cd });
		 $('input:radio[name =sex_cd]:input[value='+$('#hSex').val()+']').prop("checked", true);
	 	$('input:radio[name =cust_ss_cd]:input[value='+${customer.cust_ss_cd }+']').prop("checked", true);
		$('input:radio[name =psmt_grc_cd]:input[value='+$('#hPsmt').val()+']').prop("checked",true);
		$('input:radio[name =scal_yn]:input[value='+${customer.scal_yn }+']').prop("checked",true);
		$('input:radio[name =email_rcv_yn]:input[value='+$('#hEyn').val()+']').prop("checked",true);
		$('input:radio[name =sms_rcv_yn]:input[value='+$('#hSyn').val()+']').prop("checked",true);
		$('input:radio[name =dm_rcv_yn]:input[value='+$('#hDyn').val()+']').prop("checked",true);  
				
		//날짜 넣기
		 $('#brdy_dt').val($('#birth').val());
		
		checkRadio();
		//비교 위해 초기 form 객체
		var Form = $('#infoForm').serializeArray();
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
		$('#mbl_no1,#mbl_no2,#mbl_no3 ').change(function(){
			check = 0;
		});
		
		function checkRadio(){
			//정상이면 중지만 가능하게
	  		if($(":radio[name='cust_ss_cd'][value='10']").is(':checked')){		
	 			$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
				$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', true);
				$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', false);
			}
	 	 	//중지면 정상 해지 가능하게
	 		if($(":radio[name='cust_ss_cd'][value='80']").is(':checked')){		
				$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', false);
				$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', false);
				$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
			}
	 		//해지면 정상만 가능하게
			if($(":radio[name='cust_ss_cd'][value='90']").is(':checked')){		
				$(":radio[name='cust_ss_cd'][value='90']").attr('disabled', false);
				$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
				$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', true);
			} 
		}
	 
 		$('#closeBtn').click(function(){
 			location.href="${pageContext.request.contextPath}/customer/cusList.jsp";
 		});
		
		//고객번호 검색 클릭시 고객검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','market','width=700,height=900');
		});
		//매장검색 팝업
		$('#searchMarket').click(function(){
			window.open('${pageContext.request.contextPath}/market/marketShow.do','market','width=500,height=600');
		});
		
		//고객조회 검색시 정보 가져와서 반영
		$('#submitBtn').click(function(event){
			if($('#cust_no').val().length<=0){									
				alert('고객번호를 입력하세요.');
				return false;
			}else {
				//정보 변경 후와 원래의 폼 객체로 만들어서 서로 비교. 
				$('#email').val( $('#email1').val() +"@"+ $('#email2').val());
				$('#mbl_no').val( $('#mbl_no1').val() + $('#mbl_no2').val() + $('#mbl_no3').val());	
				var newForm = $('#infoForm').serializeArray();							//새로 현재의 폼 객체

				console.log(Form);
				console.log(newForm);
				 if(JSON.stringify(Form) !== JSON.stringify(newForm)){								//변경된 내용 있을 경우
					 var yn = confirm("변경된 내용이 있습니다. 그래도 계속 하시겠습니까?");
						if(yn==false){																//아니오 면 검색이 안됨.
							return false;
						}
				 }																					//조건에 해당하지 않는 경우 검색 진행.
					
				 $(":radio[name='cust_ss_cd'][value='90']").attr('disabled', false);
					$(":radio[name='cust_ss_cd'][value='80']").attr('disabled', false);
					$(":radio[name='cust_ss_cd'][value='10']").attr('disabled', false);
				 $('#infoForm')[0].reset();
					$.ajax({
						type:'post',
						data:{cust_no:$('#cust_no').val()}, 	
						url:'${pageContext.request.contextPath}/customer/getCustInfo.do', 
						dataType:'json',
						cache:false,
						timeout:30000,
						success:function(param){
							 	//각 input에 값 할당.
								$('#cust_nm').val(param.customer.cust_nm);
							 	$('#sCust_nm').val(param.customer.cust_nm);
	 							$('#birth').val(param.customer.brdy_dt);
								$('#merry').val(param.customer.mrrg_dt);
								$('#addr').val(param.customer.addr);
								$('#addr_dtl').val(param.customer.addr_dtl);
								$('#email').val(param.customer.email);
								$('#email1').val($('#email').val().substring(0,$('#email').val().indexOf('@')));
								$('#email2').val($('#email').val().substring($('#email').val().indexOf('@')+1,$('#email').val().length));
								
								$('#mbl_no').val(param.customer.mbl_no);
								if($('#mbl_no').val().length==11){
									$('#mbl_no1').val($('#mbl_no').val().substring(0,3));
									$('#mbl_no2').val($('#mbl_no').val().substring(3,7));
									$('#mbl_no3').val($('#mbl_no').val().substring(7,12));
								}else if($('#mbl_no').val().length==10){
									$('#mbl_no1').val($('#mbl_no').val().substring(0,3));
									$('#mbl_no2').val($('#mbl_no').val().substring(3,6));
									$('#mbl_no3').val($('#mbl_no').val().substring(6,11));
								} 
								
								$('#jn_prt_cd').val(param.customer.jn_prt_cd);
								$('#prt_nm').val(param.customer.prt_nm);
								$('#fst_js_dt').val(param.customer.fst_js_dt);
								$('#js_dt').val(param.customer.js_dt);
								$('#cncl_cnts').val(param.customer.cncl_cnts);
								$('#stp_dt').val(param.customer.stp_dt);
								$('#cncl_dt').val(param.customer.cncl_dt); 
								$('#poc_cd').val(param.customer.poc_cd).prop("selected",true);
								$('input:radio[name =sex_cd]:input[value='+param.customer.sex_cd+']').prop("checked", true);
								$('input:radio[name =cust_ss_cd]:input[value='+param.customer.cust_ss_cd+']').prop("checked", true);
								$('input:radio[name =psmt_grc_cd]:input[value='+param.customer.psmt_grc_cd+']').prop("checked",true);
								$('input:radio[name =scal_yn]:input[value='+param.customer.scal_yn+']').prop("checked",true);
								$('input:radio[name =email_rcv_yn]:input[value='+param.customer.email_rcv_yn+']').prop("checked",true);
								$('input:radio[name =sms_rcv_yn]:input[value='+param.customer.sms_rcv_yn+']').prop("checked",true);
								$('input:radio[name =dm_rcv_yn]:input[value='+param.customer.dm_rcv_yn+']').prop("checked",true);
								
															
								Form = $('#infoForm').serializeArray();				//새로 불러온 정보 form객체로 묶는다.
								checkRadio();
						},
						error:function(error){
							alert(error);
						}
					});		//ajax 끝
				
			}		//큰 else문
			event.preventDefault();
		});	//고객조회 function 끝

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
 			$('#cust_nm').val('해지고객');
 			$('#cncl_cnts').focus();
 			$('#mbl_no1').val('000');
 			$('#mbl_no2').val('0000');
 			$('#mbl_no3').val('0000');
 			$('#cncl_dt').val(getToday());
 		});
		//중지버튼
		$(":radio[name='cust_ss_cd'][value='80']").click(function(){
 			$('#stp_dt').val(getToday());
 		});
 		//정상버튼
 		$(":radio[name='cust_ss_cd'][value='10']").click(function(){
 			$('#cncl_cnts').attr("readonly",true);
 			$('#cust_nm').val('');
 			$('#cncl_cnts').val('');
 			$('#mbl_no1').val('');
 			$('#mbl_no2').val('');
 			$('#mbl_no3').val('');
 			$('#cncl_dt').val('');
 			$('#stp_dt').val('');
 			$('#js_dt').val(getToday());
 		});
		
		//저장버튼 클릭 시 휴대폰번호 변경버튼 안눌렀으면 버튼확인하라고, 필수항목 검사. 창 띄우고 yes면 저장.
		$('#confBtn').click(function(){
			//고객명 2자 이상 체크
			if($('#cust_nm').val().trim().length<2){
				alert('고객명을 2자 이상 입력해 주세요.');
				return false;
			}
			//필수항목
			if($('#email1').val().trim().length<=0 || $('#email2').val().trim().length<=0){
				alert('이메일을 입력하세요.');
				return false;
			}
			$('#email').val( $('#email1').val() +"@"+ $('#email2').val());				//email값 할당
			
			//우편물 수령 선택 필수
			if($('#psmt_grc_cd').val()==''){
				alert('우편물 수령 장소를 선택하세요.');
				return false;
			}
			
			//주소 하나 입력되어 있으면 둘 다 입력
			if($('#addr').val().trim().length>0 && $('#addr_dtl').val().trim().length<=0 ){
				alert('상세주소를 입력해 주세요.');
				return false;
			}else if($('#addr').val().trim().length<=0 && $('#addr_dtl').val().trim().length>0 ){
				alert('주소를 입력해 주세요.');
				return false;
			}
			//매장코드 필수 입력
			if($('#jn_prt_cd').val().trim().length<=0){
				alert('매장코드를 입력해 주세요.');
				return false;
			}
			//휴대폰번호 확인 체크
			
 			/* if(check==0){
				alert('휴대폰 번호 중복 확인 해주세요.');
				return false;
			}  */
			$('#mbl_no').val( $('#mbl_no1').val() + $('#mbl_no2').val() + $('#mbl_no3').val());	
			
 			//생년월일 값 체크, -제거
			if($('#birth').val()==''){
				alert('날짜를 입력해 주세요');
				return false;
			}else {
				$('#brdy_dt').val($('#birth').val());
			}
 			//날짜 제한. 오늘 넘지 않게
 			if($('#birth').val()> new Date().toISOString().substring(0,10)){
 				alert('오늘 이전의 날짜만 선택 가능합니다.');
 				return false;
 			}
			 
			
			//변경 알기 위해 작성한 폼 객체화해서 처음 데이터와 비교
			var newForm = $('#infoForm').serializeArray();
			var chg = isEquivalent(newForm,Form);										//비교함수
			console.log(chg);
			
			if(chg != ''){
				var chgStr = chg.name.join();											//받아온 객체의 명, 전 값, 변경 후 값을 문자열로 변경
				var chgbefore = chg.before.join();
				var chgafter = chg.after.join();
				$('#chg').val(chgStr);
				$('#before').val(chgbefore);
				$('#after').val(chgafter);
			}
			
			 $('#brdy_dt').val($('#birth').val().replace(/\-/g,''));
			 console.log($('#brdy_dt').val());
			
 			//결혼기념일 - 제거
			if($('#merry').val() !=''){
				$('#mrrg_dt').val($('#merry').val().replace(/\-/g,''));
			}
 			$('#fst_js_dt').val($('#f_js_dt').val().replace(/\-/g,''));
 			$('#js_dt').val($('#jdt').val().replace(/\-/g,''));
 			$('#stp_dt').val($('#stop_dt').val().replace(/\-/g,''));
 			$('#stp_dt').val($('#cn_dt').val().replace(/\-/g,''));

			var yn = confirm("고객정보를 수정하시겠습니까?");
			if(yn==false){
				return false;
			}
		});	
		
		//test
	 	/* $('#checkBtn').click(function(){
			var newForm = $('#infoForm').serializeArray();	 
		 var chg = isEquivalent(newForm,Form);
			console.log(chg);
			
			if(chg != ''){
				var chgStr = chg.name.join();
				var chgbefore = chg.before.join();
				var chgafter = chg.after.join();
				$('#chg').val(chgStr);
				alert(chgStr);
			}

		});   */
		
	});		//document 끝
	//바뀐 항목 뽑아내기
	function isEquivalent(after,before){
		console.log(after);
		console.log(before);
		/* console.log(${customer}); */
		var chName = new Array();
		var chBefore = new Array();
		var chAfter = new Array();
		if(after.length != before.length){
			return false;
		}else{
		 for(var i in after){
			 
			  if(after[i].value !== before[i].value){
				  console.log(after[i].name);
				  chName.push(after[i].name);
				  chAfter.push(after[i].value);
				  chBefore.push(before[i].value);
			  }
		}
		 var chgOb = {
			name : chName,
			before : chBefore,
			after : chAfter
		 }
		return chgOb;
		}
		}		//isEquivalent 끝
</script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
</div>
<div id='wrapper'>

<h4>고객정보조회<img alt="새로고침" src="${pageContext.request.contextPath}/images/reload.png" onclick="window.location.reload()"></h4>
<div class="searchBox">
<form method="post" id="searchForm">
	<div>
	<label for="">고객</label>
	<input type="text" id="cust_no" value="${customer.cust_no }" >
	<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
	<input type="text"  id="sCust_nm" value="${customer.cust_nm }">
	</div>
	<div class="submitBtn">
			<button id="submitBtn"><span class="material-icons">search</span></button>
	</div>
</form>
</div>

<div>
	<form action="${pageContext.request.contextPath}/customer/updateSubmit.do" method="post" id="infoForm">
	<h4>고객기본정보</h4>
		
		<div class="infoBox">
				<input type="hidden" id="chg" name="chg" >
				<input type="hidden" id="before" name="before" >
				<input type="hidden" id="after" name="after" >
				<input type="hidden" id="cust_no" name="cust_no" value="${customer.cust_no}">
				<input type="hidden" id="lst_upd_id" name="lst_upd_id" value="${id }">
				
			<div class="infoOne">
				<ul>
					<li>
						<label for="cust_nm">*고객명</label>
						<input type="text" id="cust_nm" name="cust_nm" value="${customer.cust_nm }">
					</li>
					<li>
						<label for="brdy_dt">*생년월일</label>
						<input type="hidden" id="brdy_dt" name="brdy_dt">
						<input type="date" id="birth" name="birth" value="${customer.brdy_dt }">
					</li>
					<li>
						<label for="sex_cd">성별</label>
						<input type="hidden" id="hSex" value="${customer.sex_cd }">
						<input type="radio" name="sex_cd" value='F' checked>여성
						<input type="radio" name="sex_cd" value='M'>남성
					</li>
					<li>
						<label for="scal_yn">*생일</label>
						<input type="radio" name="scal_yn" value="0" checked>양력
						<input type="radio" name="scal_yn" value="1">음력
					</li>
					<li>
						<label for="mrrg_dt">결혼기념일</label>
						<input type="hidden" id="mrrg_dt" name="mrrg_dt">
						<input type="date" id="merry" name="merry" value="${customer.mrrg_dt }">
					</li>
					<li>
						<label for="poc_cd">*직업코드</label>
						<select name="poc_cd" id="poc_cd">
								<option selected disabled>-선택-</option>
							<c:forEach var="code" items="${codeList }">
								<option value="${code.DTL_CD }">${code.DTL_CD_NM }</option>
							</c:forEach>
						</select>
					</li>
					<li>
						<label for="mbl_no">*휴대폰번호</label>
						<input type="hidden" id="mbl_no" name="mbl_no" value="${customer.mbl_no }">
						<input type="text" id="mbl_no1">
						<input type="text" id="mbl_no2">
						<input type="text" id="mbl_no3">
						<input type="button" value="확인" id="chMbl">
					</li>
					<li>
						<label for="jn_prt_cd">*가입매장</label>
						<input type="text" id="jn_prt_cd" name="jn_prt_cd" value="${customer.jn_prt_cd }" >
						<img id="searchMarket" class="searchIcon" alt="매장조회" src="${pageContext.request.contextPath}/images/search.png">
						<input type="text" id="prt_nm" value="${customer.prt_nm }" >
					</li>
				</ul>
				</div>
				<div class="infoTwo">
				<ul>
				<li>
					<label for="psmt_grc_cd">*우편물수령</label>
					<input type="hidden" id="hPsmt" value="${customer.psmt_grc_cd }">
					<input type="radio" name="psmt_grc_cd" value="H" checked>자택
					<input type="radio" name="psmt_grc_cd" value="O">직장
				</li>
				<li>
					<label for="email">*이메일</label>
					<input type="hidden" id="email" name="email" value="${customer.email }"> 
					<input type="text" id="email1">
					<span>@</span>
					<input type="text" id="email2">
				</li>
				<li>
					<label for="addr">주소</label>
					<input type="text" id="addr" name="addr" value="${customer.addr }">
					<input type="text" id="addr_dtl" name="addr_dtl" value="${customer.addr_dtl }" >
				</li>
				<li>
					<label>*고객상태</label>
					<input type="radio" name="cust_ss_cd" value="10" checked> 정상
					<input type="radio" name="cust_ss_cd" value="80"> 중지
					<input type="radio" name="cust_ss_cd" value="90"> 해지
				</li>
				<li>
					<label for="fst_js_dt">최초가입일자</label>
					<input type="hidden" id="fst_js_dt" name="fst_js_dt">
					<input type="text" id="f_js_dt" readonly name="f_js_dt" value="${customer.fst_js_dt }">
				</li>
				<li>
					<label for="js_dt">가입일자</label>
					<input type="hidden" id="js_dt" name="js_dt">
					<input type="text" id="jdt" readonly name="jdt" value="${customer.js_dt }">
				</li>
				<li>
					<label for="cncl_cnts">해지사유</label>
					<input type="text" id="cncl_cnts" readonly name="cncl_cnts" value="${customer.cncl_cnts }">
				</li>
				<li>
					<label for="stp_dt">중지일자</label>
					<input type="hidden" id="stp_dt" name="stp_dt">
					<input type="text" id="stop_dt" readonly name="stop_dt" value="${customer.stp_dt }">
				</li>
				<li>
					<label for="cncl_dt">해지일자</label>
					<input type="hidden" id="cncl_dt" name="cncl_dt">
					<input type="text" id="cn_dt" readonly name="cn_dt" value="${customer.cncl_dt }">
				</li>
			</ul>
			</div>
		</div>
		<h4>구매</h4>
		<div class="calBox">
			<ul>
				<li>
					<label for="cTot_sal_amt">총구매금액</label>
					<input type="text" id="cTot_sal_amt" readonly value="${customer.cTot_sal_amt}">
				</li>
				<li>
					<label for="mTot_sal_amt">당월구매금액</label>
					<input type="text" id="mTot_sal_amt" readonly value="${customer.mTot_sal_amt }">
				</li>
				<li>
					<label for="lSal_dt">최종구매일</label>
					<input type="text" id="lSal_dt" readonly value="${customer.lSal_dt}">
				</li>
			</ul>
		</div>
		<h4>수신동의(통합)</h4>
		<div class="ynBox">
			<ul>
				<li>
					<label for="email_rcv_yn">*이메일수신동의</label>
					<input type="hidden" id="hEyn" value="${customer.email_rcv_yn }">
					<input type="radio" name="email_rcv_yn" value="Y" checked>예
					<input type="radio" name="email_rcv_yn" value="N">아니오
				</li>
				<li>
					<label for="sms_rcv_yn">*SMS수신동의</label>
					<input type="hidden" id="hSyn" value="${customer.sms_rcv_yn }">
					<input type="radio" name="sms_rcv_yn" value="Y" checked>예
					<input type="radio" name="sms_rcv_yn" value="N">아니오
				</li>
				<li>
					<label for="dm_rcv_yn">*DM수신동의</label>
					<input type="hidden" id="hDyn" value="${customer.dm_rcv_yn }">
					<input type="radio" name="dm_rcv_yn" value="Y" checked>예
					<input type="radio" name="dm_rcv_yn" value="N">아니오
				</li>
			</ul>
		</div>
		<div class="btn">
			<input type="button" id="closeBtn" value="닫기">
			<c:if test="${prt_dt_cd eq '2'}">
				<input type="submit" id="confBtn" value="저장">
			</c:if>
		</div>
	</form>
</div>

</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>