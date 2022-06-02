
$(document).ready(function(){
	//창종료
	$.closeForm = function(value){
		value.click(function(){
			self.close();
		});
	}
	
	
	$.getSum = function(target,result){
	// 합계 계산
		var sum = 0;
			
		target.each(function(){ //클래스가 cash인 항목의 갯수만큼 진행
			sum += Number(target.text()); 
		});
				  
		result.text(sum);
				  
	} 
	
	
});		