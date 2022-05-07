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

	@Override
	public UserVO loginUser(String user_id) {
		
		UserVO user = userMapper.loginUser(user_id);
		
		return user;
	}



	@Override
	public MarketVO getMarket(String prt_cd) {
		MarketVO market = userMapper.getMarket(prt_cd);
		return market;
	}



	@Override
	public List<CustomerVO> getCustomer(Map<String,Object> map) {
		List<CustomerVO> customerList = userMapper.getCustomer(map);
		return customerList;
	}



	@Override
	public List<Map<String,Object>> getSScode() {
		List<Map<String,Object>> codeList = userMapper.getSScode();
		return codeList;
	}

	

	
}
