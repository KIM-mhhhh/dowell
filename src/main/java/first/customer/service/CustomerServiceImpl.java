package first.customer.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.customer.dao.CustomerMapper;
import first.customer.vo.CustomerVO;
import first.record.vo.RecordVO;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerMapper customerMapper;
	
	//고객번호로 고객 이력 가져오기.
	@Override
	public List<RecordVO> getRecord(String cust_no) {
		
		List<RecordVO> recordList = customerMapper.getRecord(cust_no);
		
		return recordList;
	}
	
	//고객 조회(고객이름, 핸드폰번호로)
	@Override
	public List<CustomerVO> searchCustomer(Map<String,Object> map) {
		
		List<CustomerVO> customer = customerMapper.searchCustomer(map);
		
		return customer;
	}
	//메인 검색 결과
	@Override
	public List<CustomerVO> getMainCustomer(Map<String, Object> map) {
		List<CustomerVO> list = customerMapper.getMainCustomer(map);
		return list;
	}
	//핸드폰 번호 중복 검사
	@Override
	public int getMblCheck(String mbl_no) {
		int count = customerMapper.getMblCheck(mbl_no);
		return count;
	}
	//직업코드 가져오기
	@Override
	public List<Map<String, Object>> getPocCode() {
		List<Map<String,Object>> pocList = customerMapper.getPocCode();
		return pocList;
	}
	//고객정보 가져오기
	@Override
	public CustomerVO getCustInfo(String cust_no) {
		CustomerVO customer = customerMapper.getCustInfo(cust_no);
		return customer;
	}
	//신규 고객 등록
	@Override
	public void custRegister(CustomerVO customerVO) {
		customerMapper.custRegister(customerVO);
		
	}

}
