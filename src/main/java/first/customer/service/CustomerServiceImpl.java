package first.customer.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import first.customer.dao.CustomerMapper;
import first.customer.vo.CustomerVO;
import first.record.vo.RecordVO;

@Service

public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerMapper customerMapper;
	@Autowired 
	private PlatformTransactionManager transactionManager;


	
	//怨좉컼踰덊샇濡� 怨좉컼 �씠�젰 媛��졇�삤湲�.
	@Override
	public List<RecordVO> getRecord(String cust_no) {
		
		List<RecordVO> recordList = customerMapper.getRecord(cust_no);
		
		return recordList;
	}
	
	//怨좉컼 議고쉶(怨좉컼�씠由�, �빖�뱶�룿踰덊샇濡�)
	@Override
	public List<CustomerVO> searchCustomer(Map<String,Object> map) {
		
		List<CustomerVO> customer = customerMapper.searchCustomer(map);
		
		return customer;
	}
	//硫붿씤 寃��깋 寃곌낵
	@Override
	public List<CustomerVO> getMainCustomer(Map<String, Object> map) {
		List<CustomerVO> list = customerMapper.getMainCustomer(map);
		return list;
	}
	//�빖�뱶�룿 踰덊샇 以묐났 寃��궗
	@Override
	public int getMblCheck(String mbl_no) {
		int count = customerMapper.getMblCheck(mbl_no);
		return count;
	}
	//吏곸뾽肄붾뱶 媛��졇�삤湲�
	@Override
	public List<Map<String, Object>> getPocCode() {
		List<Map<String,Object>> pocList = customerMapper.getPocCode();
		return pocList;
	}
	//怨좉컼�젙蹂� 媛��졇�삤湲�
	@Override
	public CustomerVO getCustInfo(Map<String,Object> map) {
		CustomerVO customer = customerMapper.getCustInfo(map);
		return customer;
	}
	//�떊洹� 怨좉컼 �벑濡�
	@Override
	public void custRegister(CustomerVO customerVO) {
		customerMapper.custRegister(customerVO);
		
	}
	//고객 정보 수정
	@SuppressWarnings("unchecked")
	@Override
	public void custUpdate(Map<String,Object> map) {
		
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition()); 
		try {
			CustomerVO customerVO =(CustomerVO) map.get("customerVO");
			 customerMapper.custUpdate(customerVO);
			 
			 List<RecordVO> recList = (List<RecordVO>)map.get("recordList");
			 for(int i=0;i<recList.size();i++) {
				 RecordVO record = recList.get(i);
				 System.out.println(record.toString());
				 customerMapper.recordRegist(record);
			 }
		} catch (RuntimeException e) { 
			transactionManager.rollback(status); 
			throw e; 
		} 
		transactionManager.commit(status);

		
		
		
		
		
		 
		 
		 
		
	}

}
