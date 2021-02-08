package com.mypf.ask.vo;

import java.util.Date;

import lombok.Data;
/* 문의 게시판 브이오 */
@Data
public class AskVO {

	/*
	 * user_id : 회원 아이디
	 * ask_num : 글 번호
	 * writer_nm : 작성자 이름
	 * writer_mail : 작성자 이메일
	 * ask_title : 글 제목
	 * ask_con : 글 내용
	 * comm_yn : 답변 여부
	 * ins_dt : 작성일
	 */
	
	private String user_id;
	private int ask_num;
	private String writer_nm;
	private String writer_mail;
	private String ask_title;
	private String ask_con;
	private char comm_yn;
	private Date ins_dt;
	
}
