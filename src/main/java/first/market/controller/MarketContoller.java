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

	//거래처 팝업
	
	  @RequestMapping("/market/marketShow.do") 
	  public ModelAndView showMarket() {
	  
	  ModelAndView mv = new ModelAndView("/market/marketSearch"); 

	  return mv; }
	 
	
	//거래처 검색 결과
	@RequestMapping("/market/marketResult.do")
	@ResponseBody
	public Map<String,Object> searchMarket(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		List<MarketVO> market = marketService.searchMarket(keyword);
		int marketCount = market.size();
		map.put("marketCount", marketCount);
		map.put("market", market);
		
		return map;
	}
	
}
