package first.sale.vo;

import java.util.Date;

public class ProductVO {
	
	private String prd_cd;
	private String prd_nm;
	private String prd_tp_cd;
	private int prd_csmr_upr;
	private int prd_pch_upr;
	private String tax_cs_cd;
	private String prd_ss_cd;
	private Date fst_reg_dt;
	private String fst_user_id;
	private Date lst_upd_dt;
	private String lst_upd_id;		
	
	private String prt_cd;
	private int ivco_qty;
	public String getPrd_cd() {
		return prd_cd;
	}
	public void setPrd_cd(String prd_cd) {
		this.prd_cd = prd_cd;
	}
	public String getPrd_nm() {
		return prd_nm;
	}
	public void setPrd_nm(String prd_nm) {
		this.prd_nm = prd_nm;
	}
	public String getPrd_tp_cd() {
		return prd_tp_cd;
	}
	public void setPrd_tp_cd(String prd_tp_cd) {
		this.prd_tp_cd = prd_tp_cd;
	}
	public int getPrd_csmr_upr() {
		return prd_csmr_upr;
	}
	public void setPrd_csmr_upr(int prd_csmr_upr) {
		this.prd_csmr_upr = prd_csmr_upr;
	}
	public int getPrd_pch_upr() {
		return prd_pch_upr;
	}
	public void setPrd_pch_upr(int prd_pch_upr) {
		this.prd_pch_upr = prd_pch_upr;
	}
	public String getTax_cs_cd() {
		return tax_cs_cd;
	}
	public void setTax_cs_cd(String tax_cs_cd) {
		this.tax_cs_cd = tax_cs_cd;
	}
	public String getPrd_ss_cd() {
		return prd_ss_cd;
	}
	public void setPrd_ss_cd(String prd_ss_cd) {
		this.prd_ss_cd = prd_ss_cd;
	}
	public Date getFst_reg_dt() {
		return fst_reg_dt;
	}
	public void setFst_reg_dt(Date fst_reg_dt) {
		this.fst_reg_dt = fst_reg_dt;
	}
	public String getFst_user_id() {
		return fst_user_id;
	}
	public void setFst_user_id(String fst_user_id) {
		this.fst_user_id = fst_user_id;
	}
	public Date getLst_upd_dt() {
		return lst_upd_dt;
	}
	public void setLst_upd_dt(Date lst_upd_dt) {
		this.lst_upd_dt = lst_upd_dt;
	}
	public String getLst_upd_id() {
		return lst_upd_id;
	}
	public void setLst_upd_id(String lst_upd_id) {
		this.lst_upd_id = lst_upd_id;
	}
	public String getPrt_cd() {
		return prt_cd;
	}
	public void setPrt_cd(String prt_cd) {
		this.prt_cd = prt_cd;
	}
	public int getIvco_qty() {
		return ivco_qty;
	}
	public void setIvco_qty(int ivco_qty) {
		this.ivco_qty = ivco_qty;
	}
	@Override
	public String toString() {
		return "ProductVO [prd_cd=" + prd_cd + ", prd_nm=" + prd_nm + ", prd_tp_cd=" + prd_tp_cd + ", prd_csmr_upr="
				+ prd_csmr_upr + ", prd_pch_upr=" + prd_pch_upr + ", tax_cs_cd=" + tax_cs_cd + ", prd_ss_cd="
				+ prd_ss_cd + ", fst_reg_dt=" + fst_reg_dt + ", fst_user_id=" + fst_user_id + ", lst_upd_dt="
				+ lst_upd_dt + ", lst_upd_id=" + lst_upd_id + ", prt_cd=" + prt_cd + ", ivco_qty=" + ivco_qty + "]";
	}
	
	
	
	
	
	
	
	
}
