package com.mypf.tech.vo;

import java.util.Date;

import lombok.Data;
/* 기술 게시판 댓글 브이오 */
@Data
public class TechCommVO {
	/*
	 *	user_id : 회원 아이디
	 *	tech_num : 글 번호
	 *	comm_num : 댓글 번호
	 *	recomm_num : 대댓글 번호
	 *	comm_con : 댓글 내용
	 *	ins_dt : 작성일
	 *	upt_dt : 수정일
	 */
	private String user_id;
	private int tech_num;
	private int comm_num;
	private int recomm_num;
	private String comm_con;
	private Date ins_dt;
	private Date upt_dt;
	
}
