package kr.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatUtil {
	
	//전화번호에 - 추가
	public static String phoneFormat(String phone) {
		
		String pNum=null;
		
		if(phone.length()==11) {
			pNum = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
		}else if(phone.length()==10) {
			pNum = phone.substring(0, 3) + "-" + phone.substring(3, 6) + "-" + phone.substring(6, 10);
		}
		return pNum;
	}
	
	//이름에 *처리
	public static String chName(String name) {
		String cName = "";
		if(name.length()==2) {
			cName = name.substring(0, 1) + "*";
		}else {
			String mid = name.substring(1, name.length()-1);
			String mark = "";		
			for(int i=0;i<mid.length();i++) {
				mark = mark + "*"; 
			}
			cName = name.substring(0, 1) + mark + name.substring(name.length()-1, name.length());	
		}		
		return cName;
	}
	
	//마스킹처리(번호)	
	public static String chPhone(String phone) {
		String pNum =null;
		
		if(phone.length()==11) {
			pNum = phone.substring(0, 3) + "****" + phone.substring(7, 11);
		}else if(phone.length()==10) {
			pNum = phone.substring(0, 3) + "***" + phone.substring(6, 10);
		}
		return pNum;
	}
	
	//날짜 String 형식 - 추가
	
	  public static String dateFormat(String date){
	  
		  String fmtStr = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
			
		  return fmtStr;
	  }
	 
	 //고객상태 코드 
	  public static String CustomerState(String state) {
		  
		  String stateCode = null;
		  
		  if(state.equals("10")) {
			  stateCode = "정상";
			}else if(state.equals("80")){
				stateCode ="중지";
			}else if(state.equals("90")){
				stateCode = "해지";	
			}
		
		  return stateCode;
	  }
	  //date 포맷 바꿔서 string으로 변환
	  public static String chDateFormat(Date date) {
		  String fmtDate = null;
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		  fmtDate = sdf.format(date);
		  
		  return fmtDate;
	  }
	

	

}
