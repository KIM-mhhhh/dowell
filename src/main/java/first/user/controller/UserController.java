package first.user.controller;

import java.util.List;

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
import kr.util.FormatUtil;

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

		boolean check = false;
		UserVO user = userService.loginUser(id);

		if (user != null) {
			check = user.checkPassword(password);
		}
		if (check) { // 비밀번호 일치
			session.setAttribute("id", id);
			session.setAttribute("name", user.getUser_nm());
			session.setAttribute("password", password);
			
			MarketVO market = userService.getMarket(user.getPrt_cd());
			session.setAttribute("prt_dt_cd", market.getPrt_dt_cd());
			
			// 거래처 코드로 가져온 list(매장용)
			List<CustomerVO> custList = userService.getCustomer(user.getPrt_cd());
			for (int i = 0; i < custList.size(); i++) {
				CustomerVO customer = custList.get(i);
				// 고객 상태
				if (customer.getCust_ss_cd().equals("10")) {
					customer.setCust_ss_cd("정상");
				} else if (customer.getCust_ss_cd().equals("80")) {
					customer.setCust_ss_cd("중지");
				} else if (customer.getCust_ss_cd().equals("90")) {
					customer.setCust_ss_cd("해지");
				}
				 
				// 이름에 * 처리
				customer.setCust_nm(FormatUtil.chName(customer.getCust_nm()));
				// 전화번호에 *처리, - 추가
				customer.setMbl_no(FormatUtil.phoneFormat(FormatUtil.chPhone(customer.getMbl_no())));  
				//날짜 형식 바꾸기(date > string)
				  customer.setStrLst_upd_dt(FormatUtil.chDateFormat(customer.getLst_upd_dt()));
				 
			}
			// 전체 list (본사용)
			
			  List<CustomerVO> cList = customerService.getCustomerList(); 
			  for(int i=0;i<cList.size();i++) { 
				 CustomerVO customer = cList.get(i); 
				 //고객 상태
				 if(customer.getCust_ss_cd().equals("10")) { 
					 customer.setCust_ss_cd("정상");
				 }else if(customer.getCust_ss_cd().equals("80")){
					 customer.setCust_ss_cd("중지"); 
				}else if(customer.getCust_ss_cd().equals("90")){
					customer.setCust_ss_cd("해지"); 
				}
			  //이름에 * 처리 
				 customer.setCust_nm(FormatUtil.chName(customer.getCust_nm()));
			  //전화번호에 *처리, - 추가
			  customer.setMbl_no(FormatUtil.phoneFormat(FormatUtil.chPhone(customer.getMbl_no()))); 
			  //날짜 형식 바꾸기(date > string)
//			  customer.setStrLst_upd_dt(FormatUtil.chDateFormat(customer.getLst_upd_dt()));
			  }
			 
			ModelAndView mv = new ModelAndView("/customer/cusList");
			mv.addObject("market", market);
			mv.addObject("custList", custList);
			mv.addObject("cList", cList); 
			return mv;
		} else { // 불일치
			ModelAndView mv = new ModelAndView("/user/loginFailResult");
			return mv;
		}

	}

	@RequestMapping("/user/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "/user/logoutResult"; // 로그인 페이지로 돌아가게 하기.
	}

}
