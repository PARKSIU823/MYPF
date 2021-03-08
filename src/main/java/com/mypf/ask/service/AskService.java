package com.mypf.ask.service;

import java.util.List;

import com.mypf.ask.vo.AskCommVO;
import com.mypf.ask.vo.AskVO;
import com.mypf.ask.vo.Criteria;
import com.mypf.ask.vo.SearchCriteria;
/* 문의 게시판 서비스 */
public interface AskService {

	// 문의 게시판 글 작성
	public void sendAsk(AskVO askVO) throws Exception;
	
	// 문의 게시판 글 목록
	public List<AskVO> askList(SearchCriteria scri) throws Exception;

	// 문의 게시판 글 총 갯수
	public int askCount(SearchCriteria scri) throws Exception;
	
	// 문의 게시판 문의 조회
	public AskVO askDetail(int ask_num) throws Exception;
	
	// 문의 게시판 답변 조회
	public AskCommVO commDetail(int ask_num) throws Exception;
	
	// 문의 게시판 답변 이메일 전송
	public void sendMail(AskCommVO askcommVO) throws Exception;
	
	// 문의 게시판 답변 DB 저장
	public void sendAnswer(AskCommVO askcommVO) throws Exception;

	// 문의 게시판 답변 여부 update
	public void updateCommYn(int ask_num) throws Exception;
}
