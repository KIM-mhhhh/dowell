package first.user.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import first.customer.service.CustomerService;
import first.customer.vo.CustomerVO;
import first.market.vo.MarketVO;
import first.user.service.UserService;
import first.user.vo.UserVO;


@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@RequestMapping("/loginSubmit.do")
	public ModelAndView submitLogin(HttpServletRequest request, HttpSession session) {

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		System.out.println("id : " + id + "/password:" + password);

		boolean check = false;
		UserVO user = userService.loginUser(id);

		if (user != null) {													//아이디가 존재할 경우 비밀번호 체크
			check = user.checkPassword(password);
		}
		if (check) { 														// 비밀번호 일치할 경우 로그인 처리. 세션에 정보 저장.
			session.setAttribute("id", id);
			session.setAttribute("name", user.getUser_nm());
			session.setAttribute("password", password);
			
			MarketVO market = userService.getMarket(user.getPrt_cd());		//매장코드로 해당 매장의 정보 불러오기
			session.setAttribute("prt_dt_cd", market.getPrt_dt_cd());
			session.setAttribute("prt_cd", market.getPrt_cd());
			session.setAttribute("prt_nm", market.getPrt_nm());
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("uPrt_dt_cd", market.getPrt_dt_cd());
			if(market.getPrt_dt_cd().equals("2")) {
				map.put("prt_cd", market.getPrt_cd());
			}
			
			//검색폼 state의 list
			List<Map<String,Object>> codeList = userService.getSScode();

			// list를 가져오기 위한 날짜 조건 넣기
				//오늘 날짜
			  Date today = new Date(); 
			  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 
			  String toToday = sdf.format(today); 
			  	//일주일 전 날짜
			  Calendar calendar = Calendar.getInstance();
			  calendar.add(Calendar.DAY_OF_MONTH, -7); 
			  Date date = calendar.getTime();
			  String fromD = sdf.format(date); 
			  System.out.println("toToday : " + toToday +"/ fromDate:"+fromD);
			  
			  map.put("fromDate", fromD); 
			  map.put("toDate", toToday);
			  map.put("cust_ss_cd","0");
			  
			  List<CustomerVO> custList = customerService.getMainCustomer(map); 		//날짜가 최근 일주일이고 고객상태코드가 전체인 회원의 목록 불러오기
			  int searchCount = custList.size();
			 
			ModelAndView mv = new ModelAndView("/customer/cusList");					//고객조회 창으로 불러온 list와 정보들을 보내준다.
			mv.addObject("count", searchCount);
			mv.addObject("market", market);
			mv.addObject("custList", custList);
			mv.addObject("codeList", codeList);
			return mv;
		} else { 																		//비밀번호 불일치 시 실패화면으로 이동.
			ModelAndView mv = new ModelAndView("/user/loginFailResult");
			return mv;
		}

	}
	
	//로그아웃
	@RequestMapping("/user/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();					
		return "/user/logoutResult"; 			// 로그인 페이지로 돌아가게 하기.
	}

}
