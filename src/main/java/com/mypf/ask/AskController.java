package com.mypf.ask;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskVO;

import lombok.extern.log4j.Log4j;
/* 문의 게시판 컨트롤러 */
@Controller
@Log4j
@RequestMapping("/ask/*")
public class AskController {
	
	@Autowired
	private AskService askService;
	
	// 문의 게시판 글 작성 화면
	@RequestMapping(value="ask_write.do", method = RequestMethod.GET)
	public String askWrite(HttpServletRequest request, Model model) throws Exception {
		return "ask/ask_write";
	}
	// 문의하기 게시판 글 작성
	@RequestMapping(value="send_ask.do", method=RequestMethod.POST)
	public String sendAsk(AskVO askVO, HttpServletRequest request, Model model) throws Exception{
		askService.sendAsk(askVO);
		return "redirect:ask_write.do";
	}
	
	// 문의 게시판 글 목록
	@RequestMapping(value="ask_list.do", method = RequestMethod.GET)
	public String askList(HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("list",askService.askList());
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
