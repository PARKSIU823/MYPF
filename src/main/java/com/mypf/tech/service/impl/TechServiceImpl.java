package com.mypf.tech.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypf.mapper.TechMapper;
import com.mypf.tech.service.TechService;
import com.mypf.tech.vo.Criteria;
import com.mypf.tech.vo.TechCommVO;
import com.mypf.tech.vo.TechVO;

import lombok.extern.log4j.Log4j;

/* 기술 게시판 서비스 구현 */
@Service
@Log4j
public class TechServiceImpl implements TechService{

	@Autowired
	private TechMapper mapper;
	
	// 기술 게시판 목록 조회
	@Override
	public List<TechVO> techList(Criteria cri) throws Exception {
		return mapper.getListWithPaging(cri);
	}
	
	// 기술 게시판 전체 데이터의 개수 처리
	@Override
	public int getTotal(Criteria cri) throws Exception {
		return mapper.getTotalCount(cri);
	}
	
	// 기술 게시판 글 작성
	@Override
	public void techWrite(TechVO techVO) throws Exception {
		mapper.techWriteSelectKey(techVO);
	}

	// 기술 게시판 글 상세 조회
	@Override
	public TechVO techDetail(int tech_num) throws Exception {
		return mapper.techDetail(tech_num);
	}
	
	// 기술 게시판 글 조회수 +1 증가
	@Override
	public void updateHit(int tech_num) throws Exception {
		mapper.updateHit(tech_num);	
	}
	
	// 기술 게시판 글 수정
	@Override
	public boolean techMod(TechVO techVO) throws Exception {
		return mapper.techMod(techVO) == 1;
	}

	// 기술 게시판 글 삭제
	@Override
	public boolean techDel(int tech_num) throws Exception {
		return mapper.techDel(tech_num) == 1;
	}

	// 기술 게시판 댓글 작성
	@Override
	public int register(TechCommVO techcommVO) throws Exception {
		return mapper.insert(techcommVO);
	}

	// 기술 게시판 댓글 조회
	@Override
	public TechCommVO get(int comm_num) throws Exception {
		return mapper.read(comm_num);
	}

	// 기술 게시판 댓글 수정
	@Override
	public int modify(TechCommVO techcommVO) throws Exception {
		return mapper.update(techcommVO);
	}
	
	// 기술 게시판 댓글 삭제
	@Override
	public int remove(int comm_num) throws Exception {
		return mapper.delete(comm_num);
	}

	// 기술 게시판 댓글 목록 조회
	@Override
	public List<TechCommVO> getList(Criteria cri, int tech_num) throws Exception {
		return mapper.getListWithPagingComm(cri, tech_num);
	}
}
