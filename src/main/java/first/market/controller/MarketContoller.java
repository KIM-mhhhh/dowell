package first.market.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.market.service.MarketService;
import first.market.vo.MarketVO;


@Controller
public class MarketContoller {
	
	@Autowired
	private MarketService marketService;

	//거래처 전체 목록
	@RequestMapping("/market/marketShow.do")
	public ModelAndView showMarket() {
		
		ModelAndView mv = new ModelAndView("/market/marketSearch");
		List<MarketVO> marketList = marketService.marketList();
		
		for(int i=0;i<marketList.size();i++) {
			MarketVO market = marketList.get(i);
			if(market.getPrt_ss_cd().equals("10")) {
				market.setPrt_ss_cd("정상");
			}else if(market.getPrt_ss_cd().equals("80")) {
				market.setPrt_ss_cd("중지");
			}else if(market.getPrt_ss_cd().equals("90")) {
				market.setPrt_ss_cd("폐쇄");
			}
		}
		
		mv.addObject("marketList", marketList);
		
		return mv;
	}
	
	//거래처 검색 결과
	@RequestMapping("/market/marketResult.do")
	@ResponseBody
	public Map<String,Object> searchMarket(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		int marketCount = marketService.getMarketCount(keyword);
		
		List<MarketVO> market = marketService.searchMarket(keyword);
		for(int i=0;i<market.size();i++) {
			MarketVO marketVO = market.get(i);
			if(marketVO.getPrt_ss_cd().equals("10")) {
				marketVO.setPrt_ss_cd("정상");
			}else if(marketVO.getPrt_ss_cd().equals("80")) {
				marketVO.setPrt_ss_cd("중지");
			}else if(marketVO.getPrt_ss_cd().equals("90")) {
				marketVO.setPrt_ss_cd("폐쇄");
			}
		}
		map.put("marketCount", marketCount);
		map.put("market", market);
		
		return map;
	}
	
}
