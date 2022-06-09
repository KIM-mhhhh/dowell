package first.sale.service;

import java.util.HashMap;
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
	public void registerReturn(Map<String,Object> omap) {
		
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition()); 
		try {
			
			Map<String, Object> map = new HashMap<String,Object>();
			SaleVO mtSaleVO = saleMapper.getRet((SaleVO) omap.get("saleVO"));
			mtSaleVO.setLst_upd_id((String) omap.get("id"));
			
			List<SaleVO> saleList = saleMapper.getDetailSale((SaleVO) omap.get("saleVO"));
			System.out.println("반품dtlist:"+saleList);
			if(mtSaleVO.getCrd_no() == null) {
				mtSaleVO.setCrd_no("");
			}
			if(mtSaleVO.getVld_ym() == null) {
				mtSaleVO.setVld_ym("");
			}			
			if(mtSaleVO.getCrd_co_cd() == null) {
				mtSaleVO.setCrd_co_cd("");
			}
			System.out.println("반품mt:"+mtSaleVO);
			/*
			 * for(int i=0;i<saleList.size();i++) { SaleVO saleVO = saleList.get(i);
			 * if(saleVO.getCsh_stlm_amt() ) {
			 * 
			 * } }
			 */
			
			map.put("saleVO", mtSaleVO);
			map.put("list", saleList);
			map.put("id",(String) omap.get("id"));
			
			saleMapper.registerReturnMt(mtSaleVO);
			System.out.println("mt완료");
			saleMapper.registerReturnDt(map);
			saleMapper.plusStock(map);
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
