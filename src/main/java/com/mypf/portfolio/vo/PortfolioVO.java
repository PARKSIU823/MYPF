package com.mypf.portfolio.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
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
	private String frm_dt;
	private String to_dt;
//	private Date frm_dt;
//	private Date to_dt;
	private String url;
	private String position;
	private String idea;
	private int hit;
	private Date ins_dt;
	private Date upt_dt;
	
	public List<PfFileVO> pfFileList;

	
}
