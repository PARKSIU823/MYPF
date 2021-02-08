package com.mypf.ask.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AskCommVO {

	/*
	 * userNm : 회원 이름
	 * userId : 회원 아이디
	 * askNum : 글 번호
	 * commTitle : 글 제목
	 * commCon : 글 내용
	 * intDt : 작성일
	 */
	
	private String user_nm;
	private String user_id;
	private int ask_num;
	private String comm_title;
	private String comm_con;
	private Date int_dt;
}
