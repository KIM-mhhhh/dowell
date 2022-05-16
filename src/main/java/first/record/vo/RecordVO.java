package first.record.vo;

import java.util.Arrays;
import java.util.Date;

public class RecordVO {		//���̷� ���̺�

	private String cust_no;			//����ȣ
	private String chg_dt;			//��������
	private int chg_seq;			//�Ϸù�ȣ
	private String chg_cd;			//�����ڵ�
	private String chg_bf_cnt;		//����������
	private String chg_aft_cnt;		//������ ����
	private Date fst_reg_dt;		//���ʵ������
	private String fst_user_id;		//���ʵ����
	private Date lst_upd_dt;		//������������
	private String lst_upd_id;		//����������
	
	//수정자 이름 위한 이름(사용자 테이블에서 조인해서 가져오기)
	private String user_nm;
	private String sLst_upd_dt; 
	private String cust_nm;
	
	
	public String getCust_no() {
		return cust_no;
	}
	public void setCust_no(String cust_no) {
		this.cust_no = cust_no;
	}
	public String getChg_dt() {
		return chg_dt;
	}
	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}
	public int getChg_seq() {
		return chg_seq;
	}
	public void setChg_seq(int chg_seq) {
		this.chg_seq = chg_seq;
	}
	public String getChg_cd() {
		return chg_cd;
	}
	public void setChg_cd(String chg_cd) {
		this.chg_cd = chg_cd;
	}
	public String getChg_bf_cnt() {
		return chg_bf_cnt;
	}
	public void setChg_bf_cnt(String chg_bf_cnt) {
		this.chg_bf_cnt = chg_bf_cnt;
	}
	public String getChg_aft_cnt() {
		return chg_aft_cnt;
	}
	public void setChg_aft_cnt(String chg_aft_cnt) {
		this.chg_aft_cnt = chg_aft_cnt;
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
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getsLst_upd_dt() {
		return sLst_upd_dt;
	}
	public void setsLst_upd_dt(String sLst_upd_dt) {
		this.sLst_upd_dt = sLst_upd_dt;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}

	@Override
	public String toString() {
		return "RecordVO [cust_no=" + cust_no + ", chg_dt=" + chg_dt + ", chg_seq=" + chg_seq + ", chg_cd=" + chg_cd
				+ ", chg_bf_cnt=" + chg_bf_cnt + ", chg_aft_cnt=" + chg_aft_cnt + ", fst_reg_dt=" + fst_reg_dt
				+ ", fst_user_id=" + fst_user_id + ", lst_upd_dt=" + lst_upd_dt + ", lst_upd_id=" + lst_upd_id
				+ ", user_nm=" + user_nm + ", sLst_upd_dt=" + sLst_upd_dt + ", cust_nm=" + cust_nm +"]";
	}
	
	
	
	
	
}
