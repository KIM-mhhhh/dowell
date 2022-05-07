package first.customer.vo;

import java.util.Date;

public class CustomerVO {					//������ ���̺�

	private String cust_no;				//����ȣ
	private String cust_nm;				//����
	private String sex_cd;				//�����ڵ�
	private String scal_yn;				//�����±���
	private String brdy_dt;				//�������
	private String mrrg_dt;				//��ȥ�����
	private String poc_cd;				//�����ڵ�
	private String mbl_no;				//�޴�����ȣ
	private String psmt_grc_cd;			//���������ڵ�
	private String email;				//�̸����ּ�
	private String zip_cd;				//�����ȣ�ڵ�
	private String addr;				//�ּ�
	private String addr_dtl;			//���ּ�
	private String cust_ss_cd;			//�������ڵ�
	private String cncl_cnts;			//������������
	private String jn_prt_cd;			//���Ը����ڵ�
	private String email_rcv_yn;		//�̸��ϼ��ŵ��ǿ���
	private String sms_rcv_yn;			//SMS���ŵ��ǿ���
	private String tm_rcv_yn;			//TM���ŵ��ǿ���
	private String dm_rcv_yn;			//DM���ŵ��ǿ���
	private String fst_js_dt;			//���ʰ�������
	private String js_dt;				//��������
	private String stp_dt;				//��������
	private String cncl_dt;				//��������
	private Date fst_user_dt;			//�����������
	private String fst_user_id;			//���ʵ����
	private Date lst_upd_dt;			//������������
	private String lst_upd_id;			//����������
	
	private String prt_nm;				// 조인해서 매장명(거래처명) 가져오기
	private String user_nm;				// 조인해서 등록자명 가져오기
	private String strLst_upd_dt;		// 수정일자 string으로 변환
	private String cTot_sal_amt;		// 조인해서 고객의 총 구매금액 가져오기
	private String mTot_sal_amt;		// 조인해서 당 월 총 구매금액
	private String lSal_dt;				// 조인해서 최종 구매일자
	
	public String getCust_no() {
		return cust_no;
	}
	public void setCust_no(String cust_no) {
		this.cust_no = cust_no;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getSex_cd() {
		return sex_cd;
	}
	public void setSex_cd(String sex_cd) {
		this.sex_cd = sex_cd;
	}
	public String getScal_yn() {
		return scal_yn;
	}
	public void setScal_yn(String scal_yn) {
		this.scal_yn = scal_yn;
	}
	public String getBrdy_dt() {
		return brdy_dt;
	}
	public void setBrdy_dt(String brdy_dt) {
		this.brdy_dt = brdy_dt;
	}
	public String getMrrg_dt() {
		return mrrg_dt;
	}
	public void setMrrg_dt(String mrrg_dt) {
		this.mrrg_dt = mrrg_dt;
	}
	public String getPoc_cd() {
		return poc_cd;
	}
	public void setPoc_cd(String poc_cd) {
		this.poc_cd = poc_cd;
	}
	public String getMbl_no() {
		return mbl_no;
	}
	public void setMbl_no(String mbl_no) {
		this.mbl_no = mbl_no;
	}
	public String getPsmt_grc_cd() {
		return psmt_grc_cd;
	}
	public void setPsmt_grc_cd(String psmt_grc_cd) {
		this.psmt_grc_cd = psmt_grc_cd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip_cd() {
		return zip_cd;
	}
	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_dtl() {
		return addr_dtl;
	}
	public void setAddr_dtl(String addr_dtl) {
		this.addr_dtl = addr_dtl;
	}
	public String getCust_ss_cd() {
		return cust_ss_cd;
	}
	public void setCust_ss_cd(String cust_ss_cd) {
		this.cust_ss_cd = cust_ss_cd;
	}
	public String getCncl_cnts() {
		return cncl_cnts;
	}
	public void setCncl_cnts(String cncl_cnts) {
		this.cncl_cnts = cncl_cnts;
	}
	public String getJn_prt_cd() {
		return jn_prt_cd;
	}
	public void setJn_prt_cd(String jn_prt_cd) {
		this.jn_prt_cd = jn_prt_cd;
	}
	public String getEmail_rcv_yn() {
		return email_rcv_yn;
	}
	public void setEmail_rcv_yn(String email_rcv_yn) {
		this.email_rcv_yn = email_rcv_yn;
	}
	public String getSms_rcv_yn() {
		return sms_rcv_yn;
	}
	public void setSms_rcv_yn(String sms_rcv_yn) {
		this.sms_rcv_yn = sms_rcv_yn;
	}
	public String getTm_rcv_yn() {
		return tm_rcv_yn;
	}
	public void setTm_rcv_yn(String tm_rcv_yn) {
		this.tm_rcv_yn = tm_rcv_yn;
	}
	public String getDm_rcv_yn() {
		return dm_rcv_yn;
	}
	public void setDm_rcv_yn(String dm_rcv_yn) {
		this.dm_rcv_yn = dm_rcv_yn;
	}
	public String getFst_js_dt() {
		return fst_js_dt;
	}
	public void setFst_js_dt(String fst_js_dt) {
		this.fst_js_dt = fst_js_dt;
	}
	public String getJs_dt() {
		return js_dt;
	}
	public void setJs_dt(String js_dt) {
		this.js_dt = js_dt;
	}
	public String getStp_dt() {
		return stp_dt;
	}
	public void setStp_dt(String stp_dt) {
		this.stp_dt = stp_dt;
	}
	public String getCncl_dt() {
		return cncl_dt;
	}
	public void setCncl_dt(String cncl_dt) {
		this.cncl_dt = cncl_dt;
	}
	public Date getFst_user_dt() {
		return fst_user_dt;
	}
	public void setFst_user_dt(Date fst_user_dt) {
		this.fst_user_dt = fst_user_dt;
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
	public String getPrt_nm() {
		return prt_nm;
	}
	public void setPrt_nm(String prt_nm) {
		this.prt_nm = prt_nm;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getStrLst_upd_dt() {
		return strLst_upd_dt;
	}
	public void setStrLst_upd_dt(String strLst_upd_dt) {
		this.strLst_upd_dt = strLst_upd_dt;
	}
	public String getcTot_sal_amt() {
		return cTot_sal_amt;
	}
	public void setcTot_sal_amt(String cTot_sal_amt) {
		this.cTot_sal_amt = cTot_sal_amt;
	}
	public String getmTot_sal_amt() {
		return mTot_sal_amt;
	}
	public void setmTot_sal_amt(String mTot_sal_amt) {
		this.mTot_sal_amt = mTot_sal_amt;
	}
	public String getlSal_dt() {
		return lSal_dt;
	}
	public void setlSal_dt(String lSal_dt) {
		this.lSal_dt = lSal_dt;
	}
	
	
	
	
}
