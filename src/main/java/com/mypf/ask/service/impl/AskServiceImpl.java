package com.mypf.ask.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AskServiceImpl implements AskService{
	
	//문의하기
	@Override
	public void sendAsk(AskVO askVO) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//문의 리스트
	@Override
	public List<AskVO> askList() throws Exception {
		// TODO Auto-generated method stub
		return null;
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
