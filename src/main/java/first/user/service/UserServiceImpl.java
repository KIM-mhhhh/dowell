package first.user.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import first.customer.vo.CustomerVO;
import first.market.vo.MarketVO;
import first.user.dao.UserMapper;
import first.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;

	//로그인
	@Override
	public UserVO loginUser(String user_id) {
		
		UserVO user = userMapper.loginUser(user_id);
		
		return user;
	}

	//매장코드로 고객조회 테이블 매장정보 불러오기
	@Override
	public MarketVO getMarket(String prt_cd) {
		MarketVO market = userMapper.getMarket(prt_cd);
		return market;
	}


	//매장코드로 고객조회 테이블 고객정보 불러오기
	@Override
	public List<CustomerVO> getCustomer(Map<String,Object> map) {
		List<CustomerVO> customerList = userMapper.getCustomer(map);
		return customerList;
	}


	//회원상태 코드 종류 가져오기
	@Override
	public List<Map<String,Object>> getSScode() {
		List<Map<String,Object>> codeList = userMapper.getSScode();
		return codeList;
	}

	

	
}
