package com.mypf.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypf.mapper.UserMapper;
import com.mypf.user.service.UserService;
import com.mypf.user.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper uMapper;
	
	@Autowired
	private UserService uService;
	
	//회원 가입
	@Override
	public void register(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	//아이디 찾기
	@Override
	public UserVO findID(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//비밀번호 찾기
	public UserVO findPW(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//로그인
	@Override
	public boolean userLogin(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	//로그아웃
	@Override
	public boolean userLogout(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	

	//정보 관리
	@Override
	public List<UserVO> userInfo() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	//비밀번호 확인
	@Override
	public boolean checkPW(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	//회원정보 수정
	@Override
	public boolean userMod(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	
	//회원 탈퇴
	@Override
	public boolean userDel(String userID) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	//관리자 소개
	@Override
	public List<UserVO> mUserInfoList() throws Exception {
		log.info("관리자 소개");
		return uMapper.mUserInfoList();
	}

}
