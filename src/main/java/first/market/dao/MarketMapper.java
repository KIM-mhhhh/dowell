package first.market.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import first.market.vo.MarketVO;

public interface MarketMapper {
	
	//매장리스트 전체 조회
	@Select("SELECT * FROM ma_prt_mt WHERE PRT_DT_CD=2")
	public List<MarketVO> marketList();
	
	//매장 조건에 맞는 count 
	public int getMarketCount(String keyword);
	
	//매장 검색
	public List<MarketVO> searchMarket(String keyword);
}
