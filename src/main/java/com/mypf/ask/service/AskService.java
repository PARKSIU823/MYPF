package com.mypf.ask.service;

import java.util.List;

import com.mypf.ask.vo.AskVO;

public interface AskService {

	// 문의하기
	public void sendAsk(AskVO askVO) throws Exception ;
	
	// 문의 리스트
	public List<AskVO> askList() throws Exception;

	// 문의 상세 보기
	public AskVO askDetatil(int askNum) throws Exception;

	// 문의 답변하기
	public void sendAnswer(AskVO askVO) throws Exception;
}
