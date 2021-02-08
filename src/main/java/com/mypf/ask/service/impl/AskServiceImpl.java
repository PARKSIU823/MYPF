package com.mypf.ask.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskVO;
import com.mypf.mapper.AskMapper;

import lombok.extern.log4j.Log4j;
/* 문의 게시판 서비스 구현 */
@Service
@Log4j
public class AskServiceImpl implements AskService{
	
	@Resource(name="askMapper")
	AskMapper askMapper;
	
	// 문의 게시판 글 작성
	@Override
	public void sendAsk(AskVO askVO) throws Exception {
		askMapper.sendAsk(askVO);
	}

	// 문의 게시판 글 목록
	@Override
	public List<AskVO> askList() throws Exception {
		return askMapper.askList();
	}

	//문의 상세 보기
	@Override
	public AskVO askDetatil(int askNum) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//문의 답변하기
	@Override
	public void sendAnswer(AskVO askVO) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

}
