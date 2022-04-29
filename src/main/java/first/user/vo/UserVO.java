package first.user.vo;

import java.util.Date;

public class UserVO {			//사용자 테이블
	
	private String user_id;			//사용자id
	private String user_nm;			//사용자명
	private String user_dt_cd;		//사용자구분코드
	private String use_yn;			//사용여부
	private String use_pwd;			//비밀번호
	private String st_dt;			//시작일자
	private String ed_dt;			//종료일자
	private String prt_cd;			//거래처코드
	private String pwd_upd_dt;		//비밀번호변경일자
	private Date fst_reg_dt;		//최초등록일자
	private String fst_user_id;		//최초등록자
	private Date lst_upd_dt;		//최종수정일자
	private String lst_upd_id;		//최종수정자
	
	//비밀번호 확인
	public boolean checkPassword(String password) {
		
		if(password.equals(use_pwd)) {
			return true;
		}else {
			return false;
		}
		
	}
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getUser_dt_cd() {
		return user_dt_cd;
	}
	public void setUser_dt_cd(String user_dt_cd) {
		this.user_dt_cd = user_dt_cd;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getUse_pwd() {
		return use_pwd;
	}
	public void setUse_pwd(String use_pwd) {
		this.use_pwd = use_pwd;
	}
	public String getSt_dt() {
		return st_dt;
	}
	public void setSt_dt(String st_dt) {
		this.st_dt = st_dt;
	}
	public String getEd_dt() {
		return ed_dt;
	}
	public void setEd_dt(String ed_dt) {
		this.ed_dt = ed_dt;
	}
	public String getPrt_cd() {
		return prt_cd;
	}
	public void setPrt_cd(String prt_cd) {
		this.prt_cd = prt_cd;
	}
	public String getPwd_upd_dt() {
		return pwd_upd_dt;
	}
	public void setPwd_upd_dt(String pwd_upd_dt) {
		this.pwd_upd_dt = pwd_upd_dt;
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
	
	

}
