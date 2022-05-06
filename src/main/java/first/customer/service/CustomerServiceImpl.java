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
	
	@Override
	public List<RecordVO> getRecord(String cust_no) {
		
		List<RecordVO> recordList = customerMapper.getRecord(cust_no);
		
		return recordList;
	}

	@Override
	public List<CustomerVO> getCustomerList() {
		List<CustomerVO> customerList = customerMapper.getCustomerList();
		return customerList;
	}

	@Override
	public List<CustomerVO> searchCustomer(Map<String,Object> map) {
		
		List<CustomerVO> customer = customerMapper.searchCustomer(map);
		
		return customer;
	}

	@Override
	public List<CustomerVO> getMainCustomer(Map<String, Object> map) {
		List<CustomerVO> list = customerMapper.getMainCustomer(map);
		return list;
	}

	@Override
	public int getMblCheck(String mbl_no) {
		int count = customerMapper.getMblCheck(mbl_no);
		return count;
	}

	@Override
	public List<Map<String, Object>> getPocCode() {
		List<Map<String,Object>> pocList = customerMapper.getPocCode();
		return pocList;
	}

}
