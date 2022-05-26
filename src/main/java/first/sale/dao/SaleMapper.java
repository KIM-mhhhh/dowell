package first.sale.dao;

import java.util.List;
import java.util.Map;

import first.sale.vo.ProductVO;

public interface SaleMapper {

	public List<ProductVO> getStockList(Map<String,Object> map);
}
