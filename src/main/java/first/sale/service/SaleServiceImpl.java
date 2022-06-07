package first.sale.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import first.sale.dao.SaleMapper;
import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;

@Service
public class SaleServiceImpl implements SaleService{
	
	@Autowired
	private SaleMapper saleMapper;
	@Autowired 
	private PlatformTransactionManager transactionManager;

	@Override
	public List<ProductVO> getStockList(Map<String, Object> map) {
		List<ProductVO> list = saleMapper.getStockList(map);
		return list;
	}

	@Override
	public List<SaleVO> getSaleList(Map<String, Object> map) {
		List<SaleVO> saleVO = saleMapper.getSaleList(map);
		return saleVO;
	}

	@Override
	public List<SaleVO> getDetailSale(SaleVO saleVO) {
		List<SaleVO> saleList = saleMapper.getDetailSale(saleVO);
		return saleList;
	}
	@SuppressWarnings("unchecked")
	@Override
	public void registerSale(Map<String, Object> map) {
		
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition()); 
		try {
		saleMapper.registerSaleMt((SaleVO) map.get("mtSaleVO"));
		saleMapper.registerSaleDt(map);
		saleMapper.minusStock(map);
		} catch (RuntimeException e) { 
			transactionManager.rollback(status); 
			throw e; 
		} 
		transactionManager.commit(status);
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public void registerReturn(Map<String, Object> map) {
		
	
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition()); 
		try {
		saleMapper.registerReturnMt((SaleVO) map.get("mtSaleVO"));
		saleMapper.registerReturnDt(map);
		saleMapper.plusStock((SaleVO) map.get("mtSaleVO"));
		}catch (RuntimeException e) { 
			transactionManager.rollback(status); 
			throw e; 
		} 
		transactionManager.commit(status);
	}

	@Override
	public List<Map<String, Object>> getCrdCode() {
		List<Map<String,Object>> crdList = saleMapper.getCrdCode();
		return crdList;
	}

}
