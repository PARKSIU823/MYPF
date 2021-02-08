package com.mypf.ask.vo;

import java.util.Date;

import lombok.Data;
/* 문의 게시판 브이오 */
@Data
public class AskVO {

	/*
	 * userId : 회원 아이디
	 * askNum : 글 번호
	 * writerNm : 작성자 이름
	 * writerMail : 작성자 이메일
	 * askTitle : 글 제목
	 * askCon : 글 내용
	 * commYn : 답변 여부
	 * intDt : 작성일
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
