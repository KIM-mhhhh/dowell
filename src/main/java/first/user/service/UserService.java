package first.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import first.customer.vo.CustomerVO;
import first.market.vo.MarketVO;
import first.user.vo.UserVO;

public interface UserService {
	
	//로그인
	public UserVO loginUser(String user_id);
	
	//매장코드로 고객조회 테이블 매장정보 불러오기
	public MarketVO getMarket(String prt_cd);
			
	//매장코드로 고객조회 테이블 고객정보 불러오기
	public List<CustomerVO> getCustomer(Map<String,Object> map);
	
	//회원상태 코드 종류 가져오기
	public List<Map<String,Object>> getSScode();
	
	
}
