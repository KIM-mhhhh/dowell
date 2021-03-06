package first.customer.controller;


import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.customer.service.CustomerService;
import first.customer.vo.CustomerVO;

import first.record.vo.RecordVO;
import first.user.service.UserService;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private UserService userService;
	
	
	//고객검색 팝업 열기
	@RequestMapping("/customer/searchCustomer.do")
	public String searchCustomer() {
		
		return "/customer/cusSearch";
	}
	
	//고객이력 열기
	@RequestMapping("/customer/showRecord.do")
	public ModelAndView checkRecord(HttpServletRequest request) {					//고객번호를 받아온다.
		
		String cust_no = request.getParameter("cust_no");
		System.out.println("cust_no:" + cust_no);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("cust_no", cust_no);
		List<RecordVO> recordList = customerService.getRecord(cust_no);				//고객번호로 해당 이력 목록을 list로 받아온다.
		String cust_nm = customerService.getCustInfo(map).getCust_nm();			//띄울 고객명 고객정보에서 가져오기
		System.out.println("고객이름 : " + cust_nm);

		ModelAndView mv = new ModelAndView("/customer/cusRecord");					//이력 창에 정보 보내주기
		mv.addObject("cust_no", cust_no);
		mv.addObject("cust_nm", cust_nm);
		mv.addObject("recordList",recordList);
		
		return mv;
	}
	
	//고객검색결과
	@RequestMapping("/customer/customerResult.do")
	@ResponseBody
	public Map<String,Object> searchCustomer(HttpServletRequest request){						//고객검색 팝업의 결과
		Map<String,Object> map = new HashMap<String, Object>();
		
		try {
			String cust_nm = request.getParameter("cust_nm");
			String mbl_no = request.getParameter("mbl_no");
			
			System.out.println("넘어온값 : " + cust_nm + "/" + mbl_no);
			
			Map<String,Object> ajaxMap = new HashMap<String,Object>();
			ajaxMap.put("cust_nm", cust_nm);
			ajaxMap.put("mbl_no", mbl_no);
			List<CustomerVO> customer = customerService.searchCustomer(ajaxMap);				//ajax로 키워드를 보내주고 그에 맞는 고객의 list를 가져온다.
			 
			int customerCount = customer.size();												//가져온 고객의 수
			System.out.println("고객 수 : " + customerCount);
			map.put("customerCount", customerCount);
			map.put("customer", customer);
			

		} catch (Exception e) {
			e.printStackTrace();
			map.put("error", e.getMessage());
		}

		return map;
	}
	
	//main고객검색
	@RequestMapping("/customer/mainCustomer.do")
	@ResponseBody
	public Map<String,Object> getCustomerInfo(HttpServletRequest request){						//검색 키워드들을 가져온다.
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		try {
			String prt_cd = request.getParameter("prt_cd"); 
			String prt_nm = request.getParameter("prt_nm"); 
			String cust_no = request.getParameter("cust_no"); 
			String cust_nm = request.getParameter("cust_nm"); 
			String cust_ss_cd = request.getParameter("cust_ss_cd"); 
			String from =request.getParameter("from"); 
			String to = request.getParameter("to");
			
			System.out.println("from : " + from +"/ to:"+ to );

			Map<String,Object> map = new HashMap<String,Object>();									//가져온 키워드들 map에 넣어서 list에 보내준다.
				map.put("prt_cd", prt_cd);
				map.put("prt_nm", prt_nm); 
				map.put("cust_no", cust_no); 
				map.put("cust_nm", cust_nm);
				map.put("cust_ss_cd", cust_ss_cd); 
				map.put("fromDate", from); 
				map.put("toDate", to);

			List<CustomerVO> searchList = customerService.getMainCustomer(map);						//map을 보내줘서 main검색 결과 list를 가져온다.
			int searchCount = searchList.size();				
			System.out.println("main검색결과수 : " + searchCount);

			ajaxMap.put("count", searchCount);														//ajax로 보내주기 위해 map으로 묶어서 보내준다.
			ajaxMap.put("list", searchList);
		}catch (Exception e) {
			e.printStackTrace();
			ajaxMap.put("error", e.getClass());
		}
		return ajaxMap;
	}
	
	
	//2차
	//회원등록 창
	@RequestMapping("/customer/cusRegist.do")
	public ModelAndView CustomerRegister() {
		
		ModelAndView mav = new ModelAndView("/customer/cusRegister");
		//
		List<Map<String,Object>> codeList = customerService.getPocCode();
		List<Map<String,Object>> psmtcodeList = customerService.getPsmtCode();

		mav.addObject("psmtcodeList", psmtcodeList);
		mav.addObject("codeList", codeList);
		
		return mav;
	}
	
	  //핸드폰번호 중복 확인
	  
	  @PostMapping("/customer/checkMbl.do")
	  @ResponseBody 
	  public Map<String,String> checkMblNo(HttpServletRequest request){
	  
	  Map<String,String> ajaxMap = new HashMap<String, String>();
	  String mbl_no = request.getParameter("mbl_no");
	  
	  System.out.println("폰번호:" +mbl_no);
	  
	  int mblCount = customerService.getMblCheck(mbl_no); 						//폰번호를 보내서 같은게 있는지 그 수를 가져와서 if문으로 각 경우를 나눠서 map으로보낸다.
		  if(mblCount==0) {
			  ajaxMap.put("result", "NotDuplicated"); 
		  }else if(mblCount >0){
			  ajaxMap.put("result", "Duplicated"); 
		  } 
	  return ajaxMap;
	  
	  }


	//고객 등록 처리
	@RequestMapping("/customer/registerSubmit.do")
	public String submitRegister(@ModelAttribute CustomerVO customerVO, Model model ) {
		
		customerService.custRegister(customerVO);								// 담아온 고객정보를 보내서 등록시킨다.
		model.addAttribute("customerVO", customerVO);
		
		return "/customer/register";
	}

	
	//회원 정보 가져오기
	@RequestMapping("/customer/showCustomer.do")
	public ModelAndView inquireCustomer(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("/customer/cusInfo");
		
		
		String cust_no = request.getParameter("cust_no");
		System.out.println("cust_no:"+cust_no);
		
		if(cust_no==null) {															//side로 들어가는 경우 페이지만 로드된다.
			CustomerVO customer = new CustomerVO();									//빈페이지에 기본 정보들 업로드.
			customer.setCust_ss_cd("10");
			customer.setScal_yn("0");
			customer.setSex_cd("F");
			customer.setPsmt_grc_cd("H");
			customer.setEmail_rcv_yn("Y");
			customer.setDm_rcv_yn("Y");
			customer.setSms_rcv_yn("Y");
			customer.setPoc_cd("0");
			customer.setEmail("@");
			mav.addObject("customer", customer);
		}else {
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("cust_no", cust_no);
			
			//각 고객의 요소로 들어가는 경우에는 고객의 정보를 띄워줘야 하므로 map으로 가져온다.
			CustomerVO customer = customerService.getCustInfo(map);
			
			 System.out.println("성별 :" +customer.getSex_cd());
			 System.out.println(customer.getBrdy_dt());
			 System.out.println("총 구매금액 : " + customer.getcTot_sal_amt());
			 System.out.println("월 구매금액 :" + customer.getmTot_sal_amt());
			  System.out.println("결혼기념일:" + customer.getMrrg_dt());
			  mav.addObject("customer", customer);
			
		}
		
		List<Map<String,Object>> codeList = customerService.getPocCode();
		List<Map<String,Object>> sscodeList = userService.getSScode();
		List<Map<String,Object>> psmtcodeList = customerService.getPsmtCode();
		mav.addObject("codeList", codeList);									//직업코드 목록
		mav.addObject("sscodeList", sscodeList);								//회원상태코드 목록
		mav.addObject("psmtcodeList", psmtcodeList);							//우편수령코드 목록
		
		return mav;
	}
	
	
	  //회원 정보 검색
	  
	  @RequestMapping("/customer/getCustInfo.do")
	  @ResponseBody 
	  public Map<String,Object> getCustInfo(HttpServletRequest request){ 
	  
	  String cust_no = request.getParameter("cust_no");										//ajax로 회원번호를 보내고 그걸로 고객의 정보를 받아온다.
	  System.out.println(cust_no);
	  
	  Map<String,Object> map = new HashMap<String, Object>();
		map.put("cust_no", cust_no);
	  
	  CustomerVO customer = customerService.getCustInfo(map);
	  System.out.println("성별 :" +customer.getSex_cd());
	  System.out.println("총 구매금액 : " + customer.getcTot_sal_amt());
	  System.out.println("최초 등록자 :" + customer.getFst_user_id());

	  
	  Map<String,Object> ajaxMap = new HashMap<String, Object>();
	  ajaxMap.put("customer", customer);
	  
	  return ajaxMap; 
	  }
	  
	 //고객 정보 수정
	  @RequestMapping("/customer/updateSubmit.do")
	  public String updateCustomer(@ModelAttribute CustomerVO customerVO, Model model) {
		  
		  System.out.println("첫 등록자 : " + customerVO.getFst_user_id());
		  System.out.println("첫 등록일 :"+customerVO.getFst_js_dt());

		 
		  String chg = customerVO.getChg();
		  System.out.println(chg + "/" + customerVO.getBefore() + "/" + customerVO.getAfter());
		  
		  
		  //변경사항 가져오가
		  String[] changeCd = chg.split(",");
		  String[] changeBf = customerVO.getBefore().split(",");
		  String[] changeAf = customerVO.getAfter().split(",");
		  ArrayList<String> cCdList = new ArrayList<String>(Arrays.asList(changeCd));
		  ArrayList<String> cBfList = new ArrayList<String>(Arrays.asList(changeBf));
		  ArrayList<String> cAfList = new ArrayList<String>(Arrays.asList(changeAf));

		  System.out.println(cCdList.size());
		  System.out.println(cCdList.toString());

		  System.out.println("before 길이 전:" + cBfList.size());
		  System.out.println(cBfList.toString());
		  //before이나 after에 빈 값이 있을 경우 NULL로 치환. 값을 넣어줘야 같이 for문 돌려서 record에 넣을 수가 있다.
		  if(cCdList.size()-cBfList.size()>0) {
			  int size = cCdList.size()-cBfList.size();
			  for(int i=0;i<size;i++) {
				  cBfList.add("NULL");
			  }
		  }
		  System.out.println("before 길이 후:" + cBfList.size());
		  System.out.println(cBfList.toString());

		  System.out.println(cAfList.toString());
		  if(cCdList.size()-cAfList.size()>0) {
			  int size = cCdList.size()-cAfList.size();
			  for(int i=0;i<size;i++) {
				  cAfList.add("NULL");
			  }
		  }
		  System.out.println(cAfList.toString());
		  
		  //recordVO에 값 할당
			
		  List<RecordVO> rList = new ArrayList<RecordVO>(); 
		  	for(int i=0;i<cCdList.size();i++) {
		  		
				  RecordVO recordVO = new RecordVO();
				  recordVO.setCust_no(customerVO.getCust_no());
				  recordVO.setChg_cd(cCdList.get(i).toUpperCase());
				  recordVO.setChg_bf_cnt(cBfList.get(i));
				  recordVO.setChg_aft_cnt(cAfList.get(i));
				  recordVO.setLst_upd_id(customerVO.getLst_upd_id());
				  recordVO.setFst_user_id(customerVO.getFst_user_id());
				  
				  System.out.println(recordVO.toString());
				  rList.add(recordVO); 
				  } 
			
		  	System.out.println("after 길이 후:" + cAfList.size());
		  	
		  	
		  	Map<String,Object> map = new HashMap<String, Object>();
			  map.put("customerVO", customerVO);
			  map.put("recordList", rList);
			  
		 
		  
		  System.out.println(customerVO.toString());
		  
		  
		  customerService.custUpdate(map);
		  
		  
		  model.addAttribute("cust_no", customerVO.getCust_no());
		  
		  return "redirect:/customer/showCustomer.do" ;
	  }
	
}
