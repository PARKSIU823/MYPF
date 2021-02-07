package com.mypf.ask.vo;

import java.util.Date;

import lombok.Data;

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
	
	private String userId;
	private int askNum;
	private String writerNm;
	private String writerMail;
	private String askTitle;
	private String askCon;
	private char commYn;
	private Date insDt;
	
}
