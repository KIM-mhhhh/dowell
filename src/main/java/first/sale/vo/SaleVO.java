package first.sale.vo;

import java.util.Date;
import java.util.List;

public class SaleVO {
	
	private String prt_cd;
	private String sal_dt;
	private int sal_no;
	private String sal_tp_cd;
	private int tot_sal_qty;
	private int tot_sal_amt;
	private int tot_vos_amt;
	private int tot_vat_amt;
	private int csh_stlm_amt;
	private int crd_stlm_amt;
	private int pnt_stlm_amt;
	private String cust_no;
	private String cust_nm;
	private String crd_no;
	private String vld_ym;
	private String crd_co_cd;
	private String org_shop_cd;
	private String org_sal_dt;
	private String org_sal_no;
	private Date fst_reg_dt;
	private String sFst_reg_dt;							//등록일 char로 가져오기
	private String fst_user_id;
	private Date lst_upd_dt;
	private String lst_upd_id;							//CS_SAL01_DT
	private int prd_csmr_upr;
	
	private String prd_cd;
	private String prd_nm;
	private int sal_qty;
	private int sal_amt;
	private int sal_seq;
	private int sal_vos_amt;
	private int sal_vat_amt;
	

	
	public int getPrd_csmr_upr() {
		return prd_csmr_upr;
	}
	public void setPrd_csmr_upr(int prd_csmr_upr) {
		this.prd_csmr_upr = prd_csmr_upr;
	}
	public String getPrt_cd() {
		return prt_cd;
	}
	public void setPrt_cd(String prt_cd) {
		this.prt_cd = prt_cd;
	}
	public String getSal_dt() {
		return sal_dt;
	}
	public void setSal_dt(String sal_dt) {
		this.sal_dt = sal_dt;
	}
	public int getSal_no() {
		return sal_no;
	}
	public void setSal_no(int sal_no) {
		this.sal_no = sal_no;
	}
	public String getSal_tp_cd() {
		return sal_tp_cd;
	}
	public void setSal_tp_cd(String sal_tp_cd) {
		this.sal_tp_cd = sal_tp_cd;
	}
	public int getTot_sal_qty() {
		return tot_sal_qty;
	}
	public void setTot_sal_qty(int tot_sal_qty) {
		this.tot_sal_qty = tot_sal_qty;
	}
	public int getTot_sal_amt() {
		return tot_sal_amt;
	}
	public void setTot_sal_amt(int tot_sal_amt) {
		this.tot_sal_amt = tot_sal_amt;
	}
	public int getTot_vos_amt() {
		return tot_vos_amt;
	}
	public void setTot_vos_amt(int tot_vos_amt) {
		this.tot_vos_amt = tot_vos_amt;
	}
	public int getTot_vat_amt() {
		return tot_vat_amt;
	}
	public void setTot_vat_amt(int tot_vat_amt) {
		this.tot_vat_amt = tot_vat_amt;
	}
	public int getCsh_stlm_amt() {
		return csh_stlm_amt;
	}
	public void setCsh_stlm_amt(int csh_stlm_amt) {
		this.csh_stlm_amt = csh_stlm_amt;
	}
	public int getCrd_stlm_amt() {
		return crd_stlm_amt;
	}
	public void setCrd_stlm_amt(int crd_stlm_amt) {
		this.crd_stlm_amt = crd_stlm_amt;
	}
	public int getPnt_stlm_amt() {
		return pnt_stlm_amt;
	}
	public void setPnt_stlm_amt(int pnt_stlm_amt) {
		this.pnt_stlm_amt = pnt_stlm_amt;
	}
	public String getCust_no() {
		return cust_no;
	}
	public void setCust_no(String cust_no) {
		this.cust_no = cust_no;
	}
	public String getCrd_no() {
		return crd_no;
	}
	public void setCrd_no(String crd_no) {
		this.crd_no = crd_no;
	}
	public String getVld_ym() {
		return vld_ym;
	}
	public void setVld_ym(String vld_ym) {
		this.vld_ym = vld_ym;
	}
	public String getCrd_co_cd() {
		return crd_co_cd;
	}
	public void setCrd_co_cd(String crd_co_cd) {
		this.crd_co_cd = crd_co_cd;
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
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	
	
	public String getsFst_reg_dt() {
		return sFst_reg_dt;
	}
	public void setsFst_reg_dt(String sFst_reg_dt) {
		this.sFst_reg_dt = sFst_reg_dt;
	}
	
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
	public int getSal_qty() {
		return sal_qty;
	}
	public void setSal_qty(int sal_qty) {
		this.sal_qty = sal_qty;
	}
	public int getSal_amt() {
		return sal_amt;
	}
	public void setSal_amt(int sal_amt) {
		this.sal_amt = sal_amt;
	}
	public int getSal_seq() {
		return sal_seq;
	}
	public void setSal_seq(int sal_seq) {
		this.sal_seq = sal_seq;
	}
	
	public String getOrg_shop_cd() {
		return org_shop_cd;
	}
	public void setOrg_shop_cd(String org_shop_cd) {
		this.org_shop_cd = org_shop_cd;
	}
	public String getOrg_sal_dt() {
		return org_sal_dt;
	}
	public void setOrg_sal_dt(String org_sal_dt) {
		this.org_sal_dt = org_sal_dt;
	}
	public String getOrg_sal_no() {
		return org_sal_no;
	}
	public void setOrg_sal_no(String org_sal_no) {
		this.org_sal_no = org_sal_no;
	}
	public int getSal_vos_amt() {
		return sal_vos_amt;
	}
	public void setSal_vos_amt(int sal_vos_amt) {
		this.sal_vos_amt = sal_vos_amt;
	}
	public int getSal_vat_amt() {
		return sal_vat_amt;
	}
	public void setSal_vat_amt(int sal_vat_amt) {
		this.sal_vat_amt = sal_vat_amt;
	}
	@Override
	public String toString() {
		return "SaleVO [prt_cd=" + prt_cd + ", sal_dt=" + sal_dt + ", sal_no=" + sal_no + ", sal_tp_cd=" + sal_tp_cd
				+ ", tot_sal_qty=" + tot_sal_qty + ", tot_sal_amt=" + tot_sal_amt + ", tot_vos_amt=" + tot_vos_amt
				+ ", tot_vat_amt=" + tot_vat_amt + ", csh_stlm_amt=" + csh_stlm_amt + ", crd_stlm_amt=" + crd_stlm_amt
				+ ", pnt_stlm_amt=" + pnt_stlm_amt + ", cust_no=" + cust_no + ", cust_nm=" + cust_nm + ", crd_no="
				+ crd_no + ", vld_ym=" + vld_ym + ", crd_co_cd=" + crd_co_cd + ", org_shop_cd=" + org_shop_cd
				+ ", org_sal_dt=" + org_sal_dt + ", org_sal_no=" + org_sal_no + ", fst_reg_dt=" + fst_reg_dt
				+ ", sFst_reg_dt=" + sFst_reg_dt + ", fst_user_id=" + fst_user_id + ", lst_upd_dt=" + lst_upd_dt
				+ ", lst_upd_id=" + lst_upd_id + ", prd_csmr_upr=" + prd_csmr_upr + ", prd_cd=" + prd_cd + ", prd_nm="
				+ prd_nm + ", sal_qty=" + sal_qty + ", sal_amt=" + sal_amt + ", sal_seq=" + sal_seq + ", sal_vos_amt="
				+ sal_vos_amt + ", sal_vat_amt=" + sal_vat_amt + "]";
	}

	

	
	
	
	
	
	
	
}
