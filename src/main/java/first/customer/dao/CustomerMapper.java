package first.customer.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import first.customer.vo.CustomerVO;
import first.record.vo.RecordVO;

public interface CustomerMapper {
	
	//고객 전체 조회
	public List<CustomerVO> getCustomerList();
	//고객번호로 고객 이력 가져오기.
 	public List<RecordVO> getRecord(String cust_no);
	//고객 조회(고객이름, 핸드폰번호로)
	public List<CustomerVO> searchCustomer(Map<String,Object> map);
	//메인 검색 결과
	public List<CustomerVO> getMainCustomer(Map<String,Object> map);
	//핸드폰 번호 중복 검사
	public int getMblCheck(String mbl_no);
}
