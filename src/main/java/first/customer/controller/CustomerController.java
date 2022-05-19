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

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	//怨좉컼寃��깋 �뙘�뾽
	@RequestMapping("/customer/searchCustomer.do")
	public String searchCustomer() {
		
		return "/customer/cusSearch";
	}
	
	//怨좉컼 �씠�젰 議고쉶
	@RequestMapping("/customer/showRecord.do")
	public ModelAndView checkRecord(HttpServletRequest request) {					//留곹겕濡� 怨좉컼 踰덊샇�꽆寃⑥＜湲�
		
		String cust_no = request.getParameter("cust_no");
		System.out.println("cust_no:" + cust_no);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("cust_no", cust_no);
		List<RecordVO> recordList = customerService.getRecord(cust_no);				//怨좉컼踰덊샇濡� 怨좉컼�쓽 �씠�젰 紐⑸줉�쓣 媛��졇�샂
		String cust_nm = customerService.getCustInfo(map).getCust_nm();			//怨좉컼踰덊샇濡� 怨좉컼紐� 媛��졇�삩�떎.
		System.out.println("怨좉컼紐� : " + cust_nm);

		ModelAndView mv = new ModelAndView("/customer/cusRecord");					//怨좉컼 �씠�젰 �럹�씠吏�濡� list�� �젙蹂대뱾 蹂대궡以�.
		mv.addObject("cust_no", cust_no);
		mv.addObject("cust_nm", cust_nm);
		mv.addObject("recordList",recordList);
		
		return mv;
	}
	
	//怨좉컼議고쉶(寃��깋)
	@RequestMapping("/customer/customerResult.do")
	@ResponseBody
	public Map<String,Object> searchCustomer(HttpServletRequest request){						//怨좉컼議고쉶�뙘�뾽�뿉�꽌 寃��깋�뼱濡� 怨좉컼 議고쉶
		Map<String,Object> map = new HashMap<String, Object>();
		
		try {
			String cust_nm = request.getParameter("cust_nm");
			String mbl_no = request.getParameter("mbl_no");
			
			System.out.println("寃��깋�뼱 : " + cust_nm + "/" + mbl_no);
			
			Map<String,Object> ajaxMap = new HashMap<String,Object>();
			ajaxMap.put("cust_nm", cust_nm);
			ajaxMap.put("mbl_no", mbl_no);
			List<CustomerVO> customer = customerService.searchCustomer(ajaxMap);				//寃��깋�뼱 議곌굔�뿉 留욌뒗 怨좉컼�쓽 list瑜� 遺덈윭�삩�떎.
			 
			int customerCount = customer.size();												//寃��깋�뼱 議곌굔�뿉 留욌뒗 怨좉컼�쓽 �닔
			System.out.println("怨좉컼議고쉶 list�쓽 �닔 : " + customerCount);
			map.put("customerCount", customerCount);
			map.put("customer", customer);
			

		} catch (Exception e) {
			e.printStackTrace();
			map.put("error", e.getMessage());
		}

		return map;
	}
	
	//main怨좉컼 議고쉶
	@RequestMapping("/customer/mainCustomer.do")
	@ResponseBody
	public Map<String,Object> getCustomerInfo(HttpServletRequest request){							//議곌굔�뿉 留욌뒗 怨좉컼�뱾 寃��깋
		
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

			Map<String,Object> map = new HashMap<String,Object>();									//list瑜� 媛��졇�삤湲� �쐞�븳 �슂嫄대뱾�쓣 map�뿉 �떞�븘以��떎.
				map.put("prt_cd", prt_cd);
				map.put("prt_nm", prt_nm); 
				map.put("cust_no", cust_no); 
				map.put("cust_nm", cust_nm);
				map.put("cust_ss_cd", cust_ss_cd); 
				map.put("fromDate", from); 
				map.put("toDate", to);

			List<CustomerVO> searchList = customerService.getMainCustomer(map);						//議곌굔�뿉 留욌뒗 怨좉컼�뱾 list
			int searchCount = searchList.size();				
			System.out.println("main寃��깋�쓽 寃곌낵 �닔 : " + searchCount);

			ajaxMap.put("count", searchCount);														//map�뿉 �떞�븘�꽌 ajax�쓽 json �삎�깭濡� 蹂대궡以��떎
			ajaxMap.put("list", searchList);
		}catch (Exception e) {
			e.printStackTrace();
			ajaxMap.put("error", e.getClass());
		}
		return ajaxMap;
	}
	
	
	//2李�
	//�떊洹� 怨좉컼 �벑濡� �뙘�뾽
	@RequestMapping("/customer/cusRegist.do")
	public ModelAndView CustomerRegister() {
		
		//�뤌 吏곸뾽肄붾뱶�쓽 list 肄붾뱶 �뀒�씠釉붿뿉�꽌 媛��졇�삩�떎.
		List<Map<String,Object>> codeList = customerService.getPocCode();

		ModelAndView mav = new ModelAndView("/customer/cusRegister");
		mav.addObject("codeList", codeList);
		
		return mav;
	}
	
	  //�쑕���룿 踰덊샇 以묐났
	  
	  @PostMapping("/customer/checkMbl.do")
	  @ResponseBody 
	  public Map<String,String> checkMblNo(HttpServletRequest request){
	  
	  Map<String,String> ajaxMap = new HashMap<String, String>();
	  String mbl_no = request.getParameter("mbl_no");
	  
	  System.out.println("�룿踰덊샇:" +mbl_no);
	  
	  int mblCount = customerService.getMblCheck(mbl_no); //�쑕���룿 踰덊샇媛� 議댁옱�븯�뒗 寃쎌슦 duplicated, �븘�땲硫� notDuplicated瑜� json�쑝濡� 蹂대궡以��떎. 
		  if(mblCount==0) {
			  ajaxMap.put("result", "NotDuplicated"); 
		  }else if(mblCount >0){
			  ajaxMap.put("result", "Duplicated"); 
		  } 
	  return ajaxMap;
	  
	  }

//	  @PostMapping("/customer/checkMbl.do") 
//	  @ResponseBody public Map<String,String> checkMblNo(HttpServletRequest request, @RequestParam String mbl_no){
//		  Map<String,String> ajaxMap = new HashMap<String, String>();
//	  
//		  System.out.println("폰번호:" +mbl_no);
//	  
//	  int mblCount = customerService.getMblCheck(mbl_no); 
//	  if(mblCount==0) {
//		  ajaxMap.put("result", "NotDuplicated"); 
//	  }else if(mblCount >0){
//		  ajaxMap.put("result", "Duplicated"); 
//	  } 
//	  return ajaxMap; 
//	  }

	//�떊洹� 怨좉컼 �벑濡� 泥섎━
	@RequestMapping("/customer/registerSubmit.do")
	public String submitRegister(@ModelAttribute CustomerVO customerVO, Model model ) {
		
		customerService.custRegister(customerVO);								//怨좉컼�벑濡�
		model.addAttribute("customerVO", customerVO);
		
		return "/customer/register";
	}
	//회원 정보 가져오기
	@RequestMapping("/customer/showCustomer.do")
	public ModelAndView inquireCustomer(HttpServletRequest request) {				
		
		String cust_no = request.getParameter("cust_no");
		System.out.println("cust_no:"+cust_no);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("cust_no", cust_no);
		
		// 怨좉컼踰덊샇濡� �젙蹂� 媛��졇�삤湲�
		CustomerVO customer = customerService.getCustInfo(map);
		//�뤌�쓽 吏곸뾽肄붾뱶�쓽 list
		List<Map<String,Object>> codeList = customerService.getPocCode();
		 System.out.println("성별 :" +customer.getSex_cd());
		 System.out.println(customer.getBrdy_dt());
		 System.out.println("총 구매금액 : " + customer.getcTot_sal_amt());
		 System.out.println("월 구매금액 :" + customer.getmTot_sal_amt());
		  System.out.println("결혼기념일:" + customer.getMrrg_dt());
		
		ModelAndView mav = new ModelAndView("/customer/cusInfo");
		mav.addObject("customer", customer);
		mav.addObject("codeList", codeList);
		
		return mav;
	}
	
	
	  //회원 정보 검색
	  
	  @RequestMapping("/customer/getCustInfo.do")
	  @ResponseBody 
	  public Map<String,Object> getCustInfo(HttpServletRequest request){ 
	  
	  String cust_no = request.getParameter("cust_no");
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
		  
		  
		  model.addAttribute("customerVO", customerVO);
		  
		  return "/customer/result" ;
	  }
	
}
