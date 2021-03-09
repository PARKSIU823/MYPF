package com.mypf.ask;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskCommVO;
import com.mypf.ask.vo.AskVO;
import com.mypf.ask.vo.Criteria;
import com.mypf.ask.vo.PageMaker;
import com.mypf.ask.vo.SearchCriteria;

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
	public String askList(SearchCriteria scri, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("list",askService.askList(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(askService.askCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "ask/ask_list";
	}
	
	// 문의 게시판 문의 조회 및 답변 조회 화면 
	@RequestMapping(value="ask_detail.do", method = RequestMethod.GET)
	public String askDetail(AskVO askVO, AskCommVO askcommVO, HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("read", askService.askDetail(askVO.getAsk_num()));
		model.addAttribute("comm", askService.commDetail(askcommVO.getAsk_num()));
		return "ask/ask_detail";
	}
	
	//문의 게시판 답변 이메일 전송 & DB 저장
	@RequestMapping(value = "send_answer.do", method = RequestMethod.POST)
	public String sendAnswer(@ModelAttribute AskCommVO askcommVO, AskVO askVO, HttpServletRequest request, Model model) throws Exception {
		askService.sendAnswer(askcommVO);
		askService.updateCommYn(askVO.getAsk_num());
		try {
			askService.sendMail(askcommVO); //vo(답변관련 정보)를 sendMail에 저장함
			model.addAttribute("message", "문의 글에 대한 답변 이메일이 발송되었습니다."); //이메일이 발송되었다는 메시지를 출력시킨다.
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "문의 글에 대한 답변 이메일 발송 실패"); //이메일 발송이 실패되었다는 메시지를 출력
		}
		return "redirect:ask_list.do";
		}
	}