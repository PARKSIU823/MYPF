package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.tech.vo.Criteria;
import com.mypf.user.vo.UserCriteria;
import com.mypf.user.vo.UserVO;

@Mapper
public interface UserMapper {

	// 회원 가입
	public void register(UserVO user) throws Exception;
	
	// 아이디 중복 체크
	public int chkID(UserVO user) throws Exception;
	
	// 이메일 중복 체크
	public int chkMail(UserVO user) throws Exception;
	
	//이메일 인증
	public String authKey(UserVO user) throws Exception;

	// 아이디 찾기
	public String findID(UserVO user) throws Exception;

	// 비밀번호 찾기
	public String findPW(UserVO user) throws Exception;

	// 로그인
	public UserVO userLogin(UserVO user) throws Exception;

	// 정보 관리
	public List<UserVO> userInfo(UserCriteria cri) throws Exception;
	
	//회원 리스트 전체 회원 수
	public int getTotalCount(UserCriteria cri) throws Exception;

	// 비밀번호 확인
	public int chkPW(UserVO user) throws Exception;

	// 회원정보 수정
	public void userMod(UserVO user) throws Exception;

	// 회원 탈퇴
	public void userDel(UserVO user) throws Exception;
	
	//회원 권한 보기
	public UserVO userAuthForm(UserVO user) throws Exception;
	
	//권한 수정
	public void userAuth(UserVO user) throws Exception;
	
	//관리자 소개
	public List<UserVO> mUserInfoList() throws Exception;

}
