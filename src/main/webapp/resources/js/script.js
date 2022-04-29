

	window.onload = function(){
		var marketBtn = document.getElementById('searchMarket');
		marketBtn.onclick=function(){
			window.open('${pageContext.request.contextPath}/market/marketShow.do','market','width=1000,height=1000');
		};
		
		var custBtn = document.getElementById('searchCust');
		custBtn.onclick = function(){
			window.open('${pageContext.request.contextPath}/customer/searchCustomer.do?prt_cd=${userVO.prt_cd}','market','width=1000,height=1000');
		}
		
		
		
	};
