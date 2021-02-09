package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

}
