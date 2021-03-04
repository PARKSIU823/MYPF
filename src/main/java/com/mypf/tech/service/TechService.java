package com.mypf.tech.service;

import java.util.List;

import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechCommVO;
import com.mypf.tech.vo.TechFileVO;
import com.mypf.tech.vo.TechVO;
/* 기술 게시판 서비스 */
public interface TechService {
	
	// 기술 게시판 목록 조회
	public List<TechVO> techList(Criteria cri) throws Exception;
	
	// 기술 게시판 전체 데이터의 개수 처리
	public int getTotal(Criteria cri) throws Exception;
	
	// 기술 게시판 글 작성
	public void techWrite(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 상세 조회
	public TechVO techDetail(int techNum) throws Exception;
	
	// 기술 게시판 글 조회수 +1 증가
	public void updateHit(int tech_num) throws Exception;
	
	// 기술 게시판 글 수정
	public boolean techMod(TechVO techVO) throws Exception;
	
	// 기술 게시판 글 삭제
	public boolean techDel(int techNum) throws Exception;
	
	// 기술 게시판 댓글 작성
	public int register(TechCommVO techcommVO) throws Exception;
	
	// 기술 게시판 댓글 조회
	public TechCommVO get(int comm_num) throws Exception;
	
	// 기술 게시판 댓글 수정
	public int modify(TechCommVO techcommVO) throws Exception;
	
	// 기술 게시판 댓글 삭제
	public int remove(int comm_num) throws Exception;
	
	// 기술 게시판 댓글 목록 조회
	public List<TechCommVO> getList(Criteria cri, int tech_num) throws Exception;
	
	// 기술 게시판 첨부파일 조회
	public List<TechFileVO> getFileList(int tech_num) throws Exception;
}