package first.customer.service;

import java.util.List;
import java.util.Map;

import first.customer.vo.CustomerVO;
import first.record.vo.RecordVO;

public interface CustomerService {
	
	//고객 전체 리스트 조회
	public List<CustomerVO> getCustomerList();
	
	//고객번호로 고객 이력 가져오기.
	public List<RecordVO> getRecord(String cust_no);
	
	//고객 조회(고객이름, 핸드폰번호로)
	public List<CustomerVO> searchCustomer(Map<String,Object> map);
	
	//메인 검색 결과
	public List<CustomerVO> getMainCustomer(Map<String,Object> map);
	
	//핸드폰 번호 중복 검사
	public int getMblCheck(String mbl_no);
	
	//직업코드 가져오기
	public List<Map<String,Object>> getPocCode();
	
	//고객정보 가져오기
	public CustomerVO getCustInfo(String cust_no);
	
	//신규 고객 등록
	public void custRegister(CustomerVO customerVO);

}
