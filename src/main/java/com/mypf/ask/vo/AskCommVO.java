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
	
	private String userNm;
	private String userId;
	private int askNum;
	private String commTitle;
	private String commCon;
	private Date intDt;
}
