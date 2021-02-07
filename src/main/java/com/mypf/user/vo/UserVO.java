package com.mypf.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	/*
	 * userNm : 회원 이름
	 * userId : 회원 아이디
	 * userPw : 회원 비밀번호
	 * userMail : 회원 이메일
	 * userAddr : 회원 주소
	 * userTel : 회원 전화번호
	 * userPhoto : 회원 사진
	 * userAuth : 회원 권한 (A:관리자 / U:일반회원)
	 * joinDate : 회원 가입일자
	 * uptDate : 정보 수정일자
	 */
	
	private String userNm;
	private String userId;
	private String userPw;
	private String userMail;
	private String userAddr;
	private String userTel;
	private String userPhoto;
	private char userAuth;
	private Date joinDate;
	private Date uptDate;
	
}
