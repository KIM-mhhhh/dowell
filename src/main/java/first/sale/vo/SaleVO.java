package first.sale.vo;

import java.util.Date;

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
	private String crd_no;
	private String vld_ym;
	private String crd_co_cd;
	private Date fst_reg_dt;
	private String fst_user_id;
	private Date lst_upd_dt;
	private String lst_upd_id;							//CS_SAL01_DT
	

	
	
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
	@Override
	public String toString() {
		return "SaleVO [prt_cd=" + prt_cd + ", sal_dt=" + sal_dt + ", sal_no=" + sal_no + ", sal_tp_cd=" + sal_tp_cd
				+ ", tot_sal_qty=" + tot_sal_qty + ", tot_sal_amt=" + tot_sal_amt + ", tot_vos_amt=" + tot_vos_amt
				+ ", tot_vat_amt=" + tot_vat_amt + ", csh_stlm_amt=" + csh_stlm_amt + ", crd_stlm_amt=" + crd_stlm_amt
				+ ", pnt_stlm_amt=" + pnt_stlm_amt + ", cust_no=" + cust_no + ", crd_no=" + crd_no + ", vld_ym="
				+ vld_ym + ", crd_co_cd=" + crd_co_cd + ", fst_reg_dt=" + fst_reg_dt + ", fst_user_id=" + fst_user_id
				+ ", lst_upd_dt=" + lst_upd_dt + ", lst_upd_id=" + lst_upd_id + "]";
	}
	
	
	
	
}
