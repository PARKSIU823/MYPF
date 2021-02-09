package com.mypf.tech;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.PageDTO;
import com.mypf.tech.vo.TechVO;

import lombok.extern.log4j.Log4j;
/* 기술 게시판 컨트롤러 */
@Controller
@Log4j
@RequestMapping("/tech/*")
public class TechController {
	
	@Autowired
	private TechService service;
	
	// 기술 게시판 목록 조회
	@RequestMapping(value="tech_list.do", method=RequestMethod.GET)
	public void techList(HttpServletRequest request, Criteria cri, Model model) throws Exception {
		model.addAttribute("list", service.techList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 기술 게시판 글 작성 화면
	@RequestMapping(value="tech_write.do", method=RequestMethod.GET)
	public void techWrite() {
	}
	
	// 기술 게시판 글 작성
	@RequestMapping(value="tech_write.do", method=RequestMethod.POST)
	public String techWrite(TechVO techVO, RedirectAttributes rttr) throws Exception {
		service.techWrite(techVO);
		rttr.addFlashAttribute("result", techVO.getTech_num());
		return "redirect:tech_list.do";
	}
	
	// 기술 게시판 글 상세 조회
	@RequestMapping(value="tech_detail.do")
	public void techDetail(@RequestParam("tech_num") int tech_num, Model model) throws Exception {
		model.addAttribute("board", service.techDetail(tech_num));
	}
	
	// 기술 게시판 글 수정 화면
	@RequestMapping(value="tech_modify.do", method=RequestMethod.GET)
	public void techMod(@RequestParam("tech_num") int tech_num, Model model) throws Exception {
		model.addAttribute("board", service.techDetail(tech_num));
	}
	
	// 기술 게시판 글 수정
	@RequestMapping(value="tech_modify.do", method=RequestMethod.POST)
	public String techMod(TechVO techVO, RedirectAttributes rttr) throws Exception {
		if (service.techMod(techVO)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:tech_list.do";
	}
	
	// 기술 게시판 글 삭제
	@RequestMapping(value="tech_del.do", method=RequestMethod.POST)
	public String techDel(@RequestParam("tech_num") int tech_num, RedirectAttributes rttr) throws Exception {
		if (service.techDel(tech_num)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:tech_list.do";
	}
}
