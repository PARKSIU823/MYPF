package com.mypf.tech;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
/* 기술 게시판 컨트롤러 */
@Controller
@Log4j
@RequestMapping("/tech/*")
public class TechController {
	
	//기술 게시판 목록 조회
	@RequestMapping(value="tech_list.do", method=RequestMethod.GET)
	public String techList(HttpServletRequest request, Model model) throws Exception {
		return "tech/tech_list";
	}
	
	//기술 게시판 글 작성
	@RequestMapping(value="tech_write.do", method=RequestMethod.POST)
	public String techWrite(HttpServletRequest request, Model model) throws Exception{
		return "redirect:tech/tech_list";
	}
	
	//기술 게시판 글 상세 조회
	@RequestMapping(value="tech_detail.do", method=RequestMethod.GET)
	public String techDetail(HttpServletRequest request, Model model) throws Exception{
		return "tech/tech_read";
	}
	
	//기술 게시판 글 수정
	@RequestMapping(value="tech_mod.do", method=RequestMethod.POST)
	public String techMod(HttpServletRequest request, Model model) throws Exception{
		return "tech/tech_modify";
	}
	
	//기술 게시판 글 삭제
	@RequestMapping(value="tech_del.do", method=RequestMethod.POST)
	public String techDel(HttpServletRequest request, Model model) throws Exception{
		return "redirect:tech/tech_list";
	}

}
