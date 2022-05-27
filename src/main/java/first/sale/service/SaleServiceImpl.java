package first.sale.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.sale.dao.SaleMapper;
import first.sale.vo.ProductVO;
import first.sale.vo.SaleVO;

@Service
public class SaleServiceImpl implements SaleService{
	
	@Autowired
	private SaleMapper saleMapper;

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

}
