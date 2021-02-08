package com.mypf.tech.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TechFileVO {
	
	/*
	 * user_nm : 회원 이름
	 * user_id : 회원 아이디
	 * tech_num : 글 번호
	 * file_num : 파일 번호
	 * file_path : 파일 경로
	 * file_nm : 파일 이름
	 * ins_dt : 작성일
	 * upt_dt : 수정일
	 */
	
	private String user_nm;
	private String user_id;
	private int tech_num;
	private String file_num;
	private String file_path;
	private int file_nm;
	private Date ins_dt;
	private Date upt_dt;

}
