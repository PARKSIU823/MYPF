package com.mypf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mypf.ask.vo.AskVO;
/* 문의 게시판 메퍼 인터페이스 */
@Mapper
public interface AskMapper {
	public void sendAsk(AskVO askVO) throws Exception;

	public List<AskVO> askList() throws Exception;

}
