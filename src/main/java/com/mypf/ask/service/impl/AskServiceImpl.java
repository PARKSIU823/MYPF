package com.mypf.ask.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.mypf.ask.service.AskService;
import com.mypf.ask.vo.AskCommVO;
import com.mypf.ask.vo.AskVO;
import com.mypf.ask.vo.Criteria;
import com.mypf.mapper.AskMapper;

import lombok.extern.log4j.Log4j;
/* 문의 게시판 서비스 구현 */
@Service
@Log4j
public class AskServiceImpl implements AskService{
	
	@Resource(name="askMapper")
	AskMapper askMapper;
	
	@Autowired
	private JavaMailSender mailSender; // root-context.xml에 설정한 bean을 자동 주입
	
	// 문의 게시판 글 작성
	@Override
	public void sendAsk(AskVO askVO) throws Exception {
		askMapper.sendAsk(askVO);
	}

	// 문의 게시판 글 목록
	@Override
	public List<AskVO> askList(Criteria cri) throws Exception {
		return askMapper.askList(cri);
	}

	// 문의 게시판 글 총 갯수
	@Override
	public int askCount() throws Exception {
		return askMapper.askCount();
	}
	
	// 문의 게시판 상세 조회 및 답변
	@Override
	public AskVO askDetail(int ask_num) throws Exception {
		return askMapper.askDetail(ask_num);
	}

	// 문의 게시판 답변 이메일 전송 
	@Override
	public void sendMail(AskCommVO askcommVO) throws Exception {
		try {
			//이메일 객체
			MimeMessage msg = mailSender.createMimeMessage();
			//수신자 설정(수신자의 이메일 주소 객체를 생성해서 수신자 이메일 주소를 담음)
			msg.addRecipient(RecipientType.TO, new InternetAddress(askcommVO.getWriter_mail()));
			/*
			 * createMimeMessage() : MimeMessage 객체를 생성시킴(이것을 이용해서 메시지를 구성한 뒤 메일 전송)
			 * addRecipient() : 메시지의 수신자 설정
			 * InternetAddress() : 이메일 주소
			 * getWriter_mail() : 수신자 이메일 주소
			*/

			//발신자(이메일 주소+이름)
			//(발신자의 이메일 주소와 이름을 담음)
			//이메일 발신자
			msg.addFrom(new InternetAddress[] {new InternetAddress
					("mypf2021@gmail.com",askcommVO.getUser_id()) });
			//이메일 제목(인코딩을 해야 한글이 깨지지 않음)
			msg.setSubject(askcommVO.getComm_title(), "utf-8");
			//이메일 본문(인코딩을 해야 한글이 깨지지 않음)
			msg.setText(askcommVO.getComm_con(),"utf-8");

			//이메일 전송
			mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 문의 게시판 답변 DB 저장
	@Override
	public void sendAnswer(AskCommVO askcommVO) throws Exception {
		askMapper.sendAnswer(askcommVO);
	}

	// 문의 게시판 답변 여부 update
	@Override
	public void updateCommYn(int ask_num) throws Exception {
		askMapper.updateCommYn(ask_num);
	}
}
