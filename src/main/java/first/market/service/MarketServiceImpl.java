package first.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.market.dao.MarketMapper;
import first.market.vo.MarketVO;

@Service
public class MarketServiceImpl implements MarketService {

	@Autowired
	private MarketMapper marketMapper;
	
	@Override
	public List<MarketVO> searchMarket(String keyword) {
		List<MarketVO> market = marketMapper.searchMarket(keyword);
		return market;
	}
	//매장 조건에 맞는 count 
	public int getMarketCount(String keyword) {
		
		int marketCount = marketMapper.getMarketCount(keyword);
		
		return marketCount;
		
	}

	@Override
	public List<MarketVO> marketList() {
		List<MarketVO> marketList = marketMapper.marketList();
		return marketList;
	}

}
