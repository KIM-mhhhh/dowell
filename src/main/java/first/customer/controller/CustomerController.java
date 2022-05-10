package first.customer.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.customer.service.CustomerService;
import first.customer.vo.CustomerVO;

import first.record.vo.RecordVO;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	//고객검색 팝업
	@RequestMapping("/customer/searchCustomer.do")
	public String searchCustomer() {
		
		return "/customer/cusSearch";
	}
	
	//고객 이력 조회
	@RequestMapping("/customer/showRecord.do")
	public ModelAndView checkRecord(HttpServletRequest request) {				//링크로 고객 번호넘겨주기
		
		String cust_no = request.getParameter("cust_no");
		
		List<RecordVO> recordList = customerService.getRecord(cust_no);
		String cust_nm = customerService.getCustInfo(cust_no).getCust_nm();

		ModelAndView mv = new ModelAndView("/customer/cusRecord");
		mv.addObject("cust_no", cust_no);
		mv.addObject("cust_nm", cust_nm);
		mv.addObject("recordList",recordList);
		
		return mv;
	}
	
	//고객조회(검색)
	@RequestMapping("/customer/customerResult.do")
	@ResponseBody
	public Map<String,Object> searchCustomer(HttpServletRequest request) {
		String cust_nm = request.getParameter("cust_nm");
		String mbl_no = request.getParameter("mbl_no");
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		ajaxMap.put("cust_nm", cust_nm);
		ajaxMap.put("mbl_no", mbl_no);
			
		Map<String,Object> map = new HashMap<String, Object>();

		List<CustomerVO> customer = customerService.searchCustomer(ajaxMap);
		int customerCount = customer.size();
		map.put("customerCount", customerCount);
		map.put("customer", customer);

		return map;
	}
	
	//main고객 조회
	@RequestMapping("/customer/mainCustomer.do")
	@ResponseBody
	public Map<String,Object> getCustomerInfo(HttpServletRequest request){
		String prt_cd = request.getParameter("prt_cd"); 
		String prt_nm = request.getParameter("prt_nm"); 
		String cust_no = request.getParameter("cust_no"); 
		String cust_nm = request.getParameter("cust_nm"); 
		String cust_ss_cd = request.getParameter("cust_ss_cd"); 
		String from =request.getParameter("from"); 
		String to = request.getParameter("to");
		
		System.out.println("from : " + from +"/ to:"+ to );

		Map<String,Object> map = new HashMap<String,Object>();
			map.put("prt_cd", prt_cd);
			map.put("prt_nm", prt_nm); 
			map.put("cust_no", cust_no); 
			map.put("cust_nm", cust_nm);
			map.put("cust_ss_cd", cust_ss_cd); 
			map.put("fromDate", from); 
			map.put("toDate", to);

		List<CustomerVO> searchList = customerService.getMainCustomer(map);
		int searchCount = searchList.size();
//		System.out.println(searchCount);
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		ajaxMap.put("count", searchCount);
		ajaxMap.put("list", searchList);
		
		return ajaxMap;
	}
	
	
	//신규 고객 등록 팝업
	@RequestMapping("/customer/cusRegist.do")
	public ModelAndView CustomerRegister() throws Exception {
		
		
		
		//폼 직업 list
		List<Map<String,Object>> codeList = customerService.getPocCode();
		

		ModelAndView mav = new ModelAndView("/customer/cusRegister");
		mav.addObject("codeList", codeList);

		
		return mav;
	}
	//휴대폰 번호 중복
	
	  @PostMapping("/customer/checkMbl.do")
	  @ResponseBody 
	  public Map<String,String> checkMblNo(HttpServletRequest request){ 
		  Map<String,String> ajaxMap = new HashMap<String, String>(); 
		  String mbl_no = request.getParameter("mbl_no");
	  
		  System.out.println("폰번호:" +mbl_no);
		  
		  int mblCount = customerService.getMblCheck(mbl_no); 
		  if(mblCount==0) {
		  ajaxMap.put("result", "NotDuplicated"); 
		  }else if(mblCount >0){
		  ajaxMap.put("result", "Duplicated"); 
		  } 
		  return ajaxMap; 
		  
	 }

	/*
	 * @PostMapping("/customer/checkMbl.do")
	 * 
	 * @ResponseBody public Map<String,String> checkMblNo(@RequestParam String
	 * mbl_no){ Map<String,String> ajaxMap = new HashMap<String, String>();
	 * 
	 * System.out.println("폰번호:" +mbl_no);
	 * 
	 * int mblCount = customerService.getMblCheck(mbl_no); if(mblCount==0) {
	 * ajaxMap.put("result", "NotDuplicated"); }else if(mblCount >0){
	 * ajaxMap.put("result", "Duplicated"); } return ajaxMap; }
	 */
	
	//신규 고객 등록 처리
	@RequestMapping("/customer/registerSubmit.do")
	public String submitRegister(@ModelAttribute CustomerVO customerVO, Model model ) {
		
		customerService.custRegister(customerVO);
		model.addAttribute("customerVO", customerVO);
		
		return "/customer/register";
	
	}
	
	//고객정보조회 화면
	@RequestMapping("/customer/showCustomer.do")
	public ModelAndView inquireCustomer() {
		
		//폼 직업 list
		List<Map<String,Object>> codeList = customerService.getPocCode();
		
		ModelAndView mav = new ModelAndView("/customer/cusInfo");
		mav.addObject("codeList", codeList);
		
		return mav;
	}
	
	//회원번호로 고객정보 가져오기 
	@RequestMapping("/customer/getCustInfo.do")
	@ResponseBody 
	public Map<String,Object> getCustInfo(HttpServletRequest request){
		
		String cust_no = request.getParameter("cust_no");
		System.out.println(cust_no);
		
		CustomerVO customer = customerService.getCustInfo(cust_no);
		System.out.println(customer.getSex_cd());
		
		Map<String,Object> ajaxMap = new HashMap<String, Object>();
		ajaxMap.put("customer", customer);
		
		return ajaxMap;
	}
	
}
