package com.mypf.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	/*
	 * user_nm : 회원 이름
	 * user_id : 회원 아이디
	 * user_pw : 회원 비밀번호
	 * user_mail : 회원 이메일
	 * user_addr : 회원 주소
	 * user_tel : 회원 전화번호
	 * user_photo : 회원 사진
	 * url : 홈페이지 주소
	 * user_auth : 회원 권한 (A:관리자 / U:일반회원)
	 * join_dt : 회원 가입일자
	 * upt_dt : 정보 수정일자
	 * user_count : 회원 수
	 */
	
	private String user_nm;
	private String user_id;
	private String user_pw;
	private String user_mail;
	private String zipcode;
	private String user_addr;
	private String addr01;
	private String addr02;
	private String addr03;
	private String user_tel;
	private String user_photo;
	private String url;
	private char user_auth;
	private Date join_dt;
	private Date upt_dt;
	private int user_count;
	
}
