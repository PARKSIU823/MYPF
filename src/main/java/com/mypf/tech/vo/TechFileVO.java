package com.mypf.tech.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TechFileVO {
	
	/*
	 * userId : 회원 아이디
	 * techNum : 글 번호
	 * fileNm : 파일 이름
	 * fileNum : 파일 순서
	 * filePath : 파일 경로
	 * insDt : 작성일
	 * uptDt : 수정일
	 */
	
	private String userNm;
	private String userId;
	private int techNum;
	private String techCategory;
	private String techTitle;
	private String techCon;
	private int techHit;
	private Date insDt;
	private Date uptDt;

}
