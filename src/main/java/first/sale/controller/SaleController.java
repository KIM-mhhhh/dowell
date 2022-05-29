package first.sale.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.sale.service.SaleService;
import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;

@Controller
public class SaleController {
	
	@Autowired
	private SaleService saleService;

	//고객판매관리 창 열기
	@RequestMapping("/sale/showSaleForm.do")
	public ModelAndView goSaleSearch(HttpSession session) {
		//초기값 셋팅
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("prt_cd",session.getAttribute("prt_cd"));
		
		//오늘 날짜
		  Date today = new Date(); 
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 
		  String to = sdf.format(today); 
		  	//일주일 전 날짜
		  Calendar calendar = Calendar.getInstance();
		  calendar.add(Calendar.DAY_OF_MONTH, -7); 
		  Date date = calendar.getTime();
		  String from = sdf.format(date); 
		  System.out.println("to : " + to +"/ from:"+from);
		  
		  map.put("from", from); 
		  map.put("to", to);
		
		List<SaleVO> saleList = saleService.getSaleList(map);
		System.out.println("saleList 수:"+saleList.size());
		
		ModelAndView mav = new ModelAndView("/sale/saleSearch");
		mav.addObject("saleList", saleList);
		mav.addObject("count", saleList.size());
		
		return mav;
	}
	
	//고객판매관리 검색
	@RequestMapping("/sale/searchSaleList.do")
	@ResponseBody
	public Map<String,Object> searchSaleList(HttpServletRequest request) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("prt_cd", request.getParameter("prt_cd"));
		map.put("cust_no", request.getParameter("cust_no"));
		map.put("from",request.getParameter("from"));
		map.put("to",request.getParameter("to"));
		
		System.out.println("매장코드:"+request.getParameter("prt_cd"));
		System.out.println("to : " + request.getParameter("to") +"/ from:"+request.getParameter("from"));
		
		List<SaleVO> saleList = saleService.getSaleList(map);
		int count = saleList.size();
		System.out.println("saleList갯수:" + count);
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		ajaxMap.put("saleList", saleList);
		ajaxMap.put("count", count);
		
		return ajaxMap;
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
		map.put("prd_keyword", prd_keyword);
		
		List<ProductVO> stockList = saleService.getStockList(map);
		int count = stockList.size();
		System.out.println("stocklist수:" + count);
		
		Map<String,Object> ajaxMap = new  HashMap<String,Object>();
		ajaxMap.put("stockList", stockList);
		ajaxMap.put("count", count);
		return ajaxMap;
	}
	
	//상세페이지 열기
	@RequestMapping("/sale/saleDetailPopup.do")
	public ModelAndView openSaleDetail(@ModelAttribute SaleVO saleVO) {
		
		System.out.println(saleVO.getCust_nm());
		
		List<SaleVO> saleList = saleService.getDetailSale(saleVO);
		
		ModelAndView mav = new ModelAndView("/sale/salDetail");
		mav.addObject("saleVO", saleVO);
		mav.addObject("saleList", saleList);
		
		
		return mav;
	}
	
}

