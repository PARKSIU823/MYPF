package com.mypf.user;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mypf.user.service.UserService;
import com.mypf.user.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService uService;
	
	//회원 가입
	@RequestMapping(value = "register.do", method = RequestMethod.GET)
	public String registerForm() throws Exception{
		return "user/register";
	}
	@RequestMapping(value = "register.do", method = RequestMethod.POST)
	public String register(UserVO user, Model model) throws Exception{
		log.info("회원 가입");
		String user_mail = "testmail@test.com";
		user.setUser_mail(user_mail);
		uService.register(user);
		return "user/register";
	}
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="chkID.do", method = RequestMethod.POST)
	public int chkID(UserVO user) throws Exception{
		int chkResult = uService.chkID(user);
		return chkResult;
	}
	
	//아이디 찾기 페이지
	@RequestMapping(value = "find_id.do", method = RequestMethod.POST)
	public String findId(HttpServletRequest request, Model model) throws Exception{
		return "user/find_id";
	}
	
	//비밀번호 찾기 페이지
	@RequestMapping(value = "find_pw.do", method = RequestMethod.POST)
	public String findPw(HttpServletRequest request, Model model) throws Exception{
		return "user/find_pw";
	}
	
	//로그인 페이지
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model) throws Exception{
		return "user/login";
	}
	
	//회원 삭제 페이지
	@RequestMapping(value = "remove.do", method = RequestMethod.POST)
	public String remove(HttpServletRequest request, Model model) throws Exception{
		return "user/remove";
	}
	
	//비밀번호 확인 페이지
	@RequestMapping(value = "check_pw.do", method = RequestMethod.POST)
	public String checkPw(HttpServletRequest request, Model model) throws Exception{
		return "user/check_pw";
	}

	//회원정보 수정
	@RequestMapping(value = "modify.do", method = RequestMethod.GET)
	public String modifyForm(HttpServletRequest request, Model model) throws Exception{
		return "user/modify";
	}
	@RequestMapping(value = "modify.do", method = RequestMethod.POST)
	public String modify(UserVO user, Model model) throws Exception{
		log.info("회원 정보 수정 : " + user);
		uService.userMod(user);
		return "user/modify";
	}
	
	//회원 관리 페이지
	@RequestMapping(value = "user_management.do", method = RequestMethod.POST)
	public String userManagement(HttpServletRequest request, Model model) throws Exception{
		return "user/user_management";
	}

	//관리자 소개 페이지
	@RequestMapping(value="information.do", method = RequestMethod.GET)
	public String information(Model model) throws Exception {
		log.info("mUserIntroList");
		model.addAttribute("information", uService.mUserInfoList());
		return "user/information";
	}
}
