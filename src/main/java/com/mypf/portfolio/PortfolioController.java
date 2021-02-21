package com.mypf.portfolio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PortfolioVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/portfolio/*")
public class PortfolioController {
	
	@Autowired
	private PortfolioService pfService;

	//포트폴리오 게시판 리스트
	@RequestMapping(value = "pf_list.do", method=RequestMethod.GET)
	public String pfList(Model model)  throws Exception{
		log.info("pfList");
		model.addAttribute("pfList", pfService.pfList());
		return "portfolio/pf_list";
	}

	//포트폴리오 게시판 글 내용 조회
	@RequestMapping(value="pf_read.do", method=RequestMethod.GET)
	public String pfRead(@RequestParam("prtf_num") int prtf_num, Model model) throws Exception{
		log.info("pf_read");
		model.addAttribute("pfRead", pfService.pfDetail(prtf_num));
		return "portfolio/pf_read";
	}
	
	//포트폴리오 게시판 글 작성 페이지
	@RequestMapping(value="pf_write.do", method = RequestMethod.GET)
	public String pfWriteform(Model model) throws Exception {
		log.info("포트폴리오 작성화면");
		return "portfolio/pf_write";
	}
	
	//포트폴리오 게시판 글 작성
	@RequestMapping(value="pf_write.do", method = RequestMethod.POST)
	public String pfWrite(PortfolioVO pf, Model model)  throws Exception{
		log.info("register" + pf);
		pfService.pfAdd(pf);
		model.addAttribute("result", pf.getPrtf_num());
		return "redirect:/portfolio/pf_list.do";
	}
	
	//포트폴리오 게시판 글 수정 페이지
	@RequestMapping(value = "pf_modify.do", method = RequestMethod.GET)
	public String pfModForm(@RequestParam("prtf_num") int prtf_num, Model model) throws Exception{
		log.info("포폴 글 수정 페이지");
		model.addAttribute("pfModify", pfService.pfDetail(prtf_num));
		return "portfolio/pf_modify";
	}
	
	//포트폴리오 게시판 글 수정
	@RequestMapping(value = "pf_modify.do", method = RequestMethod.POST)
	public String pfMod(PortfolioVO pf , Model model)  throws Exception{
		log.info("modify : " + pf);
		if(pfService.pfMod(pf)) {
			model.addAttribute("result", pf);
		}
		return "redirect:/portfolio/pf_read.do?prtf_num="+pf.getPrtf_num();
	}
	
	//포트폴리오 게시판 글 삭제
	@RequestMapping(value = "pf_delete.do", method = RequestMethod.POST)
	public String pfDel(@RequestParam("prtf_num") int prtf_num, Model model)  throws Exception{
		log.info("remove : " + prtf_num);
		if(pfService.pfDel(prtf_num)) {
			model.addAttribute("result", prtf_num);
		}
		return "redirect:portfolio/pf_list";
	}
}
