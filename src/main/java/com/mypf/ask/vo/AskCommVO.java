package com.mypf.ask.vo;

import java.util.Date;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;

import lombok.Data;

@Data
public class AskCommVO {

	/*
	 * user_nm : 회원 이름
	 * user_id : 회원 아이디
	 * ask_num : 글 번호
	 * writer_mail : 수신자 이메일
	 * msg.addRecipient(RecipientType.TO, new InternetAddress(askcommVO.getWriter_mail()));
	 * 수신자 객체에 이메일 주소 담기 위해 추가
	 * comm_title : 글 제목
	 * comm_con : 글 내용
	 * ins_dt : 작성일
	 */
	
	private String user_nm;
	private String user_id;
	private int ask_num;
	private String writer_mail;
	private String comm_title;
	private String comm_con;
	private Date ins_dt;
}
