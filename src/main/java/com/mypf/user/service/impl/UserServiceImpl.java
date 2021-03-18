package com.mypf.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypf.mapper.UserMapper;
import com.mypf.tech.vo.Criteria;
import com.mypf.user.service.UserService;
import com.mypf.user.vo.UserCriteria;
import com.mypf.user.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper uMapper;
	
	//회원 가입
	@Override
	public void register(UserVO user) throws Exception {
		log.info("회원 가입 : " +user);
		uMapper.register(user);
		
	}
	
	//아이디 중복 찾기
	@Override
	public int chkID(UserVO user) throws Exception{
		log.info("아이디 중복 체크 : " + user);
		return uMapper.chkID(user);
	}

	//이메일 중복 찾기
	@Override
	public int chkMail(UserVO user) throws Exception{
		log.info("아이디 중복 체크 : " + user);
		return uMapper.chkMail(user);
	}
	
	//이메일 인증
	@Override
	public void authKey(UserVO user) throws Exception{
		log.info("이메일 인증 : " + user);
		uMapper.authKey(user);
	}
	
	
	//아이디 찾기
	@Override
	public String findID(UserVO user) throws Exception {
		log.info("아이디 찾기 : " + user);
		return uMapper.findID(user);
	}

	//비밀번호 찾기
	public String findPW(UserVO user) throws Exception {
		log.info("아이디 찾기 : " + user);
		return uMapper.findPW(user);
	}

	//로그인
	@Override
	public UserVO userLogin(UserVO user) throws Exception {
		log.info("로그인 : " + user.getUser_id());
		return uMapper.userLogin(user);
	}	

	//회원 리스트
	@Override
	public List<UserVO> userInfo(UserCriteria cri) throws Exception {
		log.info("회원 리스트");
		return uMapper.userInfo(cri);
	}

	
	//비밀번호 확인
	@Override
	public int chkPW(UserVO user) throws Exception {
		log.info("비밀번호 확인 : " + user);
		return uMapper.chkPW(user);
	}

	//회원정보 수정
	@Override
	public void userMod(UserVO user) throws Exception {
		log.info("회원 정보 수정 : " + user);
		uMapper.userMod(user);
	}
	
	//회원 탈퇴
	@Override
	public void userDel(UserVO user) throws Exception {
		log.info("회원 탈퇴 : " + user);
		uMapper.userDel(user);
	}
	
	//회원 권한 수정
	@Override
	public void userAuth(UserVO user) throws Exception {
		log.info("회원 권한 수정 : " + user);
		uMapper.userAuth(user);
	}

	//관리자 소개
	@Override
	public List<UserVO> mUserInfoList() throws Exception {
		log.info("관리자 소개");
		return uMapper.mUserInfoList();
	}

	//회원 리스트 전체 회원 수
	@Override
	public int getTotal(UserCriteria cri) throws Exception {
		return uMapper.getTotalCount(cri);
	}

	//회원 권한 보기
	@Override
	public UserVO userAuthForm(UserVO user) throws Exception {
		log.info("회원 권한 수정");
		return uMapper.userAuthForm(user);
	}

}
