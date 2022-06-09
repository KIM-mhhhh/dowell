package first.sale.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import first.sale.service.SaleService;
import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;
import oracle.sql.json.OracleJsonObject;

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
		System.out.println("관리창 열 때 :" + saleList);
		
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
		System.out.println("ajax sale리스트:"+saleList);
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		ajaxMap.put("saleList", saleList);
		ajaxMap.put("count", count);
		
		return ajaxMap;
	}
	
	//고객판매수금등록 창 열기
	@RequestMapping("/sale/registShow.do")
	public ModelAndView openRegister() {
		List<Map<String,Object>> codeList = saleService.getCrdCode();
		ModelAndView mav = new ModelAndView("/sale/salRegister");
		mav.addObject("codeList", codeList);
		
		return mav;
	}
	
	//매장재고 창 열기
	@RequestMapping("/sale/openStock.do")
	public ModelAndView openStockPopup(HttpServletRequest request) {
		String num= request.getParameter("num");
		
		ModelAndView mav = new ModelAndView("/sale/checkStock");
		mav.addObject("num", num);
		
		return mav;
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

		System.out.println(saleVO.getOrg_shop_cd());
		
		List<SaleVO> saleList = saleService.getDetailSale(saleVO);
		System.out.println(saleList);
		
		ModelAndView mav = new ModelAndView("/sale/salDetail");
		mav.addObject("saleVO", saleVO);
		System.out.println(saleVO);
		mav.addObject("saleList", saleList);
		
		return mav;
	}
	
	//수금등록
	@ResponseBody
	@RequestMapping("/sale/registerSale.do")
	public Map<String,Object> registerSale(HttpServletRequest request, HttpSession session) {
		Map<String,Object> ajaxMap = new  HashMap<String,Object>();
		System.out.println("호출됨");
		 String[] arrStr=request.getParameterValues("arr");
		 System.out.println(arrStr.length);
//		 System.out.println(arrStr[0].length());
//		 String str = arrStr[0];
//		 System.out.println(str);
		 //상품품목입력할 list
		 List<SaleVO> saleList = new ArrayList<SaleVO>();
		
		 JSONParser parser = new JSONParser();
		 try {
			 for(int i=0;i<arrStr.length;i++) {
				 Object obj = parser.parse(arrStr[i]);
				 JSONObject json = (JSONObject)obj;
				 SaleVO saleVO = new SaleVO();
				 saleVO.setPrt_cd((String)session.getAttribute("prt_cd"));
				 saleVO.setPrd_cd((String)json.get("prd_cd"));
				 saleVO.setPrd_nm((String)json.get("prd_nm"));
				 saleVO.setCust_no((String)json.get("cust_no"));
				 saleVO.setCust_nm((String)json.get("cust_nm"));
				 saleVO.setSal_dt((String)json.get("sal_dt"));
				 saleVO.setVld_ym((String)json.get("vld_ym"));
				 saleVO.setCrd_co_cd((String)json.get("crd_co_cd"));
				 saleVO.setCrd_no((String)json.get("crd_no"));
				 saleVO.setPrd_csmr_upr(Integer.parseInt((String) json.get("prd_csmr_upr")));
				 saleVO.setSal_qty(Integer.parseInt((String) json.get("sal_qty")));
				 saleVO.setSal_amt(Integer.parseInt((String) json.get("sal_amt")));
				 saleVO.setTot_sal_qty(Integer.parseInt((String) json.get("tot_sal_qty")));
				 saleVO.setTot_sal_amt(Integer.parseInt((String) json.get("tot_sal_amt")));
				 saleVO.setFst_user_id((String)session.getAttribute("id"));
				 saleVO.setLst_upd_id((String)session.getAttribute("id"));
				 
				 if(json.get("csh_stlm_amt").equals("")){
					 saleVO.setCsh_stlm_amt(0);
				 }else {
					 saleVO.setCsh_stlm_amt(Integer.parseInt((String) json.get("csh_stlm_amt")));
				 }
				 if(json.get("crd_stlm_amt").equals("")){
					 saleVO.setCrd_stlm_amt(0);
				 }else {
					 saleVO.setCrd_stlm_amt(Integer.parseInt((String) json.get("crd_stlm_amt")));
				 }
				 
				 saleList.add(saleVO);
				 System.out.println(saleVO);
			 }
			 System.out.println(saleList.size());
			 //mt에 입력할 vo
			 SaleVO mtSaleVO = saleList.get(0);
			 System.out.println("등록mtVO:" + mtSaleVO);
			 Map<String,Object> map = new  HashMap<String,Object>();
			 map.put("list", saleList);
			 map.put("mtSaleVO", mtSaleVO);
			 saleService.registerSale(map);
			 ajaxMap.put("result", "success");
			
		} catch (ParseException e) {
			ajaxMap.put("result", "unsuccess");
			e.printStackTrace();
		}

		return ajaxMap;
		
	}
	
	//반품

	@RequestMapping("/sale/returnSale.do")
	public String returnSale(@ModelAttribute SaleVO saleVO, HttpSession session){
		Map<String,Object> map = new  HashMap<String,Object>();
		
		String id = (String) session.getAttribute("id");
		
		System.out.println("반품:"+saleVO);
		
		map.put("id", id);
		map.put("saleVO", saleVO);
		saleService.registerReturn(map);
		
		return "/sale/register";
		
	}
	
}

