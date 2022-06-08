<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sale.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$('#prd_cd').focus();
		
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
			   day = "0" + day;
			}
			var today = year + '-' + month + '-' + day;
					
			return today;
				} 
		//판매일자에 오늘의 날짜 고정
		$('#sal_dt').val(getToday());
		
		//회원 검색 팝업
		$('#searchCust').click(function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do','customer','width=700,height=900');
		});
		//매장 재고 팝업
		$(document).on('click','.stockBtn',function(){
		
			var num = $(this).attr('num');
			window.open('${pageContext.request.contextPath}/sale/openStock.do?num='+num+'','stock','_blank','width=700,height=900');
		});
		
 		function getSum() {
			// 합계 계산(체크된 것만)
			var sum = 0;
			var aSum = 0;
			 $('.checkBox').each(function(){
				 if ( $(this).is(':checked') ){

					 var num = $(this).attr('num');
					 //총 구매갯수
					 sum += Number($('#sal_qty'+num).val());
					 
				 	//총 구매액
					 aSum += Number($('#sal_amt'+num).val()); 
				 }
			 });
			 $('#qtySum').text(sum);
			 $('#amtSum').text(aSum.toLocaleString());				  
		} 
		
		//창 종료
		$('#closeBtn').click(function(){
			self.close();
		});
		
		//행 추가
		$('#plusRow').click(function(){
			var seq = ($('#regTable >#salTbody tr').length)+1

			//새 행 추가
			$('#salTbody').append(
			"<tr><td><input type='checkbox' num='"+seq+"' id='checkBox' class='checkBox'></td>"
			+ "<td>"+seq+"</td>"
			+ "<td><input type='text' class='prd_cd' num='"+seq+"'  name='prd_cd' id='prd_cd"+seq+"'><img id='stockBtn' num='"+seq+"' class='searchIcon stockBtn' alt='재고검색' src='${pageContext.request.contextPath}/images/search.png'></td>"
			+ "<td><input type='text' name='prd_nm' readonly id='prd_nm"+seq+"'></td>"
			+ "<td><input type='text' name='ivco_qty' readonly id='ivco_qty"+seq+"'></td>"
			+ "<td><input type='text' name='sal_qty' class='sal_qty' num='"+seq+"' id='sal_qty"+seq+"'></td>"
			+ "<td><input type='text' name='prd_csmr_upr' readonly id='prd_csmr_upr"+seq+"'></td>"
			+ "<td><input type='text' class='sal_amt' readonly name='sal_amt' id='sal_amt"+seq+"'></td></tr>"
			)
		});
		//행 삭제
		$('#minusRow').click(function(){
			if($('#salTbody tr').length<2){
				return false;
			}
			$('#salTbody tr:last').remove();
			getSum();
		});
		//상품코드를 입력하고 엔터치면 ajax로 정보 불러와서 해당 행에 입력>> 미래테그로.
		$(document).on('keydown','.prd_cd',function(key){
			if (key.keyCode == 13) {		//엔터키를 누르면
				var prd_keyword = $(this).val();
				var prt_keyword = $('#prt_cd').val();
				var num = $(this).attr('num');
//				alert(prd_keyword + "/" + prt_keyword);
				$.ajax({
					type:'post',
					data:{prt_keyword:prt_keyword,prd_keyword:prd_keyword},
					url: '${pageContext.request.contextPath}/sale/searchStock.do',
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.count<=0){
							alert('검색 결과가 존재하지 않습니다.');
						}else if(param.count==1){
							if(param.stockList[0].ivco_qty <=0){
								alert('재고가 없습니다.');
								$('#prd_cd'+num).val('').focus();
							}else if(param.stockList[0].prd_csmr_upr <=0){
								alert('소비자단가가 없습니다.');
								$('#prd_cd'+num).val('').focus();
							}else if(param.stockList[0].prd_ss_cd == 'C'){
								alert('상품상태가 정상이 아닙니다.');
								$('#prd_cd'+num).val('').focus();
							}else{
								$('#prd_nm'+num).val(param.stockList[0].prd_nm);
								$('#ivco_qty'+num).val(param.stockList[0].ivco_qty);
								$('#prd_csmr_upr'+num).val(param.stockList[0].prd_csmr_upr);
							}
						}else{				
							//팝업창 오픈
							var option = 'width=700, height=900,location=no';
							var openPrdPop = window.open('${pageContext.request.contextPath}/sale/openStock.do?num='+num+'', 'stockpopup', option);      
							      
							openPrdPop.onload = function(){
								openPrdPop.document.getElementById("prd_keyword").value = $('#prd_cd'+num).val();
							    openPrdPop.document.getElementById("searchBtn").classList.add("putBtn");
							}
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});		//ajax끝
            }
		}) ;
		//고객이 해지고객이면 판매할 수 없음
		function checkCustCd(){
			alert('실행');
			/* if($('#sCust_ss_cd').val() == '해지'){
				alert('해지고객에게는 판매할 수 없습니다.');
				$('#sCust_no').val('');
				$('#sCust_nm').val('');
			}else{
				alert('아님');
			} */
		}
		/* $('#sCust_ss_cd').change(function(){
			alert('변화');
			 if($('#sCust_ss_cd').val().equals('해지')){
				alert('해지고객에게는 판매할 수 없습니다.');
				$('#sCust_no').val('');
				$('#sCust_nm').val('');
			} 
		}); */
		
		//숫자 자릿수, 정규식 체크 함수
		function checkExp(thing,size){
			const regExp = /[0-9]/g;
			if(regExp.test(thing.val())){
				if(thing.val().length !=size){
					alert(size+'자리의 숫자를 입력하세요.');
					thing.val('').focus();
				}
			}else{
				alert('숫자를 입력하세요.');
				thing.val('').focus();
			}
		}
		
		//카드 유효일자 6자리 체크, 숫자 정규식 체크
		$('#vld_ym').change(function(){
			checkExp($('#vld_ym'),6);
		});
		//카드번호 체크
		$('#crd_no1').change(function(){
			checkExp($('#crd_no1'),4);
		});
		$('#crd_no2').change(function(){
			checkExp($('#crd_no2'),4);
		});
		$('#crd_no3').change(function(){
			checkExp($('#crd_no3'),4);
		});
		$('#crd_no4').change(function(){
			checkExp($('#crd_no4'),4);
		});

		//판매금액 제한
		$(document).on('change','.sal_qty',function(){
			var num = $(this).attr('num');
			const regExp = /[0-9]/g;
			if($(this).val() <=0){
				alert('1이상의 갯수를 입력하세요');
				$(this).val('').focus();
				return false;
			}else if(regExp.test($('#sal_qty'+num).val()) == false){
				alert('숫자를 입력하세요');
				$(this).val('').focus();
				return false;
			}else if(Number($(this).val())>Number($('#ivco_qty'+num).val())){
				alert('재고보다 많이 구매할 수 없습니다.');
				$(this).val('').focus();
				return false;
			}
			var sal_qty = $(this).val();
			var prd_csmr_upr = $('#prd_csmr_upr'+num).val();
			var cost = sal_qty * prd_csmr_upr;
			$('#sal_amt'+num).val(cost);
		});
		
		//value 비어잇으면 체크 불가능
		$(document).on('click','.checkBox',function(){	
			
			var num = $(this).attr('num');
			if($(this).is(':checked')){
				$(this).prop('checked',false);
				if($('#prd_cd'+num).val().length<=0){
					alert('상품코드를 입력하세요.');	
				}else if($('#sal_qty'+num).val().length<=0){
					alert('판매수량을 입력하세요.');
				}else{
					$(this).prop('checked',true);
					getSum();
				}
			}else{										//체크 풀때
				getSum();
			}
		});	
		
		//등록
 		$('#submitBtn').click(function(e){
 			//고객정보 필수
 			if($('#sCust_no').val().length<=0){
 				alert('고객정보를 입력하세요.');
 				return false;
 			};
 			//현금과 카드 둘 다 비어있으면 제출 불가
 			if($('#csh_stlm_amt').val().length<=0 && $('#crd_stlm_amt').val().length<=0){
 				alert('금액을 입력하세요');
// 				$('#csh_stlm_amt').val().focus();
 				return false;
 			}else if(Number($('#csh_stlm_amt').val())+Number($('#crd_stlm_amt').val()) != $('#amtSum').text().replace(/\,/g,'')){	//현금 + 카드와 총 구매금액이 다르면 제출 불가
 				alert('결제금액과 판매금액이 동일하지 않습니다.');
 				return false;
 			};
 						
 			//카드에 금액 있으면 다른 카드 항목 필수입력.
 			if($('#crd_stlm_amt').val().length>0){
 				if($('#vld_ym').val().length<=0){
 					alert('유효일자를 입력하세요.');
 					$('#vld_ym').val().focus();
 					return false;
 				}else if($('#sCrd_co_cd').val().length<=0){
 					alert('카드회사를 선택하세요.');
 					$('#crd_co_cd').val().focus();
 					return false;
 				}else if($('#crd_no1').val().length<=4){
 					alert('카드번호를 입력하세요.');
 					$('#crd_no1').val().focus();
 					return false;
 				}else if($('#crd_no2').val().length<=4){
 					alert('카드번호를 모두 입력하세요.');
 					$('#crd_no2').val().focus();
 					return false;
 				}else if($('#crd_no3').val().length<=4){
 					alert('카드번호를 모두 입력하세요.');
 					$('#crd_no3').val().focus();
 					return false;
 				}else if($('#crd_no4').val().length<=4){
 					alert('카드번호를 모두 입력하세요.');
 					$('#crd_no4').val().focus();
 					return false;
 				}
 			}
 			
 			$('#crd_no').val($('#crd_no1').val()+$('#crd_no2').val()+$('#crd_no3').val()+$('#crd_no4').val());
 			$('#tot_sal_qty').val($('#qtySum').text());
 			$('#tot_sal_amt').val($('#amtSum').text().replace(/\,/g,''));
 			$('#crd_co_cd').val($('#sCrd_co_cd').val());
 			
 			//체크된 것 없으면 제출 불가능.
 			if($('input[type=checkbox]:checked').length <=0){
 				alert('등록할 값을 선택하세요.');
 				return false;
 			};		
 			
 			var arr = [];
			  $('#regTable tr').each(function() {
				  var form = $('#registerForm').clone();
				  var tmp = $(this).closest('tr').clone();
			    if ( $(this).find('input[type=checkbox]').is(':checked') ) {
			      var tmp = $(this).clone();
			      form.append(tmp);
			      var formData = form.serializeObject();
			      arr.push(JSON.stringify(formData));
			      form.empty();
			    }
			    
			});
			  console.log(arr);
			  var yn = confirm("등록하시겠습니까?");
				if(yn==false){
					return false;
				}else{
		 			  $.ajax({
							url: "${pageContext.request.contextPath}/sale/registerSale.do",
							type: "post",
							traditional: true,	// ajax 배열 넘기기 옵션!
							data:{arr:arr},
							dataType: "json",
							success: function (data) {
								if(data.result=='success'){
									alert('등록완료!');
									self.close();
								}else{
									alet('등록실패!');
								}
							},
							error:function(request,status,error){
								alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							}
						}); //ajax끝
				}
			  e.preventDefault(); 
		}); 	  
		
	});
</script>
</head>
<body>
<h4>고객판매수금등록</h4>
<form id="registerForm" action="${pageContext.request.contextPath}/sale/registerSale.do" method="post">
<div class="searchBox">
		<input type="hidden" id="prt_cd" value="${prt_cd}">
		<input type="hidden" name="tot_sal_qty" id="tot_sal_qty">
		<input type="hidden" name="tot_sal_amt" id="tot_sal_amt">
		<ul>
			<li>
				<label for="sal_dt">판매일자</label>
				<input type="date" name="sal_dt" id="sal_dt" readonly >
			</li>
			<li>
				<label>판매구분</label>
				<select name="sal_tp_cd" id="sal_tp_cd">
					<option disabled value="0">전체</option>
					<option value="1"  selected>판매</option>
				</select>
			</li>
			<li>
				<label>고객번호</label>
				<input type="text" name="cust_no" id="sCust_no" onchange="checkCustCd()">
				<img id="searchCust" class="searchIcon" alt="고객조회" src="${pageContext.request.contextPath}/images/search.png">
				<input type="text" name="cust_nm" id="sCust_nm">
				<input type="hidden" id="sCust_ss_cd" >
			</li>
		</ul>
	
</div>
<h5>결제금액</h5>
<div id="costBox">
	<ul>
		<li>
			<label>현금</label>
			<input type="text" name="csh_stlm_amt" id="csh_stlm_amt">
		</li>
		<li>
			<label>카드금액</label>
			<input type="text" name="crd_stlm_amt" id="crd_stlm_amt">
		</li>
		<li>
			<label>유효일자</label>
			<input type="text" name="vld_ym" id="vld_ym">
		
		</li>
		<li>
			<label>카드회사</label>
			<input type="hidden" name="crd_co_cd" id="crd_co_cd">
			<select id="sCrd_co_cd">
								<option selected value="">-선택-</option>
							<c:forEach var="code" items="${codeList }">
								<option value="${code.DTL_CD }">${code.DTL_CD_NM }</option>
							</c:forEach>
			</select>
		</li>
		<li>
			<label>카드번호</label>
			<input type="hidden" name="crd_no" id="crd_no">
			<input type="text" id="crd_no1">
			<input type="text" id="crd_no2">
			<input type="text" id="crd_no3">
			<input type="text" id="crd_no4">
		</li>
	</ul>
</div>
</form>
<div id="pmBtn">
	<input type="button" id="plusRow" value="+">
	<input type="button" id="minusRow" value="-">
</div>
<div id="regList">
	<table id="regTable">
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>매장재고</th>
				<th>판매수량</th>
				<th>소비자단가</th>
				<th>판매금액</th>
			</tr>
		</thead>
		<tbody id="salTbody">
			<tr>
				<td><input type="checkbox" id="checkBox1" num="1" class="checkBox" ></td>
				<td id="rowCount">1</td>
				<td><input type="text" name="prd_cd" num="1" class="prd_cd" id="prd_cd1"><img id="stockBtn" num="1" class="searchIcon stockBtn" alt="재고검색" src="${pageContext.request.contextPath}/images/search.png"></td>
				<td><input type="text" name="prd_nm" id="prd_nm1" readonly></td>
				<td><input type="text" name="ivco_qty" id="ivco_qty1" readonly></td>
				<td><input type="text" name="sal_qty" id="sal_qty1" num="1" class="sal_qty"></td>
				<td><input type="text" name="prd_csmr_upr" id="prd_csmr_upr1" readonly></td>
				<td><input type="text" class="sal_amt" name="sal_amt" id="sal_amt1" readonly></td>
			</tr>
		</tbody>
		<tr id="sumTr">
				<td colspan="5">합계</td>
				<td id="qtySum"></td>
				<td></td>
				<td id="amtSum"></td>
			</tr>
	</table>
	
</div>
<div id="resultBtn">
	<input type="button" id="closeBtn" value="닫기">
	<input type="submit" id="submitBtn" value="적용">
</div>

</body>
</html>