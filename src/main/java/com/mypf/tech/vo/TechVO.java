package com.mypf.tech.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TechVO {
	/*
	 * userNm : 회원 이름
	 * userId : 회원 아이디
	 * techNum : 글 번호
	 * techCategory : 카테고리
	 * techTitle : 글 제목
	 * techCon : 글 내용
	 * Hit : 조회수
	 * insDt : 작성일
	 * uptDt : 수정일
	 */
	private String userNm;
	private String userId;
	private int techNum;
	private String techCategory;
	private String techTitle;
	private String techCon;
	private int Hit;
	private Date insDt;
	private Date uptDt;

}
