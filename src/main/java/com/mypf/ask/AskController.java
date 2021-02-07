package com.mypf.ask;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/ask/*")
public class AskController {
	
	//문의하기
	@RequestMapping(value="send_ask.do", method = RequestMethod.POST)
	public String sendAsk(HttpServletRequest request, Model model) throws Exception {
		return "ask/send_ask";
	}
	
	//문의 리스트
	@RequestMapping(value="ask_list.do", method = RequestMethod.GET)
	public String askList(HttpServletRequest request, Model model) throws Exception {
		return "ask/ask_list";
	}
	
	//문의 상세 보기
	@RequestMapping(value="ask_detail.do", method = RequestMethod.GET)
	public String askDetail(HttpServletRequest request, Model model) throws Exception {
		return "ask/ask_detail";
	}
	
	//문의 답변하기
	@RequestMapping(value = "send_answer.do", method = RequestMethod.POST)
	public String sendAnswer(HttpServletRequest request, Model model) throws Exception {
		return "ask/ask_write";
	}

}
