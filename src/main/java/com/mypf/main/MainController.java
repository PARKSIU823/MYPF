package com.mypf.main;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mypf.portfolio.service.PortfolioService;
import com.mypf.portfolio.vo.PfCriteria;
import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	@Autowired
	private TechService techService;
	
	@Autowired
	private PortfolioService pfService;

	@RequestMapping(value = {"/index.do","/",""}, method = RequestMethod.GET)
	public String index(HttpServletRequest request, Model model, Criteria cri, PfCriteria pfCri) throws Exception {
		log.info("index");
		model.addAttribute("pfList", pfService.pfList(pfCri));
		model.addAttribute("techList", techService.techList(cri));
		return "main/index";
	}
}
