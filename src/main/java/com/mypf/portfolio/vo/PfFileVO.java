package com.mypf.portfolio.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PfFileVO {

	/*
	 * userId : 회원 이름
	 * prtfNum : 글 번호
	 * fileNm : 파일 이름
	 * fileNum : 파일 순서
	 * filePath : 파일 경로
	 * intDt : 작성일
	 * uptDt : 수정일
	 */
	
	private int prtf_num;
	private String file_nm;
	private String uuid;
	private String file_path;
	private Date ins_dt;
	private Date upt_dt;
	

}
