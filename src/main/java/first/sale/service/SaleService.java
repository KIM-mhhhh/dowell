package first.sale.service;

import java.util.List;
import java.util.Map;

import first.sale.vo.ProductVO;

public interface SaleService {
	
	public List<ProductVO> getStockList(Map<String,Object> map);
}
