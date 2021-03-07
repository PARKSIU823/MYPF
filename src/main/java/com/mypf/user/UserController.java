package com.mypf.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mypf.user.service.UserService;
import com.mypf.user.vo.UserCriteria;
import com.mypf.user.vo.UserPageDTO;
import com.mypf.user.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService uService;
	
	//비밀번호 암호화
	BCryptPasswordEncoder pwdEncoder;
	
	//회원 가입
	@RequestMapping(value = "register.do", method = RequestMethod.GET)
	public String registerForm() throws Exception{
		return "user/register";
	}
	@RequestMapping(value = "register.do", method = RequestMethod.POST)
	public String register(UserVO user, Model model) throws Exception{
		log.info("회원 가입 : " + user);
		int result = uService.chkID(user);
		try {
			if(result == 1) {
				return "/user/register";
			} else if(result == 0) {
				//암호화 비밀번호
//				String userPW = user.getUser_pw();
//				String encodePW  = pwdEncoder.encode(userPW);
//				user.setUser_pw(encodePW);
				uService.register(user);
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
		model.addAttribute("success", "registercomplete");
		return "redirect:/user/login.do";
	}
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="chkID.do", method = RequestMethod.POST)
	public int chkID(UserVO user) throws Exception{
		int chkResult = uService.chkID(user);
		return chkResult;
	}
	
	//이메일 중복 체크
	@ResponseBody
	@RequestMapping(value="chkMail.do", method = RequestMethod.POST)
	public int chkMail(UserVO user) throws Exception{
		int chkResult = uService.chkMail(user);
		return chkResult;
	}
	
	//비밀번호 확인 페이지
	@RequestMapping(value="check_pw.do", method= RequestMethod.GET)
	public String chkPwForm() throws Exception {
		return "user/check_pw";
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
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String loginForm() throws Exception {
		return "user/login";
	}
	//로그인
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(UserVO user, HttpServletRequest request, Model model) throws Exception{
		log.info("로그인");
		HttpSession session = request.getSession();
		UserVO login = uService.userLogin(user);
//		boolean pwMatch = pwdEncoder.matches(user.getUser_pw(), login.getUser_pw());
//		if(login!= null && pwMatch == true) {
		if(login!= null) {
			session.setAttribute("user", login);
		}else {
			session.setAttribute("user", null);
			model.addAttribute("msg", false);
		}
		return "redirect:/index.do";
	}
	
	//로그아웃
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/index.do";
	}
	
	//회원 탈퇴 페이지
	@RequestMapping(value="remove.do", method= RequestMethod.GET)
	public String removeForm() throws Exception {
		return "user/remove";
	}
	//회원 삭제
	@RequestMapping(value = "remove.do", method = RequestMethod.POST)
	public String remove(UserVO user, HttpSession session, Model model) throws Exception{
		UserVO sessionUser = (UserVO) session.getAttribute("user");
		String sessionPW = sessionUser.getUser_pw();
		String userPW = user.getUser_pw();
		
		if(!(sessionPW.equals(userPW))) {
			model.addAttribute("msg", false);
			return "redirect:/user/remove.do";
		}
		uService.userDel(user);
		session.invalidate();
		return "redirect:/index.do";
	}
	
	//비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "check_pw.do", method = RequestMethod.POST)
	public int checkPw(UserVO user) throws Exception{
		int pwdChk = uService.chkPW(user);
//		boolean pwdChk = pwdEncoder.matches(user.getUser_pw(), login.getUser_pw());
		return pwdChk;
	}

	//회원정보 수정
	@RequestMapping(value = "modifyForm.do", method = RequestMethod.POST)
	public String modifyForm(UserVO user, HttpServletRequest request, Model model) throws Exception{
		log.info("회원 정보 수정 페이지 : " + user);
		model.addAttribute("model", user);
		return "user/modify";
	}
	@RequestMapping(value = "modify.do", method = RequestMethod.POST)
	public String modify(UserVO user, HttpSession session) throws Exception{
		log.info("회원 정보 수정 : " + user);
		uService.userMod(user);
		session.invalidate();
		return "redirect:/index.do";
	}
	
	//회원 관리 페이지
	@RequestMapping(value = "user_management.do", method = RequestMethod.GET)
	public String userManagement(UserCriteria cri, UserVO user, Model model) throws Exception{
		log.info("회원 정보 리스트");
		/*
		 * if(!session.getUserAuth == 'A') {
		 * return "redirect:/index.do";
		 * }else {
		 * }
		 */
		 model.addAttribute("userList", uService.userInfo(cri));
		 model.addAttribute("pageMaker", new UserPageDTO(cri, 10));
		return "user/user_management";
	}
	
	//회원 정보 수정
	@RequestMapping(value= "userAuth.do", method = RequestMethod.POST)
	public String userAuth(HttpServletRequest request, UserVO user, Model model) throws Exception{
		log.info("회원 권한 수정 : " +user);
//
//		HttpSession session = request.getSession();
//		UserVO sessionUser = (UserVO) session.getAttribute("user_auth");
//		  if(sessionUser.getUser_auth() != 'A') {
//		  return "redirect:/index.do";
//		  }else {
		  model.addAttribute("userAuth", "success");
		  uService.userAuth(user);
//		  }
		 
		return "redirect:/user/user_management.do";
	}

	//관리자 소개 페이지
	@RequestMapping(value="information.do", method = RequestMethod.GET)
	public String information(Model model) throws Exception {
		log.info("mUserIntroList");
		model.addAttribute("information", uService.mUserInfoList());
		return "user/information";
	}
}
