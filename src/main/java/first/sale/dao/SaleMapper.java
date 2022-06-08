package first.sale.dao;

import java.util.List;
import java.util.Map;

import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;

public interface SaleMapper {
	//재고 검색
	public List<ProductVO> getStockList(Map<String,Object> map);
	
	//고객판매관리 검색
	public List<SaleVO> getSaleList(Map<String,Object> map);
	
	//고객판매상세
	public List<SaleVO> getDetailSale(SaleVO saleVO);
	//카드코드
	public List<Map<String,Object>> getCrdCode();
	
	//판매등록(mt)
	public void registerSaleMt(SaleVO saleVO);
	//판매등록(dt)
	public void registerSaleDt(Map<String,Object> map);
	//판매 시 재고 삭감
	public void minusStock(Map<String,Object> map);
	
	//반품할 내역 가져오기(mt)
	public SaleVO getRet(SaleVO saleVO);
	//반품할 내역 가져오기(dt)
	public List<SaleVO> getRetDt(SaleVO saleVO);
	
	//반품 등록(mt)
	public void registerReturnMt(SaleVO saleVO);
	//반품 등록(dt)
	public void registerReturnDt(Map<String,Object> map);
	//반품 시 재고 +
	public void plusStock(Map<String,Object> map);
}
