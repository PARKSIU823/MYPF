package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.user.vo.UserVO;

@Mapper
public interface UserMapper {

	// 회원 가입
	public void register(UserVO user) throws Exception;
	
	// 아이디 중복 체크
	public int chkID(UserVO user) throws Exception;

	// 아이디 찾기
	public UserVO findID(String userId) throws Exception;

	// 비밀번호 찾기
	public UserVO findPW(String userId) throws Exception;

	// 로그인
	public boolean userLogin(UserVO user) throws Exception;

	// 로그아웃
	public boolean userLogout(UserVO user) throws Exception;

	// 정보 관리
	public List<UserVO> userInfo() throws Exception;

	// 비밀번호 확인
	public boolean checkPW(UserVO user) throws Exception;

	// 회원정보 수정
	public UserVO userMod(UserVO user) throws Exception;

	// 회원 탈퇴
	public boolean userDel(String userID) throws Exception;
	
	//권한 수정
	public void userAuth(UserVO user) throws Exception;
	
	//관리자 소개
	public List<UserVO> mUserInfoList() throws Exception;

}
