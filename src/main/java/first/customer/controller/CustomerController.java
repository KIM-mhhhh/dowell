package first.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.customer.service.CustomerService;
import first.customer.vo.CustomerVO;
import first.market.vo.MarketVO;
import first.record.vo.RecordVO;
import kr.util.FormatUtil;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	//고객전체조회
	@RequestMapping("/customer/searchCustomer.do")
	public ModelAndView searchCustomer() {
		
		
		List<CustomerVO> custList = customerService.getCustomerList();
		
		for(int i=0;i<custList.size();i++) {
			CustomerVO customer = custList.get(i);
			//고객상태
			customer.setCust_ss_cd(FormatUtil.CustomerState(customer.getCust_ss_cd()));
			//전화번호에 - 추가
			customer.setMbl_no(FormatUtil.phoneFormat(customer.getMbl_no()));
		}
		
		
		ModelAndView mv = new ModelAndView("/customer/cusSearch");
		mv.addObject("custList", custList);

		return mv;
	}
	
	//고객 이력 조회
	@RequestMapping("/customer/showRecord.do")
	public ModelAndView checkRecord(HttpServletRequest request) {				//링크로 고객 번호넘겨주기
		
		String cust_no = request.getParameter("cust_no");
		
		List<RecordVO> recordList = customerService.getRecord(cust_no);
		for(int i=0;i<recordList.size();i++) {
			RecordVO record = recordList.get(i);
			// 날짜 형식 바꾸기(string > string)
			 record.setChg_dt(FormatUtil.dateFormat(record.getChg_dt()));  
			//날짜 형식 바꾸기(date > string)
			  record.setStrLst_upd_dt(FormatUtil.chDateFormat(record.getLst_upd_dt()));
	
			// 변경항목이 고객상태인 경우 format 변환
			if(record.getChg_cd().equals("고객상태코드")) {
				record.setChg_bf_cnt(FormatUtil.CustomerState(record.getChg_bf_cnt()));
				record.setChg_aft_cnt(FormatUtil.CustomerState(record.getChg_aft_cnt()));
			}
			// 변경항목이 휴대폰 번호인 경우 format 변환
			else if(record.getChg_cd().equals("휴대폰번호")) {
				record.setChg_bf_cnt(FormatUtil.phoneFormat(record.getChg_bf_cnt()));
				record.setChg_aft_cnt(FormatUtil.phoneFormat(record.getChg_aft_cnt()));
			}
			// 변경항목이 성별인 경우 format 변환
			else if(record.getChg_cd().equals("성별코드")) {		
				if(record.getChg_bf_cnt().equalsIgnoreCase("M")) {
					record.setChg_bf_cnt("남");
				}else if(record.getChg_bf_cnt().equalsIgnoreCase("F")) {
					record.setChg_bf_cnt("여");
				}else {
					record.setChg_bf_cnt("-");
				}
				if(record.getChg_aft_cnt().equalsIgnoreCase("M")) {
					record.setChg_aft_cnt("남");
				}else if(record.getChg_aft_cnt().equalsIgnoreCase("F")) {
					record.setChg_aft_cnt("여");
				}else {
					record.setChg_aft_cnt("-");
				}
			}
			//변경항목이 생년월일인 경우 format 변환
			else if(record.getChg_cd().equals("생년월일")) {	
				record.setChg_bf_cnt(FormatUtil.dateFormat(record.getChg_bf_cnt()));
				record.setChg_aft_cnt(FormatUtil.dateFormat(record.getChg_aft_cnt()));
			}
			//변경항목이 직업코드인 경우 format변환 
			else if(record.getChg_cd().equals("직업코드")) {		
				if(record.getChg_bf_cnt().equals("10")){
					record.setChg_bf_cnt("학생");
				}else if(record.getChg_bf_cnt().equals("20")){
					record.setChg_bf_cnt("회사원");
				}else if(record.getChg_bf_cnt().equals("30")) {
					record.setChg_bf_cnt("공무원");
				}else if(record.getChg_bf_cnt().equals("40")) {
					record.setChg_bf_cnt("전문직");
				}else if(record.getChg_bf_cnt().equals("50")) {
					record.setChg_bf_cnt("군인");
				}else if(record.getChg_bf_cnt().equals("60")) {
					record.setChg_bf_cnt("주부");
				}else if(record.getChg_bf_cnt().equals("90")) {
					record.setChg_bf_cnt("연예인");
				}else if(record.getChg_bf_cnt().equals("99")) {
					record.setChg_bf_cnt("기타");
				}
				if(record.getChg_aft_cnt().equals("10")){
					record.setChg_aft_cnt("학생");
				}else if(record.getChg_aft_cnt().equals("20")){
					record.setChg_aft_cnt("회사원");
				}else if(record.getChg_aft_cnt().equals("30")) {
					record.setChg_aft_cnt("공무원");
				}else if(record.getChg_aft_cnt().equals("40")) {
					record.setChg_aft_cnt("전문직");
				}else if(record.getChg_aft_cnt().equals("50")) {
					record.setChg_aft_cnt("군인");
				}else if(record.getChg_aft_cnt().equals("60")) {
					record.setChg_aft_cnt("주부");
				}else if(record.getChg_aft_cnt().equals("90")) {
					record.setChg_aft_cnt("연예인");
				}else if(record.getChg_aft_cnt().equals("99")) {
					record.setChg_aft_cnt("기타");
				}
			}
		}
	
		ModelAndView mv = new ModelAndView("/customer/cusRecord");
		mv.addObject("cust_no", cust_no);
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
			
		int customerCount = customerService.CustomerCount(ajaxMap);
			
		List<CustomerVO> customer = customerService.searchCustomer(ajaxMap);
		for(int i=0;i<customer.size();i++) { 
			 CustomerVO custVO = customer.get(i); 
			 //고객 상태
			 if(custVO.getCust_ss_cd().equals("10")) { 
				 custVO.setCust_ss_cd("정상");
			 }else if(custVO.getCust_ss_cd().equals("80")){
				 custVO.setCust_ss_cd("중지"); 
			}else if(custVO.getCust_ss_cd().equals("90")){
				custVO.setCust_ss_cd("해지"); 
			}
			//전화번호에 - 추가
			 custVO.setMbl_no(FormatUtil.phoneFormat(custVO.getMbl_no())); 
		}
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

		System.out.println("전체" + cust_ss_cd);

		Map<String,Object> map = new HashMap<String,Object>();
			map.put("prt_cd", prt_cd);
			map.put("prt_nm", prt_nm); 
			map.put("cust_no", cust_no); 
			map.put("cust_nm", cust_nm);
			map.put("cust_ss_cd", cust_ss_cd); 
			map.put("fromDate", from); 
			map.put("toDate", to);

		int searchCount = customerService.getMainCount(map);
		List<CustomerVO> searchList = customerService.getMainCustomer(map);
		for(int i=0;i<searchList.size();i++) {
			CustomerVO customer = searchList.get(i);
			//고객상태
			if(customer.getCust_ss_cd().equals("10")) {
				customer.setCust_ss_cd("정상");
			}else if(customer.getCust_ss_cd().equals("80")){
				customer.setCust_ss_cd("중지");
			}else if(customer.getCust_ss_cd().equals("90")){
				customer.setCust_ss_cd("해지");	
			}
			customer.setCust_nm(FormatUtil.chName(customer.getCust_nm()));
		  //전화번호에 *처리, - 추가
		  customer.setMbl_no(FormatUtil.phoneFormat(FormatUtil.chPhone(customer.getMbl_no()))); 
		  //날짜 형식 바꾸기(string > string)
		  customer.setJs_dt(FormatUtil.dateFormat(customer.getJs_dt())); 
		//  System.out.println(customer.getLst_upd_dt());
		}
		
		Map<String,Object> ajaxMap = new HashMap<String,Object>();
		ajaxMap.put("count", searchCount);
		ajaxMap.put("list", searchList);
		
		return ajaxMap;
	}
}
