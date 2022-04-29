package first.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import first.customer.vo.CustomerVO;
import first.market.vo.MarketVO;
import first.user.vo.UserVO;

public interface UserMapper {

	//로그인
	@Select("SELECT * FROM ma_user_mt WHERE user_id=#{user_id}")
	public UserVO loginUser(String user_id);
	
	//매장코드로 고객조회 테이블 매장정보 불러오기
	@Select("SELECT * FROM ma_prt_mt WHERE prt_cd=#{prt_cd}")
	public MarketVO getMarket(String prt_cd);
	
	//매장코드로 고객조회 테이블 고객정보 불러오기
	public List<CustomerVO> getCustomer(String prt_cd);
	
	
}
