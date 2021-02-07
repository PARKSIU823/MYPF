package com.mypf.tech.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.TechVO;

@Service
public class TechServiceImpl implements TechService{

	//기술 게시판 목록 조회
	@Override
	public List<TechVO> techList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//기술 게시판 글 작성
	@Override
	public void techWrite(TechVO techVO) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//기술 게시판 글 상세 조회
	@Override
	public TechVO techDetail(int techNum) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//기술 게시판 글 수정
	@Override
	public void techMod(TechVO techVO) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//기술 게시판 글 삭제
	@Override
	public void techDel(int techNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
