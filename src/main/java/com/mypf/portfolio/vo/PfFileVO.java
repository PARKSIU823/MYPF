package com.mypf.portfolio.vo;

import java.util.Date;

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
	
	private String userId;
	private int prtfNum;
	private String fileNm;
	private String uuid;
	private int fileNum;
	private String filePath;
	private Date insDt;
	private Date uptDt;

}
