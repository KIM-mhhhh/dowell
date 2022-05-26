package first.market.dao;

import java.util.List;


import first.market.vo.MarketVO;

public interface MarketMapper {
	
	//매장 검색
	public List<MarketVO> searchMarket(String keyword);
}
