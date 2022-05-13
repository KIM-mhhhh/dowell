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
	
	//키워드로 매장 검색해서 list 반환
	@Override
	public List<MarketVO> searchMarket(String keyword) {
		List<MarketVO> market = marketMapper.searchMarket(keyword);
		return market;
	}


}
