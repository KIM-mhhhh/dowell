package first.user.service;


import java.util.List;

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

	
	
	/*
	 * @Override public HashMap<String, Object> getInfo(String prt_cd) {
	 * 
	 * HashMap<String,Object> map = new HashMap<String, Object>(); MarketVO market =
	 * userMapper.getMarket(prt_cd); // CustomerVO customer =
	 * userMapper.getCustomer(prt_cd); List<CustomerVO> customerList =
	 * userMapper.getCustomer(prt_cd); map.put("market", market); //
	 * map.put("customer", customer); map.put("customerList", customerList);
	 * 
	 * return map; }
	 */



	@Override
	public MarketVO getMarket(String prt_cd) {
		MarketVO market = userMapper.getMarket(prt_cd);
		return market;
	}



	@Override
	public List<CustomerVO> getCustomer(String prt_cd) {
		List<CustomerVO> customerList = userMapper.getCustomer(prt_cd);
		return customerList;
	}

	

	
}
