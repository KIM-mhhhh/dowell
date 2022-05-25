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

	//거래처 팝업 띄우기
	  @RequestMapping("/market/marketShow.do") 
	  public ModelAndView showMarket() {
	  
	  ModelAndView mv = new ModelAndView("/market/marketSearch"); 

	  return mv; }
	 
	
	//거래처 검색 결과
	@RequestMapping("/market/marketResult.do")
	@ResponseBody
	public Map<String,Object> searchMarket(HttpServletRequest request) {

			Map<String,Object> map = new HashMap<String, Object>();
			
		try {
			String keyword = request.getParameter("keyword");
			List<MarketVO> market = marketService.searchMarket(keyword);			//검색어로 거래처 list 가져온다.
			int marketCount = market.size(); 										//검색된 거래처의 갯수	
			map.put("marketCount", marketCount);
			map.put("market", market);
		} catch (Exception e) {	
			map.put("error", "정보를 가져올 수 없습니다.");
		}
		return map;
	}
	
	
	
}
