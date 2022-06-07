package first.sale.service;

import java.util.List;
import java.util.Map;

import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;

public interface SaleService {
	//재고 list 검색
	public List<ProductVO> getStockList(Map<String,Object> map);
	//고객판매관리 검색
	public List<SaleVO> getSaleList(Map<String,Object> map);
	//고객판매상세
	public List<SaleVO> getDetailSale(SaleVO saleVO);
	
	//카드코드
	public List<Map<String,Object>> getCrdCode();
	
	//판매등록
	public void registerSale(Map<String,Object> map);
	//반품등록
	public void registerReturn(Map<String,Object> map);
}
