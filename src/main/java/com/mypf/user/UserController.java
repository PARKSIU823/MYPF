package com.mypf.user;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		
	@Autowired
	private JavaMailSender mailSender;
	
	private boolean lowerCheck;
	private int size;

	//회원 가입
	@RequestMapping(value = "register.do", method = RequestMethod.GET)
	public String registerForm() throws Exception{
		return "user/register";
	}

	@RequestMapping(value = "register.do", method = RequestMethod.POST)
	public String register(UserVO user, Model model, HttpServletRequest request) throws Exception{
		log.info("회원 가입 : " + user);
		int result = uService.chkID(user);
		try {
			if(result == 1) {
				return "/user/register";
			} else if(result == 0) {
				//비밀번호 암호화
				BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
				String userPW = user.getUser_pw();
				String encodePW  = pwdEncoder.encode(userPW);
				user.setUser_pw(encodePW);
				uService.register(user);
//				String key = getKey(false, 20);
//				String user_mail = user.getUser_mail();
//				MimeMessage mail = mailSender.createMimeMessage();
//				String htmlStr = "<h2>안녕하세요. </h2><br><br>" 
//						+ "<h3>" + user.getUser_id() + "님</h3>" + "<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다 : " 
//						+ "<a href='http://localhost:8520" + request.getContextPath() + "/user/user_key.do?user_id="+ user.getUser_id() +"&user_key="+key+"'>인증하기</a></p>";
//				try {
//					mail.setSubject("[MYPF] 회원 가입 인증 메일입니다", "utf-8");
//					mail.setText(htmlStr,"utf-8","html");
//					mail.addRecipient(RecipientType.TO, new InternetAddress(user_mail));
//					mailSender.send(mail);
//				} catch (MessagingException e) {
//					e.printStackTrace();
//				}
	
			}

		} catch (Exception e) {
			throw new RuntimeException();
		}
		model.addAttribute("msg_register", user);
		return "redirect:/user/login.do";
	}

//	//회원 가입 난수 생성 
//	private String init() {
//		Random random = new Random();
//		StringBuffer sb = new StringBuffer();
//		int num = 0;
//		do {
//			num = random.nextInt(75) + 48;
//			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
//				sb.append((char) num);
//			} else {
//				continue;
//			}
//			
//		} while (sb.length() < size);
//		if (lowerCheck) {
//			return sb.toString().toLowerCase();
//		}
//		return sb.toString();
//	}
//	
//	//회원 가입 시 난수 이용 키 생성
//	private String getKey(boolean lowerCheck, int size) {
//		this.lowerCheck = lowerCheck;
//		this.size = size;
//		return init();
//	}
//		
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
	
	//아이디 찾기
	@RequestMapping(value = "find_id.do", method = RequestMethod.GET)
	public String findIdForm(HttpServletRequest request, Model model) throws Exception{
		return "user/find_id";
	}

	@ResponseBody
	@RequestMapping(value = "find_id.do", method = RequestMethod.POST)
	public String findId(UserVO user, Model model) throws Exception{
		String user_id=  uService.findID(user);
		return user_id;
	}
	
	//비밀번호 찾기
	@RequestMapping(value = "find_pw.do", method = RequestMethod.GET)
	public String findPwForm(HttpServletRequest request, Model model) throws Exception{
		return "user/find_pw";
	}

	@ResponseBody
	@RequestMapping(value = "find_pw.do", method = RequestMethod.POST)
	public String findPw(UserVO user, Model model) throws Exception{
		//비밀번호 암호화
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String userPW = user.getUser_pw();
		String encodePW  = pwdEncoder.encode(userPW);
		return encodePW;
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
		//세션 생성
		HttpSession session = request.getSession();
		UserVO login = uService.userLogin(user);
		//비밀번호 암호화
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		boolean pwMatch = pwdEncoder.matches(user.getUser_pw(), login.getUser_pw());
		if(login!= null && pwMatch == true) {
			session.setAttribute("user", login);
		}else {
			session.setAttribute("user", null);
			return "redirect:/user/login.do";
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
	//회원 탈퇴
	@RequestMapping(value = "remove.do", method = RequestMethod.POST)
	public String remove(UserVO user, HttpSession session, Model model) throws Exception{
		uService.userDel(user);
		session.invalidate();
		return "redirect:/index.do";
	}
	
	//비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "check_pw.do", method = RequestMethod.POST)
	public boolean checkPw(UserVO user) throws Exception{
//		int pwdChk = uService.chkPW(user);
		UserVO login = uService.userLogin(user);
		//비밀번호 암호화
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		boolean pwdChk = pwdEncoder.matches(user.getUser_pw(), login.getUser_pw());
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
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		String userPW = user.getUser_pw();
		String encodePW  = pwdEncoder.encode(userPW);
		user.setUser_pw(encodePW);
		uService.userMod(user);
		session.invalidate();
		return "redirect:/index.do";
	}
	
	//회원 관리 페이지
	@RequestMapping(value = "user_management.do", method = RequestMethod.GET)
	public String userManagement(UserCriteria cri, UserVO user, Model model, HttpServletRequest request) throws Exception{
		log.info("회원 정보 리스트");
//		if((request.getSession().getAttribute("user_auth")).equals('U')) {
//			return "redirect:/index.do";
//		}else {
			int total = uService.getTotal(cri);
			model.addAttribute("userList", uService.userInfo(cri));
			model.addAttribute("pageMaker", new UserPageDTO(cri, total));
			return "user/user_management";
//		}
		
	}
	
	//회원 권한 수정 페이지
	@RequestMapping(value="userAuth.do", method=RequestMethod.GET)
	public String userAuthForm(@RequestParam("user_id") String user_id, UserVO user,Model model) throws Exception {
		log.info("회원 권한 수정 페이지");
		model.addAttribute("userAuth", uService.userAuthForm(user));
		return "user/user_auth";
	}
	@RequestMapping(value= "userAuth.do", method = RequestMethod.POST)
	public String userAuth(UserVO user) throws Exception{
		log.info("회원 권한 수정 : " +user);
		uService.userAuth(user);
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
