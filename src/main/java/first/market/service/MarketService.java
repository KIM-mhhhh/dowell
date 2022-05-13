package first.market.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import first.market.vo.MarketVO;

public interface MarketService {
	

	//매장 조회
	public List<MarketVO> searchMarket(String keyword);

}
