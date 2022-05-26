package first.sale.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import first.sale.service.SaleService;
import first.sale.vo.ProductVO;

@Controller
public class SaleController {
	
	@Autowired
	private SaleService saleService;

	//고객판매관리 열기
	@RequestMapping("/sale/showSaleForm.do")
	public String goSaleSearch() {
		
		return "/sale/saleSearch";
	}
	
	//고객판매수금등록 창 열기
	@RequestMapping("/sale/registShow.do")
	public String openRegister() {
		
		return"/sale/salRegister";
	}
	
	//매장재고 창 열기
	@RequestMapping("/sale/openStock.do")
	public String openStockPopup() {
		
		return"/sale/checkStock";
	}
	//매장재고 검색
	@RequestMapping("/sale/searchStock.do")
	@ResponseBody
	public Map<String,Object> searchStock(HttpServletRequest request) {
		
		String prt_keyword = request.getParameter("prt_keyword");
		String prd_keyword = request.getParameter("prd_keyword");
		
		System.out.println("키워드 : " +prt_keyword +"/"+prd_keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("prt_keyword", prt_keyword);
		map.put("prd_keyword", prt_keyword);
		
		List<ProductVO> stockList = saleService.getStockList(map);
		
		
		Map<String,Object> ajaxMap = new  HashMap<String,Object>();
		ajaxMap.put("stockList", stockList);
		return ajaxMap;
	}
	
	
}

