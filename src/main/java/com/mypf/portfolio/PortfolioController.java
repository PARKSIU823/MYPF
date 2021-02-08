package com.mypf.portfolio;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PortfolioVO;
import com.mypf.tech.TechController;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/portfolio/*")
public class PortfolioController {

	//포트폴리오 게시판 리스트
	@RequestMapping(value = "pf_list.do", method=RequestMethod.GET)
	public String pfList(HttpServletRequest request, Model model)  throws Exception{
		return "portfolio/pf_list";
	}

	//포트폴리오 게시판 글 내용 조회
	@RequestMapping(value="pf_read.do", method=RequestMethod.GET)
	public String pfRead(HttpServletRequest request, Model model) throws Exception{
		return "portfolio/pf_read";
	}
	
	//포트폴리오 게시판 글 작성
	@RequestMapping(value="pf_write.do", method = RequestMethod.POST)
	public String pfWrite(HttpServletRequest request, Model model)  throws Exception{
		return "portfolio/pf_write";
	}
	
	//포트폴리오 게시판 글 수정
	@RequestMapping(value = "pf_modify.do", method = RequestMethod.POST)
	public String pfMod(HttpServletRequest request, Model model)  throws Exception{
		return "portfolio/modify";
	}
	
	//포트폴리오 게시판 글 삭제
	@RequestMapping(value = "pf_delete.do", method = RequestMethod.POST)
	public String pfDel(@RequestParam("prtf_num") int prtfNum, RedirectAttributes rttr)  throws Exception{
		return "redirect:portfolio/pf_list";
	}
}
