package com.mypf.tech.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
/* 기술 게시판 브이오 */
@Data
public class TechVO {
	/*
	 * user_nm : 회원 이름
	 * user_id : 회원 아이디
	 * tech_num : 글 번호
	 * tech_category : 카테고리
	 * tech_title : 글 제목
	 * tech_con : 글 내용
	 * hit : 조회수
	 * ins_dt : 작성일
	 * upt_dt : 수정일
	 */
	private String user_nm;
	private String user_id;
	private int tech_num;
	private String tech_category;
	private String tech_title;
	private String tech_con;
	private int hit;
	private Date ins_dt;
	private Date upt_dt;
	
	private List<TechFileVO> fileList;
	

}
