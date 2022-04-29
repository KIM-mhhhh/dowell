package first.market.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import first.market.vo.MarketVO;

public interface MarketService {
	
	//매장리스트 전체 조회
	public List<MarketVO> marketList();
	
	//매장 조건에 맞는 count 
	public int getMarketCount(String keyword);
	
	//매장 조회
	public List<MarketVO> searchMarket(String keyword);

}
