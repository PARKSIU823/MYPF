package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.ask.vo.AskCommVO;
import com.mypf.ask.vo.AskVO;
import com.mypf.ask.vo.Criteria;
/* 문의 게시판 메퍼 인터페이스 */
@Mapper
public interface AskMapper {
	
	// 문의 게시판 글 작성
	public void sendAsk(AskVO askVO) throws Exception;
	
	// 문의 게시판 글 목록
	public List<AskVO> askList(Criteria cri) throws Exception;
	
	// 문의 게시판 글 총 갯수
	public int askCount() throws Exception;
	
	// 문의 게시판 문의 조회
	public AskVO askDetail(int ask_num) throws Exception;
	
	// 문의 게시판 답변 조회
	public AskCommVO commDetail(int ask_num) throws Exception;

	// 문의 게시판 답변 DB 저장
	public void sendAnswer(AskCommVO askcommVO) throws Exception;
	
	// 문의 게시판 답변 여부 update
	public void updateCommYn(int ask_num) throws Exception;

}
