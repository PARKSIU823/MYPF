package com.mypf.ask.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskVO;
import com.mypf.ask.vo.Criteria;
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
	public List<AskVO> askList(Criteria cri) throws Exception {
		return askMapper.askList(cri);
	}

	// 문의 게시판 글 총 갯수
	@Override
	public int askCount() throws Exception {
		return askMapper.askCount();
	}
	
	// 문의 게시판 상세 조회 및 답변
	@Override
	public AskVO askDetail(int ask_num) throws Exception {
		return askMapper.askDetail(ask_num);
	}

	//문의 답변하기
	@Override
	public void sendAnswer(AskVO askVO) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

}
