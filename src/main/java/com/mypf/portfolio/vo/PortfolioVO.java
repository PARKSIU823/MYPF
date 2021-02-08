package com.mypf.portfolio.vo;

import java.util.Date;

import lombok.Data;

public class PortfolioVO {

	/*
	 * user_id : 회원 이름 VARCHAR2(15) NOT NULL,  
	 * category : 카테고리 varchar2(50), 
	 * prtf_num : 글 번호 NUMBER(4, 0),
	 * prtf_title : 글 제목 VARCHAR2(100) NOT NULL, 
	 * prtf_con : 글 내용 VARCHAR2(4000) NOT NULL,  
	 * frm_dt date : 프로젝트 시작일 
	 * to_dt date : 프로젝트 종료일
	 * url : 깃 경로
	 * position : 프로젝트 역할
	 * idea VARCHAR2(4000) : 프로젝트 느낀 점
	 * hit : 조회수
	 * ins_dt : 등록일
	 * upt_dt : 수정일
	 */

	private String user_id;
	private String category;
	private int prtf_num;
	private String prtf_title;
	private String prtf_con;
	private Date frm_dt;
	private Date to_dt;
	private String url;
	private String position;
	private String idea;
	private int hit;
	private Date ins_dt;
	private Date upt_dt;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrtf_num() {
		return prtf_num;
	}
	public void setPrtf_num(int prtf_num) {
		this.prtf_num = prtf_num;
	}
	public String getPrtf_title() {
		return prtf_title;
	}
	public void setPrtf_title(String prtf_title) {
		this.prtf_title = prtf_title;
	}
	public String getPrtf_con() {
		return prtf_con;
	}
	public void setPrtf_con(String prtf_con) {
		this.prtf_con = prtf_con;
	}
	public Date getFrm_dt() {
		return frm_dt;
	}
	public void setFrm_dt(Date frm_dt) {
		this.frm_dt = frm_dt;
	}
	public Date getTo_dt() {
		return to_dt;
	}
	public void setTo_dt(Date to_dt) {
		this.to_dt = to_dt;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getIdea() {
		return idea;
	}
	public void setIdea(String idea) {
		this.idea = idea;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(Date ins_dt) {
		this.ins_dt = ins_dt;
	}
	public Date getUpt_dt() {
		return upt_dt;
	}
	public void setUpt_dt(Date upt_dt) {
		this.upt_dt = upt_dt;
	}

	
}
