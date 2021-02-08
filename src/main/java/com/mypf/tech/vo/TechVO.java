package com.mypf.tech.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TechVO {
	/*
	 * userNm : 회원 이름
	 * userId : 회원 아이디
	 * techNum : 글 번호
	 * techCategory : 카테고리
	 * techTitle : 글 제목
	 * techCon : 글 내용
	 * Hit : 조회수
	 * insDt : 작성일
	 * uptDt : 수정일
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

}
