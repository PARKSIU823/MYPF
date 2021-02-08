package com.mypf.tech.service;

import java.util.List;

import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechVO;
/* 기술 게시판 서비스 */
public interface TechService {
	
	// 기술 게시판 목록 조회
	public List<TechVO> techList(Criteria cri) throws Exception;
	
	// 기술 게시판 글 작성
	public void techWrite(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 상세 조회
	public TechVO techDetail(int techNum) throws Exception;
	
	// 기술 게시판 글 수정
	public boolean techMod(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 삭제
	public boolean techDel(int techNum) throws Exception;

}
