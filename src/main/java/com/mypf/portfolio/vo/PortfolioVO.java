package com.mypf.portfolio.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PortfolioVO {

	/*
	 * userNm : 회원 이름
	 * userId : 회원 아이디
	 * prtfNum : 글 번호
	 * prtfTitle : 글 제목
	 * prtfCon : 글 내용
	 * frmDt : 프로젝트 시작일
	 * toDt : 프로젝트 종료일
	 * url : 프로젝트 홈페이지 경로
	 * position : 프로젝트 역할
	 * idea : 느낀 점
	 * prtfHit : 조회수
	 * intDt : 작성일
	 * uptDt : 수정일
	 */
	
	private String userNm;
	private String userId;
	private int prtfNum;
	private String prtfTitle;
	private String prtfCon;
	private String frmDt;
	private String toDt;
	private String position;
	private String idea;
	private int prtfHit;
	private Date insDt;
	private Date uptDt;
	
}
